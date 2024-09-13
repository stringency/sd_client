Map<String, dynamic> paramTxt2Imgs = {
  "文生图万能版": {
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
      "sd_model_checkpoint": "dreamshaper_8.safetensors [879db523c3]", // 指定大模型
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
  },
  "营销展会宫崎骏": {
    "prompt":
        "Anime merchandise promotion poster, featuring popular anime characters and a variety of products such as figurines, posters, toys, and apparel BREAK vibrant colors like red, blue, yellow, and purple to attract attention BREAK dynamic and energetic design, with cartoonish elements and bold text effects, emphasizing creativity and enthusiasm, highly detailed, engaging for anime fans",
    "negative_prompt":
        "text, blurry, low quality, noise, distorted, deformed, asymmetrical, sketch, doodle, cluttered background, messy, irrelevant objects, overexposed, dark, low light, monochrome, low saturation, color bleed, strange expressions, blurry face, unnatural expressions, poor composition, chaotic composition, weird angles, depressing, gloomy, negative emotions",
    "styles": [],
    "seed": -1,
    "subseed": -1,
    "subseed_strength": 0,
    "seed_resize_from_h": -1,
    "seed_resize_from_w": -1,
    "sampler_name": "DPM++ SDE",
    "scheduler": "Automatic",
    "batch_size": 1,
    "cfg_scale": 7,
    "comments": {},
    "denoising_strength": 0.7,
    "n_iter": 1,
    "steps": 30,
    "width": 768,
    "height": 1024,
    "restore_faces": false,
    "tiling": false,
    "do_not_save_samples": false,
    "do_not_save_grid": false,
    "enable_hr": false,
    "hr_negative_prompt": "",
    "hr_prompt": "",
    "hr_resize_x": 0,
    "hr_resize_y": 0,
    "hr_scale": 2,
    "hr_second_pass_steps": 0,
    "hr_upscaler": "Latent",
    "override_settings": {
      "sd_model_checkpoint": "",
      "sd_vae": "Automatic"
    }, // 用户决定
    "override_settings_restore_afterwards": true,
    "s_churn": 0,
    "s_min_uncond": 0,
    "s_noise": 1,
    "s_tmax": null,
    "s_tmin": 0,
    // "firstphase_width": 0,
    // "firstphase_height": 0,
    "force_task_id": "",
    "sampler_index": "DPM++ SDE",
    "script_name": "",
    "script_args": [],
    "send_images": true,
    "save_images": false,
    "alwayson_scripts": {
      "controlnet": {
        "args": [
          {
            "advanced_weighting": null,
            "animatediff_batch": false,
            "batch_image_files": [],
            "batch_images": "",
            "batch_keyframe_idx": null,
            "batch_mask_dir": null,
            "batch_modifiers": [],
            "ipadapter_input": null,
            "inpaint_crop_input_image": false,
            "is_ui": true,
            "loopback": false,
            "mask": null,
            "output_dir": "",
            "pixel_perfect": false,
            "processor_res": 1024,
            "pulid_mode": "Fidelity",
            "enabled": true,
            "control_mode": "Balanced",
            "effective_region_mask": null,
            "guidance_start": 0.1,
            "guidance_end": 1.0,
            "weight": 1.0,
            "hr_option": "Both",
            "input_mode": "simple",
            "low_vram": false,
            "model": "control_v11p_sd15_canny [d14c016b]",
            "module": "canny",
            "resize_mode": "Crop and Resize",
            "save_detected_map": true,
            "threshold_a": 100.0,
            "threshold_b": 200.0,
            "union_control_type": "Hard Edge",
            "image": {"image": null} // 用户决定
          }
        ]
      }
    },
    "infotext": ""
  },
  "营销展会中国龙": {
    "prompt":
        "(1 dragon: 1.5),break,chinese New Year celebration poster,traditional style,festive and joyful atmosphere, red lanterns,",
    "negative_prompt":
        "text, blurry, low quality, noise, distorted, deformed, asymmetrical, sketch, doodle, cluttered background, messy, irrelevant objects, overexposed, dark, low light, monochrome, low saturation, color bleed, strange expressions, blurry face, unnatural expressions, poor composition, chaotic composition, weird angles, depressing, gloomy, negative emotions",
    "batch_size": 1,
    "cfg_scale": 7,
    "comments": {},
    "denoising_strength": 0.7,
    "disable_extra_networks": false,
    "do_not_save_grid": false,
    "do_not_save_samples": false,
    "enable_hr": false,
    "height": 1024,
    "width": 768,
    "hr_negative_prompt": "",
    "hr_prompt": "",
    "hr_resize_x": 0,
    "hr_resize_y": 0,
    "hr_scale": 2,
    "hr_second_pass_steps": 0,
    "hr_upscaler": "Latent",
    "n_iter": 1,
    "override_settings": {},
    "override_settings_restore_afterwards": true,
    "restore_faces": false,
    "s_churn": 0,
    "s_min_uncond": 0,
    "s_noise": 1,
    "s_tmax": null,
    "s_tmin": 0,
    "sampler_name": "DPM++ SDE",
    "scheduler": "Automatic",
    "script_args": [],
    "script_name": null,
    "seed": -1,
    "seed_enable_extras": true,
    "seed_resize_from_h": -1,
    "seed_resize_from_w": -1,
    "steps": 30,
    "styles": [],
    "subseed": -1,
    "subseed_strength": 0,
    "tiling": false,
    "alwayson_scripts": {
      "controlnet": {
        "args": [
          {
            "control_mode": "Balanced",
            "effective_region_mask": null,
            "enabled": true,
            "guidance_start": 0.0,
            "guidance_end": 1.0,
            "weight": 1.0,
            "hr_option": "Both",
            "inpaint_crop_input_image": false,
            "input_mode": "simple",
            "ipadapter_input": null,
            "is_ui": true,
            "loopback": false,
            "low_vram": false,
            "mask": null,
            "model": "control_v11p_sd15_canny [d14c016b]",
            "module": "canny",
            "output_dir": "",
            "pixel_perfect": false,
            "processor_res": 1024,
            "pulid_mode": "Fidelity",
            "resize_mode": "Crop and Resize",
            "save_detected_map": true,
            "threshold_a": 100.0,
            "threshold_b": 200.0,
            "union_control_type": "Hard Edge",
            "image": {"image": null}
          }
        ]
      }
    }
  },
  "营销展会海报图": {
    "prompt":
        "DDicon,Transparent Blue,sky,cloud,scenery,outdoors,linear,line,[(((runway)))::((cityscape)):0.5],[cityscape::blue sky:0.5],humans,sun,[sunlight],[skyscraper],[cloudy sky],day,lens flare,cover,",
    "negative_prompt":
        "(depth of field:1.4),(bokeh:1.31),(blurry:1.4),(worst quality:1.4),(low quality:1.4),(monochrome:1.1),Sketch,ng deepnegative v1 75t,text,watermark,logo,banner,extra digits,cropped,jpeg artifacts,signature,username,error,sketch,duplicate,ugly,monochrome,horror,geometry,mutation,disgusting,",
    "styles": [],
    "seed": -1,
    "subseed": -1,
    "subseed_strength": 0,
    "seed_resize_from_h": -1,
    "seed_resize_from_w": -1,
    "sampler_name": "DPM++ 2M",
    "scheduler": "Karras",
    "batch_size": 1,
    "n_iter": 1,
    "steps": 40,
    "cfg_scale": 13.5,
    "width": 768,
    "height": 1024,
    "restore_faces": false,
    "tiling": false,
    "do_not_save_samples": false,
    "do_not_save_grid": false,
    "denoising_strength": 0.7,
    "override_settings": {
      "sd_model_checkpoint": "",
      "sd_vae": "Automatic"
    }, // 用户决定
    "override_settings_restore_afterwards": true,
    "enable_hr": false,
    "firstphase_width": 0,
    "firstphase_height": 0,
    "force_task_id": "",
    "sampler_index": "DPM++ SDE",
    "script_name": "",
    "script_args": [],
    "send_images": true,
    "save_images": false,
    "alwayson_scripts": {
      "controlnet": {
        "args": [
          {
            "control_mode": "Balanced",
            "enabled": true,
            "guidance_end": 1.0,
            "guidance_start": 0.0,
            "weight": 1.0,
            "hr_option": "Both",
            "inpaint_crop_input_image": false,
            "input_mode": "simple",
            "low_vram": false,
            "model": "control_v11p_sd15_canny [d14c016b]",
            "module": "canny",
            "resize_mode": "Crop and Resize",
            "threshold_a": 100.0,
            "threshold_b": 200.0,
            // "image": {"image": ""} // 用户决定
            "image": null // 用户决定
          }
        ]
      }
    },
    "infotext": ""
  },
  "营销展会中国龙": {
    "prompt":
        "(1 dragon: 1.5),break,chinese New Year celebration poster,traditional style,festive and joyful atmosphere, red lanterns,",
    "negative_prompt":
        "text, blurry, low quality, noise, distorted, deformed, asymmetrical, sketch, doodle, cluttered background, messy, irrelevant objects, overexposed, dark, low light, monochrome, low saturation, color bleed, strange expressions, blurry face, unnatural expressions, poor composition, chaotic composition, weird angles, depressing, gloomy, negative emotions",
    "batch_size": 1,
    "cfg_scale": 7,
    "comments": {},
    "denoising_strength": 0.7,
    "disable_extra_networks": false,
    "do_not_save_grid": false,
    "do_not_save_samples": false,
    "enable_hr": false,
    "height": 1024,
    "width": 768,
    "hr_negative_prompt": "",
    "hr_prompt": "",
    "hr_resize_x": 0,
    "hr_resize_y": 0,
    "hr_scale": 2,
    "hr_second_pass_steps": 0,
    "hr_upscaler": "Latent",
    "n_iter": 1,
    "override_settings": {},
    "override_settings_restore_afterwards": true,
    "restore_faces": false,
    "s_churn": 0,
    "s_min_uncond": 0,
    "s_noise": 1,
    "s_tmax": null,
    "s_tmin": 0,
    "sampler_name": "DPM++ SDE",
    "scheduler": "Automatic",
    "script_args": [],
    "script_name": null,
    "seed": -1,
    "seed_enable_extras": true,
    "seed_resize_from_h": -1,
    "seed_resize_from_w": -1,
    "steps": 30,
    "styles": [],
    "subseed": -1,
    "subseed_strength": 0,
    "tiling": false,
    "alwayson_scripts": {
      "controlnet": {
        "args": [
          {
            "control_mode": "Balanced",
            "effective_region_mask": null,
            "enabled": true,
            "guidance_start": 0.0,
            "guidance_end": 1.0,
            "weight": 1.0,
            "hr_option": "Both",
            "inpaint_crop_input_image": false,
            "input_mode": "simple",
            "ipadapter_input": null,
            "is_ui": true,
            "loopback": false,
            "low_vram": false,
            "mask": null,
            "model": "control_v11p_sd15_canny [d14c016b]",
            "module": "canny",
            "output_dir": "",
            "pixel_perfect": false,
            "processor_res": 1024,
            "pulid_mode": "Fidelity",
            "resize_mode": "Crop and Resize",
            "save_detected_map": true,
            "threshold_a": 100.0,
            "threshold_b": 200.0,
            "union_control_type": "Hard Edge",
            "image": {"image": null}
          }
        ]
      }
    }
  },
  "营销展会中国移动": {
    "prompt":
        "Minimalist cartoon style,UNI-APP business application theme,clean and simple design,clear lines,fresh and airy feel,dark blue background,high contrast  elements,distinct and well-defined features,tech-inspired icons,well-organized layout,high quality,web cover,",
    "negative_prompt":
        "text,font,low quality,cluttered,distorted,chaotic lines,dark colors,unprofessional,messy design,",
    "styles": [],
    "seed": -1,
    "subseed": -1,
    "subseed_strength": 0,
    "seed_resize_from_h": -1,
    "seed_resize_from_w": -1,
    "sampler_name": "DPM++ 2M",
    "scheduler": "Karras",
    "batch_size": 1,
    "n_iter": 1,
    "steps": 25,
    "cfg_scale": 15,
    "width": 768,
    "height": 1024,
    "restore_faces": false,
    "tiling": false,
    "do_not_save_samples": false,
    "do_not_save_grid": false,
    "denoising_strength": 0.7,
    "override_settings": {
      "sd_model_checkpoint": "",
      "sd_vae": "Automatic"
    }, // 用户决定
    "override_settings_restore_afterwards": true,
    "enable_hr": false,
    "firstphase_width": 0,
    "firstphase_height": 0,
    "force_task_id": "",
    "sampler_index": "DPM++ SDE",
    "script_name": "",
    "script_args": [],
    "send_images": true,
    "save_images": false,
    "alwayson_scripts": {
      "controlnet": {
        "args": [
          {
            "control_mode": "Balanced",
            "enabled": true,
            "guidance_end": 1.0,
            "guidance_start": 0.0,
            "weight": 1.0,
            "hr_option": "Both",
            "inpaint_crop_input_image": false,
            "input_mode": "simple",
            "low_vram": false,
            "model": "control_v11p_sd15_canny [d14c016b]",
            "module": "canny",
            "resize_mode": "Crop and Resize",
            "threshold_a": 100.0,
            "threshold_b": 200.0,
            // "image": {"image": ""} // 用户决定
            "image": null // 用户决定
          }
        ]
      }
    },
    "infotext": ""
  },
};
