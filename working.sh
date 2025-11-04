for f in ./test_meshes/*.obj; do
    uv run python obj_vae_infer.py \
        --input "$f" \
        --num-points 81920 \
        --mc-threshold -2.0
done