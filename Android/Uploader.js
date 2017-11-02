var http = require('http');
var formidable = require('formidable');
var fs = require('fs');
var os = require('os');

var interfaces = os.networkInterfaces();

http.createServer(function (req, res) {
  if (req.url == '/fileupload') {
    var form = new formidable.IncomingForm();
    form.parse(req, function (err, fields, files) {
      var oldpath = files.filetoupload.path;
      var newpath = 'Files/' + files.filetoupload.name;
      fs.rename(oldpath, newpath, function (err) {
        if (err) throw err;
        res.write('<div style="color: #4F8A10;background-color: #DFF2BF;">File successfully uploaded!</div>');
        res.end();
      });
 });
  } else {
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.write('<form action="fileupload" style="background-color: #008ae6;color: white;" method="post" enctype="multipart/form-data">');
    res.write('<input type="file" name="filetoupload"><br>');
    res.write('<input style="margin: 5% 5% ; border: none; background-color: #4CAF50;border: none;color: white;text-decoration: none;margin: 5% 50%;cursor: pointer;" type="submit">');
    res.write('</form>');
	
    return res.end();
  }
}


).listen(3000);
console.log("Upload engine is up please visit the link below:")
for (var k in interfaces) {
    for (var k2 in interfaces[k]) {
        var address = interfaces[k][k2];
        if (address.family === 'IPv4' && !address.internal) {
            console.log("http://"+address.address+":3000");
        }
    }
}

