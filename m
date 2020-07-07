Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC272178AE
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgGGUMt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbgGGUMs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:12:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B91C061755
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:12:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so46563156wru.6
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGBGWvdQ7uikeFllACLNz+UTtRSJGowmgwCHMdSNNLo=;
        b=i4Wbb9D5vWR7ZvrtLwuYGSomQJsW13PdSzmWff3tCkJHGhMCGQ/HSW5yxVH79pV46L
         tGbdgX4hG3qDBztTT4nSZm/jRw+NGvkWAW3puj/5aI3ocSr0a9lVgHUIRWXjL5Q4bmcC
         ymy40QVqyUlP61mFf/kASiA4K6cTSnd36TinU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGBGWvdQ7uikeFllACLNz+UTtRSJGowmgwCHMdSNNLo=;
        b=hH4nOTIOAB8h3fCqw/43S9Ya+0wZqe5d6TfkTbYDn2AiLKpH3NJ0aOG9MyDLqsMWmE
         7g0iY9b4aa48RkqZDHBMI7Mp0QwwkreqzzqWRpv/POY+D5kp/a4RzdBc53hSk9LFMZXO
         92mRAfskq8p90+UDqBZliB7vFc9sZQ6enVzawWQFQ2dl/djin5JrE6lRPpNKNr5tjwdC
         BZjogwlsXVYWJfBxJJXPTm3jrTLY6wWMrJFd67tZQY5DIiF1ofWjqOXJfHby7XeC68Pd
         PS/XUKU+QIk1i271usHzRhEJS8vllcY1HrvTjO9djmoYeE+o8Hw/VHok3pHE6B/kn4LG
         ZzrA==
X-Gm-Message-State: AOAM533Erk2byukRJAzAAP63IYqjGYwlI8et0R28LXBJfOsZqXfaCfgW
        djRPZe85LqCusvF0mI1BAkVP0w==
X-Google-Smtp-Source: ABdhPJw3cwqPDCwSU2yLmYLAHgb/GZDKN9L46jfNXwWcxmwRn2v90lLr2GiOpy9wcdxv9hJWpyyOJQ==
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr56759235wrq.263.1594152765245;
        Tue, 07 Jul 2020 13:12:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:12:44 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jesse Natalie <jenatali@microsoft.com>,
        Steve Pronovost <spronovo@microsoft.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 03/25] dma-buf.rst: Document why idenfinite fences are a bad idea
Date:   Tue,  7 Jul 2020 22:12:07 +0200
Message-Id: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
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

Comes up every few years, gets somewhat tedious to discuss, let's
write this down once and for all.

What I'm not sure about is whether the text should be more explicit in
flat out mandating the amdkfd eviction fences for long running compute
workloads or workloads where userspace fencing is allowed.

v2: Now with dot graph!

Cc: Jesse Natalie <jenatali@microsoft.com>
Cc: Steve Pronovost <spronovo@microsoft.com>
Cc: Jason Ekstrand <jason@jlekstrand.net>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Mika Kuoppala <mika.kuoppala@intel.com>
Cc: Thomas Hellstrom <thomas.hellstrom@intel.com>
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
 Documentation/driver-api/dma-buf.rst     | 70 ++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_display.c | 20 -------
 2 files changed, 70 insertions(+), 20 deletions(-)

diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
index f8f6decde359..037ba0078bb4 100644
--- a/Documentation/driver-api/dma-buf.rst
+++ b/Documentation/driver-api/dma-buf.rst
@@ -178,3 +178,73 @@ DMA Fence uABI/Sync File
 .. kernel-doc:: include/linux/sync_file.h
    :internal:
 
+Idefinite DMA Fences
+~~~~~~~~~~~~~~~~~~~~
+
+At various times &dma_fence with an indefinite time until dma_fence_wait()
+finishes have been proposed. Examples include:
+
+* Future fences, used in HWC1 to signal when a buffer isn't used by the display
+  any longer, and created with the screen update that makes the buffer visible.
+  The time this fence completes is entirely under userspace's control.
+
+* Proxy fences, proposed to handle &drm_syncobj for which the fence has not yet
+  been set. Used to asynchronously delay command submission.
+
+* Userspace fences or gpu futexes, fine-grained locking within a command buffer
+  that userspace uses for synchronization across engines or with the CPU, which
+  are then imported as a DMA fence for integration into existing winsys
+  protocols.
+
+* Long-running compute command buffers, while still using traditional end of
+  batch DMA fences for memory management instead of context preemption DMA
+  fences which get reattached when the compute job is rescheduled.
+
+Common to all these schemes is that userspace controls the dependencies of these
+fences and controls when they fire. Mixing indefinite fences with normal
+in-kernel DMA fences does not work, even when a fallback timeout is included to
+protect against malicious userspace:
+
+* Only the kernel knows about all DMA fence dependencies, userspace is not aware
+  of dependencies injected due to memory management or scheduler decisions.
+
+* Only userspace knows about all dependencies in indefinite fences and when
+  exactly they will complete, the kernel has no visibility.
+
+Furthermore the kernel has to be able to hold up userspace command submission
+for memory management needs, which means we must support indefinite fences being
+dependent upon DMA fences. If the kernel also support indefinite fences in the
+kernel like a DMA fence, like any of the above proposal would, there is the
+potential for deadlocks.
+
+.. kernel-render:: DOT
+   :alt: Indefinite Fencing Dependency Cycle
+   :caption: Indefinite Fencing Dependency Cycle
+
+   digraph "Fencing Cycle" {
+      node [shape=box bgcolor=grey style=filled]
+      kernel [label="Kernel DMA Fences"]
+      userspace [label="userspace controlled fences"]
+      kernel -> userspace [label="memory management"]
+      userspace -> kernel [label="Future fence, fence proxy, ..."]
+
+      { rank=same; kernel userspace }
+   }
+
+This means that the kernel might accidentally create deadlocks
+through memory management dependencies which userspace is unaware of, which
+randomly hangs workloads until the timeout kicks in. Workloads, which from
+userspace's perspective, do not contain a deadlock.  In such a mixed fencing
+architecture there is no single entity with knowledge of all dependencies.
+Thefore preventing such deadlocks from within the kernel is not possible.
+
+The only solution to avoid dependencies loops is by not allowing indefinite
+fences in the kernel. This means:
+
+* No future fences, proxy fences or userspace fences imported as DMA fences,
+  with or without a timeout.
+
+* No DMA fences that signal end of batchbuffer for command submission where
+  userspace is allowed to use userspace fencing or long running compute
+  workloads. This also means no implicit fencing for shared buffers in these
+  cases.
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

