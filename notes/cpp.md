---
layout: default
title: "C++ Notes"
permalink: /notes/cpp/ # Ensure this page is served at the directory root URL
---

<section class="s-content">

    <!-- Page Header -->
    <div class="s-pageheader">
        <div class="row">
            <div class="column large-12">
                <h1 class="page-title">{{ page.title }}</h1>
            </div>
        </div>
    </div> <!-- end s-pageheader-->

    <div class="row">
        <div class="column large-12">
            <p>Notes are listed alphabetically/sequentially based on their filenames.</p>
        </div>
    </div>

    {% assign all_notes = site.cpp_notes %}
    {% assign notes_count = all_notes | size %}

    {% if notes_count > 0 %}
        {% assign notes_per_col = notes_count | divided_by: 2 | ceil %} {# Use 2 for two columns #}

        <div class="row">

            <!-- Column 1 -->
            <div class="column large-6 medium-6 tab-full">
                <ul style="list-style: none; padding-left: 0;"> {# Simple list styling #}
                    {% for note in all_notes limit: notes_per_col %}
                    <li style="margin-bottom: 0.5em;"><a href="{{ note.url | relative_url }}">{{ note.title | default: note.name | escape }}</a></li>
                    {% endfor %}
                </ul>
            </div>

            <!-- Column 2 -->
            <div class="column large-6 medium-6 tab-full">
                <ul style="list-style: none; padding-left: 0;"> {# Simple list styling #}
                    {% for note in all_notes offset: notes_per_col %}
                    <li style="margin-bottom: 0.5em;"><a href="{{ note.url | relative_url }}">{{ note.title | default: note.name | escape }}</a></li>
                    {% endfor %}
                </ul>
            </div>

        </div> <!-- end row -->
    {% else %}
         <div class="row">
            <div class="column large-12">
                <p>No C++ notes found in the collection yet.</p>
            </div>
         </div>
    {% endif %}

</section> <!-- end s-content -->
