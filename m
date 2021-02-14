Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4731631B307
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Feb 2021 23:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBNW2P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Feb 2021 17:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhBNW2O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 14 Feb 2021 17:28:14 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABC0C061574
        for <linux-rdma@vger.kernel.org>; Sun, 14 Feb 2021 14:27:34 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id i20so4507149otl.7
        for <linux-rdma@vger.kernel.org>; Sun, 14 Feb 2021 14:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4SbFBSr/zEbLOAgmChoe+GwwItC/2ru7fpWJwiItJ4I=;
        b=Vdznb32Rt5Kkr1XjEEpWboeisd4x0LE1Vaib/+G1BzQYzIhL6aSx0nZ7ZoTT0aLqvL
         Pc6leKP5/irPjeM2wyO5fzoi9SAtzUmzJNkzNDPSEo1dblv/ARAjN/fZaFkJSkiul4Bw
         SE3Whgj1o+yXm40BrJdAWPyIpc9lBOrndEXIxogQ6MGHg8Z0guWho2nk6xAm9HGspaDK
         4CnaD5Uu4BSj29YmSF4fkb5z2mTMDlbvY16sSAW7J4gUT5+u4k0gaUSw1aWBGFwpKW/j
         cXzWeX9rM0Jpsxejt43U23JbQvA9bZC+1izC482Dqz4cAU+vxjKr1uigS/pWI0I38Ah1
         ch5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4SbFBSr/zEbLOAgmChoe+GwwItC/2ru7fpWJwiItJ4I=;
        b=K6xSobFGblu8bUvcek7hQyJPAb1yNiY01VSUqg2SqDON1Qs4eoq07It6k1KL9wdi7f
         ARuRIkGl6mCAoI2+RWQpv9ntDUKsjaC6RC+hJBXtXQz0ONHbx9ZZsZHa30xKJ8hx3/ji
         Es5wOEf0hk9S3rir9HK1ik3I5xI3CUnF5bih11T7gQ1rcXWXgJqfTpighmQ3b95/Qh28
         Eea+9M84vuHyGAMD0qIkKXkXoJj1/J4M5FEaXaf4px7pAw1DUvhrfX0hpcP+W1PAohVH
         YwrMo5WkqpVpJRTCSODVE8b5lEnlTpg8csL6gR9z34c1RgukcipCRhdHHlSM8RKVnhIM
         hsVQ==
X-Gm-Message-State: AOAM533wUUOkI1tEwFdeSJJEiIGk4yJ8qiDTU0fm35iGsV0x9Pve6SMJ
        plOfdt6OaApB1VsTfohZnug=
X-Google-Smtp-Source: ABdhPJw8sdZbgG9k9qcM/NypuwOkXIIN8ZNnUypOx9eYpR1PO4Y6HSCf8njCcmTAuawrFQCFIDi84w==
X-Received: by 2002:a9d:e82:: with SMTP id 2mr9420860otj.287.1613341654178;
        Sun, 14 Feb 2021 14:27:34 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-f909-9adf-44e9-3c13.res6.spectrum.com. [2603:8081:140c:1a00:f909:9adf:44e9:3c13])
        by smtp.gmail.com with ESMTPSA id z8sm2896098oon.10.2021.02.14.14.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 14:27:33 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting (again)
Date:   Sun, 14 Feb 2021 16:26:31 -0600
Message-Id: <20210214222630.3901-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Three errors occurred in the fix referenced below.

1) The on and off again 'if (skb)' got dropped but was really
needed in rxe_rcv_mcast_pkt() to prevent calling ib_device_put()
on the non-error path.

2) Extending the reference taken by rxe_get_dev_from_net() in
rxe_udp_encap_recv() until each skb is freed was not matched by
a reference in the loopback path resulting in underflows.

3) In rxe_comp.c the function free_pkt() did not clear skb which
triggered a warning at done: and could possibly at exit: in
rxe_completer(). The WARN_ONCE() calls are not required at done:
and only in one place before going to exit.

This patch fixes these errors.

Fixes: 899aba891cab ("RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 5 +++--
 drivers/infiniband/sw/rxe/rxe_net.c  | 7 ++++++-
 drivers/infiniband/sw/rxe/rxe_recv.c | 6 ++++--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index a8ac791a1bb9..13fc5a1cced1 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -671,6 +671,9 @@ int rxe_completer(void *arg)
 			 * it down the road or let it expire
 			 */
 
+			/* warn if we did receive a packet */
+			WARN_ON_ONCE(skb);
+
 			/* there is nothing to retry in this case */
 			if (!wqe || (wqe->state == wqe_state_posted))
 				goto exit;
@@ -750,7 +753,6 @@ int rxe_completer(void *arg)
 	/* we come here if we are done with processing and want the task to
 	 * exit from the loop calling us
 	 */
-	WARN_ON_ONCE(skb);
 	rxe_drop_ref(qp);
 	return -EAGAIN;
 
@@ -758,7 +760,6 @@ int rxe_completer(void *arg)
 	/* we come here if we have processed a packet we want the task to call
 	 * us again to see if there is anything else to do
 	 */
-	WARN_ON_ONCE(skb);
 	rxe_drop_ref(qp);
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 36d56163afac..8e81df578552 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -406,12 +406,17 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 
 void rxe_loopback(struct sk_buff *skb)
 {
+	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+
 	if (skb->protocol == htons(ETH_P_IP))
 		skb_pull(skb, sizeof(struct iphdr));
 	else
 		skb_pull(skb, sizeof(struct ipv6hdr));
 
-	rxe_rcv(skb);
+	if (WARN_ON(!ib_device_try_get(&pkt->rxe->ib_dev)))
+		kfree_skb(skb);
+	else
+		rxe_rcv(skb);
 }
 
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 8a48a33d587b..a5e330e3bbce 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -299,8 +299,10 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 err1:
 	/* free skb if not consumed */
-	kfree_skb(skb);
-	ib_device_put(&rxe->ib_dev);
+	if (unlikely(skb)) {
+		kfree_skb(skb);
+		ib_device_put(&rxe->ib_dev);
+	}
 }
 
 /**
-- 
2.27.0

