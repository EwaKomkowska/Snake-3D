#version 330 core
out vec4 FragColor;

 struct Material {
	//sampler2D diffuse;	//to jest nasza textura, kolor dla oœwietlenia rozproszonego
	vec3 specular;		//wp³yw œwiat³a lustrzanego
	float shininess;	//promieñ rozb³ysku
};

struct DirLight {
	vec3 direction;

	vec3 ambient;
	vec3 diffuse;
	vec3 specular;
};

struct PointLight {
	vec3 position;

	float constant;
	float linear;
	float quadratic;

	vec3 ambient;
	vec3 diffuse;
	vec3 specular;
};

#define NR_POINT_LIGHTS 1

in vec3 FragPos;
in vec2 TexCoords;
in vec3 Normal;

uniform vec3 viewPos;
uniform DirLight dirLight;
uniform PointLight pointLights[NR_POINT_LIGHTS];
uniform Material material;

uniform sampler2D Texture1;
uniform sampler2D Texture2;
uniform sampler2D Texture3;

uniform int textureChoice;
//uniform float texMix; wspolczynnik mieszania textur do FragColor = mix(texture(Texture1, TexCoord), texture(Texture2, TexCoord), texMix);

vec3 CalcDirLight(DirLight light, vec3 normal, vec3 viewDir, sampler2D diffuseTexture);
vec3 CalcPointLight(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir, sampler2D diffuseTexture);


void main()
{

	vec3 norm = normalize(Normal);
	vec3 viewDir = normalize(viewPos - FragPos);
	vec3 result;

	//tego nie ma i by³o textCoords
	if(textureChoice == 1){
		//FragColor = texture(Texture1, TexCoords);
		result = CalcDirLight(dirLight, norm, viewDir, Texture1);
		for(int i = 0; i < NR_POINT_LIGHTS; i++)
			result += CalcPointLight(pointLights[i], norm, FragPos, viewDir, Texture1);
		}
	else if (textureChoice == 2){
		//FragColor = texture(Texture2, TexCoords);
		result = CalcDirLight(dirLight, norm, viewDir, Texture2);
		for(int i = 0; i < NR_POINT_LIGHTS; i++)
			result += CalcPointLight(pointLights[i], norm, FragPos, viewDir, Texture2);
		}
	else if	(textureChoice == 3){
		//FragColor = texture(Texture3, TexCoords);
		result = CalcDirLight(dirLight, norm, viewDir, Texture3);
		for(int i = 0; i < NR_POINT_LIGHTS; i++)
			result += CalcPointLight(pointLights[i], norm, FragPos, viewDir, Texture3);
		}
	
	FragColor = vec4(result, 1.0);
}

vec3 CalcDirLight(DirLight light, vec3 normal, vec3 viewDir, sampler2D diffuseTexture) 
{
	vec3 lightDir = normalize(-light.direction);
	float diff = max(dot(normal, lightDir), 0.0);

	vec3 reflectDir = reflect(-lightDir, normal);
	float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);

	vec3 ambient = light.ambient * vec3(texture(diffuseTexture, TexCoords));
	vec3 diffuse = light.diffuse * diff * vec3(texture(diffuseTexture, TexCoords));
	vec3 specular = light.specular * spec * material.specular;

	return (ambient + diffuse + specular);
}

vec3 CalcPointLight(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir, sampler2D diffuseTexture)
{
    vec3 lightDir = normalize(light.position - fragPos);

    float diff = max(dot(normal, lightDir), 0.0);
  
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
   
    float distance = length(light.position - fragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance + light.quadratic * (distance * distance));    
   
    vec3 ambient = light.ambient * vec3(texture(diffuseTexture, TexCoords));
    vec3 diffuse = light.diffuse * diff * vec3(texture(diffuseTexture, TexCoords));
    vec3 specular = light.specular * spec * material.specular;
    ambient *= attenuation;
    diffuse *= attenuation;
    specular *= attenuation;

    return (ambient + diffuse + specular);
}