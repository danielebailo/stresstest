#!/bin/bash
urlDEV="http://irods-cnt.int.ingv.it:9090/webapi/search?page=1&resultsPerPage=25"
urlCINECA="http://epos.cineca.it/webapi/search?page=1&resultsPerPage=25"
url=$urlDEV
sleeptime_secs=.5
iterations=500

clear
echo "***** Now stressing this URL:   $url   ***** "
echo "===== Query frequency: $sleeptime_secs seconds ===="
echo "===== Iterations: $iterations ===="
echo ""

for (( i=1; i <= $iterations; i++ )); do
    start_time="$(perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)')"
    content=">>>>Output Excerpt: $(curl -s "$url")"
    echo "### Iteration $i"
    echo ${content:0:100}
    end_time="$(perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)')"
    elapsed="$(bc <<<"$end_time-$start_time")"
    echo "> Time diff is: $elapsed milliseconds"
    echo ""
    sleep sleeptime_secs
done
