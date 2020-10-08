Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D6E287DF2
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 23:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgJHV16 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 17:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgJHV15 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 17:27:57 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCB7C0613D2
        for <linux-rdma@vger.kernel.org>; Thu,  8 Oct 2020 14:27:57 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t15so7061214otk.0
        for <linux-rdma@vger.kernel.org>; Thu, 08 Oct 2020 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+/WLYri+4BUVz22/S0+OLIDW1H39RADYVikoz/dvUo=;
        b=RwvZSX0wvnkNtRYTszzV39kQ2Z7HMQlB4p0wvgNwGD3ANkBOfPs8lo6tKTt30+ABjn
         +u4MiuSIQ/xbKOlyotK3CPkcbkHJQK02ZICX8aW+7VC0UIUio4IhD4QQ0wTcUn7yfSBt
         hj6zQMhfgDQYuclpxXkTZfiGMcc7I+W5ASh2NQ7hWTlegsIPEL22Mfyh5qTv2WCECnAx
         fs7VPnnrNGFyu/4RmiXA+V7+03a85g0Isw2E+tq41ubdQn7C9APwJjAD1m8II8kVzKO2
         3dM+VS+XNLQaFQBMnkmVlvTwGUQJwx1dqoFgpmW+6HFYmcz85oKkynBZkcgvjaivDJd6
         zzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+/WLYri+4BUVz22/S0+OLIDW1H39RADYVikoz/dvUo=;
        b=PncnLEjQDXqXGuSGjxKrp8bYPpBtZEuKErJaRvvKq/GIxFKbBC2WszcahwxAO+aRsO
         wrq+FDhFJDtx2GHzi5nQ0Kc8/1rX/iR4g+VWwz6w0Aw8xRKb6mVN+b8PC3FYSJe/xOJg
         d79jgQx9PyojoXMF61cJ4v/hF6kYXJSJlhTiBUQZn6zI4lknR054bn64cjrxQxzZCk10
         cSAVSR/G/G6TE76JZGVs0c+R/BuAYOe2BJREn0+RJLUfXN+6A+hX24j0mBUJSPEnCFA0
         fw33TMJiWVldII7q8bRY5YHkcTITZlQ2SpBQ+x61NPxWnM7111WbQnEnWr5IIy22nRlu
         Pbbw==
X-Gm-Message-State: AOAM530XOTly9HkRamOo3liZCgw41cxVlP9QY5jit0XduO9rY5kSWiBJ
        hF02oU6KwTZDgDlPYvJ3sC+0B0DP0VA=
X-Google-Smtp-Source: ABdhPJylmP9H89z/+KrKAom/3P3Top3LWEZqVhAvWSkRpYsueaw+XGJ2x8yns4hGRj4OGgjrz+Xn2g==
X-Received: by 2002:a05:6830:1aca:: with SMTP id r10mr6338017otc.336.1602192477114;
        Thu, 08 Oct 2020 14:27:57 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b5fa:2b2f:81e9:e2a0])
        by smtp.gmail.com with ESMTPSA id j83sm5801132oia.19.2020.10.08.14.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 14:27:56 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2] rdma_rxe: fix bug rejecting multicast packets
Date:   Thu,  8 Oct 2020 16:27:53 -0500
Message-Id: <20201008212753.265249-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  - Fix a bug in rxe_rcv that causes all multicast packets to be
    dropped. Currently rxe_match_dgid is called for each packet
    to verify that the destination IP address matches one of the
    entries in the port source GID table. This is incorrect for
    IP multicast addresses since they do not appear in the GID table.
  - Add code to detect multicast addresses.
  - Change function name to rxe_chk_dgid which is clearer.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index a3eed4da1540..b6fee61b2aee 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -280,7 +280,17 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
-static int rxe_match_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
+/**
+ * rxe_chk_dgid - validate destination IP address
+ * @rxe: rxe device that received packet
+ * @skb: the received packet buffer
+ *
+ * Accept any loopback packets
+ * Extract IP address from packet and
+ * Accept if multicast packet
+ * Accept if matches an SGID table entry
+ */
+static int rxe_chk_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
 {
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
 	const struct ib_gid_attr *gid_attr;
@@ -298,6 +308,9 @@ static int rxe_match_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
 		pdgid = (union ib_gid *)&ipv6_hdr(skb)->daddr;
 	}
 
+	if (rdma_is_multicast_addr((struct in6_addr *)pdgid))
+		return 0;
+
 	gid_attr = rdma_find_gid_by_port(&rxe->ib_dev, pdgid,
 					 IB_GID_TYPE_ROCE_UDP_ENCAP,
 					 1, skb->dev);
@@ -322,8 +335,8 @@ void rxe_rcv(struct sk_buff *skb)
 	if (unlikely(skb->len < pkt->offset + RXE_BTH_BYTES))
 		goto drop;
 
-	if (rxe_match_dgid(rxe, skb) < 0) {
-		pr_warn_ratelimited("failed matching dgid\n");
+	if (rxe_chk_dgid(rxe, skb) < 0) {
+		pr_warn_ratelimited("failed checking dgid\n");
 		goto drop;
 	}
 
-- 
2.25.1

