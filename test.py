import tensorflow as tf
import numpy as np
import pathlib
import cv2
import matplotlib.pyplot as plt
import matplotlib as mpl
import PIL

labels_path = tf.keras.utils.get_file(
    fname="labels.txt",
    origin="https://github.com/tensorflow/models/raw/master/official/projects/movinet/files/kinetics_600_labels.txt",
)
labels_path = pathlib.Path(labels_path)

lines = labels_path.read_text().splitlines()

KINETICS_600_LABELS = np.array([line.strip() for line in lines])

def get_top_k(probs, k=5, label_map=KINETICS_600_LABELS):
    """Outputs the top k model labels and probabilities on the given video.

    Args:
      probs: probability tensor of shape (num_frames, num_classes) that represents
        the probability of each class on each frame.
      k: the number of top predictions to select.
      label_map: a list of labels to map logit indices to label strings.

    Returns:
      a tuple of the top-k labels and probabilities.
    """
    # Sort predictions to find top_k
    top_predictions = tf.argsort(probs, axis=-1, direction="DESCENDING")[:k]
    # collect the labels of top_k predictions
    top_labels = tf.gather(label_map, top_predictions, axis=-1)
    # decode lablels
    top_labels = [label.decode("utf8") for label in top_labels.numpy()]
    # top_k probabilities of the predictions
    top_probs = tf.gather(probs, top_predictions, axis=-1).numpy()
    return tuple(zip(top_labels, top_probs))


# Create the interpreter and get the signature runner.
interpreter = tf.lite.Interpreter(
    model_path="models/lite-model_movinet_a2_stream_kinetics-600_classification_tflite_float16_2.tflite"
)

runner = interpreter.get_signature_runner()
input_details = runner.get_input_details()


lines = labels_path.read_text().splitlines()
KINETICS_600_LABELS = np.array([line.strip() for line in lines])


def quantized_scale(name, state):
    """Scales the named state tensor input for the quantized model."""
    dtype = input_details[name]["dtype"]
    scale, zero_point = input_details[name]["quantization"]
    if "frame_count" in name or dtype == np.float32 or scale == 0.0:
        return state
    return np.cast((state / scale + zero_point), dtype)


# Create the initial states, scale quantized.
init_states = {
    name: quantized_scale(name, np.zeros(x["shape"], dtype=x["dtype"]))
    for name, x in input_details.items()
    if name != "image"
}

# Insert your video clip or video frame here.
# Input to the model be of shape [1, 1, 224, 224, 3].

# To run on a video, pass in one frame at a time.
states = init_states


src = cv2.VideoCapture("/home/nickcao/The Cha Cha Slide Dance [I1gMUbEAUFw].mp4")

dst = cv2.VideoWriter("output.mp4", cv2.VideoWriter_fourcc(*'MP4V'), src.get(cv2.CAP_PROP_FPS), (1280, 720))

while True:
    ret, frame = src.read()
    if not ret:
        break
    f = frame

    frame = tf.image.resize_with_pad(frame, 224, 224)
    frame = tf.cast(frame, tf.float32) / 255.0
    frame = frame[tf.newaxis, tf.newaxis, ...]

    # Normally the input frame is normalized to [0, 1] with dtype float32, but
    # here we apply quantized scaling to fit values into the quantized dtype.
    frame = quantized_scale("image", frame)
    # Input shape: [1, 1, 224, 224, 3]
    outputs = runner(**states, image=frame)
    # `logits` will output predictions on each frame.
    logits = outputs.pop("logits")
    states = outputs

    labeled = False
    for label, p in get_top_k(logits[-1], k=1):
        if not labeled:
            f = cv2.putText(f, label, (50, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 0, 0), 2, cv2.LINE_AA)
            labeled = True
        print(f"{label:20s}: {p:.3f}")

    dst.write(f)

src.release()
dst.release()
