enum throwError:Error {
    case errorFirst
}


import PerfectMarkdown
import PerfectLib

print("Hello, world!")

let markdown = "# some blahblah blah markdwon text \n\n## with mojo"

guard let html = markdown.markdownToHTML else {
    print("error")
    throw throwError.errorFirst
}

print(html)

class markdownClass {
    
    internal func markdownHTML(markFile: String, HTMLFile: String?) -> (success: Bool, error: String?) {
        do {
            
            let markdown = try String(contentsOfFile: "/Users/zhangpenghui/Desktop/MyAwesomeProject/Workspace/templates/static/\(markFile)")
            
            let md = markdown[(markdown.range(of: "---")?.lowerBound)!..<markdown.endIndex]
            let mdstring = String(md)
            
            let i = markdown.range(of: "pid: ")
            let j = markdown.range(of: ";")
            
            let pidString = markdown[(i?.upperBound)!..<(j?.lowerBound)!]
            print("pidString = \(pidString)")
            
            if let html = mdstring.markdownToHTML {
                
//                print("markdownWithHTML = \(html)")
                
                let thisFile = File("/Users/zhangpenghui/Desktop/MyAwesomeProject/Workspace/templates/posts/\(pidString).html")
                
//                //存在返回
//                guard !thisFile.exists else {
//                    return (false, "error")
//                }
                
                try thisFile.open(.readWrite)
                try thisFile.write(string: html)
                thisFile.close()
                
                return (true,nil)
            }
            
            return (false, "error")
        } catch {
            return (false, "error")
        }
    }
}

let thisStatic = Dir("/Users/zhangpenghui/Desktop/MyAwesomeProject/Workspace/templates/static/")

try thisStatic.forEachEntry { (n) in
    
    let result = markdownClass().markdownHTML(markFile: n, HTMLFile: nil)
    print("result = \(result)")
}

