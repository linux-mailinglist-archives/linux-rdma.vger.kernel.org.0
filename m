Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AB96185D4
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiKCRLc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiKCRKq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:46 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692852651
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:36 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1322d768ba7so2892416fac.5
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCy2bDlCBQ8PdVfXPhoVHT1lTJtBg3hJoknThX7Fg0k=;
        b=MOdSck6MGH2y4Z/8dDFUUhuKX/HvlSK296BHLTEN55u8KijyT92sOxapp/OFvNGefd
         Jj+KlLk24G8p+8Va925303ReZSIN6jiOB2BblSi7o48nmDIaS1EpIP+d21YTpxVnOGsu
         KnRimuDXBXAx7LdoGkO9oB8YAECjGarIg4Vm7XBYSbsdXrpsfA/y2sOxrSRvV1J9m1oC
         63XkQ6aypFDoVE0djoROqskpBBLuCT8n0sl4ntjH+yyzarvtgdg9ljLJBetIUEseGAn7
         8Vyvm4D3HnWVkhdBQQlj76PbjppbP42vDl1n7CHRRQ/jQAHhwbd3Hr9a72XBjMQXH4eG
         98vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCy2bDlCBQ8PdVfXPhoVHT1lTJtBg3hJoknThX7Fg0k=;
        b=lK/embDegMNg/aQzsbpdcfrbNFpOjZsPq5cSym03EaUpUq11XtxmlnlQ82tbmjkbbM
         9CvmcTlol9EU/HOlR2l4Xnu6QmlXXorfJARg5eWDkfy+U3BYN34RgecvPzhMCzmda//f
         6FcTLfK9LTSVZcDN8mnNLXc47aNYshy/KgUqGfNML2vZzU+h2ASgu9EUrtBxeZ0tjOwL
         EPFYn0iNEeexqIboU8agY/w1GwpXJnn2FO2gX55VCDuK9mNsHqjWKfbejlxEI9akcme5
         Z3bipOfpqArGXw7KCVz6jWpA3Qu9am9BcC9CjFowTh+H0g8eu9ngHhRyRlpP9skfZcFY
         cb6Q==
X-Gm-Message-State: ACrzQf0fDj+ctYp2gBfj4O0z9SIBXJMcaKoGHEXbhdQ81RJztEmMiuU4
        5OkPpqxYIVtsGGs6ejwK+pM=
X-Google-Smtp-Source: AMsMyM7yKda+lJI0XhdhjiCb6UzvMN+f3dcFj2LTnGLKJ1btd+jXz6b+bpeHnY/IikMtf/TDi1gdYg==
X-Received: by 2002:a05:6870:9627:b0:136:c323:2ad8 with SMTP id d39-20020a056870962700b00136c3232ad8mr28194176oaq.259.1667495435755;
        Thu, 03 Nov 2022 10:10:35 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:35 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 03/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_cq.c
Date:   Thu,  3 Nov 2022 12:10:01 -0500
Message-Id: <20221103171013.20659-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103171013.20659-1-rpearsonhpe@gmail.com>
References: <20221103171013.20659-1-rpearsonhpe@gmail.com>
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

Replace calls to pr_xxx() in rxe_cq.c with rxe_dbg_xxx().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index b1a0ab3cd4bd..1df186534639 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -14,12 +14,12 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 	int count;
 
 	if (cqe <= 0) {
-		pr_warn("cqe(%d) <= 0\n", cqe);
+		rxe_dbg(rxe, "cqe(%d) <= 0\n", cqe);
 		goto err1;
 	}
 
 	if (cqe > rxe->attr.max_cqe) {
-		pr_debug("cqe(%d) > max_cqe(%d)\n",
+		rxe_dbg(rxe, "cqe(%d) > max_cqe(%d)\n",
 				cqe, rxe->attr.max_cqe);
 		goto err1;
 	}
@@ -27,7 +27,7 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 	if (cq) {
 		count = queue_count(cq->queue, QUEUE_TYPE_TO_CLIENT);
 		if (cqe < count) {
-			pr_debug("cqe(%d) < current # elements in queue (%d)",
+			rxe_dbg_cq(cq, "cqe(%d) < current # elements in queue (%d)",
 					cqe, count);
 			goto err1;
 		}
@@ -65,7 +65,7 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 	cq->queue = rxe_queue_init(rxe, &cqe,
 			sizeof(struct rxe_cqe), type);
 	if (!cq->queue) {
-		pr_warn("unable to create cq\n");
+		rxe_dbg(rxe, "unable to create cq\n");
 		return -ENOMEM;
 	}
 
-- 
2.34.1

