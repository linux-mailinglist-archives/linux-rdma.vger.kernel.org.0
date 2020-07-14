Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D3E21EB6E
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 10:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGNIc0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 04:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgGNIc0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 04:32:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E240AC061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:32:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so1288348wme.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0HN0dxzFpYm4Rka7NmVSrpxEeor/j/vcVp/Uq2Ve5d8=;
        b=YkjNuJN47VltLx1lhEkQLaPsCee/6d2xVibMw2vuA+P5Kc8I4jXeriQ764iOzkURhw
         jjCwLo7ifsdRxD7mnomlGAb5EZ/gTnjJ+JFPscKxv9VyjFpYEQ2T71wduBufP3+s3scy
         09WCqrrsffIFqLnZdRz+312hsyCv8VWWcBG7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0HN0dxzFpYm4Rka7NmVSrpxEeor/j/vcVp/Uq2Ve5d8=;
        b=AFmpVVLae6Duip/V5DAkyYgokSNNcH/2P0+1C/hynAwGpTr0AbXbKjd4o4JFNz5mPk
         L9wOjIAj5lReE23wbdOHJ2dPSTtbcg1cyiyMPhxmHWAgEqGuzgqt3aMHUzbdRT2JPyDK
         xfYCAq1HIvlB0Eth6tUxQc4RPBDGU+200CSSechgFau3TeWQW9W6+IfYoSsQ43RZS8xO
         5/TCjJLt/zzuHtAZFIePfDju/hBw1NVDC6asWemVAV3jUkhzJc9tfJHGUCsA2pJSzr17
         rjz607C0HpFMB2ud0hA2/G73Elzf7Muo0k6OmKL5k7PjNrpwagxzbEwKaF5GM15HDmvJ
         1hdw==
X-Gm-Message-State: AOAM5335fWriW+hUDVmnrZRQAGw0xKaEbhtEpFdinQ2PniHzFO+1fIzR
        dbE/ZlNQH0HSBXvEbuVNNjP015BdNQg=
X-Google-Smtp-Source: ABdhPJwKKcprJsUui8VrRe6dH8//cpcVyZL/UXJFkqUizSHqQAGJUmV4To7vgKryIGOILfcMxjzuxg==
X-Received: by 2002:a1c:1b90:: with SMTP id b138mr3164033wmb.21.1594715544585;
        Tue, 14 Jul 2020 01:32:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a4sm29863857wrg.80.2020.07.14.01.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:32:23 -0700 (PDT)
Date:   Tue, 14 Jul 2020 10:32:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jyri Sarha <jsarha@ti.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/tilcdc: Use standard drm_atomic_helper_commit
Message-ID: <20200714083221.GT3278063@phenom.ffwll.local>
References: <20200707201229.472834-16-daniel.vetter@ffwll.ch>
 <20200708142050.530240-1-daniel.vetter@ffwll.ch>
 <ae71125b-6496-a0e7-3424-9fe69cc3734f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae71125b-6496-a0e7-3424-9fe69cc3734f@ti.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 10, 2020 at 02:16:50PM +0300, Jyri Sarha wrote:
> Thank you Daniel,
> Now this works perfectly, all while I was on vacation.
> 
> On 08/07/2020 17:20, Daniel Vetter wrote:
> > Gives us proper nonblocking support for free, and a pile of other
> > things. The tilcdc code is simply old enough that it was never
> > converted over, but was stuck forever with the copypasta from when it
> > was initially merged.
> > 
> > The riskiest thing with this conversion is maybe that there's an issue
> > with the vblank handling or vblank event handling, which will upset
> > the modern commit support in atomic helpers. But from a cursory review
> > drm_crtc_vblank_on/off is called in the right places, and the event
> > handling also seems to exist (albeit with much hand-rolling and
> > probably some races, could perhaps be converted over to
> > drm_crtc_arm_vblank_event without any real loss).
> > 
> > Motivated by me not having to hand-roll the dma-fence annotations for
> > this.
> > 
> > v2: Clear out crtc_state->event when we're handling the event, to
> > avoid upsetting the helpers (reported by Jyri).
> > 
> > v3: Also send out even whent the crtc is getting disabled. Tilcdc looks a
> > bit like conversion to simple display helpers would work out really
> > nice.
> > 
> 
> Probably. Should take a closer looks some day when I have time.
> 
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Jyri Sarha <jsarha@ti.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Tested-by: Jyri Sarha <jsarha@ti.com>
> Reviewed-by: Jyri Sarha <jsarha@ti.com>

Thanks for testing and reviewing, patch pushed to drm-misc-next.
-Daniel

