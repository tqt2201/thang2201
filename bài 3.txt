<form method="post" >
Số A:<input type ="number" name="soA" value="0"><br>
Số B:<input type ="number" name="soB" value="0"><br>
Số C:<input type ="number" name="soC" value="0"><br>
<input type="submit" value ="tinh">
</form>

<?php
$a = $_POST['soA'];
$b = $_POST['soB'];
$c = $_POST['soC'];
$x = "";
$y = "";

$y = ($b*$b) - (4*$a*$c);
if($y < 0){
    $x = 'Phương trình vô nghiệm';
}else if($y == 0){
    $x = 'Phương trình có nghiệm kép' . (-$b/2*$a);
}else{
    $x = 'Phương trình có hai nghiệm x1='. ((-$b + sqrt($y))/2*$a);
    $x .= ',x2 = ' . ((-$b - sqrt($y))/2*$a);
}

echo($x);


?>