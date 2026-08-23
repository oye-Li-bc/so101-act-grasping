#!/usr/bin/env python3
"""分析数据集质量：夹爪张合幅度、关键动作占比、帧数统计

用法：
    python analyze_dataset.py oye-Li-bc/oye_tissue_20260815_133841
"""
import sys
import glob
import numpy as np
import pandas as pd
from lerobot.datasets import LeRobotDataset


def main(repo_id: str):
    ds = LeRobotDataset(repo_id)
    print(f"数据集: {repo_id}")
    print(f"  Episodes: {ds.num_episodes}")
    print(f"  Frames:   {ds.num_frames}")
    print(f"  FPS:      {ds.fps}")

    # 读所有 parquet（ds.root 已含完整 repo 路径）
    files = glob.glob(f"{ds.root}/data/chunk-*/file-*.parquet")
    if not files:
        raise FileNotFoundError(f"在 {ds.root}/data/ 下未找到 parquet 文件")
    df = pd.concat([pd.read_parquet(f) for f in files], ignore_index=True)
    action = np.stack(df["action"].values)

    print("\n=== 各关节变化幅度 ===")
    names = ["shoulder_pan", "shoulder_lift", "elbow_flex", "wrist_flex", "wrist_roll", "gripper"]
    for i, name in enumerate(names):
        col = action[:, i]
        print(f"  {name:15}: 幅度={col.max()-col.min():7.1f}°  (min={col.min():.1f}, max={col.max():.1f})")

    # 夹爪张开/闭合占比
    gripper = action[:, 5]
    open_ratio = (gripper > 40).mean() * 100
    close_ratio = (gripper < 10).mean() * 100
    print(f"\n=== 夹爪状态占比 ===")
    print(f"  张开(>40°): {open_ratio:.1f}%")
    print(f"  闭合(<10°): {close_ratio:.1f}%")
    print(f"\n⚠️ 若张开占比 <15%，模型可能学不会夹取动作（数据不平衡）")


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "oye-Li-bc/oye_tissue_20260815_133841")
