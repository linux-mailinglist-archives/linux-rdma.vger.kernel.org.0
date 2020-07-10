Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFBE21BE39
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 22:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgGJUCd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 16:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgGJUCc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jul 2020 16:02:32 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7E3C08C5DC
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 13:02:32 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t198so5762915oie.7
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 13:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hlzdQKgtPmO74k0pNR7vHuIZBrt/Pc63RtVTndWe5dA=;
        b=SqNPnTQbjsymEOAYWvf7HTkD0FI+HW6j/e6KRe6XGJh3lSuGZ0C7kP/iBUFjVJ03M5
         t8w6HTmvlfEqaW7ZR4/WDh2zFfGdT+tuiUcDAyD+AEP04wFuCMGfRQQM26yq17Soms89
         nnpW0b1zmvAznK5+R6nx5wurVKlahUyCP/oLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlzdQKgtPmO74k0pNR7vHuIZBrt/Pc63RtVTndWe5dA=;
        b=H+jBDvEgkCX4tmiM3rElPeZqRgVa2NUj/cokgAg6Cq4es3ZwoZL1BOfUpVwIa8vcs2
         k4oSiz4lz+iLpvpS9TM2UnhFfkzzZm1Vqyd8UasB4CmrBrbJM2jnYiwvYc3LMEyuFRZW
         B2fAAtOkDar2gmRAHLLMtGgJ8Q/gHW54Vq4dh6KsJlPjnujGhCt2rCo/9Wj8jIlzNImg
         l7cTTwgiAEf2qHD1dpuJaieEDPYG4dk97+5XjikKQIHqMzHF6IZi+Sh/ERuIYS54qqeh
         P8ZBFavwOm1cq0gCnrZ50yScwoh75FxurUTWAWg4HYniab4pel8z9metpC52nNEl17aj
         0Lcg==
X-Gm-Message-State: AOAM5300QX6zh0/SN0yZ/PeAO1INlfEc+8xXZUMQbanwwQRVSTjwuIs1
        +V2l9c9cMVu/GHLG1eAf50dCRFS8nltXU7bd3y2ijg==
X-Google-Smtp-Source: ABdhPJyXe/UuJLRx5f5TlPpv/BPhnkWHORX2InNLi0AlJObIla3gh+GkiBljOI27Z+bfXCvGSQK4tsearkrRp5oifn8=
X-Received: by 2002:aca:da03:: with SMTP id r3mr5553679oig.14.1594411351996;
 Fri, 10 Jul 2020 13:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-3-daniel.vetter@ffwll.ch> <20200709080911.GP3278063@phenom.ffwll.local>
 <20200710124357.GB23821@mellanox.com> <5c163d74-4a28-1d74-be86-099b4729a2e0@amd.com>
 <20200710125453.GC23821@mellanox.com> <4f4a2cf7-f505-8494-1461-bd467870481e@amd.com>
 <20200710134826.GD23821@mellanox.com> <CAKMK7uGSUULTmL=bDXty6U4e37dzLHzu7wgUyOxo2CvR9KvXGg@mail.gmail.com>
 <20200710142347.GE23821@mellanox.com>
In-Reply-To: <20200710142347.GE23821@mellanox.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 10 Jul 2020 22:02:20 +0200
Message-ID: <CAKMK7uFK6Os5ALHEBr7tqCMtmHS1FpuDeOvqs40GVMv2kqJ90g@mail.gmail.com>
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
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 10, 2020 at 4:23 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Fri, Jul 10, 2020 at 04:02:35PM +0200, Daniel Vetter wrote:
>
> > > dma_fence only possibly makes some sense if you intend to expose the
> > > completion outside a single driver.
> > >
> > > The prefered kernel design pattern for this is to connect things with
> > > a function callback.
> > >
> > > So the actual use case of dma_fence is quite narrow and tightly linked
> > > to DRM.
> > >
> > > I don't think we should spread this beyond DRM, I can't see a reason.
> >
> > Yeah v4l has a legit reason to use dma_fence, android wants that
> > there.
>
> 'legit' in the sense the v4l is supposed to trigger stuff in DRM when
> V4L DMA completes? I would still see that as part of DRM

Yes, and also the other way around. But thus far it didn't land.
-Daniel

> Or is it building a parallel DRM like DMA completion graph?
>
> > > Trying to improve performance of limited HW by using sketchy
> > > techniques at the cost of general system stability should be a NAK.
> >
> > Well that's pretty much gpu drivers, all the horrors for a bit more speed :-)
> >
> > On the text itself, should I upgrade to "must not" instead of "should
> > not"? Or more needed?
>
> Fundamentally having some unknowable graph of dependencies where parts
> of the graph can be placed in critical regions like notifiers is a
> complete maintenance nightmare.
>
> I think building systems like this should be discouraged :\

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
