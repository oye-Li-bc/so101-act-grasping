#!/bin/bash
# 录制示教数据（主臂示教 + 从臂跟随）
set -e
cd "$(dirname "$0")/.."

lerobot-record \
    --dataset.repo_id=oye-Li-bc/oye_tissue \
    --dataset.num_episodes=40 \
    --dataset.episode_time_s=20 \
    --dataset.reset_time_s=5 \
    --dataset.fps=25 \
    --teleop.type=so101_leader \
    --teleop.port=/dev/ttyACM1 \
    --teleop.id=oye_leader_arm \
    --robot.type=so101_follower \
    --robot.id=oye_follower_arm \
    --robot.port=/dev/ttyACM0 \
    --robot.cameras="{ front: {type: opencv, index_or_path: /dev/video2, width: 1920, height: 1080, fps: 25, fourcc: \"MJPG\"}}" \
    --display_data=true
