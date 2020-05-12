Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EAD1CF511
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgELM5R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 08:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728085AbgELM5N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 08:57:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDFEC061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 05:57:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d207so6381570wmd.0
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=YLwPnbDauSfAWxQ+40E6XOuXjM5jTgn5iCgXAVP6tHM=;
        b=KWGRPT0N+HWyZObFdaYwOoBDk6GmRygeG8bjF/Ab5wGAv3MXUGlO2Xf6a+9ZJ61BCM
         hxPgvmTkF+Bkvy7vlPpqhg8/t9LiQ1q0PTy/V04RetxJf4aLej2ZMhnrdUtQEP/RP/8a
         Z5PNDBOPNPemwJ32wYOyATJbIthvElXXJrGr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YLwPnbDauSfAWxQ+40E6XOuXjM5jTgn5iCgXAVP6tHM=;
        b=B4m9S0LB9SfDY43TrMmWIbdMVHOjiBvJEaSLnonlJbVqxH0rTPRpNC9tKNOpkGEzf9
         49sUjOD5/ukQ3s+66rypxo8vftMTChSowG3IjiG27X143xrAHbikgRbTHChFbNvt42Vq
         e5YC6AXL7Z2orcSfoKHQK+3DJPy9Kf32DXJZRC2NcLwC02O1UssnNR7rwgdfUIqXK6yD
         Vy2nfg0kipcXPL0d/8maFSqKMrdVhFPI7kvtR73h0V/VuQY8fQUXl94o/hXo1Of7dwur
         0fM5DDti7STWYCd5RVMTg3267rAL0XBLhBc+eJ9r44E2GiUJUSN8k36AmRXMkQOd4sUX
         Lu0A==
X-Gm-Message-State: AGi0PuaX12yhbR9+VJT6w77gDRxjTS53mLb0GgHZYeDpwHSI71LBNGB+
        dEU8/QgF/xwDzxwZkYMAVijuUA==
X-Google-Smtp-Source: APiQypJPVhngnqNHLopAtRaOF+m2sBFi2Xz4I59IV6FcrkZnjpcKLb8O72XuWRPFprkKUYDNGgj6Nw==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr27041116wmk.18.1589288231721;
        Tue, 12 May 2020 05:57:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 32sm23035619wrg.19.2020.05.12.05.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 05:57:10 -0700 (PDT)
Date:   Tue, 12 May 2020 14:57:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [RFC 02/17] dma-fence: basic lockdep annotations
Message-ID: <20200512125708.GG206103@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-3-daniel.vetter@ffwll.ch>
 <20200512120952.GG26002@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512120952.GG26002@ziepe.ca>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 09:09:52AM -0300, Jason Gunthorpe wrote:
> On Tue, May 12, 2020 at 10:59:29AM +0200, Daniel Vetter wrote:
> > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> > index 6802125349fb..d5c0fd2efc70 100644
> > +++ b/drivers/dma-buf/dma-fence.c
> > @@ -110,6 +110,52 @@ u64 dma_fence_context_alloc(unsigned num)
> >  }
> >  EXPORT_SYMBOL(dma_fence_context_alloc);
> >  
> > +#ifdef CONFIG_LOCKDEP
> > +struct lockdep_map	dma_fence_lockdep_map = {
> > +	.name = "dma_fence_map"
> > +};
> > +
> > +bool dma_fence_begin_signalling(void)
> > +{
> 
> Why is this global? I would have expected it to be connected to a
> single fence?

It's the same rules for all fences, since they can be shared across
drivers in various ways. Lockdep usually achieves that with a static
variable hidden in the macro, but that doesn't work if you have lots of
different ways from different drivers to create a dma_fence. Hence the
unique global one that we explicitly allocate.

We have similar stuff for the global dma_resv_lock ww_mutex class, just
there it's a bit more standardized and hidden behind a neat macro. But
really lockdep needs global lockdep_maps or it doesn't work.

> It would also be alot nicer if this was some general lockdep feature,
> not tied to dmabuf. This exact problem also strikes anyone using
> completions, for instance, and the same solution should be
> applicable??

There was:

https://lwn.net/Articles/709849/

It even got merged, and seems to have worked. Unfortunately (and I'm not
entirely clear on the reasons) it was thrown out again, so we can't use
it. That means wait_event/wake_up dependencies need to be manually
annotated, like e.g. flush_work() already is. flush_work is more or less
where I've stolen this idea from, with some adjustements and tricks on top
to make it work for dma_fence users.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
