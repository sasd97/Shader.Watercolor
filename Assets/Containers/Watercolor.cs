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

        #region Variables
        public Shader ScShader;
        private Material _scMaterial;
        private readonly Vector2 _scScreenSize = new Vector2(Screen.width, Screen.height);
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
                Material.SetVector(ScreenResolutiuonVectorFlag, _scScreenSize);
                Graphics.Blit(sourceTexture, destTexture, Material);
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