Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047B43BC8A2
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 11:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhGFJr4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 05:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhGFJr4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jul 2021 05:47:56 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB2EC061760;
        Tue,  6 Jul 2021 02:45:16 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so8916928otp.8;
        Tue, 06 Jul 2021 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dz+mf5b0jxNjbTow/jqpUwCBlNrUahNX3010uoWnq3c=;
        b=GebIlLsG3wnD9bFmhGClYwFbSd5NUry7hy9yznhxk6JYeX7btEUsh1ljWnT3SOG7L9
         VD1fSU4APIJ61ZlkwlZGuzqefuKMTR3YLWKOwTksMQnGj1pEo22y2iil/+luGVXtaNTi
         WHixboA9iwiFbSJ7W54NrYsCzLdX1eRgrdE07Yth8XUt7fAI0M0mi9Hey8aoFuubCHNr
         YdJfkvFfv65cXqQIJPA9u+i80+EQ2gbGUnCAIwH/5L2SVy5AhbqizBw5lKu3jgT3MaKW
         vfj0d+m6UELsbl4c9sYUCMYWgrh61wHZTF0+7tv1Y61rhUDdvhdEOMQxTrQAEKpDzrdm
         VAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dz+mf5b0jxNjbTow/jqpUwCBlNrUahNX3010uoWnq3c=;
        b=ttNgkYNoh1UfV0yZySkTrip+VzUDPyCfZOVmjcciVQalTo8G2680tW5Nm0te1VW7kC
         mvHfx6F+QOBl3w475nvO9BAsb0+EflnQdZL3aNZk8mmSl99+72Jw5AqVheYRDf4BHd4Z
         ig/aK7sFJSwH6C3ptze5z2phkCcICzJKOxjYpiCXLyeSqgU+mQ6e28b+bdBjmo/9S619
         97jClbCPD96aQAvOLxVg0gNmwUEAYSxr8A9bmq8EMXvQg05/XpHKRNNviMl6G78D9gMv
         qU7aCCXIHbrZFdDEmLaF2BuYXvsr7M3eGy05sK6ImvnmPfzqlSqWfnXZgqr9XipP/aYf
         IkBA==
X-Gm-Message-State: AOAM530QPHtBiyQZU3uQYSDOA+d40qAQcjf/1Vvyw0UeUcopsFtTsNyX
        uhDSxLRFKxZHGRYZLy1T3Kxlq9g20orD+C6K31Y=
X-Google-Smtp-Source: ABdhPJxBf9teTevWqibbqk3iMkxs2oQg8YD+AXIuIYOH7OAlTf44SDRKjAvd1Ntt8xB1TbhYFmVyQUa43hqNw+WGnbA=
X-Received: by 2002:a9d:76d7:: with SMTP id p23mr14460048otl.145.1625564715878;
 Tue, 06 Jul 2021 02:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210705130314.11519-1-ogabbay@kernel.org> <20210705130314.11519-3-ogabbay@kernel.org>
 <20210705165226.GJ4604@ziepe.ca>
In-Reply-To: <20210705165226.GJ4604@ziepe.ca>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 6 Jul 2021 12:44:49 +0300
Message-ID: <CAFCwf100mkROMw9+2LgW7d3jKnaeZ4nmfWm7HtXuUE7NF4B8pg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] habanalabs: add support for dma-buf exporter
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 5, 2021 at 7:52 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Jul 05, 2021 at 04:03:14PM +0300, Oded Gabbay wrote:
>
> > +     rc = sg_alloc_table(*sgt, nents, GFP_KERNEL | __GFP_ZERO);
> > +     if (rc)
> > +             goto error_free;
>
> If you are not going to include a CPU list then I suggest setting
> sg_table->orig_nents == 0
>
> And using only the nents which is the length of the DMA list.
>
> At least it gives some hope that other parts of the system could
> detect this.

Will do.
>
> > +
> > +     /* Merge pages and put them into the scatterlist */
> > +     cur_page = 0;
> > +     for_each_sgtable_sg((*sgt), sg, i) {
>
> for_each_sgtable_sg should never be used when working with
> sg_dma_address() type stuff, here and everywhere else. The DMA list
> should be iterated using the for_each_sgtable_dma_sg() macro.

Thanks, will change that.

>
> > +     /* In case we got a large memory area to export, we need to divide it
> > +      * to smaller areas because each entry in the dmabuf sgt can only
> > +      * describe unsigned int.
> > +      */
>
> Huh? This is forming a SGL, it should follow the SGL rules which means
> you have to fragment based on the dma_get_max_seg_size() of the
> importer device.
>
hmm
I don't see anyone in drm checking this value (and using it) when
creating the SGL when exporting dmabuf. (e.g.
amdgpu_vram_mgr_alloc_sgt)
Are you sure we need this check ? Maybe I'm mistaken but if that's a
real concern, then most of the drm drivers are broken.

> > +     hl_dmabuf->pages = kcalloc(hl_dmabuf->npages, sizeof(*hl_dmabuf->pages),
> > +                                                             GFP_KERNEL);
> > +     if (!hl_dmabuf->pages) {
> > +             rc = -ENOMEM;
> > +             goto err_free_dmabuf_wrapper;
> > +     }
>
> Why not just create the SGL directly? Is there a reason it needs to
> make a page list?
Well the idea behind it was that we have two points of entry to this
code path (export dmabuf from address, and export dmabuf from handle)
and
we want that the map function later on will be agnostic to it and
behave the same in both cases.

Having said that, if we need to consider the max segment size
according to dma_get_max_seg_size() when creating the SGL, I agree
this code is redundant and I will remove it.

>
> Jason
