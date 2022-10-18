Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97520602359
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJREgi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJREg2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:28 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240AFA0268
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:26 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u15so14417495oie.2
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtHZM1yGvnB6A7szWnXegeRUkqTXVVuK9djjikzFkEc=;
        b=FykQRsmYjl3I9s4ChJjaC9ADQgwuxN64p4ra/AH+bdD6tI61CfxsbJ3MwFdOIy9rgy
         +qmQIl/jTXzuWKvQbipSbiygD6Vt54Lks6gkbprmRV1eTFNK7WicBcbuDbC5nxT2KdYU
         l0T/BWXJZdkLFR7KzAwT4pknpa9QnoHA4bxpAeXcaU5WC7bBKSo8r5l1p4S5gpGa+MMi
         IkT93/D8kDge7ZihPSUSl6ab8GWvQzqzfC2lCgV6wp6646VnHoYgAO22AgG8VelUOydD
         t7uoYklHcC7kAgwmcTqwj1wPoGWtZJ7ZaQnIokJ4sFzbpZ9nlKnwnCW6uEYkz+LScWCb
         6A7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtHZM1yGvnB6A7szWnXegeRUkqTXVVuK9djjikzFkEc=;
        b=4oca178J1+BvQNoln2di1uupCgQOwuVi4HMBLWcdf0EO2wRT7q5drEZBRQZiTXdw2F
         0iHedC295bOZBeI1lg34uxDii2ZiaWEG0TFjS1mhYGnaIjw4beEwT13cXPPzsvkiLqcP
         KqVHg4Vr0/EeUmYL4VsAi+0Zo2zpvQ7P8PQn1XbwH1/BB4XugNXT3J0nvJJ5OHxdM3sl
         Pd0OuPXFSy5/Pr8THpHZZiAX9s/GQOQ6ZwRD192lsjU3EWDY8TN63G7h9sWj1jzBcG7z
         UegAv8MwTnWG6rYxNbk2Rf6QhdLeJIrXWKDTAPwJ++GQ7McCy7rOHt/dogq1u20aC0mQ
         ioww==
X-Gm-Message-State: ACrzQf2j7/WUAWO17hp5y4vMjTcGKRCxDS0uld91cZoTRJr4KmkpIxJM
        X1faYIDJXzChd8JGcyAC1d0=
X-Google-Smtp-Source: AMsMyM7c60wdr/okxEurSk5kyAIfuimd/S/G3O9PwUhUM2QnXzFFLXYtSvJXaCV8vQu1kGNAHbc7eQ==
X-Received: by 2002:a05:6808:1507:b0:355:3ec:3109 with SMTP id u7-20020a056808150700b0035503ec3109mr576251oiw.263.1666067785544;
        Mon, 17 Oct 2022 21:36:25 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:36:25 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 10/16] RDMA/rxe: Cleanup comp tasks in rxe_qp.c
Date:   Mon, 17 Oct 2022 23:33:41 -0500
Message-Id: <20221018043345.4033-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018043345.4033-1-rpearsonhpe@gmail.com>
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
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

Take advantage of inline task behavior to cleanup code in rxe_qp.c
for completer tasks.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index b5e108794aa1..3691eb97c576 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -480,8 +480,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 
 	/* stop request/comp */
 	if (qp->sq.queue) {
-		if (qp_type(qp) == IB_QPT_RC)
-			rxe_disable_task(&qp->comp.task);
+		rxe_disable_task(&qp->comp.task);
 		rxe_disable_task(&qp->req.task);
 	}
 
@@ -524,9 +523,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	rxe_enable_task(&qp->resp.task);
 
 	if (qp->sq.queue) {
-		if (qp_type(qp) == IB_QPT_RC)
-			rxe_enable_task(&qp->comp.task);
-
+		rxe_enable_task(&qp->comp.task);
 		rxe_enable_task(&qp->req.task);
 	}
 }
@@ -537,10 +534,7 @@ static void rxe_qp_drain(struct rxe_qp *qp)
 	if (qp->sq.queue) {
 		if (qp->req.state != QP_STATE_DRAINED) {
 			qp->req.state = QP_STATE_DRAIN;
-			if (qp_type(qp) == IB_QPT_RC)
-				rxe_sched_task(&qp->comp.task);
-			else
-				__rxe_do_task(&qp->comp.task);
+			rxe_sched_task(&qp->comp.task);
 			rxe_sched_task(&qp->req.task);
 		}
 	}
@@ -556,11 +550,7 @@ void rxe_qp_error(struct rxe_qp *qp)
 
 	/* drain work and packet queues */
 	rxe_sched_task(&qp->resp.task);
-
-	if (qp_type(qp) == IB_QPT_RC)
-		rxe_sched_task(&qp->comp.task);
-	else
-		__rxe_do_task(&qp->comp.task);
+	rxe_sched_task(&qp->comp.task);
 	rxe_sched_task(&qp->req.task);
 }
 
-- 
2.34.1

