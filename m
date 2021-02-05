Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74AC310821
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 10:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhBEJod (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 04:44:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12843 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhBEJmi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 04:42:38 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DX9QB069sz7hVp;
        Fri,  5 Feb 2021 17:40:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 17:41:50 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 09/12] RDMA/hns: Remove some magic numbers
Date:   Fri, 5 Feb 2021 17:39:31 +0800
Message-ID: <1612517974-31867-10-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
References: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xinhao Liu <liuxinhao5@hisilicon.com>

Use macros instead of magic numbers to represent shift of dma_handle_wqe,
dma_handle_idx and UDP destination port number of RoCEv2.

Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index a5e304a..1bff432 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1601,7 +1601,8 @@ static int hns_roce_config_global_param(struct hns_roce_dev *hr_dev)
 		       CFG_GLOBAL_PARAM_DATA_0_ROCEE_TIME_1US_CFG_S, 0x3e8);
 	roce_set_field(req->time_cfg_udp_port,
 		       CFG_GLOBAL_PARAM_DATA_0_ROCEE_UDP_PORT_M,
-		       CFG_GLOBAL_PARAM_DATA_0_ROCEE_UDP_PORT_S, 0x12b7);
+		       CFG_GLOBAL_PARAM_DATA_0_ROCEE_UDP_PORT_S,
+		       ROCE_V2_UDP_DPORT);
 
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
@@ -5264,6 +5265,9 @@ static int hns_roce_v2_qp_flow_control_init(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
+#define DMA_IDX_SHIFT 3
+#define DMA_WQE_SHIFT 3
+
 static int hns_roce_v2_write_srqc_index_queue(struct hns_roce_srq *srq,
 					      struct hns_roce_srq_context *ctx)
 {
@@ -5286,8 +5290,9 @@ static int hns_roce_v2_write_srqc_index_queue(struct hns_roce_srq *srq,
 	hr_reg_write(ctx, SRQC_IDX_HOP_NUM,
 		     to_hr_hem_hopnum(hr_dev->caps.idx_hop_num, srq->wqe_cnt));
 
-	hr_reg_write(ctx, SRQC_IDX_BT_BA_L, dma_handle_idx >> 3);
-	hr_reg_write(ctx, SRQC_IDX_BT_BA_H, upper_32_bits(dma_handle_idx >> 3));
+	hr_reg_write(ctx, SRQC_IDX_BT_BA_L, dma_handle_idx >> DMA_IDX_SHIFT);
+	hr_reg_write(ctx, SRQC_IDX_BT_BA_H,
+		     upper_32_bits(dma_handle_idx >> DMA_IDX_SHIFT));
 
 	hr_reg_write(ctx, SRQC_IDX_BA_PG_SZ,
 		     to_hr_hw_page_shift(idx_que->mtr.hem_cfg.ba_pg_shift));
@@ -5340,8 +5345,9 @@ static int hns_roce_v2_write_srqc(struct hns_roce_srq *srq, void *mb_buf)
 		     to_hr_hem_hopnum(hr_dev->caps.srqwqe_hop_num,
 				      srq->wqe_cnt));
 
-	hr_reg_write(ctx, SRQC_WQE_BT_BA_L, dma_handle_wqe >> 3);
-	hr_reg_write(ctx, SRQC_WQE_BT_BA_H, upper_32_bits(dma_handle_wqe >> 3));
+	hr_reg_write(ctx, SRQC_WQE_BT_BA_L, dma_handle_wqe >> DMA_WQE_SHIFT);
+	hr_reg_write(ctx, SRQC_WQE_BT_BA_H,
+		     upper_32_bits(dma_handle_wqe >> DMA_WQE_SHIFT));
 
 	hr_reg_write(ctx, SRQC_WQE_BA_PG_SZ,
 		     to_hr_hw_page_shift(srq->buf_mtr.hem_cfg.ba_pg_shift));
-- 
2.8.1

