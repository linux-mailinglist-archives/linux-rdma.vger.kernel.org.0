Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12366AABAB
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Mar 2023 18:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCDRqv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Mar 2023 12:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjCDRqu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Mar 2023 12:46:50 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16141B572
        for <linux-rdma@vger.kernel.org>; Sat,  4 Mar 2023 09:46:48 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id l16-20020a9d4c10000000b006944b17058cso2976771otf.2
        for <linux-rdma@vger.kernel.org>; Sat, 04 Mar 2023 09:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677952008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGvVu9UP1kN4tY4HLfoBPjtQL2U8Fkq/aq9vMca1XFY=;
        b=OnmoqnE0t3PvHZQgi12z5lN8tpTtIIf3vSdwPc4wWyaNA5F1VOAZzJqJVi4EXKnrcW
         4irV+Sma5/tYeCRcrV6dgRmoxhhCTm3LjUY1W6cQztatsLf9J94kuHUzlyiSTiQ6F5JB
         /7Jr1t+dHbMx0TL5MqAE85XLMfIPfSmQMQ/qj9mGu8blFC0PAF75GolkhWCL64HxAcNG
         1kvV4IwZRJuSkg/GvU6l9jKIkvbV7siNRKrXMMunMqeQqzGP4P2OY56ptZ/ZbKWRonTz
         5sOpscI3ENIZ3ma/s6U27bONLdXMhnpEyh0xrFcz1MaxaiINPlzxF12dyF+HWck1EgU7
         fu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677952008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGvVu9UP1kN4tY4HLfoBPjtQL2U8Fkq/aq9vMca1XFY=;
        b=NX6V1nqg5jC63GeojmAIbuqJJ0JuWUlLKdJjcpfBIIWxtk6Kj4v8Qakr26OKNYyefM
         owc/V87oYlka6huOGR/SZsYqcWu8S0g8hHqE9Tp6S82DWEq1gqZSxKG0Mpl1o7+8L8/U
         sEb4Dz6DU84yhUBWOgLlaVdTluj33ESYSDP5xzHOG9NCfpJ+WfC0hSOJwtULiLsrfpKL
         09R8LiPmerlz7lVhUsTmVYZBF8t/06d4MzwWk1SP/G2MI2HbuOGTuZj39oYaMEyJr9ra
         O/oydhcJ+2Fc/ZPeQ5qPD4sCpVoYBAduI/jLZICJFX2Mfc74hF8ywElU3voDoruGOMQo
         KWAQ==
X-Gm-Message-State: AO0yUKWDdf+JDWzwVFSP4AKqaoZIxJNKXeei2jWM1OGqQaiasaQaKzPw
        KLe1PdrhKE2/NB0ZrnCq2YiTZypuE0w=
X-Google-Smtp-Source: AK7set8Aku3Eu5CGlluEu0utSLPeprUGrVYNL2prrLBaA6MEfQJLGwFBT3biplOimd9b12wp/OGyAw==
X-Received: by 2002:a05:6830:349d:b0:690:eb17:89f7 with SMTP id c29-20020a056830349d00b00690eb1789f7mr3958471otu.15.1677952008040;
        Sat, 04 Mar 2023 09:46:48 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-f848-0c36-f4e0-0517.res6.spectrum.com. [2603:8081:140c:1a00:f848:c36:f4e0:517])
        by smtp.gmail.com with ESMTPSA id a1-20020a056830008100b0068bcadcad5bsm2311227oto.57.2023.03.04.09.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 09:46:47 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 5/8] RDMA/rxe: Remove qp reference counting in tasks
Date:   Sat,  4 Mar 2023 11:45:31 -0600
Message-Id: <20230304174533.11296-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230304174533.11296-1-rpearsonhpe@gmail.com>
References: <20230304174533.11296-1-rpearsonhpe@gmail.com>
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
index f7ab0dfe1034..7aa8e90bdfe4 100644
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

