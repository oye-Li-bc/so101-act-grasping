# 数据集

本项目的训练数据与模型权重托管在 **HuggingFace**（GitHub 不存放大文件）。

## 数据集

| 项 | 值 |
|------|------|
| Repo ID | `oye-Li-bc/oye_tissue_20260815_133841` |
| 内容 | 40 条抓取-放置示教轨迹 |
| 帧数 | 10,000 帧（25 FPS，1080p） |
| 特征 | 6 关节角度 + 单目 RGB 图像 |
| 任务 | 抓取纸巾团并放置到目标位置 |

### 下载

```python
from lerobot.datasets import LeRobotDataset

ds = LeRobotDataset("oye-Li-bc/oye_tissue_20260815_133841")
```

## 模型权重

| 项 | 值 |
|------|------|
| Repo ID | `oye-Li-bc/oye_tissue_act` |
| 策略 | ACT，52M 参数 |
| 训练 | 8000 步，L1=0.257，KL=0.015 |
| checkpoint | 2000 / 4000 / 6000 / 8000 |

### 加载

```python
from lerobot.policies.act import ACTPolicy

policy = ACTPolicy.from_pretrained("oye-Li-bc/oye_tissue_act")
```

## 目录结构（HuggingFace 数据集）

```
oye_tissue_20260815_133841/
├── meta/
│   ├── info.json          # 数据集元信息
│   └── episodes/          # 每条轨迹的起止帧
├── data/
│   └── chunk-000/         # 关节角度 parquet
└── videos/
    └── observation.images.front/   # 相机录像
```
