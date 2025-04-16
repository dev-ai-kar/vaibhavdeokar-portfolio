---
layout: default
title: "C++ Notes"
permalink: /notes/cpp/ # Ensure this page is served at the directory root URL
---

<section class="s-content">
    <div class="row">
        <div class="column large-12">

            <article class="s-content__entry format-standard">

                <div class="s-content__entry-header">
                    <h1 class="s-content__title s-content__title--post">C++ Notes Index</h1>
                </div> <!-- end s-content__entry-header -->

                <div class="s-content__primary">
                    <div class="s-content__entry-content">
                        <p>List of available C++ notes:</p>
                        <ul>
                          {% for note in site.cpp_notes %}
                            <li><a href="{{ note.url | relative_url }}">{{ note.title }}</a></li>
                          {% endfor %}
                        </ul>
                    </div> <!-- end s-entry__entry-content -->
                </div> <!-- end s-content__primary -->

            </article> <!-- end entry -->

        </div> <!-- end column -->
    </div> <!-- end row -->
</section> <!-- end s-content -->
