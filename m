Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445807EC72F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 16:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjKOP2J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 10:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjKOP2H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 10:28:07 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9060018A
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:28:03 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so10727182a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700062082; x=1700666882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUAK1l/2ByJ754WFSE3HJ7EYyscP+GOYGl/ZbcBVs30=;
        b=VpBNsU5qIpvCS2eBLamXK4Ise2qjdL6k4gY/u+BzO6wZ5sap+cLysC9OG1b45fsQDh
         vthkTaYnxl/P1Dd3AeyyqC12kqjjBsKpASwYNSuZh7HoP/JEwFxjs06eEsj7fLu2Zxct
         lIMsPcBHg6K2VtHSwQxTIazfB3AVZpfwlqmOhrTcUXQiEHwVQkdIHou6JxlD0v9N+dSs
         fD6X04Cj3UjSk8dUiECYteq4OYmRefnnhgKfDIwCqlv++C03w51eH6RtZYFTdeL1CH4D
         bDAnQ58aPWqXKuPxvFJ9+jEDX9tTazxEQguFtQVLTm34xeOK88OB/nerL9shLeS7siNI
         F+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062082; x=1700666882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUAK1l/2ByJ754WFSE3HJ7EYyscP+GOYGl/ZbcBVs30=;
        b=WoeaK5o2RXl1UvPJZdrioqIHml7FbzyjAh4GWJirpiNVJPOaF2KeaUGL0pZIjII85T
         8ykA0UFqoWA1d65T1gVU2GUf7hvHLPxkHnRVrRubN7rqUvu67YM2zKoaLqqIhw2xx1JW
         VB2/h1EXfUMtSfxpptiJRObDZiLJDK/OjbA8S1fO7eWVQaWzSaxhMcJDDMcXUTCNZSqt
         /qfZXbyY6xNqnetOne53imqXJ1wdbytvnvFF8Ptd/RXcoUkWoEKx2bvwiZQrIE2kuiPr
         ajSjiL5shSaSg16Owpo06vc29CCQdkiuBdWTDWSMf37yWHpuWiQhA+lWgLeUHNlh6EYt
         aFIw==
X-Gm-Message-State: AOJu0YxU2hevDS1iF1u6GP3jbzIFHDpyY8iIArfTqypgioZK0bx6xQTx
        4z8mtluXUVn7uWmYmRkW6n0/15YIk3Uyvl6u+q4=
X-Google-Smtp-Source: AGHT+IGavqx6F7s3IrlO1gFVclBLask02NYLaRK2a22rUABoxrooZNbSd3K4RXn8ElBwTur1fn3bhA==
X-Received: by 2002:aa7:df83:0:b0:543:fa0:b4b6 with SMTP id b3-20020aa7df83000000b005430fa0b4b6mr10598177edy.33.1700062081846;
        Wed, 15 Nov 2023 07:28:01 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id u6-20020a056402064600b00542da55a716sm6577349edx.90.2023.11.15.07.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 07:28:01 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Supriti Singh <supriti.singh@ionos.com>,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 9/9] RDMA/rtrs: use %pe to print errors
Date:   Wed, 15 Nov 2023 16:27:49 +0100
Message-Id: <20231115152749.424301-10-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115152749.424301-1-haris.iqbal@ionos.com>
References: <20231115152749.424301-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Supriti Singh <supriti.singh@ionos.com>

While printing error, replace %ld by %pe. %pe prints a string
whereas %ld would print an error code.

Signed-off-by: Supriti Singh <supriti.singh@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 +++---
 drivers/infiniband/ulp/rtrs/rtrs.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 8c5054d18402..493efbba2fe3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1391,9 +1391,9 @@ static int alloc_path_reqs(struct rtrs_clt_path *clt_path)
 				      clt_path->max_pages_per_mr);
 		if (IS_ERR(req->mr)) {
 			err = PTR_ERR(req->mr);
+			pr_err("Failed to alloc clt_path->max_pages_per_mr %d: %pe\n",
+			       clt_path->max_pages_per_mr, req->mr);
 			req->mr = NULL;
-			pr_err("Failed to alloc clt_path->max_pages_per_mr %d\n",
-			       clt_path->max_pages_per_mr);
 			goto out;
 		}
 
@@ -2061,7 +2061,7 @@ static int create_cm(struct rtrs_clt_con *con)
 			       RDMA_PS_IB : RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(cm_id)) {
 		err = PTR_ERR(cm_id);
-		rtrs_err(s, "Failed to create CM ID, err: %d\n", err);
+		rtrs_err(s, "Failed to create CM ID, err: %pe\n", cm_id);
 
 		return err;
 	}
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index d80edfffd2e4..4e17d546d4cc 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -242,8 +242,8 @@ static int create_cq(struct rtrs_con *con, int cq_vector, int nr_cqe,
 		cq = ib_cq_pool_get(cm_id->device, nr_cqe, cq_vector, poll_ctx);
 
 	if (IS_ERR(cq)) {
-		rtrs_err(con->path, "Creating completion queue failed, errno: %ld\n",
-			  PTR_ERR(cq));
+		rtrs_err(con->path, "Creating completion queue failed, errno: %pe\n",
+			  cq);
 		return PTR_ERR(cq);
 	}
 	con->cq = cq;
-- 
2.25.1

