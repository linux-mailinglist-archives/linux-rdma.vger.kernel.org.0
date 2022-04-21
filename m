Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A295094B6
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 03:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383654AbiDUBoB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 21:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383665AbiDUBn7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 21:43:59 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E5113FBF
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:11 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e2a00f2cc8so3947391fac.4
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J9C0qft11+s8T5hP9zWOQB4PW9ykUFarEO2261Tr0/U=;
        b=pBPGN/ovw1FfF2xZpOvN0IlsS241K8la5rIXLuB15dzKCwiZqfqrHnIhyNBFNNI+dG
         UrpNXDcE+pTMaxBmQ00JeT0M4qDwRoUkmENJCpV19EScowPRct1ec2zvgLgbEuOR9JKb
         gEK+EGLcGAdwpTybCWIejodQitGBHJjmSH6ZsGt6FUvKN1al7Dvq22PV4CRhtHcbL0aC
         NJbQLAkySo7wgtuy0C0PMUH3NlPDxH1GwwuQYknDqAZChVTWy5QO3dQ5o6VdkoYU6JXQ
         89IP4n4fvhS63V3IcMbK9NYW7yH405P/Vm/mZ3ikDVnZ7jdoqIYJlSUu0ZlzcikQZSFI
         BX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9C0qft11+s8T5hP9zWOQB4PW9ykUFarEO2261Tr0/U=;
        b=dkmlWN6iFzpeQ6aH31VaA24SXMO8EGRa6FU8tccftF/Fwe+p5+VAv54sQOmpdM3LP0
         YCnb09m43oSq70cTdaZqBhexRjpi/aImjmznMrq8z0kV1LlDbW5+B9P6pZEwGIUW5mUR
         x8JyeCS/5k5eZx4T8u1qphxpYRgAEz6B2cLQ3TFcaBDLb45Gcer+a95FMuSRT/3rTek3
         /AG9MztTVlXD6MUOumocUyX+mVMmGaGap6BxGoQzczKTOSpR3polxqmlo490MFqMOZFa
         R+VOqyMFGgxYjXFWHdcBDJwA7xPAmr4wP2tcbt5wLw5p+7av/BgjPbmuExE1v/CWskJN
         p9Sg==
X-Gm-Message-State: AOAM531pnxoNN4ChrULptfIPr36qKqMQvWoabMn2oGbc7k1I6HxND/5U
        RLSObCqZC/kB2FTPwFSuMJ0=
X-Google-Smtp-Source: ABdhPJyBIfx8k94JKBvRO4bv36QQbyg58S9d1esQR3OSyO5NrxyLZIlZ+oM/GikQO7+8TfmmrWYhxQ==
X-Received: by 2002:a05:6870:78d:b0:e2:e03c:6587 with SMTP id en13-20020a056870078d00b000e2e03c6587mr2846742oab.294.1650505271010;
        Wed, 20 Apr 2022 18:41:11 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-c7f7-b397-372c-b2f0.res6.spectrum.com. [2603:8081:140c:1a00:c7f7:b397:372c:b2f0])
        by smtp.googlemail.com with ESMTPSA id l16-20020a9d6a90000000b0060548d240d4sm4847710otq.74.2022.04.20.18.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:41:10 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v14 03/10] RDMA/rxe: Check rxe_get() return value
Date:   Wed, 20 Apr 2022 20:40:36 -0500
Message-Id: <20220421014042.26985-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220421014042.26985-1-rpearsonhpe@gmail.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
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
index 9bb24b824968..ca55bc4cd120 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -609,7 +609,8 @@ int rxe_requester(void *arg)
 	struct rxe_ah *ah;
 	struct rxe_av *av;
 
-	rxe_get(qp);
+	if (!rxe_get(qp))
+		return -EAGAIN;
 
 next_wqe:
 	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 49133bd0d756..f4f6ee5d81fe 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1262,7 +1262,8 @@ int rxe_responder(void *arg)
 	struct rxe_pkt_info *pkt = NULL;
 	int ret = 0;
 
-	rxe_get(qp);
+	if (!rxe_get(qp))
+		return -EAGAIN;
 
 	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
-- 
2.32.0

