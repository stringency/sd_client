Map<String, dynamic> baseTxt2img = {
  "prompt":
      "(masterpiece:1.2),best qualityhighres,extremely detailed CG,perfect lighting,8k wallpaper,", // 基础起手正面提示词
  "negative_prompt":
      "NSFW,(worst quality:2),(low quality:2)(normal quality:2),lowres, normal quality,((monochrome)),((grayscale)),skin spots,acnes,skin blemishes,age spot,(ugly:1.331),(duplicate:1.331),(morbid:1.21),(extra legs:1.331)(fused fingers:1.5),(too many fingers:1.5)(unclear eyes:1.331),lowers, bad hands,missing fingers, extra diqit,bad handsmissing fingers, (((extra arms and legs))),", //基础起手负面提示词
  "styles": ["photorealistic"], // 生成图像的风格列表。例如：["artistic", "realistic"]
  "seed": -1, // 随机种子
  "subseed": -1, // 子级种子
  "subseed_strength": 0.5, // 子级种子影响力度
  "seed_resize_from_h": 256, // 从指定高度调整种子。-1 表示不调整
  "seed_resize_from_w": 256, // 从指定宽度调整种子。-1 表示不调整
  "sampler_name": "DPM++ 2M", // 使用的采样器名称。例如："Euler"、"LMS"
  "scheduler": "Karras", // 调度器的名称，控制生成过程的调度策略
  "batch_size": 1, // 每次生成的张数
  "n_iter": 1, // 生成批次
  "steps": 50, // 生成步数
  "cfg_scale": 7, // 关键词相关性
  "width": 512, // 生成图像宽度
  "height": 512, // 生成图像高度
  "restore_faces": true, // 面部修复
  "tiling": false, // 平铺
  "do_not_save_samples": false, // 是否保存生成的图像样本
  "do_not_save_grid": false, // 是否保存生成的图像网格
  "eta": 0, // 噪声
  "denoising_strength": 0, // 去噪强度，控制生成图像的平滑程度
  "s_min_uncond": 0, // 最小无条件噪声比例
  "s_churn": 0, // 噪声混合比例
  "s_tmax": 0, // 最大时间步
  "s_tmin": 0, // 最小时间步
  "s_noise": 0, // 噪声量
  "override_settings": {
    "sd_model_checkpoint": "879db523c3", // 指定大模型
    "sd_vae": "Automatic", // 指定vae 默认自动
  }, // 覆盖性配置
  "override_settings_restore_afterwards": true, // 在生成图像后恢复默认设置
  "refiner_checkpoint": "", // 用于图像精细化的检查点
  "refiner_switch_at": 0, // 切换到精细化阶段的步数
  "disable_extra_networks": false, // 是否禁用额外的网络（如辅助网络）
  "firstpass_image": "", // 初次生成的图像，用于进一步的处理
  "comments": {}, // 额外的注释或元数据
  "enable_hr": false, // 是否启用高分辨率模式
  "firstphase_width": 0, // 第一阶段的图像宽度
  "firstphase_height": 0, // 第一阶段的图像高度
  "hr_scale": 2, // 高分辨率模式下的缩放比例
  "hr_upscaler": "None", // 用于高分辨率模式的上采样器名称
  "hr_second_pass_steps": 0, // 高分辨率模式下的第二次生成步骤
  "hr_resize_x": 0, // 高分辨率模式下的X方向调整
  "hr_resize_y": 0, // 高分辨率模式下的Y方向调整
  "hr_checkpoint_name": "", // 高分辨率模式下的检查点名称
  "hr_sampler_name": "Euler", // 高分辨率模式下的采样器名称
  "hr_scheduler": "", // 高分辨率模式下的调度器名称
  "hr_prompt": "", // 高分辨率模式下的文本提示词
  "hr_negative_prompt": "", // 高分辨率模式下的负面提示词
  "force_task_id": "", // 强制任务ID，用于任务管理
  "sampler_index": "Euler", // 采样方法
  "script_name": "", // 使用的脚本名称，若无特定脚本则留空或移除
  "script_args": [], // lora 模型参数配置
  "send_images": true, // 是否发送图像
  "save_images": false, // 是否在服务端保存生成的图像
  "alwayson_scripts": {}, // alwayson配置
  "infotext": "Testing API", // 额外的信息文本
  // 自定义参数
  // "multi_lingual":"yes",
};


