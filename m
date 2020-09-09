Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F44262B25
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 10:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgIII65 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 04:58:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11283 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730157AbgIII64 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Sep 2020 04:58:56 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9B190D4E0E2B5C3E4175;
        Wed,  9 Sep 2020 16:58:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 16:58:43 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 8/9] RDMA/hns: Fix configuration of ack_req_freq in QPC
Date:   Wed, 9 Sep 2020 16:57:33 +0800
Message-ID: <1599641854-23160-9-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
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
index fdbc6b0..fe11c9a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3675,9 +3675,6 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 			     V2_QPC_BYTE_76_SRQ_EN_S, 1);
 	}
 
-	roce_set_field(context->byte_172_sq_psn, V2_QPC_BYTE_172_ACK_REQ_FREQ_M,
-		       V2_QPC_BYTE_172_ACK_REQ_FREQ_S, 4);
-
 	roce_set_bit(context->byte_172_sq_psn, V2_QPC_BYTE_172_FRE_S, 1);
 
 	hr_qp->access_flags = attr->qp_access_flags;
@@ -3988,6 +3985,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	dma_addr_t trrl_ba;
 	dma_addr_t irrl_ba;
 	enum ib_mtu mtu;
+	u8 lp_pktn_ini;
 	u8 port_num;
 	u64 *mtts;
 	u8 *dmac;
@@ -4095,13 +4093,21 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
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

