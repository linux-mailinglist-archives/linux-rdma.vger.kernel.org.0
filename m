Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F761CF091
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 11:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgELJBJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 05:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729352AbgELJAD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 05:00:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A4FC061A0F
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 02:00:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l17so793379wrr.4
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k3OodW5bIt6jtahEoyPvdqvd8L7bfSaZtDSgdgQ0KSE=;
        b=Tba/CBQcoFuTPwNcOK0uHe+q5z5Fq6i1EP5lEPO6yQnGb0xZi3OTwd+ZAJUMrRox80
         JQxMbr1Hy5zgQtio1imHYMaQf8uOuY/D0v6qpXbtodzS2aPiBGDFHO2m+fo/NUnJQtIa
         9QatpvOy7g08efja4D6G7OF9WYNAibebHkhiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k3OodW5bIt6jtahEoyPvdqvd8L7bfSaZtDSgdgQ0KSE=;
        b=rkEWY9oWRmBB9BfyAapqdWVBIzJrdxSbDbFB2X8GbgoVg/t+GeJZFZ19Rm4OkL50YP
         FvUTeMbO/gfpJopsEI3pnb2YbMg3mK8c3XoWywvL6YXJi81hv1uTCu4We/W7CTM852z1
         0yAs5eaEFqy2gLS2liCsXGveFOO5NF6Gc8d64fZrQc/4iYcEcBh3AtNgsXDWpPmvfEXl
         o3hqnW8j2fyk1/vLeRZ81laSoZO7Yk1sbba7NJW4/63mOwhGSs3rtKMQrR3awDj0/KB2
         IQLRryDW3Z4CFz3tg5YY9KSUfIVgQzoBCD9tKkf3UIGOH/eH8FPz0UYYG2IYSl3poa4I
         f5sQ==
X-Gm-Message-State: AGi0Puao2BFw6qCXvw3OGixTjDT08SYb0jR/w3L4Ul9tnYn6/rIxk0d+
        6vPjgbRTjdowbeg8s3Ukqz4SBQ==
X-Google-Smtp-Source: APiQypLIE0/1kWTahFNGDnQcsBGsaNy02ojJZXXlJ0KfLdzMgemSxmLWkBaf5jP2NOQfTl/RTuSVRw==
X-Received: by 2002:adf:ca0e:: with SMTP id o14mr25265512wrh.254.1589274001957;
        Tue, 12 May 2020 02:00:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y10sm18845457wrd.95.2020.05.12.02.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 02:00:01 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [RFC 05/17] drm/vblank: Annotate with dma-fence signalling section
Date:   Tue, 12 May 2020 10:59:32 +0200
Message-Id: <20200512085944.222637-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
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
index 758bf74e1cab..125ef0c0f9a1 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -24,6 +24,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/dma-fence.h>
 #include <linux/export.h>
 #include <linux/moduleparam.h>
 
@@ -1895,7 +1896,7 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 {
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 	unsigned long irqflags;
-	bool disable_irq;
+	bool disable_irq, fence_cookie;
 
 	if (WARN_ON_ONCE(!dev->num_crtcs))
 		return false;
@@ -1903,6 +1904,8 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 	if (WARN_ON(pipe >= dev->num_crtcs))
 		return false;
 
+	fence_cookie = dma_fence_begin_signalling();
+
 	spin_lock_irqsave(&dev->event_lock, irqflags);
 
 	/* Need timestamp lock to prevent concurrent execution with
@@ -1915,6 +1918,7 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 	if (!vblank->enabled) {
 		spin_unlock(&dev->vblank_time_lock);
 		spin_unlock_irqrestore(&dev->event_lock, irqflags);
+		dma_fence_end_signalling(fence_cookie);
 		return false;
 	}
 
@@ -1940,6 +1944,8 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 	if (disable_irq)
 		vblank_disable_fn(&vblank->disable_timer);
 
+	dma_fence_end_signalling(fence_cookie);
+
 	return true;
 }
 EXPORT_SYMBOL(drm_handle_vblank);
-- 
2.26.2

