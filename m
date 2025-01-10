Return-Path: <linux-rdma+bounces-6959-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7686CA096CE
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 17:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE9D188CB0B
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26313212B0B;
	Fri, 10 Jan 2025 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZAtduALz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55320551F
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525387; cv=none; b=OGKH+Co0/bKpGSEN0jTalBJPmWCvz/jEni0U0/YdAyvGZUh9fAIRbonHd4iSYf+6p7LUrOaVyI8o+3Vj8yHkn8Y0I5fuEezGXU2saEF11A0KggF8jEr4yL7lZOTheiI5KnYfKy2P3Ab/rpI78HUJr4dHb1rj80lZ2u/G5k+Nzv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525387; c=relaxed/simple;
	bh=LZxH2CKR6cMgDrtKerup8m5/Xpf+osO2v/95CO2b72s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h9AcaUA8/EaE3QlT+soeYuN76Ptb67yoLyHLiAb1R+kw3Ap/fGtfPlfd6hWKNF6l3ZHC8UO31KZZIi9j8zwVe55qC5xESXBMO/pswT+x8PudYpSVHLcA/q3sKeDL5WgVX7Yqm4I0hoieA6LkC4qkh0AlgBNAv3ScBv3o4kYb8dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZAtduALz; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736525378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=prhRDDQ/AEqH4e4E7BwYjV/yAiIquHSatrXOwb6W1lQ=;
	b=ZAtduALzBjQrZNHdEhuf9KEUxb3WDQoGzl4CDS8vHnwhBJDTqhnN+nymgKbry1lTWi8PIx
	70YJov6EQpYcDH+I8msglcDoidQHn0vqtUzQOgMCiBbA6R8zHU6ZmiDwb6brv9FZG0aGLs
	lSTbR3RmquQCKyP+VMRa8z5pNHmQS5o=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] RDMA/rxe: Fix the warning "__rxe_cleanup+0x12c/0x170 [rdma_rxe]"
Date: Fri, 10 Jan 2025 17:09:27 +0100
Message-Id: <20250110160927.55014-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The Call Trace is as below:
"
  <TASK>
  ? show_regs.cold+0x1a/0x1f
  ? __rxe_cleanup+0x12c/0x170 [rdma_rxe]
  ? __warn+0x84/0xd0
  ? __rxe_cleanup+0x12c/0x170 [rdma_rxe]
  ? report_bug+0x105/0x180
  ? handle_bug+0x46/0x80
  ? exc_invalid_op+0x19/0x70
  ? asm_exc_invalid_op+0x1b/0x20
  ? __rxe_cleanup+0x12c/0x170 [rdma_rxe]
  ? __rxe_cleanup+0x124/0x170 [rdma_rxe]
  rxe_destroy_qp.cold+0x24/0x29 [rdma_rxe]
  ib_destroy_qp_user+0x118/0x190 [ib_core]
  rdma_destroy_qp.cold+0x43/0x5e [rdma_cm]
  rtrs_cq_qp_destroy.cold+0x1d/0x2b [rtrs_core]
  rtrs_srv_close_work.cold+0x1b/0x31 [rtrs_server]
  process_one_work+0x21d/0x3f0
  worker_thread+0x4a/0x3c0
  ? process_one_work+0x3f0/0x3f0
  kthread+0xf0/0x120
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x22/0x30
  </TASK>
"
When too many rdma resources are allocated, rxe needs more time to
handle these rdma resources. Sometimes with the current timeout, rxe
can not release the rdma resources correctly.

Compared with other rdma drivers, a bigger timeout is used.

Fixes: 215d0a755e1b ("RDMA/rxe: Stop lookup of partially built objects")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 67567d62195e..d9cb682fd71f 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -178,7 +178,6 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 {
 	struct rxe_pool *pool = elem->pool;
 	struct xarray *xa = &pool->xa;
-	static int timeout = RXE_POOL_TIMEOUT;
 	int ret, err = 0;
 	void *xa_ret;
 
@@ -202,19 +201,19 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 	 * return to rdma-core
 	 */
 	if (sleepable) {
-		if (!completion_done(&elem->complete) && timeout) {
+		if (!completion_done(&elem->complete)) {
 			ret = wait_for_completion_timeout(&elem->complete,
-					timeout);
+					msecs_to_jiffies(50000));
 
 			/* Shouldn't happen. There are still references to
 			 * the object but, rather than deadlock, free the
 			 * object or pass back to rdma-core.
 			 */
 			if (WARN_ON(!ret))
-				err = -EINVAL;
+				err = -ETIMEDOUT;
 		}
 	} else {
-		unsigned long until = jiffies + timeout;
+		unsigned long until = jiffies + RXE_POOL_TIMEOUT;
 
 		/* AH objects are unique in that the destroy_ah verb
 		 * can be called in atomic context. This delay
@@ -226,7 +225,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 			mdelay(1);
 
 		if (WARN_ON(!completion_done(&elem->complete)))
-			err = -EINVAL;
+			err = -ETIMEDOUT;
 	}
 
 	if (pool->cleanup)
-- 
2.34.1


