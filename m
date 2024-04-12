Return-Path: <linux-rdma+bounces-1923-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046338A2A20
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3D21F2263C
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 09:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE2150A6E;
	Fri, 12 Apr 2024 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hX3ioNvF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB6E50291;
	Fri, 12 Apr 2024 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911672; cv=none; b=PTvA2AmGtYKR3YEp+7wG4tHmWG6Btep6q/qgbZwzdzxPRHduokcrBVQZ52sS66Pl4bZQt40fOj8tDea/VC4T5hYUC4JvqqJlUFKu34GrHaCXWUSdt4ZajH4HcW1SR34uzmJL0l9LR2Nj/eoSxwsye3achA0LxcCSn3PecmUj5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911672; c=relaxed/simple;
	bh=+bSJfphEhdM2khUxYW99gCY/F7bVezIrSu/oMDC0xX0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jyUfkUSaxUWUJx6c6U5tCwBDJbPlLnpF2Di/2xUgHT14xkQ+gN3Zo5NEhcYvB077vNLsb+WNhQxdi1yyz5fsJG3qXEeoKuJRCiQ+UZY/p6QGodH++4bL3Zv/6g2ABRpADvDGAVE2CU+mVzTvmFip51Pz6hh3znQ+N/cgOen4S38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hX3ioNvF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 48D5F20ECCAD;
	Fri, 12 Apr 2024 01:47:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 48D5F20ECCAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712911670;
	bh=ZipZCVZ40QrnKt/aK4/37pyZx59+dD3ut/pz+jtUHVg=;
	h=From:To:Cc:Subject:Date:From;
	b=hX3ioNvFo2rHBKVIQhYNxoJGIRIofxlMgIGnh6oPA+IGOeGNk6g2b+jfRZzxjpgr5
	 mGE+/RdQZxkMMMfCxfaM9pVYMLJa4mDhQet1zQJ74y5zQAPN9aZvxB2O9ogcOQ6lRc
	 1W0gxp6Maa8x0pAG+YUMIwPwJuQMbHdELShI/nnI=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: Use num_comp_vectors of ib_device
Date: Fri, 12 Apr 2024 01:47:36 -0700
Message-Id: <1712911656-17352-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Use num_comp_vectors of struct ib_device instead of max_num_queues
from gdma_context.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c     | 7 +------
 drivers/infiniband/hw/mana/device.c | 2 +-
 drivers/infiniband/hw/mana/qp.c     | 4 ++--
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index c9129218f1be..dc931b9c3491 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -12,19 +12,14 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_create_cq ucmd = {};
 	struct mana_ib_dev *mdev;
-	struct gdma_context *gc;
 	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	gc = mdev_to_gc(mdev);
 
 	if (udata->inlen < sizeof(ucmd))
 		return -EINVAL;
 
-	if (attr->comp_vector > gc->max_num_queues)
-		return -EINVAL;
-
-	cq->comp_vector = attr->comp_vector;
+	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
 
 	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
 	if (err) {
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 6fa902ee80a6..07e97de31886 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -74,7 +74,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	 * num_comp_vectors needs to set to the max MSIX index
 	 * when interrupts and event queues are implemented
 	 */
-	dev->ib_dev.num_comp_vectors = 1;
+	dev->ib_dev.num_comp_vectors = mdev->gdma_context->max_num_queues;
 	dev->ib_dev.dev.parent = mdev->gdma_context->dev;
 
 	ret = mana_gd_register_device(&mdev->gdma_context->mana_ib);
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index ef0a6dc664d0..f5c743db3a94 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -200,7 +200,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		cq_spec.gdma_region = cq->queue.gdma_region;
 		cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
 		cq_spec.modr_ctx_id = 0;
-		eq = &mpc->ac->eqs[cq->comp_vector % gc->max_num_queues];
+		eq = &mpc->ac->eqs[cq->comp_vector];
 		cq_spec.attached_eq = eq->eq->id;
 
 		ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,
@@ -359,7 +359,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	cq_spec.gdma_region = send_cq->queue.gdma_region;
 	cq_spec.queue_size = send_cq->cqe * COMP_ENTRY_SIZE;
 	cq_spec.modr_ctx_id = 0;
-	eq_vec = send_cq->comp_vector % gc->max_num_queues;
+	eq_vec = send_cq->comp_vector;
 	eq = &mpc->ac->eqs[eq_vec];
 	cq_spec.attached_eq = eq->eq->id;
 

base-commit: f10242b3da908dc9d4bfa040e6511a5b86522499
-- 
2.43.0


