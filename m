Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A975A21B796
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgGJOCt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 10:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbgGJOCs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jul 2020 10:02:48 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDF3C08C5DC
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 07:02:47 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 12so4874115oir.4
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xTQ5MsJnerH24IzbOibKIVgALQbQ6fBLEFDFGaudNHc=;
        b=WU2W6d+TZkpC2bQ5QGHyZU588I4aYRy0pgR/0jf5dsrsdUKzG7CHHQbdXmPQGYQqUL
         nasfBbJ4/UbxjUPNH17KzLPCu8/hid/VouoHAy2Rs5LX3JMX0PseWupYbCGix+YrbFIN
         0G929NaZD66foWbG+h37GXj5alNoKzzHEG+Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xTQ5MsJnerH24IzbOibKIVgALQbQ6fBLEFDFGaudNHc=;
        b=eK+OAJShJgz1ZpfXQGHZfD6mvihKczirL0DREXKx/+DFrKc/pJnmg8hQ+WvXZokde6
         rLtvZioHcmm1z8+jlXGm8RNh8mzRwC2VWiDJEZb+GE6w1EX5ww1D4DSbgukAvSBmoe8z
         DtiTgHsFfmnYBXdOgF9iChxNnEGx3rxGmiotQyAXm8kRWD0S/GziOFW4OvDUz3+tXhFK
         PpuKqzB7Ich8p+BZRTiLcyCkCwTUTWpdlmG1SBkJC3ttl4wHUatPY/Xu7Q00gGGu+xan
         2EIteL/BCHZin7GkTGAOtXZdy6fwJkOyf07rl8QNgaeFOtiFFtyex2mapyQpqBqpYJPR
         X1qQ==
X-Gm-Message-State: AOAM530AwoG7sfdupmlZuieGktfFD6UZlT7+GR5XBIcZ5RISWhJkjmai
        YH6Bx0FiO+/i6fiD3hUIZkh1Xk/jG1GPRYMTGQEUXQ==
X-Google-Smtp-Source: ABdhPJz9ueO/NwCXWq4u05bld/A1Jzmv30JDZLkssowFodTQImkU08xp+BW6yONjBlhlRH0STky3grfq96MK+YXxz58=
X-Received: by 2002:aca:cc8e:: with SMTP id c136mr4296478oig.128.1594389767031;
 Fri, 10 Jul 2020 07:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-3-daniel.vetter@ffwll.ch> <20200709080911.GP3278063@phenom.ffwll.local>
 <20200710124357.GB23821@mellanox.com> <5c163d74-4a28-1d74-be86-099b4729a2e0@amd.com>
 <20200710125453.GC23821@mellanox.com> <4f4a2cf7-f505-8494-1461-bd467870481e@amd.com>
 <20200710134826.GD23821@mellanox.com>
In-Reply-To: <20200710134826.GD23821@mellanox.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 10 Jul 2020 16:02:35 +0200
Message-ID: <CAKMK7uGSUULTmL=bDXty6U4e37dzLHzu7wgUyOxo2CvR9KvXGg@mail.gmail.com>
Subject: Re: [PATCH 02/25] dma-fence: prime lockdep annotations
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        kernel test robot <lkp@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 10, 2020 at 3:48 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Fri, Jul 10, 2020 at 03:01:10PM +0200, Christian K=C3=B6nig wrote:
> > Am 10.07.20 um 14:54 schrieb Jason Gunthorpe:
> > > On Fri, Jul 10, 2020 at 02:48:16PM +0200, Christian K=C3=B6nig wrote:
> > > > Am 10.07.20 um 14:43 schrieb Jason Gunthorpe:
> > > > > On Thu, Jul 09, 2020 at 10:09:11AM +0200, Daniel Vetter wrote:
> > > > > > Hi Jason,
> > > > > >
> > > > > > Below the paragraph I've added after our discussions around dma=
-fences
> > > > > > outside of drivers/gpu. Good enough for an ack on this, or want=
 something
> > > > > > changed?
> > > > > >
> > > > > > Thanks, Daniel
> > > > > >
> > > > > > > + * Note that only GPU drivers have a reasonable excuse for b=
oth requiring
> > > > > > > + * &mmu_interval_notifier and &shrinker callbacks at the sam=
e time as having to
> > > > > > > + * track asynchronous compute work using &dma_fence. No driv=
er outside of
> > > > > > > + * drivers/gpu should ever call dma_fence_wait() in such con=
texts.
> > > > > I was hoping we'd get to 'no driver outside GPU should even use
> > > > > dma_fence()'
> > > > My last status was that V4L could come use dma_fences as well.
> > > I'm sure lots of places *could* use it, but I think I understood that
> > > it is a bad idea unless you have to fit into the DRM uAPI?
> >
> > It would be a bit questionable if you use the container objects we came=
 up
> > with in the DRM subsystem outside of it.
> >
> > But using the dma_fence itself makes sense for everything which could d=
o
> > async DMA in general.
>
> dma_fence only possibly makes some sense if you intend to expose the
> completion outside a single driver.
>
> The prefered kernel design pattern for this is to connect things with
> a function callback.
>
> So the actual use case of dma_fence is quite narrow and tightly linked
> to DRM.
>
> I don't think we should spread this beyond DRM, I can't see a reason.

Yeah v4l has a legit reason to use dma_fence, android wants that
there. There's even been patches proposed years ago, but never landed
because android is using some vendor hack horror show for camera
drivers right now.

But there is an effort going on to fix that (under the libcamera
heading), and I expect that once we have that, it'll want dma_fence
support. So outright excluding everyone from dma_fence is a bit too
much. They definitely shouldn't be used though for entirely
independent stuff.

> > > You are better to do something contained in the single driver where
> > > locking can be analyzed.
> > >
> > > > I'm not 100% sure, but wouldn't MMU notifier + dma_fence be a valid=
 use case
> > > > for things like custom FPGA interfaces as well?
> > > I don't think we should expand the list of drivers that use this
> > > technique.
> > > Drivers that can't suspend should pin memory, not use blocked
> > > notifiers to created pinned memory.
> >
> > Agreed totally, it's a complete pain to maintain even for the GPU drive=
rs.
> >
> > Unfortunately that doesn't change users from requesting it. So I'm pret=
ty
> > sure we are going to see more of this.
>
> Kernel maintainers need to say no.
>
> The proper way to do DMA on no-faulting hardware is page pinning.
>
> Trying to improve performance of limited HW by using sketchy
> techniques at the cost of general system stability should be a NAK.

Well that's pretty much gpu drivers, all the horrors for a bit more speed :=
-)

On the text itself, should I upgrade to "must not" instead of "should
not"? Or more needed?
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
