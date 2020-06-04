Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537541EDF8B
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2020 10:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgFDIOH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jun 2020 04:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgFDIMi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jun 2020 04:12:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8A4C03E97D
        for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2020 01:12:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q25so4635128wmj.0
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jun 2020 01:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iX8yvgIySAam94sgW57RQXUmTB7Ou3XcFF4UUEubWkk=;
        b=ZCDuFtoO+JO6z1AsWRdVcfb4gkFPZIWpzbyZoQgItzGv+2X9uOvWQIfJl2CXVLRyS7
         jmrwsv7OJneJtVtuGdLOTI+9nAN12c7tfvxEoB5QUeVSsKzLICOoE2KZwOuoG0NrxtB0
         Y5WBOXg98M8mm1tRfoWbjuaEkFXGTwncTzP4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iX8yvgIySAam94sgW57RQXUmTB7Ou3XcFF4UUEubWkk=;
        b=EaOO7hUCwhExOBtqVkGaZx+9gR1VvVH+yjWJVPQ4q4qvFBZB2QmqegEZdIcLMZ4mMd
         eRTc7qaxus9T7ZnoUGlcKwQdDmQLMjox+gVa6M6xH35IB6D76IRCYd+v2EeS5eaLKluc
         tiSNd1L/3Ku2e6WgrcagxFugI+/wpVdArTbzh5SrpNcoQ/uUEdv82ZrJx9ZVajzOEpBO
         rPVG366aE4GB9uJwa8DHQ/sXvN0J408Klurxz0ffTqYtkCMaYtTkFEpd76dleZCUWr0e
         VAyI8p6yYy2e3iQAudvojOlPuus3thLNkNx0wH04s3XEL31U4OfPC/YBbf9IJ9wWgyxA
         q71A==
X-Gm-Message-State: AOAM531S6/UBgEN3bCdJ+0KKq8fmLjDguhX6Owm6uw2sRQew7N6pRoIG
        EcoLQwKK2j/KqhFAXRYlL4kpRA==
X-Google-Smtp-Source: ABdhPJxE++sNFKLfONHraOPjYXQYwoR5UNfEopf+/1eDf4bACkMBIaDiWDCJt9Y4c08FHgIuU/EGmg==
X-Received: by 2002:a7b:c145:: with SMTP id z5mr3006166wmi.6.1591258357250;
        Thu, 04 Jun 2020 01:12:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:12:36 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 04/18] dma-fence: prime lockdep annotations
Date:   Thu,  4 Jun 2020 10:12:10 +0200
Message-Id: <20200604081224.863494-5-daniel.vetter@ffwll.ch>
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

Two in one go:
- it is allowed to call dma_fence_wait() while holding a
  dma_resv_lock(). This is fundamental to how eviction works with ttm,
  so required.

- it is allowed to call dma_fence_wait() from memory reclaim contexts,
  specifically from shrinker callbacks (which i915 does), and from mmu
  notifier callbacks (which amdgpu does, and which i915 sometimes also
  does, and probably always should, but that's kinda a debate). Also
  for stuff like HMM we really need to be able to do this, or things
  get real dicey.

Consequence is that any critical path necessary to get to a
dma_fence_signal for a fence must never a) call dma_resv_lock nor b)
allocate memory with GFP_KERNEL. Also by implication of
dma_resv_lock(), no userspace faulting allowed. That's some supremely
obnoxious limitations, which is why we need to sprinkle the right
annotations to all relevant paths.

The one big locking context we're leaving out here is mmu notifiers,
added in

commit 23b68395c7c78a764e8963fc15a7cfd318bf187f
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon Aug 26 22:14:21 2019 +0200

    mm/mmu_notifiers: add a lockdep map for invalidate_range_start/end

that one covers a lot of other callsites, and it's also allowed to
wait on dma-fences from mmu notifiers. But there's no ready-made
functions exposed to prime this, so I've left it out for now.

v2: Also track against mmu notifier context.

