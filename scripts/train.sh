#!/bin/bash
# 训练 ACT 模型（已验证：40条纸巾团数据，8000步，L1=0.257）
set -e
cd "$(dirname "$0")/.."

export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True

lerobot-train \
    --policy.type=act \
    --dataset.repo_id=oye-Li-bc/oye_tissue_20260815_133841 \
    --steps=8000 \
    --batch_size=4 \
    --output_dir=./oye_tissue_full \
    --policy.n_action_steps=50 \
    --policy.push_to_hub=false \
    --save_freq=2000
