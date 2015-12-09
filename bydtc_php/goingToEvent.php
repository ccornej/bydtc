<?php
 
$dbhostname = 'mysql1.cs.clemson.edu';
 
$dbusername = 'bydtc_bv08';
 
$dbpassword = 'asdf1234';
 
$conn = mysql_connect($dbhostname, $dbusername, $dbpassword);
 
if(!$conn)
{
 
  die('Could not connect: ' . mysql_error());
 
}
echo ('connected');

if (isset ($_GET["attendeeId"], $_GET["eventId"], $_GET["enrolled"]))
{
		$attendeeId = intval($_GET["attendeeId"]);
		$eventId =intval($_GET["eventId"]);
		$enrolled = intval($_GET["enrolled"]);
}
$errorCount = 0;
if(empty($attendeeId))
{
    echo('Attendee ID empty');
    $errorCount++;
}
if(empty($eventId))
{
	echo('Event ID empty');
	$errorCount++;
}
if($errorCount == 0)
{
echo ('no errors');
//echo 'MySQL Connected successfully'."<BR>";
mysql_select_db("bydtc_0bhv") or die(mysql_error());

$result = mysql_query("INSERT INTO EventAttendees (eventId, attendId)
 VALUES('$eventId', '$attendeeId')");
 
if (!$result) {
    echo 'Could not run query: ' . mysql_error();
    exit;
}
else{
	mysql_query("UPDATE Events SET enrolled='$enrolled' WHERE id='$eventId'");
}
mysql_close($conn);
}
else
{
mysql_close($conn);

}
