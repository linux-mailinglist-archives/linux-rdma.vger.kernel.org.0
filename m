Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C653B792F
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 22:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhF2UQ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 16:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbhF2UQz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 16:16:55 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01651C061766
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:14:27 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so128425otl.0
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/1OQ8iiUM5jBS3SROmYbJG4M9djpGPpNOKrJeUwIAuE=;
        b=GsiJ4e6OOU6bHOQKo3mv4V+ndF37jTgCGBz9Ek8wHmZ2VGsoe+L8Boap2l4q8j6Ym7
         zQqUCZt8sMVmg9o0tDN5KlyOxH6eOpZr62NYfjJhdP6QIAan6Gie3MTqDcgIsu/NipNK
         2NluIMBgtQXEiGlULA1zqITan0+tpzJp4hf6jF5tAMgffuz7cmTHIxS61i7aKTAnIXPF
         3CkCw71STGVNBsq6jZBSQCGGeVKCfskvvydhXx7yIuldvXQdfa877yrAb9vHPYS4IIaE
         do56y4W3J9Wh/WyOOpFs9kFvr0timTQ0QHnbEz+aN9NxybyeGj80Xschn9ALKjdqHaDM
         JHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/1OQ8iiUM5jBS3SROmYbJG4M9djpGPpNOKrJeUwIAuE=;
        b=C2gXDFsVFhTn+jC3hq88EN5kaYW3kNS4lcxsLpSjAEzxb6p3rOYfVDWVcED3EyEUyt
         RVBcSj794ryoITez3roOnejMRVj6igTwIhE7WHjuAZ35EicRwtBKcdN0+BaP5JOQjbZ3
         y+SMy/UIp0Z1dnXpHAL0aOvgCj/ORC6Ew1NNwMD8UzKNmMXvAOUYs14TiyY5mmc8Bs/5
         vWALvB/6Nl0gjD3c0US7Q6eJ2eGUjqeb2r8a7827DfbH3A6tttM/p6pNthCg64t3lspu
         d3goRvu3JUy9+tuDL47k3akPy9sOhIJRL5EQZXPLNCQXGJURQGccymv4d+8WDYPtLvns
         UdBg==
X-Gm-Message-State: AOAM532EkCRoLrdC4Fkiglmcf3pWjyuYiZ9IZdlrBXza2m+UaTOVNmoy
        LIr2RgeQWRLH0g5y6hVHci8=
X-Google-Smtp-Source: ABdhPJy5FWikh4fYDkl9kk9ge8cZKvvNBmmNTgySOb9ONR303LUOKxLjPIVTgXFHbqKxg8rmk5m+fQ==
X-Received: by 2002:a9d:baa:: with SMTP id 39mr5839469oth.159.1624997666434;
        Tue, 29 Jun 2021 13:14:26 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id e29sm4159499oiy.53.2021.06.29.13.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 13:14:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 6/7] RDMA/rxe: Add parameters to control checking/generating ICRC
Date:   Tue, 29 Jun 2021 15:14:11 -0500
Message-Id: <20210629201412.28306-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210629201412.28306-1-rpearsonhpe@gmail.com>
References: <20210629201412.28306-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add module parameters rxe_must_check_icrc and rxe_must_generat_icrc which
default to 1 and which suppresses checking/generating ICRC if set to 0.
The parameter is displayed in /sys as "check_icrc" or "generate_icrc".

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c      | 9 +++++++++
 drivers/infiniband/sw/rxe/rxe.h      | 4 ++++
 drivers/infiniband/sw/rxe/rxe_net.c  | 3 ++-
 drivers/infiniband/sw/rxe/rxe_recv.c | 8 +++++---
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 8e0f9c489cab..08de3ef9f1f2 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -15,6 +15,15 @@ MODULE_LICENSE("Dual BSD/GPL");
 
 bool rxe_initialized;
 
+/* If set to false these parameters disable checking and/or generating
+ * the packet ICRC
+ */
+bool rxe_must_check_icrc = true;
+module_param_named(check_icrc, rxe_must_check_icrc, bool, 0660);
+
+bool rxe_must_generate_icrc = true;
+module_param_named(generate_icrc, rxe_must_generate_icrc, bool, 0660);
+
 /* free resources for a rxe device all objects created for this device must
  * have been destroyed
  */
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 1bb3fb618bf5..a5083a924a6f 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -13,6 +13,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/skbuff.h>
 
 #include <rdma/ib_verbs.h>
@@ -39,6 +40,9 @@
 
 #define RXE_ROCE_V2_SPORT		(0xc000)
 
+extern bool rxe_must_check_icrc;
+extern bool rxe_must_generate_icrc;
+
 extern bool rxe_initialized;
 
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int dev_mtu);
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 3860281a3a90..4d109e5b33ff 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -434,7 +434,8 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		goto drop;
 	}
 
-	rxe_icrc_generate(skb, pkt);
+	if (rxe_must_generate_icrc)
+		rxe_icrc_generate(skb, pkt);
 
 	if (pkt->mask & RXE_LOOPBACK_MASK) {
 		memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 8582b3163e2c..01d425b3991e 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -382,9 +382,11 @@ void rxe_rcv(struct sk_buff *skb)
 	if (unlikely(err))
 		goto drop;
 
-	err = rxe_icrc_check(skb);
-	if (unlikely(err))
-		goto drop;
+	if (rxe_must_check_icrc) {
+		err = rxe_icrc_check(skb);
+		if (unlikely(err))
+			goto drop;
+	}
 
 	rxe_counter_inc(rxe, RXE_CNT_RCVD_PKTS);
 
-- 
2.30.2

