Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9021CF01D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 11:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgELJAn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 05:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729452AbgELJAN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 05:00:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816F0C05BD09
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 02:00:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e26so20839184wmk.5
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 02:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u5gM1ohPbNVORxsODI5ngB8Z3LljD1/NzUrdRFpQw6k=;
        b=eo6XCFnGqS3UTbV+XFLkZTkDoh8UHvgOyRRDESLFJ7MP+5Cj3/IxjzAl127GN5O9rY
         VXDXGt6n7g7rCnvzywPZOWCjrMfNywQXd3+W+fn3un22WolNWV/n9WI+YAZlftq1Ve6F
         gC89CnJ6agJOr1dSjp+3V/HsmrsJiwJEQFsVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5gM1ohPbNVORxsODI5ngB8Z3LljD1/NzUrdRFpQw6k=;
        b=RtYkfExgkDfSpUjp0t3OK9sAgVKrFlOSSBnZFi10FGxcCojxBWL44g05Q5M+NIRiC6
         auAZQ3EwgqygK1c0ArX2z+NsNHP0dukarChFEu1F3DLHsalXAV8apIUg91OWkHNBuArZ
         zAIpGVzmGjWSvuC8vzi2f0zl3UKgD/SJ5CFZKyzkosIJRozOKv1d4TsGMHjMZI3nLItX
         g/bQuARgLZ0FMwai1yYM2DG/niXYOmDJFrAR7bg7gKer3e24/ViOTQ0DjNuj48s9c24j
         s/vXah7R1udLuH+PJTpT/eP1DLlrO74GFVLQQA6bzGmAiOpn9MaNF9gVlgaZgig7Iaxn
         M+oQ==
X-Gm-Message-State: AGi0PubY2rpLvaxYDr8TXp3GKLiekWh3mB6p0AUmS+srmj+4Gnx3Jcv1
        TKnXvDzEEIA8L7nLJDIF2Gsshg==
X-Google-Smtp-Source: APiQypLTNXsQ8HlHPlHfp2Mll6IbSc871xkl7AkjDoENjAiQEoiFF4u2nMFQth6vdD3XxA2bFR9BoQ==
X-Received: by 2002:a1c:9e52:: with SMTP id h79mr35953921wme.84.1589274012210;
        Tue, 12 May 2020 02:00:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y10sm18845457wrd.95.2020.05.12.02.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 02:00:11 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC 14/17] drm/amdgpu: use dma-fence annotations for gpu reset code
Date:   Tue, 12 May 2020 10:59:41 +0200
Message-Id: <20200512085944.222637-15-daniel.vetter@ffwll.ch>
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

To improve coverage also annotate the gpu reset code itself, since
that's called from other places than drm/scheduler (which is already
annotated). Annotations nests, so this doesn't break anything, and
allows easier testing.

Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-rdma@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b038ddbb2ece..5560d045b2e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4140,6 +4140,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	bool use_baco =
 		(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
 		true : false;
+	bool fence_cookie;
+
+	fence_cookie = dma_fence_begin_signalling();
 
 	/*
 	 * Flush RAM to disk so that after reboot
@@ -4168,6 +4171,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
 			  job ? job->base.id : -1, hive->hive_id);
 		mutex_unlock(&hive->hive_lock);
+		dma_fence_end_signalling(fence_cookie);
 		return 0;
 	}
 
@@ -4178,8 +4182,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 */
 	INIT_LIST_HEAD(&device_list);
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
-		if (!hive)
+		if (!hive) {
+			dma_fence_end_signalling(fence_cookie);
 			return -ENODEV;
+		}
 		if (!list_is_first(&adev->gmc.xgmi.head, &hive->device_list))
 			list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
 		device_list_handle = &hive->device_list;
@@ -4194,6 +4200,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
 				  job ? job->base.id : -1);
 			mutex_unlock(&hive->hive_lock);
+			dma_fence_end_signalling(fence_cookie);
 			return 0;
 		}
 
@@ -4319,6 +4326,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	if (r)
 		dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
+	dma_fence_end_signalling(fence_cookie);
 	return r;
 }
 
-- 
2.26.2