> 
> > --
> > From logs looks like we're not stuck when disabling the display, so I
> > hacked in a bit of code for that too. Like mentioned above, tilcdc
> > looks like a perfect candidate for simple display helpers, I think
> > that would simplify a _lot_ of code here.
> > -Daniel
> > ---
> >  drivers/gpu/drm/tilcdc/tilcdc_crtc.c  | 13 ++++++++
> >  drivers/gpu/drm/tilcdc/tilcdc_drv.c   | 47 +--------------------------
> >  drivers/gpu/drm/tilcdc/tilcdc_plane.c |  8 +++--
> >  3 files changed, 19 insertions(+), 49 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> > index e9dd5e5cb4e7..1856962411c7 100644
> > --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> > +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> > @@ -537,6 +537,18 @@ static void tilcdc_crtc_atomic_disable(struct drm_crtc *crtc,
> >  	tilcdc_crtc_disable(crtc);
> >  }
> >  
> > +static void tilcdc_crtc_atomic_flush(struct drm_crtc *crtc,
> > +				     struct drm_crtc_state *old_state)
> > +{
> > +	if (!crtc->state->event)
> > +		return;
> > +
> > +	spin_lock_irq(&crtc->dev->event_lock);
> > +	drm_crtc_send_vblank_event(crtc, crtc->state->event);
> > +	crtc->state->event = NULL;
> > +	spin_unlock_irq(&crtc->dev->event_lock);
> > +}
> > +
> >  void tilcdc_crtc_shutdown(struct drm_crtc *crtc)
> >  {
> >  	tilcdc_crtc_off(crtc, true);
> > @@ -822,6 +834,7 @@ static const struct drm_crtc_helper_funcs tilcdc_crtc_helper_funcs = {
> >  	.atomic_check	= tilcdc_crtc_atomic_check,
> >  	.atomic_enable	= tilcdc_crtc_atomic_enable,
> >  	.atomic_disable	= tilcdc_crtc_atomic_disable,
> > +	.atomic_flush	= tilcdc_crtc_atomic_flush,
> >  };
> >  
> >  void tilcdc_crtc_set_panel_info(struct drm_crtc *crtc,
> > diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> > index 0d74a6443263..4f5fc3e87383 100644
> > --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> > +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> > @@ -87,55 +87,10 @@ static int tilcdc_atomic_check(struct drm_device *dev,
> >  	return ret;
> >  }
> >  
> > -static int tilcdc_commit(struct drm_device *dev,
> > -		  struct drm_atomic_state *state,
> > -		  bool async)
> > -{
> > -	int ret;
> > -
> > -	ret = drm_atomic_helper_prepare_planes(dev, state);
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret = drm_atomic_helper_swap_state(state, true);
> > -	if (ret) {
> > -		drm_atomic_helper_cleanup_planes(dev, state);
> > -		return ret;
> > -	}
> > -
> > -	/*
> > -	 * Everything below can be run asynchronously without the need to grab
> > -	 * any modeset locks at all under one condition: It must be guaranteed
> > -	 * that the asynchronous work has either been cancelled (if the driver
> > -	 * supports it, which at least requires that the framebuffers get
> > -	 * cleaned up with drm_atomic_helper_cleanup_planes()) or completed
> > -	 * before the new state gets committed on the software side with
> > -	 * drm_atomic_helper_swap_state().
> > -	 *
> > -	 * This scheme allows new atomic state updates to be prepared and
> > -	 * checked in parallel to the asynchronous completion of the previous
> > -	 * update. Which is important since compositors need to figure out the
> > -	 * composition of the next frame right after having submitted the
> > -	 * current layout.
> > -	 */
> > -
> > -	drm_atomic_helper_commit_modeset_disables(dev, state);
> > -
> > -	drm_atomic_helper_commit_planes(dev, state, 0);
> > -
> > -	drm_atomic_helper_commit_modeset_enables(dev, state);
> > -
> > -	drm_atomic_helper_wait_for_vblanks(dev, state);
> > -
> > -	drm_atomic_helper_cleanup_planes(dev, state);
> > -
> > -	return 0;
> > -}
> > -
> >  static const struct drm_mode_config_funcs mode_config_funcs = {
> >  	.fb_create = drm_gem_fb_create,
> >  	.atomic_check = tilcdc_atomic_check,
> > -	.atomic_commit = tilcdc_commit,
> > +	.atomic_commit = drm_atomic_helper_commit,
> >  };
> >  
> >  static void modeset_init(struct drm_device *dev)
> > diff --git a/drivers/gpu/drm/tilcdc/tilcdc_plane.c b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
> > index 0d09b31ae759..2f681a713815 100644
> > --- a/drivers/gpu/drm/tilcdc/tilcdc_plane.c
> > +++ b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
> > @@ -83,9 +83,11 @@ static void tilcdc_plane_atomic_update(struct drm_plane *plane,
> >  	if (WARN_ON(!state->fb || !state->crtc->state))
> >  		return;
> >  
> > -	tilcdc_crtc_update_fb(state->crtc,
> > -			      state->fb,
> > -			      state->crtc->state->event);
> > +	if (tilcdc_crtc_update_fb(state->crtc,
> > +				  state->fb,
> > +				  state->crtc->state->event) == 0) {
> > +		state->crtc->state->event = NULL;
> > +	}
> >  }
> >  
> >  static const struct drm_plane_helper_funcs plane_helper_funcs = {
> > 
> 
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
