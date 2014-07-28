# Introducing the CronSpeak gem

    require 'cronspeak'

    CronSpeak.new('1 * * * *').to_s #=> "1st minute of every hour every day"
    CronSpeak.new('*/5 * * * *').to_s #=> "every 5th minute of every hour every day"

Note: The output is similar to the output from CronChecker.

## Resources

* [jrobertson/cronspeak](https://github.com/jrobertson/cronspeak)
* [CronChecker](http://cronchecker.net/)
* [Cron](http://en.wikipedia.org/wiki/Cron#Format)

