import matplotlib.pyplot as plt
import matplotlib.image as mpimg

figure_directory = "."
numbers_to_select = [1, 3, 5, 10, 20, 30, 40, 50]
fig, axes = plt.subplots(4, 2, figsize=(20, 10))
plt.subplots_adjust(wspace=-1, hspace=0.01)
axes = axes.flatten()

for i, num in enumerate(numbers_to_select):
    figure_name = f"{figure_directory}/{num}_neurons_in_MLP.png"
    img = mpimg.imread(figure_name)
    axes[i].imshow(img)
    axes[i].axis('off')

for j in range(len(numbers_to_select), len(axes)):
    fig.delaxes(axes[j])

plt.tight_layout()
plt.savefig("selected_figures_grid.png")
plt.show()
