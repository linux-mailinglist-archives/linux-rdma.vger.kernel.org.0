Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC5B307D05
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 18:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhA1Rv1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 12:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhA1Rtv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 12:49:51 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803A3C061756
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jan 2021 09:49:11 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id d7so5981699otf.3
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jan 2021 09:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8d1mzIpzL6K+rfjHo0enK4ISuTduKFodUbeLIs3hAk=;
        b=QWaBlqKw9LZ5lh4hyKzSN1lpMjybmSZf5VxUUc4IG1a2jENq9P0mHwgDthaKHgXq4y
         t34HbO8OwXqG+2jLNizQIbbKkYkEYd9/ZV4Aa3mFQ7+nuQU5tid5L5L/BMtsiifecTh9
         vJXqfXKFp19gkL9/Aau3yoiR+JInL5D1RU+eKxkiD+553BQPG9UhrsAXGLY4n1dwBJ6B
         7Gxex/0aVu8oDyB5IEQoQ+xh3Y9Z/QBWJ/2xKi3WJO2SaR/Hu7lC3+Mt2+/nn7Wm5pO5
         /gXntaWxjSX3w7U1I6dEMJWNdcBetACKQ92mZPaL1txCynqATf5CgJ76DA3QMe8CiFMZ
         vgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8d1mzIpzL6K+rfjHo0enK4ISuTduKFodUbeLIs3hAk=;
        b=nlb06dE1v9yfaoBAE5tS1NfOqYiQ9FB/o4zosdfkwzlRuRVmQXj19OcDUj4bZGlXxo
         Jwyoczw6yYuI4frHgOeAi5za5j7UUjMiA9uNgPGCZMCfuBCNMpxhHr+I/6hpg5uLQo6z
         XmOi9jkSyjdrIK83YU//QUhdRwuywlrT+4xHOktoKoBzv9K5Cr2bFYZiqA/XFe+05AgF
         lAf155BYZ5MQyYqtxPuoYyFaUD+t5HiFAvyAfGtneJYAltuf6+cvf/YoyErOFFLCtmEx
         N17539NBhTyiiJw8aa9zR8I5YXfoo2ToPscuRSHYWD1TA2G5VEzhFhk/W+0MRPQCvZa1
         QVYw==
X-Gm-Message-State: AOAM531tc6eHXijFbE+MOcD/z7mb+AoeSLAbbK1ZJqbKxXki5HDqsG9m
        byqUyfZ8HZoucjbHS6VxPWE=
X-Google-Smtp-Source: ABdhPJyA9pi/ArUrM3nCuOhHcEpFL/mZM28n4SpXhDpXGnuj4ezqhDtEK8WQshlqtGw2KO2SRvd79A==
X-Received: by 2002:a05:6830:1182:: with SMTP id u2mr399018otq.258.1611856149955;
        Thu, 28 Jan 2021 09:49:09 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ed32-ab84-718a-cacc.res6.spectrum.com. [2603:8081:140c:1a00:ed32:ab84:718a:cacc])
        by smtp.gmail.com with ESMTPSA id e14sm1179914oou.19.2021.01.28.09.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 09:49:09 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2] RDMA/rxe: Fix coding error in rxe_rcv_mcast_pkt
Date:   Thu, 28 Jan 2021 11:47:53 -0600
Message-Id: <20210128174752.16128-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[2]
Replaced unnecessary if(skb) by a comment.

[1]
rxe_rcv_mcast_pkt() in rxe_recv.c can leak SKBs in error path
code. The loop over the QPs attached to a multicast group
creates new cloned SKBs for all but the last QP in the list
and passes the SKB and its clones to rxe_rcv_pkt() for further
processing. Any QPs that do not pass some checks are skipped.
If the last QP in the list fails the tests the SKB is leaked.
This patch checks if the SKB for the last QP was used and if
not frees it. Also removes a redundant loop invariant assignment.

Fixes: 8700e3e7c4857 ("Soft RoCE driver")
Fixes: 71abf20b28ff8 ("RDMA/rxe: Handle skb_clone() failure in rxe_recv.c")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index c9984a28eecc..9293899ae76d 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -252,7 +252,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 	list_for_each_entry(mce, &mcg->qp_list, qp_list) {
 		qp = mce->qp;
-		pkt = SKB_TO_PKT(skb);
 
 		/* validate qp for incoming packet */
 		err = check_type_state(rxe, pkt, qp);
@@ -264,12 +263,18 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 			continue;
 
 		/* for all but the last qp create a new clone of the
-		 * skb and pass to the qp.
+		 * skb and pass to the qp. If an error occurs in the
+		 * checks for the last qp in the list we need to
+		 * free the skb since it hasn't been passed on to
+		 * rxe_rcv_pkt() which would free it later.
 		 */
-		if (mce->qp_list.next != &mcg->qp_list)
+		if (mce->qp_list.next != &mcg->qp_list) {
 			per_qp_skb = skb_clone(skb, GFP_ATOMIC);
-		else
+		} else {
 			per_qp_skb = skb;
+			/* show we have consumed the skb */
+			skb = NULL;
+		}
 
 		if (unlikely(!per_qp_skb))
 			continue;
@@ -284,9 +289,8 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 	rxe_drop_ref(mcg);	/* drop ref from rxe_pool_get_key. */
 
-	return;
-
 err1:
+	/* free skb if not consumed */
 	kfree_skb(skb);
 }
 
-- 
2.27.0

