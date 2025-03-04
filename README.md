# dobot-docker
Building a Docker image for ROS 2 driver for Dobot manipulators

## Run

### Integration with Husarion UGV

Firstly release Husarion UGV E-Stop.

```bash
ros2 service call /panther/hardware/e_stop_release std_srvs/srv/Trigger
```

Then enable aux power for the manipulator.

```bash
ros2 service call /panther/hardware/aux_power_enable std_srvs/srv/SetBool "data: true"
```

### Run Dobot

Build and run dobot arm with gripper:

>[!NOTE]
> When running with Husarion UGV platform, make sure that software E-stop is released before starting Dobot arm software.

```bash
docker compose up
```

### Arm configuration


Enable arm:
```bash
ros2 service call /dobot_bringup_v3/srv/ClearError dobot_msgs_v3/srv/ClearError
ros2 service call /dobot_bringup_v3/srv/EnableRobot dobot_msgs_v3/srv/EnableRobot
```

Example movement of joint (joint 1 - I think it is 10 degrees but not sure about units):

```bash
ros2 service call /dobot_bringup_v3/srv/RelMovJ dobot_msgs_v3/srv/RelMovJ "{offset1: 10.0}"
```

Move to position at your own risk, I tried with copied position from `GetPose` and arm decided to attack itself xD. Movement completely unpredictable.

Other usefull services for movement:
```
/dobot_bringup_v3/srv/MovJ
/dobot_bringup_v3/srv/MovL
/dobot_bringup_v3/srv/RelMovJ
/dobot_bringup_v3/srv/RelMovL
```

### Gripper

Launches automatically

Close gripper:

```bash
ros2 action send_goal /robotiq_gripper_controller/gripper_cmd control_msgs/action/GripperCommand "{command: {position: 0.85, max_effort: 1.0}}"
```

Open gripper:

```bash
ros2 action send_goal /robotiq_gripper_controller/gripper_cmd control_msgs/action/GripperCommand "{command: {position: 0.0, max_effort: 1.0}}"
```

### Known errors:

Missing `PowerOn` service for arm. After triggering e-stop there is no way to power up arm again from terminal.

ClearError->EnableRobot if at anytime arm turns green. ClearErrors only wont help.
