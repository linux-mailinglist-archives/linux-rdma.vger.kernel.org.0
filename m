Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082E369FFA1
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Feb 2023 00:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjBVXfo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Feb 2023 18:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjBVXfm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Feb 2023 18:35:42 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2973474EC
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:39 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id dm12-20020a0568303b8c00b0068db1940216so1841488otb.5
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzytK9HhWzaSQMdbRM/oFPX9az3MzdnjElHqdZw4N54=;
        b=J+SVmareSnf+MPzB3rB3+cK445LtV754i109/2QXCr54zrIhxB+LUAySMpD295PYFk
         fO077VPI/6OB8LPbKYbJMX3BiShtgk3nYaBLHw68HmCKlCtKF8L8NK8TrePy2tNjWxK6
         AD8DXBhzuyJQICxhCgGze/0oBnT1DfR3DXRDx3uu//AyEAKqCv1Y3Jh3DOLVt1/32TMZ
         VyYP/znBHGPzE3o7QbKPnncenRlGPVbD6966qroZ8EDyNUFUdeWmaGWNt0RS5egjWLXq
         3PyFxdVeADhRCxr7Hj648JOqXiRrtfg2GwKilffKg5+qqfdCZo5uxjrc3WO2c8PpmxLk
         1iLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzytK9HhWzaSQMdbRM/oFPX9az3MzdnjElHqdZw4N54=;
        b=R1FcLnUk4ufp2YX/JI7tYzE1nzR3VKyyuf3Arw6E+sPjz9cQw6VAwUdjrVIiWbA1aq
         TMmLvwG29tfFZoRGrLPnPvYKz4sIZR0z5e2HjFTCf9tAp5uZeSGkcBdrarGiWF7xBU6w
         wZgcAwdjnTf67pd4MAUC81vva1eD9QpVwKKZX/aNnhfAg8GkgNbIB2QDlDfEU+wN7Z5A
         xHBidhskRVK7GT0nOW5vn0oU2rNYxDxOVU27FJxipnzFHMexlIXxnWAYcFKj5YuzKjU9
         K0J91PZoQ7xSyax166aP0dcOtKFyNDSSl8V2dp9b1aUniN171B5Vv2pvZFMBHhYQREht
         qHyQ==
X-Gm-Message-State: AO0yUKV/9nQBhklkh152GQp9yKhWigOMqpcn/fVnviyaYud7KYZNHujQ
        dryBUWPE9JpDSIsr15JqeB4=
X-Google-Smtp-Source: AK7set+wQhQnAfaVMoUKcasbYgHsb0ZenmR06gc3572pnydBNjp/k49qwNyIdnRT5ayVraEilWbVYg==
X-Received: by 2002:a9d:1b0b:0:b0:68b:ba12:424d with SMTP id l11-20020a9d1b0b000000b0068bba12424dmr5229288otl.29.1677108939356;
        Wed, 22 Feb 2023 15:35:39 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-e92c-8850-3fad-351f.res6.spectrum.com. [2603:8081:140c:1a00:e92c:8850:3fad:351f])
        by smtp.gmail.com with ESMTPSA id l19-20020a9d7093000000b0068663820588sm2723281otj.44.2023.02.22.15.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:35:38 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 8/9] RDMA/rxe: Remove qp reference counting in tasks
Date:   Wed, 22 Feb 2023 17:32:37 -0600
Message-Id: <20230222233237.48940-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222233237.48940-1-rpearsonhpe@gmail.com>
References: <20230222233237.48940-1-rpearsonhpe@gmail.com>
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
That is a bug in rxe_task.c which will be fixed in the next patch.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 4 ----
 drivers/infiniband/sw/rxe/rxe_req.c  | 5 -----
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ----
 3 files changed, 13 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index cbfa16b3a490..6eea13381476 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -584,9 +584,6 @@ int rxe_completer(struct rxe_qp *qp)
 	enum comp_state state;
 	int ret;
 
-	if (!rxe_get(qp))
-		return -EAGAIN;
-
 	if (!qp->valid || qp->comp.state == QP_STATE_ERROR ||
 	    qp->comp.state == QP_STATE_RESET) {
 		rxe_drain_resp_pkts(qp, qp->valid &&
@@ -787,7 +784,6 @@ int rxe_completer(struct rxe_qp *qp)
 out:
 	if (pkt)
 		free_pkt(pkt);
-	rxe_put(qp);
 
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
index 7cb1b962d665..09271c861cc6 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1450,9 +1450,6 @@ int rxe_responder(struct rxe_qp *qp)
 	struct rxe_pkt_info *pkt = NULL;
 	int ret;
 
-	if (!rxe_get(qp))
-		return -EAGAIN;
-
 	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
 	if (!qp->valid)
@@ -1651,6 +1648,5 @@ int rxe_responder(struct rxe_qp *qp)
 exit:
 	ret = -EAGAIN;
 out:
-	rxe_put(qp);
 	return ret;
 }
-- 
2.37.2

