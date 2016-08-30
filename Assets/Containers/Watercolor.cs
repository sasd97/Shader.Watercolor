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
        private const string ScreenResolutiuonVectorFlag = "_ScreenResolution";
        #endregion

        #region Settings
        [Range(0, 10)]
        public int Iterations;
        [Range(0, 4)]
        public int DownRes;
        #endregion

        #region Variables
        public Shader ScShader;
        private Material _scMaterial;
        #endregion

        #region Materials
        Material Material
        {
            get {
                return _scMaterial ?? (_scMaterial = new Material(ScShader) {hideFlags = HideFlags.HideAndDontSave});
            }
        }
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
            if (ScShader != null)
            {
                int width = sourceTexture.width >> DownRes;
                int height = sourceTexture.height >> DownRes;

                RenderTexture rt = RenderTexture.GetTemporary(width, height);
                Graphics.Blit(sourceTexture, rt);

                for (int i = 0; i < Iterations; i++)
                {
                    RenderTexture rt2 = RenderTexture.GetTemporary(width, height);
                    Graphics.Blit(rt, rt2, Material);
                    RenderTexture.ReleaseTemporary(rt);
                    rt = rt2;
                }

                Graphics.Blit(rt, destTexture);
                RenderTexture.ReleaseTemporary(rt);
            }
            else
            {
                Graphics.Blit(sourceTexture, destTexture);
            }
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
            if (Application.isPlaying != true)
            {
                ScShader = Shader.Find(ShaderName);
            }
            #endif

        }
	
        void OnDisable()
        {
            if (_scMaterial)
            {
                DestroyImmediate(_scMaterial);
            }
        }	
    }
}