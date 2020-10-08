Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3F6287D46
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 22:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJHUh5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 16:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgJHUh4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 16:37:56 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD7BC0613D2
        for <linux-rdma@vger.kernel.org>; Thu,  8 Oct 2020 13:37:56 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id z1so1823922ooj.3
        for <linux-rdma@vger.kernel.org>; Thu, 08 Oct 2020 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSX2C5rkfFjNBRm7zCNVoeHLBr0xOlkYd6sS3YABcCg=;
        b=St+6YBpWyyBZXaeONZqWnn4Uo1m8U3CQOgeyHYk7h17/qNdJem/pxBpWoi6rYomb3U
         JLNmxESJ8PF6XNDIAB5PB8T1jyAS/lkWmtRMVBuC5vlq1ZG2JjY8B8pEBvwHbezmSYHj
         1UFouENtbM7xxNZCWPmTlA99dHceYsWH5oKdWnLhHuXu/23/Z8Ip1RBagQz0rwbpoBSv
         yOTOSpujnbN4fDq4K76eok6sdC14j07gyBZRB/QRu655y/7vKK3eX0gsArbBmLHN5lEI
         YCWgeSlitDGAekfVson+tSI4mF4RteGgDzpbBxYRGub2vkBuU6t1YruWrpDk7yV6vKu3
         Ti0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSX2C5rkfFjNBRm7zCNVoeHLBr0xOlkYd6sS3YABcCg=;
        b=o/+6LCRaNFwHnYhbkYq4EqbGEv9QquV7WPCO8eqyW19NmektYyeOlUuI6XnHDqRCmG
         3p/C7s7KgmzRDvtCiQ4htncKepCNBxNLTN3o1OpzhHTQN9bl/Opi1hJ4R9NGCA1S1FLO
         Hal8xtscloS7o0UPo03M8PX1sBZcHHzaUohmBjdXW6ESf3r6iDMtazFW8sD6V9odrHlY
         Flk7qlOSe8eYzXNZS83mKkFAhgSmDZGqJPDXKuOUEk3roLpstdn+lPvl8/2OeVNedpDc
         AuItlz8poAAVY6XGSWKdRs7gCalrUHcQ9m2r7+gS8KlX/HJbOKni8g+cILtExcCEPavv
         8UwQ==
X-Gm-Message-State: AOAM531F9CuhyBnGXttNGROK/ytWq7D1bLg20iLhNqf8Tvm3ZibgbZS1
        zFk4Ggmn8jejRsbT+srRqvc=
X-Google-Smtp-Source: ABdhPJycDXrGTffpU7i9XiNB7PnlJrTR8Pbv32jGUkgbXp8CUedk+tu4oGLAAeM0AdzDDv3efRkM0Q==
X-Received: by 2002:a4a:a844:: with SMTP id p4mr6752670oom.59.1602189475711;
        Thu, 08 Oct 2020 13:37:55 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b5fa:2b2f:81e9:e2a0])
        by smtp.gmail.com with ESMTPSA id 22sm2521851oie.54.2020.10.08.13.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:37:55 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] rdma_rxe: fixed bug in rxe_rcv_mcast_pkt
Date:   Thu,  8 Oct 2020 15:36:52 -0500
Message-Id: <20201008203651.256958-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  - The changes referenced below replaced sbk_clone by
    taking additional references, passing the skb along and
    then freeing the skb. This deleted the packets before
    they could be processed and additionally passed bad data
    in each packet. Since pkt is stored in skb->cb
    changing pkt->qp changed it for all the packets.
  - Replace skb_get by sbk_clone in rxe_rcv_mcast_pkt for
    cases where multiple QPs are receiving multicast packets
    on the same address.
  - Delete kfree_skb because the packets need to live until
    they have been processed by each QP. They are freed later.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
Fixes: 86af61764151 ("IB/rxe: remove unnecessary skb_clone")
Fixes: fe896ceb5772 ("IB/rxe: replace refcount_inc with skb_get")
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index a9be4efba5f3..6b78e2ff6709 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -233,6 +233,8 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	struct rxe_mc_elem *mce;
 	struct rxe_qp *qp;
 	union ib_gid dgid;
+	struct sk_buff *per_qp_skb;
+	struct rxe_pkt_info *per_qp_pkt;
 	int err;
 
 	if (skb->protocol == htons(ETH_P_IP))
@@ -261,21 +263,26 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		if (err)
 			continue;
 
-		/* if *not* the last qp in the list
-		 * increase the users of the skb then post to the next qp
+		/* for all but the last qp create a new clone of the
+		 * skb and pass to the qp.
 		 */
 		if (mce->qp_list.next != &mcg->qp_list)
-			skb_get(skb);
+			per_qp_skb = skb_clone(skb, GFP_ATOMIC);
+		else
+			per_qp_skb = skb;
 
-		pkt->qp = qp;
+		per_qp_pkt = SKB_TO_PKT(per_qp_skb);
+		per_qp_pkt->qp = qp;
 		rxe_add_ref(qp);
-		rxe_rcv_pkt(pkt, skb);
+		rxe_rcv_pkt(per_qp_pkt, per_qp_skb);
 	}
 
 	spin_unlock_bh(&mcg->mcg_lock);
 
 	rxe_drop_ref(mcg);	/* drop ref from rxe_pool_get_key. */
 
+	return;
+
 err1:
 	kfree_skb(skb);
 }
-- 
2.25.1

