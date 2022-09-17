Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5C35BB5D7
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIQDNB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiIQDM1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:12:27 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0674BD14B
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:12:25 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id j188so5967308oih.0
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Qv+MFCfjBy9qlntNACjCRozVQRuJY60ehMS3GyMG2/8=;
        b=TkyA6wF2FaU4uxesiWz4zwavg7rsv+phGbvY+EP4WtF9b8yydMxk0K7+uMgiv5F0YQ
         3otSrB4NruGrz1mTN2kBKAxBvOBr4tstHLM4UTNBVZ1V+gYnNwcXXsnmAcwz57rl309p
         XC9Uok/BddAWe3OK2XToj5qmBlVvHloFJ993ZYweKcCK7UE4GqFm8t877KI8HsOhE9UO
         eQwO5dhj9cxcsqQtElJjD+gpO+oSwbj4aBVNERutOplbgO3iRqqqSneBb5oFiO7mjrKe
         0E2jDV0JWeHHogFLtKY9KhJAP73zotCfC8swOFMnWsG8fx0hcq3ucJol0UF3n93qefQq
         HJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Qv+MFCfjBy9qlntNACjCRozVQRuJY60ehMS3GyMG2/8=;
        b=Bd3IZQf8CBhbwvcMJPLWgxBeP97iJfC77ClEu08LjvZU+UlawGoUxVRvcEg8EtzX3Y
         7x/ScNQd5CA3JiJ84KIakBUPebGqD6xid3sHN6ffNJjMw5kTl3h6I1jJGH5n4v/hliDB
         Qr5pKyK+Pwfw5IRIZ0RpjCv70tDM4duCpYLikW6HcuiVKFooVPvB2TPcF2OxDZxR+/Xj
         rENAKy43Qn47cEORFLYPJogFTMbXjHqRCDIR8ArwJZwTb5kDrKZrjs4guqkXiJq/vPMD
         /u6fY4Nj8H+QvZ2y0wNBob69RQKulaNUpRfnU0IPtUizO0X0z1bKOJVhAu2YiiVd9CBN
         A47w==
X-Gm-Message-State: ACgBeo3H0gUxPh1UjAQJhn8Ph+lKVJioJMkj9ZnDgrzcrJge2ssA+2Wt
        pq8D0t3EE5DbwNHJmZN43aY=
X-Google-Smtp-Source: AA6agR6ioGQkgMzOqEayJkr8YuwFwOL/xE4H/Yy6lfOqPby2RuomhzL8jAAYxZ4xfI7hmRY74smbOQ==
X-Received: by 2002:aca:f2c1:0:b0:34f:bb9b:cdba with SMTP id q184-20020acaf2c1000000b0034fbb9bcdbamr8339294oih.249.1663384345007;
        Fri, 16 Sep 2022 20:12:25 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id a18-20020a05683012d200b00636ed80eab8sm11100865otq.4.2022.09.16.20.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:12:24 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 12/13] RDMA/rxe: Extend rxe_net.c to support xrc qps
Date:   Fri, 16 Sep 2022 22:12:21 -0500
Message-Id: <20220917031221.21293-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

