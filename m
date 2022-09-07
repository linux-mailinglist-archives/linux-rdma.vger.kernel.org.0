Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCE55AFA06
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 04:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiIGCmB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 22:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIGCl6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 22:41:58 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76F5792DA;
        Tue,  6 Sep 2022 19:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1662518515; i=@fujitsu.com;
        bh=FXz8g5NuKtLllkSCn8NXZeFBjCQlegQSoRfTyvz3x6g=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=eXteeUMZZs2nT62LzkX8pDYrjWYGhexMcg8CUGIkIdlgzSBZILxk6XBAM+3NyimoQ
         zydJ905qhI+m8ATMYhhJgIKI2vaPM/2mgHvQk/qXWXeEgzITN+Po+5/eImpXd9OCVJ
         /Pa3tl+JiyNPK6z2swUWBcmt0A338kNjWJLlok3ZpUmr77qbzvG430i5Sas4SxO5fO
         /LhNn7JFT6+mhV0NmD+8KQgEKxlTsyFvsZ8qj6MXSrWgiYZtrKSuU9lLZji5aS16KD
         X24GDinSesqLmSZqCPjN23aSUHsuCKsJ+jR3f1rKEs70onn5qZMYwUWiPcefb700KV
         iJKtgw+BKp2Iw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRWlGSWpSXmKPExsViZ8MxSfcji0S
  ywZrpBhYzZ5xgtJjyaymzxeVdc9gsnh3qZbE4f6yf3YHVY+esu+wem1Z1snl83iTnsfXzbZYA
  lijWzLyk/IoE1oy7H1qYC5YpVfQ3PmBqYPwk3cXIxSEksIVR4u3V9SwQznImiRVrG6Cc/YwSs
  65/BnI4OdgENCTutdxkBLFFBGIk/h37BWYzC7hJbHozmx3EFhZwljjw5RBYPYuAisTvRYfAan
  gFHCWebVrEBmJLCChITHn4nhnE5hRwkjj9rBWongNomaPEnat1EOWCEidnPmGBGC8hcfDFC2a
  QEgkBJYmZ3fEQUyokGqcfYoKw1SSuntvEPIFRcBaS7llIuhcwMq1itEoqykzPKMlNzMzRNTQw
  0DU0NNU11DUyNNdLrNJN1Est1S1PLS7RNdRLLC/WSy0u1iuuzE3OSdHLSy3ZxAiMg5Rixps7G
  Fv7fuodYpTkYFIS5VW9IZ4sxJeUn1KZkVicEV9UmpNafIhRhoNDSYKXj0EiWUiwKDU9tSItMw
  cYkzBpCQ4eJRGING9xQWJucWY6ROoUo6KUOO9uRqCEAEgiozQPrg2WBi4xykoJ8zIyMDAI8RS
  kFuVmlqDKv2IU52BUEuZ1AJnCk5lXAjf9FdBiJqDFWwPFQRaXJCKkpBqYdCJWZ92VqvX2PHTm
  /q2qaaL2a1deW/Vnp/vkf263nzDfO2f0uPqDgu/MmMnKi+wVny34c2RXoKeXoadIfifL98YHo
  h8Em79+nt7xcqIoW4bvAgehJFZ5l8rFSvFbOBw2/jzPyanIpF5qGveVO/PTxXa5rL3Ppu9yuz
  ftXrXxRusDi3NZvl2r5fMW8QxzOBW4p/jK5EOhRleemm0y8FD0WGe5qdQt0fRtt8vjLS9rVcW
  iJZwz8p+qPVidl+qxoHBFEE/tB681mQassxd4FjRKaP9YY+m+6yo7s96N0zyb7E95tjPZBy26
  X7jtn1ttoYRUXNr8qX0apcwLNLR3Pdba/p5x5kPO29rvF6ade+WqxFKckWioxVxUnAgA0cmFM
  X4DAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-16.tower-585.messagelabs.com!1662518513!997669!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24954 invoked from network); 7 Sep 2022 02:41:53 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-16.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Sep 2022 02:41:53 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 5D6041000C2;
        Wed,  7 Sep 2022 03:41:53 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 4FE1A1000C1;
        Wed,  7 Sep 2022 03:41:53 +0100 (BST)
Received: from 21b4d06c27e6.localdomain (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 7 Sep 2022 03:41:50 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next 2/2] RDMA/rxe: convert pr_warn to pr_debug
Date:   Wed, 7 Sep 2022 02:48:21 +0000
Message-ID: <1662518901-2-2-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1662518901-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1662518901-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

