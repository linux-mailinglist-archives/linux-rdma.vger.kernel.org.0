Return-Path: <linux-rdma+bounces-1976-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2688AA05E
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Apr 2024 18:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF98B21ADC
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Apr 2024 16:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C100171E5A;
	Thu, 18 Apr 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BNagOu2l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9556171651;
	Thu, 18 Apr 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459133; cv=none; b=D6AQQtJrzR1eUFci0Q9aF2LbJxP3yXJjsWm0YMniJfAqsowKg3J9KkWr4qmr8uOUvsrAszVaidZFSkAfXY3PGpojKPOerFh78GnBV+h6Weanp8t0t4T9dx98FzMxHNgT4LokrSWQRPTe79t8kbo0ZHlshqheKMXkHQvJtc+3boo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459133; c=relaxed/simple;
	bh=66ULFsYlF4+P/zd59wyz8wFV4wTbmXZtbpdURsGbB9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dY2gjca0zGPmXxapDK3zD5I6Ggrx3DGM2P5eJ+ILIyu60/LrLa0Uztbamq1oVfab/Vx7fLSPII4GihdP1MU8qYLHYmSckjlGlDf3dZlRQB7equ8UzSlqatKziKsqwdshE9ICorpo7AcvI+Onq3vwJbaa3DjTl69WW+ecjSwq7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BNagOu2l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 59E6F20FD8D9;
	Thu, 18 Apr 2024 09:52:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 59E6F20FD8D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713459131;
	bh=aDAn/WfFY23tx012r1yhsWoDE/LbuHpjESH/aHdeOFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BNagOu2lGE5nLOHAV/VW7C/iH6LJL9PXdUN4qc1RCqrTRwhSviJCh9vvVBbd1QWoj
	 RY/vsWQMCCrfTesxn00JAhYZDRYK086ptwJjB92l46+dGSiFWPbtY3Debkr4OU58q/
	 lLN1ZHaXoJiZVAHGuUqFXfU/xk22lql/hhyDuucM=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 3/6] RDMA/mana_ib: replace duplicate cqe with buf_size
Date: Thu, 18 Apr 2024 09:52:02 -0700
Message-Id: <1713459125-14914-4-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Replace cqe with buf_size in struct mana_ib_cq.
The cqe field is already present in struct ib_cq and can be accessed there.
The buf_size field is required for mana RNIC CQs.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      | 4 ++--
 drivers/infiniband/hw/mana/mana_ib.h | 2 +-
 drivers/infiniband/hw/mana/qp.c      | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index dc931b9..0467ee8 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -33,8 +33,8 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		return -EINVAL;
 	}
 
-	cq->cqe = attr->cqe;
-	err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE, &cq->queue);
+	cq->buf_size = attr->cqe * COMP_ENTRY_SIZE;
+	err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->buf_size, &cq->queue);
 	if (err) {
 		ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n", err);
 		return err;
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 9162f29..9c07021 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -90,7 +90,7 @@ struct mana_ib_mr {
 struct mana_ib_cq {
 	struct ib_cq ibcq;
 	struct mana_ib_queue queue;
-	int cqe;
+	u32 buf_size;
 	u32 comp_vector;
 	mana_handle_t  cq_handle;
 };
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 280e85a..c4fb8b4 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -196,7 +196,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		wq_spec.queue_size = wq->wq_buf_size;
 
 		cq_spec.gdma_region = cq->queue.gdma_region;
-		cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
+		cq_spec.queue_size = cq->buf_size;
 		cq_spec.modr_ctx_id = 0;
 		eq = &mpc->ac->eqs[cq->comp_vector];
 		cq_spec.attached_eq = eq->eq->id;
@@ -355,7 +355,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	wq_spec.queue_size = ucmd.sq_buf_size;
 
 	cq_spec.gdma_region = send_cq->queue.gdma_region;
-	cq_spec.queue_size = send_cq->cqe * COMP_ENTRY_SIZE;
+	cq_spec.queue_size = send_cq->buf_size;
 	cq_spec.modr_ctx_id = 0;
 	eq_vec = send_cq->comp_vector;
 	eq = &mpc->ac->eqs[eq_vec];
-- 
2.43.0


