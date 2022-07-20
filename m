Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A15957B34C
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jul 2022 10:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiGTI4r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jul 2022 04:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTI4q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jul 2022 04:56:46 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB9267CA5
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jul 2022 01:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1658307402; i=@fujitsu.com;
        bh=GwK0f5+nazGfLHGdhdDbn1nqYies5I7If8cq+o9I8XM=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=y26ov6UWL0+TdHi3PBC27luxacdsTv81D1id+jTQwPSCAjQGRNIT0UoR54tJfTT6E
         iMf4O270nayNk/El5UKDfcbB5DXWAbyvm70uxcrETZ3Kp+pn0vbhpFtW4ULPC1KABI
         iG/bV6dMxUPTnNAZC1fYFAt+aHtW38w0p5PmDklvHEbTOs4xxtn9dr67lyeZhpJPmm
         n9ApMvlu5oUXH88i+MG7Q77pMcwk7c4dyGsjKV0pb/2pw+HbCQndLMFCDgRoc90oOR
         aqBr1CkPLvxbABSWsxpyCb+thCXCIrhmtuJIuSusdafKRqF0A+WQe3il4nlxH9TFZy
         o4AmhUkKSz0LQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleJIrShJLcpLzFFi42Kxs+GYpOt1+Hq
  Swb/ljBbHVm5msVjw4S2LxcwZJxgtpvxaymzx7FAvi8WXqdOYLY5POcfuwO6xc9Zddo9NqzrZ
  PHY+tPRY2DCV2ePj01ssHp83yXls/XybJYA9ijUzLym/IoE14+/UvSwFV2QrHn/azN7A2CfZx
  cjFISSwhVHizYuNLBDOciaJ9/0fmSCcfYwST1sms3UxcnKwCWhI3Gu5yQhiiwhcZZQ4el4HxG
  YW0JRY8WE/E4gtLBAjcexYP1ANBweLgKrEl1nFIGFeAReJrsP/2EFsCQEFiSkP3zOD2JwCrhJ
  T3u5lBikXAqr58joVolxQ4uTMJywQ0yUkDr54wQzRqihxpPMvC4RdIfH68CWouJrE1XObmCcw
  Cs5C0j4LSfsCRqZVjFZJRZnpGSW5iZk5uoYGBrqGhqa6QNLURC+xSjdRL7VUtzy1uETXUC+xv
  FgvtbhYr7gyNzknRS8vtWQTIzBuUooZZu1gnNX3U+8QoyQHk5Ior83i60lCfEn5KZUZicUZ8U
  WlOanFhxhlODiUJHirDwLlBItS01Mr0jJzgDEMk5bg4FES4dUFSfMWFyTmFmemQ6ROMepyTJ3
  9bz+zEEtefl6qlDjvI5AiAZCijNI8uBGwdHKJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjDv
  rwNAU3gy80rgNr0COoIJ6IhJTldAjihJREhJNTCdmGmXI/Zgyo0PEf8bJDau/a5a7CTz6uxH3
  4tnV//eeOzpvn+1eSuvBiSLrZv2+czPQ6WXdF+VPQuaePvg5QOiW79/+6a8U+HVzEv7Y9gNpm
  +Y+cXGk0vEbtPh0iqNAvYim8O6exc/bGjjUc3h7qpNXlm91bRoSc0Edj+mutumvvwlWvrSfUv
  e3D/GK9E1e95VnevtpxNF5523NK50rPmy/vLfv6dubEtSlsmNP3BkXp3XnPsrhMJ2/fPkDOBw
  PMzqFeDC69GkUPBPR76Bn5f5Z5tEVcaONZZ3i1hkbkb8T90V/Gp5cVhB//4V2Symen/19dlCn
  f5JX8z5u+vOpr/7O84UuV7kFFeLWTnj5QxvJZbijERDLeai4kQAuCC56aIDAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-9.tower-587.messagelabs.com!1658307401!46125!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29843 invoked from network); 20 Jul 2022 08:56:41 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-9.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Jul 2022 08:56:41 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 96E071000C2;
        Wed, 20 Jul 2022 09:56:41 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 8999A100077;
        Wed, 20 Jul 2022 09:56:41 +0100 (BST)
