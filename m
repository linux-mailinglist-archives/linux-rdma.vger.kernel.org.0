Return-Path: <linux-rdma+bounces-5478-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE989AA101
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 13:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5EB1C22430
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 11:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37D319D8A7;
	Tue, 22 Oct 2024 11:16:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00A919D06E;
	Tue, 22 Oct 2024 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595801; cv=none; b=Hcu+tOjkpm3INEgSmLoUZGp3Nlhp2GPMQ8LtwnWUEDYaePLs597G6IWBkImOGRows68CqO9bnHCxcPBuVmCFNKsZ9RAs3qCWFFe51tvkUU4p0AoI/Ekd4+5mOZpEN2Lp1Y2naOGvJ1cleettOF3/NKB31e68Yim3m0in0xROBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595801; c=relaxed/simple;
	bh=Pn7Y/iVUgpru4asH9jpIpWBrH8bp0qSMphbIyViKTCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hf5h38Od92bPNGf3hDoVjwYa5t123lH0jMdxIQZj/De2hfXtsPr9yf3twTkDKcf0uJ0omd9np6gjW2UA6dyH1L5m2gorHwpnaJ/DgvhQJsXpDu8CHsxklR7lbLR862zworgvw9Jme9esqZ6n1MnUyJB5ZtTVRMzpimAD1O6qbKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XXqMB6bdsz10N3d;
	Tue, 22 Oct 2024 19:14:30 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 901301800DB;
	Tue, 22 Oct 2024 19:16:31 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Oct 2024 19:16:31 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH for-rc 2/5] RDMA/hns: Fix flush cqe error when racing with destroy qp
Date: Tue, 22 Oct 2024 19:10:14 +0800
Message-ID: <20241022111017.946170-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241022111017.946170-1-huangjunxian6@hisilicon.com>
References: <20241022111017.946170-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 14 ++++++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

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
index dcaa370d4a26..3439312b0138 100644
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
@@ -1151,6 +1159,8 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 
 	hr_qp->state = IB_QPS_RESET;
 	hr_qp->flush_flag = 0;
+	flush_work->hr_dev = hr_dev;
+	INIT_WORK(&flush_work->work, flush_work_handle);
 
 	if (init_attr->create_flags)
 		return -EOPNOTSUPP;
-- 
2.33.0


