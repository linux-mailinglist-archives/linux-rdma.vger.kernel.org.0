Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F4F615327
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 21:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiKAUXz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 16:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiKAUXx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 16:23:53 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945F61EAD3
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 13:23:50 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id y67so17175712oiy.1
        for <linux-rdma@vger.kernel.org>; Tue, 01 Nov 2022 13:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHbOXnY8o7rTAT8DVu9lCYSozb8GmEwnDOfzCyO8zXI=;
        b=NhUvAd1B35JMigi7bR+e6LL7otdvLimb69vQ0ZCnzzN5DbaHpJ7JEjJVDPaADh4lIM
         92sFzkIuP0vK2ZcykKGfcf11dAI9+wewXSPJ49wIgwtwZecRC3zd3cV/KFNfzmXlsk3b
         ug1VweSmrnAsW6m/StGD97daM4+1o6hVWS5DPIJj0BXs8aQH5uSTFaSXJcIFb77ib/03
         z2xMYNtJw7cvaPXxOxKBsB2z3m8XnpRV65W7gOBGrCMV/Bjym2vszKIkO0I40HbKpd4D
         cNZQUIpbUQX98xI9jDpqvw5ewCQwzdscRSb/fC7mffx561AOoHTIAQfsmb3d14YQWtBU
         77nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHbOXnY8o7rTAT8DVu9lCYSozb8GmEwnDOfzCyO8zXI=;
        b=AVNsDFJ0BVYJcbsOYE5tsHxU+JbnClHPJrccSTAYKyH60yMCBeUnsrvBg3rJSHdwT1
         e2QBFLVfd2r5MayyA+FYS3cOXiU9Ixf6Ff2fZcDgMUCQMUkYwXX9gBrtutWgGb5Em1D8
         4IT3NgSFsnnPVcqs0OaMLqxEfDTrDUnNDL26qELmDD2WFvhA/q9orZT0gz869jwE4SaC
         XlDbJMS2X2BmMNb0vv865xyJdLzfu5YvyVPbnwn19PqE1MqlavmNgyh31WZ7HVONsyjn
         pl/GKbWQgQaYoy0n6UtjPsuWJ5y8aTjBSPsRIt3r/nP7RJQVmpW8teoh+BHsC7GOvoXc
         /hmg==
X-Gm-Message-State: ACrzQf2aY68/AeYTUBrq//HHhBv+1KYX85Zy+7X0LyzaHcyyTGWS18sv
        IhOxPo7/6PvfGeypNLrur0E=
X-Google-Smtp-Source: AMsMyM4VQ/PORrv/rf3RAQIWQ7oGCDA63B06T9kBdhBdalE3bSA3c+qwicHgxaHZ20Cncu/v/E60tQ==
X-Received: by 2002:a05:6808:2c7:b0:35a:35b:9171 with SMTP id a7-20020a05680802c700b0035a035b9171mr7408202oid.200.1667334229992;
        Tue, 01 Nov 2022 13:23:49 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-e052-4710-92ba-8142.res6.spectrum.com. [2603:8081:140c:1a00:e052:4710:92ba:8142])
        by smtp.googlemail.com with ESMTPSA id d22-20020a056830045600b0066210467fb1sm4337493otc.41.2022.11.01.13.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:23:49 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 03/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_cq in rxe_cq.c
Date:   Tue,  1 Nov 2022 15:22:28 -0500
Message-Id: <20221101202238.32836-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101202238.32836-1-rpearsonhpe@gmail.com>
References: <20221101202238.32836-1-rpearsonhpe@gmail.com>
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

Replace calls to pr_err/warn() in rxe_cq.c with rxe_dbg/_cq().

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

