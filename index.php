
<link href='https://fonts.googleapis.com/css?family=Poppins:300' rel='stylesheet' type='text/css'>

<style>
body {
	padding: 0 !important;
	margin: 0 !important;
    font-family: 'Poppins', sans-serif;
    width: auto !important;
    text-align: center;
    background: #eaebed;
}
.title {
    margin: 55px 0 30px 0;
    font-family: 'Poppins', sans-serif;
    text-align: center;
    letter-spacing: 2px;
    font-size: 50px;
    color: rgba(255,255,255,1);
    font-weight: 100;
}

.host {
    margin: 0 0 50px 0;
    font-family: 'Poppins', sans-serif;
    color: rgba(255,255,255,0.5);
    text-align: center;
    letter-spacing: 2px;
    font-size: 22px;
    text-transform: uppercase;
}

.container {
    padding: 50px 0;
    background-image: url(https://www.docker.com/sites/default/files/island_1.png);
    background-position: bottom left !important;
    background-color: #22b8eb;
    background-repeat: no-repeat;
    min-height: 269px;
    margin: 0 0 50px 0;
}
table {
    max-width: 800px;
    background: #fff;
    padding: 15px;
    margin: 15px auto;
}
</style>

<div class="container">
	<h1 class="title">Hello Docker.</h1>
	<h2 class="host" style=""><?php echo gethostname(); ?></h1>
</div>

<?php phpinfo(); ?>