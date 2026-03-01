resource "aws_key_pair" "grotrack_key" {
  key_name   = "mysshkeyso"
  public_key = file("mysshkeyso.pem")
}