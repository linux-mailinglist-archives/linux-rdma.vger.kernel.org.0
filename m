Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C1A2012E7
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 18:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392352AbgFSPTR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 11:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392438AbgFSPPy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Jun 2020 11:15:54 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D2EC0613EF
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 08:15:53 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id q14so7406171qtr.9
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X2HlrHXMTsUGZp7zXkK0C6ORZXN08Rk3M03svjYzeco=;
        b=KCSiM2dDaLHttoqe1QHt/9yr2IYYTmKDtwUlr/2aAPsMXJotGdlS5LIUOCBI3nfUKr
         7H5hXjOFeIhEMM1rhPsYmLXsVGK+/URRxwB5gkdgB/VVBX1WNWiPWPxGzOXFSojm2k67
         xv0fxT++s5BYKLm5BozcojKfi5oVGvmGeiUTUYEK9kBmA8g9ZeUGElwaPjjy3Aw3zHUD
         ZgrJPkhJj7UA3fOZqK2qsLucfVZJHTCbjC1vzx8LgcH+mB7ndhuHBfDQHVam/u5lMZnQ
         /ScgOIQLnmny9xQ2AmPd/r9OS8erk86JqJJRaxVdcgDBEB/6Qu//RVN/4j5OzzqwuMzv
         jKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X2HlrHXMTsUGZp7zXkK0C6ORZXN08Rk3M03svjYzeco=;
        b=F38EtWUClpWdpUWBV0k/USKCi9eNYghhH1D8XyR38VzaK+zt8ILEOlvK6Aj4/t5T2w
         FC4++LRMa6E4GIcr9JalzGlIlUeNcKZAi6amz/KwAw1lHJcErTMoPcaAX/pMaB4nWdiz
         v4HWEe8wGrJFsntED9lIkpVlAo9EjesJ3qTV9cd1PxFKJK8U2mAQQsGUpM/P9Gbqs1yF
         Mc3ANZ+nLr6HiuYwz8z2LedkJyPNTMrwb1KRWWh6xWOqaS7+N6R4lcNGb7KywsTPxGr1
         QJ2Qg6AxWKPZ0w7Eitl+UfKl92XTTSByS+nx5V0XeZrjjKSxXQ39M14bHbvSyb+e1Mh6
         XTzw==
X-Gm-Message-State: AOAM530nGRSgG0wk6oZ5xMJhqMaeDcP13ngowtLBvZiKrHyzFn+F81aN
        C2bUWSq8TDv5Lk2AitLmvEJkZA==
X-Google-Smtp-Source: ABdhPJwyaHoM3658+VLpg+i0sFuo+6OU0FHPK264DOfSFcO/+Xp6yT6eiXXI1R4LmEbcaqkeIQOs/w==
X-Received: by 2002:ac8:2fb0:: with SMTP id l45mr3800795qta.260.1592579752403;
        Fri, 19 Jun 2020 08:15:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y54sm7195320qtj.28.2020.06.19.08.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 08:15:51 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jmIkB-00Ap5C-Bi; Fri, 19 Jun 2020 12:15:51 -0300
Date:   Fri, 19 Jun 2020 12:15:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
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
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
Message-ID: <20200619151551.GP6578@ziepe.ca>
References: <20200611083430.GD20149@phenom.ffwll.local>
 <20200611141515.GW6578@ziepe.ca>
 <20200616120719.GL20149@phenom.ffwll.local>
 <CAKMK7uE7DKUo9Z+yCpY+mW5gmKet8ugbF3yZNyHGqsJ=e-g_hA@mail.gmail.com>
 <20200617152835.GF6578@ziepe.ca>
 <20200618150051.GS20149@phenom.ffwll.local>
 <20200618172338.GM6578@ziepe.ca>
 <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 19, 2020 at 05:06:04PM +0200, Daniel Vetter wrote:
> On Fri, Jun 19, 2020 at 1:39 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Jun 19, 2020 at 09:22:09AM +0200, Daniel Vetter wrote:
> > > > As I've understood GPU that means you need to show that the commands
> > > > associated with the buffer have completed. This is all local stuff
> > > > within the driver, right? Why use fence (other than it already exists)
> > >
> > > Because that's the end-of-dma thing. And it's cross-driver for the
> > > above reasons, e.g.
> > > - device A renders some stuff. Userspace gets dma_fence A out of that
> > > (well sync_file or one of the other uapi interfaces, but you get the
> > > idea)
> > > - userspace (across process or just different driver) issues more
> > > rendering for device B, which depends upon the rendering done on
> > > device A. So dma_fence A is an dependency and will block this dma
> > > operation. Userspace (and the kernel) gets dma_fence B out of this
> > > - because unfortunate reasons, the same rendering on device B also
> > > needs a userptr buffer, which means that dma_fence B is also the one
> > > that the mmu_range_notifier needs to wait on before it can tell core
> > > mm that it can go ahead and release those pages
> >
> > I was afraid you'd say this - this is complete madness for other DMA
> > devices to borrow the notifier hook of the first device!
> 
> The first device might not even have a notifier. This is the 2nd
> device, waiting on a dma_fence of its own, but which happens to be
> queued up as a dma operation behind something else.
> 
> > What if the first device is a page faulting device and doesn't call
> > dma_fence??
> 
> Not sure what you mean with this ... even if it does page-faulting for
> some other reasons, it'll emit a dma_fence which the 2nd device can
> consume as a dependency.

At some point the pages under the buffer have to be either pinned
or protected by mmu notifier. So each and every single device doing
DMA to these pages must either pin, or use mmu notifier.

Driver A should never 'borrow' a notifier from B

If each driver controls its own lifetime of the buffers, why can't the
driver locally wait for its device to finish?

Can't the GPUs cancel work that is waiting on a DMA fence? Ie if
Driver A detects that work completed and wants to trigger a DMA fence,
but it now knows the buffer is invalidated, can't it tell driver B to
give up?

> The problem is that there's piles of other dependencies for a dma job.
> GPU doesn't just consume a single buffer each time, it consumes entire
> lists of buffers and mixes them all up in funny ways. Some of these
> buffers are userptr, entirely local to the device. Other buffers are
> just normal device driver allocations (and managed with some shrinker
> to keep them in check). And then there's the actually shared dma-buf
> with other devices. The trouble is that they're all bundled up
> together.

But why does this matter? Does the GPU itself consume some work and
then stall internally waiting for an external DMA fence?

Otherwise I would expect this dependency chain should be breakable by
aborting work waiting on fences upon invalidation (without stalling)

> > Do not need to wait on dma_fence in notifiers.
> 
> Maybe :-) The goal of this series is more to document current rules
> and make them more consistent. Fixing them if we don't like them might
> be a follow-up task, but that would likely be a pile more work. First
> we need to know what the exact shape of the problem even is.

Fair enough

Jason
