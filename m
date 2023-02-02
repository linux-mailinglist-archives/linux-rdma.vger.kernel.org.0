Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BA96874A7
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 05:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjBBErS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Feb 2023 23:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjBBEqs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Feb 2023 23:46:48 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7CE7F682
        for <linux-rdma@vger.kernel.org>; Wed,  1 Feb 2023 20:45:10 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id j21so517014oie.4
        for <linux-rdma@vger.kernel.org>; Wed, 01 Feb 2023 20:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K71LkKjUysHMuHJZhNky6axTD+J0vyo1s9ayLvx59z0=;
        b=E8FJ1BIVN+wmKNMlvbYUR4MhZOY8uQ0LiDhDT52TOioyNrPY/6a0GB7JyPsKq+8LNH
         g7ksL/drG6rxseHZSF21/jhKs5VriEKySVUsOxk1NMMr7DtteN53lxfpacMi48yn+29q
         GetsL3IxpxY9kelmLDAhGI1M0JHmN1t5Pbo/Ydfj8gH6/j2tKBU1KGguPykIbX4SrWcL
         wJC5tookudsOlcnnnUt/lO/Sd0o5OVl92zuNezGqYSjHi3x7Ekbr+c5o/ycKBrNblxkP
         OMvZQw6/08hAC9oui39JF3UhEPWwKSY0SHLk3KZ1cQSDEyjqVYDp5Hbp48gJ4Q7L9cvF
         n6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K71LkKjUysHMuHJZhNky6axTD+J0vyo1s9ayLvx59z0=;
        b=ZTPx1r9W9QhQ8CRZffz3+btKUWGKsRnvdPJIZ75N2PR49w5iLcCkgL+tCNP5njhdCx
         k8r9a0VWyLxuj/Qr3IyZpRBeWfUeaCrS60sGeWxstbSB/sHlwu8aHa/nrP1qtPW4iipi
         9RQInq1EIEt+wlUltaW4B2bJ/C+Gn061x57LgiYmHEEMCd2UxdVV+JUjmiPAL7562bYx
         g61YR8wGXDXmbwqFspDR4aVQmbzDUMb5xUw75C2GoxAitD12ZFW3q/OCSg3DOloSHucw
         PYr7aT6Rj8DxkVwd1VOct4qkEWHwN3h1vQjnjMv17V0BNmbediYVIOEwmojqlm6HRqa4
         XzhA==
X-Gm-Message-State: AO0yUKX8tJFfeWM6VJYPMpbxXEX7dhp4lkyYjZnuzdcOKQ1Lh1Ap3Aj1
        XDI3oFREh90i6b3ajBwe6K0=
X-Google-Smtp-Source: AK7set++6ul/0BGmsYm0W1V2stXR1UTZNn19bfYP3WVIfcL5C6jXWJYHRx96isR4y4Kjts7E+19zaA==
X-Received: by 2002:a05:6808:210a:b0:378:1ae0:1198 with SMTP id r10-20020a056808210a00b003781ae01198mr2711434oiw.1.1675313108352;
        Wed, 01 Feb 2023 20:45:08 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id m7-20020aca6507000000b003631fe1810dsm4959501oim.47.2023.02.01.20.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 20:45:07 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        matsuda-daisuke@fujitsu.com, tom@talpey.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4] Subject: RDMA/rxe: Handle zero length rdma
Date:   Wed,  1 Feb 2023 22:42:41 -0600
Message-Id: <20230202044240.6304-1-rpearsonhpe@gmail.com>
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
rkey for zero length RDMA read or write operations so the rkey
provided may be invalid and should not be used to lookup an mr.

This patch corrects the driver to ignore the provided rkey if the
reth length is zero for read or write operations and make sure to
set the mr to NULL. In read_reply() if length is zero rxe_recheck_mr()
is not called. Warnings are added in the routines in rxe_mr.c to
catch NULL MRs when the length is non-zero.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v4:
  Fixed a regression in flush operations because the rkey must be
  valid in that case even if the length is zero which maybe the
  case for selectivity level of the entire memory region.

Reported-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>

v3:
  Fixed my fat finger typing on v2. Mangled the patch.

v2:
  Rebased to current for-next.
  Cleaned up description to be a little more accurate.
