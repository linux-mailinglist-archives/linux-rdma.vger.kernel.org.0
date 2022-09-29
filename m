Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9075EFBA9
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 19:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiI2RJd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 13:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiI2RJY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 13:09:24 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D459D1D35B9
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:19 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id c13-20020a4ac30d000000b0047663e3e16bso530695ooq.6
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Qv+MFCfjBy9qlntNACjCRozVQRuJY60ehMS3GyMG2/8=;
        b=iId2GNFMoFbEXeTMLCCrNzjn9/D3ZCak0EOmV0Zfs4UmGyMrOBhLJ0AFb9zEoSY0U4
         b2C/6qFS/YSf3wtlvr3MlOpw+oP0Ug7o0oTkHZOve2VAdRo9hrPd2kO+pTJzlFZHtLO/
         zKT4iuRs+96BqtLc5s37mxGrRDP4CLQlUTsJQpT6x80+rMMnUvXSJiNtmpYoWEBYjIct
         x3Naw09m94slRlVw174ZAFL+7kjg5QBjJQbmrQYcSKwvzUXoKAkCee4EP9VJngNL4J97
         n7wqoPrXtZ5nQ3OkdI4GH8/6NmRNxxUwH7hv3FUv+mAE9U2RrB2Ajdmo+vArB4Ct2g/k
         CwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Qv+MFCfjBy9qlntNACjCRozVQRuJY60ehMS3GyMG2/8=;
        b=03WFyrxHgbYyKP89NxovtV/MC1lwCwA/cljNRnhguirPMTKHOK6NmGCH/StRduZy8K
         JdcOJ0aY7LAyplLQ9aTKqIsx8aEIH24YLuxt27NcXKpNjtZRVz4Ktcxdm7CAUdec3N/P
         7vEQ9JdDZ0m7NDJ5PgQYO7QplatNqFEwvDcaSYuskqzXNp6EauWRj03RBWeFQ3AhCYwP
         jwMCG9J2ZJ10IkD+k3cxO8t+0eZ5c6YxfbTgiCUSw5f+Tx2VefLorSy3b4ioN1/lWpO9
         A7qj/HtK4cFZ3J2+tH9tYNf3P46AzjwSJ6HmYC2nPYbfqL6IpATe/08joMzPpJLLvTnB
         6uVg==
X-Gm-Message-State: ACrzQf04maWRpywydPUaIJbxFSmgXgYQBlu2+0mp9NDFNk66fzoLIS5R
        q5593SguQ26cXfIWi7ga/ik=
X-Google-Smtp-Source: AMsMyM4CIS8CwHTO9FOwzUg21bLCmDwW4EniDDGbC5V2FTwDEv250pAEKprWmmzpa//gsC/YUKWhjw==
X-Received: by 2002:a05:6830:440b:b0:65a:127d:89a9 with SMTP id q11-20020a056830440b00b0065a127d89a9mr1728084otv.103.1664471358417;
        Thu, 29 Sep 2022 10:09:18 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-c4e7-bfae-90ed-ac81.res6.spectrum.com. [2603:8081:140c:1a00:c4e7:bfae:90ed:ac81])
        by smtp.googlemail.com with ESMTPSA id v17-20020a056808005100b00349a06c581fsm2798557oic.3.2022.09.29.10.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:09:18 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 12/13] RDMA/rxe: Extend rxe_net.c to support xrc qps
Date:   Thu, 29 Sep 2022 12:08:36 -0500
Message-Id: <20220929170836.17838-13-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929170836.17838-1-rpearsonhpe@gmail.com>
References: <20220929170836.17838-1-rpearsonhpe@gmail.com>
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

Extend code in rxe_net.c to support xrc qp types.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index d46190ad082f..d9bedd6fc497 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -92,7 +92,7 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 {
 	struct dst_entry *dst = NULL;
 
-	if (qp_type(qp) == IB_QPT_RC)
+	if (qp_type(qp) == IB_QPT_RC || qp_type(qp) == IB_QPT_XRC_INI)
 		dst = sk_dst_get(qp->sk->sk);
 
 	if (!dst || !dst_check(dst, qp->dst_cookie)) {
@@ -120,7 +120,8 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 #endif
 		}
 
-		if (dst && (qp_type(qp) == IB_QPT_RC)) {
+		if (dst && (qp_type(qp) == IB_QPT_RC ||
+			    qp_type(qp) == IB_QPT_XRC_INI)) {
 			dst_hold(dst);
 			sk_dst_set(qp->sk->sk, dst);
 		}
@@ -386,14 +387,23 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
  */
 static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
-	memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
+	struct rxe_pkt_info *new_pkt = SKB_TO_PKT(skb);
+
+	memset(new_pkt, 0, sizeof(*new_pkt));
+
+	/* match rxe_udp_encap_recv */
+	new_pkt->rxe = pkt->rxe;
+	new_pkt->port_num = 1;
+	new_pkt->hdr = pkt->hdr;
+	new_pkt->mask = RXE_GRH_MASK;
+	new_pkt->paylen = pkt->paylen;
 
 	if (skb->protocol == htons(ETH_P_IP))
 		skb_pull(skb, sizeof(struct iphdr));
 	else
 		skb_pull(skb, sizeof(struct ipv6hdr));
 
-	if (WARN_ON(!ib_device_try_get(&pkt->rxe->ib_dev))) {
+	if (WARN_ON(!ib_device_try_get(&new_pkt->rxe->ib_dev))) {
 		kfree_skb(skb);
 		return -EIO;
 	}
@@ -412,7 +422,6 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 
 	if ((is_request && (qp->req.state != QP_STATE_READY)) ||
 	    (!is_request && (qp->resp.state != QP_STATE_READY))) {
-		pr_info("Packet dropped. QP is not in ready state\n");
 		goto drop;
 	}
 
@@ -427,8 +436,8 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		return err;
 	}
 
-	if ((qp_type(qp) != IB_QPT_RC) &&
-	    (pkt->mask & RXE_LAST_MASK)) {
+	if ((pkt->mask & RXE_REQ_MASK) && (pkt->mask & RXE_LAST_MASK) &&
+	    (qp_type(qp) != IB_QPT_RC && qp_type(qp) != IB_QPT_XRC_INI)) {
 		pkt->wqe->state = wqe_state_done;
 		rxe_run_task(&qp->comp.task, 1);
 	}
-- 
2.34.1

