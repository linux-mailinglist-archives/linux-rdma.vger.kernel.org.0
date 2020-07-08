Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49443218A02
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 16:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgGHOU7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 10:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbgGHOU7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jul 2020 10:20:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56B9C061A0B
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2020 07:20:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so46181617wrw.1
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jul 2020 07:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mbjs4Xco2BnQcEWmOYB21di0nfPsS4vqLCypsBXuRUM=;
        b=Sf2tXa4i8T58WeCNrxFfRBSsdgYHlntwEX22AOgxISFSfy6CwM8HbQOwhCiT6V1LA8
         ZlTJnOWwEA6WLknVFjmYFzLu/Uu98KlRTMBqBAPKSui4lRxYjNkFVbOhMF6kqm/vuv2T
         9ChyXcOOe9ioMKDXRz/qwWgGoVVkTswgee7aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mbjs4Xco2BnQcEWmOYB21di0nfPsS4vqLCypsBXuRUM=;
        b=nAlF4DKxDN/yK7qFKXjdcaFx3pzLyLR0Ku23jUfAOrbB6BBF2bpKWVQoikMzUYJB3a
         TmixQCrIXjTHbEZTmL2yYpfxJ+15csC77NL35++jkl/nWdV2GphnHC+a6bU995rwamtf
         LGvj3UacdYKsZ/quav1hJ3TXTQeWa7WPsWjUqkTRIyT/lhAJ8DmbCtLt77E6eI62wiD/
         gIEqr2QfHeG0c6U0wpTihOoqEIIWSHcUpwzTxMkX/3PjVIL65sDQxPs3sCltEfoo9xAj
         0kFe29GyFo2NLsmsGwno8z0kjSy6v7ANyipb5sahljWxV4ZkpxurnEhhyfC03SC++uSR
         XAzw==
X-Gm-Message-State: AOAM532Sc5+ydUVab1byLji7IBEzwgnxw6pcnKBnB+Tf7UQzF4RVA8Kh
        WQeZGQHNZPIonEUTzrlfbY/Gpg==
X-Google-Smtp-Source: ABdhPJwXMcCZlP5Kkr9nza6hs1MVIbRfcmO/qkUh289RARCj6//Yh8CBc1dSkuQ3pYpRJx8shz0O1w==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr64730043wru.158.1594218056983;
        Wed, 08 Jul 2020 07:20:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m16sm189119wro.0.2020.07.08.07.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:20:56 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] drm/tilcdc: Use standard drm_atomic_helper_commit
Date:   Wed,  8 Jul 2020 16:20:50 +0200
Message-Id: <20200708142050.530240-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707201229.472834-16-daniel.vetter@ffwll.ch>
References: <20200707201229.472834-16-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Gives us proper nonblocking support for free, and a pile of other
things. The tilcdc code is simply old enough that it was never
converted over, but was stuck forever with the copypasta from when it
was initially merged.

The riskiest thing with this conversion is maybe that there's an issue
with the vblank handling or vblank event handling, which will upset
the modern commit support in atomic helpers. But from a cursory review
drm_crtc_vblank_on/off is called in the right places, and the event
handling also seems to exist (albeit with much hand-rolling and
probably some races, could perhaps be converted over to
drm_crtc_arm_vblank_event without any real loss).

Motivated by me not having to hand-roll the dma-fence annotations for
this.

v2: Clear out crtc_state->event when we're handling the event, to
avoid upsetting the helpers (reported by Jyri).

v3: Also send out even whent the crtc is getting disabled. Tilcdc looks a
bit like conversion to simple display helpers would work out really
nice.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
--
From logs looks like we're not stuck when disabling the display, so I
hacked in a bit of code for that too. Like mentioned above, tilcdc
looks like a perfect candidate for simple display helpers, I think
that would simplify a _lot_ of code here.
-Daniel
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c  | 13 ++++++++
 drivers/gpu/drm/tilcdc/tilcdc_drv.c   | 47 +--------------------------
 drivers/gpu/drm/tilcdc/tilcdc_plane.c |  8 +++--
 3 files changed, 19 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index e9dd5e5cb4e7..1856962411c7 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -537,6 +537,18 @@ static void tilcdc_crtc_atomic_disable(struct drm_crtc *crtc,
 	tilcdc_crtc_disable(crtc);
 }
 
