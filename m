Return-Path: <linux-rdma+bounces-966-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C525B84D93F
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 04:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616481F22CE4
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 03:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C3F2E400;
	Thu,  8 Feb 2024 03:54:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878162C1A2;
	Thu,  8 Feb 2024 03:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364493; cv=none; b=aJk8xZ8Tm0pijfO5XtY3sAapU3uTe6CLu6DX8j0udM8oBPZoCtUkyiXv84VKvxGmkMtHrWrN6VLscinmcU3NyeXQyRvJhehKXvEbkO9JtYgt5MPZQgJYYVGooZAaPSdxbvfFFNuqpeVjeDKYYyJin/TzQHizCIAYBMBTn+ihpjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364493; c=relaxed/simple;
	bh=FvtGIkAMDz8detl5OIk06g4IGpah/YCw5aIMJ3ndXE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEs4ib3iBl1uRje5AW+JuLKgwP+a/sFQ3X4ELeBLRFylg9fd6YQjMysH3VY9YwWRr8uKmEiCU4BrO0vbWgO2+JYFA6ROwOvR4NnpdlhIkaFKntST0UyENAWE60i1pkq5Lrw1srYts8x+ZhvZ6c79InitLQJ8xRtJn0j+z/AGjn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TVjk95xjsz1gyBH;
	Thu,  8 Feb 2024 11:52:49 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id D505A180060;
	Thu,  8 Feb 2024 11:54:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 11:54:46 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 1/2] RDMA/hns: Fix mis-modifying default congestion control algorithm
Date: Thu, 8 Feb 2024 11:50:37 +0800
Message-ID: <20240208035038.94668-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240208035038.94668-1-huangjunxian6@hisilicon.com>
References: <20240208035038.94668-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500006.china.huawei.com (7.221.188.68)

From: Luoyouming <luoyouming@huawei.com>

Commit 27c5fd271d8b ("RDMA/hns: The UD mode can only be configured
with DCQCN") adds a check of congest control alorithm for UD. But
that patch causes a problem: hr_dev->caps.congest_type is global,
used by all QPs, so modifying this field to DCQCN for UD QPs causes
other QPs unable to use any other algorithm except DCQCN.

Revert the modification in commit 27c5fd271d8b ("RDMA/hns: The UD
mode can only be configured with DCQCN"). Add a new field cong_type
to struct hns_roce_qp and configure DCQCN for UD QPs.

Fixes: 27c5fd271d8b ("RDMA/hns: The UD mode can only be configured with DCQCN")
Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
Signed-off-by: Luoyouming <luoyouming@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 15 ++++++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 16 ++++++++++------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 1a8516019516..c88ba7e053bf 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -594,6 +594,13 @@ struct hns_roce_work {
 	u32 queue_num;
 };
 
+enum cong_type {
+	CONG_TYPE_DCQCN,
+	CONG_TYPE_LDCP,
+	CONG_TYPE_HC3,
+	CONG_TYPE_DIP,
+};
+
 struct hns_roce_qp {
 	struct ib_qp		ibqp;
 	struct hns_roce_wq	rq;
@@ -637,6 +644,7 @@ struct hns_roce_qp {
 	struct list_head	sq_node; /* all send qps are on a list */
 	struct hns_user_mmap_entry *dwqe_mmap_entry;
 	u32			config;
+	enum cong_type		cong_type;
 };
 
 struct hns_roce_ib_iboe {
@@ -708,13 +716,6 @@ struct hns_roce_eq_table {
 	struct hns_roce_eq	*eq;
 };
 
-enum cong_type {
-	CONG_TYPE_DCQCN,
-	CONG_TYPE_LDCP,
-	CONG_TYPE_HC3,
-	CONG_TYPE_DIP,
-};
-
 struct hns_roce_caps {
 	u64		fw_ver;
 	u8		num_ports;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index de56dc6e3226..42e28586cefa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4738,12 +4738,15 @@ static int check_cong_type(struct ib_qp *ibqp,
 			   struct hns_roce_congestion_algorithm *cong_alg)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 
-	if (ibqp->qp_type == IB_QPT_UD)
-		hr_dev->caps.cong_type = CONG_TYPE_DCQCN;
+	if (ibqp->qp_type == IB_QPT_UD || ibqp->qp_type == IB_QPT_GSI)
+		hr_qp->cong_type = CONG_TYPE_DCQCN;
+	else
+		hr_qp->cong_type = hr_dev->caps.cong_type;
 
 	/* different congestion types match different configurations */
-	switch (hr_dev->caps.cong_type) {
+	switch (hr_qp->cong_type) {
 	case CONG_TYPE_DCQCN:
 		cong_alg->alg_sel = CONG_DCQCN;
 		cong_alg->alg_sub_sel = UNSUPPORT_CONG_LEVEL;
@@ -4771,8 +4774,8 @@ static int check_cong_type(struct ib_qp *ibqp,
 	default:
 		ibdev_warn(&hr_dev->ib_dev,
 			   "invalid type(%u) for congestion selection.\n",
-			   hr_dev->caps.cong_type);
-		hr_dev->caps.cong_type = CONG_TYPE_DCQCN;
+			   hr_qp->cong_type);
+		hr_qp->cong_type = CONG_TYPE_DCQCN;
 		cong_alg->alg_sel = CONG_DCQCN;
 		cong_alg->alg_sub_sel = UNSUPPORT_CONG_LEVEL;
 		cong_alg->dip_vld = DIP_INVALID;
@@ -4791,6 +4794,7 @@ static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 	struct hns_roce_congestion_algorithm cong_field;
 	struct ib_device *ibdev = ibqp->device;
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	u32 dip_idx = 0;
 	int ret;
 
@@ -4803,7 +4807,7 @@ static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 		return ret;
 
 	hr_reg_write(context, QPC_CONG_ALGO_TMPL_ID, hr_dev->cong_algo_tmpl_id +
-		     hr_dev->caps.cong_type * HNS_ROCE_CONG_SIZE);
+		     hr_qp->cong_type * HNS_ROCE_CONG_SIZE);
 	hr_reg_clear(qpc_mask, QPC_CONG_ALGO_TMPL_ID);
 	hr_reg_write(&context->ext, QPCEX_CONG_ALG_SEL, cong_field.alg_sel);
 	hr_reg_clear(&qpc_mask->ext, QPCEX_CONG_ALG_SEL);
-- 
2.30.0


