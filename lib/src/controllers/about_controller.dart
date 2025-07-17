import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:utilidades/src/models/about_model.dart';

class AboutController {
  AboutModel getAbout() {
    return AboutModel(
      photoUrl: "https://avatars.githubusercontent.com/u/17409046?v=4",
      aboutMe: [
        'Sou um desenvolvedor fullStack a 25 anos de experiência e CEO da Chief Delivery, uma plataforma de Gestão de Restaurantes.',
        'Além disso, é o criador do Canal Café pra DEV no Youtube e leciona cursos de programação desde 2022.',
        'Com uma especialização em desenvolvimento web, Diego compartilha seu conhecimento e experiência para ajudar as pessoas a aprenderem e se desenvolverem na área da programação.',
      ],
      socialLinks: [
        SocialLink(
          name: "Github",
          icon: FontAwesomeIcons.github,
          color: Colors.black,
          url: "https://github.com/bracellos",
        ),
        SocialLink(
          name: "LinkedIn",
          icon: FontAwesomeIcons.linkedin,
          color: Colors.indigo,
          url: "https://linkedin.com/in/bracellos",
        ),
        SocialLink(
          name: "Youtube",
          icon: FontAwesomeIcons.youtube,
          color: Colors.red,
          url: "https://youtube.com/@cafepradev",
        ),
      ],
    );
  }
}
