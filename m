Return-Path: <linux-rdma+bounces-12794-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BEBB29312
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 14:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33686188B619
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 12:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9B813B797;
	Sun, 17 Aug 2025 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQTDWsOF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938D173
	for <linux-rdma@vger.kernel.org>; Sun, 17 Aug 2025 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755434296; cv=none; b=NKz/n+03YVCBBZpcZQk4JUtMFKQK4QVQ1jvOeTVKn263CXUuclmBZ2XWrISGcqxPfPd+vJPJL6A51IAMa/rh5R/m4lPERJUnh6sxxe0JoGyhvEZ0cVIL92hvEAesGv+zg737BOVJMyBDBTA4oS57o1EJJ2ZmM1sWxuMR/zCJcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755434296; c=relaxed/simple;
	bh=lwREUqYFALSaQ28bWCCdsjOF4FXmfskQjSU/BaXhsoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBx/z+MpNFuHBgRjHb6AMjUd4Vji3wfOYcnOxtQwueNhCT8GvHmPQdjnX3G9uYKgtWRhRu2SC/Nt51+a5J6NNJUQ83mWQ/2wuVTUDoWPrB9Qgxr5kPfRct+xxBfCq8tr+0HNr1j0AOOni0XKQ/mHObjifS1XwauwZ5k6njkMGts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQTDWsOF; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b471754c159so2163130a12.3
        for <linux-rdma@vger.kernel.org>; Sun, 17 Aug 2025 05:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755434294; x=1756039094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cnE5imnE73CzbpUqci1dnE6bDLz14n9UrJFwBiqs1UU=;
        b=CQTDWsOFbXHImsU19f/moCKx3cfm7UwHN4kOR7aSL+tnj87EDEOX3/FN7oLVmssdrN
         Pj9LlFFHLioMNhSChuvmJy2Pfyf5aj8TcduyCQiiqbgZf7yBrQHy0CBS1DS6l0JDQYgx
         30IRWqC/+78zL91H5WPCuRonkXgou3lWsbTYMKdgxCP28Ke9q5+nox31/TMPmwiaXJFy
         yGr93rfLxQJ73AyNVici/1Mqxp+D/rd+z8mYg53eoNNIumX/DYL94cmkBH2hPCP2T63q
         6jzpWBgGjbssgCUQGisqfsxPes3uPS7IP+XH1quftyxz3m47aE0tUJm9oy94jxCRJOfg
         3qMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755434294; x=1756039094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnE5imnE73CzbpUqci1dnE6bDLz14n9UrJFwBiqs1UU=;
        b=rN0MiXhxF7tYvMTMKFu27ZgzJU6+jWvb2vmKw7kB3/+OcNUVEFXHBfKUu54lMCDvdN
         EHPKqkwPHW/VkdCBPddKdDSAiOfdChdj+rq4lDAb5fcB516ascl4a62AfMyrTndwmfaO
         MghCne6tL94vnNu6yNGE64ry6wpUESuevhRcF8ncQwn7eB2na/cdG2W7es7oeajvnlPE
         Y11NdQBZU28ZkDz1J55ElxEL9VyYBKEnu4uOBCDPsG3+VI5gm4nvH5RWF/VxBauPBsRy
         YOdExqqhESqryN0rI4qKPkSLyjGSuv4HiAmN0zXsgeFf5dUplrmnknxLtEDiX6jchrTH
         e9Sg==
X-Gm-Message-State: AOJu0YxoTYHUJH+3wZWqorErpYYxWJZZRc2u+WshfdxmyiLm3zd8owmj
	AfrhU1V7x2OkgrSmUNL0l+giPHhbi2ql9cJlJ+sZ15tSYx3l3+5Ubrgb5JX6Jg==
