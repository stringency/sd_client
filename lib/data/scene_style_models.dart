// 模拟场景数据
const Map<String, Map<String, dynamic>> modelInfos = {
  '文生图万能版': {
    "sd_model_checkpoint": "dreamshaper_8.safetensors [879db523c3]", // 指定大模型
    "sd_vae": "Automatic", // 指定vae 默认自动
    "lora": [""]
  },
  '营销展会宫崎骏': {
    "sd_model_checkpoint": "cheesedOutAnime_v15.safetensors [158df08cfb]",
    "sd_vae": "cheesedOutAnime_v15.safetensors",
    "lora": [",<lora:jun:0.5>,"]
  },
  '营销展会中国龙': {
    "sd_model_checkpoint": "dreamshaper_8.safetensors [879db523c3]",
    "sd_vae": "Automatic",
    "lora": [",<lora:dragon512_512Lora:1>,",",<lora:PAseerEasternDragonV3:0.3>,"]
  },
  '营销展会海报图': {
    "sd_model_checkpoint": "dreamshaper_8.safetensors [879db523c3]",
    "sd_vae": "Automatic",
    "lora": [",<lora:DDicon:0.5>,"]
  },
  '产品宣传溅水花': {
    "sd_model_checkpoint": "dreamshaper_8.safetensors [879db523c3]",
    "lora": [",<lora:20240113-1705136141854:1>,"]
  },
  '产品宣传展示台': {
    "sd_model_checkpoint": "dreamshaper_8.safetensors [879db523c3]",
    "lora": [",<lora:dianshan:1>,"]
  },
  '产品宣传金色纹': {
    "sd_model_checkpoint": "dreamshaper_8.safetensors [879db523c3]",
    "lora": [",<lora:MooMoo-Golden Cosmetic:1>,"]
  },
};
