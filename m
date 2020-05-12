Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208A51CF087
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgELJA4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 05:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729422AbgELJAJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 05:00:09 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE12FC05BD0C
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 02:00:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m12so15932742wmc.0
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r5PRcG/JtprEwCOUf2/ZPMLqKS9RbW1APrGVc2im3Nw=;
        b=GdZJjNq28F9KcRJyjlTagS8E3fkL1j9MVdiS32+c3J3oz4My0gpMGd7IrjrVwziyZj
         3INpjpPYeyhbD4+NwUOkIx7M0B6lMTqDeQsZGgAtFaTLfzA0CcV9W86y8Gzd1CxGRleL
         BXUlHw6StLiPmKsmxJLvaFWoCXKd6BPsYXKG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r5PRcG/JtprEwCOUf2/ZPMLqKS9RbW1APrGVc2im3Nw=;
        b=obD5sDULM/NB3tiUWV/RCGioX5XDCRgAWs6uEfqLmHBOCOO2HIcG7L+/xUelB4JSJ5
         facVq+JppJD4gxvQNCVv9lDuJJvb+F8tMqUD+mogRG6EQKZjuH8IfWDfW7I82Fz/DpX9
         H/uh6AQHmkX3aYPhQkT0we4uwUzjOcBciJen9/s74yvBcSaKnfwAwJ9/kEl+64qi1dvS
         3bHrzbHjDmZ0s4ErtoIwQpwDR4J0Al4sTmJLu+0ATXgArZiJ7xBNyQVwTBTqKRda4bLE
         oM70N9AXgn0zdarxQqNI4EU20/WfJRvk+/nR9Hv3RjvpMGpEuqi+hzGYZRCiPVPh0zr8
         dsxA==
X-Gm-Message-State: AGi0Pubv2s3eQg/k39IA/4UAMHaPDcsq8ejSEwxH+rr03+A6NUwI7xui
        vk8L5Fy3ncVqoI7GIEM8YGJcmw==
X-Google-Smtp-Source: APiQypLn0gzMJwxb1G5NuhzTlxFQ4Fcx0V6C0P/n0rDCyjAZoEVClTf3ENM81ku64jmXd4+qf9UzyQ==
X-Received: by 2002:a05:600c:2055:: with SMTP id p21mr13224168wmg.127.1589274007383;
        Tue, 12 May 2020 02:00:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y10sm18845457wrd.95.2020.05.12.02.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 02:00:06 -0700 (PDT)
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
Subject: [RFC 10/17] drm/amdgpu: s/GFP_KERNEL/GFP_ATOMIC in scheduler code
Date:   Tue, 12 May 2020 10:59:37 +0200
Message-Id: <20200512085944.222637-11-daniel.vetter@ffwll.ch>
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

My dma-fence lockdep annotations caught an inversion because we
allocate memory where we really shouldn't:

	kmem_cache_alloc+0x2b/0x6d0
	amdgpu_fence_emit+0x30/0x330 [amdgpu]
	amdgpu_ib_schedule+0x306/0x550 [amdgpu]
	amdgpu_job_run+0x10f/0x260 [amdgpu]
	drm_sched_main+0x1b9/0x490 [gpu_sched]
	kthread+0x12e/0x150

Trouble right now is that lockdep only validates against GFP_FS, which
would be good enough for shrinkers. But for mmu_notifiers we actually
need !GFP_ATOMIC, since they can be called from any page laundering,
even if GFP_NOFS or GFP_NOIO are set.

I guess we should improve the lockdep annotations for
fs_reclaim_acquire/release.

Ofc real fix is to properly preallocate this fence and stuff it into
the amdgpu job structure. But GFP_ATOMIC gets the lockdep splat out of
the way.

v2: Two more allocations in scheduler paths.

Frist one:

	__kmalloc+0x58/0x720
	amdgpu_vmid_grab+0x100/0xca0 [amdgpu]
	amdgpu_job_dependency+0xf9/0x120 [amdgpu]
	drm_sched_entity_pop_job+0x3f/0x440 [gpu_sched]
	drm_sched_main+0xf9/0x490 [gpu_sched]

Second one:

	kmem_cache_alloc+0x2b/0x6d0
	amdgpu_sync_fence+0x7e/0x110 [amdgpu]
	amdgpu_vmid_grab+0x86b/0xca0 [amdgpu]
	amdgpu_job_dependency+0xf9/0x120 [amdgpu]
	drm_sched_entity_pop_job+0x3f/0x440 [gpu_sched]
	drm_sched_main+0xf9/0x490 [gpu_sched]

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index d878fe7fee51..055b47241bb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -143,7 +143,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 	uint32_t seq;
 	int r;
 
-	fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
+	fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
 	if (fence == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index fe92dcd94d4a..fdcd6659f5ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -208,7 +208,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
 	if (ring->vmid_wait && !dma_fence_is_signaled(ring->vmid_wait))
 		return amdgpu_sync_fence(sync, ring->vmid_wait, false);
 
-	fences = kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_KERNEL);
+	fences = kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_ATOMIC);
 	if (!fences)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index b87ca171986a..330476cc0c86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -168,7 +168,7 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f,
 	if (amdgpu_sync_add_later(sync, f, explicit))
 		return 0;
 
-	e = kmem_cache_alloc(amdgpu_sync_slab, GFP_KERNEL);
+	e = kmem_cache_alloc(amdgpu_sync_slab, GFP_ATOMIC);
 	if (!e)
 		return -ENOMEM;
 
-- 
2.26.2

