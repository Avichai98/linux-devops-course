package app.ctf.controllers;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
public class CtfController {
    private final List<String> messages = new ArrayList<>();
    private final String SECRET_FLAG = "AfekaCTF{XSS_Makes_It_Work}";

    @GetMapping("/")
    public String home() {
        return "index";
    }

    @PostMapping("/")
    public String submit(@RequestParam String message, Model model) {
        messages.add(message);
        model.addAttribute("messages", messages);
        return "index";
    }

    // This endpoint returns the flag — only accessible via JS running in browser
    @ResponseBody
    @GetMapping("/secret-flag")
    public String getFlag(@RequestHeader(value = "Referer", required = false) String referer,
                          HttpServletRequest request) {
        if (referer != null && referer.contains("/")) {
            return SECRET_FLAG;
        }
        return "Nope!";
    }
}
