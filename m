Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804F7611F9F
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJ2DKu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJ2DKp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:10:45 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A732A403
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:24 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13bd2aea61bso8411540fac.0
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jywcoq6WfpSz2CinBO3sC4x3ilzoShyeAxGkJ7NOWiY=;
        b=K8dNoJB9WCoiwr7HKUpVI2zBB9bFC/sGcQJA6obJ0LhCQTWQdkRPnLsXlZ3ay7evW6
         Ht5v00+/kxAUfM/f5bo4fuy55Gc5ArpeCDYzT6ZGhIdEgT8eSo8K0NxJR7Y72LJ2rvPa
         xGrn4tOIT1t5+veyRyMdTJjgmgMGCf7CWEHutzQQxUM9T60CcRPUtUXv1WeuqwDNB/tq
         mB7C+NNORdY2rimNzacJ0wsZik/fXlk+sobvvWs82GdQ570TUKs+Kq8iEfIYL2xNg2Kr
         5A+K9Y/u/NicW5soGJWsYEMC7ZT6XCldkPWK9Uq+SRVYTszPR/Bi+jTDTyF5jX6KxXZk
         MOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jywcoq6WfpSz2CinBO3sC4x3ilzoShyeAxGkJ7NOWiY=;
        b=0/8rdFm9/Kv6813FGGoczK91g85/aZ4fkVemJpMpQ8Mn+zupcheQ/4DYyResfCJYM4
         j9ifJKTX3t3WZU321Y3VGNs+2hi13tZ1swD6/y6Mtmg57r7CrhldDisRdQrKf6Hj3OVT
         zoV6MD3jEQeeI4B3nj/KzmPrcg+w+hn02zGbg1XQcsMxqlZT445qLDe39+PwOIKrWbaV
         MYCmY0M2m3e5KGSb8U43ttOB6YfySMYJZKpT2IPWVZ4SmCScRa2FvGwsaFjzmW9Qv+9y
         LsGba5SWlmRrrW4aexOtUxY01dFG1y6YFThcIszWsNXe0BLDN1SCw3IU85hhYmCQFPWJ
         IhzA==
X-Gm-Message-State: ACrzQf1rEr77km/fu0NrXicQg525OHCMjlZ6FLY2CUJfyYx0Os8A8aMW
        a/VuqEiE14HYNlXk/h8d0d0=
X-Google-Smtp-Source: AMsMyM7vsl034KhRlWp2MzTvz0KfLObK3DiLcMClWHQJx/Hu4OX67zKeQVDUjLL4e7PDr4FKaoEXjw==
X-Received: by 2002:a05:6870:a188:b0:131:ca36:7f9b with SMTP id a8-20020a056870a18800b00131ca367f9bmr11334187oaf.86.1667013023139;
        Fri, 28 Oct 2022 20:10:23 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-5d1e-45f3-e9b5-d771.res6.spectrum.com. [2603:8081:140c:1a00:5d1e:45f3:e9b5:d771])
        by smtp.googlemail.com with ESMTPSA id p3-20020a0568301d4300b006391adb6034sm162493oth.72.2022.10.28.20.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:10:22 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH v3 05/13] RDMA/rxe: Cleanup comp tasks in rxe_qp.c
Date:   Fri, 28 Oct 2022 22:10:02 -0500
Message-Id: <20221029031009.64467-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029031009.64467-1-rpearsonhpe@gmail.com>
References: <20221029031009.64467-1-rpearsonhpe@gmail.com>
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

