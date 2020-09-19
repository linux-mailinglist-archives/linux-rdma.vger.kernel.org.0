Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCF3270CC9
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 12:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgISKEt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Sep 2020 06:04:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45376 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbgISKEs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 19 Sep 2020 06:04:48 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9AA749ECFBEB73002912;
        Sat, 19 Sep 2020 18:04:45 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 18:04:35 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 7/8] RDMA/hns: Fix configuration of ack_req_freq in QPC
Date:   Sat, 19 Sep 2020 18:03:21 +0800
Message-ID: <1600509802-44382-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1600509802-44382-1-git-send-email-liweihang@huawei.com>
References: <1600509802-44382-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The hardware will add AckReq flag in BTH header according to the value of
ack_req_freq to request ACK from responder for the packets with this flag.
It should be greater than or equal to lp_pktn_ini instead of using a fixed
value.

Fixes: 7b9bd73ed13d ("RDMA/hns: Fix wrong assignment of lp_pktn_ini in QPC")
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 316cdb6..f0101a7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3664,9 +3664,6 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 			     V2_QPC_BYTE_76_SRQ_EN_S, 1);
 	}
 
-	roce_set_field(context->byte_172_sq_psn, V2_QPC_BYTE_172_ACK_REQ_FREQ_M,
-		       V2_QPC_BYTE_172_ACK_REQ_FREQ_S, 4);
-
 	roce_set_bit(context->byte_172_sq_psn, V2_QPC_BYTE_172_FRE_S, 1);
 
 	hr_qp->access_flags = attr->qp_access_flags;
@@ -3977,6 +3974,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	dma_addr_t trrl_ba;
 	dma_addr_t irrl_ba;
 	enum ib_mtu mtu;
+	u8 lp_pktn_ini;
 	u8 port_num;
 	u64 *mtts;
 	u8 *dmac;
@@ -4084,13 +4082,21 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	}
 
 #define MAX_LP_MSG_LEN 65536
-	/* MTU*(2^LP_PKTN_INI) shouldn't be bigger than 64kb */
+	/* MTU * (2 ^ LP_PKTN_INI) shouldn't be bigger than 64KB */
+	lp_pktn_ini = ilog2(MAX_LP_MSG_LEN / ib_mtu_enum_to_int(mtu));
+
 	roce_set_field(context->byte_56_dqpn_err, V2_QPC_BYTE_56_LP_PKTN_INI_M,
-		       V2_QPC_BYTE_56_LP_PKTN_INI_S,
-		       ilog2(MAX_LP_MSG_LEN / ib_mtu_enum_to_int(mtu)));
+		       V2_QPC_BYTE_56_LP_PKTN_INI_S, lp_pktn_ini);
 	roce_set_field(qpc_mask->byte_56_dqpn_err, V2_QPC_BYTE_56_LP_PKTN_INI_M,
 		       V2_QPC_BYTE_56_LP_PKTN_INI_S, 0);
 
+	/* ACK_REQ_FREQ should be larger than or equal to LP_PKTN_INI */
+	roce_set_field(context->byte_172_sq_psn, V2_QPC_BYTE_172_ACK_REQ_FREQ_M,
+		       V2_QPC_BYTE_172_ACK_REQ_FREQ_S, lp_pktn_ini);
+	roce_set_field(qpc_mask->byte_172_sq_psn,
+		       V2_QPC_BYTE_172_ACK_REQ_FREQ_M,
+		       V2_QPC_BYTE_172_ACK_REQ_FREQ_S, 0);
+
 	roce_set_bit(qpc_mask->byte_108_rx_reqepsn,
 		     V2_QPC_BYTE_108_RX_REQ_PSN_ERR_S, 0);
 	roce_set_field(qpc_mask->byte_96_rx_reqmsn, V2_QPC_BYTE_96_RX_REQ_MSN_M,
-- 
2.8.1

