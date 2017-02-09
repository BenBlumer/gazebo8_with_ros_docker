FROM osrf/ros:kinetic-desktop-full
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
#ADD non_ros_dependencies non_ros_dependencies
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys D2486D2DD83DB69272AFE98867170598AF249743
RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-latest.list
ENV ROS_ETC_DIR=/opt/ros/kinetic/etc/ros
ENV ROS_ROOT=/opt/ros/kinetic/share/ros
ENV ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:/root/catkin_ws/src:/opt/ros/kinetic/share:/opt/ros/kinetic/stacks
ENV ROS_MASTER_URI=http://localhost:11311
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/catkin_ws/devel/lib:/root/catkin_ws/devel/lib/x86_64-linux-gnu:/opt/ros/kinetic/lib/x86_64-linux-gnu:/opt/ros/kinetic/lib
ENV CATKIN_TEST_RESULTS_DIR=/root/catkin_ws/build/test_results
ENV CPATH=$CPATH:/root/catkin_ws/devel/include:/opt/ros/kinetic/include
ENV ROS_TEST_RESULTS_DIR=/root/catkin_ws/build/test_results
ENV PATH=$PATH:/root/catkin_ws/devel/bin:/opt/ros/kinetic/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV ROSLISP_PACKAGE_DIRECTORIES=/root/catkin_ws/devel/share/common-lisp
ENV ROS_DISTRO=kinetic
ENV PYTHONPATH=$PYTHONPATH:/root/catkin_ws/devel/lib/python2.7/dist-packages:/opt/ros/kinetic/lib/python2.7/dist-packages
ENV PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/root/catkin_ws/devel/lib/pkgconfig:/root/catkin_ws/devel/lib/x86_64-linux-gnu/pkgconfig:/opt/ros/kinetic/lib/x86_64-linux-gnu/pkgconfig:/opt/ros/kinetic/lib/pkgconfig
ENV CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:/root/catkin_ws/devel:/opt/ros/kinetic
RUN apt-get update && apt-get install -y \
        libignition-math3 
RUN apt-get install -y libsdformat5 \
        libgazebo8 \
        gazebo8 \
        libgazebo8-dev \
        ros-kinetic-ros-control \
        ros-kinetic-ros-controllers
WORKDIR /catkin_ws/src
RUN git clone https://github.com/ros-simulation/gazebo_ros_pkgs.git -b kinetic-devel
WORKDIR /catkin_ws
RUN catkin_make
RUN source devel/setup.bash
