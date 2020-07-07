Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560E82178CC
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgGGUNE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbgGGUNE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:13:04 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D59FC061755
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:13:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so46608776wrm.4
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=288QC5fKBToLFpFuoOPQqa37hzJ8GViPNZgBbpolevY=;
        b=exbtvFm/IDGUVNkPZ+J6eOk/nKAYYZYnwZjGPqn4diJ0GPNqgp8huhSLLZXvWl635s
         SW4E6QQuTZgdY7pe95x7AGPcPBSzYsyKzcyQVjeYtQ/3mSTlpcm9bstPy6xqhxQdc3lU
         nhih5p7E42c1af44f6sBfO4t1NWm5I/2bCo5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=288QC5fKBToLFpFuoOPQqa37hzJ8GViPNZgBbpolevY=;
        b=l1UQ47Ajr7jHoI7/z84NV6ppVqkCci3pPn8/HxrpEYaTT5X5r0P8t0FA6EfR35J+Ce
         ICirv8dfmj4ka7c1d15TJmNpIP3YlUAOPs2jhaE0et3JLr4SwgI9tIXL60i5Fxet4V/S
         xLsEby0SZXu4GyU2PNWUFAqUZf2H3U30kAIgo3vC65YCoCYRKutR3CyWeI+4n0sW/Drt
         8TGwpXaeBGnb+PZbCDUAx3z8DNOts/qLafRRA6baJuYm4QnP0LHRJINicVxQYWYG7j00
         4AyRaGLWmQZAe7JbIfGvpasUb4wmqgJs8b9npt3gryRL6ZYP0Dsj2QAUprSQjhitGO8F
         qbIg==
X-Gm-Message-State: AOAM532fV8neq85YzRA8QBQlm50za3ZUw/t8lL8ETi7TjnKJUPfKYlDX
        ij3c93f7kjqJ8B+m7NUNLs+mtZVg4+Y=
X-Google-Smtp-Source: ABdhPJzJC+HAl1m5YFWCn6DTeDFu8lcCd90/+4+vD1TO4Q9nKElNEoSd/j3rcAA3OQS0WKjwS/G1Mg==
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr56760051wrq.263.1594152782893;
        Tue, 07 Jul 2020 13:13:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:13:02 -0700 (PDT)
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
Subject: [PATCH 18/25] drm/amdgpu: use dma-fence annotations in cs_submit()
Date:   Tue,  7 Jul 2020 22:12:22 +0200
Message-Id: <20200707201229.472834-19-daniel.vetter@ffwll.ch>
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

This is a bit tricky, since ->notifier_lock is held while calling
dma_fence_wait we must ensure that also the read side (i.e.
dma_fence_begin_signalling) is on the same side. If we mix this up
lockdep complaints, and that's again why we want to have these
annotations.

A nice side effect of this is that because of the fs_reclaim priming
for dma_fence_enable lockdep now automatically checks for us that
nothing in here allocates memory, without even running any userptr
workloads.

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index a512ccbc4dea..858528a06fe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1212,6 +1212,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	struct amdgpu_job *job;
 	uint64_t seq;
 	int r;
+	bool fence_cookie;
 
 	job = p->job;
 	p->job = NULL;
@@ -1226,6 +1227,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	 */
 	mutex_lock(&p->adev->notifier_lock);
 
+	fence_cookie = dma_fence_begin_signalling();
+
 	/* If userptr are invalidated after amdgpu_cs_parser_bos(), return
 	 * -EAGAIN, drmIoctl in libdrm will restart the amdgpu_cs_ioctl.
 	 */
@@ -1262,12 +1265,14 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
 
 	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
+	dma_fence_end_signalling(fence_cookie);
 	mutex_unlock(&p->adev->notifier_lock);
 
 	return 0;
 
 error_abort:
 	drm_sched_job_cleanup(&job->base);
+	dma_fence_end_signalling(fence_cookie);
 	mutex_unlock(&p->adev->notifier_lock);
 
 error_unlock:
-- 
2.27.0

