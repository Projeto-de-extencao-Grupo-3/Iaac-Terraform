# FRONTEND 1 (ZB)

resource "aws_instance" "frontend_1" {
  ami                    = "ami-0b6c6ebed2801a5cb"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_zb.id
  private_ip             = "10.0.0.50"
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  key_name               = aws_key_pair.grotrack_key.key_name

  tags = { Name = "frontend-1" }
}

# FRONTEND 2 (ZC)

resource "aws_instance" "frontend_2" {
  ami                    = "ami-0b6c6ebed2801a5cb"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_zc.id
  private_ip             = "10.0.0.66"
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  key_name               = aws_key_pair.grotrack_key.key_name

  tags = { Name = "frontend-2" }
}

# BACKEND (ZA)

resource "aws_instance" "backend" {
  ami                    = "ami-0b6c6ebed2801a5cb"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_za.id
  private_ip             = "10.0.0.5"
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  key_name               = aws_key_pair.grotrack_key.key_name

  tags = { Name = "backend" }
}

# DB (ZA)

resource "aws_instance" "db" {
  ami                    = "ami-0b6c6ebed2801a5cb"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_za.id
  private_ip             = "10.0.0.6"
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  key_name               = aws_key_pair.grotrack_key.key_name

  tags = { Name = "db" }
}

# TERCEIRA PRIVADA (ZA)

resource "aws_instance" "private_extra" {
  ami                    = "ami-0b6c6ebed2801a5cb"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_za.id
  private_ip             = "10.0.0.7"
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  key_name               = aws_key_pair.grotrack_key.key_name

  tags = { Name = "private-extra" }
}