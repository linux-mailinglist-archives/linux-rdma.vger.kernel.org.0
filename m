Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF1C6477B7
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 22:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiLHVJ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Dec 2022 16:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLHVJy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Dec 2022 16:09:54 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C0492FC8
        for <linux-rdma@vger.kernel.org>; Thu,  8 Dec 2022 13:09:53 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so3330365fac.2
        for <linux-rdma@vger.kernel.org>; Thu, 08 Dec 2022 13:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQ8TLLspk6HN0CCvZZOb71fJ+C9zF8+JBHlP6f8Y16A=;
        b=ZwWm1IITbVv3SNhUdLISHkskmiDUVIQtb5hwBSpzkXc7iqOIh4h0hPqxsILfnWIY7z
         ghAf5spd/+QckqpPc75aDqG8zzkMh/0QBT9p3ELyczWA3zU1UUcg5EZ+ad8wgtNvglq5
         x+MwV3+bYKvnMABSS1fvHpKhZF5fQe/YrX1IERy0X1VGz5U5vA7x1DoVrZpIMSepGs+V
         +WnEdUFGlOYFFv/GDn3y5JO+CR1bGCYxWQm44qxCEd910vFKNaWf3zghGeWejjcbT2xa
         dnoqruRTkagACfGKQW5CounCwJfO6IzkRgWYfvRv4jlbznuC7rt0JpASi8dK9FPcEAfH
         E/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQ8TLLspk6HN0CCvZZOb71fJ+C9zF8+JBHlP6f8Y16A=;
        b=jG5szvZbiKBWDIdOK12ibwiP1dGPh54KjJHhgm4HkVhulOmu759U4bwsvAHEr+QnoM
         xxhqwNK3LmcHwuP4hGS+vGlPs3E3rImdtWVE1gumvOP2QbV+8HUEs8mlGFDXrTsmMA8W
         CCl+pPNnQyBhgpkENlviWX1N/GskHk09gLH7ay9PmsE6jOAHOgXBOXDEMWbbRyV5BMJM
         e0jwvo+5TRBLc2eoTJ9lUU+C/c1kNd4jse8G7KuG5VLY2zWx2caBI7UE3I/ijKjat9aR
         zELyFHe6ecrOrkpB4mJsm7SjlhdJyC6anBRVAZVwsoSGU4Az4ZNqnyWub38OZjTDAaOa
         H0lw==
X-Gm-Message-State: ANoB5pnse8EGmGTp3GYzayO397l0J5cxQYehfIbfIad5/tqGxIBevP2z
        JVaVCJQf+qNXVT/osWyS7p5OIcv+ADI=
X-Google-Smtp-Source: AA0mqf4GHLk3Fjm3pKUsJU7ZZDRFQmJOOjeZmVX8HJIJZ5fFXWkXA90GtS0z62J39InQYICiVsFehw==
X-Received: by 2002:a05:6870:8dc7:b0:144:87fd:a8a7 with SMTP id lq7-20020a0568708dc700b0014487fda8a7mr1714296oab.46.1670533792431;
        Thu, 08 Dec 2022 13:09:52 -0800 (PST)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a13f-9234-e395-548a.res6.spectrum.com. [2603:8081:140c:1a00:a13f:9234:e395:548a])
        by smtp.googlemail.com with ESMTPSA id s11-20020a056870ea8b00b00143d4709a38sm14199278oap.55.2022.12.08.13.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:09:52 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix incorrect responder length checking
Date:   Thu,  8 Dec 2022 15:09:46 -0600
Message-Id: <20221208210945.28607-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The code in rxe_resp.c at check_length() is incorrect as it
compares pkt->opcode an 8 bit value against various mask bits
which are all higher than 256 so nothing is ever reported.

This patch rewrites this to compare against pkt->mask which is
correct. However this now exposes another error. For UD send
packets the value of the pmtu cannot be determined from qp->mtu.
All that is required here is to later check if the payload fits
into the posted receive buffer in that case.

Fixes: 837a55847ead ("RDMA/rxe: Implement packet length validation on responder")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 62 ++++++++++++++++------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 6ac544477f3f..42261537772c 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -392,36 +392,46 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 	return RESPST_CHK_LENGTH;
 }
 
-static enum resp_states check_length(struct rxe_qp *qp,
-				     struct rxe_pkt_info *pkt)
+static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
+					      struct rxe_pkt_info *pkt)
 {
-	int mtu = qp->mtu;
-	u32 payload = payload_size(pkt);
-	u32 dmalen = reth_len(pkt);
-
-	/* RoCEv2 packets do not have LRH.
-	 * Let's skip checking it.
+	/*
+	 * See IBA C9-92
+	 * For UD QPs we only check if the packet will fit in the
+	 * receive buffer later. For rmda operations additional
+	 * length checks are performed in check_rkey.
 	 */
-
-	if ((pkt->opcode & RXE_START_MASK) &&
-	    (pkt->opcode & RXE_END_MASK)) {
-		/* "only" packets */
-		if (payload > mtu)
-			return RESPST_ERR_LENGTH;
-	} else if ((pkt->opcode & RXE_START_MASK) ||
-		   (pkt->opcode & RXE_MIDDLE_MASK)) {
-		/* "first" or "middle" packets */
-		if (payload != mtu)
-			return RESPST_ERR_LENGTH;
-	} else if (pkt->opcode & RXE_END_MASK) {
-		/* "last" packets */
-		if ((payload == 0) || (payload > mtu))
-			return RESPST_ERR_LENGTH;
+	if (pkt->mask & RXE_PAYLOAD_MASK && ((qp_type(qp) == IB_QPT_RC) ||
+					     (qp_type(qp) == IB_QPT_UC))) {
+		unsigned int mtu = qp->mtu;
+		unsigned int payload = payload_size(pkt);
+
+		if ((pkt->mask & RXE_START_MASK) &&
+		    (pkt->mask & RXE_END_MASK)) {
+			if (unlikely(payload > mtu)) {
+				rxe_dbg_qp(qp, "only packet too long");
+				return RESPST_ERR_LENGTH;
+			}
+		} else if ((pkt->mask & RXE_START_MASK) ||
+			   (pkt->mask & RXE_MIDDLE_MASK)) {
+			if (unlikely(payload != mtu)) {
+				rxe_dbg_qp(qp, "first or middle packet not mtu");
+				return RESPST_ERR_LENGTH;
+			}
+		} else if (pkt->mask & RXE_END_MASK) {
+			if (unlikely((payload == 0) || (payload > mtu))) {
+				rxe_dbg_qp(qp, "last packet zero or too long");
+				return RESPST_ERR_LENGTH;
+			}
+		}
 	}
 
-	if (pkt->opcode & (RXE_WRITE_MASK | RXE_READ_MASK)) {
-		if (dmalen > (1 << 31))
+	/* See IBA C9-94 */
+	if (pkt->mask & RXE_RETH_MASK) {
+		if (reth_len(pkt) > (1U << 31)) {
+			rxe_dbg_qp(qp, "dma length too long");
 			return RESPST_ERR_LENGTH;
+		}
 	}
 
 	return RESPST_CHK_RKEY;
@@ -1397,7 +1407,7 @@ int rxe_responder(void *arg)
 			state = check_resource(qp, pkt);
 			break;
 		case RESPST_CHK_LENGTH:
-			state = check_length(qp, pkt);
+			state = rxe_resp_check_length(qp, pkt);
 			break;
 		case RESPST_CHK_RKEY:
 			state = check_rkey(qp, pkt);
-- 
2.37.2

