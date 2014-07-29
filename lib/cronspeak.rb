#!/usr/bin/env ruby

# file: cronspeak.rb

require 'date'
require 'time'

module Ordinal
  refine Fixnum do

    def ordinal
      self.to_s + ( (10...20).include?(self) ? 'th' : 
                          %w{ th st nd rd th th th th th th }[self % 10] )
    end

  end
end

class CronSpeak
  using Ordinal

  attr_reader :to_s

  def initialize(s)

    @count = 0
    m, h, d, mon, raw_dow = s.scan(/([\d,\*-\/]+)\s*/).flatten(1)
    dow(raw_dow)
    @to_s = [mins(m), hrs(h), days(d), months(mon)].join

  end

  private

  def mins(m='*')

    r = if m == '*' then
      'every minute'
    elsif m[/^\*\//]
      m = m[/^\*\/(\d+)/,1]      
      "every %s minute" % [m.to_i.ordinal]
    else
      "%s minute" % [m.to_i.ordinal]
    end

    return r
  end

  def hrs(h='*')

    r = if h == '*' then
      ' of every hour' 
    elsif h[/^\*\//]
      h = h[/^\*\/(\d+)/,1]      
      " of every %s hour" % [h.to_i.ordinal]
    else
      " of %s%s" % [h, Time.parse(h+':00').strftime("%P")]
    end
    
    @count += 2

    return r
  end

  def days(d='*') 

    r = if @count >= 8 then
      " %s in " % @dow
    elsif d == '*' then
      ' every day'
    elsif d[/^\*\//]
      d = d[/^\*\/(\d+)/,1]      
      @count += 4
      " of every %s day" % [d.to_i.ordinal] 
    else
      @count += 4
      " the %s" % [d.to_i.ordinal]
    end

    return r
  end

  def months(mon='*') 

    r = if mon == '*' then

      if @count < 4 then
        '' 
      else
        s = @count < 8 ? ' of ' : ''
        s + 'every month'
      end

    elsif mon[/^\*\//]
      mon = mon[/^\*\/(\d+)/,1]      
      @count += 16
      " of every %s month" % [mon.to_i.ordinal] 
    else
      s = @count < 8 ? 'of ' : ''
      " %s%s" % [s, Date::MONTHNAMES[mon.to_i]]
    end

    @count += 16

    return r
  end

  def dow(raw_dow='*') 
    return '' if raw_dow == '*'
    @count += 8
    @dow = Date::DAYNAMES[raw_dow.to_i] + 's'
  end

end

if __FILE__ == $0 then
  cs = CronSpeak.new(ARGV[0])
  cs.to_s
end