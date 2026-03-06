# trilha de alarm do cloudwatch front1
resource "aws_cloudwatch_metric_alarm" "cpu_alarm_frontend" {
  alarm_name          = "cpu-high-frontend"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "CPU usage too high"

  dimensions = {
    InstanceId = aws_instance.frontend_grotrack.id
  }

  alarm_actions = [
    aws_sns_topic.grotrack_alerts.arn
  ]
}
# trilha de alarm do cloudwatch front2
resource "aws_cloudwatch_metric_alarm" "cpu_alarm_frontend2" {
  alarm_name          = "cpu-high-frontend2"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "CPU usage too high"

  dimensions = {
    InstanceId = aws_instance.frontend2_grotrack.id
  }

  alarm_actions = [
    aws_sns_topic.grotrack_alerts.arn
  ]
}
# trilha de alarm do cloudwatch back
resource "aws_cloudwatch_metric_alarm" "cpu_alarm_backend" {
  alarm_name          = "cpu-high-back"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "CPU usage too high"

  dimensions = {
    InstanceId = aws_instance.backend_grotrack.id
  }

  alarm_actions = [
    aws_sns_topic.grotrack_alerts.arn
  ]
}
# trilha de alarm do cloudwatch db
resource "aws_cloudwatch_metric_alarm" "cpu_alarm_db" {
  alarm_name          = "cpu-high-db"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "CPU usage too high"

  dimensions = {
    InstanceId = aws_instance.db_grotrack.id
  }

  alarm_actions = [
    aws_sns_topic.grotrack_alerts.arn
  ]
}
# trilha de alarm do cloudwatch api
resource "aws_cloudwatch_metric_alarm" "cpu_alarm_api" {
  alarm_name          = "cpu-high-api"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "CPU usage too high"

  dimensions = {
    InstanceId = aws_instance.api_grotrack.id
  }

  alarm_actions = [
    aws_sns_topic.grotrack_alerts.arn
  ]
}