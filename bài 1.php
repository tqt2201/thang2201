<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <center>
        <div>
            <form method="post">
                <h2>CHÀO THEO GIỜ</h2>
                <input type="Number" name="txtGio">
                <br>
                <?php
                   if (isset($_POST["txtGio"]))
                {
                   $gio = $_POST["txtGio"];
        
                   if ($gio <12 )
                   $chao = "chào buổi sáng";
                   else if ($gio <17)
                   $chao = "chào buổi chiều";
                   else 
                   $chao = "Chào buổi tối";
                   echo $chao;
                }
                ?>
                <br>
                <button type="submit">CHÀO</button>
            </form>
        </div>
    </center>
</body>

</html>