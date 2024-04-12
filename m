Return-Path: <linux-rdma+bounces-1925-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3818A2AF8
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 11:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17F41C22A69
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D3D537FB;
	Fri, 12 Apr 2024 09:20:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E120A51C4D;
	Fri, 12 Apr 2024 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913652; cv=none; b=OHR3k16EoP3cYOPeJszrQQH95766ZecqOCsvs5iibReI46LIPdIuzEAvYr/d1JjD6Fs0IL38IrqruqDt6JVmI+l8HvB/+7Xz4z1ayvCCFB20Oy8nDJxYZcINklMJrN+n6eszYw/HSBUFR0ng9EgJ+M8sajOxtVLcnamQOyDw9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913652; c=relaxed/simple;
	bh=0RjIl3/CZIauiHO50+sEt8Kq5cwNHrSvB01cJGWc5fE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7QB10Uq2lqGg2sKAQ3NnNCm7QMLyyq6+9uD//M9Ih/hpv0FAChMfxG7CPRZ+J1hv0g/hPJ8NIiM235Fh3O4H3OJx00njaOnHP5sNot+eEnIdbhGid76gVlm880eWtH28gIVZyBPxAnVkhWao7yg68HUJ6oAPvac7iRYld1pMUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VG9vN1JBNzTmQZ;
	Fri, 12 Apr 2024 17:17:36 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A054140AC1;
	Fri, 12 Apr 2024 17:20:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:20:46 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 01/10] RDMA/hns: Use macro instead of magic number
Date: Fri, 12 Apr 2024 17:16:07 +0800
Message-ID: <20240412091616.370789-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240412091616.370789-1-huangjunxian6@hisilicon.com>
References: <20240412091616.370789-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)

From: Yangyang Li <liyangyang20@huawei.com>

Use macro instead of magic number.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 34 ++++++++++++----------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 13 +++++++++
 drivers/infiniband/hw/hns/hns_roce_qp.c    |  3 +-
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 423ab66c5856..30ac5fb5ab16 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3204,13 +3204,14 @@ static int set_mtpt_pbl(struct hns_roce_dev *hr_dev,
 
 	/* Aligned to the hardware address access unit */
 	for (i = 0; i < ARRAY_SIZE(pages); i++)
-		pages[i] >>= 6;
+		pages[i] >>= MPT_PBL_BUF_ADDR_S;
 
 	pbl_ba = hns_roce_get_mtr_ba(&mr->pbl_mtr);
 
 	mpt_entry->pbl_size = cpu_to_le32(mr->npages);
-	mpt_entry->pbl_ba_l = cpu_to_le32(pbl_ba >> 3);
-	hr_reg_write(mpt_entry, MPT_PBL_BA_H, upper_32_bits(pbl_ba >> 3));
+	mpt_entry->pbl_ba_l = cpu_to_le32(pbl_ba >> MPT_PBL_BA_ADDR_S);
+	hr_reg_write(mpt_entry, MPT_PBL_BA_H,
+		     upper_32_bits(pbl_ba >> MPT_PBL_BA_ADDR_S));
 
 	mpt_entry->pa0_l = cpu_to_le32(lower_32_bits(pages[0]));
 	hr_reg_write(mpt_entry, MPT_PA0_H, upper_32_bits(pages[0]));
@@ -3331,8 +3332,10 @@ static int hns_roce_v2_frmr_write_mtpt(struct hns_roce_dev *hr_dev,
 
 	mpt_entry->pbl_size = cpu_to_le32(mr->npages);
 
-	mpt_entry->pbl_ba_l = cpu_to_le32(lower_32_bits(pbl_ba >> 3));
-	hr_reg_write(mpt_entry, MPT_PBL_BA_H, upper_32_bits(pbl_ba >> 3));
+	mpt_entry->pbl_ba_l = cpu_to_le32(lower_32_bits(pbl_ba >>
+							MPT_PBL_BA_ADDR_S));
+	hr_reg_write(mpt_entry, MPT_PBL_BA_H,
+		     upper_32_bits(pbl_ba >> MPT_PBL_BA_ADDR_S));
 
 	return 0;
 }
@@ -3578,14 +3581,14 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 		     to_hr_hw_page_shift(hr_cq->mtr.hem_cfg.ba_pg_shift));
 	hr_reg_write(cq_context, CQC_CQE_BUF_PG_SZ,
 		     to_hr_hw_page_shift(hr_cq->mtr.hem_cfg.buf_pg_shift));
-	hr_reg_write(cq_context, CQC_CQE_BA_L, dma_handle >> 3);
-	hr_reg_write(cq_context, CQC_CQE_BA_H, (dma_handle >> (32 + 3)));
+	hr_reg_write(cq_context, CQC_CQE_BA_L, dma_handle >> CQC_CQE_BA_L_S);
+	hr_reg_write(cq_context, CQC_CQE_BA_H, dma_handle >> CQC_CQE_BA_H_S);
 	hr_reg_write_bool(cq_context, CQC_DB_RECORD_EN,
 			  hr_cq->flags & HNS_ROCE_CQ_FLAG_RECORD_DB);
 	hr_reg_write(cq_context, CQC_CQE_DB_RECORD_ADDR_L,
 		     ((u32)hr_cq->db.dma) >> 1);
 	hr_reg_write(cq_context, CQC_CQE_DB_RECORD_ADDR_H,
-		     hr_cq->db.dma >> 32);
+		     hr_cq->db.dma >> CQC_CQE_DB_RECORD_ADDR_H_S);
 	hr_reg_write(cq_context, CQC_CQ_MAX_CNT,
 		     HNS_ROCE_V2_CQ_DEFAULT_BURST_NUM);
 	hr_reg_write(cq_context, CQC_CQ_PERIOD,
@@ -4517,16 +4520,16 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 		return -EINVAL;
 	}
 
