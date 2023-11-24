deepspeed --num_nodes=1 --num_gpus=2 \
    testcode003.py  \
    --deepspeed "./config/default_offlload_zero2.json" \
    --model_name_or_path my_model \
    --output_dir hhh


