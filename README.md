
# Direct3D: VAE Infer code.

> "For the latest updates and source code, check out the [official Direct3D GitHub repository](https://github.com/DreamTechAI/Direct3D)."

I used CUDA 12.1.1

## 🚀 Getting Started

### Installation

```sh
git clone https://github.com/DreamTechAI/Direct3D.git

cd Direct3D

uv sync

uv shell
```

### VAE Inference for Mesh Reconstruction

You can use the Direct3D VAE directly for 3D mesh encoding and reconstruction without the diffusion model. This is useful for mesh compression, reconstruction, and understanding the VAE's encoding capabilities.

#### Single Mesh Reconstruction

```bash
uv run obj_vae_infer.py \
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

#### Processing Multiple Meshes

Use the provided `working.sh` script to process all OBJ files in a directory:

```bash
# Place your meshes in ./test_meshes/
bash working.sh
```

This will process all `.obj` files in the `./test_meshes/` directory and save reconstructions to `./test_output/`.

**Note:** Make sure you have the `config.yaml` file in the root directory, which defines the VAE architecture configuration.

## 📖 Citation

```bibtex
@article{direct3d,
  title={Direct3D: Scalable Image-to-3D Generation via 3D Latent Diffusion Transformer},
  author={Wu, Shuang and Lin, Youtian and Zhang, Feihu and Zeng, Yifei and Xu, Jingxi and Torr, Philip and Cao, Xun and Yao, Yao},
  journal={arXiv preprint arXiv:2405.14832},
  year={2024}
}
```

---
