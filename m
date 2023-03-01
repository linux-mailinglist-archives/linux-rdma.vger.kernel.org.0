Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A026A6722
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Mar 2023 05:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCAEws (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 23:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjCAEwr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 23:52:47 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9493403A
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 20:52:45 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id bj30so4113810oib.6
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 20:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oO4zS5VDWvEFX/eQvXfDUh+dVC58M0RwnbDvyWKYzI=;
        b=C2QFr9pxAwNSkcNXX/xfzmNEnSvGuyj4ZiwirkWJaQ1hcaGb8iFWsp7u57R95Gj8Wb
         UXCEoWl4h2Rv1lCC7/n8MhN1vPCcxak2t3zg+B2BaFckX8eDTXkCLMymFTeXBrQPOYSA
         b/6W0rIQEeoKBCnHdFlQ0dV6XRbq8Ix5GZ2y31XrNlHU7Zaxkm1tYBgfZUDMViwWFq6X
         Zar1SsfrzdIB+YzUL3n0YBCXsmc8nIY5+622q7EA99xrP3u7nbjFLcAlyYVWcDqpwgZ1
         ibalpiRtkmUZ/NPwbjPTgBsGrJ/JY9XpniOKssXR9XGIOYGcf8jnXs+YrylQ5uIQ8pn+
         GkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oO4zS5VDWvEFX/eQvXfDUh+dVC58M0RwnbDvyWKYzI=;
        b=7Hy62IlQwPyhF70NiKxXrw+kF4VCxyDNyVYj6jxDR5X2CJm/AFx52HefLrUn8dz+w0
         k7irmXK4+xZ1R1REmdQd4m9TzCXVuoTJMQnKqlA/AIQBmdb12KbD7SSeddRq5x+eAKqC
         d7V5Oi8l2J6W1/uZ6kj9gpDGfhWHPaknznoY9QEUe9k/7fOkVHY56u4Li+bR6Hs6Usfl
         Vy1/AmZ/Ik4IQDZ3360WBj2f+xQVY3VfnRNKEgn8HRwm9vSXbDz0qptb6CfjdYAoneS+
         0mJCaoYiLRkKz95WavFu1tPRez+4JpBVjdEULGAsHZvtCxBTD1/OJ66oP9w+v0qmJADr
         BFWw==
X-Gm-Message-State: AO0yUKVIJRfa0u57HKWjtf5UuXceichgoYBinD3hBCW7uZ+Cp5Qa5fAR
        5pvTO+Qlj2QHsRE+TY2pyLo=
X-Google-Smtp-Source: AK7set8cBOJybu4I+9md6EBYb3q+bZ1nJ9F491Yq3cBPRFe1fD3Zy9gv5gUc3YNEPtl5O7yRbHZgnw==
X-Received: by 2002:aca:2201:0:b0:384:28d6:b99c with SMTP id b1-20020aca2201000000b0038428d6b99cmr2443193oic.7.1677646365075;
        Tue, 28 Feb 2023 20:52:45 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-759b-a469-60fc-ba97.res6.spectrum.com. [2603:8081:140c:1a00:759b:a469:60fc:ba97])
        by smtp.gmail.com with ESMTPSA id ex16-20020a056808299000b0037fcc1fd34bsm5309604oib.13.2023.02.28.20.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 20:52:44 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 5/8] RDMA/rxe: Remove qp reference counting in tasks
Date:   Tue, 28 Feb 2023 22:51:52 -0600
Message-Id: <20230301045154.23733-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230301045154.23733-1-rpearsonhpe@gmail.com>
References: <20230301045154.23733-1-rpearsonhpe@gmail.com>
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

Currently each of the three tasklets requester, completer and
responder in the rxe driver take and release a reference to the
qp argument at the beginning and end of the subroutines. The
caller passing in the qp argument should be responsible for holding
a reference to qp so these are not required. Further doing so
breaks the qp cleanup code in rxe_qp_do_cleanup which calls these
routines after all the references have been dropped so they cannot
drain the packet and work request queues as intended.

In fact if these routines are deferred by calling tasklet_schedule
there is no guarantee that the calling code does have a qp reference.
That is a bug in rxe_task.c which will be fixed later in this series.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 5 -----
 drivers/infiniband/sw/rxe/rxe_req.c  | 5 -----
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ----
 3 files changed, 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index ebece584a020..fa864c6704ac 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -619,9 +619,6 @@ int rxe_completer(struct rxe_qp *qp)
 	enum comp_state state;
 	int ret;
 
-	if (!rxe_get(qp))
-		return -EAGAIN;
-
 	if (!qp->valid || qp->comp.state == QP_STATE_ERROR ||
 	    qp->comp.state == QP_STATE_RESET) {
 		bool notify = qp->valid &&
@@ -824,7 +821,5 @@ int rxe_completer(struct rxe_qp *qp)
 out:
 	if (pkt)
 		free_pkt(pkt);
-	rxe_put(qp);
-
 	return ret;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index f2dc2d191e16..abc65c54bfd6 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -653,9 +653,6 @@ int rxe_requester(struct rxe_qp *qp)
 	struct rxe_ah *ah;
 	struct rxe_av *av;
 
-	if (!rxe_get(qp))
-		return -EAGAIN;
-
 	if (unlikely(!qp->valid))
 		goto exit;
 
@@ -844,7 +841,5 @@ int rxe_requester(struct rxe_qp *qp)
 exit:
 	ret = -EAGAIN;
 out:
-	rxe_put(qp);
-
 	return ret;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 2f71183449f9..01e3cbea8445 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1464,9 +1464,6 @@ int rxe_responder(struct rxe_qp *qp)
 	struct rxe_pkt_info *pkt = NULL;
 	int ret;
 
-	if (!rxe_get(qp))
-		return -EAGAIN;
-
 	if (!qp->valid || qp->resp.state == QP_STATE_ERROR ||
 	    qp->resp.state == QP_STATE_RESET) {
 		bool notify = qp->valid &&
@@ -1658,6 +1655,5 @@ int rxe_responder(struct rxe_qp *qp)
 exit:
 	ret = -EAGAIN;
 out:
-	rxe_put(qp);
 	return ret;
 }
-- 
2.37.2

