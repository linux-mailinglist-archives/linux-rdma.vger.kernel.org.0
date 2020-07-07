Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAA82178D2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgGGUNI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgGGUNI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:13:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAEBC08C5DC
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:13:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so46596801wrw.5
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTmW8GfMFV/TYGpBlf3/1N9LBDvcZT77sRHKHDyMv2U=;
        b=GL5GXtMw+oGEYvMEGD0ynq2bKINBxOKzvUDWYVHTriILNZ4e2LMTYBOLfRSdtqri/0
         8fVfJVJOm+WP7NTwU9gLBFBMCRU8A2MmLw38gaCMariAj60judwyB1sDCPok8/lVFlnY
         Pb7gt9prSymFTaCQVjSvH2HJvNNSjmu81x9wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTmW8GfMFV/TYGpBlf3/1N9LBDvcZT77sRHKHDyMv2U=;
        b=X/yEUT8OiFa2El9aD62fAJHuq57WfW6bEeuyY7VwFDVKE4Xkmu1BikYQJD9Tx2Ts6q
         WW4GTrXHbio5y5uj2mikFxS34Pb/iMVqcvM8Fi3ZBydB1iHGUeoajE50/TaKVMW8J8vB
         Ohh03tqvSyALaHlzDcLhiVF3m0oyiGKJqa5jLD9IkHllel4nTQj8Q2QO15sqt+n+t1o9
         laeRmx4JQgOPMA9v4jwOV2TYcYqQWo9YUeMl4kLTirN8cO4i9vJr3roKdnygPRd0yoar
         2Jql5ocDSDVWkCukelS4QNCsIKOFmt0bEEoPPySTigyf/Vigp48POJ0AxUzoFZDkcqtG
         WbzA==
X-Gm-Message-State: AOAM531mxNi8nWdXFD3bhivYm3X6Ev9p3UBw/0wn5beJSSlKzKq3oN40
        uFlgYz7+yFGdI+3AiYOY+JOObw==
X-Google-Smtp-Source: ABdhPJwmWTeCyTx0bBgTDG/B9PdUMguU6YzowcNba5ee/pIgTrKGFZT6kx1B6bzPcnRvbe3254x7bw==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr36581036wrr.364.1594152785392;
        Tue, 07 Jul 2020 13:13:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:13:04 -0700 (PDT)
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
Subject: [PATCH 20/25] drm/amdgpu: DC also loves to allocate stuff where it shouldn't
Date:   Tue,  7 Jul 2020 22:12:24 +0200
Message-Id: <20200707201229.472834-21-daniel.vetter@ffwll.ch>
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

Not going to bother with a complete&pretty commit message, just
offending backtrace:

        kvmalloc_node+0x47/0x80
        dc_create_state+0x1f/0x60 [amdgpu]
        dc_commit_state+0xcb/0x9b0 [amdgpu]
        amdgpu_dm_atomic_commit_tail+0xd31/0x2010 [amdgpu]
        commit_tail+0xa4/0x140 [drm_kms_helper]
        drm_atomic_helper_commit+0x152/0x180 [drm_kms_helper]
        drm_client_modeset_commit_atomic+0x1ea/0x250 [drm]
        drm_client_modeset_commit_locked+0x55/0x190 [drm]
        drm_client_modeset_commit+0x24/0x40 [drm]

v2: Found more in DC code, I'm just going to pile them all up.

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
 drivers/gpu/drm/amd/amdgpu/atom.c                 | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 4cfc786699c7..1b0c674fab25 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1226,7 +1226,7 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	ectx.abort = false;
 	ectx.last_jump = 0;
 	if (ws)
-		ectx.ws = kcalloc(4, ws, GFP_KERNEL);
+		ectx.ws = kcalloc(4, ws, GFP_ATOMIC);
 	else
 		ectx.ws = NULL;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6afcc33ff846..3d41eddc7908 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6872,7 +6872,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		struct dc_stream_update stream_update;
 	} *bundle;
 
-	bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
+	bundle = kzalloc(sizeof(*bundle), GFP_ATOMIC);
 
 	if (!bundle) {
 		dm_error("Failed to allocate update bundle\n");
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 942ceb0f6383..f9a58509efb2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1475,8 +1475,10 @@ bool dc_post_update_surfaces_to_stream(struct dc *dc)
 
 struct dc_state *dc_create_state(struct dc *dc)
 {
+	/* No you really cant allocate random crap here this late in
+	 * atomic_commit_tail. */
 	struct dc_state *context = kvzalloc(sizeof(struct dc_state),
-					    GFP_KERNEL);
+					    GFP_ATOMIC);
 
 	if (!context)
 		return NULL;
-- 
2.27.0

