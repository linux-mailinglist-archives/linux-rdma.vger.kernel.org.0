Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5542C2FEED9
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 16:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbhAUPbp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 10:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733007AbhAUPbe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 10:31:34 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7044C06178C
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 07:30:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l12so2165929wry.2
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 07:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cO1IkKPUOVwRn1crpsdxPu7FkoF7p+ucW3GbJhM3e14=;
        b=jhC25ghF/XaqC35+yLTxVb7Wu3JLRJXw2J2hDlMlBegM1HgvqArOVwueF+WlNe1LK0
         iAxoO75LoZrCTVQkpHH8oySG5WCiFgXObeuTlNMlP86RWNc969Ycv/BYdMOvA8ZurmTu
         IPauh1ssYJZERfONi1YMonwWMecl3j/Y7Jjz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cO1IkKPUOVwRn1crpsdxPu7FkoF7p+ucW3GbJhM3e14=;
        b=PvAgx9f3iZIf+kRTUfp9fosq47t4gHz+DC5fLZpRcweej81rOIHqDeCpH0A7PjpcbE
         3Ja89oXaoCHRfT+2wlsL4gUpFSvXN49FOdYFlPDZW52sbpG903Wk6Od1TgY+9apUZ8Db
         xmifxa1IgmnXGFtUxBom33EwHQ0WQFA6vhTCQWlnL7Gw72u6UtL807djCzMGQG+kmr6D
         t4mdh2Uj8KqaIBXN4zLZsnx02aPQaJxVIZ+mKW0en9IxBkSRUgmePaPBFGa52sqygynR
         MWL1SuIDq4fAxNxpNn+8nh7kuHZvVwjkl9+JqpUkcb/+scOcyX09LZ2Uecq2g9g6F3x3
         MisQ==
X-Gm-Message-State: AOAM531gXqhZ9+xhY4CG7syDlUwlxgXKb2eJJhiEmqWQfNyOsPdmGclP
        atMmV3yAC5VLSMLJjFQS8g+Q8Q==
X-Google-Smtp-Source: ABdhPJzW179r+95gTC9AApAezahGncz7nZxmZZU6SylexVR2TnthZyEScn1yu5DpB9svGDcS52Nyxg==
X-Received: by 2002:a5d:49c1:: with SMTP id t1mr33276wrs.56.1611243007580;
        Thu, 21 Jan 2021 07:30:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f14sm8269866wre.69.2021.01.21.07.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 07:30:06 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 02/11] drm/vkms: Annotate vblank timer
Date:   Thu, 21 Jan 2021 16:29:50 +0100
Message-Id: <20210121152959.1725404-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121152959.1725404-1-daniel.vetter@ffwll.ch>
References: <20210121152959.1725404-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is needed to signal the fences from page flips, annotate it
accordingly. We need to annotate entire timer callback since if we get
stuck anywhere in there, then the timer stops, and hence fences stop.
Just annotating the top part that does the vblank handling isn't
enough.

Tested-by: Melissa Wen <melissa.srw@gmail.com>
Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-rdma@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 0443b7deeaef..6164349cdf11 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <linux/dma-fence.h>
+
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
@@ -14,7 +16,9 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 	struct drm_crtc *crtc = &output->crtc;
 	struct vkms_crtc_state *state;
 	u64 ret_overrun;
-	bool ret;
+	bool ret, fence_cookie;
+
+	fence_cookie = dma_fence_begin_signalling();
 
 	ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
 					  output->period_ns);
@@ -49,6 +53,8 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 			DRM_DEBUG_DRIVER("Composer worker already queued\n");
 	}
 
+	dma_fence_end_signalling(fence_cookie);
+
 	return HRTIMER_RESTART;
 }
 
-- 
2.30.0

