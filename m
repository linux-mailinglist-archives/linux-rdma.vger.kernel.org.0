Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895A9311874
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Feb 2021 03:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhBFCio (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 21:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhBFCgZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 21:36:25 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8621C08ED2E
        for <linux-rdma@vger.kernel.org>; Fri,  5 Feb 2021 15:08:00 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id d1so8469051otl.13
        for <linux-rdma@vger.kernel.org>; Fri, 05 Feb 2021 15:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=itYgS8lyxvC90K7pAlTKNU3L1mmn+/AJwi8qeF3XVUI=;
        b=CFtU4N83bNpfHN+xvQWzTDBLFBph4LQEoJUXJJQd8TNCAsSBZyJoVZOFg5MGdjy75p
         Kf3dfTN6LkV7l7HTDaPiCq/E9Q1ayL8ulTkiAC/LF3aWXJZ9/Lx0x6F1JL8TGZLMcIxw
         +9qLE8xJtUb9WXo8Vez4wzfjViDbJQaqkdh3/CvisfVHe09Ok6mDJaOAM4Iy5y5WpLes
         ZHk47nwvhHC+ZwN85At5zTMMSn+sPfHLCNKF4Rbr/R5b1/AUYoNIyhlPALDKE7Ja5LDr
         85MyfQCX47k7qIwEzHxmMWSy0Rc456DmD8y+3Vv0j5VkPRvMwliZpJd7fyAACfGoZgpK
         cc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=itYgS8lyxvC90K7pAlTKNU3L1mmn+/AJwi8qeF3XVUI=;
        b=T3bQa5O+aSl+2wYy8jPQ98PDMIK7XwMfB2wra9ZUh+0sb7dRrM/OfY8hb19o2CHYoy
         RhbE+VulYDeP0oOS13xT1aYPZkht63V4B/jIAHP5ZD3pVNgIFXn6wiVDNRPmdFpFtpTo
         KVyj+qCUxAQnF81iPJUDZyDJalklcJeO5xDOFM1hHObd/0iyjoGrnWmQ8HLSXLMpfrnb
         DRL/SfpGiK7939gR8Qr6J22b1ILM95it6DDWKXWbyh2KUtxR+kfjAjVk/akWKZLGnEiR
         S25G7+6pzSmBDaDA5Gnqmjssa8guBxU7yRMjkuBmLixpEtmUAZMjED3o2LT7fm5jo7D5
         gp7A==
X-Gm-Message-State: AOAM530V2RBoqSEOEmNHcyx6COb8T3o1Fni966QFH/oS068sEe/xhV+A
        b4TMrOlWXoke3wFSpziMe/U=
X-Google-Smtp-Source: ABdhPJw6Zycfef1zaIqzYusUFB7TN0fhC+U4ApXh8dNEJKWi3tJ88DyM/Y+VJ45BWQtA5JYXZvIV1A==
X-Received: by 2002:a9d:7f16:: with SMTP id j22mr463857otq.76.1612566480350;
        Fri, 05 Feb 2021 15:08:00 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-0c84-1204-8f4f-f302.res6.spectrum.com. [2603:8081:140c:1a00:c84:1204:8f4f:f302])
        by smtp.gmail.com with ESMTPSA id c10sm2116599otm.22.2021.02.05.15.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 15:07:59 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] RDMA/rxe: Fix checkpatch warnings
Date:   Fri,  5 Feb 2021 17:05:26 -0600
Message-Id: <20210205230525.49068-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

checkpatch -f found 3 warnings in RDMA/rxe

1. a missing space following switch
2. return followed by else
3. use of strlcpy() instead of strscpy().

This patch fixes each of these. In

		...
	} elseif (...) {
		...
		return 0;
	} else
		...

The middle block can be safely moved since it is completely
independant of the other code.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 16 ++++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 65c8df812aeb..34ae957a315c 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -62,7 +62,7 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 	struct rxe_port *port;
 	int port_num = init->port_num;
 
-	switch(init->qp_type) {
+	switch (init->qp_type) {
 	case IB_QPT_SMI:
 	case IB_QPT_GSI:
 	case IB_QPT_RC:
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 7483a33bcec5..984909e03b35 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -566,6 +566,13 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 
 	init_send_wr(qp, &wqe->wr, ibwr);
 
+	/* local operation */
+	if (unlikely(mask & WR_REG_MASK)) {
+		wqe->mask = mask;
+		wqe->state = wqe_state_posted;
+		return 0;
+	}
+
 	if (qp_type(qp) == IB_QPT_UD ||
 	    qp_type(qp) == IB_QPT_SMI ||
 	    qp_type(qp) == IB_QPT_GSI)
@@ -581,13 +588,10 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 
 			p += sge->length;
 		}
-	} else if (mask & WR_REG_MASK) {
-		wqe->mask = mask;
-		wqe->state = wqe_state_posted;
-		return 0;
-	} else
+	} else {
 		memcpy(wqe->dma.sge, ibwr->sg_list,
 		       num_sge * sizeof(struct ib_sge));
+	}
 
 	wqe->iova = mask & WR_ATOMIC_MASK ? atomic_wr(ibwr)->remote_addr :
 		mask & WR_READ_OR_WRITE_MASK ? rdma_wr(ibwr)->remote_addr : 0;
@@ -1118,7 +1122,7 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	struct ib_device *dev = &rxe->ib_dev;
 	struct crypto_shash *tfm;
 
-	strlcpy(dev->node_desc, "rxe", sizeof(dev->node_desc));
+	strscpy(dev->node_desc, "rxe", sizeof(dev->node_desc));
 
 	dev->node_type = RDMA_NODE_IB_CA;
 	dev->phys_port_cnt = 1;
-- 
2.27.0

