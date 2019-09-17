#ifndef FOOD_H
#define FOOD_H

#include <utility>
#include <tuple>
#include "board.h"
#include "Block.h"
#include "glm/vec3.hpp" 


class Food
{
private:
	float vertices[288] = { 
		//pozycja		 //tekstury		//normalne
	-0.5f, -0.5f, -0.5f,  0.0f, 0.0f,  0.0f, 0.0f, -1.0f,
	 0.5f, -0.5f, -0.5f,  1.0f, 0.0f,  0.0f, 0.0f, -1.0f,
	 0.5f,  0.5f, -0.5f,  1.0f, 1.0f,  0.0f, 0.0f, -1.0f,
	 0.5f,  0.5f, -0.5f,  1.0f, 1.0f,  0.0f, 0.0f, -1.0f,
	-0.5f,  0.5f, -0.5f,  0.0f, 1.0f,  0.0f, 0.0f, -1.0f,
	-0.5f, -0.5f, -0.5f,  0.0f, 0.0f,  0.0f, 0.0f, -1.0f,

	-0.5f, -0.5f,  0.5f,  0.0f, 0.0f,  0.0f, 0.0f, 1.0f,
	 0.5f, -0.5f,  0.5f,  1.0f, 0.0f,  0.0f, 0.0f, 1.0f,
	 0.5f,  0.5f,  0.5f,  1.0f, 1.0f,  0.0f, 0.0f, 1.0f,
	 0.5f,  0.5f,  0.5f,  1.0f, 1.0f,  0.0f, 0.0f, 1.0f,
	-0.5f,  0.5f,  0.5f,  0.0f, 1.0f,  0.0f, 0.0f, 1.0f,
	-0.5f, -0.5f,  0.5f,  0.0f, 0.0f,  0.0f, 0.0f, 1.0f,

	-0.5f,  0.5f,  0.5f,  1.0f, 0.0f,  -1.0f, 0.0f, 0.0f,
	-0.5f,  0.5f, -0.5f,  1.0f, 1.0f,  -1.0f, 0.0f, 0.0f,
	-0.5f, -0.5f, -0.5f,  0.0f, 1.0f,  -1.0f, 0.0f, 0.0f,
	-0.5f, -0.5f, -0.5f,  0.0f, 1.0f,  -1.0f, 0.0f, 0.0f,
	-0.5f, -0.5f,  0.5f,  0.0f, 0.0f,  -1.0f, 0.0f, 0.0f,
	-0.5f,  0.5f,  0.5f,  1.0f, 0.0f,  -1.0f, 0.0f, 0.0f,

	 0.5f,  0.5f,  0.5f,  1.0f, 0.0f,  1.0f, 0.0f, 0.0f,
	 0.5f,  0.5f, -0.5f,  1.0f, 1.0f,  1.0f, 0.0f, 0.0f,
	 0.5f, -0.5f, -0.5f,  0.0f, 1.0f,  1.0f, 0.0f, 0.0f,
	 0.5f, -0.5f, -0.5f,  0.0f, 1.0f,  1.0f, 0.0f, 0.0f,
	 0.5f, -0.5f,  0.5f,  0.0f, 0.0f,  1.0f, 0.0f, 0.0f,
	 0.5f,  0.5f,  0.5f,  1.0f, 0.0f,  1.0f, 0.0f, 0.0f,

	-0.5f, -0.5f, -0.5f,  0.0f, 1.0f,  0.0f, -1.0f, 0.0f,
	 0.5f, -0.5f, -0.5f,  1.0f, 1.0f,  0.0f, -1.0f, 0.0f,
	 0.5f, -0.5f,  0.5f,  1.0f, 0.0f,  0.0f, -1.0f, 0.0f,
	 0.5f, -0.5f,  0.5f,  1.0f, 0.0f,  0.0f, -1.0f, 0.0f,
	-0.5f, -0.5f,  0.5f,  0.0f, 0.0f,  0.0f, -1.0f, 0.0f,
	-0.5f, -0.5f, -0.5f,  0.0f, 1.0f,  0.0f, -1.0f, 0.0f,

	-0.5f,  0.5f, -0.5f,  0.0f, 1.0f,  0.0f, 1.0f, 0.0f,
	 0.5f,  0.5f, -0.5f,  1.0f, 1.0f,  0.0f, 1.0f, 0.0f,
	 0.5f,  0.5f,  0.5f,  1.0f, 0.0f,  0.0f, 1.0f, 0.0f,
	 0.5f,  0.5f,  0.5f,  1.0f, 0.0f,  0.0f, 1.0f, 0.0f,
	-0.5f,  0.5f,  0.5f,  0.0f, 0.0f,  0.0f, 1.0f, 0.0f,
	-0.5f,  0.5f, -0.5f,  0.0f, 1.0f,  0.0f, 1.0f, 0.0f
		};

	/*float vertices2[120] = {
		-0.5f, 0.0f, 0.5f,  0.0f, 0.0f,
		 0.5f, 0.0f, 0.5f,  0.0f, 0.0f,
		 0.0f, 0.5f, 0.0f,  0.0f, 0.0f,

		-0.5f, 0.0f, -0.5f,  0.0f, 0.0f,
		 0.5f, 0.0f, -0.5f,  1.0f, 0.0f,
		 0.0f, 0.5f, 0.0f,  0.25f, 1.0f,

		-0.5f, 0.0f, -0.5f,  0.0f, 0.0f,
		-0.5f, 0.0f,  0.5f,  1.0f, 0.0f,
		 0.0f, 0.5f, 0.0f,  0.25f, 1.0f,

		 0.5f, 0.0f, -0.5f,  0.0f, 0.0f,
		 0.5f, 0.0f,  0.5f,  1.0f, 0.0f,
		 0.0f, 0.5f, 0.0f,  0.25f, 1.0f,

		 -0.5f, 0.0f, 0.5f,  0.0f, 0.0f,
		 0.5f, 0.0f, 0.5f,  1.0f, 0.0f,
		 0.0f, -0.5f, 0.0f,  0.25f, 1.0f,

		-0.5f, 0.0f, -0.5f,  0.0f, 0.0f,
		 0.5f, 0.0f, -0.5f,  1.0f, 0.0f,
		 0.0f, -0.5f, 0.0f,  0.25f, 1.0f,

		-0.5f, 0.0f, -0.5f,  0.0f, 0.0f,
		-0.5f, 0.0f,  0.5f,  1.0f, 0.0f,
		 0.0f, -0.5f, 0.0f,  0.25f, 1.0f,

		 0.5f, 0.0f, -0.5f,  0.0f, 0.0f,
		 0.5f, 0.0f,  0.5f,  1.0f, 0.0f,
		 0.0f, -0.5f, 0.0f,  0.25f, 1.0f,
	};*/

	GLuint VAO, VBO;
	Block* block;
public:
	Food();
	Food(glm::ivec3 coordinates);
	~Food();
	void setCoords(glm::ivec3 coordinates);
	glm::vec3 getCoords(void) const;
	void getEaten(const Board* board, std::vector<Block*> snake_coords);
	void Draw(glm::mat4 model_matrix, glm::mat4 view_matrix, glm::mat4 projection_matrix, Shader* shaderProgram); //const
	void setBuffers(void);
};

#endif FOOD_H