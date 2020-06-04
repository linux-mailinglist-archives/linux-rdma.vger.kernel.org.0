Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9D61EDF83
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2020 10:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgFDINu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jun 2020 04:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgFDIMn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jun 2020 04:12:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5191AC03E97D
        for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2020 01:12:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u13so4302347wml.1
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jun 2020 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nP9MOB+NRJcIZvAbkEER1wMU4XBwsFVpcXFNKANe0X8=;
        b=A/nDmxB1z0+GjCIm4Zq3jaNGjJ23cPpfIRlR5gm4EnJUVo5qYiGFagWY005kpAT8FA
         ArHPraQTxuq4p9JNPAua05uIHltLnWCPHrN4LJm936hW5tG5uT72nfIWJAuitOyRxRAc
         kB2mcQ2NolCjuilnD8ztQG9UfFpafIoWQgtOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nP9MOB+NRJcIZvAbkEER1wMU4XBwsFVpcXFNKANe0X8=;
        b=P7ZekM4d9zwLUj8c84/XjP1mpy6U6WVjLxQ1z4UsGc5BP7mWO444DvxwdHx0oz8zT2
         CCzj+Uw8Klr99JMhHqYIFAKrCOm0JJO1bN78Pjxm2kInoSzkiNYzbxVCzQolstPIgWsp
         5sXracyJy8LljfckiQOwoPuPUvVm28MBOOXznCmcV3r0Nw5MDdEwWLbomvPEyAH/mOd1
         hSazZC72E+KvkPDO+ESR8VpRJhSN/19XGGigJj4Z/rWcd2u0QFSPkDxqPMKlRt+9hygM
         cUa4llgc74+jBrA3uIKIlDU+Fw+1u5M00TDdFsuXxc+CZF9TzReDvaNNRBvfP40L/L9v
         eOFw==
X-Gm-Message-State: AOAM533iKn1b7fkasRLK3Ppj79h9hsDUvYXeckYN/rDCw1w3zXZi4kwm
        ViDDCzCxu60xFa8Gx0ORLjski5KI5ng=
X-Google-Smtp-Source: ABdhPJykIL9KNzrWb72K3NVL+V2g/6mdC3SH7CAQEoT09C7y7QbvAegOLkcv21ECmp0YTrkrfLSkzQ==
X-Received: by 2002:a1c:9e13:: with SMTP id h19mr2939010wme.107.1591258361040;
        Thu, 04 Jun 2020 01:12:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:12:40 -0700 (PDT)
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
Subject: [PATCH 07/18] drm/atomic-helper: Add dma-fence annotations
Date:   Thu,  4 Jun 2020 10:12:13 +0200
Message-Id: <20200604081224.863494-8-daniel.vetter@ffwll.ch>
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

This is a bit disappointing since we need to split the annotations
over all the different parts.

I was considering just leaking the critical section into the
->atomic_commit_tail callback of each driver. But that would mean we
need to pass the fence_cookie into each driver (there's a total of 13
implementations of this hook right now), so bad flag day. And also a
bit leaky abstraction.

Hence just do it function-by-function.

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
 drivers/gpu/drm/drm_atomic_helper.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 7cd7fe0d57b4..bfcc7857a9a1 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1549,6 +1549,7 @@ EXPORT_SYMBOL(drm_atomic_helper_wait_for_flip_done);
 void drm_atomic_helper_commit_tail(struct drm_atomic_state *old_state)
 {
 	struct drm_device *dev = old_state->dev;
+	bool fence_cookie = dma_fence_begin_signalling();
 
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
 
@@ -1560,6 +1561,8 @@ void drm_atomic_helper_commit_tail(struct drm_atomic_state *old_state)
 
 	drm_atomic_helper_commit_hw_done(old_state);
 
+	dma_fence_end_signalling(fence_cookie);
+
 	drm_atomic_helper_wait_for_vblanks(dev, old_state);
 
 	drm_atomic_helper_cleanup_planes(dev, old_state);
@@ -1579,6 +1582,7 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_tail);
 void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
 {
 	struct drm_device *dev = old_state->dev;
+	bool fence_cookie = dma_fence_begin_signalling();
 
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
 
@@ -1591,6 +1595,8 @@ void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
 
 	drm_atomic_helper_commit_hw_done(old_state);
 
+	dma_fence_end_signalling(fence_cookie);
+
 	drm_atomic_helper_wait_for_vblanks(dev, old_state);
 
 	drm_atomic_helper_cleanup_planes(dev, old_state);
@@ -1606,6 +1612,9 @@ static void commit_tail(struct drm_atomic_state *old_state)
 	ktime_t start;
 	s64 commit_time_ms;
 	unsigned int i, new_self_refresh_mask = 0;
+	bool fence_cookie;
+
+	fence_cookie = dma_fence_begin_signalling();
 
 	funcs = dev->mode_config.helper_private;
 
@@ -1634,6 +1643,8 @@ static void commit_tail(struct drm_atomic_state *old_state)
 		if (new_crtc_state->self_refresh_active)
 			new_self_refresh_mask |= BIT(i);
 
+	dma_fence_end_signalling(fence_cookie);
+
 	if (funcs && funcs->atomic_commit_tail)
 		funcs->atomic_commit_tail(old_state);
 	else
@@ -1789,6 +1800,7 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 			     bool nonblock)
 {
 	int ret;
+	bool fence_cookie;
 
 	if (state->async_update) {
 		ret = drm_atomic_helper_prepare_planes(dev, state);
@@ -1811,6 +1823,8 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 	if (ret)
 		return ret;
 
+	fence_cookie = dma_fence_begin_signalling();
+
 	if (!nonblock) {
 		ret = drm_atomic_helper_wait_for_fences(dev, state, true);
 		if (ret)
@@ -1848,6 +1862,7 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 	 */
 
 	drm_atomic_state_get(state);
+	dma_fence_end_signalling(fence_cookie);
 	if (nonblock)
 		queue_work(system_unbound_wq, &state->commit_work);
 	else
@@ -1856,6 +1871,7 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 	return 0;
 
 err:
+	dma_fence_end_signalling(fence_cookie);
 	drm_atomic_helper_cleanup_planes(dev, state);
 	return ret;
 }
-- 
2.26.2

