Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EC21EDF52
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2020 10:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgFDINI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jun 2020 04:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgFDIM4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jun 2020 04:12:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A89EC05BD1E
        for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2020 01:12:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u26so6243342wmn.1
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jun 2020 01:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tFPcYYVPEczCJNqu565ZZzRL31Ro7iqoJLud+V9/W6s=;
        b=MV7FJtoEKLyy0r+Z0KoFPEtyhRXEwQ/IbBpYLu8LO9Uc78Ax/2RYA4vzBMjtiJcK6p
         AdKwrHzr6dzh+N3ms51V1I6le1IjLWDF+LcV9lCl9LStGwUptD8GwQ/Htx2fZJN8DVly
         sAfPeJLEgUIdNH8S/XB9b4lCyMgUL5KbMtjSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tFPcYYVPEczCJNqu565ZZzRL31Ro7iqoJLud+V9/W6s=;
        b=pVg+00nBcQQ/dsQzenjqpIJCW/b4kK5OY7O2f8rbRCOcsu3KJGp1iDFpHOKT4uMPGt
         +c2r6McNS5pQzBOFa+p655cKqXvrb0KbXf9EqVaI9/Qvr20QQ+Rcr6ogP0RfIIlsPIQ9
         2ctqkCZ+jc0K68iC0N2R8YhqsIlXgbuCdfFxcS1hZkuMu/zKRbGc35Q1hmGUVfiJKwbK
         8Ivif/sLNS89mzBoU4gBanuYMDC1gWZapK2/IaEhusF2MqLpybFCGoH/sYR+x9ml4wfz
         /2rhrOXHeH1Rj8NyFdBfVvgDm4qCSUlxK7IPZOuuNhxlVAzn65GLzfFvUAGXQGrLLZv+
         OQKg==
X-Gm-Message-State: AOAM533DiswUyE87fSDIK2Lcb9DNxLPOxGM8JFpSbFX3mUXUdtKHtUl2
        kVI/rtQgldFU679Lnurh4VS/rg==
X-Google-Smtp-Source: ABdhPJwyTSsHObvqYxt5vjWFqYKxgNRr/Tg50mOhhgXdXRLp1pp0LpRagZgRAkv0R2QBG8+IZNWOoQ==
X-Received: by 2002:a7b:c18a:: with SMTP id y10mr3020133wmi.73.1591258374887;
        Thu, 04 Jun 2020 01:12:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:12:54 -0700 (PDT)
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
Subject: [PATCH 18/18] drm/i915: Annotate dma_fence_work
Date:   Thu,  4 Jun 2020 10:12:24 +0200
Message-Id: <20200604081224.863494-19-daniel.vetter@ffwll.ch>
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

i915 does tons of allocations from this worker, which lockdep catches.

Also generic infrastructure like this with big potential for how
dma_fence or other cross driver contracts work, really should be
reviewed on dri-devel. Implementing custom wheels for everything
within the driver is a classic case of "platform problem" [1]. Which in
upstream we really shouldn't have.

Since there's no quick way to solve these splats (dma_fence_work is
used a bunch in basic buffer management and command submission) like
for amdgpu, I'm giving up at this point here. Annotating i915
scheduler and gpu reset could would be interesting, but since lockdep
is one-shot we can't see what surprises would lurk there.

1: https://lwn.net/Articles/443531/
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
 drivers/gpu/drm/i915/i915_sw_fence_work.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_sw_fence_work.c b/drivers/gpu/drm/i915/i915_sw_fence_work.c
index a3a81bb8f2c3..5b74acadaef5 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence_work.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence_work.c
@@ -17,12 +17,15 @@ static void fence_work(struct work_struct *work)
 {
 	struct dma_fence_work *f = container_of(work, typeof(*f), work);
 	int err;
+	bool fence_cookie;
 
+	fence_cookie = dma_fence_begin_signalling();
 	err = f->ops->work(f);
 	if (err)
 		dma_fence_set_error(&f->dma, err);
 
 	fence_complete(f);
+	dma_fence_end_signalling(fence_cookie);
 	dma_fence_put(&f->dma);
 }
 
-- 
2.26.2

