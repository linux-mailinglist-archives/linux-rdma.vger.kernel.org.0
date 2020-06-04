Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0DC1EDF85
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2020 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgFDIMm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jun 2020 04:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgFDIMl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jun 2020 04:12:41 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9938C08C5C4
        for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2020 01:12:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f5so4624240wmh.2
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jun 2020 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z86jDMPjYosEVmpvz8g87itNg+tEFmiX7DLzwmjjruY=;
        b=IqxGBAw7Ux8mFxKbZqFfhWHBvUThVxHGPJeIMG6V8JAySneDzg1MMfr9dhIgUYw2Fn
         OTAZ0xbCrYCL4eXPkPqfd9hDPavzifvRAdCmfeUmSdOIDkGg1FY43BlyAFoqsAL1182F
         slvaQBsul976QOmZFtX03fE52IJl/0XI4phXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z86jDMPjYosEVmpvz8g87itNg+tEFmiX7DLzwmjjruY=;
        b=NC5wYNTz2/amkfWzfkM2wl455uzeBtBYXKpcZkVJ1+1e6CUwD+kvFb9v/3boey50rw
         jHeeSHsWf+TWdWVo0OYgNx8fzcilajvB/7/NA5XKk2Qz27p6nyYIWCd0TtNbmHpooBkE
         UXWe6jfK3NFOwd6rbAaGLnVt6IUl5mbSvcEjQRM/PWtR9f6BHJOk+U2K70W7t4qxYerX
         qkRImvGfO7Hfn43ll459v8ho3qDIC1N5PFPG2113WEVfv7ho1HLT3g5gvnZkBZnW0Yu4
         Ss0bt7KXFg7QxUzO/AX5FiE+sEdPpqBULCAyAbLHaUGB6xIHSf7hPgaDeBDw1opYZ5te
         8icg==
X-Gm-Message-State: AOAM532dOBHWdnZ3wUwU7y0Ls60AnmXpWu4s7iobz3WlGD/gRNjhFj2a
        JPJw+MNTV5OwIMqlxP+t5JlTdg==
X-Google-Smtp-Source: ABdhPJyKQbuv5baACXqVPivWSRwfBW+Y73i/xXeG533ND6BCj6YxPKujbnsSL0XPuqc9zCvklUc7sg==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr3041108wmj.121.1591258358519;
        Thu, 04 Jun 2020 01:12:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:12:37 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 05/18] drm/vkms: Annotate vblank timer
Date:   Thu,  4 Jun 2020 10:12:11 +0200
Message-Id: <20200604081224.863494-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is needed to signal the fences from page flips, annotate it
accordingly. We need to annotate entire timer callback since if we get
stuck anywhere in there, then the timer stops, and hence fences stop.
Just annotating the top part that does the vblank handling isn't
enough.

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
index ac85e17428f8..a53a40848a72 100644
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
2.26.2

