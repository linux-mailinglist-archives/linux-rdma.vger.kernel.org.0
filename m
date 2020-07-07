Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A8A2178B2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgGGUMu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbgGGUMt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:12:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC4EC061755
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:12:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so468020wmj.2
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=McVPt9fJuC6YkxvBQy2jGA4bv0ebGunC4HyUvWhZjbk=;
        b=NYza4RHRT9Nbd5tiuaDvvt87+k7x8TzYBK9/QEGb9/Is2lgqJSOuJN6F8FSSMmLVNz
         AX9kEZIMyNmgI+JilF+jEH3k9RERK+pVA/s56lFytmeok7MwNFT8h3+RidSiuyF0GL3K
         QytzewPz12OhJLJsGQP0sEMa2ZvTYapQq+Oos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=McVPt9fJuC6YkxvBQy2jGA4bv0ebGunC4HyUvWhZjbk=;
        b=fSky/i/ZbTftxfB3XEw4VypFl7KaqY30jH5mGl8VbFjUql2yoqh0Wsh4v2KaZlok09
         V9G3lYXHUoNIUGC2KisKSwx7c3iUItsI1SjRogcim7dCpbc++xSwqHnkikECXOulTwEW
         cgnH9EwqOuJrebDFXBKsyafXZOdsbLb1BnYRUA3/dJ2RfhqjSOx25HQGMaDe0PED867G
         A2vxY4w3BoNjm0HeezfKfMBCAoDQj7fpE5OtrT6Bh+y48m9K2tnoQ519b6XRFkt2g3r/
         Pshb3/Kx6nmtwp6ye1DwVjuVHHQykmXYlstgTZDE4x26e+oaQzcDUc6bdqv+CMnzrWeq
         W01A==
X-Gm-Message-State: AOAM531Xi2fRj8q25XGNos01LEyaqVeXt/441NXGfZbrHSr724TKw037
        oMse2XEosPgoVpFr5IESR6kKxQ==
X-Google-Smtp-Source: ABdhPJxvv8IOS1X24OSEZRVe7u0HCChwY1utohnpU4U1V2xvfRe6hswS0LJw8ponIMP4FVWNOp1Snw==
X-Received: by 2002:a7b:c10c:: with SMTP id w12mr5788472wmi.87.1594152767816;
        Tue, 07 Jul 2020 13:12:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:12:47 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 05/25] drm/vblank: Annotate with dma-fence signalling section
Date:   Tue,  7 Jul 2020 22:12:09 +0200
Message-Id: <20200707201229.472834-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is rather overkill since currently all drivers call this from
hardirq (or at least timers). But maybe in the future we're going to
have thread irq handlers and what not, doesn't hurt to be prepared.
Plus this is an easy start for sprinkling these fence annotations into
shared code.

Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-rdma@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/gpu/drm/drm_vblank.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 42a84eb4cc8c..d681ab09963c 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -24,6 +24,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/dma-fence.h>
 #include <linux/export.h>
 #include <linux/moduleparam.h>
 
@@ -1909,7 +1910,7 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 {
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 	unsigned long irqflags;
-	bool disable_irq;
+	bool disable_irq, fence_cookie;
 
 	if (drm_WARN_ON_ONCE(dev, !drm_dev_has_vblank(dev)))
 		return false;
@@ -1917,6 +1918,8 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
 		return false;
 
+	fence_cookie = dma_fence_begin_signalling();
+
 	spin_lock_irqsave(&dev->event_lock, irqflags);
 
 	/* Need timestamp lock to prevent concurrent execution with
@@ -1929,6 +1932,7 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 	if (!vblank->enabled) {
 		spin_unlock(&dev->vblank_time_lock);
 		spin_unlock_irqrestore(&dev->event_lock, irqflags);
+		dma_fence_end_signalling(fence_cookie);
 		return false;
 	}
 
@@ -1954,6 +1958,8 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 	if (disable_irq)
 		vblank_disable_fn(&vblank->disable_timer);
 
+	dma_fence_end_signalling(fence_cookie);
+
 	return true;
 }
 EXPORT_SYMBOL(drm_handle_vblank);
-- 
2.27.0

