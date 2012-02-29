# Adapted from pdf-writer example by j-wilkins
#--
# PDF::Writer for Ruby.
#   http://rubyforge.org/projects/ruby-pdf/
#   Copyright 2003 - 2005 Austin Ziegler.
#
#   Licensed under a MIT-style licence. See LICENCE in the main distribution
#   for full licensing information.
#
# $Id: pac.rb,v 1.4.2.1 2005/08/25 03:38:05 austin Exp $
#++
require 'pacman/version'
require 'pdf/writer'

class PacMan

  attr_accessor :pdf

  GAME_DOTS = {
    150 => {circles: [{x: 250, r: 20}, 300, 350, 400, 450]},
    200 => {ellipse: 300,  circles: [350, 400,  450]},
    250 => {circles: [300,  350, 400, 450]},
    300 => {ellipse: 400, circles: [450]},
    350 => {circles: [400, 450]},
  }

  def initialize
    @pdf = PDF::Writer.new(:orientation => :landscape)
  end

  def draw_background(ghost = true)
    # fill
    pdf.fill_color    Color::RGB::Black
    pdf.rectangle(0, 0, pdf.page_width, pdf.page_height).fill
      # Wall
    pdf.fill_color    Color::RGB::Magenta
    pdf.stroke_color  Color::RGB::Cyan
    pdf.rounded_rectangle(20, 500, 750, 20, 10).close_fill_stroke
    pdf.rounded_rectangle(20, 200, 750, 20, 10).close_fill_stroke
      # Ghost
    if ghost
      pdf.fill_color    Color::RGB::Blue
      pdf.stroke_color  Color::RGB::Cyan
      pdf.move_to(500, 250)
      pdf.line_to(500, 425)
      pdf.curve_to(550, 475, 600, 475, 650, 425)
      pdf.line_to(650, 250)
      pdf.line_to(625, 275)
      pdf.line_to(600, 250)
      pdf.line_to(575, 275)
      pdf.line_to(550, 250)
      pdf.line_to(525, 275)
      pdf.line_to(500, 250).fill_stroke
      pdf.fill_color    Color::RGB::White
      pdf.rectangle(525, 375, 25, 25).fill
      pdf.rectangle(575, 375, 25, 25).fill
      pdf.fill_color    Color::RGB::Black
      pdf.rectangle(525, 375, 10, 10).fill
      pdf.rectangle(575, 375, 10, 10).fill
    end
  end

  def draw_pacman_at(x, mouth_open)
      # Body
    pdf.fill_color    Color::RGB::Yellow
    pdf.stroke_color  Color::RGB::Black
    pdf.circle_at(x, 350, 100).fill_stroke
    if mouth_open == true
      pdf.fill_color    Color::RGB::Black
      pdf.segment_at(x, 350, 100, 100, 30, -30).close_fill_stroke
    end
  end

  def draw_dots_for(step)
    unless GAME_DOTS[step].nil?
      pdf.fill_color    Color::RGB::Yellow
      GAME_DOTS[step][:circles].each do |opts|
        unless opts.is_a?(Hash)
          opts = {x: opts, r: 10}
        end
        pdf.circle_at(opts[:x], 350, opts[:r]).fill_stroke
      end
      unless GAME_DOTS[step][:ellipse].nil?
        pdf.ellipse2_at(GAME_DOTS[step][:ellipse], 350, 10, 10, 95, -95)
      end
    end
  end

  def draw_game(count = 1)
    count.times do |inc|
      pdf.start_new_page unless inc == 0
      mouth_open = true
      (150..600).step(50) do |x|
        pdf.start_new_page unless x == 150
        draw_background((x < 550))
        draw_pacman_at(x, mouth_open)
        draw_dots_for(x)
        mouth_open = !mouth_open
      end
    end
    self
  end

  def save(name = 'pacman.pdf')
    pdf.save_as(name)
  end
end
