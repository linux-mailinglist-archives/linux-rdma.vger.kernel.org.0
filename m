Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7311521ED66
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 11:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgGNJ52 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 05:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNJ51 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 05:57:27 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB20C061755;
        Tue, 14 Jul 2020 02:57:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so4170788wmj.2;
        Tue, 14 Jul 2020 02:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dHnFvOIsrXw6jrB6m+7BeIm/WgTb5Cqh7gsjXssaU1c=;
        b=KnoAcjX4xbVjcEeEVJH8HgscVFZmdZqaHYPU5EtBNSakspRZVOZRaF/dmW850mwgBb
         EIEhQt2487O5Ch8XMPP3/ZU0Tssjmmc7st+F7gnirRjowDijU/yBcwEg3SOb9H1XsW6O
         ZHx7iwIiziKTbK9+5KHYm9bGfe6nUHtsA16tHYKBk0E3M0omDqd8kn8O5ydg6O3+BZtA
         PutrPQjiZTbEN81UwfdkSWanowJeW2hnqp7xV47pvtph9xIjnMWVQWpGmaH8ubZFQrdd
         I/n+BAZE77F8uVwo3QQ03YNLe+6OGonbu4pK0o7ZgyMLHkHiHLHLknU5JFB2PiFJ+gQS
         W0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dHnFvOIsrXw6jrB6m+7BeIm/WgTb5Cqh7gsjXssaU1c=;
        b=oPeWk+0OAMMkLCpvUUOwK/Z3qWXqdrfDO1I9uNJx5vA/Zz79MfRRzWniCsl9jF8a4s
         pxlAZCUOnSjzrObQ88+Y6OFnNc7bQUwlGNxWuFeGLyLDm0dp38F4AfXXq9ZsM1R5hXqO
         Tbdj5b2orrHkXB6eBT+zprTgwgEq9jHXbpA8R7OAa/ByWQy37Zr1ZPH8HDv2lwrOsH/w
         /pXnW/WdNquJQ9r5SrwkY35WrlFAFUdjcrk7LbEr+VE67rUhmFqCsNryrEIT1KK5Qv6f
         o7lmx2ZcYOASnmj8uFU3WY9MeYK2gN0ATsK7H+8KV34e2G96z97neRFtevG+YCNDVrd6
         l/vQ==
X-Gm-Message-State: AOAM531knnD8u/+e0mpoTqhMTW4GdDQUGc2GuXbtB5JCgSmFmbaJXzzU
        wWHm2zVZJYMeFv9Gzk8qaLc=
X-Google-Smtp-Source: ABdhPJy//OrDpSJANwxwERqV3gHdFYgIJtILxA4cb/jXIXye2R9kTiX9uf+7YtLVsgsXyKpQFfoArw==
X-Received: by 2002:a1c:4444:: with SMTP id r65mr3301652wma.129.1594720644598;
        Tue, 14 Jul 2020 02:57:24 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id r28sm27797330wrr.20.2020.07.14.02.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 02:57:23 -0700 (PDT)
Date:   Tue, 14 Jul 2020 06:57:17 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Trevor Woerner <twoerner@gmail.com>
Subject: Re: [PATCH 04/25] drm/vkms: Annotate vblank timer
Message-ID: <20200714095717.njwk2u4tkgro54jn@smtp.gmail.com>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-5-daniel.vetter@ffwll.ch>
 <20200712222716.4rhvj7hryiecjthv@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200712222716.4rhvj7hryiecjthv@smtp.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 07/12, Rodrigo Siqueira wrote:
> Hi,
> 
> Everything looks fine to me, I just noticed that the amdgpu patches did
> not apply smoothly, however it was trivial to fix the issues.
> 
> Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> 
> Melissa,
> Since you are using vkms regularly, could you test this patch and review
> it? Remember to add your Tested-by when you finish.
>
Hi,

I've applied the patch series, ran some tests on vkms, and found no
issues. I mean, things have remained stable.

Tested-by: Melissa Wen <melissa.srw@gmail.com>

> Thanks
> 
> On 07/07, Daniel Vetter wrote:
> > This is needed to signal the fences from page flips, annotate it
> > accordingly. We need to annotate entire timer callback since if we get
> > stuck anywhere in there, then the timer stops, and hence fences stop.
> > Just annotating the top part that does the vblank handling isn't
> > enough.
> > 
> > Cc: linux-media@vger.kernel.org
> > Cc: linaro-mm-sig@lists.linaro.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Christian König <christian.koenig@amd.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > ---
> >  drivers/gpu/drm/vkms/vkms_crtc.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > index ac85e17428f8..a53a40848a72 100644
> > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > @@ -1,5 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >  
> > +#include <linux/dma-fence.h>
> > +
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_probe_helper.h>
> > @@ -14,7 +16,9 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
> >  	struct drm_crtc *crtc = &output->crtc;
> >  	struct vkms_crtc_state *state;
> >  	u64 ret_overrun;
> > -	bool ret;
> > +	bool ret, fence_cookie;
> > +
> > +	fence_cookie = dma_fence_begin_signalling();
> >  
> >  	ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
> >  					  output->period_ns);
> > @@ -49,6 +53,8 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
> >  			DRM_DEBUG_DRIVER("Composer worker already queued\n");
> >  	}
> >  
> > +	dma_fence_end_signalling(fence_cookie);
> > +
> >  	return HRTIMER_RESTART;
> >  }
> >  
> > -- 
> > 2.27.0
> > 
> 
> -- 
> Rodrigo Siqueira
> https://siqueira.tech


