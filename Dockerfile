ARG ROS_DISTRO=humble

FROM husarnet/ros:${ROS_DISTRO}-ros-core

STOPSIGNAL SIGINT

WORKDIR /ros2_ws

RUN apt-get update && apt-get install -y \
        git \
        build-essential \
        python3-colcon-common-extensions \
        python3-rosdep \
        python3-vcstool \
        python3-colcon-common-extensions \
        ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
        ros-${ROS_DISTRO}-joint-state-broadcaster \
        ros-${ROS_DISTRO}-joint-trajectory-controller

RUN git clone https://github.com/Dobot-Arm/DOBOT_6Axis_ROS2_V3.git src/dobot_ros

RUN apt-get update && \
    rosdep init && \
    rosdep update --rosdistro $ROS_DISTRO && \
    rosdep install --from-paths src -y -i -r --skip-keys "ros-humble-warehouse-ros-mongo"; exit 0

RUN source /opt/ros/$ROS_DISTRO/setup.sh && \
    colcon build --symlink-install

# RUN apt-get update && apt-get install -y ros-${ROS_DISTRO}-robotiq-controllers