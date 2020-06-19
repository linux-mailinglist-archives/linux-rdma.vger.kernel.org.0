Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3A8200E3C
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 17:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391421AbgFSPGV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391417AbgFSPGR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Jun 2020 11:06:17 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8E2C06174E
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 08:06:17 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a3so8731466oid.4
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l5bPDp6tSQ6UB25Tmr+FxCYVIvJPeZJlOAF1u+aQ9Rs=;
        b=V1jFXKxH9JLOzMoiPIzD5AaSDKHq7RFlO6xezDKhJyRYz93hCrYjWgdK7OEyodFwM2
         kDzGATay8IHh8e80+mnVWhb8ejljyl7TC9nAm9rnfWCRB2CH7Y5/uH3a16+C1ds/YG6W
         L2ObS2Ab5ArSWEXfmwsNABGkjrImJGIKuRrck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l5bPDp6tSQ6UB25Tmr+FxCYVIvJPeZJlOAF1u+aQ9Rs=;
        b=pnbc01/P4pbbpWCzZTOOG70dwYA6RQESu36UX8tOpdqFDCaJ9rUPEpmnjD2iS65T6v
         EaHOjrUMh4LDZ3IuA8pMThEQfuUikrhvZ9TlQq8ae/WiUt7wcn22o07LaflIlo6hIJfd
         tn+Ruq0/GpAgJ/FKJbzrtYHUSMTf36MCR4UdIVvsjMtPUOWu6jRKvdtOn+qterfXR7ot
         osakpcrQeKuOdx+wCAQwSMLqB7m/f5oCpJ8SV0E5RyCgL2W9JVku8Odv9G7TNrboZNSF
         7OYoqlYJm3N4DqDT0rzeVy6EfxpTIVXHfKiC6j0fAVNEhE8Brv2Ggoeyfxw9t+KB0tpM
         cUJQ==
X-Gm-Message-State: AOAM531uc317d6+GjmU0UhXt5ondn40R8pvcPoL4BblwMWZbYK25hhqg
        g3XSCcoJFQfESr9r4qrNMbjL4Fcl4RVnMQzAuvshze+B
X-Google-Smtp-Source: ABdhPJzkpCIjuIXUDXsaWuT9KnXo7xRSxKpK3kVIgCwYzrv9QHH1pbq5icbg335wwjGkDiUm4Nr1W4w/4YXBEbh0gJs=
X-Received: by 2002:aca:aaca:: with SMTP id t193mr3427302oie.14.1592579176624;
 Fri, 19 Jun 2020 08:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-5-daniel.vetter@ffwll.ch>
 <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org> <20200611083430.GD20149@phenom.ffwll.local>
 <20200611141515.GW6578@ziepe.ca> <20200616120719.GL20149@phenom.ffwll.local>
 <CAKMK7uE7DKUo9Z+yCpY+mW5gmKet8ugbF3yZNyHGqsJ=e-g_hA@mail.gmail.com>
 <20200617152835.GF6578@ziepe.ca> <20200618150051.GS20149@phenom.ffwll.local>
 <20200618172338.GM6578@ziepe.ca> <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca>
In-Reply-To: <20200619113934.GN6578@ziepe.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 19 Jun 2020 17:06:04 +0200
Message-ID: <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
        <thomas_os@shipmail.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 19, 2020 at 1:39 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Jun 19, 2020 at 09:22:09AM +0200, Daniel Vetter wrote:
> > > As I've understood GPU that means you need to show that the commands
> > > associated with the buffer have completed. This is all local stuff
> > > within the driver, right? Why use fence (other than it already exists=
)
> >
> > Because that's the end-of-dma thing. And it's cross-driver for the
> > above reasons, e.g.
> > - device A renders some stuff. Userspace gets dma_fence A out of that
> > (well sync_file or one of the other uapi interfaces, but you get the
> > idea)
> > - userspace (across process or just different driver) issues more
> > rendering for device B, which depends upon the rendering done on
> > device A. So dma_fence A is an dependency and will block this dma
> > operation. Userspace (and the kernel) gets dma_fence B out of this
> > - because unfortunate reasons, the same rendering on device B also
> > needs a userptr buffer, which means that dma_fence B is also the one
> > that the mmu_range_notifier needs to wait on before it can tell core
> > mm that it can go ahead and release those pages
>
> I was afraid you'd say this - this is complete madness for other DMA
> devices to borrow the notifier hook of the first device!

The first device might not even have a notifier. This is the 2nd
device, waiting on a dma_fence of its own, but which happens to be
queued up as a dma operation behind something else.

> What if the first device is a page faulting device and doesn't call
> dma_fence??

Not sure what you mean with this ... even if it does page-faulting for
some other reasons, it'll emit a dma_fence which the 2nd device can
consume as a dependency.

> It you are going to treat things this way then the mmu notifier really
> needs to be part of the some core DMA buf, and not randomly sprinkled
> in drivers

So maybe again unclear, we don't allow such userptr dma-buf to even be
shared. They're just for slurping in stuff in the local device
(general from file io or something the cpu has done or similar). There
have been attempts to use it as the general backing storage, but that
didn't go down too well because way too many complications.

Generally most memory the gpu operates on isn't stuff that's
mmu_notifier'ed. And also, the device with userptr support only waits
for its own dma_fence (because well you can't share this stuff, we
disallow that).

The problem is that there's piles of other dependencies for a dma job.
GPU doesn't just consume a single buffer each time, it consumes entire
lists of buffers and mixes them all up in funny ways. Some of these
buffers are userptr, entirely local to the device. Other buffers are
just normal device driver allocations (and managed with some shrinker
to keep them in check). And then there's the actually shared dma-buf
with other devices. The trouble is that they're all bundled up
together.

Now we probably should have some helper code for userptr so that all
drivers do this roughly the same, but that's just not there yet. But
it can't be a dma-buf exporter behind the dma-buf interfaces, because
even just pinned get_user_pages would be too different semantics
compared to normal shared dma-buf objects, that's all very tightly
tied into the specific driver.

> But really this is what page pinning is supposed to be used for, the
> MM behavior when it blocks on a pinned page is less invasive than if
> it stalls inside a mmu notifier.
>
> You can mix it, use mmu notififers to keep track if the buffer is
> still live, but when you want to trigger DMA then pin the pages and
> keep them pinned until DMA is done. The pin protects things (well,
> fork is still a problem)

Hm I thought amdgpu had that (or drm/radeon as the previous
incarnation of that stack), and was unhappy about the issues. Would
need Christian K=C3=B6nig to chime in.

> Do not need to wait on dma_fence in notifiers.

Maybe :-) The goal of this series is more to document current rules
and make them more consistent. Fixing them if we don't like them might
be a follow-up task, but that would likely be a pile more work. First
we need to know what the exact shape of the problem even is.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
