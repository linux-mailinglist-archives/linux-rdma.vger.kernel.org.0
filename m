Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABE744D789
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Nov 2021 14:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhKKNwB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Nov 2021 08:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhKKNwA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Nov 2021 08:52:00 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF3EC061766
        for <linux-rdma@vger.kernel.org>; Thu, 11 Nov 2021 05:49:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b15so24219959edd.7
        for <linux-rdma@vger.kernel.org>; Thu, 11 Nov 2021 05:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nv+hx8I3IHjCI05ZjVWGV/sj0+jd0uqD6OrAJdus9YA=;
        b=U5PY7YJQv5S8LMsOGm14OqM8+lRkGDN6PRR8XmtLDjDn23rqHngROBq3dAwQYLLsPs
         fpqDW1xFhdhG1ka/y4BJ8cysf2dat/JddltWlknWI7YPhJa08gQQ+GDqBA0vKmQtI9G1
         e4HwUfEJJmcVAWktzR6SpymFcPifDobCog9YmyDUY+4Efr2aTAVqxbegvk3VLxBAqUrt
         Px8nQnQ7HauiDIMs4ZZa3ir2QA9Xn0mwr0Ras40vu5GDZ4571khtzDd7YpYytplaeyto
         VvW9hBqg2dZoxNHP1Ac8lkjIW8hOHlzEAwiQZ59ISdH0O8xtshpjis1y/5P5EhU8mHef
         DPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nv+hx8I3IHjCI05ZjVWGV/sj0+jd0uqD6OrAJdus9YA=;
        b=O/QE+pGyjRLTTYg/m1zvCaj+kYA7Ytt+cJ/opPQj1A8ZpaifnNC/ch61U4KEws9lju
         geMzuRFTHixm/edUgJDgpWYC/gPlju0YMk6HKyVyVaof3Wo8yXxwAlapS4IOXJLY+I4y
         zDV8g+Ngy4Yqc7i817HkGKF4AjuTWTOoG41Alt02ElGNRgD225fRHvSCdnE7IgDZdsL0
         ysJDGWj3VoBRb4uQevdxZjqx85pllNaZ8SymxiV3ismGXRscn1SnhK2R5JgXLPPPRv6f
         AyG52bk2Vj4aUV95nvCogFHMGiu6f1Qx+qrEWVTmqZ3v63EjjjYSvranYF8Pz/KAPf8y
         pNig==
X-Gm-Message-State: AOAM5305J9DBIw9E3L62qMXQEDgvrxh/4wYYqY5GnxiVOfISBJT30MjI
        spe9UGh7kSQQWzAsE1Ag/nrXRHuwSpExTMWTX3ZDjXP8IYUYBA==
X-Google-Smtp-Source: ABdhPJw/NXC1E8jR3e44QZXCku1ttPGzXRrpuSSv/eaMqQm0l+9Sdmk5KxPp0qc0hY0wiU8I/B/qnZ5JiWp/0UWxIk0=
X-Received: by 2002:a05:6402:1ac1:: with SMTP id ba1mr10260902edb.206.1636638550038;
 Thu, 11 Nov 2021 05:49:10 -0800 (PST)
MIME-Version: 1.0
References: <CAMGffEmC07MwNsTHQ19OwUonG4zgYsx0vj+R__9as3E5EduY8A@mail.gmail.com>
 <20211111125845.GB876299@ziepe.ca>
In-Reply-To: <20211111125845.GB876299@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 11 Nov 2021 14:48:59 +0100
Message-ID: <CAMGffEn2wvEnmzc0xe=xYiCLqpphiHDBxCxqAELrBofbUAMQxw@mail.gmail.com>
Subject: Re: Missing infiniband network interfaces after update to 5.14/5.15
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Haris Iqbal <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 11, 2021 at 1:58 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Nov 11, 2021 at 08:48:08AM +0100, Jinpu Wang wrote:
> > Hi Jason, hi Leon,
> >
> > We are seeing exactly the same error reported here:
> > https://bugzilla.redhat.com/show_bug.cgi?id=2014094
> >
> > I suspect it's related to
> > https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/
> >
> > Do you have any idea, what goes wrong?
>
> instrument ib_setup_port_attrs() until you find why it failed
>
> Jason
Thanks Jason and Leon, I will add some debug messages and find out the reason.