Received: from centos-smtp.localdomain (10.167.226.45) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 20 Jul 2022 09:56:38 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Cheng Xu <chengyou@linux.alibaba.com>
Subject: [PATCH RESEND for-next v6 3/4] RDMA/rxe: Split qp state for requester and completer
Date:   Wed, 20 Jul 2022 04:56:07 -0400
Message-ID: <1658307368-1851-4-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1658307368-1851-1-git-send-email-lizhijian@fujitsu.com>
References: <1658307368-1851-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bob Pearson <rpearsonhpe@gmail.com>

Currently the requester can continue to process send wqes after
an local qp operation error is detected because the setting of
the qp state to the error state is deferred until later. This
patch splits the qp state for the completer and requester into
two separate states and sets qp->req.state = QP_STATE_ERROR as
soon as the error is detected before another wqe can be executed.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
V4: new patch
---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 6 +++---
 drivers/infiniband/sw/rxe/rxe_qp.c    | 5 +++++
 drivers/infiniband/sw/rxe/rxe_req.c   | 1 +
 drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index da3a398053b8..0b68630a3e49 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -565,10 +565,10 @@ int rxe_completer(void *arg)
 	if (!rxe_get(qp))
 		return -EAGAIN;
 
-	if (!qp->valid || qp->req.state == QP_STATE_ERROR ||
-	    qp->req.state == QP_STATE_RESET) {
+	if (!qp->valid || qp->comp.state == QP_STATE_ERROR ||
+	    qp->comp.state == QP_STATE_RESET) {
 		rxe_drain_resp_pkts(qp, qp->valid &&
-				    qp->req.state == QP_STATE_ERROR);
+				    qp->comp.state == QP_STATE_ERROR);
 		ret = -EAGAIN;
 		goto done;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index f69e3ff095f8..becdcfdfc49b 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -228,6 +228,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 					       QUEUE_TYPE_FROM_CLIENT);
 
 	qp->req.state		= QP_STATE_RESET;
+	qp->comp.state		= QP_STATE_RESET;
 	qp->req.opcode		= -1;
 	qp->comp.opcode		= -1;
 
@@ -488,6 +489,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 
 	/* move qp to the reset state */
 	qp->req.state = QP_STATE_RESET;
+	qp->comp.state = QP_STATE_RESET;
 	qp->resp.state = QP_STATE_RESET;
 
 	/* let state machines reset themselves drain work and packet queues
@@ -550,6 +552,7 @@ void rxe_qp_error(struct rxe_qp *qp)
 {
 	qp->req.state = QP_STATE_ERROR;
 	qp->resp.state = QP_STATE_ERROR;
+	qp->comp.state = QP_STATE_ERROR;
 	qp->attr.qp_state = IB_QPS_ERR;
 
 	/* drain work and packet queues */
@@ -687,6 +690,7 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 			pr_debug("qp#%d state -> INIT\n", qp_num(qp));
 			qp->req.state = QP_STATE_INIT;
 			qp->resp.state = QP_STATE_INIT;
+			qp->comp.state = QP_STATE_INIT;
 			break;
 
 		case IB_QPS_RTR:
@@ -697,6 +701,7 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 		case IB_QPS_RTS:
 			pr_debug("qp#%d state -> RTS\n", qp_num(qp));
 			qp->req.state = QP_STATE_READY;
+			qp->comp.state = QP_STATE_READY;
 			break;
 
 		case IB_QPS_SQD:
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index cbb2ce2d7b50..35a249727435 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -774,6 +774,7 @@ int rxe_requester(void *arg)
 	/* update wqe_index for each wqe completion */
 	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
 	wqe->state = wqe_state_error;
+	qp->req.state = QP_STATE_ERROR;
 	__rxe_do_task(&qp->comp.task);
 
 exit:
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 628e40c1714b..ab899aee72e4 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -128,6 +128,7 @@ struct rxe_req_info {
 };
 
 struct rxe_comp_info {
+	enum rxe_qp_state	state;
 	u32			psn;
 	int			opcode;
 	int			timeout;
-- 
2.31.1

