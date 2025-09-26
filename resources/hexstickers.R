
library(hexSticker)
library(magick)
library(ggplot2)

#documentation: https://cran.r-project.org/web/packages/hexSticker/hexSticker.pdf

###############OCS####



imgurl <- "https://opencasestudies.github.io/img/icon.png"
hex_ocs <-sticker(imgurl, package="", 
                  p_size=2, s_x=1, s_y=.99, s_width=.55,
                  h_fill="gray", h_size = 0) + #make with no border as it was messed up
  theme(plot.margin = margin(.5,0,.5,0, "cm")) + #bottom was cutoff, adding space
  geom_hexagon(size = 2, fill = NA, color = "gold") # add our own border 
# Print or save the final sticker
ggsave("resources/images/hex_images/hex_ocs.png", hex_ocs) #save the hex


#### Function to fix hex sticker so this is easier:####

fix_hex <-function(hex, border_color){
  hex_finished <- hex + theme(plot.margin = margin(.5,0,.5,0, "cm")) + 
    geom_hexagon(size = 2, fill = NA, color = border_color)
  hex_finished}

###############ITN### Double Border ###


img <- image_read(here::here("resources/images/hex_images/logos/ITN_logo.png"))
itn_inner<- sticker(subplot = img,
        package = "", # title
        p_size=2, # font size of title
        h_size = 1,
        s_x=1, s_y=.93, # position of image
        s_width=1.3, s_height = 1.3, #  size of image
        h_fill="white")
itn_inner <-fix_hex(hex = itn_inner, border_color = "#ce532f")

# Print or save the final sticker

ggsave("resources/images/hex_images/itn_hex_inner.png", itn_inner)

itn_outer <-fix_hex(hex = itn_inner, border_color = "#213b5e")

# Print or save the final sticker
ggsave("resources/images/hex_images/itn_hex_outer.png", itn_outer)

#read in as magick images
base_image <- image_read(here::here("resources/images/hex_images/itn_hex_inner.png"))
overlay_image <- image_read(here::here("resources/images/hex_images/itn_hex_outer.png"))

overlay_image<- image_resize(overlay_image, "97%") # make inner smaller
layered_image <- image_composite(base_image, overlay_image, gravity = "center") # overlay images


image_write(layered_image, path = here::here("resources/images/hex_images/hex_itn.png"), format = "png")


     
####### function to make double borders #######
make_double_border  <- function(inner_hex_path, outer_hex_path){
  base_image <- image_read(inner_hex_path)
  overlay_image <- image_read(outer_hex_path)
  overlay_image <- image_resize(overlay_image, "97%")
  layered_image <- image_composite(base_image, overlay_image, gravity = "center") # overlay images
}

test <-make_double_border(inner_hex_path = 
                     here::here("resources/images/hex_images/itn_hex_inner.png"), 
                   outer_hex_path =
                     here::here("resources/images/hex_images/itn_hex_outer.png"))




