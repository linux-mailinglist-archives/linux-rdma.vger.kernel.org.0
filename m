Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DFD611FAB
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiJ2DNt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2DNs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:13:48 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90FE3A15E
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:13:42 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id r83so8065369oih.2
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jywcoq6WfpSz2CinBO3sC4x3ilzoShyeAxGkJ7NOWiY=;
        b=XdJadX39PY85QZctzUbrpyBSAAvSZZ34104z14HtwgwEofIEL4pz9OuyUfwZP5Q7Ac
         kQHgAnYpw1TwPU1Uhf1J8X/BIq5T7G9iOP3vvezEtW/NkLBtecrE6Hv6uSyrS0hQgYmW
         IeNBh6/zM0A/cov727IjUZkCfyXEboJr0zw3BT1dX5tEWuLRCDAs3ZUcEPMCPtXeSY5t
         WefLC9yvsg44KkJj7eZKtu2zyN23b2EwyAMUwPpoWTJwS9i/21o0KVxW2IOjr463aj1A
         vUyrLyk/R5HvUyT/L8OGS8d0RWMpE8O9JTt2dULru6Jzm6f31Bmtdxv+Ly/ByxTwI5Hk
         osqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jywcoq6WfpSz2CinBO3sC4x3ilzoShyeAxGkJ7NOWiY=;
        b=OmoR8QcU/t1u13E51dwvdozWHHR3ZKiIMXMJFJYEiqP1NzGYYIElhiPBkWlE05OJ+p
         61oUxqANMZpw1icdSMzPlkwtFLl372mT/8WuCYoETJk1tlFuKDwaSizXhQSn6hAV4bXH
         GkRoRUGwF6+ssMV31H261e+c0nzeUtLPhNTwC/fUWeJKHlGmOiPY+dg27XWsf1WLYxIL
         KYbGGamGYSMPKTlZSGD6uAkc5u/OJX5H7+qKy6ZvI+em2jIrWuf5Y4ZPL9tnivXA2MLV
         /Y197pnH0eyw9FxSTw1yjJ1We0QIRZev8BOQLK/AS+kwNgLW+lwB4j1fNt9BrwcQQM/9
         uRHQ==
X-Gm-Message-State: ACrzQf0N2aZuyCAwsoSd+EfIoyfGNvf0Q8jZI6xlHi2n3KnX5u7DjGg6
        KaWCez0eSryJS8O34EMyWecdp7swUgw=
X-Google-Smtp-Source: AMsMyM6ComIv7oYrnsR4Q/EfM7R4I14GZ5/yFDAyoRjSivOdfUuffgShPjl3Spb+j+UDU1bJNNbk5A==
X-Received: by 2002:a05:6808:124b:b0:353:f4fe:5846 with SMTP id o11-20020a056808124b00b00353f4fe5846mr10352006oiv.270.1667013222243;
        Fri, 28 Oct 2022 20:13:42 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-5d1e-45f3-e9b5-d771.res6.spectrum.com. [2603:8081:140c:1a00:5d1e:45f3:e9b5:d771])
        by smtp.googlemail.com with ESMTPSA id l2-20020a9d7a82000000b0066c2fd0528esm174913otn.53.2022.10.28.20.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:13:41 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v3 05/13] RDMA/rxe: Cleanup comp tasks in rxe_qp.c
Date:   Fri, 28 Oct 2022 22:13:32 -0500
Message-Id: <20221029031331.64518-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

