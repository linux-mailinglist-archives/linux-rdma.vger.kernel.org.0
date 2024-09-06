Return-Path: <linux-rdma+bounces-4797-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEAA96EFD4
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 11:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138F12887ED
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 09:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB7E1CB134;
	Fri,  6 Sep 2024 09:40:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB121C9DEA;
	Fri,  6 Sep 2024 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615642; cv=none; b=lqXo9Z7J8y79aZlCb+kIoLzK/Jx4Z1+pLSao/N65vb9/hUYbbJTPUixUcUg5R2tLUTxUEZKRzfCYfkMlPHL2ltJVZG+A12lmvEosDyAoV+mv0z5zhakS7e0azijLksTt0exaBhsSZXoLciovRQxdXy3QxuSmzD/iekJJuqMk9iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615642; c=relaxed/simple;
	bh=zgRErwe+7/OlqN+OtPmfFNEht306dokkywL/aVZYv2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxVBUA2dv7+6e5BMhl8/r2xU6RHzWm8428tgT616dLYpq5FF7EqKXYC/5ew1NWDvu3DVN1kBd5ViwZL/+SIQ1MZvuSaQUqnKVl87GMsPfcrwtItkBlB6s6i0TPukfhKne4jiSd6h4p4l9KQSYkNiuBnY/d7rAL37atQRU2EZxY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X0WPt3plXzpVKg;
	Fri,  6 Sep 2024 17:38:42 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 2502214011A;
	Fri,  6 Sep 2024 17:40:38 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 17:40:37 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 9/9] RDMA/hns: Fix different dgids mapping to the same dip_idx
Date: Fri, 6 Sep 2024 17:34:44 +0800
Message-ID: <20240906093444.3571619-10-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
References: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Feng Fang <fangfeng4@huawei.com>

DIP algorithm requires a one-to-one mapping between dgid and dip_idx.
Currently a queue 'spare_idx' is used to store QPN of QPs that use
DIP algorithm. For a new dgid, use a QPN from spare_idx as dip_idx.
This method lacks a mechanism for deduplicating QPN, which may result
in different dgids sharing the same dip_idx and break the one-to-one
mapping requirement.

This patch replaces spare_idx with two new bitmaps: qpn_bitmap to record
QPN that is not being used as dip_idx, and dip_idx_map to record QPN
that is being used. Besides, introduce a reference count of a dip_idx
to indicate the number of QPs that using this dip_idx. When creating
a DIP QP, if it has a new dgid, set the corresponding bit in dip_idx_map,
otherwise add 1 to the reference count of the reused dip_idx and set bit
in qpn_bitmap. When destroying a DIP QP, decrement the reference count
by 1. If it becomes 0, set bit in qpn_bitmap and clear bit in dip_idx_map.

