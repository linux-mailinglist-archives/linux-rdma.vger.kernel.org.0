Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603922A047E
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 12:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgJ3LlM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 07:41:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7109 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgJ3LlM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 07:41:12 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CN0kZ4VlRzLrFV;
        Fri, 30 Oct 2020 19:41:10 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 30 Oct 2020 19:41:00 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/8] RDMA/hns: Avoid setting loopback indicator when smac is same as dmac
Date:   Fri, 30 Oct 2020 19:39:30 +0800
Message-ID: <1604057975-23388-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1604057975-23388-1-git-send-email-liweihang@huawei.com>
References: <1604057975-23388-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The loopback flag will be set to 1 by the hardware when the source mac
address is same as the destination mac address. So the driver don't need to
compare them.

Fixes: d6a3627e311c ("RDMA/hns: Optimize wqe buffer set flow for post send")
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 499d72c..7a1d30f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -433,8 +433,6 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	unsigned int curr_idx = *sge_idx;
 	int valid_num_sge;
 	u32 msg_len = 0;
-	bool loopback;
-	u8 *smac;
 	int ret;
 
 	valid_num_sge = calc_wr_sge_num(wr, &msg_len);
@@ -457,13 +455,6 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	roce_set_field(ud_sq_wqe->byte_48, V2_UD_SEND_WQE_BYTE_48_DMAC_5_M,
 		       V2_UD_SEND_WQE_BYTE_48_DMAC_5_S, ah->av.mac[5]);
 
-	/* MAC loopback */
-	smac = (u8 *)hr_dev->dev_addr[qp->port];
-	loopback = ether_addr_equal_unaligned(ah->av.mac, smac) ? 1 : 0;
-
-	roce_set_bit(ud_sq_wqe->byte_40,
-		     V2_UD_SEND_WQE_BYTE_40_LBI_S, loopback);
-
 	ud_sq_wqe->msg_len = cpu_to_le32(msg_len);
 
 	/* Set sig attr */
-- 
2.8.1

