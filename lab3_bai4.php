<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="textcss" href="style1.css">
	<title>Đồng hồ bài 5</title>
	<style>
		#time{
			background: rgb(157, 182, 49);
		    padding: 30px;
		    color: #dcadad;
		    font-size: 80px;
		    font-weight: bold;
		    text-align: center;
		    width: 500px;
		    margin: 30px auto;
		    border-radius: 15px;
		    font-family: Verdana;
}
body{
	background-image: url('https://anhcuoiviet.vn/wp-content/uploads/2022/11/background-dep-0.jpg');
    background-size: cover;
    background-position-y: -80px;
    font-size: 20px;
	text-align: center;
	border: 1px solid grey;
    border-radius: 10px;
}
	
.dh
{

    text-align: center;
	color:aqua;
    
}
h2{
    color:yellowgreen;
    font-family: sans-serif;
    text-align: center;
}
input{
    width: 200px;
    height: 20px;
    margin-bottom: 10px;
    border-radius: 5px;
    border: 1px solid grey;
    padding-left: 20px;
;
}
button{
    width: 200px;
    height: 30px;
    margin-bottom: 10px;
    border-radius: 5px;
    border: 10px;
    background-color:yellowgreen;  
	 color: white;
}
button:hover{
    font-size: 20px;
    background-color: black;
    color:red
}
</style>	
		
</head>
<body>
	<h2>Tìm Hiểu Kỹ Thuật DOM trong JAVASCRIPT</h2>
	<div class="dh">
		Giờ <input type="text" name="txtGio"><br>
		Phút <input type="text" name="txtphut"><br>
		Giây <input type="text" name="txtgiay"><br>
		kích thước chữ <input type=""><br>
		Loại đồng hồ <input type="radio" checked="checked" name="dh" value="thuan"/>Thuận
		<input type="radio" name="dh" value="Nguoc"/>Ngược<br>
		<?php
echo strrev("dongho");
?>
  
		Giờ hệ thống <input type="checkbox" name="" value="Hiển thị"/>Hiển Thị<br>
	<button> play </button>
	<button> Stop </button>
	<button> xóa </button>
		<div id="time"></div>
	<script>
		function dongho(){
			var today = new Date();
			var gio = today.getHours();
			var phut = today.getMinutes();
			var giay = today.getSeconds();

			if(gio<10){
				gio = "0" + gio;
			}
			if(phut<10){
				phut = "0" + phut;
			}
			if(giay<10){
				giay = "0" + giay;
			}
			document.getElementById("time").innerHTML = gio + ":" + phut + ":" + giay;
			setTimeout("dongho()",1000);
		}
		dongho();
	</script>
	</div>
</body>
</html>