---
 drivers/infiniband/sw/rxe/rxe_mr.c   |  7 ++++
 drivers/infiniband/sw/rxe/rxe_resp.c | 59 +++++++++++++++++++++-------
 2 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index c80458634962..5e9a03831bf9 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -314,6 +314,9 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 	if (length == 0)
 		return 0;
 
+	if (WARN_ON(!mr))
+		return -EINVAL;
+
 	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
 		rxe_mr_copy_dma(mr, iova, addr, length, dir);
 		return 0;
@@ -432,6 +435,10 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
 	int err;
 	u8 *va;
 
+	/* mr must be valid even if length is zero */
+	if (WARN_ON(!mr))
+		return -EINVAL;
+
 	if (length == 0)
 		return 0;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index cccf7c6c21e9..c8e7b4ca456b 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -420,13 +420,23 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
 	return RESPST_CHK_RKEY;
 }
 
+/* if the reth length field is zero we can assume nothing
+ * about the rkey value and should not validate or use it.
+ * Instead set qp->resp.rkey to 0 which is an invalid rkey
+ * value since the minimum index part is 1.
+ */
 static void qp_resp_from_reth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 {
+	unsigned int length = reth_len(pkt);
+
 	qp->resp.va = reth_va(pkt);
 	qp->resp.offset = 0;
-	qp->resp.rkey = reth_rkey(pkt);
-	qp->resp.resid = reth_len(pkt);
-	qp->resp.length = reth_len(pkt);
+	qp->resp.resid = length;
+	qp->resp.length = length;
+	if (pkt->mask & RXE_READ_OR_WRITE_MASK && length == 0)
+		qp->resp.rkey = 0;
+	else
+		qp->resp.rkey = reth_rkey(pkt);
 }
 
 static void qp_resp_from_atmeth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
@@ -437,6 +447,10 @@ static void qp_resp_from_atmeth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 	qp->resp.resid = sizeof(u64);
 }
 
+/* resolve the packet rkey to qp->resp.mr or set qp->resp.mr to NULL
+ * if an invalid rkey is received or the rdma length is zero. For middle
+ * or last packets use the stored value of mr.
+ */
 static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
@@ -473,10 +487,12 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		return RESPST_EXECUTE;
 	}
 
-	/* A zero-byte op is not required to set an addr or rkey. See C9-88 */
+	/* A zero-byte read or write op is not required to
+	 * set an addr or rkey. See C9-88
+	 */
 	if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
-	    (pkt->mask & RXE_RETH_MASK) &&
-	    reth_len(pkt) == 0) {
+	    (pkt->mask & RXE_RETH_MASK) && reth_len(pkt) == 0) {
+		qp->resp.mr = NULL;
 		return RESPST_EXECUTE;
 	}
 
@@ -555,6 +571,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	return RESPST_EXECUTE;
 
 err:
+	qp->resp.mr = NULL;
 	if (mr)
 		rxe_put(mr);
 	if (mw)
@@ -889,7 +906,11 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	}
 
 	if (res->state == rdatm_res_state_new) {
-		if (!res->replay) {
+		if (!res->replay || qp->resp.length == 0) {
+			/* if length == 0 mr will be NULL (is ok)
+			 * otherwise qp->resp.mr holds a ref on mr
+			 * which we transfer to mr and drop below.
+			 */
 			mr = qp->resp.mr;
 			qp->resp.mr = NULL;
 		} else {
@@ -903,6 +924,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		else
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
 	} else {
+		/* re-lookup mr from rkey on all later packets.
+		 * length will be non-zero. This can fail if someone
+		 * modifies or destroys the mr since the first packet.
+		 */
 		mr = rxe_recheck_mr(qp, res->read.rkey);
 		if (!mr)
 			return RESPST_ERR_RKEY_VIOLATION;
@@ -920,18 +945,16 @@ static enum resp_states read_reply(struct rxe_qp *qp,
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
@@ -940,9 +963,12 @@ static enum resp_states read_reply(struct rxe_qp *qp,
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
@@ -959,6 +985,9 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		state = RESPST_CLEANUP;
 	}
 
+err_out:
+	if (mr)
+		rxe_put(mr);
 	return state;
 }
 

base-commit: 01884059c09fa770206ca03bf3660502f97d5fdd
-- 
2.37.2

