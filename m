Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4271B72CAA4
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 17:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjFLPv3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 11:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjFLPv2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 11:51:28 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FF6CA
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 08:51:23 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-55b77d50465so1178533eaf.0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 08:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686585082; x=1689177082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8oYnKHnROGc5yTaBpBK9rix0xb4DOATklSUAVlGyhEc=;
        b=B9cL/+FQUyHLdy9kmMx/txfmQucJG18XsCozsGylrvkvNLaHPM0LOS6q5qm9l1h4Yr
         hqk+dq69OnplqTLee7ynXPbDdYls/LllWuhxhYQh4p/PobF3eBihlJlPn9yIRJcGmxSo
         0ISOvIYuBQwXfh+eda3tfxWI18mC7b/wVdS1CRxEL0uM5zskJYi9FnBtMQG+EyRDZsHL
         fziyP37VLfWzuSDtbC5p72Qc1Ha9RhnXdAT2wOeLywStXh2S5usyo0kZgh8soTrwX9k+
         MpKWN4vwRaIBYDdI6CX9ZYnjbELFiHpfjflmUDFgEsFXfjSF6m957B7Dbcbn5T96zHTq
         Z/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686585082; x=1689177082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oYnKHnROGc5yTaBpBK9rix0xb4DOATklSUAVlGyhEc=;
        b=HxYsQmwZYUm9ZXd3AZVwSiskmkot1MZ7UKuIRhIwqvb7ttIhqmbfH9TEdio39+79Ny
         LVqxWvT2FUgD8DSFkxZSKkvQxPS4fVoATzUgaUQCEH79mo2wPieBbR13N7LcjQQkBB97
         iluyXsKvfkbq+OpwRF4JemV6tmLMsUEPYcCdWIu82SNRuqbx9pOUj/7Hbmm/8JIA281C
         vr90FlwzGIP42+05XQ1qZIAEO9HiYXvuXEC1qkaZvkdC3Tlvge540t6EXmiCZGwgELiZ
         +lJQvI8AxEHiWQpE8ZC4DuKu3E+2mT5KrK3FEekW3qYWJownROyYEHsTAmD+Cuguor6I
         2EQA==
X-Gm-Message-State: AC+VfDxHtUtT1DH8qco5DFHhDADMQZdf37x4UkdhLEB3J7wTd0E+vtE9
        Xg1HEOwjCzMX3DO5EwzeLpA=
X-Google-Smtp-Source: ACHHUZ4voGjms1mG1J7ooeVrApTWd7oWaT8M8+yu8VtfXXC/PBRavHLW5NfrNQuOE/gAvBV6scbkqg==
X-Received: by 2002:aca:de84:0:b0:38e:ca21:db29 with SMTP id v126-20020acade84000000b0038eca21db29mr4208633oig.27.1686585082459;
        Mon, 12 Jun 2023 08:51:22 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a8bb-e9da-af00-e223.res6.spectrum.com. [2603:8081:140c:1a00:a8bb:e9da:af00:e223])
        by smtp.gmail.com with ESMTPSA id n205-20020acaefd6000000b0039cea510638sm382885oih.21.2023.06.12.08.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:51:21 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix rxe_cq_post
Date:   Mon, 12 Jun 2023 10:50:33 -0500
Message-Id: <20230612155032.17036-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
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

A recent patch replaced a tasklet execution of cq->comp_handler
by a direct call. While this made sense it let changes to cq->notify
state be unprotected and assumed that the cq completion machinery
and the ulp done callbacks were reentrant. The result is that in
some cases completion events can be lost. This patch moves the
cq->comp_handler call inside of the spinlock in rxe_cq_post which
solves both issues. This is compatible with the matching code in
the request notify verb.

Fixes: 78b26a335310 ("RDMA/rxe: Remove tasklet call from rxe_cq.c")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 20ff0c0c4605..6ca2a05b6a2a 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -113,8 +113,6 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 
 	queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
 
-	spin_unlock_irqrestore(&cq->cq_lock, flags);
-
 	if ((cq->notify == IB_CQ_NEXT_COMP) ||
 	    (cq->notify == IB_CQ_SOLICITED && solicited)) {
 		cq->notify = 0;
@@ -122,6 +120,8 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 	}
 
+	spin_unlock_irqrestore(&cq->cq_lock, flags);
+
 	return 0;
 }
 

base-commit: 830f93f47068b1632cc127871fbf27e918efdf46
-- 
2.39.2

