using Microsoft.AspNetCore.Mvc;
using SimpleCalculatorWeblinux.Models;

namespace SimpleCalculatorWeblinux.Controllers
{
    public class CalculatorController : Controller
    {
        [HttpGet]
        public IActionResult Index()
        {
            // Return the 'Index' view from the 'Home' folder
            return View("~/Views/Home/Index.cshtml", new CalculatorModel { Value1 = 0, Value2 = 0, Operation = "Add" });
        }

        [HttpPost]
        public IActionResult Calculate(CalculatorModel model)
        {
            switch (model.Operation)
            {
                case "Add":
                    model.Result = model.Value1 + model.Value2;
                    break;
                case "Subtract":
                    model.Result = model.Value1 - model.Value2;
                    break;
                case "Multiply":
                    model.Result = model.Value1 * model.Value2;
                    break;
                case "Divide":
                    model.Result = model.Value2 != 0 ? model.Value1 / model.Value2 : 0;
                    break;
            }
            // Return the 'Index' view from the 'Home' folder with the updated model
            return View("~/Views/Home/Index.cshtml", model);
        }
    }
}