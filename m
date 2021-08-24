Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D8F3F6A08
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Aug 2021 21:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhHXTom (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Aug 2021 15:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhHXTom (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Aug 2021 15:44:42 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC19C061757;
        Tue, 24 Aug 2021 12:43:57 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id x10-20020a056830408a00b004f26cead745so49147136ott.10;
        Tue, 24 Aug 2021 12:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBbTc7OlDYPpYPyI2mJEpC5WNa/R3jML5MemVKt7vxM=;
        b=llUXYTXRx7lnpKLnCUSaxUM9p08o9HH4gc9HSkXqS1/cVHmEUtLpColBXFieKfgWzm
         bRzmeShA6clmtElXKicQAyRIf06K8UbKF5PxLM+JmfSzkjg3G3ORcMXcl4YIknzXem3y
         /3M9svbfztv2qY+xtdeyAox0bpAIAxUUvWts+kvg+BAZQg5yr2oKM2rbjSdQdxDoWGvV
         +niP6l4tAPzr5r/ZzIqZwrh3j+bJT51RHudo/0G6vL9b/1zc3jnJ5A9Uxmkq9+0xSTHb
         qXez/x6ctYhPbKY4HrJmfi/QV0FyMSetwl4bScjQJBtOYAOLsJmQzC1fu0uVbT1UXwB2
         osqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBbTc7OlDYPpYPyI2mJEpC5WNa/R3jML5MemVKt7vxM=;
        b=hLOt73c9falSXqYIDdUIyCOmFA/sUiK6fDeHfjh/TrXeZKgk80kUVrbERdIDW2z7go
         cFhxrcWi4u6USAY64ue7i65YcXXkRgZ4kAn2kGW1/8R1UZx9H7r2P5Nlr5IQBRBKHQn6
         G+9bPCXmlKmxIxr4IhT2xR0qcPgcPv0ZIQF+GD7NGwkuBFiLZmhZCZPzH3uDPTYl++QZ
         tXwu0B4V9XdHZxaAOwyfshv9KsJdFZEkfyTCTpM6r1xKPt7TFb/s6mBr476egRX8Z51e
         wW9aC4onycGZoN00rr6LgKN0tSZ8PIweWyW5GgRKE0J00MT6ksk09p+V29qoexLf1apF
         jjdg==
X-Gm-Message-State: AOAM530b8tkD6l2uHifzJpRHEUb6ou436AHw0ygS/gC7YZY8nJIN36Jo
        tTHimPM+DNdCxCwkOjgyDTZ20Kl66tFiwPon7io=
X-Google-Smtp-Source: ABdhPJzmToZkcSRY6iS0ugkuP8K2hav7y9IVCYNyAMElC9hGxpTBNA4yY/VJkNP6g47QpJTrM6QSPnXHj78fudkDTcM=
X-Received: by 2002:a05:6808:6d2:: with SMTP id m18mr3985768oih.120.1629834237075;
 Tue, 24 Aug 2021 12:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210819230602.GU543798@ziepe.ca> <CAKMK7uGgQWcs4Va6TGN9akHSSkmTs1i0Kx+6WpeiXWhJKpasLA@mail.gmail.com>
 <20210820123316.GV543798@ziepe.ca> <0fc94ac0-2bb9-4835-62b8-ea14f85fe512@amazon.com>
 <20210820143248.GX543798@ziepe.ca> <da6364b7-9621-a384-23b0-9aa88ae232e5@amazon.com>
 <fa124990-ee0c-7401-019e-08109e338042@amd.com> <e2c47256-de89-7eaa-e5c2-5b96efcec834@amazon.com>
 <6b819064-feda-b70b-ea69-eb0a4fca6c0c@amd.com> <a9604a39-d08f-6263-4c5b-a2bc9a70583d@nvidia.com>
 <20210824173228.GE543798@ziepe.ca> <1d1bd2d0-f467-4808-632b-1cca1174cfd9@nvidia.com>
 <CAPM=9txd71fisvZ1Es5Fv2mwR2vWfHJarya7oeKOm2aq6tH0HQ@mail.gmail.com>
In-Reply-To: <CAPM=9txd71fisvZ1Es5Fv2mwR2vWfHJarya7oeKOm2aq6tH0HQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Aug 2021 15:43:46 -0400
Message-ID: <CADnq5_OBt2bQoWzadZ6kR46XU5QMVtzv9aB10CtE49PAotHHPg@mail.gmail.com>
Subject: Re: [RFC] Make use of non-dynamic dmabuf in RDMA
To:     Dave Airlie <airlied@gmail.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Doug Ledford <dledford@redhat.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 24, 2021 at 3:16 PM Dave Airlie <airlied@gmail.com> wrote:
>
> On Wed, 25 Aug 2021 at 03:36, John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > On 8/24/21 10:32 AM, Jason Gunthorpe wrote:
> > ...
> > >>> And yes at least for the amdgpu driver we migrate the memory to host
> > >>> memory as soon as it is pinned and I would expect that other GPU drivers
> > >>> do something similar.
> > >>
> > >> Well...for many topologies, migrating to host memory will result in a
> > >> dramatically slower p2p setup. For that reason, some GPU drivers may
> > >> want to allow pinning of video memory in some situations.
> > >>
> > >> Ideally, you've got modern ODP devices and you don't even need to pin.
> > >> But if not, and you still hope to do high performance p2p between a GPU
> > >> and a non-ODP Infiniband device, then you would need to leave the pinned
> > >> memory in vidmem.
> > >>
> > >> So I think we don't want to rule out that behavior, right? Or is the
> > >> thinking more like, "you're lucky that this old non-ODP setup works at
> > >> all, and we'll make it work by routing through host/cpu memory, but it
> > >> will be slow"?
> > >
> > > I think it depends on the user, if the user creates memory which is
> > > permanently located on the GPU then it should be pinnable in this way
> > > without force migration. But if the memory is inherently migratable
> > > then it just cannot be pinned in the GPU at all as we can't
> > > indefinately block migration from happening eg if the CPU touches it
> > > later or something.
> > >
> >
> > OK. I just want to avoid creating any API-level assumptions that dma_buf_pin()
> > necessarily implies or requires migrating to host memory.
>
> I'm not sure we should be allowing dma_buf_pin at all on
> non-migratable memory, what's to stop someone just pinning all the
> VRAM and making the GPU unuseable?

In a lot of cases we have GPUs with more VRAM than system memory, but
we allow pinning in system memory.

Alex

>
> I understand not considering more than a single user in these
> situations is enterprise thinking, but I do worry about pinning is
> always fine type of thinking when things are shared or multi-user.
>
> My impression from this is we've designed hardware that didn't
> consider the problem, and now to let us use that hardware in horrible
> ways we should just allow it to pin all the things.
>
> Dave.
