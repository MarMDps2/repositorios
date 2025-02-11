import pygame
import pyautogui
import os
import time
import requests
from io import BytesIO
from PIL import Image, ImageSequence

# Función para descargar imágenes desde una URL
def load_image_from_url(url):
    response = requests.get(url)
    if response.status_code == 200:
        return Image.open(BytesIO(response.content))
    else:
        raise Exception(f"Error al descargar la imagen: {url}")

# Inicializar pygame
pygame.init()

# Configuración de la pantalla
screen_width, screen_height = pyautogui.size()
screen = pygame.display.set_mode((screen_width, screen_height), pygame.NOFRAME)
pygame.display.set_caption("Virus Inofensivo con GIF")

# Descargar el GIF y extraer frames
gif_url = "https://media.tenor.com/JHa1sk7FONkAAAAi/heavy-time-to-dance-conga-tf2.gif"
gif_image = load_image_from_url(gif_url)

gif_frames = []
for frame in ImageSequence.Iterator(gif_image):
    frame = frame.convert("RGBA")
    frame = frame.resize((100, 100))
    gif_frames.append(pygame.image.fromstring(frame.tobytes(), frame.size, frame.mode))

# Descargar la segunda imagen
image2_url = "https://steamuserimages-a.akamaihd.net/ugc/960848817034352826/9B7D70E0F98922AAE4812060AB3C60F25829388B/?imw=512&&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false"
image2_pil = load_image_from_url(image2_url)
image2_pil = image2_pil.convert("RGBA")
image2 = pygame.image.fromstring(image2_pil.tobytes(), image2_pil.size, image2_pil.mode)

# Cargar sonido
sound = pygame.mixer.Sound("sonido.wav")

# Tamaño de la imagen
image_width, image_height = gif_frames[0].get_size()

# Posición inicial de la imagen
image_x = screen_width // 2 - image_width // 2
image_y = screen_height // 2 - image_height // 2

# Velocidad de seguimiento
speed = 5

# Estado de la imagen
image_changed = False
change_time = 0

# Índice del frame actual del GIF
current_frame = 0
frame_delay = 100  # Tiempo entre frames en milisegundos
last_frame_time = pygame.time.get_ticks()

running = True
while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Obtener la posición del cursor
    cursor_x, cursor_y = pyautogui.position()

    # Mover la imagen hacia el cursor
    if cursor_x > image_x:
        image_x += speed
    elif cursor_x < image_x:
        image_x -= speed

    if cursor_y > image_y:
        image_y += speed
    elif cursor_y < image_y:
        image_y -= speed

    # Verificar colisión entre el cursor y la imagen
    if (cursor_x >= image_x and cursor_x <= image_x + image_width and
        cursor_y >= image_y and cursor_y <= image_y + image_height):
        if not image_changed:
            sound.play()
            image_changed = True
            change_time = time.time()

    # Cambiar la imagen temporalmente
    if image_changed and time.time() - change_time > 1:  # 1 segundo
        image_changed = False

    # Dibujar la imagen en la pantalla
    screen.fill((0, 0, 0))  # Limpiar pantalla

    # Actualizar el frame del GIF
    now = pygame.time.get_ticks()
    if now - last_frame_time > frame_delay:
        current_frame = (current_frame + 1) % len(gif_frames)
        last_frame_time = now

    if image_changed:
        screen.blit(image2, (image_x, image_y))
    else:
        screen.blit(gif_frames[current_frame], (image_x, image_y))

    pygame.display.flip()

    # Controlar la velocidad del bucle
    pygame.time.delay(30)

pygame.quit()
