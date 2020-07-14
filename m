Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C3521EB8B
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 10:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgGNIjU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 04:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNIjU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 04:39:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0BDC061794
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:39:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so1319820wme.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wWL0p/Vwv0P0ZyYXD3ZMaH3SKBU8WIQHi3HTc/T6A9w=;
        b=ebQ0MwriHk720YK7jpRkgDh2q1K2tVmNTC1YJBlS9yxg5jlb36yjp65sCLFR8BptZ1
         yZjZyyJaO41YaqFoM6++oKXxdeZXDR1ZfvX30KrXnQzzpONVPuYR1S+CF443DmyIJlu5
         Ubb6RD5v3HGzwEZnMQENeriNav21kKQkbJstQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wWL0p/Vwv0P0ZyYXD3ZMaH3SKBU8WIQHi3HTc/T6A9w=;
        b=OHA/gsZ2IXv3+vbG1ywpdEonfYNPzu2v0iPE0Y5NBM95kg1oE3TTeSPm84mGs8XQtt
         XNMZa2cGAXWEQIZ4MqlT17G7uMHx1BNMGLDAfaGY1KofxBNHJyz5DMxuzvTSImhOmHPE
         WU63nraNe8TpBO0EMjX0KqUPGL3jGFGgj3pog1PIa6v7SC8+i8akaIzM6owdwEMvGC62
         5u+ph7LOXYoKpvpyCo844RKd0gGMF8X2Ns9RCSfA5ZnjeKXdI7G/6n74QY5cBKIfG2KD
         YQ71gjWnQyi+XYmF44jOZMZ+Tc3xBDv2SwwDCYF2/LxwU/CUu/23Dw16TjvivbAG0yvw
         HH8g==
X-Gm-Message-State: AOAM530nuP7xXMImUGXHsMym4tSLPgpHBT8vp6B3GsoN3Svx8x3dKhZz
        IRFd/QvfdAmtYPvzLYQ1zHhYZg==
X-Google-Smtp-Source: ABdhPJyOnLYCZDLW6HYI2v9CjdLtSc+vjAnr+zti6cxE291NZ0S4kQLPNPRV5xw+YN8juLwXY+es/Q==
X-Received: by 2002:a7b:c054:: with SMTP id u20mr3129190wmc.2.1594715958922;
        Tue, 14 Jul 2020 01:39:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k11sm30494142wrd.23.2020.07.14.01.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:39:18 -0700 (PDT)
Date:   Tue, 14 Jul 2020 10:39:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 12/25] drm/rcar-du: Annotate dma-fence critical section
 in commit path
Message-ID: <20200714083916.GV3278063@phenom.ffwll.local>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-13-daniel.vetter@ffwll.ch>
 <20200707233240.GR19803@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707233240.GR19803@pendragon.ideasonboard.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 08, 2020 at 02:32:40AM +0300, Laurent Pinchart wrote:
> Hi Daniel,
> 
> Thank you for the patch.
> 
> On Tue, Jul 07, 2020 at 10:12:16PM +0200, Daniel Vetter wrote:
> > Ends right after drm_atomic_helper_commit_hw_done(), absolutely
> > nothing fancy going on here.
> 
> Just looking at this patch and the commit message, I have no idea what
> this does, and why. It would be nice to expand the commit message to
> give some more context, and especially explain why ending signalling
> right after drm_atomic_helper_commit_hw_done() is the right option.
> 
> I suppose I'll have to check the whole series in the meantime :-)

Yes first three patches. They should land in the next few days. The
explanation is a few pages long, not sure that makes much sense to
copypaste into every driver patch here.

Also patch 16 has some more explanation specific for display.

> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > ---
> >  drivers/gpu/drm/rcar-du/rcar_du_kms.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> > index 482329102f19..42c5dc588435 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> > @@ -391,6 +391,7 @@ static void rcar_du_atomic_commit_tail(struct drm_atomic_state *old_state)
> >  	struct drm_crtc_state *crtc_state;
> >  	struct drm_crtc *crtc;
> >  	unsigned int i;
> > +	bool fence_cookie = dma_fence_begin_signalling();
> 
> Can this be moved right before the
> drm_atomic_helper_commit_modeset_disables() call ?

The critical section starts even before this function starts, but for
composability each part is individually annotated. That's why I've put it
as the very first thing in every patch. Currently there's nothing between
the funciton start and drm_atomic_helper_commit_modeset_disables which
could break dma-fence rules, but the entire point of annotations is to not
have to manually prove stuff like this. Wrapping it all is the point here.

Does that make sense?

Also, what I'm realling looking for is testing with lockdep enabled.
Neither me nor you is going to catch issues with review here :-)
-Daniel

> 
> >  
> >  	/*
> >  	 * Store RGB routing to DPAD0 and DPAD1, the hardware will be configured
> > @@ -417,6 +418,7 @@ static void rcar_du_atomic_commit_tail(struct drm_atomic_state *old_state)
> >  	drm_atomic_helper_commit_modeset_enables(dev, old_state);
> >  
> >  	drm_atomic_helper_commit_hw_done(old_state);
> > +	dma_fence_end_signalling(fence_cookie);
> >  	drm_atomic_helper_wait_for_flip_done(dev, old_state);
> >  
> >  	drm_atomic_helper_cleanup_planes(dev, old_state);
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
