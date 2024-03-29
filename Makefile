NAME = fractol

INC_DIR = 	$(shell find includes -type d)

INC_LIBX = minilibx-linux/

##List every folder where he will find source file
SRC_DIR = 	$(shell find srcs -type d)

##Folder where he will store the .o
OBJ_DIR	= obj

##Add to the vpath the folder find in SRC_DIR
vpath %.c $(foreach dir, $(SRC_DIR), $(dir):)

##List every .c found inside SRC_DIR
SRC = fractol.c basics.c Events.c Draw.c

##Transform and place every .o from SRC
OBJ = $(addprefix $(OBJ_DIR)/, $(SRC:%.c=%.o))

##Basics flags
CFLAGS =	-Wall -Wextra -Werror
#-g3 -fsanitize=address

##Create the flags to includes every .h needed by this program
IFLAGS =	$(foreach dir, $(INC_DIR), -I $(dir))

##Define the compiler to use
CC =	gcc

all: $(NAME)

$(NAME): $(OBJ)
				make -C minilibx-linux 2>/dev/null
				@echo "Compiling $(NAME) ...\c"
				$(CC) $(OBJ) $(CFLAGS) $(IFLAGS) -I $(INC_LIBX) -L $(INC_LIBX) -lmlx -lm  -L /opt/X11/lib -lXext -lX11 -o fractol  $(CFLAGS)
				@echo " DONE"

$(OBJ_DIR)/%.o : %.c
				@mkdir -p $(OBJ_DIR)
				@echo "Compiling $< ...\c"
				@$(CC) $(CFLAGS) $(IFLAGS) -I $(INC_LIBX) -o $@ -c $<
				@echo " DONE"

clean:
				@rm -rf $(OBJ_DIR)
				@echo "clean"

fclean:			clean
				@rm -f $(NAME)
				@echo "fclean"

re:				fclean all

.PHONY: all clean fclean re
