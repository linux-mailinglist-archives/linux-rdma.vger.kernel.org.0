Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE80296E71
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 14:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371521AbgJWMWt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 08:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463626AbgJWMWr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 08:22:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5879AC0613D4
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 05:22:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n15so1597772wrq.2
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 05:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pt7r3r8KzR5b5qiGeAc9wam0F2FH3YbYbdtTLI7+5pA=;
        b=J1ovvaeRgAyxo4+fhyaimEa7i+0LS95i5IhmBF2STfEkqG/VqrnAk7NJv/NWmihpPf
         X7Np5ypMJj57D3bg6y5M89f/D5DBHFvI4gBX/jBw4SJGMzN43CprGiEkGtFlLBdX8fbV
         vsahdqW51+kNqRYjTRhqxtPo2IT1e1Su+fPVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pt7r3r8KzR5b5qiGeAc9wam0F2FH3YbYbdtTLI7+5pA=;
        b=ljPftl8YM/i5IFmFX5//r+z+Nx5HZzh6yxJb09h4j66ixJ9sHjubHjG31fYsFiRzTg
         5t/B0VuQvxdP9ooFgSruvVavgJ3dYRcX+UysvJJXaITtkJB6MGKiiDGoVakuJWs9Kyg0
         6jAXcAmUKRb8f9lD4+sHFh6OdfzEvvzHOJDHXh53Rd1f5fmyvP4oK71KOQjJ/cVJzY3P
         GNXXBEqUpR345wsZY0hSewLgEBSIf1SjgvLMr4c9eVurqBkLBZlKMSDWsp4O3l5zLvLU
         ZNDpXrWN6jO3qd2DXKy1fBDU/IZEmkylUBe2Tw26S0HtdN0Hef6JxhgOAAI9jnjIDaBb
         xA9A==
X-Gm-Message-State: AOAM530y03dciSjpyShZZYXiPNqa/0FOsT7cPfsHE39HpneKmn7BVuUz
        sz9EjHQYrz8iRdA9kv0XtMDbVuBpyrY6GRK8
X-Google-Smtp-Source: ABdhPJzeL0b3o7SdVpsqso58ueQCQULN8UwDSO9Ve2MQd7IHgs3k/2/xklwW61HBtOOF7k0eWuT9pw==
X-Received: by 2002:a5d:4ccd:: with SMTP id c13mr2315042wrt.221.1603455766129;
        Fri, 23 Oct 2020 05:22:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y4sm3056484wrp.74.2020.10.23.05.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 05:22:45 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 21/65] drm/amdgpu: use dma-fence annotations for gpu reset code
Date:   Fri, 23 Oct 2020 14:21:32 +0200
Message-Id: <20201023122216.2373294-21-daniel.vetter@ffwll.ch>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e8b41756c9f9..029a026ecfa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4496,6 +4496,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_emergency_restart = false;
 	bool audio_suspended = false;
+	bool fence_cookie;
+
+	fence_cookie = dma_fence_begin_signalling();
 
 	/**
 	 * Special case: RAS triggered and full reset isn't supported
@@ -4529,6 +4532,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
 				job ? job->base.id : -1, hive->hive_id);
 			amdgpu_put_xgmi_hive(hive);
+			dma_fence_end_signalling(fence_cookie);
 			return 0;
 		}
 		mutex_lock(&hive->hive_lock);
@@ -4541,8 +4545,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
@@ -4556,8 +4562,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
 			dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
 				  job ? job->base.id : -1);
-			r = 0;
-			goto skip_recovery;
 		}
 
 		/*
@@ -4699,6 +4703,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	if (r)
 		dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
+	dma_fence_end_signalling(fence_cookie);
 	return r;
 }
 
-- 
2.28.0

