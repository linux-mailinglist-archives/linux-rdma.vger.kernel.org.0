Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E69C6D735B
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Apr 2023 06:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbjDEE0y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Apr 2023 00:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDEE0x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Apr 2023 00:26:53 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D283310CF
        for <linux-rdma@vger.kernel.org>; Tue,  4 Apr 2023 21:26:52 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id y184so25827633oiy.8
        for <linux-rdma@vger.kernel.org>; Tue, 04 Apr 2023 21:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680668812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9O+HD33FVdquyuVKwfAdYxW6gFbaxtWKtNZ/Gth7z5k=;
        b=bTFk4IaGSUAfSzBUcUR2+ZQdZ8EiuSf9+8V3Mvdn5zY4WVM4Gmw7wKwhwi0BBxFijw
         TB/01VwoMIw+0KYUIPZK2pjjC305+DeP4d9ABQOe0vtgkzIIwPtNlRwxfNqptRoMK5zz
         WN95K9iZFqdKFkkB1S2U4/bZ3QzdqyCt7tcXa5WlGFyFnMuqkYQsQLuVuSpEf12lxgX5
         qBuIzOhDYg73lPIdoTVhvgzJQkN37iOXZSI/KriIgOY/g4nBb7Wy/cYL0fJjIBoTPbGD
         efdhBdD695eBeS9eTS9trH3zK4vx48OLJdM0F6s0btX+ZOJtlcRefDiOUBUhA1sdVRFp
         E5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680668812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9O+HD33FVdquyuVKwfAdYxW6gFbaxtWKtNZ/Gth7z5k=;
        b=xeZbQCDTBFPtiehUyKOBBHkrNZOPiv1UfOCnFh/aauc5647Y/4QV/Dfp+tZradbWkB
         q15QBOGEtQM94rh5kvPTCRBPrGa7xIOojCxzUAR9X10Sa8SRCRsOH3H6fh/lXAHpW6kq
         rmZSjmRm91ApA7WbezBIaQ6qEmg0j++vOkfjOMy9fNJSmZVR8HH5yYkxpjWqxcjbNsn4
         ULXaxyVonanbnPC1CqQ0G7BYCQv3wBh8U2NuvYE3VyONSUWGmaEZaAm8Xej2iSzgvwAp
         txopFN3NuduyFmNWvqikbeXPsvIB+Tl8JSW7hi+KI2kXowVhlEzL096V/r87l9PhbibN
         VrMw==
X-Gm-Message-State: AAQBX9eKrIfBt9edzhocGd22GDVrGMNWpyHI4DFew4gNg3BJ5As7whwX
        vdIP/bkf3g9f6Ci00SOdnoR8IAaTBaA=
X-Google-Smtp-Source: AKy350Zn14eDwyTf8SLFld70XnvyIPyFZ+3cPtrNjWRuWLvJLZJEsjJwYQhvBcHBoF6r/kUmwqzdkA==
X-Received: by 2002:a05:6808:46:b0:389:7b6b:7a2c with SMTP id v6-20020a056808004600b003897b6b7a2cmr2260320oic.44.1680668812161;
        Tue, 04 Apr 2023 21:26:52 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id x80-20020a4a4153000000b0053d9be4be68sm6321326ooa.19.2023.04.04.21.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 21:26:45 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 2/5] RDMA/rxe: Remove qp->comp.state
Date:   Tue,  4 Apr 2023 23:26:08 -0500
Message-Id: <20230405042611.6467-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230405042611.6467-1-rpearsonhpe@gmail.com>
References: <20230405042611.6467-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The rxe driver has four different QP state variables,
    qp->attr.qp_state,
    qp->req.state,
    qp->comp.state, and
    qp->resp.state.
All of these basically carry the same information.

This patch replaces uses of qp->comp.state by qp->attr.qp_state.
This is the second of three patches which will remove all but the
qp->attr.qp_state variable. This will bring the driver closer
to the IBA description.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 8 ++++----
 drivers/infiniband/sw/rxe/rxe_qp.c    | 5 -----
 drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 2c70cdcd55dc..173ebfe784e6 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -619,10 +619,10 @@ int rxe_completer(struct rxe_qp *qp)
 	enum comp_state state;
 	int ret;
 
-	if (!qp->valid || qp->comp.state == QP_STATE_ERROR ||
-	    qp->comp.state == QP_STATE_RESET) {
-		bool notify = qp->valid &&
-				(qp->comp.state == QP_STATE_ERROR);
+	if (!qp->valid || qp_state(qp) == IB_QPS_ERR ||
+	    qp_state(qp) == IB_QPS_RESET) {
+		bool notify = qp->valid && (qp_state(qp) == IB_QPS_ERR);
+
 		drain_resp_pkts(qp);
 		flush_send_queue(qp, notify);
 		goto exit;
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 38694b355bed..a4486d9c540e 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -232,7 +232,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 					       QUEUE_TYPE_FROM_CLIENT);
 
 	qp->req.state		= QP_STATE_RESET;
-	qp->comp.state		= QP_STATE_RESET;
 	qp->req.opcode		= -1;
 	qp->comp.opcode		= -1;
 
@@ -477,7 +476,6 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 
 	/* move qp to the reset state */
 	qp->req.state = QP_STATE_RESET;
-	qp->comp.state = QP_STATE_RESET;
 
 	/* drain work and packet queuesc */
 	rxe_requester(qp);
@@ -530,7 +528,6 @@ static void rxe_qp_drain(struct rxe_qp *qp)
 void rxe_qp_error(struct rxe_qp *qp)
 {
 	qp->req.state = QP_STATE_ERROR;
-	qp->comp.state = QP_STATE_ERROR;
 	qp->attr.qp_state = IB_QPS_ERR;
 
 	/* drain work and packet queues */
@@ -660,7 +657,6 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 		case IB_QPS_INIT:
 			rxe_dbg_qp(qp, "state -> INIT\n");
 			qp->req.state = QP_STATE_INIT;
-			qp->comp.state = QP_STATE_INIT;
 			break;
 
 		case IB_QPS_RTR:
@@ -670,7 +666,6 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 		case IB_QPS_RTS:
 			rxe_dbg_qp(qp, "state -> RTS\n");
 			qp->req.state = QP_STATE_READY;
-			qp->comp.state = QP_STATE_READY;
 			break;
 
 		case IB_QPS_SQD:
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 12594cb2a9cf..1ae8dfd0ce7b 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -127,7 +127,6 @@ struct rxe_req_info {
 };
 
 struct rxe_comp_info {
-	enum rxe_qp_state	state;
 	u32			psn;
 	int			opcode;
 	int			timeout;
-- 
2.37.2

