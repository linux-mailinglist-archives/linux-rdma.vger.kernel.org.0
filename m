Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79099296E60
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 14:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463590AbgJWMWc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 08:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463594AbgJWMWb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 08:22:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F316C0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 05:22:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c16so1298354wmd.2
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 05:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fkOMfIAhHnIvKJblgrObApVFyijBiqdZwYQpautVWE=;
        b=h2UcRa9UQoJClDthSwfwclF7bhL3oBVRME7c7/5zSRqhORAazkbgsGc4/vw6kIZtIK
         fhou2mbGdVANXK1CAFqIvL046sqBvxJGq5gDLkYCxZejl9o44OcJnB+RHw52tVnqbiHm
         JEDd6QHk5g7ytqeIZjF9fLUc3+7QOoDG7T1g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fkOMfIAhHnIvKJblgrObApVFyijBiqdZwYQpautVWE=;
        b=sWiGKDzZJmuHdWVU+jTOEGKXmSD2rGgeD2hZPrlmHJXpyHx/4eHR5lEnf+LfAYYyeI
         6J+M7sWZpLZ7ubTKRl+h8RFbXTh10TCMQv7glkKOQxKds/MWo6ixixOeW1Vj0zYcq1Bn
         hqnoqe/8Oo7FvRFtNyE78K3pg5DiC0ub0++orgDsY+MV0H7auIXxyyfiz5UoS/bwVSAs
         ef2TcWyW5aiGGHdJYSUgIm+7tFdS3+P5z2+V2KG6PZ144EgEeRcEM9UUnYLgjY43b/3h
         YNGDGcY4gQ8USENwQjnChbsTEhaqhb2l0Eoi64BDbzkK/ro5XlKs09cal1FUbjFi5RhU
         S1GA==
X-Gm-Message-State: AOAM533vbiXVv7Kskynz1i0W30edPDNdRqFg+Vls52BGvWpI6Yt5h5ZO
        vaMylu4TtEJ3+gGoWbr8SNwDjA==
X-Google-Smtp-Source: ABdhPJxH4xe48wzE/NSho9ypMHFrSsNZaDWF+abLcTHBzoHtv3gPf22+aRfQRDawp5z3s1pKd7nXCw==
X-Received: by 2002:a1c:4445:: with SMTP id r66mr2000497wma.140.1603455748879;
        Fri, 23 Oct 2020 05:22:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y4sm3056484wrp.74.2020.10.23.05.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 05:22:28 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 06/65] drm/vkms: Annotate vblank timer
Date:   Fri, 23 Oct 2020 14:21:17 +0200
Message-Id: <20201023122216.2373294-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023122216.2373294-1-daniel.vetter@ffwll.ch>
References: <20201021163242.1458885-1-daniel.vetter@ffwll.ch>
 <20201023122216.2373294-1-daniel.vetter@ffwll.ch>
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
index e43e4e1b268a..8124d8f2ee15 100644
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
2.28.0

