Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3907021EB7C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 10:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgGNIet (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 04:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNIes (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 04:34:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F86C061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:34:48 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so20288476wru.6
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K91c8fFe6EieBtvrxtfxonx0x9RxTurKJuaMG5F3Ud4=;
        b=aUcIAb5ITcZhu35Ohf4qglLh9VjvwtnirWnGQ4Gj6lMz9VbLnI7QSQIw8cqx5llHzI
         HTJc4ygD+WXxtLFFL7WqB6U3xMx5zphIW4ArUlz2/WeB6he4crgN1BqMqgV+kCwrPRvG
         Mn1eu6XQYG3zIlswsyltjacS2V3Ooh0R2hSZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K91c8fFe6EieBtvrxtfxonx0x9RxTurKJuaMG5F3Ud4=;
        b=OGgUchNba/DsWZRJ1mtG0uxPK0Oqar7AO7nLLiEF96ryfUzSiX4Ruj9roTGwq26ZeD
         EHFrz/snqOv2hoBfVfv3QEPdPQ/Lm5nR+DO+ki1jx+7x64s2atg0v4JrjOb0UOl7ot4E
         4fPNkjVQ0BWYbmrywQtNQISGWls0tIzm0KL2W17sWKQhDA7dsyiQTXJ3SaIDENgYEY/U
         Iuri2cZx6PSArcmKefzR2fZy5qYNsz06/EKBfMUV+DiKMqIz0ySV95EByYxlelLUktMY
         FFoxhxu0l1jcrApoU/WBrZoOa2II6jwxCbpmJRwUuYpAYSc4BdoPnPCExRxqPLoofi4I
         3Jvw==
X-Gm-Message-State: AOAM530YAIXwD8UotTxRdfBLunXJu3jo0Jj1S7tvgKKNutg/O/VExYQ+
        QPgCm9PHDM4KixKpUAnv4vDwQw==
X-Google-Smtp-Source: ABdhPJwCnGtXhumdxB3E/91dbQgl0bntY1R8MxmECWxuvNsNQ5eGRIeroGGz+Gd4oiNmz7XNlmjktw==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr3814345wrr.364.1594715687205;
        Tue, 14 Jul 2020 01:34:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w14sm27844836wrt.55.2020.07.14.01.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:34:46 -0700 (PDT)
Date:   Tue, 14 Jul 2020 10:34:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Daniel Vetter <daniel.vetter@intel.com>, nd@arm.com
Subject: Re: [PATCH 07/25] drm/komdea: Annotate dma-fence critical section in
 commit path
Message-ID: <20200714083444.GU3278063@phenom.ffwll.local>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-8-daniel.vetter@ffwll.ch>
 <20200708051739.GB1121718@jamwan02-TSP300>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708051739.GB1121718@jamwan02-TSP300>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 08, 2020 at 01:17:39PM +0800, james qian wang (Arm Technology China) wrote:
> On Tue, Jul 07, 2020 at 10:12:11PM +0200, Daniel Vetter wrote:
> > Like the helpers, nothing special. Well except not, because we the
> > critical section extends until after hw_done(), since that's the last
> > thing which could hold up a subsequent atomic commit. That means the
> > wait_for_flip_done is included, but that's not a problem, we're
> > allowed to call dma_fence_wait() from signalling critical sections.
> > Even on our own fence (which this does), it's just a bit confusing.
> > But in a way those last 2 function calls are already part of the fence
> > signalling critical section for the next atomic commit.
> > 
> > Reading this I'm wondering why komeda waits for flip_done() before
> > calling hw_done(), which is a bit backwards (but hey hw can be
> > special). Might be good to throw a comment in there that explains why,
> > because the original commit that added this just doesn't.
> 
> Hi Daniel:
> 
> It's a typo, thank you for pointing this out, and I'll give a fix after
> this series have been merged.
> 
> for this patch
> 
> Reviewed-by: James Qian Wang <james.qian.wang@arm.com>

Hi James,

Thanks for revieweing. Note that the "wrong" order doesn't have to be a
real problem, there's other drivers which need this one too. But they
explain why in a comment. So if you change that, make sure you test it all
well to avoid surprises.

Testing (with lockdep enabled) would be really good here, can you try to
do that too?

Also, next patch is for drm/malidp, can you pls review that patch too?

Thanks, Daniel

> 
> > Cc: "James (Qian) Wang" <james.qian.wang@arm.com>
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Mihail Atanassov <mihail.atanassov@arm.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > index 1f6682032ca4..cc5b5915bc5e 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > @@ -73,6 +73,7 @@ static struct drm_driver komeda_kms_driver = {
> >  static void komeda_kms_commit_tail(struct drm_atomic_state *old_state)
> >  {
> >  	struct drm_device *dev = old_state->dev;
> > +	bool fence_cookie = dma_fence_begin_signalling();
> >  
> >  	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> >  
> > @@ -85,6 +86,8 @@ static void komeda_kms_commit_tail(struct drm_atomic_state *old_state)
> >  
> >  	drm_atomic_helper_commit_hw_done(old_state);
> >  
> > +	dma_fence_end_signalling(fence_cookie);
> > +
> >  	drm_atomic_helper_cleanup_planes(dev, old_state);
> >  }
> >  
> > -- 
> > 2.27.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
