#!/bin/bash
# 真机部署 ACT 模型（已验证：稳定抓取-放置）
# 注意：n_action_steps 必须与训练一致（50）
set -e
cd "$(dirname "$0")/.."

export PYTHONPATH=""

lerobot-rollout \
    --policy.type=act \
    --policy.pretrained_path=./oye_tissue_full/checkpoints/008000/pretrained_model \
    --policy.input_features="{ observation.state: {type: STATE, shape: [6]}, observation.images.front: {type: VISUAL, shape: [3, 1080, 1920]} }" \
    --policy.output_features="{ action: {type: ACTION, shape: [6]} }" \
    --policy.n_action_steps=50 \
    --robot.type=so101_follower \
    --robot.id=oye_follower_arm \
    --robot.port=/dev/ttyACM0 \
    --robot.cameras="{ front: {type: opencv, index_or_path: /dev/video2, width: 1920, height: 1080, fps: 25, fourcc: \"MJPG\"}}" \
    --display_data=true
