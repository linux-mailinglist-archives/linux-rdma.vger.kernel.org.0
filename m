Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E1B1DB0E9
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgETLD1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 07:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgETLD1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 May 2020 07:03:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4B2C061A0E
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2020 04:03:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i15so2652343wrx.10
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2020 04:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ct4iwtkqSx7W80DKvDt8WvEkiq9KjVIacJ0yr7BAVII=;
        b=gCn4N7N304bnLXil/a63o+C7lXWE4O+dUD5kr4U/QwkYok3WIYIss7MpTiwkIvDJDu
         Yb14/i8NGGvtiwnPpTQWB1oc/MHjv9gyvs+HjkbrsA9GEiFTSWKwCkg07hWlb9e22xpX
         cG1iXAAYqHj6N5FDXXS8FFy8ELfjoCREHTKlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=ct4iwtkqSx7W80DKvDt8WvEkiq9KjVIacJ0yr7BAVII=;
        b=VNGgGBl6vfFsIMp9M37CaTyyuHVGG53dEYCbtUXdI/A8QxNXhiRgIVq6K82V9oUtzI
         neflyT6Qp5yogsC/DowAlt85gcY19Q5nOqFtFkpW7sXIG++BbzaSFDZ1z4OS7wCA2tsM
         5OdIMZypUrcpZlrTukhWDMWEs9MmMvHJjtIXnVVJW9V7eKxXnQy2mOG520u9nK2eAa6H
         bpf6Og088/4Yuwi9JYVMPDaEr+q1+5aJIByjLaefXd4nYuCtWeMsOJ/lQAovpsrI0iyL
         6H9hBrIdmYNY4ehjXMavHhEsDmvT2vNAhH53L5prPbjpsvViW5hVkmAvcnM3l+HLG1g7
         OZvQ==
X-Gm-Message-State: AOAM533MstK2sQHuD9OTkb0J8D4G331+p+lLVlnTw47WXIojikU5cil1
        AYixtQLeFcZ+UgID7eQ9C715Aw==
X-Google-Smtp-Source: ABdhPJzCd29Xl/wTekkJzbG2hFf7ELniw9c+535re3/QWPV7VzmtBOKv2TwjIms44WqcPc+fmic+SA==
X-Received: by 2002:adf:fe90:: with SMTP id l16mr3672440wrr.222.1589972604221;
        Wed, 20 May 2020 04:03:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u65sm2743050wmg.8.2020.05.20.04.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 04:03:23 -0700 (PDT)
Date:   Wed, 20 May 2020 13:03:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] dma-fence: add might_sleep annotation to _wait()
Message-ID: <20200520110320.GT206103@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20200519132756.682888-1-daniel.vetter@ffwll.ch>
 <be86b73c-2fb3-a6c0-5a12-004af051210f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be86b73c-2fb3-a6c0-5a12-004af051210f@amd.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 20, 2020 at 08:54:36AM +0200, Christian König wrote:
> Am 19.05.20 um 15:27 schrieb Daniel Vetter:
> > Do it uncontionally, there's a separate peek function with
> > dma_fence_is_signalled() which can be called from atomic context.
> > 
> > v2: Consensus calls for an unconditional might_sleep (Chris,
> > Christian)
> > 
> > Full audit:
> > - dma-fence.h: Uses MAX_SCHEDULE_TIMOUT, good chance this sleeps
> > - dma-resv.c: Timeout always at least 1
> > - st-dma-fence.c: Save to sleep in testcases
> > - amdgpu_cs.c: Both callers are for variants of the wait ioctl
> > - amdgpu_device.c: Two callers in vram recover code, both right next
> >    to mutex_lock.
> > - amdgpu_vm.c: Use in the vm_wait ioctl, next to _reserve/unreserve
> > - remaining functions in amdgpu: All for test_ib implementations for
> >    various engines, caller for that looks all safe (debugfs, driver
> >    load, reset)
> > - etnaviv: another wait ioctl
> > - habanalabs: another wait ioctl
> > - nouveau_fence.c: hardcoded 15*HZ ... glorious
> > - nouveau_gem.c: hardcoded 2*HZ ... so not even super consistent, but
> >    this one does have a WARN_ON :-/ At least this one is only a
> >    fallback path for when kmalloc fails. Maybe this should be put onto
> >    some worker list instead, instead of a work per unamp ...
> > - i915/selftests: Hardecoded HZ / 4 or HZ / 8
> > - i915/gt/selftests: Going up the callchain looks safe looking at
> >    nearby callers
> > - i915/gt/intel_gt_requests.c. Wrapped in a mutex_lock
> > - i915/gem_i915_gem_wait.c: The i915-version which is called instead
> >    for i915 fences already has a might_sleep() annotation, so all good
> > 
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > Cc: "VMware Graphics" <linux-graphics-maintainer@vmware.com>
> > Cc: Oded Gabbay <oded.gabbay@gmail.com>
> > Cc: linux-media@vger.kernel.org
> > Cc: linaro-mm-sig@lists.linaro.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Christian König <christian.koenig@amd.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>

intel-gfx-ci approves too, thanks to both of you for reviews, patch merged
to drm-misc-next.
-Daniel

> 
> > ---
> >   drivers/dma-buf/dma-fence.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> > index 90edf2b281b0..656e9ac2d028 100644
> > --- a/drivers/dma-buf/dma-fence.c
> > +++ b/drivers/dma-buf/dma-fence.c
> > @@ -208,6 +208,8 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
> >   	if (WARN_ON(timeout < 0))
> >   		return -EINVAL;
> > +	might_sleep();
> > +
> >   	trace_dma_fence_wait_start(fence);
> >   	if (fence->ops->wait)
> >   		ret = fence->ops->wait(fence, intr, timeout);
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
