Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0681EDF7F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2020 10:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgFDINo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jun 2020 04:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgFDIMq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jun 2020 04:12:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAE2C08C5C0
        for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2020 01:12:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v19so4303842wmj.0
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jun 2020 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QpRcEBLBFti7+uwIPhFpaG5e28opFzcZsYVebGatC0I=;
        b=IEeSF84MYGmRcfj4sMCd4J+zYZKwLXaJxMSpi3fUTEKdsfossRgSDuWbe+zZ21xpAx
         3y3tAVuXjHWRsIi+zJrg554cTrk73ezXwhTX3+vOBsrV//Okft/By/0MmGxexiInifje
         DtXukw743V5Gql830qv9EKpT7CFp/fzcgsUTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QpRcEBLBFti7+uwIPhFpaG5e28opFzcZsYVebGatC0I=;
        b=ELfAlGRG8R2AvcvWCV1l+UPb0x/s3S4ZOrmqMAbroHbTNM0hqtyWdorGYT1BCGcE6e
         FT3VvJlSnJK8vf2ZbIIXqa0/ZEnE/9rs9uuTPKx6Fz0Sp3th0yutgqf8Qabp70zWLF09
         VgFnlihbg1jGc9LNYixgMU8NKbzL9Ih6VPCQsBB22G4fbUN6QjYY/475axPhMfmUpeb/
         8QYN/sGYuPp9Rp1g0yiHzULYKVfR8A/pOQwqlXypjKYBKsGlT6xxiIYPVo+vyfjyKjrs
         3LVPlRZw3MmOZ8JVGkujfrfF/qdpFcuR1HvFCJs2jOveY8zM2aOvEftMMsMZ50YpbyE7
         jmLg==
X-Gm-Message-State: AOAM531YJ3NMt0bS5AlHOv0Ui38Ii11UzG5t+Zu+FRNDRYHcCBzWxQj1
        3fpQPUKQ/bRwmcHT+BGOjIW+IA==
X-Google-Smtp-Source: ABdhPJzK094CFf7KReF2ex18c6m+K0h2mhk+2HMb53cWYgjLEFwQL7H9L4hoB3ty2HpwgAOoCcUgiQ==
X-Received: by 2002:a1c:5502:: with SMTP id j2mr3075373wmb.56.1591258363614;
        Thu, 04 Jun 2020 01:12:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:12:42 -0700 (PDT)
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
Subject: [PATCH 09/18] drm/scheduler: use dma-fence annotations in main thread
Date:   Thu,  4 Jun 2020 10:12:15 +0200
Message-Id: <20200604081224.863494-10-daniel.vetter@ffwll.ch>
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

If the scheduler rt thread gets stuck on a mutex that we're holding
while waiting for gpu workloads to complete, we have a problem.

Add dma-fence annotations so that lockdep can check this for us.

I've tried to quite carefully review this, and I think it's at the
right spot. But obviosly no expert on drm scheduler.

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
 drivers/gpu/drm/scheduler/sched_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 2f319102ae9f..06a736e506ad 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -763,9 +763,12 @@ static int drm_sched_main(void *param)
 	struct sched_param sparam = {.sched_priority = 1};
 	struct drm_gpu_scheduler *sched = (struct drm_gpu_scheduler *)param;
 	int r;
+	bool fence_cookie;
 
 	sched_setscheduler(current, SCHED_FIFO, &sparam);
 
+	fence_cookie = dma_fence_begin_signalling();
+
 	while (!kthread_should_stop()) {
 		struct drm_sched_entity *entity = NULL;
 		struct drm_sched_fence *s_fence;
@@ -823,6 +826,9 @@ static int drm_sched_main(void *param)
 
 		wake_up(&sched->job_scheduled);
 	}
+
+	dma_fence_end_signalling(fence_cookie);
+
 	return 0;
 }
 
-- 
2.26.2

