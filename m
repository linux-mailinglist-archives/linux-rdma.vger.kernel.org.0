Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9FF31185E
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Feb 2021 03:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhBFCgA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 21:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhBFCdj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 21:33:39 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B9DC08EE25
        for <linux-rdma@vger.kernel.org>; Fri,  5 Feb 2021 16:25:02 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id v193so3960962oie.8
        for <linux-rdma@vger.kernel.org>; Fri, 05 Feb 2021 16:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQKQUsK6QMsy4X1oV28tM4z8Ewm0hEDOsXzwdCyisqY=;
        b=gexGdOH1sm7Hi0CeMn2IaZ6IvAWu5qkCraAlWyLc+xTkTHRts2h1GVGzwMAxdYclLT
         pxPTUFhq4U8o5e4bDPEN7IyIDRT0jthzfNZ44/2i8aDcYHobp/Kd99CIkqq5ikg0oZPL
         B/Fy0t5Q7A+lVnMnj6qBPNX0BO4XN/UbpmmsETf1vUE8XZVYyi4Y488OopqXnYYiHceL
         x/EBzVfRoOh2VBbhbLEY68jhLiILotMbIbRG0EHS7AavLpyN5Foe8/Sq+ju5YgITHdpz
         a8bKV1kM6bjaraFVtuGR/ir08nf+09siAFNALDCev03Q5OBjf7bgdOchCyyJTk7LUslL
         k5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQKQUsK6QMsy4X1oV28tM4z8Ewm0hEDOsXzwdCyisqY=;
        b=kteJrB3JsJ08MWvGrp+1CPe/RVM42FpxOq2zQfWMmvuN1tlTsb6Wt1LqhWuD6hZ1/1
         9qxIEAs6hXZpCVyM1AhYMf2Nm5u258COzNVdgdISYGgF6PV1XzPwNbUctIu1qGZ6iF3b
         00i2PxvK7mu8mdalZM2dmO5ZPqsr1u/U9/8nWbkK6YXD7G1KhWwDU35W35GDDmkcxpxg
         yGS4EKNTKqV3N+dwwGrJAfM4rxVKEKTZ5KVWG08tae/EJfUohZIZeKbo7gY8cqU5iunh
         uRA18NmjSYOVuCAn/LRNVB3HqpCVFyxupXVEJ7XXR2dyUL1gdjzVF7JMRQlgLKQaCRgp
         S9vA==
X-Gm-Message-State: AOAM533Rj4/F13QXKgXVUyrhc/S8aWeFwHGkv+HYUkCeazoG6B/N891G
        C1jRdyAShCWi8VccOJfAkz4=
X-Google-Smtp-Source: ABdhPJxN3dhQyEKZjX6GIuKwZpyj2jzqxvw+cdp3E3aj/3g06hOSyiXrAP+qmherTkPBaVlw1XQNAA==
X-Received: by 2002:aca:ba56:: with SMTP id k83mr4804118oif.82.1612571101491;
        Fri, 05 Feb 2021 16:25:01 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-b1e0-6ae3-596c-1850.res6.spectrum.com. [2603:8081:140c:1a00:b1e0:6ae3:596c:1850])
        by smtp.gmail.com with ESMTPSA id f26sm2131662otq.80.2021.02.05.16.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 16:25:00 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] RDMA/rxe: Cleanup init_send_wqe
Date:   Fri,  5 Feb 2021 18:24:37 -0600
Message-Id: <20210206002437.2756-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch changes the type of init_send_wqe in rxe_verbs.c to void
since it always returns 0. It also separates out the code that copies
inline data into the send wqe as copy_inline_data_to_wqe().

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 42 ++++++++++++---------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 984909e03b35..dee5e0e919d2 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -555,14 +555,24 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 	}
 }
 
-static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
+static void copy_inline_data_to_wqe(struct rxe_send_wqe *wqe,
+				    const struct ib_send_wr *ibwr)
+{
+	struct ib_sge *sge = ibwr->sg_list;
+	u8 *p = wqe->dma.inline_data;
+	int i;
+
+	for (i = 0; i < ibwr->num_sge; i++, sge++) {
+		memcpy(p, (void *)(uintptr_t)sge->addr, sge->length);
+		p += sge->length;
+	}
+}
+
+static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 			 unsigned int mask, unsigned int length,
 			 struct rxe_send_wqe *wqe)
 {
 	int num_sge = ibwr->num_sge;
-	struct ib_sge *sge;
-	int i;
-	u8 *p;
 
 	init_send_wr(qp, &wqe->wr, ibwr);
 
@@ -570,7 +580,7 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	if (unlikely(mask & WR_REG_MASK)) {
 		wqe->mask = mask;
 		wqe->state = wqe_state_posted;
-		return 0;
+		return;
 	}
 
 	if (qp_type(qp) == IB_QPT_UD ||
@@ -578,20 +588,11 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	    qp_type(qp) == IB_QPT_GSI)
 		memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av, sizeof(wqe->av));
 
-	if (unlikely(ibwr->send_flags & IB_SEND_INLINE)) {
-		p = wqe->dma.inline_data;
-
-		sge = ibwr->sg_list;
-		for (i = 0; i < num_sge; i++, sge++) {
-			memcpy(p, (void *)(uintptr_t)sge->addr,
-					sge->length);
-
-			p += sge->length;
-		}
-	} else {
+	if (unlikely(ibwr->send_flags & IB_SEND_INLINE))
+		copy_inline_data_to_wqe(wqe, ibwr);
+	else
 		memcpy(wqe->dma.sge, ibwr->sg_list,
 		       num_sge * sizeof(struct ib_sge));
-	}
 
 	wqe->iova = mask & WR_ATOMIC_MASK ? atomic_wr(ibwr)->remote_addr :
 		mask & WR_READ_OR_WRITE_MASK ? rdma_wr(ibwr)->remote_addr : 0;
@@ -603,8 +604,6 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	wqe->dma.sge_offset	= 0;
 	wqe->state		= wqe_state_posted;
 	wqe->ssn		= atomic_add_return(1, &qp->ssn);
-
-	return 0;
 }
 
 static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
@@ -627,10 +626,7 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	}
 
 	send_wqe = producer_addr(sq->queue);
-
-	err = init_send_wqe(qp, ibwr, mask, length, send_wqe);
-	if (unlikely(err))
-		goto err1;
+	init_send_wqe(qp, ibwr, mask, length, send_wqe);
 
 	advance_producer(sq->queue);
 	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
-- 
2.27.0

