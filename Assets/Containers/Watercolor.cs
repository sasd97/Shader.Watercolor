/*
	Created by Alexander Dadukin & Vladimir Polyakov
	26/08/2016
*/

using UnityEngine;

namespace Assets.Containers
{
    [ExecuteInEditMode]
    public class Watercolor : MonoBehaviour
    {
        #region Constants
        private const string ShaderName = "Shaders/Watercolor";
        #endregion

        #region Variables

        public Shader ScShader;
        #endregion

        void Start () 
        {
            ScShader = Shader.Find(ShaderName);

            if(!SystemInfo.supportsImageEffects)
            {
                enabled = false;
                return;
            }
        }
	
        void OnRenderImage(RenderTexture sourceTexture, RenderTexture destTexture)
        {
        }

        void OnValidate()
        {
        }

        void Update () 
        {
            if (Application.isPlaying)
            {

            }

            #if UNITY_EDITOR
            if (Application.isPlaying!=true)
            {
                ScShader = Shader.Find(ShaderName);

            }
            #endif

        }
	
        void OnDisable ()
        {
        }	
    }
}