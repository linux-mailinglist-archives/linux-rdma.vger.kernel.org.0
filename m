Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7062178B5
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgGGUMv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbgGGUMu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:12:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A25C08C5DC
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:12:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so38532073wrs.0
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/F5bE4Ajmtsmz1BnMPDeI6gxnQhrPyyYiyHS2HLPAEo=;
        b=edyYB/A8Bn1xvsQ1OLmcp1AEJAGKyqJznhiwF5qjLOtwp/tnRdBKIbkBVPj6vkehdK
         JYKwC5u1bob3ga9Kl0BgdFZx8mmrUWiUWvLmuU1+rh/HuE2OpIApTN+EFC9fDvwacVc6
         RAiwdAmdL7TyjvFBeWRMwjIikyR7iGzSCkCfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/F5bE4Ajmtsmz1BnMPDeI6gxnQhrPyyYiyHS2HLPAEo=;
        b=arps2UNA+q3VMxP7dG9MnCmvNRYykvjU+MeXIkwXUkI0gchQT0UoRupzC+Wrxs34Fb
         AX3fYhZrtXtXrbM+luJp3I5ZL8bezTFiUe/4G7g9uNCw0Y3Ay2Lj+8G6AIpdhRlgif0Q
         DGcWimxEnLPFco33NbbYk1rBP7IVpDeXPowgMTTqmbISWZA6apvDKvEcF1si+AIBIKDr
         7femVjxoR4NHZ9x5G26eqz+WD2/HszC0M0EjvyFVJnAOX/ZaN8htTC4HVJcYuCHoBKWO
         ol+3KjC+UPD+eA8I8D37ANJAE7rNniY4zIG6nvZGXQUZ4t8vZ3JtASoDVaIazgWQ9vTB
         SrIw==
X-Gm-Message-State: AOAM532l/wP8bsQGRNUpoaEKRFouk+kBjbS3g7pF8QomN+DQBTZtnEeg
        /ZoZevniw06gx3B/to0h2qraQg==
X-Google-Smtp-Source: ABdhPJwbdve/8vMlznHD/htlv+d2Iw56fdNcBxr/w0i0HbzaOXCdPCcE786isY4b7E3+0QkxxmkdLA==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr53792691wrv.162.1594152768997;
        Tue, 07 Jul 2020 13:12:48 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:12:48 -0700 (PDT)
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
Subject: [PATCH 06/25] drm/amdgpu: add dma-fence annotations to atomic commit path
Date:   Tue,  7 Jul 2020 22:12:10 +0200
Message-Id: <20200707201229.472834-7-daniel.vetter@ffwll.ch>
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

I need a canary in a ttm-based atomic driver to make sure the
dma_fence_begin/end_signalling annotations actually work.

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
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5b0f708dd8c5..6afcc33ff846 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -57,6 +57,7 @@
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
+#include <linux/module.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/version.h>
@@ -7359,6 +7360,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	struct drm_connector_state *old_con_state, *new_con_state;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
 	int crtc_disable_count = 0;
+	bool fence_cookie;
+
+	fence_cookie = dma_fence_begin_signalling();
 
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
 
@@ -7639,6 +7643,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	/* Signal HW programming completion */
 	drm_atomic_helper_commit_hw_done(state);
 
+	dma_fence_end_signalling(fence_cookie);
+
 	if (wait_for_vblank)
 		drm_atomic_helper_wait_for_flip_done(dev, state);
 
-- 
2.27.0

