Return-Path: <linux-rdma+bounces-3799-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 441B992D32D
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 15:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF0A7B26448
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 13:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02001946BC;
	Wed, 10 Jul 2024 13:42:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFABB194141;
	Wed, 10 Jul 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618954; cv=none; b=rwul4i76phbQF3wcO4SSk6DWUwFmpN2LFkTqVDWKARe63D5JBGkpQBXQfo7EZwgHM9RyLaPp1Jf1ORyzwP/DAvtwXHYXlgvAEDIDbrB+xjttu2k4snyeKF7R/DERUpgWpHUX/sXb8DIAeavSrUE8sPbWjSrsDTXmU8rG7qM0c58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618954; c=relaxed/simple;
	bh=PND3fEFJhzk25l89uTHt9gHFkld+VZcBV1FuXneP828=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b78OBjM8BKhDUpMAsO8xKw7k3btTPljUihuie2CiKUanFjIQqqfHjo/6u52/sV7IhIn1M1vZavN+RA7Prcd5dX10tUeTrN8vz6X8tSKdsh2eFqYKzVTWr2GsGMLWTShtKvs4q3aVNxtk9eTFBguntgUST1orCZgAPcG6oZFb2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WJzYH4kvGzjX65;
	Wed, 10 Jul 2024 21:41:55 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 58AF714035F;
	Wed, 10 Jul 2024 21:42:23 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jul 2024 21:42:22 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-rc 1/8] RDMA/hns: Check atomic wr length
Date: Wed, 10 Jul 2024 21:36:58 +0800
Message-ID: <20240710133705.896445-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240710133705.896445-1-huangjunxian6@hisilicon.com>
References: <20240710133705.896445-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)

8 bytes is the only supported length of atomic. Add this check in
set_rc_wqe(). Besides, stop processing WQEs and return from
set_rc_wqe() if there is any error.

Fixes: 384f88185112 ("RDMA/hns: Add atomic support")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 2 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

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
index 4287818a737f..eb6052ee8938 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -591,11 +591,16 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
 		     (wr->send_flags & IB_SEND_SIGNALED) ? 1 : 0);
 
 	if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
-	    wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD)
+	    wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD) {
+		if (msg_len != ATOMIC_WR_LEN)
+			return -EINVAL;
 		set_atomic_seg(wr, rc_sq_wqe, valid_num_sge);
-	else if (wr->opcode != IB_WR_REG_MR)
+	} else if (wr->opcode != IB_WR_REG_MR) {
 		ret = set_rwqe_data_seg(&qp->ibqp, wr, rc_sq_wqe,
 					&curr_idx, valid_num_sge);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * The pipeline can sequentially post all valid WQEs into WQ buffer,
-- 
2.33.0


