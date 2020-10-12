Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEA728BE7F
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 18:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403966AbgJLQxT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 12:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390534AbgJLQxT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 12:53:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C26C0613D0;
        Mon, 12 Oct 2020 09:53:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h7so19993584wre.4;
        Mon, 12 Oct 2020 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+vLvR2wy5eGqgyPIxJSCZBSQQ+dbsnbZ11swl+iSUJE=;
        b=hkMbwX9Ihr0nuDzGl4PJrqj4PHwbhKvCszEovxFaOBuv39OX1Dh7OZwuvlGkUh9GQt
         RMIvqPvIZRQsfDRO4EaJND5XLaEqVPJK9N3UExt6xPZ1akVFhrUFRwTZBlZbIpvwOy46
         dU5mzhM5N/Qa8CcTK8S8ib/Ec/AZhV8+pM8EFHquvRcCAeZGSpQmW0t3y3miYan10D9V
         zRfS3s2X60MZwl79zyqc+PQea8n/STI2D53qpn9K9gR2eCAVCAxZP5bJbVsozhLC7JuW
         MUNSGcBGab5iBowjvnhV+HinPe2PpRoLqmyI8Zq/RqgyCx9WnH6EusiuPJT7UIpN3pl7
         sHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+vLvR2wy5eGqgyPIxJSCZBSQQ+dbsnbZ11swl+iSUJE=;
        b=O4LOmE35wBUOHqQc4Ny7TQ1Vyiawyo/oo7YaO6hlh5tGW91EoaggWjAyaQlgTmhdFh
         cHai6CCUPTatUDdfxeOxhDbp2PnRwXLI5q6xtceGGmM/7iDvxMhHIn85sOLIRalDM3+d
         t6E6tKZdqJn6wwGhK0kdvU3LlkrjS3HsRbTFNu8rtuLE9xEDRh3XgCzAmgKoEnN753et
         O/YWhtb1viiut8L9yG8I6GfvLgT308LMVLJ54DCECYJnasqDvZhe+qlZdHtZAAgZsjq4
         tkJDGxHOb+Wi1R7pZ2vgn1Bzh2kccTgxKfk5wagVJp+uAO1WFMQhAycZ+r3fToYfZwjc
         26MA==
X-Gm-Message-State: AOAM532Fr7mSMXKts7z90njI5B3lLE7FXLVsA15ZhP/iEsyZNDFo3so+
        JTrhH0PO57MsxFb6TSmDP3ZqHx3eEUGs+w==
X-Google-Smtp-Source: ABdhPJzKK+zDmc7pcMb2gP2pC09uP7g0Ac9Lj3c1QZ4Te6MjKjvXS/C5cbgyLnQKWSBBMe/H+1sZxQ==
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr1310096wro.22.1602521597296;
        Mon, 12 Oct 2020 09:53:17 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id d30sm27362777wrc.19.2020.10.12.09.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 09:53:16 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/rxe: Fix possible NULL pointer dereference
Date:   Mon, 12 Oct 2020 17:52:30 +0100
Message-Id: <20201012165229.59257-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

skb_clone() is called without checking if the returned pointer is NULL
before it is dereferenced. Fix by adding an additional error check.

Fixes: e7ec96fc7932 ("RDMA/rxe: Fix skb lifetime in rxe_rcv_mcast_pkt()")
Addresses-Coverity-ID: 1497804: Null pointer dereferences (NULL_RETURNS)
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 11f3daf20768..a65936e12f89 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -266,10 +266,13 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		/* for all but the last qp create a new clone of the
 		 * skb and pass to the qp.
 		 */
-		if (mce->qp_list.next != &mcg->qp_list)
+		if (mce->qp_list.next != &mcg->qp_list) {
 			per_qp_skb = skb_clone(skb, GFP_ATOMIC);
-		else
+			if (!per_qp_skb)
+				goto err2;
+		} else {
 			per_qp_skb = skb;
+		}
 
 		per_qp_pkt = SKB_TO_PKT(per_qp_skb);
 		per_qp_pkt->qp = qp;
@@ -283,6 +286,10 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 	return;
 
+err2:
+	spin_unlock_bh(&mcg->mcg_lock);
+	rxe_drop_ref(mcg);	/* drop ref from rxe_pool_get_key. */
+
 err1:
 	kfree_skb(skb);
 }
-- 
2.28.0

