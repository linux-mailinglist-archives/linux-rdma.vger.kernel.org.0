Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9422178BD
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgGGUM6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbgGGUM5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:12:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBEFC08C5DC
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:12:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so24324782wrp.2
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pt65zP3tlEuv8TvdEB6rXZKaCDTrRKjurzMHDo80+l4=;
        b=ECzcjwmTm3AborwU40haIL5DfGUbNaGnjl4KrnQruJIqmKFPCtJbIcfPTulkN3oSNO
         LeoytZCXEcdrNk/HBVLRNvsvpRSnu2zo4n5M8SWqzSYXPQ57n9jIZATJmEY1VIUw2fNP
         3raRyIXFs8+1WpAOpUHm9CDrANOWWyeYyfNdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pt65zP3tlEuv8TvdEB6rXZKaCDTrRKjurzMHDo80+l4=;
        b=kA7Sq3akWy+6h0XwNlzKiHrj88NKZ7ZkLzLa9JrjMrE/Hc0vmg8hcveigskp2cjTAj
         5LFrgJS0X7/enK0jJyKKUV4clEnsL8bMImyCwUQ95H4g+JhoJDYLZ42Ou6q9lZbAEw1C
         69ZB2oik61kZssBIdipzbCqjMwORM3YmNCDZlVS/I1XAOD2lP+8t4j+6C7S9ZziSYe0+
         xCmtpMoBD+jll0C5xFTlHbD9fKmGj57R4T+xct103GE4vxQvMRKscouFNCE5UkIm+8Xr
         Y8lYUIQyYpxJ7jQ3FfW4egJYWXOU6Rv4jw1TtuIROFPoJHUeYYl03FJHKd/aG/i8LxBJ
         intw==
X-Gm-Message-State: AOAM532D0pHNCWttRDYLgVR+ALUAtAzjDvjEniroq7Hune7qTovkuJjH
        olmVdFQw0IdPhoQaTDc3D7G/Sg==
X-Google-Smtp-Source: ABdhPJxKgmysUU/h7rSk9LS5o1iZmQTnbNWz1lWZoVAw8JPRoDOBpIt/L+K29HI41t8AbVdqITvtgg==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr56007824wrv.177.1594152775024;
        Tue, 07 Jul 2020 13:12:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:12:54 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/25] drm/omapdrm: Annotate dma-fence critical section in commit path
Date:   Tue,  7 Jul 2020 22:12:15 +0200
Message-Id: <20200707201229.472834-12-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Nothing special, just put the end right after hw_done(). Note that in
one path there's a wait for the flip/update to complete. But as far as
I understand from comments and code that's only relevant for modesets,
and skipped if there wasn't a modeset done on a given crtc.

For a bit more clarity pull the hw_done() call out of the if/else,
that way it's a bit clearer flow. But happy to shuffle this around as
is seen fit.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 4526967978b7..aa3a8034d0ea 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -68,6 +68,7 @@ static void omap_atomic_commit_tail(struct drm_atomic_state *old_state)
 {
 	struct drm_device *dev = old_state->dev;
 	struct omap_drm_private *priv = dev->dev_private;
+	bool fence_cookie = dma_fence_begin_signalling();
 
 	priv->dispc_ops->runtime_get(priv->dispc);
 
@@ -90,8 +91,6 @@ static void omap_atomic_commit_tail(struct drm_atomic_state *old_state)
 		omap_atomic_wait_for_completion(dev, old_state);
 
 		drm_atomic_helper_commit_planes(dev, old_state, 0);
-
-		drm_atomic_helper_commit_hw_done(old_state);
 	} else {
 		/*
 		 * OMAP3 DSS seems to have issues with the work-around above,
@@ -101,10 +100,12 @@ static void omap_atomic_commit_tail(struct drm_atomic_state *old_state)
 		drm_atomic_helper_commit_planes(dev, old_state, 0);
 
 		drm_atomic_helper_commit_modeset_enables(dev, old_state);
-
-		drm_atomic_helper_commit_hw_done(old_state);
 	}
 
+	drm_atomic_helper_commit_hw_done(old_state);
+
+	dma_fence_end_signalling(fence_cookie);
+
 	/*
 	 * Wait for completion of the page flips to ensure that old buffers
 	 * can't be touched by the hardware anymore before cleaning up planes.
-- 
2.27.0

