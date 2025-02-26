# dobot-docker
Building a Docker image for ROS 2 driver for Dobot manipulators

```
# Build and run dobot arm
docker compose up

# Enable arm
ros2 service call /dobot_bringup_v3/srv/ClearError dobot_msgs_v3/srv/ClearError
ros2 service call /dobot_bringup_v3/srv/EnableRobot dobot_msgs_v3/srv/EnableRobot

# Example movement of joint (joint 1 - I think it is 10 degrees but not sure about units)
ros2 service call /dobot_bringup_v3/srv/RelMovJ dobot_msgs_v3/srv/RelMovJ "{offset1: 10.0}"
```

## Gripper

Launches automatically

Close gripper

```
ros2 action send_goal /robotiq_gripper_controller/gripper_cmd control_msgs/action/GripperCommand "{command: {position: 0.85, max_effort: 1.0}}"
```

Open gripper

```
ros2 action send_goal /robotiq_gripper_controller/gripper_cmd control_msgs/action/GripperCommand "{command: {position: 0.0, max_effort: 1.0}}"
```

## Known errors:
Missing `PowerOn` service. After triggering e-stop there is no way to power up arm again from terminal.