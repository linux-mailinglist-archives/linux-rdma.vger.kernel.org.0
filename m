Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636DC1EDF62
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2020 10:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgFDINV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jun 2020 04:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgFDIMv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jun 2020 04:12:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09068C08C5C2
        for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2020 01:12:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so5009453wru.12
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jun 2020 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zHLq9yPZgKKERQ/k46N5wAtq1tEa3e90dS7EqKAAVV8=;
        b=ifotk2PJMfPqXT/+gwn4eR7/3IWQV+W9DCcY7OyrRdaAZFQwKftRJdQXo0rpUM3/yB
         gFJrkbneOCQ2QX77TBZL8U/VuKVxgzOxX4tlg9WC2CbjGOvgEb6AVwmiQ15EpDYBd7lG
         Tzy0RTnpPG+HiMGAwz3SGe+WNdJdbJrdEf6D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zHLq9yPZgKKERQ/k46N5wAtq1tEa3e90dS7EqKAAVV8=;
        b=gOSxQ9CvAnLllhY3CHmwFPoWpZciEWJQH2xC8eWhRlzNTy5Bcwtz1ZvxuwdDGUiWIv
         rytt9sfYV/Y9XqkSSMxiyKA4d+ZGDZLsDs7kEmQoStS3KrQsn9f8PWkxoh47trxESCie
         MWzKP8aYxwHnBmMGp7HMCit8qpYDLTgpnBIpcIexY7pPrqErQzo3netQWS33m6QVbESK
         KiU0lcEFfbJu2umvvSFWsMaLKsu9JypTWrdrEI8JCFTBLeDsyKtIknwi8XiSCSHSe32D
         XhG4nty12XWcTtqJEn92ZyKLAexZF82E5GbBam9/K/ibNqPsDjIMr33jmu2kN8eBg/x3
         HnDA==
X-Gm-Message-State: AOAM531ZnP+ydr4BLULqh7Tt0t/hyd4wg7lNJRrrHRDL+enLcfDno/ng
        iEsZQKUB9vFf/laocLIYsJqWPQ==
X-Google-Smtp-Source: ABdhPJwmXgxb0rRlbz9RyKT6KVGNFYaugD+jseyFJKYlXk9wNmaSF3eMQq44tjneQVcPWbVrYiOUJw==
X-Received: by 2002:adf:fb0f:: with SMTP id c15mr3424740wrr.410.1591258368775;
        Thu, 04 Jun 2020 01:12:48 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:12:48 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 13/18] drm/amdgpu/dc: Stop dma_resv_lock inversion in commit_tail
Date:   Thu,  4 Jun 2020 10:12:19 +0200
Message-Id: <20200604081224.863494-14-daniel.vetter@ffwll.ch>
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
index c575e7394d03..04c11443b9ca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6910,7 +6910,11 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
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
@@ -6920,6 +6924,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
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
2.26.2

