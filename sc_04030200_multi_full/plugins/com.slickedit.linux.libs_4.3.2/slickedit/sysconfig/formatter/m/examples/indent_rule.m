extern "C" {
namespace Khan
{
   class B {
   public:
      void cpu_space_heater(State x)
      {
         start:
         switch (x) {
         case ON:
            goto start;
             default:
                {
               goto start;
                }
         }
      }
   }
}
}
@interface Something : NSObject {
   @public
      char* aName;
}
- (id)go;
@end
