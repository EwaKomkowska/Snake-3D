#version 330 core
out vec4 FragColor;

 struct Material {
	//sampler2D diffuse;	//to jest nasza textura, kolor dla oœwietlenia rozproszonego
	vec3 lustrzane;			//wp³yw œwiat³a lustrzanego
	float rozblysk;			//promieñ rozb³ysku
};

struct DirLight {
	vec3 direction;
	vec3 otoczenie;
	vec3 rozproszone;
	vec3 lustrzane;		//oœwietlenie zwierciadlane
};

struct PointLight {
	vec3 pozycja;
	vec3 otoczenie;
	vec3 rozproszone;
	vec3 lustrzane;
	float constant;
	float linear;
	float quadratic;
};

in vec3 FragPos;
in vec2 TexCoord;
in vec3 Normal;

uniform vec3 viewPos;
uniform DirLight dirLight;
uniform PointLight pointLights;					//ile ma byc swiatel, jesli wiecej to tablica
uniform Material material;

uniform sampler2D Texture1;
uniform sampler2D Texture2;
uniform sampler2D Texture3;

uniform int textureChoice;
//uniform float texMix; wspolczynnik mieszania textur do FragColor = mix(texture(Texture1, TexCoord), texture(Texture2, TexCoord), texMix);

vec3 swiatloKierunkowe(DirLight light, vec3 normal, vec3 viewDir, sampler2D diffuseTexture);
vec3 swiatloPunktowe(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir, sampler2D diffuseTexture);


void main()
{

	vec3 norm = normalize(Normal);
	vec3 viewDir = normalize(viewPos - FragPos);
	vec3 result;

	//tego nie ma i by³o textCoords
	if(textureChoice == 1){
		result = swiatloKierunkowe(dirLight, norm, viewDir, Texture1);
		result += swiatloPunktowe(pointLights, norm, FragPos, viewDir, Texture1);
		}
	else if (textureChoice == 2){
		result = swiatloKierunkowe(dirLight, norm, viewDir, Texture2);
		result += swiatloPunktowe(pointLights, norm, FragPos, viewDir, Texture2);
		}
	else if	(textureChoice == 3){
		result = swiatloKierunkowe(dirLight, norm, viewDir, Texture3);
		result += swiatloPunktowe(pointLights, norm, FragPos, viewDir, Texture3);
		}
	
	FragColor = vec4(result, 1.0);
}

vec3 swiatloKierunkowe(DirLight light, vec3 normal, vec3 viewDir, sampler2D diffuseTexture) 
{
	//rozproszone - wspolczynnik
	vec3 lightDir = normalize(-light.direction);
	float diff = max(dot(normal, lightDir), 0.0);

	//zwierciadlane - wspolczynnik
	vec3 reflectDir = reflect(-lightDir, normal);
	float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.rozblysk);

	//koncowe wartosci
	vec3 ambient = light.otoczenie * vec3(texture(diffuseTexture, TexCoord));
	vec3 diffuse = light.rozproszone * diff * vec3(texture(diffuseTexture, TexCoord));
	vec3 specular = light.lustrzane * spec * material.lustrzane;

	return (ambient + diffuse + specular);
}

vec3 swiatloPunktowe(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir, sampler2D diffuseTexture)
{
    vec3 lightDir = normalize(light.pozycja - fragPos);
	
	//rozproszone - wspolczynnik
    float diff = max(dot(normal, lightDir), 0.0);
  
	//zwierciadlane - wspolczynnik	
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.rozblysk);
   
	//wygaszanie swiatla - stale ze wzorow
    float distance = length(light.pozycja - fragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance + light.quadratic * (distance * distance));    
   
    //koncowe wartosci
    vec3 ambient = light.otoczenie * vec3(texture(diffuseTexture, TexCoord));
    vec3 diffuse = light.rozproszone * diff * vec3(texture(diffuseTexture, TexCoord));
    vec3 specular = light.lustrzane * spec * material.lustrzane;

	//koncowy efekt wygaszania
    ambient *= attenuation;
    diffuse *= attenuation;
    specular *= attenuation;

    return (ambient + diffuse + specular);
}