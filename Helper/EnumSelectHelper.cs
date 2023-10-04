using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Reflection;

namespace System
{
	public static class EnumSelectHelper
    {
        /// <summary>
        /// /In your controller:

        //If you don't have an enum value use the type
        // ViewBag.DropDownList = EnumHelper.SelectListFor<MyEnum>();

        //If you do have an enum value use the value (the value will be marked as selected)    
        ///ViewBag.DropDownList = EnumHelper.SelectListFor(MyEnum.MyEnumValue);
        ///
        /// 
        /// In your View:

        //        @Html.DropDownList("DropDownList")
        //@* OR*@
        //@Html.DropDownListFor(m => m.Property, ViewBag.DropDownList as SelectList, null)


        /// </summary>
        /// <typeparam name="TEnum"></typeparam>
        /// <param name="value"></param>
        /// <returns></returns>
        // Get the value of the description attribute if the   
        // enum has one, otherwise use the value.  
        public static string GetDescription<TEnum>(this TEnum value)
        {
            var fi = value.GetType().GetField(value.ToString());

            if (fi != null)
            {
                var attributes = (DescriptionAttribute[])fi.GetCustomAttributes(typeof(DescriptionAttribute), false);

                if (attributes.Length > 0)
                {
                    return attributes[0].Description;
                }
            }

            return value.ToString();
        }
         
        public static string GetDisplayName(this Enum enumValue)
        {
            string result = ""; 
              result = enumValue.GetType().GetMember(enumValue.ToString())
             .First()
             .GetCustomAttribute<DisplayAttribute>()
             ?.GetName();

            return result;
        } 


        /// <summary>
        /// Build a select list for an enum
        /// </summary>
        //public static SelectList SelectListFor<T>(bool bALL) where T : struct
        //{
        //    Type t = typeof(T);
        //    return !t.IsEnum
        //        ? null
        //        : new SelectList(BuildSelectListItems(t, bALL), "Value", "Text");
        //}

        ///// <summary>
        ///// Build a select list for an enum with a particular value selected 
        ///// </summary>
        //public static SelectList SelectListFor<T>(bool bALL, T selected) where T : struct
        //{
        //    Type t = typeof(T);
        //    return !t.IsEnum
        //        ? null
        //        : new SelectList(BuildSelectListItems(t, bALL), "Value", "Text", selected.ToString());
        //}


        //private static IEnumerable<SelectListItem> BuildSelectListItems(Type t, bool bALL)
        //{
        //    if (bALL)
        //    { 
        //        return Enum.GetValues(t).Cast<Enum>()
        //            .Select(e => new SelectListItem
        //            {
        //                Value = e.ToString(),
        //                Text = e.GetDescription()
        //            }); 
        //    }
        //    else
        //    {
        //        return Enum.GetValues(t).Cast<Enum>()
        //              .Where(e => true && e.ToString().ToUpper() != "ALL")
        //              .Select(e => new SelectListItem
        //              {
        //                  Value = e.ToString(),
        //                  Text = e.GetDescription()
        //              });
        //    }

        //}











        /// <summary>
        /// Build a select list for an enum
        /// </summary>
        //public static SelectList SelectListForInt<T>(bool bALL) where T : struct
        //{
        //    Type t = typeof(T);
        //    return !t.IsEnum
        //        ? null
        //        : new SelectList(BuildSelectListItemsInt(t, bALL), "Value", "Text");
        //}

        /// <summary>
        /// Build a select list for an enum with a particular value selected 
        /// </summary>
        //public static SelectList SelectListForIntInt<T>(bool bALL, T selected) where T : struct
        //{
        //    Type t = typeof(T);
        //    return !t.IsEnum
        //        ? null
        //        : new SelectList(BuildSelectListItemsInt(t, bALL), "Value", "Text", selected.ToString());
        //}


        //private static IEnumerable<SelectListItem> BuildSelectListItemsInt(Type t, bool bALL)
        //{
        //    if (bALL)
        //    {
        //        return Enum.GetValues(t).Cast<Enum>()
        //            .Select(e => new SelectListItem
        //            {
        //                Value = Convert.ToInt32(e).ToString(),
        //                Text = e.GetDescription()
        //            });
        //    }
        //    else
        //    {
        //        return Enum.GetValues(t).Cast<Enum>()
        //              .Where(e => true && e.ToString().ToUpper() != "ALL")
        //              .Select(e => new SelectListItem
        //              {
        //                  Value = Convert.ToInt32(e).ToString(),
        //                  Text = e.GetDescription()
        //              });
        //    }

        //}



    }
}
