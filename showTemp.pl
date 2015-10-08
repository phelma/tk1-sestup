#!/usr/bin/perl -w
# By "peba@inode.at"

use Tk;
$main=MainWindow->new;
$main->resizable (0,0);
$temp0="--";
$temp1="--";
$temp2="--";
$temp3="--";
$temp4="--";
$temp5="--";

$myframe=$main->Frame ();
$myframe->Label (-text => 'CPU')->pack ();
$temp_label0=$myframe->Label (-text => "$temp0")->pack ();
$myframe->Label (-text => 'GPU')->pack ();
$temp_label1=$myframe->Label (-text => "$temp1")->pack ();
$myframe->Label (-text => 'MEM')->pack ();
$temp_label2=$myframe->Label (-text => "$temp2")->pack ();
$myframe->Label (-text => 'PLL')->pack ();
$temp_label3=$myframe->Label (-text => "$temp3")->pack ();
$myframe->Label (-text => 'Tboard_tegra')->pack ();
$temp_label4=$myframe->Label (-text => "$temp4")->pack ();
$myframe->Label (-text => 'Tdiode_tegra')->pack ();
$temp_label5=$myframe->Label (-text => "$temp5")->pack ();
$myframe->pack();

$main->repeat(1000,\&update_temp_label);
MainLoop;

sub update_temp_label {
    $temp0=`cat /sys/devices/virtual/thermal/thermal_zone0/temp`;
    $temp_label0->configure('-text' => $temp0);
    $temp1=`cat /sys/devices/virtual/thermal/thermal_zone1/temp`;
    $temp_label1->configure('-text' => $temp1);
    $temp2=`cat /sys/devices/virtual/thermal/thermal_zone2/temp`;
    $temp_label2->configure('-text' => $temp2);
    $temp3=`cat /sys/devices/virtual/thermal/thermal_zone3/temp`;
    $temp_label3->configure('-text' => $temp3);
    $temp4=`cat /sys/devices/virtual/thermal/thermal_zone4/temp`;
    $temp_label4->configure('-text' => $temp4);
    $temp5=`cat /sys/devices/virtual/thermal/thermal_zone5/temp`;
    $temp_label5->configure('-text' => $temp5);
}
