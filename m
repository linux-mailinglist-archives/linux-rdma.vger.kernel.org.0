Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143DD615326
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 21:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiKAUXx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 16:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiKAUXw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 16:23:52 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0840317052
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 13:23:50 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-13c2cfd1126so18082358fac.10
        for <linux-rdma@vger.kernel.org>; Tue, 01 Nov 2022 13:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jjp9wYlavuPz4LHH71+rdE2DpYiSE2m/SsqEKdhE490=;
        b=YgGdMzGR5AzNE+8BHfaDe8VS6iKFqCPogKRW0srAI5cPAAmlrXLyu5/Zbjj7yFPv8h
         3mTe9vHm9Q15EJYBspaCdholCZ6CDq6Q2F+PO3NVhEWjQxTvwye4HItMEfEZE1i7A04p
         7crCNlCnm8NnPKDazqlFrlhxW4+/XL7FQY4WFqGLZO1+PhgyXtcyr57v3gDv46XAt/om
         PkSf5YFyNUC1w10E0NtACBE3gen6xGVzqFh7Wz8M4QOlRCXGTKIrnmeGXz8eumwkLB2V
         0pO3TYvmJU7BWEf8Rhc1gue5+7QREgcEKZaT7o/aNruQBQx8Bji+iVXHYnyl0mjHkxH6
         Fu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jjp9wYlavuPz4LHH71+rdE2DpYiSE2m/SsqEKdhE490=;
        b=SZ7MBseqAFo5ID1k4Hq6cE9xaxF92J/orALiURI2o+p6ajZGvi+08PG/OCCn705QrW
         NdQG4awyOwZeyLLYhClL9oR8q6lv0f/1hRO55dpj6mQijFCF0Xnn9CfiCZVqtcIEru1x
         j0lI8UOrbioDlYQja0DCboTnUya158FoBJAzj29erEcfKI1a7zc00Vrt7ReCedwe8kwE
         HBvHdsS+bgwZIK3xkQOLy6vr56CrhARjT3075hP66Ira9JU2rEaw3/MRMa7QkSz2ZW8l
         A8O8TLKC9ZlCmGjfpK2MTOsIIh4lBjoxquzDeh40o67sjcsp+6EQGOgI8BnO45a7R9Yg
         UCcg==
X-Gm-Message-State: ACrzQf2J0felN9bhDQpMp/3XEKJgFIAPCy4rx+LaGqfJJQ4PYnVLUVd4
        Dzp2aVf3A9r/+mnL3tEaq9E=
X-Google-Smtp-Source: AMsMyM6qkUszLRMlE7LpULEBpv35GjqAN6Hhnj5Yddy8SeVlPm+JJMJ4nhkhuzfQVDlF/C4vThpC0g==
X-Received: by 2002:a05:6870:51a:b0:130:ae8d:daaf with SMTP id j26-20020a056870051a00b00130ae8ddaafmr20713783oao.103.1667334229052;
        Tue, 01 Nov 2022 13:23:49 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-e052-4710-92ba-8142.res6.spectrum.com. [2603:8081:140c:1a00:e052:4710:92ba:8142])
        by smtp.googlemail.com with ESMTPSA id d22-20020a056830045600b0066210467fb1sm4337493otc.41.2022.11.01.13.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:23:48 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 02/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_qp in rxe_comp.c
Date:   Tue,  1 Nov 2022 15:22:27 -0500
Message-Id: <20221101202238.32836-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101202238.32836-1-rpearsonhpe@gmail.com>
References: <20221101202238.32836-1-rpearsonhpe@gmail.com>
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

Replace calls to pr_err/warn() in rxe_comp.c with rxe_dbg_qp().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 66f392810c86..4dca4f8bbb5a 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -114,7 +114,7 @@ void retransmit_timer(struct timer_list *t)
 {
 	struct rxe_qp *qp = from_timer(qp, t, retrans_timer);
 
-	pr_debug("%s: fired for qp#%d\n", __func__, qp->elem.index);
+	rxe_dbg_qp(qp, "retransmit timer fired\n");
 
 	if (qp->valid) {
 		qp->comp.timeout = 1;
@@ -334,7 +334,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 				return COMPST_ERROR;
 
 			default:
-				pr_warn("unexpected nak %x\n", syn);
+				rxe_dbg_qp(qp, "unexpected nak %x\n", syn);
 				wqe->status = IB_WC_REM_OP_ERR;
 				return COMPST_ERROR;
 			}
@@ -345,7 +345,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 		break;
 
 	default:
-		pr_warn("unexpected opcode\n");
+		rxe_dbg_qp(qp, "unexpected opcode\n");
 	}
 
 	return COMPST_ERROR;
@@ -598,8 +598,7 @@ int rxe_completer(void *arg)
 	state = COMPST_GET_ACK;
 
 	while (1) {
-		pr_debug("qp#%d state = %s\n", qp_num(qp),
-			 comp_state_name[state]);
+		rxe_dbg_qp(qp, "state = %s\n", comp_state_name[state]);
 		switch (state) {
 		case COMPST_GET_ACK:
 			skb = skb_dequeue(&qp->resp_pkts);
@@ -746,8 +745,7 @@ int rxe_completer(void *arg)
 				 * rnr timer has fired
 				 */
 				qp->req.wait_for_rnr_timer = 1;
-				pr_debug("qp#%d set rnr nak timer\n",
-					 qp_num(qp));
+				rxe_dbg_qp(qp, "set rnr nak timer\n");
 				mod_timer(&qp->rnr_nak_timer,
 					  jiffies + rnrnak_jiffies(aeth_syn(pkt)
 						& ~AETH_TYPE_MASK));
-- 
2.34.1

