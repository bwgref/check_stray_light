#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);
use DateTime;
use Net::Google::Calendar;
use Term::ReadKey;


my $obsid;
my %names=();
my %time_start=();
my %time_end=();
my %date_start=();
my ($username, $password)=();


my ($yr, $day, $hr, $min, $sec)=();

# If necessary, update obs log:
update_obs_log();

# Read in obs log:
read_obs_log();

# Convert timestampes to dates:
convert_to_dates();

#Sort dates:
my @datesort= sort { $date_start{$b} cmp $date_start{$a} } keys %date_start;

# Query for the password:
say "Google password";
query_pass();

my $cal = Net::Google::Calendar->new;
$cal->login($username, $password);

# Load the NuSTAR Observation calendar:
my $cal_title='NuSTAR Observations';
my $c;
for ($cal->get_calendars(owned=>1)){
    $c = $_ if ($_->title eq $cal_title);
}
$cal->set_calendar($c);


# say scalar @datesort;

my @all_evt=$cal->get_events("max-results" => 10000);
#my $nevt=$cal->get_events();
say scalar @all_evt;
for my $key (@datesort){
    # Check to see if any events have this key:
    #    say $date_start{$key};
    my $found=0;
	if (scalar @all_evt > 0){
        for my $evt (@all_evt){
            my $check = $evt->content->body;
            #            say "$check "." $key";
            if ("$check" eq "$key"){
                $found = 1;
                #                say $key;
                # say $check;
             
                say "Skipping: $key"." $found";
            }
        }
    }
    next if ($found == 1);

    
    say "Adding: ".$names{$key};

    my $event = Net::Google::Calendar::Entry->new();
    $event->content("$key");
    $event->title($names{$key});
    
    
    # Parse time into dt object:
    ($yr, $day, $hr, $min, $sec)=split ":", $time_start{$key};

    my $DT_start = DateTime->from_day_of_year(
	year => $yr,
    day_of_year => $day,
    hour      => $hr,
    minute    => $min,
    second    => $sec,
    time_zone => 'UTC',
    );
    
    ($yr, $day, $hr, $min, $sec)=split ":", $time_end{$key};
    my $DT_end = DateTime->from_day_of_year(
    year => $yr,
    day_of_year => $day,
    hour      => $hr,
    minute    => $min,
    second    => $sec,
    time_zone => 'UTC',
    );
    
    $event->when($DT_start, $DT_end );
    $cal->add_entry($event);
}



sub convert_to_dates{
    foreach my $key (keys %time_start) {
        ($yr, $day, $hr, $min, $sec)=split ":", $time_start{$key};
        my $dt = DateTime->from_day_of_year(
        year => $yr,
        day_of_year => $day,
        hour      => $hr,
        minute    => $min,
        second    => $sec,
        time_zone => 'UTC',
        );
        $date_start{$key}=$dt->date().'T'.$dt->time();
    }
}

sub read_obs_log{
    my $file = "obs_log.txt";
    open FH,$file or die "ERROR opening filed $file\n";
    for (1..20) {
        my $skip = <FH>;
    }
    my $n = 0;
    while (my $line = <FH>) {
    	chomp $line;

        my @x = split " ", $line;
        $obsid = $x[2];

        $time_start{$obsid}=$x[0];
        $time_end{$obsid}=$x[1];
        $names{$obsid}=$x[3];
        $n++;
        if ($n>50){
            last;
        }
    }
    close FH;
}

sub query_pass {
	say "Username: ";
	$username=<>;
	say "Password ";
	system('stty', '-echo');
	$password=<>;
	system('stty', 'echo');
}

sub update_obs_log {
    system "curl -u nusoc http://www.srl.caltech.edu/NuSTAR_Public/NuSTAROperationSite/Operations/observing_schedule.txt > obs_log.txt"
    
}

