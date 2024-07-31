CC = cc
CFLAGS = -Wall -Wextra -Werror
CFLAGS_DEBUG = -fsanitize=address -g
NAME = minishell
HEADR = ./includes/minishell.h
LIBFT = ./libft/libft.a
LIBFT_DIR = ./libft
SRCS_DIR = ./srcs
OBJS_DIR = ./objs
SRCS = ms_main.c \
       ms_prompt.c

SRCS := $(addprefix $(SRCS_DIR)/, $(SRCS))
OBJS := $(SRCS:$(SRCS_DIR)/%.c=$(OBJS_DIR)/%.o)

all: $(OBJS_DIR) $(NAME)

$(NAME): $(OBJS) $(LIBFT)
	$(CC) $(CFLAGS) $(OBJS) $(LIBFT) -o $(NAME)
	@echo "MINISHELL is ready!"

$(LIBFT):
	$(MAKE) -C $(LIBFT_DIR)

$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.c $(HEADR) | $(OBJS_DIR)
	$(CC) $(CFLAGS) -I./includes -c $< -o $@

$(OBJS_DIR):
	mkdir -p $(OBJS_DIR)

clean:
	$(MAKE) clean -C $(LIBFT_DIR)
	rm -rf $(OBJS_DIR)
	@echo "Cleaning..."

fclean: clean
	$(MAKE) fclean -C $(LIBFT_DIR)
	rm -f $(NAME)
	@echo "Full cleaning..."

re: fclean all

.PHONY: all clean fclean re