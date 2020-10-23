Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1A0296E6A
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 14:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463616AbgJWMWo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 08:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463615AbgJWMWo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 08:22:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4576C0613D2
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 05:22:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n6so1553027wrm.13
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 05:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOyGCTKuuJziCpWzWdCo/QK3Mayinv6OMW6Q5kQhnyk=;
        b=da0uNPQTF9iafrGvjttCTo8KaCRGJJ0losxnfEnQ+ctYYMk40w+JM+UOvxXYJaJDlG
         xnhBhyiiG2KhEERw/wSo3xnYtahtTOoeS3KP8SHjgUOynK4D05IBt6vq+GpjyIyyqglj
         o++XAyFlbf9CE2K6mHWsMlao1Qc55VGiPnPJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOyGCTKuuJziCpWzWdCo/QK3Mayinv6OMW6Q5kQhnyk=;
        b=f4GEKGVqivDIjfQgIB0MQE6kD1vRKkyUoUqh4Q0xgU6q3DVIJfGQF0Wh8/D2aTb5DD
         6FRbfQmiiZYaaFVhVFX02g3GWUWVfHfxOqRMzEpxeKOtxlJGGLotKzO2rIlvo9fc7/WN
         s6AzJ9II5ojoZMAhIEYYbLEiHmXyaTHMH9c4haNb+Uv0lpLUZeu85DqXv0wMvEfHfkSU
         ZiLWd2lKY8UfjV9BI8crEUpAoxfNEX5isxsXNao6O9mgFSQqCwZSrtt9wiM3kfYK6PMM
         gNFWUVchcU6dtwH0TyxK5INhBzyWdnLbh8k0fzZWLAJiV9X3our40a4w32LePsuMyZ7Q
         onWQ==
X-Gm-Message-State: AOAM5329Zq12W458bWx4ghO1HcEBYV7wLzbbRZXWnFG4J21v3wnqnqLL
        9k2lKJXOQyAS/dKMABOxI+cAKA==
X-Google-Smtp-Source: ABdhPJxrOX8/B2rmy6TerQUriY/hvWhKXRqCPO7bzGJK2shyHhd4WjRC4UHiZqehTAyO+ARcrDOJSA==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr2304784wrn.362.1603455762699;
        Fri, 23 Oct 2020 05:22:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y4sm3056484wrp.74.2020.10.23.05.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 05:22:42 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 18/65] drm/amdgpu: use dma-fence annotations in cs_submit()
Date:   Fri, 23 Oct 2020 14:21:29 +0200
Message-Id: <20201023122216.2373294-18-daniel.vetter@ffwll.ch>
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
index d50b63a93d37..3b3999225e31 100644
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
2.28.0

