Return-Path: <linux-rdma+bounces-13888-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11856BE31F7
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 13:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6A74823F0
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 11:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8018F31B80D;
	Thu, 16 Oct 2025 11:41:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614731AF3B
	for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614864; cv=none; b=RXUSBIt7KXufNGBUQg53jJk+hNwrRo5hWCzz+m1LSV6g+Gi57d21QrAa6t8gtuQAz5Zl3O4DJwrFc0+EDjLOKEDEKJT+RXnDIRzTTUoVSiGGSs+GsImoFkpObmmS0JSIZLThgmutMc87cA+twpI8HvNR4X4XccUEvVPWI/BHlc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614864; c=relaxed/simple;
	bh=Vn+m/j+LbDEHJ0RvWs4RS/nMFmMeNxp2KXYtLDQZo3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQHnwLb6ktGwDPVK0Pun4y7MiMf5AO+RTLomI57PyG9/BE/9D5F32g9NLDPIfBKo/KkSbgXG0ToHmYvcNEkhARbJE2XeHCrK+ncCEt9W5b9Ej27+5EoSWkOln32m3CV3PLdUKrWhH/BWAEqMXBKxdHzsl00+Wmm1Yz5H4/sWndE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cnQxX6mHyzmV66;
	Thu, 16 Oct 2025 19:40:32 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id D5B3A140144;
	Thu, 16 Oct 2025 19:40:53 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 19:40:53 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 3/4] RDMA/hns: Fix wrong WQE data when QP wraps around
Date: Thu, 16 Oct 2025 19:40:50 +0800
Message-ID: <20251016114051.1963197-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251016114051.1963197-1-huangjunxian6@hisilicon.com>
References: <20251016114051.1963197-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)

When QP wraps around, WQE data from the previous use at the same
position still remains as driver does not clear it. The WQE field
layout differs across different opcodes, causing that the fields
that are not explicitly assigned for the current opcode retain
stale values, and are issued to HW by mistake. Such fields are as
follows:

* MSG_START_SGE_IDX field in ATOMIC WQE
* BLOCK_SIZE and ZBVA fields in FRMR WQE
* DirectWQE fields when DirectWQE not used

For ATOMIC WQE, always set the latest sge index in MSG_START_SGE_IDX
as required by HW.

For FRMR WQE and DirectWQE, clear only those unassigned fields
instead of the entire WQE to avoid performance penalty.

Fixes: 68a997c5d28c ("RDMA/hns: Add FRMR support for hip08")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 64bca08f3f1a..d20cef4b3ac9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -165,6 +165,8 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 	hr_reg_write(fseg, FRMR_PBL_BUF_PG_SZ,
 		     to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.buf_pg_shift));
 	hr_reg_clear(fseg, FRMR_BLK_MODE);
+	hr_reg_clear(fseg, FRMR_BLOCK_SIZE);
+	hr_reg_clear(fseg, FRMR_ZBVA);
 }
 
 static void set_atomic_seg(const struct ib_send_wr *wr,
@@ -339,9 +341,6 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	int j = 0;
 	int i;
 
-	hr_reg_write(rc_sq_wqe, RC_SEND_WQE_MSG_START_SGE_IDX,
-		     (*sge_ind) & (qp->sge.sge_cnt - 1));
-
 	hr_reg_write(rc_sq_wqe, RC_SEND_WQE_INLINE,
 		     !!(wr->send_flags & IB_SEND_INLINE));
 	if (wr->send_flags & IB_SEND_INLINE)
@@ -586,6 +585,9 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
 	hr_reg_write(rc_sq_wqe, RC_SEND_WQE_CQE,
 		     (wr->send_flags & IB_SEND_SIGNALED) ? 1 : 0);
 
+	hr_reg_write(rc_sq_wqe, RC_SEND_WQE_MSG_START_SGE_IDX,
+		     curr_idx & (qp->sge.sge_cnt - 1));
+
 	if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
 	    wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD) {
 		if (msg_len != ATOMIC_WR_LEN)
@@ -734,6 +736,9 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		owner_bit =
 		       ~(((qp->sq.head + nreq) >> ilog2(qp->sq.wqe_cnt)) & 0x1);
 
+		/* RC and UD share the same DirectWQE field layout */
+		((struct hns_roce_v2_rc_send_wqe *)wqe)->byte_4 = 0;
+
 		/* Corresponding to the QP type, wqe process separately */
 		if (ibqp->qp_type == IB_QPT_RC)
 			ret = set_rc_wqe(qp, wr, wqe, &sge_idx, owner_bit);
-- 
2.33.0


