Return-Path: <linux-rdma+bounces-3664-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9619284A1
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 11:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF35A1C2442B
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328CE146A71;
	Fri,  5 Jul 2024 09:04:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549813665A;
	Fri,  5 Jul 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170298; cv=none; b=rV2GPJHkiS2HpRPhUzuGH9C8RQJGEE/jKHQej0lI+ZkftVl3B73B1aP/0pcPYc0utYz08ZGh5vvnIgkLKEB3XDhqMgLZnJZNTaaA/NyaT8bYPo8UR7eYjrX4WhLpNTvSJBtLdOaI7WfeTaRNxjI0DL4/PMPo7Qz5PxESXxCz+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170298; c=relaxed/simple;
	bh=dAPZbACw6uK/VTIi6nUF7U//UDZ7wAoHYWWhu6NJtKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quLcDwWZA3sqDMXo5D9qUEDL7GA0GmxQktl+qqd3JOwYq+jRs+P2jf6o48hgllLTLH5v3f9yJNAeeqNWzS9BYo+LWTVWYhWA0AkmKhn3kXt7UzujYK4F+LfSZ+gcWRi1Gv8nZKDyG2BxBX6rRZ4pvRW+sMruJTtysg2qEVD1Ah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WFnbD36Nhz1HF1t;
	Fri,  5 Jul 2024 17:02:32 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id A228D140257;
	Fri,  5 Jul 2024 17:04:52 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Jul 2024 17:04:52 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 1/9] RDMA/hns: Check atomic wr length
Date: Fri, 5 Jul 2024 16:59:29 +0800
Message-ID: <20240705085937.1644229-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
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

8 bytes is the only supported length of atomic. Return an error if
it is not.

Fixes: 384f88185112 ("RDMA/hns: Add atomic support")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 19 +++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index ff0b3f68ee3a..05005079258c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -91,6 +91,8 @@
 /* Configure to HW for PAGE_SIZE larger than 4KB */
 #define PG_SHIFT_OFFSET				(PAGE_SHIFT - 12)
 
+#define ATOMIC_WR_LEN				8
+
 #define HNS_ROCE_IDX_QUE_ENTRY_SZ		4
 #define SRQ_DB_REG				0x230
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4287818a737f..a5d746a5cc68 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -164,15 +164,23 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 	hr_reg_clear(fseg, FRMR_BLK_MODE);
 }
 
-static void set_atomic_seg(const struct ib_send_wr *wr,
-			   struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
-			   unsigned int valid_num_sge)
+static int set_atomic_seg(struct hns_roce_dev *hr_dev,
+			  const struct ib_send_wr *wr,
+			  struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
+			  unsigned int valid_num_sge, u32 msg_len)
 {
 	struct hns_roce_v2_wqe_data_seg *dseg =
 		(void *)rc_sq_wqe + sizeof(struct hns_roce_v2_rc_send_wqe);
 	struct hns_roce_wqe_atomic_seg *aseg =
 		(void *)dseg + sizeof(struct hns_roce_v2_wqe_data_seg);
 
+	if (msg_len != ATOMIC_WR_LEN) {
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "invalid atomic wr len, len = %u.\n",
+				      msg_len);
+		return -EINVAL;
+	}
+
 	set_data_seg_v2(dseg, wr->sg_list);
 
 	if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP) {
@@ -185,6 +193,8 @@ static void set_atomic_seg(const struct ib_send_wr *wr,
 	}
 
 	hr_reg_write(rc_sq_wqe, RC_SEND_WQE_SGE_NUM, valid_num_sge);
+
+	return 0;
 }
 
 static int fill_ext_sge_inl_data(struct hns_roce_qp *qp,
@@ -592,7 +602,8 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
 
 	if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
 	    wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD)
-		set_atomic_seg(wr, rc_sq_wqe, valid_num_sge);
+		ret = set_atomic_seg(hr_dev, wr, rc_sq_wqe, valid_num_sge,
+				     msg_len);
 	else if (wr->opcode != IB_WR_REG_MR)
 		ret = set_rwqe_data_seg(&qp->ibqp, wr, rc_sq_wqe,
 					&curr_idx, valid_num_sge);
-- 
2.33.0


