Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8FF607F73
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJUUC4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiJUUCX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:23 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8344C25ED03
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:15 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-136b5dd6655so4916376fac.3
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jywcoq6WfpSz2CinBO3sC4x3ilzoShyeAxGkJ7NOWiY=;
        b=X9H9TsVo6ZqZveeuCZUJ7oLE5bS0cVsma/da9EzY10+P95nYFwn3rZj8HDkBaavYcA
         oKxGeMwk+aR6yqAi91VEVarnDywDUCDMMmvJwMNcJxXaaUR55CRWMz6Zs3SRlsPtroGa
         jTuLeAk+Ofic2N4NJsoecSnrWoVcgq1JdsSMSksJlylrKe1GgMhA2cTw6+ZVs3Dt8cTi
         qYqDsEsLC7dEaMOcV/LsTmVu48hEOneNavD1B45qXXxR8/2fuz0HrC/2Ixe8DVYRDaHm
         Q+0zRGdOiHKdQP/38p/HNZQcGQrVukNGzHHNw8ZMOhMQcoyqXGphhGtcec8NFjJINmda
         ISDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jywcoq6WfpSz2CinBO3sC4x3ilzoShyeAxGkJ7NOWiY=;
        b=NM81aAu8oGF/plunadQTaz+Y16BvvBYhIiSANAl1JI5FETUNUe8pBv6JSjS+XOKlv4
         7upRzC+oDXJtyP/cPgM1610+xwoqr7pNNiJU5ZtkmpU5rJnCgnZWDt4eCDA5qp/RJxdB
         w7tdlCpXvdCq0lVrahw4ahf31Hoz2RPQ1KsVRWaFrC0iU3WgFvo+prlcrz1n7d1KJsfN
         2XQZEf3rg8E4qNttq9dA0r3FsLvRMpAsunt+miNG1IfJf25YCDapriIlj7XIdAQM8TwD
         VU/rQByX9f1Nm8Wd6nBR/7AcfDzSS24esdxX+5omBGH8tt2Nyaoyh7A8cmOisXVMVz4A
         t06g==
X-Gm-Message-State: ACrzQf0FlNzVMUssrITi+nlXhNAXi1W4LSAThpb7upAz0d7vflEwhfFu
        r2jYcOnc6q7t0R+H3XgeabI=
X-Google-Smtp-Source: AMsMyM5nIYDYBrQ/TBT9lYmXB5cPRMMZuDkf/PpCMOScB59FMGRbJ+KVq33kmdZ1WOJqRKyfhp70Qg==
X-Received: by 2002:a05:6870:586:b0:132:f48a:b487 with SMTP id m6-20020a056870058600b00132f48ab487mr13563107oap.51.1666382534921;
        Fri, 21 Oct 2022 13:02:14 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:14 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 11/18] RDMA/rxe: Cleanup comp tasks in rxe_qp.c
Date:   Fri, 21 Oct 2022 15:01:12 -0500
Message-Id: <20221021200118.2163-12-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021200118.2163-1-rpearsonhpe@gmail.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
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

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
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

