resource "aws_lb" "elb1" {
  name               = "${var.prefix}-${var.env}-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.elbSgId]
  subnets            = var.elbSubnetIds
  tags               = merge(var.defaultTags, { Name = "${var.prefix}-${var.env}-elb" })
}

resource "aws_lb_target_group" "elbTargetGroup" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpcId
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
  tags = merge(var.defaultTags, { Name = "${var.prefix}-${var.env}-TargetGroup" })
}

resource "aws_lb_target_group_attachment" "tgtGroupAttatchment" {
  count            = length(var.elbInstanceIds)
  target_group_arn = aws_lb_target_group.elbTargetGroup.arn
  target_id        = element(var.elbInstanceIds, count.index)
  port             = 80
}

resource "aws_lb_listener" "elbListener" {
  load_balancer_arn = aws_lb.elb1.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.elbTargetGroup.arn
  }
}