Fixes: eb653eda1e91 ("RDMA/hns: Bugfix for incorrect association between dip_idx and dgid")
Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
Signed-off-by: Feng Fang <fangfeng4@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 58 ++++++++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  1 +
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 16 ++++--
 4 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 0b1e21cb6d2d..adc65d383cf1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -490,9 +490,8 @@ struct hns_roce_bank {
 };
 
 struct hns_roce_idx_table {
-	u32 *spare_idx;
-	u32 head;
-	u32 tail;
+	unsigned long *qpn_bitmap;
+	unsigned long *dip_idx_bitmap;
 };
 
 struct hns_roce_qp_table {
@@ -656,6 +655,7 @@ struct hns_roce_qp {
 	enum hns_roce_cong_type	cong_type;
 	u8			tc_mode;
 	u8			priority;
+	struct hns_roce_dip *dip;
 };
 
 struct hns_roce_ib_iboe {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 085461713fa9..19a4bf80a080 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4706,21 +4706,24 @@ static int get_dip_ctx_idx(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 {
 	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
-	u32 *spare_idx = hr_dev->qp_table.idx_table.spare_idx;
-	u32 *head =  &hr_dev->qp_table.idx_table.head;
-	u32 *tail =  &hr_dev->qp_table.idx_table.tail;
+	unsigned long *dip_idx_bitmap = hr_dev->qp_table.idx_table.dip_idx_bitmap;
+	unsigned long *qpn_bitmap = hr_dev->qp_table.idx_table.qpn_bitmap;
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	struct hns_roce_dip *hr_dip;
 	unsigned long flags;
 	int ret = 0;
+	u32 idx;
 
 	spin_lock_irqsave(&hr_dev->dip_list_lock, flags);
 
-	spare_idx[*tail] = ibqp->qp_num;
-	*tail = (*tail == hr_dev->caps.num_qps - 1) ? 0 : (*tail + 1);
+	if (!test_bit(ibqp->qp_num, dip_idx_bitmap))
+		set_bit(ibqp->qp_num, qpn_bitmap);
 
 	list_for_each_entry(hr_dip, &hr_dev->dip_list, node) {
 		if (!memcmp(grh->dgid.raw, hr_dip->dgid, GID_LEN_V2)) {
 			*dip_idx = hr_dip->dip_idx;
+			hr_dip->qp_cnt++;
+			hr_qp->dip = hr_dip;
 			goto out;
 		}
 	}
@@ -4734,9 +4737,21 @@ static int get_dip_ctx_idx(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 		goto out;
 	}
 
+	idx = find_first_bit(qpn_bitmap, hr_dev->caps.num_qps);
+	if (idx < hr_dev->caps.num_qps) {
+		*dip_idx = idx;
+		clear_bit(idx, qpn_bitmap);
+		set_bit(idx, dip_idx_bitmap);
+	} else {
+		ret = -ENOENT;
+		kfree(hr_dip);
+		goto out;
+	}
+
 	memcpy(hr_dip->dgid, grh->dgid.raw, sizeof(grh->dgid.raw));
-	hr_dip->dip_idx = *dip_idx = spare_idx[*head];
-	*head = (*head == hr_dev->caps.num_qps - 1) ? 0 : (*head + 1);
+	hr_dip->dip_idx = *dip_idx;
+	hr_dip->qp_cnt++;
+	hr_qp->dip = hr_dip;
 	list_add_tail(&hr_dip->node, &hr_dev->dip_list);
 
 out:
@@ -5597,12 +5612,41 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
+static void put_dip_ctx_idx(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_qp *hr_qp)
+{
+	unsigned long *dip_idx_bitmap = hr_dev->qp_table.idx_table.dip_idx_bitmap;
+	unsigned long *qpn_bitmap = hr_dev->qp_table.idx_table.qpn_bitmap;
+	struct hns_roce_dip *hr_dip = hr_qp->dip;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hr_dev->dip_list_lock, flags);
+
+	if (hr_dip) {
+		hr_dip->qp_cnt--;
+		if (!hr_dip->qp_cnt) {
+			clear_bit(hr_dip->dip_idx, dip_idx_bitmap);
+			set_bit(hr_dip->dip_idx, qpn_bitmap);
+
+			list_del(&hr_dip->node);
+		} else {
+			hr_dip = NULL;
+		}
+	}
+
+	spin_unlock_irqrestore(&hr_dev->dip_list_lock, flags);
+	kfree(hr_dip);
+}
+
 int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	int ret;
 
+	if (hr_qp->cong_type == CONG_TYPE_DIP)
+		put_dip_ctx_idx(hr_dev, hr_qp);
+
 	ret = hns_roce_v2_destroy_qp_common(hr_dev, hr_qp, udata);
 	if (ret)
 		ibdev_err_ratelimited(&hr_dev->ib_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index c65f68a14a26..3804882bb5b4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1342,6 +1342,7 @@ struct hns_roce_v2_priv {
 struct hns_roce_dip {
 	u8 dgid[GID_LEN_V2];
 	u32 dip_idx;
+	u32 qp_cnt;
 	struct list_head node; /* all dips are on a list */
 };
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 6b03ba671ff8..bc278b735736 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1546,11 +1546,18 @@ int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
 	unsigned int reserved_from_bot;
 	unsigned int i;
 
-	qp_table->idx_table.spare_idx = kcalloc(hr_dev->caps.num_qps,
-					sizeof(u32), GFP_KERNEL);
-	if (!qp_table->idx_table.spare_idx)
+	qp_table->idx_table.qpn_bitmap = bitmap_zalloc(hr_dev->caps.num_qps,
+						       GFP_KERNEL);
+	if (!qp_table->idx_table.qpn_bitmap)
 		return -ENOMEM;
 
+	qp_table->idx_table.dip_idx_bitmap = bitmap_zalloc(hr_dev->caps.num_qps,
+							   GFP_KERNEL);
+	if (!qp_table->idx_table.dip_idx_bitmap) {
+		bitmap_free(qp_table->idx_table.qpn_bitmap);
+		return -ENOMEM;
+	}
+
 	mutex_init(&qp_table->scc_mutex);
 	mutex_init(&qp_table->bank_mutex);
 	xa_init(&hr_dev->qp_table_xa);
@@ -1580,5 +1587,6 @@ void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev)
 		ida_destroy(&hr_dev->qp_table.bank[i].ida);
 	mutex_destroy(&hr_dev->qp_table.bank_mutex);
 	mutex_destroy(&hr_dev->qp_table.scc_mutex);
-	kfree(hr_dev->qp_table.idx_table.spare_idx);
+	bitmap_free(hr_dev->qp_table.idx_table.qpn_bitmap);
+	bitmap_free(hr_dev->qp_table.idx_table.dip_idx_bitmap);
 }
-- 
2.33.0


