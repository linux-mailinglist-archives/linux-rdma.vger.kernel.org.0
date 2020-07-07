Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DC82178BC
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgGGUMy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbgGGUMx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:12:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84089C061755
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:12:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so473266wmo.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47ry8zzJFpkbfzhaSz9dhVhLH4swSU+s2K6Km6oEVI4=;
        b=EkliKi78Cxcl4ZAllF+yKDmH5E9JQGpVZmBIOkBrQvMdM9LUHNaP9GKLQdO77Lb39L
         GyBkGsTjZ0pHswhSbz9s50PvwzL72e/qMWjhFUvQ04RwgzfPZYMnpEFdcwxHVuzK5WwE
         Ewx2qS/aZTwAf4YCyL66MrgWIqZDYDYwHB82c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47ry8zzJFpkbfzhaSz9dhVhLH4swSU+s2K6Km6oEVI4=;
        b=flOFjruYIBeQJ53TrF4zKhmIYVeu9fKCNLjnHGmvBNFiw5u59sMh7cHWZve+T2mZzw
         +B1D98hAfnmBounwY8wjQvmb+mKHB7KJ2GdlEcge8g9J5Zk5Ws1zyLxNpPQWk9XGlBm2
         LnwP2PCYV2DeB83/RGIOOBRNP+NSoFJyypWYFbupFgOy39rBs+Ut4UTQviJSpU2yKdMQ
         /0l87pnj6s/7gbWp87U/195OTFWAeUw9txQjOYKNsujqQh23AHshQYjHzpTchXRJeWZP
         l4a0iMMYYYrWiAf/eJToLgGZg/l14SSzA7BSdOCAwQO4UzpO4uP2SG+SDMxASYGgXc9O
         lIfw==
X-Gm-Message-State: AOAM533bno3AO5e80nOHLedumE4FmUOEoqFSthWA1uDJ7ydt1TerJX5t
        /7wX2aHKo8E45STyMSZ0rvpm3g==
X-Google-Smtp-Source: ABdhPJxUjiOp/tGPiSxUOs2dJFh+N2PZSymkScgMscfuWIvlTUg/OsYH+ykwrEw2mMDdVf+mxSmsNg==
X-Received: by 2002:a1c:6384:: with SMTP id x126mr6067851wmb.144.1594152772232;
        Tue, 07 Jul 2020 13:12:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:12:51 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/25] drm/atmel: Use drm_atomic_helper_commit
Date:   Tue,  7 Jul 2020 22:12:13 +0200
Message-Id: <20200707201229.472834-10-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

One of these drivers that predates the nonblocking support in helpers,
and hand-rolled its own thing. Entirely not anything specific here, we
can just delete it all and replace it with the helper version.

Could also perhaps use the drm_mode_config_helper_suspend/resume
stuff, for another few lines deleted. But I'm not looking at that
stuff, I'm just going through all the atomic commit functions and make
sure they have properly annotated dma-fence critical sections
everywhere.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 96 +-------------------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h |  4 -
 2 files changed, 1 insertion(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 871293d1aeeb..9ec156e98f06 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -557,103 +557,10 @@ static irqreturn_t atmel_hlcdc_dc_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-struct atmel_hlcdc_dc_commit {
-	struct work_struct work;
-	struct drm_device *dev;
-	struct drm_atomic_state *state;
-};
-
-static void
-atmel_hlcdc_dc_atomic_complete(struct atmel_hlcdc_dc_commit *commit)
-{
-	struct drm_device *dev = commit->dev;
-	struct atmel_hlcdc_dc *dc = dev->dev_private;
-	struct drm_atomic_state *old_state = commit->state;
-
-	/* Apply the atomic update. */
-	drm_atomic_helper_commit_modeset_disables(dev, old_state);
-	drm_atomic_helper_commit_planes(dev, old_state, 0);
-	drm_atomic_helper_commit_modeset_enables(dev, old_state);
-
-	drm_atomic_helper_wait_for_vblanks(dev, old_state);
-
-	drm_atomic_helper_cleanup_planes(dev, old_state);
-
-	drm_atomic_state_put(old_state);
-
-	/* Complete the commit, wake up any waiter. */
-	spin_lock(&dc->commit.wait.lock);
-	dc->commit.pending = false;
-	wake_up_all_locked(&dc->commit.wait);
-	spin_unlock(&dc->commit.wait.lock);
-
-	kfree(commit);
-}
-
-static void atmel_hlcdc_dc_atomic_work(struct work_struct *work)
-{
-	struct atmel_hlcdc_dc_commit *commit =
-		container_of(work, struct atmel_hlcdc_dc_commit, work);
-
-	atmel_hlcdc_dc_atomic_complete(commit);
-}
-
-static int atmel_hlcdc_dc_atomic_commit(struct drm_device *dev,
-					struct drm_atomic_state *state,
-					bool async)
-{
-	struct atmel_hlcdc_dc *dc = dev->dev_private;
-	struct atmel_hlcdc_dc_commit *commit;
-	int ret;
-
-	ret = drm_atomic_helper_prepare_planes(dev, state);
-	if (ret)
-		return ret;
-
-	/* Allocate the commit object. */
-	commit = kzalloc(sizeof(*commit), GFP_KERNEL);
-	if (!commit) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	INIT_WORK(&commit->work, atmel_hlcdc_dc_atomic_work);
-	commit->dev = dev;
-	commit->state = state;
-
-	spin_lock(&dc->commit.wait.lock);
-	ret = wait_event_interruptible_locked(dc->commit.wait,
-					      !dc->commit.pending);
-	if (ret == 0)
-		dc->commit.pending = true;
-	spin_unlock(&dc->commit.wait.lock);
-
-	if (ret)
-		goto err_free;
-
-	/* We have our own synchronization through the commit lock. */
-	BUG_ON(drm_atomic_helper_swap_state(state, false) < 0);
-
-	/* Swap state succeeded, this is the point of no return. */
-	drm_atomic_state_get(state);
-	if (async)
-		queue_work(dc->wq, &commit->work);
-	else
-		atmel_hlcdc_dc_atomic_complete(commit);
-
-	return 0;
-
-err_free:
-	kfree(commit);
-error:
-	drm_atomic_helper_cleanup_planes(dev, state);
-	return ret;
-}
-
 static const struct drm_mode_config_funcs mode_config_funcs = {
 	.fb_create = drm_gem_fb_create,
 	.atomic_check = drm_atomic_helper_check,
-	.atomic_commit = atmel_hlcdc_dc_atomic_commit,
+	.atomic_commit = drm_atomic_helper_commit,
 };
 
 static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
@@ -716,7 +623,6 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 	if (!dc->wq)
 		return -ENOMEM;
 
-	init_waitqueue_head(&dc->commit.wait);
 	dc->desc = match->data;
 	dc->hlcdc = dev_get_drvdata(dev->dev->parent);
 	dev->dev_private = dc;
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 469d4507e576..9367a3747a3a 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -346,10 +346,6 @@ struct atmel_hlcdc_dc {
 		u32 imr;
 		struct drm_atomic_state *state;
 	} suspend;
-	struct {
-		wait_queue_head_t wait;
-		bool pending;
-	} commit;
 };
 
 extern struct atmel_hlcdc_formats atmel_hlcdc_plane_rgb_formats;
-- 
2.27.0

