
# Direct3D: VAE Infer code.

> "For the latest updates and source code, check out the [official Direct3D GitHub repository](https://github.com/DreamTechAI/Direct3D)."


## 🚀 Getting Started

### Installation

```sh
git clone https://github.com/DreamTechAI/Direct3D.git

cd Direct3D

pip install -r requirements.txt

pip install -e .
```

### Usage

```python
from direct3d.pipeline import Direct3dPipeline
pipeline = Direct3dPipeline.from_pretrained("DreamTechAI/Direct3D")
pipeline.to("cuda")
mesh = pipeline(
    "assets/devil.png",
    remove_background=False, # set to True if the background of the image needs to be removed
    mc_threshold=-1.0,
    guidance_scale=4.0,
    num_inference_steps=50,
)["meshes"][0]
mesh.export("output.obj")
```

### VAE Inference for Mesh Reconstruction

You can use the Direct3D VAE directly for 3D mesh encoding and reconstruction without the diffusion model. This is useful for mesh compression, reconstruction, and understanding the VAE's encoding capabilities.

#### Single Mesh Reconstruction

```bash
python obj_vae_infer.py \
    --input path/to/your/mesh.obj \
    --num-points 81920 \
    --mc-threshold -2.0 \
    --voxel-resolution 512
```

**Arguments:**
- `--input`: Path to the input OBJ file (required)
- `--model-id`: HuggingFace repo or local path (default: "DreamTechAI/Direct3D")
- `--device`: Device to run on (default: cuda if available, else cpu)
- `--num-points`: Number of surface points to sample from input mesh (default: 81920)
- `--voxel-resolution`: Marching cubes grid resolution (default: 512)
- `--mc-threshold`: Iso-surface threshold for marching cubes (default: 0.0)

The script will:
1. Load and sample points with normals from your input mesh
2. Encode the point cloud through the VAE
3. Decode back to a mesh using marching cubes
4. Save the reconstructed mesh to `./test_output/`

#### Batch Processing Multiple Meshes

Use the provided `working.sh` script to process all OBJ files in a directory:

```bash
# Place your meshes in ./test_meshes/
bash working.sh
```

This will process all `.obj` files in the `./test_meshes/` directory and save reconstructions to `./test_output/`.

**Note:** Make sure you have the `config.yaml` file in the root directory, which defines the VAE architecture configuration.

## 🤗 Acknowledgements

Thanks to the following repos for their great work, which helps us a lot in the development of Direct3D:

- [3DShape2VecSet](https://github.com/1zb/3DShape2VecSet/tree/master)
- [Michelangelo](https://github.com/NeuralCarver/Michelangelo)
- [Objaverse](https://objaverse.allenai.org/)
- [diffusers](https://github.com/huggingface/diffusers)

## 📖 Citation

If you find our work useful, please consider citing our paper:

```bibtex
@article{direct3d,
  title={Direct3D: Scalable Image-to-3D Generation via 3D Latent Diffusion Transformer},
  author={Wu, Shuang and Lin, Youtian and Zhang, Feihu and Zeng, Yifei and Xu, Jingxi and Torr, Philip and Cao, Xun and Yao, Yao},
  journal={arXiv preprint arXiv:2405.14832},
  year={2024}
}
```

---
