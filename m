Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F8D3B215B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 21:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFWTmg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 15:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhFWTmf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Jun 2021 15:42:35 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A0AC0613A2;
        Wed, 23 Jun 2021 12:40:15 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso3086987oto.12;
        Wed, 23 Jun 2021 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDjEA/DLHJuJqbx7wc+mRyI0RJczQytGp1V6E75bd6s=;
        b=njxfplOx17G0/91fOLaiwVofE0DeSdGcCG3lxRi9OYVY6KYvRDAEsYT4a2X08avjYz
         uk9LS4BPT8B0ygh92FmzwsjnilNP75l1/gXEVq89GseCAdSIpq6YYw8fjjAPPxr4o+PW
         L1d2m01Uw4KLPxZ66w09nOVAPTd8mJoSjCCMU66jx/8k6x/Lf49D21aPA/ifhKbt2vkW
         jY4n3+MG8/wALoxr2cftjzWWAHPFat3vVo01kBbQP+RM7GGT5W4PQR6uFllaJRjFkjzQ
         vwcmftcSUgYfe5LpftZyXNntJzQ+Wo2BZqKzqtT+Ch7LKM5E+/AWX9vBPa/rH66Sg51K
         GNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDjEA/DLHJuJqbx7wc+mRyI0RJczQytGp1V6E75bd6s=;
        b=d7oDwWtBSFOBJ15jMYouUqLjlwSCasEdomDIFvWMcYICYo1E4noBb+G7rEoltqExPQ
         oK5LrZgJo4cLXUUjvL/wEqLO+qCGCV0QpU8v8NpVOQf0eOwggoCxY/bAEUONGNAg3G3E
         1H2mW+y/uJ28qjcmw5zHA6ATCJbAqLysGLEJBHQ0Ta3lxQXPJXlxoSYIpZ1OEZRGJwSV
         Oolm3VK1vALZZ+0mOTV5sZYKcxZJSnpjpqFY9lAk6SJ5SIueSR/cEO5mXbocGz6oEhjK
         o5NEp+EuytaKgHvkx494ehwNg1qUgOjagS5TPAlb5ktYTOou7GGpZ2ZzFx8LmCRWPJ1M
         kMlw==
X-Gm-Message-State: AOAM530ColhpSh+ZVgUlBXq4Z5EH8gbuSriJwiqCl1z9Zdsp/r3nn2Wx
        mf4p6FqWRx9GdaIsIHJXiCDSklS4gX9i2w4LYhI=
X-Google-Smtp-Source: ABdhPJznDm09EdJ4nc7aCaNiJgX/OzhaJax6fBkCDboeJEjZGy4mnzO3nT99DVOufQL4W+3P5HvD7FiPj986tjjoFdA=
X-Received: by 2002:a9d:542:: with SMTP id 60mr1364333otw.143.1624477214591;
 Wed, 23 Jun 2021 12:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210622152343.GO1096940@ziepe.ca> <3fabe8b7-7174-bf49-5ffe-26db30968a27@amd.com>
 <20210622154027.GS1096940@ziepe.ca> <09df4a03-d99c-3949-05b2-8b49c71a109e@amd.com>
 <20210622160538.GT1096940@ziepe.ca> <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com>
 <20210623182435.GX1096940@ziepe.ca> <CAFCwf111O0_YB_tixzEUmaKpGAHMNvMaOes2AfMD4x68Am4Yyg@mail.gmail.com>
 <20210623185045.GY1096940@ziepe.ca> <CAFCwf12tW_WawFfAfrC8bgVhTRnDA7DuM+0V8w3JsUZpA2j84w@mail.gmail.com>
 <20210623193456.GZ1096940@ziepe.ca>
In-Reply-To: <20210623193456.GZ1096940@ziepe.ca>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 23 Jun 2021 22:39:48 +0300
Message-ID: <CAFCwf13vM2T-eJUu42ht5jdXpRCF3UZh0Ow=vwN9QqZ=KNUBsQ@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Doug Ledford <dledford@redhat.com>,
        Tomer Tayar <ttayar@habana.ai>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 23, 2021 at 10:34 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jun 23, 2021 at 10:00:29PM +0300, Oded Gabbay wrote:
> > On Wed, Jun 23, 2021 at 9:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Wed, Jun 23, 2021 at 09:43:04PM +0300, Oded Gabbay wrote:
> > >
> > > > Can you please explain why it is so important to (allow) access them
> > > > through the CPU ?
> > >
> > > It is not so much important, as it reflects significant design choices
> > > that are already tightly baked into alot of our stacks.
> > >
> > > A SGL is CPU accessible by design - that is baked into this thing and
> > > places all over the place assume it. Even in RDMA we have
> > > RXE/SWI/HFI1/qib that might want to use the CPU side (grep for sg_page
> > > to see)
> > >
> > > So, the thing at the top of the stack - in this case the gaudi driver
> > > - simply can't assume what the rest of the stack is going to do and
> > > omit the CPU side. It breaks everything.
> > >
> > > Logan's patch series is the most fully developed way out of this
> > > predicament so far.
> >
> > I understand the argument and I agree that for the generic case, the
> > top of the stack can't assume anything.
> > Having said that, in this case the SGL is encapsulated inside a dma-buf object.
> >
> > Maybe its a stupid/over-simplified suggestion, but can't we add a
> > property to the dma-buf object,
> > that will be set by the exporter, which will "tell" the importer it
> > can't use any CPU fallback ? Only "real" p2p ?
>
> The block stack has been trying to do something like this.
>
> The flag doesn't solve the DMA API/IOMMU problems though.
hmm, I thought using dma_map_resource will solve the IOMMU issues, no ?
We talked about it yesterday, and you said that it will "work"
(although I noticed a tone of reluctance when you said that).

If I use dma_map_resource to set the addresses inside the SGL before I
export the dma-buf, and guarantee no one will use the SGL in the
dma-buf for any other purpose than device p2p, what else is needed ?

Oded

>
> Jason