They could be triggered by user APIs with invalid parameters.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 45 +++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index ad7f06f4beb0..a62bab88415c 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -19,34 +19,34 @@ static int rxe_qp_chk_cap(struct rxe_dev *rxe, struct ib_qp_cap *cap,
 			  int has_srq)
 {
 	if (cap->max_send_wr > rxe->attr.max_qp_wr) {
-		pr_warn("invalid send wr = %u > %d\n",
-			cap->max_send_wr, rxe->attr.max_qp_wr);
+		pr_debug("invalid send wr = %u > %d\n",
+			 cap->max_send_wr, rxe->attr.max_qp_wr);
 		goto err1;
 	}
 
 	if (cap->max_send_sge > rxe->attr.max_send_sge) {
-		pr_warn("invalid send sge = %u > %d\n",
-			cap->max_send_sge, rxe->attr.max_send_sge);
+		pr_debug("invalid send sge = %u > %d\n",
+			 cap->max_send_sge, rxe->attr.max_send_sge);
 		goto err1;
 	}
 
 	if (!has_srq) {
 		if (cap->max_recv_wr > rxe->attr.max_qp_wr) {
-			pr_warn("invalid recv wr = %u > %d\n",
-				cap->max_recv_wr, rxe->attr.max_qp_wr);
+			pr_debug("invalid recv wr = %u > %d\n",
+				 cap->max_recv_wr, rxe->attr.max_qp_wr);
 			goto err1;
 		}
 
 		if (cap->max_recv_sge > rxe->attr.max_recv_sge) {
-			pr_warn("invalid recv sge = %u > %d\n",
-				cap->max_recv_sge, rxe->attr.max_recv_sge);
+			pr_debug("invalid recv sge = %u > %d\n",
+				 cap->max_recv_sge, rxe->attr.max_recv_sge);
 			goto err1;
 		}
 	}
 
 	if (cap->max_inline_data > rxe->max_inline_data) {
-		pr_warn("invalid max inline data = %u > %d\n",
-			cap->max_inline_data, rxe->max_inline_data);
+		pr_debug("invalid max inline data = %u > %d\n",
+			 cap->max_inline_data, rxe->max_inline_data);
 		goto err1;
 	}
 
@@ -73,7 +73,7 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 	}
 
 	if (!init->recv_cq || !init->send_cq) {
-		pr_warn("missing cq\n");
+		pr_debug("missing cq\n");
 		goto err1;
 	}
 
@@ -82,14 +82,14 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 
 	if (init->qp_type == IB_QPT_GSI) {
 		if (!rdma_is_port_valid(&rxe->ib_dev, port_num)) {
-			pr_warn("invalid port = %d\n", port_num);
+			pr_debug("invalid port = %d\n", port_num);
 			goto err1;
 		}
 
 		port = &rxe->port;
 
 		if (init->qp_type == IB_QPT_GSI && port->qp_gsi_index) {
-			pr_warn("GSI QP exists for port %d\n", port_num);
+			pr_debug("GSI QP exists for port %d\n", port_num);
 			goto err1;
 		}
 	}
@@ -402,7 +402,7 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 					attr->qp_state : cur_state;
 
 	if (!ib_modify_qp_is_ok(cur_state, new_state, qp_type(qp), mask)) {
-		pr_warn("invalid mask or state for qp\n");
+		pr_debug("invalid mask or state for qp\n");
 		goto err1;
 	}
 
@@ -416,7 +416,7 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	if (mask & IB_QP_PORT) {
 		if (!rdma_is_port_valid(&rxe->ib_dev, attr->port_num)) {
-			pr_warn("invalid port %d\n", attr->port_num);
+			pr_debug("invalid port %d\n", attr->port_num);
 			goto err1;
 		}
 	}
@@ -431,12 +431,12 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 		if (rxe_av_chk_attr(rxe, &attr->alt_ah_attr))
 			goto err1;
 		if (!rdma_is_port_valid(&rxe->ib_dev, attr->alt_port_num))  {
-			pr_warn("invalid alt port %d\n", attr->alt_port_num);
+			pr_debug("invalid alt port %d\n", attr->alt_port_num);
 			goto err1;
 		}
 		if (attr->alt_timeout > 31) {
-			pr_warn("invalid QP alt timeout %d > 31\n",
-				attr->alt_timeout);
+			pr_debug("invalid QP alt timeout %d > 31\n",
+				 attr->alt_timeout);
 			goto err1;
 		}
 	}
@@ -457,17 +457,16 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	if (mask & IB_QP_MAX_QP_RD_ATOMIC) {
 		if (attr->max_rd_atomic > rxe->attr.max_qp_rd_atom) {
-			pr_warn("invalid max_rd_atomic %d > %d\n",
-				attr->max_rd_atomic,
-				rxe->attr.max_qp_rd_atom);
+			pr_debug("invalid max_rd_atomic %d > %d\n",
+				 attr->max_rd_atomic,
+				 rxe->attr.max_qp_rd_atom);
 			goto err1;
 		}
 	}
 
 	if (mask & IB_QP_TIMEOUT) {
 		if (attr->timeout > 31) {
-			pr_warn("invalid QP timeout %d > 31\n",
-				attr->timeout);
+			pr_debug("invalid QP timeout %d > 31\n", attr->timeout);
 			goto err1;
 		}
 	}
-- 
1.8.3.1

