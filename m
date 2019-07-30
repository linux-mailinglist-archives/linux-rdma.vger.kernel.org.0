Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08037A393
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 11:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbfG3JBC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 05:01:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54030 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731237AbfG3JBB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 05:01:01 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 84C42B3966D337C3C158;
        Tue, 30 Jul 2019 17:00:53 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 30 Jul 2019 17:00:45 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 04/13] RDMA/hns: Remove unnessary init for cmq reg
Date:   Tue, 30 Jul 2019 16:56:41 +0800
Message-ID: <1564477010-29804-5-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
References: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

There is no need to init the enable bit of cmq.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 ++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 064e56c..b13c68e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -887,8 +887,7 @@ static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
 		roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_H_REG,
 			   upper_32_bits(dma));
 		roce_write(hr_dev, ROCEE_TX_CMQ_DEPTH_REG,
-			  (ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S) |
-			   HNS_ROCE_CMQ_ENABLE);
+			   ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
 		roce_write(hr_dev, ROCEE_TX_CMQ_HEAD_REG, 0);
 		roce_write(hr_dev, ROCEE_TX_CMQ_TAIL_REG, 0);
 	} else {
@@ -896,8 +895,7 @@ static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
 		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_H_REG,
 			   upper_32_bits(dma));
 		roce_write(hr_dev, ROCEE_RX_CMQ_DEPTH_REG,
-			  (ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S) |
-			   HNS_ROCE_CMQ_ENABLE);
+			   ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
 		roce_write(hr_dev, ROCEE_RX_CMQ_HEAD_REG, 0);
 		roce_write(hr_dev, ROCEE_RX_CMQ_TAIL_REG, 0);
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 478f5a5..58931b5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -126,8 +126,6 @@
 #define HNS_ROCE_CMD_FLAG_ERR_INTR	BIT(HNS_ROCE_CMD_FLAG_ERR_INTR_SHIFT)
 
 #define HNS_ROCE_CMQ_DESC_NUM_S		3
-#define HNS_ROCE_CMQ_EN_B		16
-#define HNS_ROCE_CMQ_ENABLE		BIT(HNS_ROCE_CMQ_EN_B)
 
 #define HNS_ROCE_CMQ_SCC_CLR_DONE_CNT		5
 
-- 
1.9.1

