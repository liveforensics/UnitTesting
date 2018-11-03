using System;
using System.Text;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MyClassesTest
{
    /// <summary>
    /// Summary description for MyClassesTestInitialisation
    /// </summary>
    [TestClass]
    public class MyClassesTestInitialisation
    {
        [AssemblyInitialize]
        public static void AssemblyInitialise(TestContext tc)
        {
            tc.WriteLine("In AssemblyInitialise");
        }
        [AssemblyCleanup]
        public static void AssemblyCleanup()
        {
            // TODO: Clean up after all tests in an assembly
        }
    }
}
