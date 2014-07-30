# Introducing the CronSpeak gem

    require 'cronspeak'

    CronSpeak.new('1 * * * *').to_s #=> "1st minute of every hour every day"
    CronSpeak.new('*/5 * * * *').to_s #=> "every 5th minute of every hour every day"

Note: The output is similar to the output from CronChecker.

More examples:

    CronSpeak.new('3 * * * *').to_s #=> 3rd minute of every hour every day
    CronSpeak.new('* * * */5 *').to_s #=> every minute of every hour every day of every 5th month
    CronSpeak.new('* 2 * * *').to_s #=> every minute of 2am every day
    CronSpeak.new('* * 3 * *').to_s #=> every minute of every hour the 3rd of every month
    CronSpeak.new('* 2 * 4 *').to_s #=> every minute of 2am every day of April
    CronSpeak.new('* 2 * * 5').to_s #=> every minute of 2am Fridays in every month
    CronSpeak.new('*/3 * * * *').to_s #=> every 3rd minute of every hour every day
    CronSpeak.new('1,6 0 * * *').to_s #=> 1st and 6th minutes of 12am every day
    CronSpeak.new('* 1,6 * * *').to_s #=> every minute of 1am and 6am every day
    CronSpeak.new('1 0 4,7 * *').to_s #=> 12:01am the 4th and 7th of every month
    CronSpeak.new('* * * 2,3 *').to_s #=> every minute of every hour every day of February and March
    CronSpeak.new('2-5 * * 2,3 *').to_s #=> the 2nd through 5th minutes of every hour every day of February and March
    CronSpeak.new('5 * 5-6 * *').to_s #=> 5th minute of every hour the 5th through 6th every month
    CronSpeak.new('5 * * 3-6 *').to_s #=> 5th minute of every hour every day of March through June
    CronSpeak.new('5 * * * 2,3').to_s #=> 5th minute of every hour Tuesdays and Wednesdays in every month
    CronSpeak.new('5 * * * 3-5').to_s #=> 5th minute of every hour Wednesdays through Fridays in every month

## Resources

* [jrobertson/cronspeak](https://github.com/jrobertson/cronspeak)
* [CronChecker](http://cronchecker.net/)
* [Cron](http://en.wikipedia.org/wiki/Cron#Format)

cronspeak gem
