Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107122178D3
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgGGUNJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgGGUNI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:13:08 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AFCC061755
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:13:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so474052wmo.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8vhBO2QXji8rIT2yf3WDABSBN2A7UpHMa5cTtCVfx9g=;
        b=SI+A2Elkc84jnDWNJKdyIiWg94QLHhdHfRic7YA64NrB2zUjcHaawvIqElpfiGS5UF
         vFS/cvCNncCF3VRb1GLb2SQUTphEzGthiR0Q3gqWonj/oSVCvkQT/b8Q7NKuEISQBx4V
         XZfDuKa8LNkQLyxNGvqdeV8x2KvGAtj5Li8Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8vhBO2QXji8rIT2yf3WDABSBN2A7UpHMa5cTtCVfx9g=;
        b=X/UbmVhzJGKxovsUhDRaPHhodfD61ecQTwqqemBd6av9oUJKUqeXOqcTqzV6Ntz5lX
         jZphWrTvx3+3heBHH65CEgl5xhg4ApqMUmkX6y47H8BeyknPROfh5+VMf460/pEuzQMQ
         6SavY1ZFOMWWf7H2wr4K9J/23efxakacVg5vZVouaC/PJgiG5iFLSELktOo6VUe/3/7v
         RK7w/8eMTNV7SXUaSGato3isk6T9XyALk8TNgy5HXhv2E5uJngQpQbDJA80+UtbWOI+x
         ikX5wn2McSocyBFlcpUBbri5W5rM0ZAv610zKvzHtBLjbCWvOOPYUZXfcnGeL98PK9pi
         /mdg==
X-Gm-Message-State: AOAM533A0FBGP+RVB28DqfMFi3D6NUjfZFU00/ODIY7LMlXe05gzhnLC
        Qb+5MAxRV9Fye56uItbB/HniCA==
X-Google-Smtp-Source: ABdhPJz3xBYLJDOwYA2n2XZ64XK2kngCSUfd1JWeXQJzfB/NbmdXimIF/UOKC7vdM6lhx0lkZoAdKg==
X-Received: by 2002:a1c:7c16:: with SMTP id x22mr5594163wmc.76.1594152786931;
        Tue, 07 Jul 2020 13:13:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:13:06 -0700 (PDT)
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
Subject: [PATCH 21/25] drm/amdgpu/dc: Stop dma_resv_lock inversion in commit_tail
Date:   Tue,  7 Jul 2020 22:12:25 +0200
Message-Id: <20200707201229.472834-22-daniel.vetter@ffwll.ch>
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

Trying to grab dma_resv_lock while in commit_tail before we've done
all the code that leads to the eventual signalling of the vblank event
(which can be a dma_fence) is deadlock-y. Don't do that.

Here the solution is easy because just grabbing locks to read
something races anyway. We don't need to bother, READ_ONCE is
equivalent. And avoids the locking issue.

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
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3d41eddc7908..d6bb876a74e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6949,7 +6949,11 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		 * explicitly on fences instead
 		 * and in general should be called for
 		 * blocking commit to as per framework helpers
+		 *
+		 * Yes, this deadlocks, since you're calling dma_resv_lock in a
+		 * path that leads to a dma_fence_signal(). Don't do that.
 		 */
+#if 0
 		r = amdgpu_bo_reserve(abo, true);
 		if (unlikely(r != 0))
 			DRM_ERROR("failed to reserve buffer before flip\n");
@@ -6959,6 +6963,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		tmz_surface = amdgpu_bo_encrypted(abo);
 
 		amdgpu_bo_unreserve(abo);
+#endif
+		/*
+		 * this races anyway, so READ_ONCE isn't any better or worse
+		 * than the stuff above. Except the stuff above can deadlock.
+		 */
+		tiling_flags = READ_ONCE(abo->tiling_flags);
 
 		fill_dc_plane_info_and_addr(
 			dm->adev, new_plane_state, tiling_flags,
-- 
2.27.0

