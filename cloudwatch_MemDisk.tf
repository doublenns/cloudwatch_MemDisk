#######
# AWS #
#######

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}


# Resources will be built in the default VPC


##################
# Security Group #
##################

resource "aws_security_group" "public_access" {
  name        = "public_access"
  description = "Allow SSH access from current public IP"
  tags { Name = "public_access" }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.current_public_ip}/32"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}


#######
# IAM #
#######

resource "aws_iam_user" "cloudwatch_MemDisk" {
  name = "cloudwatch_MemDisk"
}

resource "aws_iam_access_key" "cloudwatch_MemDisk" {
  user = "${aws_iam_user.cloudwatch_MemDisk.name}"
}

resource "aws_iam_user_policy" "cloudwatch_MemDisk" {
  name = "cloudwatch_MemDisk"
  user = "${aws_iam_user.cloudwatch_MemDisk.name}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "cloudwatch:PutMetricData",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:ListMetrics",
        "ec2:DescribeTags"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

}


#############
# Instances #
#############

resource "aws_instance" "cloudwatch_Salt" {
  ami           = "ami-66506c1c"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.public_access.id}"]
  key_name = "cloudwatch_MemDisk"
  tags {
    Name = "cloudwatch_Salt"
  }
}


resource "aws_instance" "cloudwatch_Ubuntu" {
  ami           = "ami-66506c1c"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.public_access.id}"]
  key_name = "cloudwatch_MemDisk"
  tags {
    Name = "cloudwatch_Ubuntu"
  }
}

resource "aws_instance" "cloudwatch_AWSLinux" {
  ami           = "ami-97785bed"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.public_access.id}"]
  key_name = "cloudwatch_MemDisk"
  tags {
    Name = "cloudwatch_AWSLinux"
  }
}

resource "aws_instance" "cloudwatch_CentOS6" {
  ami           = "ami-97785bed"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.public_access.id}"]
  key_name = "cloudwatch_MemDisk"
  tags {
    Name = "cloudwatch_CentOS6"
  }
}

resource "aws_instance" "cloudwatch_CentOS7" {
  ami           = "ami-e3fdd999"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.public_access.id}"]
  key_name = "cloudwatch_MemDisk"
  tags {
    Name = "cloudwatch_CentOS7"
  }
}

