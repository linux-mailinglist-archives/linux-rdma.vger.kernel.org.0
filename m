Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197F921A01C
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2020 14:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGIMdy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jul 2020 08:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgGIMdx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jul 2020 08:33:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AC9C061A0B
        for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2020 05:33:53 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so1626847wmh.2
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2020 05:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3e+2hfQAEno550QSTUaHwqumwSkwkBzuWx2HdwXt2vk=;
        b=dcBagqjPL5oaA17pl8tDkIKyeu12QXbFJrtQGGLySAvLDY4xiergC2IYR6E1fpmf4p
         1WACZV3CMOEQku9V/ZRJ4sZLASuV3NVXphsb30Q+GUjzDBa8TFvBnMO71pd02lVOROXU
         YPnb5OTAQoA0wAe6EW+/BDiI3Gr7pzCuT6Vuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3e+2hfQAEno550QSTUaHwqumwSkwkBzuWx2HdwXt2vk=;
        b=WTMlpZKlyIWTjR3sEaNpiC4sT/9V7Bu+6ijFH2OWq/5+2sn/RXotdoJ9tk464Hf7qK
         GiFogKUMIA1M2nBHLVFptmkLjfNlgHaCUITAnqEyYC8ZzyJHSACrBk9wqPTyrMFyGSHH
         pezS+Pixw02fP2VgQ8lZ/s2Ku0cX6a7K+PE5bX8CbSOenupm7HkPq25b/gcZnHD7rFRh
         ZxYwO6+5gIQSrl0VXv+d2JEszOt5ZxeN2cnsDz666N3hny1RgwRRm15WRla8cuXB5qLr
         fTIh585ojYqgSPXH1FwV6IyY21jpxtHikyDrp8unI9PgZQHYz4c9DCrxCQ7tot6Z8Kwi
         D0Zw==
X-Gm-Message-State: AOAM533J+ck7S2i1Mbzb8Aqd8/LTk6qOXXNJZBNicw32SkXKhhhhNcxo
        IlZ5g17dlMX3Chmnp/gx+2bsaw==
X-Google-Smtp-Source: ABdhPJz0m548k8vvU6TSo8mQCX1rasisxK2aa1KJaJsuIt1AObEfDAw51itB4tLFY3QZ8k7xMQcj5w==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr13930700wmi.98.1594298032057;
        Thu, 09 Jul 2020 05:33:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o205sm4925347wme.24.2020.07.09.05.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 05:33:51 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 2/2] drm/virtio: Remove open-coded commit-tail function
Date:   Thu,  9 Jul 2020 14:33:39 +0200
Message-Id: <20200709123339.547390-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709123339.547390-1-daniel.vetter@ffwll.ch>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Exactly matches the one in the helpers.

This avoids me having to roll out dma-fence critical section
annotations to this copy.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index f3ce49c5a34c..af55b334be2f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -314,25 +314,6 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 	return &virtio_gpu_fb->base;
 }
 
-static void vgdev_atomic_commit_tail(struct drm_atomic_state *state)
-{
-	struct drm_device *dev = state->dev;
-
-	drm_atomic_helper_commit_modeset_disables(dev, state);
-	drm_atomic_helper_commit_modeset_enables(dev, state);
-	drm_atomic_helper_commit_planes(dev, state, 0);
-
-	drm_atomic_helper_fake_vblank(state);
-	drm_atomic_helper_commit_hw_done(state);
-
-	drm_atomic_helper_wait_for_vblanks(dev, state);
-	drm_atomic_helper_cleanup_planes(dev, state);
-}
-
-static const struct drm_mode_config_helper_funcs virtio_mode_config_helpers = {
-	.atomic_commit_tail = vgdev_atomic_commit_tail,
-};
-
 static const struct drm_mode_config_funcs virtio_gpu_mode_funcs = {
 	.fb_create = virtio_gpu_user_framebuffer_create,
 	.atomic_check = drm_atomic_helper_check,
@@ -346,7 +327,6 @@ void virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
 	drm_mode_config_init(vgdev->ddev);
 	vgdev->ddev->mode_config.quirk_addfb_prefer_host_byte_order = true;
 	vgdev->ddev->mode_config.funcs = &virtio_gpu_mode_funcs;
-	vgdev->ddev->mode_config.helper_private = &virtio_mode_config_helpers;
 
 	/* modes will be validated against the framebuffer size */
 	vgdev->ddev->mode_config.min_width = XRES_MIN;
-- 
2.27.0

