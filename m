Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2275D67F003
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jan 2023 21:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjA0U5a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Jan 2023 15:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjA0U53 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Jan 2023 15:57:29 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C34F8497E
        for <linux-rdma@vger.kernel.org>; Fri, 27 Jan 2023 12:57:26 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id h3-20020a4ac443000000b004fb2954e7c3so741901ooq.10
        for <linux-rdma@vger.kernel.org>; Fri, 27 Jan 2023 12:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H257jgKZbmcZ9vru3Ro9XPHkmQHSIBXhW6WxZzRrRbQ=;
        b=Jq4lCRmSGnfqx3f09no/Vc0oE2lprc30w6NlMmZNgALfpktGnUXyqmEPxTlpxf+CXU
         t4fwo3vc4tPLNI6KWTxhTv0wj0ojX3TQsJeux9Ywwl4SaF9pGfdVS7aGCu8xneeO4HnY
         VewqJIWVSQ6uKUdCadazJDsJQwPh0G9sAGACDG/pNg17MNymVzPSCBTzTGM2met42BgA
         6S1PsWNmhMAhOZoe0+qCPkFkHituOCE36/8LW83d0NdQHdDY1hTOB93dgwnBWsEuqjug
         agmekZF+LxKMnyd18PJAcSs0MH8JD9Qjs7fVLXEwYb2HlmNtPaAxRbysPCG73auXnIGG
         HsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H257jgKZbmcZ9vru3Ro9XPHkmQHSIBXhW6WxZzRrRbQ=;
        b=VETFygDB0NFB5MDmogQBeWfXhYUtXdrqAbE1nK6IKB191Ffo2wSxCH1czgcWynOT+3
         xi0UOfz9R8RM7wxZj1VDMl2X/AMzHjhBpQ7F2XLK6GVcE3T6QCCF8ZCTAviQm7tlmbB6
         VrKUFD4kWADNjeFrCJa6cR8S7HAHh66k85a98CQqiBNU2vGbx0y/My8CdGaZ4smigMYR
         NCgVnV3gA1XjDi6Dj4wP00/gXhC3SqfL1cg8OHmTFfaa9Vnsa5+PxZH9bMIoMDvqvRo0
         fvosLpaJrgLH74lf1kFCW1kjb1LodWxSU9M1R03Ma36RC9cwNI8pDtskuBoAtKMINY7n
         8lDg==
X-Gm-Message-State: AFqh2kqNRia8vJ7iKQJbwtQmzaQ4jR0FCKKpBrycLeAStnAXWALPe7zq
        qNHLvj/wgweLterHrPvsZTcA4H31+AkgWw==
X-Google-Smtp-Source: AMrXdXuFAhsJEvZxngjhAXlFBgSqRE9zJZkwHplUna9uLE0B0TIb6Hyg+Te2l3gTV5UvDsnOSrkz0A==
X-Received: by 2002:a4a:b5cb:0:b0:4a3:c9f5:c1ab with SMTP id u11-20020a4ab5cb000000b004a3c9f5c1abmr16868081ooo.6.1674853045356;
        Fri, 27 Jan 2023 12:57:25 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id c22-20020a4a2856000000b004fb2935d0e7sm2078452oof.36.2023.01.27.12.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 12:57:24 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, lizhijia@fujitsu.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2] Subject: RDMA/rxe: Handle zero length rdma
Date:   Fri, 27 Jan 2023 14:56:44 -0600
Message-Id: <20230127205643.29801-1-rpearsonhpe@gmail.com>
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

Currently the rxe driver does not handle all cases of zero length
rdma operations correctly. The client does not have to provide an
rkey for zero length RDMA operations so the rkey provided may be
invalid and should not be used to lookup an mr.

This patch corrects the driver to ignore the provided rkey if the
reth length is zero and make sure to set the mr to NULL. In read_reply()
if length is zero rxe_recheck_mr() is not called. Warnings are added in
the routines in rxe_mr.c to catch NULL MRs when the length is non-zero.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2:
  Rebased to current for-next.
  Cleaned up description to be a little more accurate.

 drivers/infiniband/sw/rxe/rxe_resp.c | 43 ++++++++++++++++------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 21b2af948662..b13ae98400c1 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -900,10 +900,11 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	}
 
 	if (res->state == rdatm_res_state_new) {
-		if (qp->resp.length == 0) {
-			mr = NULL;
-			qp->resp.mr = NULL;
-		} else if (!res->replay) {
+		if (!res->replay || qp->resp.length == 0) {
+			/* if length == 0 mr will be NULL (is ok)
+			 * otherwise qp->resp.mr holds a ref on mr
+			 * which we transfer to mr and drop below.
+			 */
 			mr = qp->resp.mr;
 			qp->resp.mr = NULL;
 		} else {
@@ -917,13 +918,13 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		else
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
 	} else {
-		if (qp->resp.length == 0) {
-			mr = NULL;
-		} else {
-			mr = rxe_recheck_mr(qp, res->read.rkey);
-			if (!mr)
-				return RESPST_ERR_RKEY_VIOLATION;
-		}
+		/* re-lookup mr from rkey on all later packets.
+		 * length will be non-zero. This can fail if someone
+		 * modifies or destroys the mr since the first packet.
+		 */
+		mr = rxe_recheck_mr(qp, res->read.rkey);
+		if (!mr)
+			return RESPST_ERR_RKEY_VIOLATION;
 
 		if (res->read.resid > mtu)
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE;
@@ -938,18 +939,16 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	skb = prepare_ack_packet(qp, &ack_pkt, opcode, payload,
 				 res->cur_psn, AETH_ACK_UNLIMITED);
 	if (!skb) {
-		if (mr)
-			rxe_put(mr);
-		return RESPST_ERR_RNR;
+		state = RESPST_ERR_RNR;
+		goto err_out;
 	}
 
 	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
 			  payload, RXE_FROM_MR_OBJ);
-	if (mr)
-		rxe_put(mr);
 	if (err) {
 		kfree_skb(skb);
-		return RESPST_ERR_RKEY_VIOLATION;
+		state = RESPST_ERR_RKEY_VIOLATION;
+		goto err_out;
 	}
 
 	if (bth_pad(&ack_pkt)) {
@@ -958,9 +957,12 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		memset(pad, 0, bth_pad(&ack_pkt));
 	}
 
+	/* rxe_xmit_packet always consumes the skb */
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
-	if (err)
-		return RESPST_ERR_RNR;
+	if (err) {
+		state = RESPST_ERR_RNR;
+		goto err_out;
+	}
 
 	res->read.va += payload;
 	res->read.resid -= payload;
@@ -977,6 +979,9 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		state = RESPST_CLEANUP;
 	}
 
+err_out:
+	if (mr)
+		rxe_put(mr);
 	return state;
 }
 

base-commit: ff33dcb55ca3860092ebb98ad01211159842d566
-- 
2.37.2

