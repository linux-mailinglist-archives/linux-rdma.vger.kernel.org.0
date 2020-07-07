Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D163E2178C3
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgGGUNB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgGGUNA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:13:00 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F44C08C5DC
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:13:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so473609wmo.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7j8mgacEyozwm1WPaRaxgcPUZx0GeX2tcfd/ShNWJFU=;
        b=ivUu0QERHV+mzPbbu0k22gU9nEIQPE6zDSZF3Ml70xt9+GeTBIFI05sEsGiR5mEjpD
         L3oswsJTwOx5oLP4k/silGMZZJlwF/hdu8/vDJ8RRrjRaksLuQflFH5QLIVPRGEikHjt
         PLx1iYscrqxNjgoQ2zdIhQTW9oydXmtK284y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7j8mgacEyozwm1WPaRaxgcPUZx0GeX2tcfd/ShNWJFU=;
        b=rqt4/5fK4N63q8qUaIPWKuZoz+E5vvlOA1GLDAodYgJTOh157HnnbWwSzcyrXGShPB
         uWKu32TM8FCVuA4/ppgnFoFz+xgxa2tRNZhW5XS5f07n6+dxA6fXqJte4/raahPFx0na
         g/sYjXtMbMBQeKBKcc2FM3rSM8q4kANpUya7vmuHpRK2f9YkhaIoQzA9NybzjdZQ9mhn
         V78lekz05w5KMkoPFZAbsw+2sYPOwIOGKIDRgDbb0Ku2Jnv55w0CpX8dB5osTBUR/x6X
         lk8d+VlUY3AVqI5Le0SK/nja7lc9EerznL+HABfjzFJjYqYWhLpNxwA67GTc9BkldCEQ
         aetg==
X-Gm-Message-State: AOAM531I7g8aas9ouR+KzD+JN/LlwTO8HZCeTmq0BLj+bDVFY/xD+D5h
        Nf2TZVmiS6geSLg31yYh69jhAA==
X-Google-Smtp-Source: ABdhPJzOJJTuxoaWiMt7I2GriiW2xfr9u6BzNcL3JMkG+3RSZ9rHjuqdWeuvLwwOiNSfmz0qsJZ1lA==
X-Received: by 2002:a1c:2602:: with SMTP id m2mr6089251wmm.50.1594152779172;
        Tue, 07 Jul 2020 13:12:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:12:58 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/25] drm/tilcdc: Use standard drm_atomic_helper_commit
Date:   Tue,  7 Jul 2020 22:12:19 +0200
Message-Id: <20200707201229.472834-16-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
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

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 47 +----------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

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
-- 
2.27.0

