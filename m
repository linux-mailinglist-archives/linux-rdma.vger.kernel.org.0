Return-Path: <linux-rdma+bounces-5506-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E269AE553
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 14:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D5B1C243DA
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E811DD0D8;
	Thu, 24 Oct 2024 12:46:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA51D9A51;
	Thu, 24 Oct 2024 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773989; cv=none; b=tNkAYHUmXLXArOrfD26BXHIncmhgSkc9PEGrOpE8FIUuI+PFX5r9JSb5tcKiBcXk1pc5OKi+s134zabodV4KBiYpIUk/MDEtFehW2v6RmGP5PHwI7fE1IQMnJERT2VcDBF6OjTfZRYo70UNsXHX3k0OhrztTWI8FcWkes0KMv/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773989; c=relaxed/simple;
	bh=F51Ytz6GiWudGuizbBDr0KrFzqjcWrI6ynhGxglzDhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSf5y9j+rqEB5l3RRovYK7RGi3qxbUILgIfYvnSYnDF33xqwvsCDY+vYZKD4evUdMbAxRrDO9mz1c/lwN1HWYJcdXpP8XdP8pIPT3PpFiZhuvpSN83qH7NfYzTitDdV2w2hbDK4YI5iZsotlUgefbvH/eS0Yij1VOLUNBZuP/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XZ5C74t0wz1HKy8;
	Thu, 24 Oct 2024 20:41:55 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id C3C711400CA;
	Thu, 24 Oct 2024 20:46:17 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Oct 2024 20:46:17 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH v2 for-rc 2/5] RDMA/hns: Fix flush cqe error when racing with destroy qp
Date: Thu, 24 Oct 2024 20:39:57 +0800
Message-ID: <20241024124000.2931869-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241024124000.2931869-1-huangjunxian6@hisilicon.com>
References: <20241024124000.2931869-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: wenglianfa <wenglianfa@huawei.com>

QP needs to be modified to IB_QPS_ERROR to trigger HW flush cqe. But
when this process races with destroy qp, the destroy-qp process may
modify the QP to IB_QPS_RESET first. In this case flush cqe will fail
since it is invalid to modify qp from IB_QPS_RESET to IB_QPS_ERROR.

Add lock and bit flag to make sure pending flush cqe work is completed
first and no more new works will be added.

Fixes: ffd541d45726 ("RDMA/hns: Add the workqueue framework for flush cqe handler")
Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  7 +++++++
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 15 +++++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 73c78005901e..9b51d5a1533f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -593,6 +593,7 @@ struct hns_roce_dev;
 
 enum {
 	HNS_ROCE_FLUSH_FLAG = 0,
+	HNS_ROCE_STOP_FLUSH_FLAG = 1,
 };
 
 struct hns_roce_work {
@@ -656,6 +657,7 @@ struct hns_roce_qp {
 	enum hns_roce_cong_type	cong_type;
 	u8			tc_mode;
 	u8			priority;
+	spinlock_t flush_lock;
 };
 
 struct hns_roce_ib_iboe {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index e85c450e1809..aa42c5a9b254 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5598,8 +5598,15 @@ int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+	unsigned long flags;
 	int ret;
 
+	/* Make sure flush_cqe() is completed */
+	spin_lock_irqsave(&hr_qp->flush_lock, flags);
+	set_bit(HNS_ROCE_STOP_FLUSH_FLAG, &hr_qp->flush_flag);
+	spin_unlock_irqrestore(&hr_qp->flush_lock, flags);
+	flush_work(&hr_qp->flush_work.work);
+
 	ret = hns_roce_v2_destroy_qp_common(hr_dev, hr_qp, udata);
 	if (ret)
 		ibdev_err(&hr_dev->ib_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index dcaa370d4a26..2ad03ecdbf8e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -90,11 +90,18 @@ static void flush_work_handle(struct work_struct *work)
 void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
 	struct hns_roce_work *flush_work = &hr_qp->flush_work;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hr_qp->flush_lock, flags);
+	/* Exit directly after destroy_qp() */
+	if (test_bit(HNS_ROCE_STOP_FLUSH_FLAG, &hr_qp->flush_flag)) {
+		spin_unlock_irqrestore(&hr_qp->flush_lock, flags);
+		return;
+	}
 
-	flush_work->hr_dev = hr_dev;
-	INIT_WORK(&flush_work->work, flush_work_handle);
 	refcount_inc(&hr_qp->refcount);
 	queue_work(hr_dev->irq_workq, &flush_work->work);
+	spin_unlock_irqrestore(&hr_qp->flush_lock, flags);
 }
 
 void flush_cqe(struct hns_roce_dev *dev, struct hns_roce_qp *qp)
@@ -1140,6 +1147,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				     struct ib_udata *udata,
 				     struct hns_roce_qp *hr_qp)
 {
+	struct hns_roce_work *flush_work = &hr_qp->flush_work;
 	struct hns_roce_ib_create_qp_resp resp = {};
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_ib_create_qp ucmd = {};
@@ -1148,9 +1156,12 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	mutex_init(&hr_qp->mutex);
 	spin_lock_init(&hr_qp->sq.lock);
 	spin_lock_init(&hr_qp->rq.lock);
+	spin_lock_init(&hr_qp->flush_lock);
 
 	hr_qp->state = IB_QPS_RESET;
 	hr_qp->flush_flag = 0;
+	flush_work->hr_dev = hr_dev;
+	INIT_WORK(&flush_work->work, flush_work_handle);
 
 	if (init_attr->create_flags)
 		return -EOPNOTSUPP;
-- 
2.33.0


