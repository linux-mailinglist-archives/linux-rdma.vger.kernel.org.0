Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE284DD2A3
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 02:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiCRB5A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 21:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiCRB47 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 21:56:59 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E32241A10
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:31 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id e4so4467427oif.2
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1xptPxghO5Wv38XZBgv1n4noPRyDNrIm4QC80PPVwBo=;
        b=NCSI8ASfaJnabR36RGZYsF6iuUoeLNJSjrbNQjx/wsExiEi7G7oQk+H8yVehakCRAU
         i6NWT9KTH+Fp6RC4lbnd/eGplKU+jK0E2vzaW5VoLDFKaui/c2y6yBjbY7+JVBx0rLNt
         gno4Iyx5D+DVSgK1jCVf6puaMUMKGk3LEn3H80PAwifLkalN/RMhtSKcmTMbWB4+lkfF
         DoxKxp7VKNDF2Ja8LvTEGtMMRFbWjjLbFEnaS+gmdJAMOmSh4GViARlbDCNhx6t7uhIo
         4I0gW+QlpIt31pgieK3DQHdNdehNefmdeqg6ZsNlLrMdbvHVAtyqtMEIsjzBGLftChOK
         +TOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1xptPxghO5Wv38XZBgv1n4noPRyDNrIm4QC80PPVwBo=;
        b=T+vTvhbPVJagKK2Z8DfxHIbh3kXMgZovimYdhlYwOe1v25GDGcyKKKiS2rOzmk3dGm
         CKV3gTe2tqeVR2rQfyOLQJb8w2P/7EChm3P41OQFV8IEDv6rjhPwHb1K0qgB+zMAB+w/
         bYzrQJYLL4cn3iPVftY40uMeYvBWdk6poNvjDMDJjKVlHr9Ed4Yy3sU2oqBZvEiujfj8
         +RmbW3ll67oYr2iathdTFsK9q7DBlJJGuPHS3udjbvOFDLx/oFlbsqWh8DfxUm6l3j+G
         4xCfHMOD+OZElEiP9E/dqcLDBimDDWSXQBDBDrNNgji1ZuXx2OmZ0IE/TBi5zi3c6EH1
         c/gQ==
X-Gm-Message-State: AOAM531vtCwZYBy4bOgsLGYJNcP8aJ5yaxY/OYtqcj4POx25wUb84Imr
        0ftdaFwcqSL+sL8eBoH8g5U=
X-Google-Smtp-Source: ABdhPJxIWRzPzbPM9yFlVViO1YZyMXyo7f0E1Y3fiGAzXxuDYyBEzT72/RqSnXZWQ1HER5efgYRGVA==
X-Received: by 2002:a05:6808:190e:b0:2da:226f:5ab with SMTP id bf14-20020a056808190e00b002da226f05abmr3443443oib.13.1647568531313;
        Thu, 17 Mar 2022 18:55:31 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-257e-2cb6-0a79-8c62.res6.spectrum.com. [2603:8081:140c:1a00:257e:2cb6:a79:8c62])
        by smtp.googlemail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm3292878oaf.10.2022.03.17.18.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:55:31 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 03/11] RDMA/rxe: Check rxe_get() return value
Date:   Thu, 17 Mar 2022 20:55:06 -0500
Message-Id: <20220318015514.231621-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318015514.231621-1-rpearsonhpe@gmail.com>
References: <20220318015514.231621-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In the tasklets (completer, responder, and requester) check the
return value from rxe_get() to detect failures to get a reference.
This only occurs if the qp has had its reference count drop to
zero which indicates that it no longer should be used. This is
in preparation to an upcoming change that will move the qp cleanup
code to rxe_qp_cleanup().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 3 ++-
 drivers/infiniband/sw/rxe/rxe_req.c  | 3 ++-
 drivers/infiniband/sw/rxe/rxe_resp.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 138b3e7d3a5f..da3a398053b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -562,7 +562,8 @@ int rxe_completer(void *arg)
 	enum comp_state state;
 	int ret = 0;
 
-	rxe_get(qp);
+	if (!rxe_get(qp))
+		return -EAGAIN;
 
 	if (!qp->valid || qp->req.state == QP_STATE_ERROR ||
 	    qp->req.state == QP_STATE_RESET) {
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ae5fbc79dd5c..27aba921cc66 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -611,7 +611,8 @@ int rxe_requester(void *arg)
 	struct rxe_ah *ah;
 	struct rxe_av *av;
 
-	rxe_get(qp);
+	if (!rxe_get(qp))
+		return -EAGAIN;
 
 next_wqe:
 	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 16fc7ea1298d..1ed45c192cf5 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1250,7 +1250,8 @@ int rxe_responder(void *arg)
 	struct rxe_pkt_info *pkt = NULL;
 	int ret = 0;
 
-	rxe_get(qp);
+	if (!rxe_get(qp))
+		return -EAGAIN;
 
 	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
-- 
2.32.0

