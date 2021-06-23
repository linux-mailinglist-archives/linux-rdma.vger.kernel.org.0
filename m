Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B433B207F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 20:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhFWSpt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWSps (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Jun 2021 14:45:48 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48432C061574;
        Wed, 23 Jun 2021 11:43:31 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id k1-20020a0568200161b029024bef8a628bso965048ood.7;
        Wed, 23 Jun 2021 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cpkWeMAkWCf76CjUWKr9rUiGHMNQHXwmEhD8GnECJcY=;
        b=FAdddLGyvRhCK6AccX0MB+lVTROAnOJkBjUEiLvKrGbCjDXg8cMuBvzhCKCYG+2wp/
         7FJ3bFXrVJfND52cISdONm5rVb5W9wcg0gd6yEuwoMBJliQ+FKvkdyDQWzozxNSwBNbs
         JO7eZe4ZccJ/2bx2xYR8vGk+3FNkZO8h7JpLwuS4w5BJ2EAXBGSDJEkL0jivD5z+gFEw
         7BIJX+4ApeN6hyu2dSaya30ciWfKtm1usu/9aEHqyXKsn8HrRL8Oik9b/5kIdMgkmffs
         40h8uV5SomFi6A7tfXs9WuHwRD2nn3EpgHQL1ljq24NiTrr2WkcWAikxIxKIRjiJG6dp
         7Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cpkWeMAkWCf76CjUWKr9rUiGHMNQHXwmEhD8GnECJcY=;
        b=dT2q+uAFiupTv8l87TZ91N6EWS61YuKmypmSJYHLxHxpnneShijbf9ko7dRyNMdiAB
         5b6hgqiEoNjC3fTim3nk2I/6tEdEmsZ19XAG25guqblAiVR41k6DzQyl8dubrMCiylFX
         FFdJqsSNKu6zQ8LzPTqdSu6Oz+MD1lO30YPhJQypJqvX+MRWK9qGTF2bzw0tvkAXD81N
         neVC117VrIuCXjcJ7jWnz/1IdF/KuBxbEIwT8x61px+n8Di7aWmZdnkgYTEyx/Nr+atv
         4JLhlo10CG6JRezacLXpDhI0u7qWKiYdxyfhaePoD0tZwekOQLkgVE+CkN04B8a26cIR
         pZNA==
X-Gm-Message-State: AOAM531cvxcvINOmQtgFJQ9opiB15jxNke9fp5jIgwVJthlCrcod/r01
        sM9FQMuToLEL8b8l9BXfT/7COmR1z8Kx0P5mxqQ=
X-Google-Smtp-Source: ABdhPJztTw3IUTHnVPOKEUa+mzrtiHw343QNu8CeH1GRn9gntl2RUBK4RDrGb/9f1ZBukujNJOVgfhuumtOwviJ5UvE=
X-Received: by 2002:a4a:1a84:: with SMTP id 126mr976948oof.77.1624473810500;
 Wed, 23 Jun 2021 11:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca> <d497b0a2-897e-adff-295c-cf0f4ff93cb4@amd.com>
 <20210622152343.GO1096940@ziepe.ca> <3fabe8b7-7174-bf49-5ffe-26db30968a27@amd.com>
 <20210622154027.GS1096940@ziepe.ca> <09df4a03-d99c-3949-05b2-8b49c71a109e@amd.com>
 <20210622160538.GT1096940@ziepe.ca> <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com>
 <20210623182435.GX1096940@ziepe.ca>
In-Reply-To: <20210623182435.GX1096940@ziepe.ca>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 23 Jun 2021 21:43:04 +0300
Message-ID: <CAFCwf111O0_YB_tixzEUmaKpGAHMNvMaOes2AfMD4x68Am4Yyg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 23, 2021 at 9:24 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jun 23, 2021 at 10:57:35AM +0200, Christian K=C3=B6nig wrote:
>
> > > > No it isn't. It makes devices depend on allocating struct pages for=
 their
> > > > BARs which is not necessary nor desired.
> > > Which dramatically reduces the cost of establishing DMA mappings, a
> > > loop of dma_map_resource() is very expensive.
> >
> > Yeah, but that is perfectly ok. Our BAR allocations are either in chunk=
s of
> > at least 2MiB or only a single 4KiB page.
>
> And very small apparently
>
> > > > Allocating a struct pages has their use case, for example for expos=
ing VRAM
> > > > as memory for HMM. But that is something very specific and should n=
ot limit
> > > > PCIe P2P DMA in general.
> > > Sure, but that is an ideal we are far from obtaining, and nobody want=
s
> > > to work on it prefering to do hacky hacky like this.
> > >
> > > If you believe in this then remove the scatter list from dmabuf, add =
a
> > > new set of dma_map* APIs to work on physical addresses and all the
> > > other stuff needed.
> >
> > Yeah, that's what I totally agree on. And I actually hoped that the new=
 P2P
> > work for PCIe would go into that direction, but that didn't materialize=
d.
>
> It is a lot of work and the only gain is to save a bit of memory for
> struct pages. Not a very big pay off.
>
> > But allocating struct pages for PCIe BARs which are essentially registe=
rs
> > and not memory is much more hacky than the dma_resource_map() approach.
>
> It doesn't really matter. The pages are in a special zone and are only
> being used as handles for the BAR memory.
>
> > By using PCIe P2P we want to avoid the round trip to the CPU when one d=
evice
> > has filled the ring buffer and another device must be woken up to proce=
ss
> > it.
>
> Sure, we all have these scenarios, what is inside the memory doesn't
> realy matter. The mechanism is generic and the struct pages don't care
> much if they point at something memory-like or at something
> register-like.
>
> They are already in big trouble because you can't portably use CPU
> instructions to access them anyhow.
>
> Jason

Jason,
Can you please explain why it is so important to (allow) access them
through the CPU ?
In regard to p2p, where is the use-case for that ?
The whole purpose is that the other device accesses my device,
bypassing the CPU.

Thanks,
Oded