-	hr_reg_write(context, QPC_TRRL_BA_L, trrl_ba >> 4);
+	hr_reg_write(context, QPC_TRRL_BA_L, trrl_ba >> QPC_TRRL_BA_L_S);
 	hr_reg_clear(qpc_mask, QPC_TRRL_BA_L);
-	context->trrl_ba = cpu_to_le32(trrl_ba >> (16 + 4));
+	context->trrl_ba = cpu_to_le32(trrl_ba >> QPC_TRRL_BA_M_S);
 	qpc_mask->trrl_ba = 0;
-	hr_reg_write(context, QPC_TRRL_BA_H, trrl_ba >> (32 + 16 + 4));
+	hr_reg_write(context, QPC_TRRL_BA_H, trrl_ba >> QPC_TRRL_BA_H_S);
 	hr_reg_clear(qpc_mask, QPC_TRRL_BA_H);
 
-	context->irrl_ba = cpu_to_le32(irrl_ba >> 6);
+	context->irrl_ba = cpu_to_le32(irrl_ba >> QPC_IRRL_BA_L_S);
 	qpc_mask->irrl_ba = 0;
-	hr_reg_write(context, QPC_IRRL_BA_H, irrl_ba >> (32 + 6));
+	hr_reg_write(context, QPC_IRRL_BA_H, irrl_ba >> QPC_IRRL_BA_H_S);
 	hr_reg_clear(qpc_mask, QPC_IRRL_BA_H);
 
 	hr_reg_enable(context, QPC_RMT_E2E);
@@ -4588,8 +4591,9 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	hr_reg_clear(qpc_mask, QPC_TRRL_HEAD_MAX);
 	hr_reg_clear(qpc_mask, QPC_TRRL_TAIL_MAX);
 
+#define MAX_LP_SGEN 3
 	/* rocee send 2^lp_sgen_ini segs every time */
-	hr_reg_write(context, QPC_LP_SGEN_INI, 3);
+	hr_reg_write(context, QPC_LP_SGEN_INI, MAX_LP_SGEN);
 	hr_reg_clear(qpc_mask, QPC_LP_SGEN_INI);
 
 	if (udata && ibqp->qp_type == IB_QPT_RC &&
@@ -4681,7 +4685,7 @@ static int get_dip_ctx_idx(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 	*tail = (*tail == hr_dev->caps.num_qps - 1) ? 0 : (*tail + 1);
 
 	list_for_each_entry(hr_dip, &hr_dev->dip_list, node) {
-		if (!memcmp(grh->dgid.raw, hr_dip->dgid, 16)) {
+		if (!memcmp(grh->dgid.raw, hr_dip->dgid, GID_LEN_V2)) {
 			*dip_idx = hr_dip->dip_idx;
 			goto out;
 		}
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index df04bc8ede57..4bac34f6bbe8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -276,6 +276,10 @@ struct hns_roce_v2_cq_context {
 	__le32 byte_64_se_cqe_idx;
 };
 
+#define CQC_CQE_BA_L_S 3
+#define CQC_CQE_BA_H_S (32 + CQC_CQE_BA_L_S)
+#define CQC_CQE_DB_RECORD_ADDR_H_S 32
+
 #define HNS_ROCE_V2_CQ_DEFAULT_BURST_NUM 0x0
 #define HNS_ROCE_V2_CQ_DEFAULT_INTERVAL	0x0
 
@@ -447,6 +451,12 @@ struct hns_roce_v2_qp_context {
 	struct hns_roce_v2_qp_context_ex ext;
 };
 
+#define QPC_TRRL_BA_L_S 4
+#define QPC_TRRL_BA_M_S (16 + QPC_TRRL_BA_L_S)
+#define QPC_TRRL_BA_H_S (32 + QPC_TRRL_BA_M_S)
+#define QPC_IRRL_BA_L_S 6
+#define QPC_IRRL_BA_H_S (32 + QPC_IRRL_BA_L_S)
+
 #define QPC_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_v2_qp_context, h, l)
 
 #define QPC_TST QPC_FIELD_LOC(2, 0)
@@ -716,6 +726,9 @@ struct hns_roce_v2_mpt_entry {
 	__le32	byte_64_buf_pa1;
 };
 
+#define MPT_PBL_BUF_ADDR_S 6
+#define MPT_PBL_BA_ADDR_S 3
+
 #define MPT_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_v2_mpt_entry, h, l)
 
 #define MPT_ST MPT_FIELD_LOC(1, 0)
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 697230f964b1..cac3fe588672 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -410,7 +410,8 @@ static void free_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 
 	bankid = get_qp_bankid(hr_qp->qpn);
 
-	ida_free(&hr_dev->qp_table.bank[bankid].ida, hr_qp->qpn >> 3);
+	ida_free(&hr_dev->qp_table.bank[bankid].ida,
+		 hr_qp->qpn / HNS_ROCE_QP_BANK_NUM);
 
 	mutex_lock(&hr_dev->qp_table.bank_mutex);
 	hr_dev->qp_table.bank[bankid].inuse--;
-- 
2.30.0


