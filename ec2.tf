# Ubuntu AMI

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }
}

# FRONTEND 1 (ZB)

resource "aws_instance" "frontend_1" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_zb.id
  private_ip             = "10.0.0.50"
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  key_name               = aws_key_pair.grotrack_key.key_name

  tags = { Name = "frontend-1" }
}

# FRONTEND 2 (ZC)

resource "aws_instance" "frontend_2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_zc.id
  private_ip             = "10.0.0.66"
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  key_name               = aws_key_pair.grotrack_key.key_name

  tags = { Name = "frontend-2" }
}

# BACKEND (ZA)

resource "aws_instance" "backend" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_za.id
  private_ip             = "10.0.0.5"
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  key_name               = aws_key_pair.grotrack_key.key_name

  tags = { Name = "backend" }
}

# DB (ZA)

resource "aws_instance" "db" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_za.id
  private_ip             = "10.0.0.6"
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  key_name               = aws_key_pair.grotrack_key.key_name

  tags = { Name = "db" }
}

# TERCEIRA PRIVADA (ZA)

resource "aws_instance" "private_extra" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_za.id
  private_ip             = "10.0.0.7"
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  key_name               = aws_key_pair.grotrack_key.key_name

  tags = { Name = "private-extra" }
}