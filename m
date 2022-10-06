Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCAD5F6BEE
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Oct 2022 18:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiJFQkO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Oct 2022 12:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiJFQkH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Oct 2022 12:40:07 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C231A389
        for <linux-rdma@vger.kernel.org>; Thu,  6 Oct 2022 09:40:04 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso2806879fac.6
        for <linux-rdma@vger.kernel.org>; Thu, 06 Oct 2022 09:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Sx2SydxFWO5a6f78O7GmARlZelqAHo5t5iWn6bGRaM=;
        b=GCn2YFZ4SZeyZsdRgirmFdItw2fOTMD/ynlFCEHDfSNAeSkMH7+nxFhUxtJyBmI3dZ
         qwEY3uI+yDgkwtC1jjnet1d3Ay8cbE0O6a/f+g2oRUUP0Wm+NRT7dLHozfcUMkpuILHl
         y9SkGJoPjfmPu/ddsUgPk4hsChzw0bc2ZiSGLlrtFay6/zNPY2Bs9DUYjbuXE+ktHn07
         DiP/wYCIJwvpNGwcMnHP9Gi7OuSaLLLCGeLU60TYxGhuI5znA1ZPZlEJZ4H+yK8inzf7
         sdtzpYO5tSOJKy74SRSDGE3BavYO8DiSlpc+opnggZ8rl0Yin7wiZ4Nnos0G4KTjlb9H
         GK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Sx2SydxFWO5a6f78O7GmARlZelqAHo5t5iWn6bGRaM=;
        b=ssHc0Lziyf8j0FmKXNLeL+UZy0Ilzf5Aq+HF+H9HBtVoMy/4qPmBdPzr973H2GgId5
         oRE+sRX8LDKufkEfhOO31b6H7DqndrXiaOeF88UAYluNorV8G6T+CYZakOOjR8W1cEcQ
         qyD0SdDZrgmcl0x2uOld48NGnYo98YVyivohSZboMV0tdyNQqlnRuKw6/fFyvV/ng3Z+
         mxSvFwhavrrIAORfaey9Itdofegm1zAHxFlj7nxlnDlZmr3sWPcPAd3aBauJGgr1XYDi
         6q/AzrtNb9YZCQCku14bdlqZmtxL//PwM3pI3AAxGormaVSnRWAoXnoiX3ahFbCaiZNJ
         IeWg==
X-Gm-Message-State: ACrzQf27pvUweJZpr1ez0fqUp8DUkcvws9/vUOoiburk4psPechgzHfX
        dNygX+oqP9n9gt6+NM/r2a0=
X-Google-Smtp-Source: AMsMyM5ctaxDwBS9b4+GbVCwh8EsEO8L+X9byhHIQl0q1WKgni8YlmWDYBAAD8r+aHT6ylElrGYYKg==
X-Received: by 2002:a05:6871:89:b0:131:6362:e26f with SMTP id u9-20020a056871008900b001316362e26fmr308196oaa.144.1665074403903;
        Thu, 06 Oct 2022 09:40:03 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-4f1a-4f5a-81c0-34f5.res6.spectrum.com. [2603:8081:140c:1a00:4f1a:4f5a:81c0:34f5])
        by smtp.googlemail.com with ESMTPSA id o6-20020a056870524600b0012d939eb0bfsm8416oai.34.2022.10.06.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 09:40:03 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Convert spinlock to memory barrier
Date:   Thu,  6 Oct 2022 11:39:00 -0500
Message-Id: <20221006163859.84266-1-rpearsonhpe@gmail.com>
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

Currently the rxe driver takes a spinlock to safely pass a
control variable from a verbs API to a tasklet. A release/acquire
memory barrier pair can accomplish the same thing with less effort.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index b1a0ab3cd4bd..76534bc66cb6 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -42,14 +42,10 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 static void rxe_send_complete(struct tasklet_struct *t)
 {
 	struct rxe_cq *cq = from_tasklet(cq, t, comp_task);
-	unsigned long flags;
 
-	spin_lock_irqsave(&cq->cq_lock, flags);
-	if (cq->is_dying) {
-		spin_unlock_irqrestore(&cq->cq_lock, flags);
+	/* pairs with rxe_cq_disable */
+	if (smp_load_acquire(&cq->is_dying))
 		return;
-	}
-	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
 	cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 }
@@ -143,11 +139,8 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 
 void rxe_cq_disable(struct rxe_cq *cq)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&cq->cq_lock, flags);
-	cq->is_dying = true;
-	spin_unlock_irqrestore(&cq->cq_lock, flags);
+	/* pairs with rxe_send_complete */
+	smp_store_release(&cq->is_dying, true);
 }
 
 void rxe_cq_cleanup(struct rxe_pool_elem *elem)

base-commit: cbdae01d8b517b81ed271981395fee8ebd08ba7d
-- 
2.34.1

