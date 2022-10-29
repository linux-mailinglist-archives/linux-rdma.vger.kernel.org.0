Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29870611FA0
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJ2DKu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJ2DKp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:10:45 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3188329CA4
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:20 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so1014720ooi.5
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxVc8Xs0oLXoDtXiq0E1glHusFjw0NUoNGpkz6t1r38=;
        b=bb1bZmn3KXcIPFKxL9i3CBl+a256ZqgrrrEn/Mmi78nIh8j0b/U4HiMzk6k4zDRdw9
         N7np7qid2oMCGGSMsjGrMebT9bPQ6POM/keXyvhvQn+7JXrb9QyXiL/0lkY7ZR+x5guM
         s7IvMyQ8J9dm5ooQCQOg44nSvMlix9zjMqbKH51z6RDBBb/Q9SH30QTnGErOgW+CkDxr
         nGhlj/0/kwQHQ5fZ+qwK7JnUAyiLwxBMhI1VgpAsbJ7bbnqn74HzzZMF+TWkleTbLUGK
         obHVwZ7sfRxvwMPdXPa45MB3/oa2FX7H/uef6hkfEjkLCPqNFm075uNe80V+yt8SVpPC
         prcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxVc8Xs0oLXoDtXiq0E1glHusFjw0NUoNGpkz6t1r38=;
        b=kJvFhgb9V6GZC0y69geUeGsZZUGlr1Z/VD7qnAAN1vvOmT/LH0XZ0Aa+buttk4EwZo
         KcNT+y0myXvrgw7r9u+obIHl8dnATQ3a4jAlcbwnMeNPjDwi5wwAhzeFHU0qdswX1tUk
         7S5xmNTzjpGp0KL2HqSr9sUSbOpv0Vsh1L78SqhGwGDQ/HdKkzZ5qmE5TxN21b3EcaTI
         lSTqdHLKEeOXRl55WUsaqR0owVMBgg9vaevdRMC9vr50Asrl15YKdSKCh+p92yCRcBgA
         bdaQCQw4DJJ+cTdkGHYmKNRcf1siGDPihZj0NmtrZn6Lqs/X4pVphF0KDU8z7ofmWXDh
         LkWQ==
X-Gm-Message-State: ACrzQf2Z6iE8XaABe43+VMTTlQUwGE6bJiWNkHOegGV4j1niiBJOTedn
        wx+Gb3m0MTGEWo30+fK+d/k=
X-Google-Smtp-Source: AMsMyM5KHNdHti1EdQkjfwfGRQBfKq2WyJ14kQCL3xqUwavkfTa5hGyzEXcOjjF6AfroLsWzjs2lJg==
X-Received: by 2002:a4a:8e81:0:b0:475:811f:3f9e with SMTP id p1-20020a4a8e81000000b00475811f3f9emr1082867ook.35.1667013020042;
        Fri, 28 Oct 2022 20:10:20 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-5d1e-45f3-e9b5-d771.res6.spectrum.com. [2603:8081:140c:1a00:5d1e:45f3:e9b5:d771])
        by smtp.googlemail.com with ESMTPSA id p3-20020a0568301d4300b006391adb6034sm162493oth.72.2022.10.28.20.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:10:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v3 02/13] RDMA/rxe: Split rxe_drain_resp_pkts()
Date:   Fri, 28 Oct 2022 22:09:59 -0500
Message-Id: <20221029031009.64467-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029031009.64467-1-rpearsonhpe@gmail.com>
References: <20221029031009.64467-1-rpearsonhpe@gmail.com>
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

Split rxe_drain_resp_pkts() into two subroutines which perform separate
functions.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 66f392810c86..76dc0a4702fd 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -532,17 +532,21 @@ static inline enum comp_state complete_wqe(struct rxe_qp *qp,
 	return COMPST_GET_WQE;
 }
 
-static void rxe_drain_resp_pkts(struct rxe_qp *qp, bool notify)
+static void rxe_drain_resp_pkts(struct rxe_qp *qp)
 {
 	struct sk_buff *skb;
-	struct rxe_send_wqe *wqe;
-	struct rxe_queue *q = qp->sq.queue;
 
 	while ((skb = skb_dequeue(&qp->resp_pkts))) {
 		rxe_put(qp);
 		kfree_skb(skb);
 		ib_device_put(qp->ibqp.device);
 	}
+}
+
+static void rxe_drain_send_queue(struct rxe_qp *qp, bool notify)
+{
+	struct rxe_send_wqe *wqe;
+	struct rxe_queue *q = qp->sq.queue;
 
 	while ((wqe = queue_head(q, q->type))) {
 		if (notify) {
@@ -573,6 +577,7 @@ int rxe_completer(void *arg)
 	struct sk_buff *skb = NULL;
 	struct rxe_pkt_info *pkt = NULL;
 	enum comp_state state;
+	bool notify;
 	int ret;
 
 	if (!rxe_get(qp))
@@ -580,8 +585,9 @@ int rxe_completer(void *arg)
 
 	if (!qp->valid || qp->comp.state == QP_STATE_ERROR ||
 	    qp->comp.state == QP_STATE_RESET) {
-		rxe_drain_resp_pkts(qp, qp->valid &&
-				    qp->comp.state == QP_STATE_ERROR);
+		notify = qp->valid && (qp->comp.state == QP_STATE_ERROR);
+		rxe_drain_resp_pkts(qp);
+		rxe_drain_send_queue(qp, notify);
 		goto exit;
 	}
 
-- 
2.34.1

