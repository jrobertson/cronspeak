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

    @to_s = if m+h =~ /^\d+$/ then
      [Time.parse(h + ':' + m)\
                     .strftime("%l:%M%P ").lstrip, days(d), months(mon)].join
    else
      [mins(m), hrs(h), days(d), months(mon)].join
    end

  end

  private

  def mins(m='*')

    return 'every minute of ' if m == '*'
      
    r = case m
    when /^\*\//
      m = m[/^\*\/(\d+)/,1]      
      "every %s minute of " % [m.to_i.ordinal]
    when /,/
      "%s minutes of " % m.split(/,/).map {|x| x.to_i.ordinal }.join(' and ')
    when /\-/
      "the %s minutes of " % m.split('-',2)\
                                 .map {|x| x.to_i.ordinal }.join(' through ')
    else
      "%s minute of " % [m.to_i.ordinal]
    end

    return r
  end

  def hrs(h='*')

    return 'every hour' if h == '*'

    @count += 2    

    return case h  
    when /^\*\//
      h = h[/^\*\/(\d+)/,1]      
      " of every %s hour" % [h.to_i.ordinal]
    when /,/
      h.split(/,/)\
        .map {|x| Time.parse(x+':00').strftime("%l%P").lstrip }.join(' and ')
    when /,/
      "%s of " % h.split(/,/).map {|x| x.to_i.ordinal }.join(' and ')
    when /\-/
      h.split('-',2).map {|x| Time.parse(x+':00').strftime("%l%P").lstrip }\
                                                            .join(' through ')
    else
      [Time.parse(h+':00').strftime("%l%P").lstrip]
    end
    
  end

  def days(d='*') 

    return " %s in " % @dow if @count >= 8
      
    return case d
    when /^\*$/ then
      ' every day'
    when/^\*\//
      d = d[/^\*\/(\d+)/,1]      
      @count += 4
      " of every %s day" % [d.to_i.ordinal] 
    when /,/
      @count += 8
      "the %s of " % d.split(/,/).map {|x| x.to_i.ordinal }.join(' and ')
    when /\-/
      @count += 8
      " the %s " % d.split('-',2).map {|x| x.to_i.ordinal }.join(' through ')
    else
      @count += 4
      " the %s" % [d.to_i.ordinal]
    end

  end

  def months(mon='*') 

    r = case mon
    when /^\*$/

      if @count < 4 then
        '' 
      else
        s = @count < 8 ? ' of ' : ''
        s + 'every month'
      end

    when /^\*\//
      mon = mon[/^\*\/(\d+)/,1]      
      @count += 16
      " of every %s month" % [mon.to_i.ordinal] 
    when /,/
      " of %s" % mon.split(/,/)\
                        .map {|x| Date::MONTHNAMES[x.to_i] }.join(' and ')  
    when /\-/
      " of %s" % mon.split('-',2).map {|x| Date::MONTHNAMES[x.to_i] }.join(' through ')
    else
      s = @count < 8 ? 'of ' : ''
      " %s%s" % [s, Date::MONTHNAMES[mon.to_i]]
    end

    @count += 16

    return r
  end

  def dow(raw_dow='*')
 
    @dow = case raw_dow
    when /^\*$/
      ''
    when /,/
      @count += 8
      raw_dow.split(/,/).map {|x| Date::DAYNAMES[x.to_i] + 's' }.join(' and ')
    when /\-/
      @count += 8
      raw_dow.split('-',2).map {|x| Date::DAYNAMES[x.to_i] + 's' }\
                                                            .join(' through ')
    else
      @count += 8
      Date::DAYNAMES[raw_dow.to_i] + 's'
    end

  end

end

if __FILE__ == $0 then
  cs = CronSpeak.new(ARGV[0])
  cs.to_s
end