X-Gm-Gg: ASbGncs1d2PFgbRcylWGIufg2EwUD90eg0u2xbBFt80yUqIUQzDXCaIAfbVqB3Z+HnG
	Ir4sW/7ENgzxHMUKkq95Rqo+1SWmPQZ1zBthVW++/gfsebaLvkCcoOxaTy1Bcwtsh1d6DDNPjFl
	vJFPyAJbX4Q+rHBpAWXCfecZKj/vhd7zVH3Qp2eUAmPT/IZgpnO4MLaJO7fm/IQGgYFJ95TeqQH
	x5crNuz+BhQrGb25Eu6xozeE24nmQLDddfPymnYSO6FLTuRjI9JqfhliuiUIwGwVGU7dYojNuC0
	csJUcg8+GCSO5NPAPBVBmnGge7yjqMBDfRNMH9dhalqp7X5cSCOOrwxPoLKBjihK8hBiGwHyyEJ
	U4gltPMcuuSj3XReNUS23yUp8e0lutSWeu3lD2Ut7JZZOpU5RlayS6NiD
X-Google-Smtp-Source: AGHT+IFC/SbZmIsu83acBZ5vjpdMC+zHcHm+Sxm5v46TGwN8x1haYwX2vpvtkSHFpCW6d1hkQfkOzQ==
X-Received: by 2002:a17:902:d50f:b0:243:12d5:db5f with SMTP id d9443c01a7336-24478fd2b63mr87487675ad.48.1755434293803;
        Sun, 17 Aug 2025 05:38:13 -0700 (PDT)
Received: from trigkey.. (FL1-125-195-176-151.tky.mesh.ad.jp. [125.195.176.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f4c3sm54636125ad.84.2025.08.17.05.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 05:38:13 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: yanjun.zhu@linux.dev,
	philipp.reisner@linbit.com,
	Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH for-rc v1] RDMA/rxe: Avoid CQ polling hang triggered by CQ resize
Date: Sun, 17 Aug 2025 12:37:52 +0000
Message-ID: <20250817123752.153735-1-dskmtsd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running the test_resize_cq testcase from rdma-core, polling a
completion queue from userspace may occasionally hang and eventually fail
with a timeout:
=====
ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
Test resize CQ, start with specific value and then increase and decrease
----------------------------------------------------------------------
Traceback (most recent call last):
    File "/root/deb/rdma-core/tests/test_cq.py", line 135, in test_resize_cq
      u.poll_cq(self.client.cq)
    File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
      wcs = _poll_cq(cq, count, data)
            ^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
      raise PyverbsError(f'Got timeout on polling ({count} CQEs remaining)')
pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs
remaining)
=====

The issue is caused when rxe_cq_post() fails to post a CQE due to the queue
being temporarily full, and the CQE is effectively lost. To mitigate this,
add a bounded busy-wait with fallback rescheduling so that CQE does not get
lost.

Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index fffd144d509e..7b0fba63204e 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -84,14 +84,36 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int cqe,
 /* caller holds reference to cq */
 int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 {
+	unsigned long flags;
+	u32 spin_cnt = 3000;
 	struct ib_event ev;
-	int full;
 	void *addr;
-	unsigned long flags;
+	int full;
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
 
 	full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
+	if (likely(!full))
+		goto post_queue;
+
+	/* constant backoff until queue is ready */
+	while (spin_cnt--) {
+		full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
+		if (!full)
+			goto post_queue;
+
+		cpu_relax();
+	}
+
+	/* try giving up cpu and retry */
+	if (full) {
+		spin_unlock_irqrestore(&cq->cq_lock, flags);
+		cond_resched();
+		spin_lock_irqsave(&cq->cq_lock, flags);
+
+		full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
+	}
+
 	if (unlikely(full)) {
 		rxe_err_cq(cq, "queue full\n");
 		spin_unlock_irqrestore(&cq->cq_lock, flags);
@@ -105,6 +127,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 		return -EBUSY;
 	}
 
+ post_queue:
 	addr = queue_producer_addr(cq->queue, QUEUE_TYPE_TO_CLIENT);
 	memcpy(addr, cqe, sizeof(*cqe));
 
-- 
2.43.0


