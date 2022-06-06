Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8C253E66F
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbiFFOjb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 10:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbiFFOj1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 10:39:27 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E747714C749
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 07:39:26 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id y69so6128321oia.7
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jun 2022 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0KF+yaCXSyIYckD85Ccvzhib8uV1qADvrtwkcf45tUs=;
        b=NdwMWgxS3Fl9YTO4Zbks9aus4zS/Qt/g+prIdCP0Yn/xCYwHfNHFTr19HCixXDF3Fl
         jqI3EMbQl+cs1ipSLbhSYYkJAVXBBKARR7TI+SAmPvgCiy1MRnYNNeUypLdb1sEtujGp
         3/W/TMiXyt/WxSuTi+h6QMmAE2O0zmiddVfNoFeCZ+5evpdSwqErlfLCUQ7vdsN6vHqv
         HW938ZimF6pbNew5k2nfl6nhtVek+qpz0XX4w59z1H+/Tr9ghK1GBivlFPqH8QG/GYRX
         ClXvVKibheS69jJ/WCyqBHwQB8A7pv70/wqp6st8P+f8etDTfiL15keNzq9hJFX3Q+ns
         +qFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0KF+yaCXSyIYckD85Ccvzhib8uV1qADvrtwkcf45tUs=;
        b=SrfgT35k+qqzwWz6Pq31fYTdzN+BhQ+lbv2JdfU6wqjIcq2Qng6wVNp+7payu/o6+A
         Cw3NjT+YL/hGx25N2UXt5GFvLCCcTVXMjE4hUf6GMnPFTuvhHUedCuIVx7j5U8RufW/P
         NsHDpXfsnwP5i7VxMhJVdo9rP5TVkDjhewTW53cmvyf59K0Kbib3mr2T0YrHNZ1tofXT
         Fe0fyGsy2fp4xYyocWBlmcKSaR0VET0nt9PdcYnMEOcG5DZaSU9LxoBaIyIbXen21kTS
         6Vy+3VejYhVWiyxxo8nY06ksimQBzq5JqKdsod9YpQN3owZD+h/zxBO7BaQ49KUxJDwj
         tllQ==
X-Gm-Message-State: AOAM5320MW8vc/SQI9AmMzdVAdCoxwtrWabeIOdtEuYOaUbiwh5wl5L1
        lg5WviK1sroBUbCi3ZUrRb8=
X-Google-Smtp-Source: ABdhPJyGqSffGsZFJDGrDn3KqsqRCzOcL06mteak7JuI29vF5rSMC4E5qbGf7iNfi2DzfxhpUbsiiQ==
X-Received: by 2002:a05:6808:191d:b0:32e:8e4e:abbd with SMTP id bf29-20020a056808191d00b0032e8e4eabbdmr3693486oib.263.1654526366256;
        Mon, 06 Jun 2022 07:39:26 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id q28-20020a05683022dc00b0060c00c3fde5sm658335otc.72.2022.06.06.07.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:39:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        frank.zago@hpe.com, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 3/5] RDMA/rxe: Move atomic responder res to atomic_reply
Date:   Mon,  6 Jun 2022 09:38:35 -0500
Message-Id: <20220606143836.3323-4-rpearsonhpe@gmail.com>
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

Move the allocation of the atomic responder resource up into
rxe_atomic_reply() from send_atomic_ack(). In preparation for
merging the normal and retry atomic responder flows.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 49 +++++++++++++++++-----------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 4babd6fbfefe..4908b9fc0204 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -554,12 +554,36 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 /* Guarantee atomicity of atomic operations at the machine level. */
 static DEFINE_SPINLOCK(atomic_ops_lock);
 
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
+	res->replay = 0;
+
+	return res;
+}
+
 static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
 					 struct rxe_pkt_info *pkt)
 {
 	u64 *vaddr;
 	enum resp_states ret;
 	struct rxe_mr *mr = qp->resp.mr;
+	struct resp_res *res = qp->resp.res;
+
+	if (!res) {
+		res = rxe_prepare_atomic_res(qp, pkt);
+		qp->resp.res = res;
+	}
 
 	if (mr->state != RXE_MR_STATE_VALID) {
 		ret = RESPST_ERR_RKEY_VIOLATION;
@@ -1028,30 +1052,13 @@ static int send_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	return err;
 }
 
-static struct resp_res *rxe_prepare_atomic_res(struct rxe_qp *qp,
-					       struct rxe_pkt_info *pkt)
-{
-	struct resp_res *res;
-
-	res = &qp->resp.resources[qp->resp.res_head];
-	rxe_advance_resp_resource(qp);
-	free_rd_atomic_resource(qp, res);
-
-	res->type = RXE_ATOMIC_MASK;
-	res->first_psn = pkt->psn;
-	res->last_psn = pkt->psn;
-	res->cur_psn = pkt->psn;
-
-	return res;
-}
-
 static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 			   u8 syndrome)
 {
 	int err = 0;
 	struct rxe_pkt_info ack_pkt;
 	struct sk_buff *skb;
-	struct resp_res *res;
+	struct resp_res *res = qp->resp.res;
 
 	skb = prepare_ack_packet(qp, pkt, &ack_pkt,
 				 IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE, 0, pkt->psn,
@@ -1063,7 +1070,6 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 
 	skb_get(skb);
 
-	res = rxe_prepare_atomic_res(qp, pkt);
 	res->atomic.skb = skb;
 
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
@@ -1071,6 +1077,11 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		pr_err_ratelimited("Failed sending ack\n");
 		rxe_put(qp);
 	}
+
+	/* have to clear this since it is used to trigger
+	 * long read replies
+	 */
+	qp->resp.res = NULL;
 out:
 	return err;
 }
-- 
2.34.1

