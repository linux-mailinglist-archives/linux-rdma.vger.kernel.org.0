Return-Path: <linux-rdma+bounces-3942-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A647D93AE30
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 10:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3031F243D5
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 08:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095B613A418;
	Wed, 24 Jul 2024 08:57:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795BE14A62F
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811451; cv=none; b=lJjLwb1LZTNtN01VuvQFPaXEXRfg+Fe3Yu5rRGQUqC1hKJep+gWngY/BaBB3brOYU3O1Pss+xxQO8qH6ZlGEohwtF9DVg59WT7vHdcf2XSd5T77xR6AZ+CFb/3p8wqvQUjUaBtR1H9cO3nQC3O+WaqxXNoyOPiBgwHUw8vNgY14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811451; c=relaxed/simple;
	bh=oBWrqCAjgch3EyJ+gZUxSCM0fZ5fdID8KfOL+kaT1v4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BtmPlLf59anVkyIwL5G3IXrV7isfqYPU6TRZ5irua13zanCEQELkQZUrjp8zxEy1v9lPbkG/z6dKI2tLBT8MJ5HuGV6VtJ0qIo2l6fWkQBymRmTeecn2Cpmp3pdeM9bLiL/7scEcPAmUYkEV1xlM/DBGlbIpUD35bPsNL/0TwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from sonada.blr.asicdesigners.com (sonada.blr.asicdesigners.com [10.193.186.190])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 46O8ebFv002954;
	Wed, 24 Jul 2024 01:40:38 -0700
From: Showrya M N <showrya@chelsio.com>
To: jgg@nvidia.com, leonro@nvidia.com, bmt@zurich.ibm.com
Cc: linux-rdma@vger.kernel.org, Showrya M N <showrya@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH for-rc] RDMA/siw: Remove NETDEV_GOING_DOWN event handler
Date: Wed, 24 Jul 2024 14:24:28 +0530
Message-Id: <20240724085428.3813-1-showrya@chelsio.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Toggling link while running NVME-oF over siw hits a kernel panic
due to race condition within siw_handler and ib_destroy_qp().
The IB_EVENT_PORT_ERR event can alone handle destroying qps.
therefore remove unwanted processing in siw.

Suggested-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Showrya M N <showrya@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/sw/siw/siw.h      |  2 --
 drivers/infiniband/sw/siw/siw_main.c | 37 ----------------------------
 2 files changed, 39 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 75253f2b3e3d..86d4d6a2170e 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -94,8 +94,6 @@ struct siw_device {
 	atomic_t num_mr;
 	atomic_t num_srq;
 	atomic_t num_ctx;
-
-	struct work_struct netdev_down;
 };
 
 struct siw_ucontext {
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 61ad8ca3d1a2..9a50a9dcce39 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -364,39 +364,6 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 	return NULL;
 }
 
-/*
- * Network link becomes unavailable. Mark all
- * affected QP's accordingly.
- */
-static void siw_netdev_down(struct work_struct *work)
-{
-	struct siw_device *sdev =
-		container_of(work, struct siw_device, netdev_down);
-
-	struct siw_qp_attrs qp_attrs;
-	struct list_head *pos, *tmp;
-
-	memset(&qp_attrs, 0, sizeof(qp_attrs));
-	qp_attrs.state = SIW_QP_STATE_ERROR;
-
-	list_for_each_safe(pos, tmp, &sdev->qp_list) {
-		struct siw_qp *qp = list_entry(pos, struct siw_qp, devq);
-
-		down_write(&qp->state_lock);
-		WARN_ON(siw_qp_modify(qp, &qp_attrs, SIW_QP_ATTR_STATE));
-		up_write(&qp->state_lock);
-	}
-	ib_device_put(&sdev->base_dev);
-}
-
-static void siw_device_goes_down(struct siw_device *sdev)
-{
-	if (ib_device_try_get(&sdev->base_dev)) {
-		INIT_WORK(&sdev->netdev_down, siw_netdev_down);
-		schedule_work(&sdev->netdev_down);
-	}
-}
-
 static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
 			    void *arg)
 {
@@ -418,10 +385,6 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
 		siw_port_event(sdev, 1, IB_EVENT_PORT_ACTIVE);
 		break;
 
-	case NETDEV_GOING_DOWN:
-		siw_device_goes_down(sdev);
-		break;
-
 	case NETDEV_DOWN:
 		sdev->state = IB_PORT_DOWN;
 		siw_port_event(sdev, 1, IB_EVENT_PORT_ERR);
-- 
2.39.1


