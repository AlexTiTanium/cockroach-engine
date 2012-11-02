package classes.resourceManager
{

   import flash.utils.ByteArray;
   import org.as3yaml.YAML;
   import org.as3yaml.YAMLException;
   
   [EditorData(extensions="yaml")]
   
   /**
    * This is a Resource subclass for YAML data.
    */
   public class YAMLResource extends Resource
   {
      /**
       * The loaded yaml This will be null until loading of the resource has completed.
       */
      public function get YAMLData():Object
      {
         return _yaml;
      }
      
      /**
       * The data loaded from an YAML file is just a string containing the YAML itself,
       * so we don't need any special loading. This just converts the byte array to
       * a string and marks the resource as loaded.
       */
      override public function initialize(data:*):void
      {
         if (data is ByteArray)
         {
         	// convert ByteArray data to a string
         	data = (data as ByteArray).readUTFBytes((data as ByteArray).length);
         }
            
         try
         {
            _yaml = YAML.decode(data);
         }
         catch (e:YAMLException)
         {
			throw new Error("Got type error parsing YAML: " + e.toString());
            _valid = false;
         }
         
         onLoadComplete();
      }
      
      /**
       * @inheritDoc
       */
      override protected function onContentReady(content:*):Boolean 
      {
         return _valid;
      }
      
      private var _valid:Boolean = true;
      private var _yaml:Object = null;
   }
}