v3: kerneldoc to spec the cross-driver contract. Note that currently
i915 throws in a hard-coded 10s timeout on foreign fences (not sure
why that was done, but it's there), which is why that rule is worded
with SHOULD instead of MUST.

Also some of the mmu_notifier/shrinker rules might surprise SoC
drivers, I haven't fully audited them all. Which is infeasible anyway,
we'll need to run them with lockdep and dma-fence annotations and see
what goes boom.

v4: A spelling fix from Mika

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
 Documentation/driver-api/dma-buf.rst |  6 ++++
 drivers/dma-buf/dma-fence.c          | 41 ++++++++++++++++++++++++++++
 drivers/dma-buf/dma-resv.c           |  4 +++
 include/linux/dma-fence.h            |  1 +
 4 files changed, 52 insertions(+)

diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
index 05d856131140..f8f6decde359 100644
--- a/Documentation/driver-api/dma-buf.rst
+++ b/Documentation/driver-api/dma-buf.rst
@@ -133,6 +133,12 @@ DMA Fences
 .. kernel-doc:: drivers/dma-buf/dma-fence.c
    :doc: DMA fences overview
 
+DMA Fence Cross-Driver Contract
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: drivers/dma-buf/dma-fence.c
+   :doc: fence cross-driver contract
+
 DMA Fence Signalling Annotations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 0005bc002529..754e6fb84fb7 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -64,6 +64,47 @@ static atomic64_t dma_fence_context_counter = ATOMIC64_INIT(1);
  *   &dma_buf.resv pointer.
  */
 
+/**
+ * DOC: fence cross-driver contract
+ *
+ * Since &dma_fence provide a cross driver contract, all drivers must follow the
+ * same rules:
+ *
+ * * Fences must complete in a reasonable time. Fences which represent kernels
+ *   and shaders submitted by userspace, which could run forever, must be backed
+ *   up by timeout and gpu hang recovery code. Minimally that code must prevent
+ *   further command submission and force complete all in-flight fences, e.g.
+ *   when the driver or hardware do not support gpu reset, or if the gpu reset
+ *   failed for some reason. Ideally the driver supports gpu recovery which only
+ *   affects the offending userspace context, and no other userspace
+ *   submissions.
+ *
+ * * Drivers may have different ideas of what completion within a reasonable
+ *   time means. Some hang recovery code uses a fixed timeout, others a mix
+ *   between observing forward progress and increasingly strict timeouts.
+ *   Drivers should not try to second guess timeout handling of fences from
+ *   other drivers.
+ *
+ * * To ensure there's no deadlocks of dma_fence_wait() against other locks
+ *   drivers should annotate all code required to reach dma_fence_signal(),
+ *   which completes the fences, with dma_fence_begin_signalling() and
+ *   dma_fence_end_signalling().
+ *
+ * * Drivers are allowed to call dma_fence_wait() while holding dma_resv_lock().
+ *   This means any code required for fence completion cannot acquire a
+ *   &dma_resv lock. Note that this also pulls in the entire established
+ *   locking hierarchy around dma_resv_lock() and dma_resv_unlock().
+ *
+ * * Drivers are allowed to call dma_fence_wait() from their &shrinker
+ *   callbacks. This means any code required for fence completion cannot
+ *   allocate memory with GFP_KERNEL.
+ *
+ * * Drivers are allowed to call dma_fence_wait() from their &mmu_notifier
+ *   respectively &mmu_interval_notifier callbacks. This means any code required
+ *   for fence completeion cannot allocate memory with GFP_NOFS or GFP_NOIO.
+ *   Only GFP_ATOMIC is permissible, which might fail.
+ */
+
 static const char *dma_fence_stub_get_name(struct dma_fence *fence)
 {
         return "stub";
diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 99c0a33c918d..c223f32425c4 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -35,6 +35,7 @@
 #include <linux/dma-resv.h>
 #include <linux/export.h>
 #include <linux/sched/mm.h>
+#include <linux/mmu_notifier.h>
 
 /**
  * DOC: Reservation Object Overview
@@ -115,6 +116,9 @@ static int __init dma_resv_lockdep(void)
 	if (ret == -EDEADLK)
 		dma_resv_lock_slow(&obj, &ctx);
 	fs_reclaim_acquire(GFP_KERNEL);
+	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
+	__dma_fence_might_wait();
+	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 	fs_reclaim_release(GFP_KERNEL);
 	ww_mutex_unlock(&obj.lock);
 	ww_acquire_fini(&ctx);
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 3f288f7db2ef..09e23adb351d 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -360,6 +360,7 @@ dma_fence_get_rcu_safe(struct dma_fence __rcu **fencep)
 #ifdef CONFIG_LOCKDEP
 bool dma_fence_begin_signalling(void);
 void dma_fence_end_signalling(bool cookie);
+void __dma_fence_might_wait(void);
 #else
 static inline bool dma_fence_begin_signalling(void)
 {
-- 
2.26.2

