Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D074D2178B8
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgGGUM4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgGGUM4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:12:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A560C061755
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:12:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so46550318wrw.12
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ccq2vLhORCvzbowlNkHW/GWZWfo0NUEsItyCBi/7QQc=;
        b=GtoTLLcN+6IDWQipx40CILNYaoxWkS3MLVhVJd7iis9W01KxUynXNAhouGbJKVNJnA
         pqiV/TDfqcFVxGmpHLYoJqPrsDhJqeSMlWnG/asxpaZ0in/bD9RKRrHnxrozGHE5d7Ao
         OlSC/3EBkkn4FUkdzjwg0xoW3sX1fkZL+juHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ccq2vLhORCvzbowlNkHW/GWZWfo0NUEsItyCBi/7QQc=;
        b=IQ5ydC9S1A+4dWkMHrMscbfHW3N+4WVRHmcrK57nBrYT0UxizAHt7XyYhRwOESp+f9
         OXQfPY0rpp1UjnYE0zWyXKfGKAtZfBHFcpfhR2xcm+x9Epgyqt99BbiYZ2oSy65BVuln
         V79E7joKuiS4Cm+yfJ1zDes1W0jQWiB/i9p4tr6g56mGihYdao/G1dAyLyQXKGAKXZY3
         he5clqIpyBqQObf0P1bau70byrJmjEii0cdXK/P/78Ii/duH1gx1jVuFaRJkuWLQplwx
         hQBNIr1ZPsOXiNJ0WaTMmq/LaTU2brE9f5j2PouWAgXbk+ElkNiPtSqGntDl12LBIGME
         TUdw==
X-Gm-Message-State: AOAM531ALKnNGt0Fb6/VchaEPl3w+igcLFrIgMdb/IYBltT3IlPioHUg
        t5iUKk+tYmsNIu4tlpXlrcOb0Uh/Bsk=
X-Google-Smtp-Source: ABdhPJywrqcDHWLumfWRYpTNsuFaPCinzpmk8UNMIb1Hji0hkX9CsoZGh1QMqsBfNGQxIXDLsi54eQ==
X-Received: by 2002:adf:f20a:: with SMTP id p10mr58701351wro.41.1594152773878;
        Tue, 07 Jul 2020 13:12:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:12:52 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/25] drm/imx: Annotate dma-fence critical section in commit path
Date:   Tue,  7 Jul 2020 22:12:14 +0200
Message-Id: <20200707201229.472834-11-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

drm_atomic_helper_commit_hw_done() is the last thing (no plane cleanup
apparrently), so it's the entire function. And a nice comment
explaining why thw wait_for_flip_done is ahead, unlike the usual
sequence.

Aside, I think since the atomic helpers do track plane disabling now
separately this might no longer be a real problem since:

commit 21a01abbe32a3cbeb903378a24e504bfd9fe0648
Author: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Date:   Mon Sep 4 12:48:37 2017 +0200

    drm/atomic: Fix freeing connector/plane state too early by tracking commits, v3.

Plus the subsequent bugfixes of course, this was tricky to get right.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpu/drm/imx/imx-drm-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index 36037b2e6564..8c209bd36780 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -80,6 +80,7 @@ static void imx_drm_atomic_commit_tail(struct drm_atomic_state *state)
 	struct drm_plane_state *old_plane_state, *new_plane_state;
 	bool plane_disabling = false;
 	int i;
+	bool fence_cookie = dma_fence_begin_signalling();
 
 	drm_atomic_helper_commit_modeset_disables(dev, state);
 
@@ -110,6 +111,7 @@ static void imx_drm_atomic_commit_tail(struct drm_atomic_state *state)
 	}
 
 	drm_atomic_helper_commit_hw_done(state);
+	dma_fence_end_signalling(fence_cookie);
 }
 
 static const struct drm_mode_config_helper_funcs imx_drm_mode_config_helpers = {
-- 
2.27.0

