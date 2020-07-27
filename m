Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F6522FB6D
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 23:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgG0Vbx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 17:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgG0Vbx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jul 2020 17:31:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DDEC061794
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jul 2020 14:31:53 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so16268671wrs.11
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jul 2020 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbBLsev6A/k6JtTZxYPdXm24BNGReWdxszm0mfyFmjs=;
        b=cVLK0R/gUj+gognaAVDPpAcP0p/kaqO27TPJ/4oQvPAVxTWgzIk1QMDw38zDZnYRwL
         oEPqrbbbcE3rhwjhV7Pm1B0efa4lN6NMK/Kky5kl6lUyt4IW7cYwb/OkujsODB6S4ySc
         /O6SRw8n2sblXDqrfhuiNO9eEB3Ehe86udljQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbBLsev6A/k6JtTZxYPdXm24BNGReWdxszm0mfyFmjs=;
        b=hKeGh0sYUMA/M/IYRDX0YkW2oWbAR3l2LVJp4FfEO5kMKULQN9E5mMLY82s6awwxF8
         DPfS1Z82Trfhw1hOZw4+qyHLM1lBcTWlDMqjAFPzIlAIW6HT6qi9Mx6LH9u5rxmw56rz
         6lid3yn+8fd7iNYYhR98r7o5oyW8IMQsKieMDM7m6hpB33Lq3ren4xOkWdpD26JBvjqZ
         ojq/pChyDSBzRQHkow1xMUzTV953griMQ8FxthLl1X62TCVSzqMHMuE5DhlH4HupoVQJ
         0VgpjoJGHFnINmtzqoDssvG1eT2lhjdnO7S1QFuzs4kib0QBdg2riaoa3M7wk2pfpAj7
         5loA==
X-Gm-Message-State: AOAM5338nIQ0m09RFyiAqC5wcEK5ATTCCiAGYSKjHFKQazqLIDDCFNqr
        r8QemjwckTNdsVvyLlrq9ooRnQ==
X-Google-Smtp-Source: ABdhPJxu91l4eNQybKcmI4LErpte7CoyW1rnIyORt8Wxy15Rf018CY26pqWTld4+57hcv1yfORKfeQ==
X-Received: by 2002:adf:82f6:: with SMTP id 109mr23889821wrc.25.1595885511913;
        Mon, 27 Jul 2020 14:31:51 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f9sm13945424wru.47.2020.07.27.14.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:31:51 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] drm/amdgpu/dc: Stop dma_resv_lock inversion in commit_tail
Date:   Mon, 27 Jul 2020 23:30:18 +0200
Message-Id: <20200727213017.852589-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
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

v2: Also take into account tmz_surface boolean, plus just delete the
old code.

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
DC-folks, I think this split out patch from my series here

https://lore.kernel.org/dri-devel/20200707201229.472834-1-daniel.vetter@ffwll.ch/

should be ready for review/merging. I fixed it up a bit so that it's not
just a gross hack :-)

Cheers, Daniel


---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 21ec64fe5527..a20b62b1f2ef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6959,20 +6959,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			DRM_ERROR("Waiting for fences timed out!");
 
 		/*
-		 * TODO This might fail and hence better not used, wait
-		 * explicitly on fences instead
-		 * and in general should be called for
-		 * blocking commit to as per framework helpers
+		 * We cannot reserve buffers here, which means the normal flag
+		 * access functions don't work. Paper over this with READ_ONCE,
+		 * but maybe the flags are invariant enough that not even that
+		 * would be needed.
 		 */
-		r = amdgpu_bo_reserve(abo, true);
-		if (unlikely(r != 0))
-			DRM_ERROR("failed to reserve buffer before flip\n");
-
-		amdgpu_bo_get_tiling_flags(abo, &tiling_flags);
-
-		tmz_surface = amdgpu_bo_encrypted(abo);
-
-		amdgpu_bo_unreserve(abo);
+		tiling_flags = READ_ONCE(abo->tiling_flags);
+		tmz_surface = READ_ONCE(abo->flags) & AMDGPU_GEM_CREATE_ENCRYPTED;
 
 		fill_dc_plane_info_and_addr(
 			dm->adev, new_plane_state, tiling_flags,
-- 
2.27.0

