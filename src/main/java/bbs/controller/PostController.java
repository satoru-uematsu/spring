package bbs.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import bbs.dto.PostsDto;
import bbs.entity.Users;
import bbs.form.PostForm;
import bbs.service.PostsService;

@Controller
public class PostController {
    @Autowired
    private PostsService postsService;

    @RequestMapping(value = "/addPost", method = RequestMethod.POST)
    public String addPost(@ModelAttribute PostForm form,HttpSession session) {
    	Users loginUser = (Users) session.getAttribute("loginUser");
    	postsService.addPost(loginUser, form);
        return "redirect:/home";
    }

    @RequestMapping(value = "/newPost", method = RequestMethod.GET)
    public String newPost(Model model) {
    	model.addAttribute("post",new PostsDto());
        model.addAttribute("categories",postsService.getCategories());
    	model.addAttribute("action_post","confirmPost");
    	model.addAttribute("is_readonly",false);
        return "addPost";
    }

    @RequestMapping(value = "/confirmPost", method = RequestMethod.POST)
    public String confirmPost(@ModelAttribute PostForm form, Model model) {
        PostsDto post = new PostsDto();
    	BeanUtils.copyProperties(form, post);
    	model.addAttribute("post",post);
        model.addAttribute("categories",postsService.getCategories());
    	model.addAttribute("action_post","addPost");
    	model.addAttribute("is_readonly",true);
        return "addPost";
    }

    @RequestMapping(value = "/doeditPost", method = RequestMethod.POST)
    public String editPost(Model model, PostForm form) {
    	postsService.editPost(form);
        return "redirect:/home";
    }
}