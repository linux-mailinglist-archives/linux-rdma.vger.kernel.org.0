Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1052178C4
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgGGUNB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbgGGUNA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:13:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A2FC061755
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:12:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so46550537wrw.12
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kL+RB1KM4/yl8RLrIa4baCeHAlTavvqJM6Ze/i1mrs=;
        b=S2CyXGvGn8x8BbuCBF1Dlhba4g73zGpswHnSigIvgpr794NnK/Fz7C7N4d0t29msnq
         tAFBjh4EOBDQSY00bzCCqXCB7FYhI3NIQV0WcMubzFw1HljERMzMfxnWaGkv+vSqLlY1
         9aK1NpWlbcyF84913acyjAiEw/27hrZSgVyls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kL+RB1KM4/yl8RLrIa4baCeHAlTavvqJM6Ze/i1mrs=;
        b=Ps6mP5Q7u9B54+OnalwyBD8yOQD49vY/cz6u706ttRq078Q89zXoSW2vyHWytjGe/2
         iciUILh+THxLL2wXV/sEKyJcRA1AffMBQD4FtDT6O3VkeWuxMPBtOjovDvPp9gqJiZbd
         SVsAYOyd/nm1j3jXJw93SVYnzNQrsj0FHRFDIfmp0fuK/CMZwTmSEJckOdJ3e0uqY+xv
         hFO2g12V7JZNBTMb9ZXXBEKvclcORECp0Bjkn2CTax+fkSY62uchaM8cBlOXO9TbgW4n
         ANUyjcOH4aMj10gN9tiWXgkJpPzk9rx6l2wz48LOOY1lmWKf4nxa9CcBpc/yN1TZn4T0
         qCdA==
X-Gm-Message-State: AOAM53161SueT1sBfjduFRdA4XjgJuD9dsYPUkv01jTt+Ia3En2GSCao
        Fp3vbReVL9MaROEGcfSO0pMkbg==
X-Google-Smtp-Source: ABdhPJwYZihW6MCohjBA3hUxjm67Ec/Qq2NSVmrLJez6834kk1mvXyOLiuF0oNDVSFbqQlkZZuJycw==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr59616866wrq.38.1594152778138;
        Tue, 07 Jul 2020 13:12:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:12:57 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/25] drm/tidss: Annotate dma-fence critical section in commit path
Date:   Tue,  7 Jul 2020 22:12:18 +0200
Message-Id: <20200707201229.472834-15-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Ends right after hw_done(), totally standard case.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/tidss/tidss_kms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index b6e61d6cf60f..556bc801b77c 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -4,6 +4,8 @@
  * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
  */
 
+#include <linux/dma-fence.h>
+
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
@@ -26,6 +28,7 @@ static void tidss_atomic_commit_tail(struct drm_atomic_state *old_state)
 {
 	struct drm_device *ddev = old_state->dev;
 	struct tidss_device *tidss = to_tidss(ddev);
+	bool fence_cookie = dma_fence_begin_signalling();
 
 	dev_dbg(ddev->dev, "%s\n", __func__);
 
@@ -36,6 +39,7 @@ static void tidss_atomic_commit_tail(struct drm_atomic_state *old_state)
 	drm_atomic_helper_commit_modeset_enables(ddev, old_state);
 
 	drm_atomic_helper_commit_hw_done(old_state);
+	dma_fence_end_signalling(fence_cookie);
 	drm_atomic_helper_wait_for_flip_done(ddev, old_state);
 
 	drm_atomic_helper_cleanup_planes(ddev, old_state);
-- 
2.27.0

