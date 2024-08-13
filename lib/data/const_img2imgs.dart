Map<String, dynamic> baseImg2Imgs = {
  "prompt": "",  // 用户决定
  "negative_prompt":
      "NSFW,(worst quality:2),(low quality:2)(normal quality:2),lowres,normal quality,((monochrome)),((grayscale)),skin spots,acnes,skin blemishes,age spot,(ugly:1.331),(duplicate:1.331),(morbid:1.21),(extra legs:1.331)(fused fingers:1.5),(too many fingers:1.5)(unclear eyes:1.331),lowers,bad hands,missing fingers,extra diqit,bad handsmissing fingers,(((extra arms and legs))),",
  "styles": [],
  "seed": -1,
  "subseed": -1,
  "subseed_strength": 0,
  // "seed_enable_extras": true,
  "seed_resize_from_h": -1,
  "seed_resize_from_w": -1,
  "sampler_name": "DPM++ 2M",
  "scheduler": "Karras",
  "batch_size": 1,
  "n_iter": 1,
  "steps": 30,
  "cfg_scale": 7,
  "width": 512,
  "height": 768,
  "restore_faces": false,
  "tiling": false,
  "do_not_save_samples": false,
  "do_not_save_grid": false,
  // "eta": 0,
  "denoising_strength": 0.75,
  // "s_min_uncond": 0,
  // "s_churn": 0,
  // "s_tmax": null,
  // "s_tmin": 0,
  // "s_noise": 1,
  "override_settings": {
    "sd_model_checkpoint": "", // 用户决定
    "sd_vae": "Automatic"
  },
  "override_settings_restore_afterwards": true,
  // "refiner_checkpoint": "",
  // "refiner_switch_at": 0,
  // "disable_extra_networks": false,
  // "firstpass_image": "",
  // "comments": {},
  "init_images": [],  // 用户决定
  "resize_mode": 0,
  "image_cfg_scale": 1.75,
  // "mask_blur_x": 4,
  // "mask_blur_y": 4,
  // "mask_blur": 4,
  // "mask_round": true,
  // "inpainting_fill": 1,
  // "inpaint_full_res": 0,
  // "inpaint_full_res_padding": 32,
  // "inpainting_mask_invert": 1,
  // "initial_noise_multiplier": 1,
  // "latent_mask": "",
  // "force_task_id": "",
  "sampler_index": "DPM++ 2M",
  // "include_init_images": false,
  "script_name": null,
  "script_args": [],
  "send_images": true,
  "save_images": false,
  "alwayson_scripts": {
    "controlnet": {
      "args": [
        {
          // "batch_images": "",
          "control_mode": "Balanced",
          "enabled": true,
          "guidance_start": 0,
          "guidance_end": 1,
          "weight": 1,
          // "input_mode": "simple",
          // "is_ui": true,
          // "loopback": false,
          "low_vram": false,
          "pixel_perfect": true,
          "model": "control_v11p_sd15_canny [d14c016b]",
          "module": "canny",
          // "processor_res": 512,
          // "resize_mode": "Crop and Resize",
          // "threshold_a": 100,
          // "threshold_b": 200,
          // "image": {
          //   "image": "",
          //   "mask": ""
          // }  // 用户决定
        }
      ]
    }
  },
  "infotext": ""
};

Map<String, dynamic> img21 = {
  "prompt": "", // 用户传入
  "negative_prompt":
      "NSFW,(worst quality:2),(low quality:2)(normal quality:2),lowres, normal quality,((monochrome)),((grayscale)),skin spots,acnes,skin blemishes,age spot,(ugly:1.331),(duplicate:1.331),(morbid:1.21),(extra legs:1.331)(fused fingers:1.5),(too many fingers:1.5)(unclear eyes:1.331),lowers, bad hands,missing fingers, extra diqit,bad handsmissing fingers, (((extra arms and legs))),",
  "init_images": [], // 用户传入
  "alwayson_scripts": {
    "API payload": {"args": []},
    "Comments": {"args": []},
    "ControlNet": {
      "args": [
        {
          "batch_images": "",
          "control_mode": "Balanced",
          "enabled": true,
          "guidance_end": 1,
          "guidance_start": 0,
          "image": {
            "image": "", // 用户传入
            "mask": "" // 用户传入
          },
          "input_mode": "simple",
          "is_ui": true,
          "loopback": false,
          "low_vram": false,
          "model": "control_v11p_sd15_canny [d14c016b]",
          "module": "canny",
          "output_dir": "",
          "pixel_perfect": true,
          "processor_res": 512,
          "resize_mode": "Crop and Resize",
          "threshold_a": 100,
          "threshold_b": 200,
          "weight": 1
        }
      ]
    },
    "Extra options": {"args": []},
    "Hypertile": {"args": []},
    "Refiner": {
      "args": [false, "", 0.8]
    },
    "Sampler": {
      "args": [30, "DPM++ 2M", "Automatic"]
    },
    "Seed": {
      "args": [-1, false, -1, 0, 0, 0]
    },
    "Soft Inpainting": {
      "args": [false, 1, 0.5, 4, 0, 0.5, 2]
    }
  },
  "batch_size": 1,
  "cfg_scale": 7,
  "comments": {},
  "denoising_strength": 0.75,
  "disable_extra_networks": false,
  "do_not_save_grid": false,
  "do_not_save_samples": false,
  "height": 768,
  "image_cfg_scale": 1.5,
  "initial_noise_multiplier": 1,
  "inpaint_full_res": 0,
  "inpaint_full_res_padding": 32,
  "inpainting_fill": 1,
  "inpainting_mask_invert": 1,
  "mask_blur": 4,
  "mask_blur_x": 4,
  "mask_blur_y": 4,
  "mask_round": true,
  "n_iter": 1,
  "override_settings": {
    "sd_model_checkpoint": "", // 用户指定大模型
    "sd_vae": "Automatic"
  },
  "override_settings_restore_afterwards": true,
  "resize_mode": 0,
  "restore_faces": false,
  "s_churn": 0,
  "s_min_uncond": 0,
  "s_noise": 1,
  "s_tmax": null,
  "s_tmin": 0,
  "sampler_name": "DPM++ 2M",
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
  "width": 512
};
