Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D3E54CCD6
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 17:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349193AbiFOP2S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353642AbiFOP1x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 11:27:53 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8EB3A8
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=6mxleO61ntnrzTsACZ11U45J7gyAN6fy3NChb7ddr5M=; b=2tzVPyC+Dqc/CtiPiER/+45TWp
        R3w9YUKggRPBI80DaewsVLFUOjbWw76UMW+7R/9gNJNKsjYDJK4/8gnuw+4JiRLB5Wd/ToaRhmnH9
        ZEKH7YRKdiuiATCjSkjLoe8CeXI78DYymhAEYOCkkJlH5pgDGwWdq1pppXH/7j+l3o8vZkj/u72Ki
        dkXAOlbz4UrsKHKGcAeBikBylOkl6DySCV6ARdSKu1Ak5vPhEL6D7VkPCGV2D1hBaEmeS1onB89AM
        5/U+pxq6yefwAX9nuakNCqA2chuwV++mqAc4dKEwWAbSrouID9iBaSDQ2fn8vF49SFzSxc3UG3/Nh
        nfL6JvMprk7fwdq1XcWmFDAwjSqDPjR67GOeH6Yo29N7MmZ+8Hjdz6TOTqPpk7jq2VUUJ2cU8F05Z
        46HwaF8zqqpybiAwhmSfYk4iOhefU3lyT78nYdW8RYKkn+rB/lTyFMxBe7yxndMuFOYKXSayNK+XV
        nsdb/JRaAhRV3KC42zu1ywbJ;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1UvT-005rtL-AL; Wed, 15 Jun 2022 15:27:23 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH v2 03/14] rdma/siw: split out a __siw_cep_terminate_upcall() function
Date:   Wed, 15 Jun 2022 17:26:41 +0200
Message-Id: <7c1b2f0b2cabc91c0085f7d04da75cb80dd72ccb.1655305567.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655305567.git.metze@samba.org>
References: <cover.1655305567.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are multiple places where should have the same logic.
Having one helper function to be used in all places
makes it easier to extended the logic.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 53 ++++++++++++++++++------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index eeb366edba2a..c5ef5de7e84c 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -103,6 +103,37 @@ static void siw_socket_disassoc(struct socket *s)
 	}
 }
 
+/*
+ * The caller needs to deal with siw_cep_set_inuse()
+ * and siw_cep_set_free()
+ */
+static void __siw_cep_terminate_upcall(struct siw_cep *cep,
+				       int reply_status)
+{
+	if (cep->qp && cep->qp->term_info.valid)
+		siw_send_terminate(cep->qp);
+
+	switch (cep->state) {
+	case SIW_EPSTATE_AWAIT_MPAREP:
+		siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY,
+			      reply_status);
+		break;
+
+	case SIW_EPSTATE_RDMA_MODE:
+		siw_cm_upcall(cep, IW_CM_EVENT_CLOSE, 0);
+		break;
+
+	case SIW_EPSTATE_IDLE:
+	case SIW_EPSTATE_LISTENING:
+	case SIW_EPSTATE_CONNECTING:
+	case SIW_EPSTATE_AWAIT_MPAREQ:
+	case SIW_EPSTATE_RECVD_MPAREQ:
+	case SIW_EPSTATE_CLOSED:
+	default:
+		break;
+	}
+}
+
 static void siw_rtr_data_ready(struct sock *sk)
 {
 	struct siw_cep *cep;
@@ -393,29 +424,9 @@ void siw_qp_cm_drop(struct siw_qp *qp, int schedule)
 		}
 		siw_dbg_cep(cep, "immediate close, state %d\n", cep->state);
 
-		if (qp->term_info.valid)
-			siw_send_terminate(qp);
+		__siw_cep_terminate_upcall(cep, -EINVAL);
 
 		if (cep->cm_id) {
-			switch (cep->state) {
-			case SIW_EPSTATE_AWAIT_MPAREP:
-				siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY,
-					      -EINVAL);
-				break;
-
-			case SIW_EPSTATE_RDMA_MODE:
-				siw_cm_upcall(cep, IW_CM_EVENT_CLOSE, 0);
-				break;
-
-			case SIW_EPSTATE_IDLE:
-			case SIW_EPSTATE_LISTENING:
-			case SIW_EPSTATE_CONNECTING:
-			case SIW_EPSTATE_AWAIT_MPAREQ:
-			case SIW_EPSTATE_RECVD_MPAREQ:
-			case SIW_EPSTATE_CLOSED:
-			default:
-				break;
-			}
 			cep->cm_id->rem_ref(cep->cm_id);
 			cep->cm_id = NULL;
 			siw_cep_put(cep);
-- 
2.34.1

