module Hypembot; end
require 'rubygems'
require 'hypembot/version'
require 'directory_watcher'
require 'eventmachine'
require 'growl'
require 'mp3info'
require 'fileutils'

class Hypembot::Bot
  def initialize(opts)
    @source = opts[:source] || "#{ENV['HOME']}/Library/Caches/Google/Chrome/Default/Cache/"
    @dir = opts[:directory] || "#{ENV["HOME"]}/Music"
    @min_bitrate = opts[:bitrate] || 125
    @min_length = opts[:length] || 60

    @dw = DirectoryWatcher.new(@source,
                               :scanner => :em,
                               :pre_load => true,
                               :glob => 'f_*',
                               :stable => 18,
                               :interval => 10)
  end

  def start
    setup
    # make sure to set ulimit -n 4096 or something similarily high
    EM.kqueue
    @dw.start

    loop { sleep 1000 }
  end

  private

  def setup
    @dw.add_observer do |*args|
      args.each do |event|
        verify_mp3(event.path) if event.type == :stable
      end
    end
  end

  def verify_mp3(file)
    Mp3Info.open(file) do |mp3|
      if mp3.length >= @min_length and mp3.bitrate >= @min_bitrate
        process(file, mp3)
      end
    end
  rescue
    nil
  end

  def process(file, mp3)
    info = Hash.new("")
    if mp3.tag
      info[:title] = clean(mp3.tag.title).empty? ? "Untitled" : clean(mp3.tag.title)
      info[:artist] = clean(mp3.tag.artist).empty? ? "Unknown Artist" : clean(mp3.tag.artist)
      info[:album] = clean(mp3.tag.album)
    end
    info[:length] = format_time(mp3.length)
    info[:bitrate] = "#{mp3.bitrate} kbps" + (mp3.vbr ? "" : " (VBR)")

    growl(info) if Growl.installed?
    FileUtils.cp(file, filename(info))
  end

  def growl(info)
    message = "#{info[:artist]}"
    message << "- #{info[:album]}" unless info[:album].empty?
    message << "\n(#{info[:length]}) - #{info[:bitrate]}"

    Growl.notify do |n|
      n.title = info[:title]
      n.message = message
    end
  end

  def clean(tag)
    tag ? tag.strip : ""
  end

  def format_time(s)
    mins = s.to_i / 60
    secs = s.to_i % 60
    secs < 10 ? "#{mins}:0#{secs}" : "#{mins}:#{secs}"
  end

  def filename(info)
    title = info[:title].split.join("_")
    artist = info[:artist].split.join("_")
    name = "#{title}-#{artist}"
    name << "-#{Time.now.to_i}" if title == "Untitled" and artist == "Unknown_Artist"
    File.expand_path("#{name}.mp3", @dir)
  end
end
