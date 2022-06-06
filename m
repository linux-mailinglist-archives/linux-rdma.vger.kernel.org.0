Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BCC53EB81
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbiFFOj3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 10:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbiFFOj0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 10:39:26 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91CD150A29
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 07:39:25 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e656032735so19429492fac.0
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jun 2022 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hNCWlLHg2GISb9iFySN3QSGSoJ3+7SrsBn0Xrg6VcdE=;
        b=bScqZHssX3UlS+ZyQLDeEL8kUFm4Ykl7GGJFD/CsEskODP/zuTC0BlJs5VqrBnLnNi
         flt5fE8rHgdEBwNxk92lYxfXpnCKMGi/Dl2myLqJoYOLH4CTFFXftr5WepFo7bwa5p3U
         TEEnNNJ934sWoKYjtO36yBeSLbA8lnKDTHQWmYsizSonyZwRzyrc+RI1hSZuoU5KfFe7
         c9xWkaa9s2PZmDbPq2IURqNeKRtU2Ct9aFpE1oqGjhocjBRlYSxF613StvTEH13TWuwv
         3Qkl9Cw/fTiL3R5B9z+kl3/8jgz62dnWjSbdqpCUZbz/8JjfNyWvLWPuXOCrdeKgDDIl
         tLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNCWlLHg2GISb9iFySN3QSGSoJ3+7SrsBn0Xrg6VcdE=;
        b=CszRH5Qn0CwdR89JCy80KVYN/4/RxZVgtkuyUemNQvJRg08qYpH1VMkAbgpieAftkH
         C7ERnPkXnRYDBoxlqNzRjzTs4XDN1faUcEA0fjw846lPnIY6PcOKzs0MryUqJhtAnuoN
         hUoJcX62WG1hadj1GThcjDnQ5I2tlLlXiH+PdvOV/LkisSVrPqvPOezRbiLgmxeUWXEk
         wz+5FiBkSiPghFSqck7XE7yEZMR266o+YdKZn5DOuphbwtyUgL7IFMTnolApga149Nuw
         DxFU7BxiprnwH2KT1yML00RZSW9RB/zeIOorD4uh6Rz+jEhxjKOBw0ZK3q1BKa2h+yAl
         WoWA==
X-Gm-Message-State: AOAM531wEZJIblBuUi3I/+SHvl67cV9xM89QsCUFAArCT3qqZMxutITp
        ft3OPNLG8DAnchFNjoI0HAM=
X-Google-Smtp-Source: ABdhPJyi/seBzieyOrCTSuum+BIt9iQkRGPpAkT12n9/Wlh4hSs5AAwBu144wyW2LRDaPSHKhccQAA==
X-Received: by 2002:a05:6871:7a1:b0:f1:b33d:7875 with SMTP id o33-20020a05687107a100b000f1b33d7875mr13691013oap.272.1654526365002;
        Mon, 06 Jun 2022 07:39:25 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id q28-20020a05683022dc00b0060c00c3fde5sm658335otc.72.2022.06.06.07.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:39:24 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        frank.zago@hpe.com, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 1/5] RDMA/rxe: Move code to rxe_prepare_atomic_res()
Date:   Mon,  6 Jun 2022 09:38:33 -0500
Message-Id: <20220606143836.3323-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220606143836.3323-1-rpearsonhpe@gmail.com>
References: <20220606143836.3323-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Separate the code that prepares the atomic responder resource
into a subroutine. This is preparation for merging the normal
and retry atomic responder flows.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 37 ++++++++++++++++++----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index f4f6ee5d81fe..69723bc1a071 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1019,10 +1019,27 @@ static int send_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	return err;
 }
 
+static struct resp_res *rxe_prepare_atomic_res(struct rxe_qp *qp,
+					       struct rxe_pkt_info *pkt)
+{
+	struct resp_res *res;
+
+	res = &qp->resp.resources[qp->resp.res_head];
+	rxe_advance_resp_resource(qp);
+	free_rd_atomic_resource(qp, res);
+
+	res->type = RXE_ATOMIC_MASK;
+	res->first_psn = pkt->psn;
+	res->last_psn = pkt->psn;
+	res->cur_psn = pkt->psn;
+
+	return res;
+}
+
 static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 			   u8 syndrome)
 {
-	int rc = 0;
+	int err = 0;
 	struct rxe_pkt_info ack_pkt;
 	struct sk_buff *skb;
 	struct resp_res *res;
@@ -1031,28 +1048,22 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 				 IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE, 0, pkt->psn,
 				 syndrome);
 	if (!skb) {
-		rc = -ENOMEM;
+		err = -ENOMEM;
 		goto out;
 	}
 
-	res = &qp->resp.resources[qp->resp.res_head];
-	free_rd_atomic_resource(qp, res);
-	rxe_advance_resp_resource(qp);
-
 	skb_get(skb);
-	res->type = RXE_ATOMIC_MASK;
+
+	res = rxe_prepare_atomic_res(qp, pkt);
 	res->atomic.skb = skb;
-	res->first_psn = ack_pkt.psn;
-	res->last_psn  = ack_pkt.psn;
-	res->cur_psn   = ack_pkt.psn;
 
-	rc = rxe_xmit_packet(qp, &ack_pkt, skb);
-	if (rc) {
+	err = rxe_xmit_packet(qp, &ack_pkt, skb);
+	if (err) {
 		pr_err_ratelimited("Failed sending ack\n");
 		rxe_put(qp);
 	}
 out:
-	return rc;
+	return err;
 }
 
 static enum resp_states acknowledge(struct rxe_qp *qp,
-- 
2.34.1

