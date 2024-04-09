Return-Path: <linux-rdma+bounces-1873-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC82289DC19
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 16:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4131F23E05
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 14:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424ED12FF99;
	Tue,  9 Apr 2024 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GZokU8Jn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9523A12F5BD;
	Tue,  9 Apr 2024 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672482; cv=none; b=AEKwtPvgi5v/ix+BA1EqQWDxsLiaDF3reZ93U55wUZLmUUNGLHRuMXFtTJFPwLfkOvGjfU4nNOASCxKK8eU+gSGBFqL/N3L2BZEA9qcluLS6OvgNjnx2bJIm/iqlFzNIUYp6Uj3RdlCx9mgKlHM0dNOoXgHcDdAynrZMQIHlk9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672482; c=relaxed/simple;
	bh=r3ARvPN5ZObWBEzPaxs814rwpfqyWWM6Kki8/3njKXk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=D0ENvhZSjWlxbkVDXF1wV5O9eh9ZO0tNU2THQg8+qX1e7qsDb32MQHphAY32OY/xwrU3L4buo+o0EI3OKH3Y+z55ah6BBG/wv9MfiSHzmknYpn7v4dLX0DPK/urrCFwvwyfl/bO7kBHcVFYj9uQ2WXUpMnxaeIfJBmOBiPtFmQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GZokU8Jn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2307820EA458;
	Tue,  9 Apr 2024 07:21:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2307820EA458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712672473;
	bh=JzakOs7RQnSTrTKG1GCPrXs8j73AU05MCUWlerbOk5M=;
	h=From:To:Cc:Subject:Date:From;
	b=GZokU8JnvqPN+YNKlYGFS2c21jqGR+HQLl5SmpUn4fdwi9yWlVBSNqud0+I06MbqO
	 Eb+2ki/3LiU0nMmnVFvHwnTUFINVvfvSgcImGn3zpgUhVL08rfn40PL80ek8qvZmul
	 WXAtVxEK52VCK29FuaqHllbr8B1GFuyg2y35dZDI=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: remove useless return values from dbg prints
Date: Tue,  9 Apr 2024 07:21:05 -0700
Message-Id: <1712672465-29960-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Remove printing ret value on success as it was always 0.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 4 +---
 drivers/infiniband/hw/mana/mr.c   | 2 +-
 drivers/infiniband/hw/mana/qp.c   | 6 +++---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 4524c6b80748..b31dcff32699 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -261,9 +261,7 @@ int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
 	}
 	queue->umem = umem;
 
-	ibdev_dbg(&mdev->ib_dev,
-		  "create_dma_region ret %d gdma_region 0x%llx\n",
-		  err, queue->gdma_region);
+	ibdev_dbg(&mdev->ib_dev, "created dma region 0x%llx\n", queue->gdma_region);
 
 	return 0;
 free_umem:
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index b70b13484f09..4f13423ecdbd 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -135,7 +135,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	}
 
 	ibdev_dbg(ibdev,
-		  "create_dma_region ret %d gdma_region %llx\n", err,
+		  "created dma region for user-mr 0x%llx\n",
 		  dma_region_handle);
 
 	mr_params.pd_handle = pd->pd_handle;
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index ef0a6dc664d0..6cecf76426d4 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -219,8 +219,8 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		cq->queue.id = cq_spec.queue_index;
 
 		ibdev_dbg(&mdev->ib_dev,
-			  "ret %d rx_object 0x%llx wq id %llu cq id %llu\n",
-			  ret, wq->rx_object, wq->queue.id, cq->queue.id);
+			  "rx_object 0x%llx wq id %llu cq id %llu\n",
+			  wq->rx_object, wq->queue.id, cq->queue.id);
 
 		resp.entries[i].cqid = cq->queue.id;
 		resp.entries[i].wqid = wq->queue.id;
@@ -385,7 +385,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 		goto err_destroy_wq_obj;
 
 	ibdev_dbg(&mdev->ib_dev,
-		  "ret %d qp->qp_handle 0x%llx sq id %llu cq id %llu\n", err,
+		  "qp->qp_handle 0x%llx sq id %llu cq id %llu\n",
 		  qp->qp_handle, qp->raw_sq.id, send_cq->queue.id);
 
 	resp.sqid = qp->raw_sq.id;

base-commit: f10242b3da908dc9d4bfa040e6511a5b86522499
-- 
2.43.0


