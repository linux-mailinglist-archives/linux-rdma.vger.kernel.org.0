Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A848C2178CF
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgGGUNH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgGGUNG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:13:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B73C08C5E1
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:13:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so453581wme.5
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6mLNvmwV0mXXFCJp1CZ5e+LEhcYSNx/dxx3MEMckRw=;
        b=I+82JJmua6H54T91fmYUr8DAr6NrwnR+mkHvBYi78d5aDPpW3+51mLiZmLWpatmsVZ
         7UZkmP80kTFgcoEpPk4rtMeZpVJWOIuNxSW1ZScEeiy2ttA5BTAFxF1utpsJipJarIxb
         cjMyFkg21+NB7V8zjtGNczY53Qq7GLqyckRu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6mLNvmwV0mXXFCJp1CZ5e+LEhcYSNx/dxx3MEMckRw=;
        b=nDEKDIspPKqJvwhJ+bIJu0JXR+MZYL6uLXAZ5Tjus0sNULbcNOD7pRLfiD4EQDFr4h
         8h/XI0mN3vVrUCU3Oyp7EThyukqWw5to+ADpF6pqe+b3QcK3D4Q0/2MCIMtlIGQSaiWp
         bLC/w6u31XLKgGzKexSYcoka8xMSeU3pjKtNMQVs/uNffK2sp9MGE1OuSUIOJGxR6qNG
         LbhtQzWpkEeDzqQDuoXVtjqsL+X/bd9QEumQ7BM6+yicAxoNArPB9izmOPQ1tHlVmeHY
         5qH7Twk28p5LOLJn6eIQqqIimEhhXlly3+rHi8IKjhN0mcqBv9NnnXsCHpGlJ4SDjBrg
         GreA==
X-Gm-Message-State: AOAM533YWBJn7WZ+ml/Ojv5dZ5UjIp8TFQ4OaCZ5Kt7/mbFIfN5Y1nL7
        6M4vnuEDQiZzUkFRNupSbPdB9VfwlzY=
X-Google-Smtp-Source: ABdhPJwb8lrdzNzimlB7WFs1FDrPYBlKDSPiN4WBOCVQt3QuE500w5Nk7OIYzGADJypoV3zm1LNAIA==
X-Received: by 2002:a1c:44e:: with SMTP id 75mr5900441wme.139.1594152784201;
        Tue, 07 Jul 2020 13:13:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:13:03 -0700 (PDT)
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
Subject: [PATCH 19/25] drm/amdgpu: s/GFP_KERNEL/GFP_ATOMIC in scheduler code
Date:   Tue,  7 Jul 2020 22:12:23 +0200
Message-Id: <20200707201229.472834-20-daniel.vetter@ffwll.ch>
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
index 8d84975885cd..a089a827fdfe 100644
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
index 267fa45ddb66..a333ca2d4ddd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -208,7 +208,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
 	if (ring->vmid_wait && !dma_fence_is_signaled(ring->vmid_wait))
 		return amdgpu_sync_fence(sync, ring->vmid_wait);
 
-	fences = kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_KERNEL);
+	fences = kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_ATOMIC);
 	if (!fences)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 8ea6c49529e7..af22b526cec9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -160,7 +160,7 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f)
 	if (amdgpu_sync_add_later(sync, f))
 		return 0;
 
-	e = kmem_cache_alloc(amdgpu_sync_slab, GFP_KERNEL);
+	e = kmem_cache_alloc(amdgpu_sync_slab, GFP_ATOMIC);
 	if (!e)
 		return -ENOMEM;
 
-- 
2.27.0

