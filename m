Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D24400F1D
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Sep 2021 12:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbhIEK3k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Sep 2021 06:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbhIEK3W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Sep 2021 06:29:22 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36906C061575
        for <linux-rdma@vger.kernel.org>; Sun,  5 Sep 2021 03:28:19 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v10so4617519ybm.5
        for <linux-rdma@vger.kernel.org>; Sun, 05 Sep 2021 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AQI+gaP3gRr3DWEJsbHrkGhbGs7Zx+5Z3tcCL1B09EM=;
        b=hGDJJkWSW05bNl19CJkknXhJXhdqAVTFPKt8R8ypbO9bENcCVqwNYNjiSU4nUMP486
         HZ/YGcjWrbQMmxERfXgXLCDFTg6lEDm30cygaD3HHUm0c618kwRaEYiOmWuVkdqFJujX
         VFXi0u1aCBJgz1mnTaoOMvvnJ/7jx89Ndv4DfKLm3UDr6eu1BTUZTLv11uiYEjhnWq7s
         1+hFOxIW+vx3SfsmV+O6cbh8MFs2yDHv0COxQ8JkB8gMnbXBQ0AF3974xoSpWgWVFI3t
         AkcEngGewqdpW2cAojMw7CGVA0IDPTc7/7PyKyZ3XBJcVtORiGwlYaR07H3Ub3dgXRkp
         HbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AQI+gaP3gRr3DWEJsbHrkGhbGs7Zx+5Z3tcCL1B09EM=;
        b=LBg45ujx0eAmB1NpphRSEVK/rjMWlulcrEAUf/GhSfskU2Hf7CPlqWmj1tuyz9vwFb
         0660qX2HPp0391gZabfZA/e6MSMEDfQ7mKcl/J5McOgo+DfDXlqF94ZSqRA+Xw4BR9Ly
         e2q/QZRUr+YUGhc07oqSfKnEvrEN0uvG21w6ExOfCj3l98cjIELC+V1ngXVYvPRTG80O
         r11bLbVmLDjVKzJ/1hnG1ql15J4gC7v00qh2atZPIlTl4eqkVY3FdxfNDaEeSp8xdHfh
         5H6Gdu/lO9aKE9X73ts2xKq5lpVakrXdIHVwwUNzEeYVR+UkzQShSsMW2DlqcES3AZPL
         ZEsQ==
X-Gm-Message-State: AOAM5301h3VFXcErvyr7qrldBBRaA/rPBHGz+rmydsCKy31F4U/2rEYb
        RuezhPLujY7zRlrHd9040hRx0nY+K3WjO17klKXGrpCYOizK+w==
X-Google-Smtp-Source: ABdhPJwUMjpiClPMnVypnfptUylRaktIv0wJ9B2H/+UCZ38X0rqhKmYEOjyQpFyVnf3CKn6DETL4fJkPaTAzeQBjUsI=
X-Received: by 2002:a25:ba08:: with SMTP id t8mr9911518ybg.111.1630837698320;
 Sun, 05 Sep 2021 03:28:18 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <ceo.teo.en.ming@gmail.com>
Date:   Sun, 5 Sep 2021 18:28:08 +0800
Message-ID: <CAMEJMGFDhtq4e3kYo0ZOsO71dX3MJDX4OyPB4TbLQ0Y98Tph5Q@mail.gmail.com>
Subject: Introduction: I am a Linux and open source software enthusiast
To:     linux-rdma@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Subject: Introduction: I am a Linux and open source software enthusiast

Greetings from Singapore,

My name is Mr. Turritopsis Dohrnii Teo En Ming, 43 years old as of 5
September 2021. My country is Singapore. Presently I am an IT
Consultant with a System Integrator (SI)/computer firm in Singapore. I
am also a Linux and open source software and information technology
enthusiast.

You can read my autobiography on my redundant blogs. The title of my
autobiography is:

"Autobiography of Singaporean Targeted Individual Mr. Turritopsis
Dohrnii Teo En Ming (Very First Draft, Lots More to Add in Future)"

Links to my redundant blogs (Blogger and Wordpress) can be found in my
email signature below.

I have three other redundant blogs, namely:

https://teo-en-ming.tumblr.com/

https://teo-en-ming.medium.com/

https://teo-en-ming.livejournal.com/

Future/subsequent versions of my autobiography will be published on my
redundant blogs.

My Blog Books are also available for download on my redundant blogs.

Thank you very much.




-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's
Academic Qualifications as at 14 Feb 2019 and refugee seeking attempts
at the United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan
(5 Aug 2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