+static void tilcdc_crtc_atomic_flush(struct drm_crtc *crtc,
+				     struct drm_crtc_state *old_state)
+{
+	if (!crtc->state->event)
+		return;
+
+	spin_lock_irq(&crtc->dev->event_lock);
+	drm_crtc_send_vblank_event(crtc, crtc->state->event);
+	crtc->state->event = NULL;
+	spin_unlock_irq(&crtc->dev->event_lock);
+}
+
 void tilcdc_crtc_shutdown(struct drm_crtc *crtc)
 {
 	tilcdc_crtc_off(crtc, true);
@@ -822,6 +834,7 @@ static const struct drm_crtc_helper_funcs tilcdc_crtc_helper_funcs = {
 	.atomic_check	= tilcdc_crtc_atomic_check,
 	.atomic_enable	= tilcdc_crtc_atomic_enable,
 	.atomic_disable	= tilcdc_crtc_atomic_disable,
+	.atomic_flush	= tilcdc_crtc_atomic_flush,
 };
 
 void tilcdc_crtc_set_panel_info(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 0d74a6443263..4f5fc3e87383 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -87,55 +87,10 @@ static int tilcdc_atomic_check(struct drm_device *dev,
 	return ret;
 }
 
-static int tilcdc_commit(struct drm_device *dev,
-		  struct drm_atomic_state *state,
-		  bool async)
-{
-	int ret;
-
-	ret = drm_atomic_helper_prepare_planes(dev, state);
-	if (ret)
-		return ret;
-
-	ret = drm_atomic_helper_swap_state(state, true);
-	if (ret) {
-		drm_atomic_helper_cleanup_planes(dev, state);
-		return ret;
-	}
-
-	/*
-	 * Everything below can be run asynchronously without the need to grab
-	 * any modeset locks at all under one condition: It must be guaranteed
-	 * that the asynchronous work has either been cancelled (if the driver
-	 * supports it, which at least requires that the framebuffers get
-	 * cleaned up with drm_atomic_helper_cleanup_planes()) or completed
-	 * before the new state gets committed on the software side with
-	 * drm_atomic_helper_swap_state().
-	 *
-	 * This scheme allows new atomic state updates to be prepared and
-	 * checked in parallel to the asynchronous completion of the previous
-	 * update. Which is important since compositors need to figure out the
-	 * composition of the next frame right after having submitted the
-	 * current layout.
-	 */
-
-	drm_atomic_helper_commit_modeset_disables(dev, state);
-
-	drm_atomic_helper_commit_planes(dev, state, 0);
-
-	drm_atomic_helper_commit_modeset_enables(dev, state);
-
-	drm_atomic_helper_wait_for_vblanks(dev, state);
-
-	drm_atomic_helper_cleanup_planes(dev, state);
-
-	return 0;
-}
-
 static const struct drm_mode_config_funcs mode_config_funcs = {
 	.fb_create = drm_gem_fb_create,
 	.atomic_check = tilcdc_atomic_check,
-	.atomic_commit = tilcdc_commit,
+	.atomic_commit = drm_atomic_helper_commit,
 };
 
 static void modeset_init(struct drm_device *dev)
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_plane.c b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
index 0d09b31ae759..2f681a713815 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_plane.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
@@ -83,9 +83,11 @@ static void tilcdc_plane_atomic_update(struct drm_plane *plane,
 	if (WARN_ON(!state->fb || !state->crtc->state))
 		return;
 
-	tilcdc_crtc_update_fb(state->crtc,
-			      state->fb,
-			      state->crtc->state->event);
+	if (tilcdc_crtc_update_fb(state->crtc,
+				  state->fb,
+				  state->crtc->state->event) == 0) {
+		state->crtc->state->event = NULL;
+	}
 }
 
 static const struct drm_plane_helper_funcs plane_helper_funcs = {
-- 
2.27.0

