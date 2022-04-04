Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1084F1F25
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Apr 2022 00:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243039AbiDDW3g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 18:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245434AbiDDW2V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 18:28:21 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D1051E56
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 14:51:28 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t21so11469191oie.11
        for <linux-rdma@vger.kernel.org>; Mon, 04 Apr 2022 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ir1rbhJVm4YOuatC8nTnW07YQS3a/+GpADxu2BBd+7A=;
        b=mTm9DC73zrc9+qnJe02afFnnOl6MCGSh3IWWvLG5tsd/KyTy8Vu3zNxuTE/tq7fWQ5
         yDh++N7VQCVYLXwFuXcWvw3DRwHJQIuojiOVv2Lm36P9D9VBP+U1qBM/1dS6eaWKg60b
         Q2IGDxBaUA1wOfiCffj4beikFlZNuFvcnvf9e76p0r8vll9SE1Vs8D/Ac9OAvogoRSuj
         RSAnvZxgFCyFSVSgSSCSWYEvZ0p1nQjt+EyOUtiyxFSoUGZo/U9khtS1SMclyY0SzfKR
         HO/VUbv+WYAJudxZayhFqMJ5pb2jB+pDYZFp2Cjb7vm76q8webyWKLVjAa9plnZBc8hp
         jKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ir1rbhJVm4YOuatC8nTnW07YQS3a/+GpADxu2BBd+7A=;
        b=MdgdyDJ0mCh0YPKS5vLCM5eiu+uRCGOtDf3B2rSD+Ywf0vesVn4tYAbQw6AttXrIpT
         mX0om3f8BbLGbPPvlCCX9sUwBYBvQsp7+spUnsn9dAKlrzK7SrvfcVWU0Ir+BxJ4DMxa
         exih5nLeahaixl4/dc2EZGxggJQcklp1fZljyWCSYAoYQzmeoQN4wrbBQ68jYsgncUN+
         Q6NN8te1spIop+toGPfJGbOmdtJ7KzmLiSou2vYaDiTloLlB0dBvQo+BTbwz8MSbRB76
         /6cyPG4HHRcxYeN9Y27GW/oi26Yyf5FPUmLPKCke5HaK2fvj9/LaAuzzv/ni6S4qgR39
         uxmA==
X-Gm-Message-State: AOAM5313h4U7NanO2dLfiCBNgPBIA/ggpIYbLpfvQ4Ze0LEyZ/mpXsvX
        BkVWrfaSJfNJrlGym12iSBVGePeMYCU=
X-Google-Smtp-Source: ABdhPJwPQ2bprDhQhp2WrXtZX9iE+cdQCrvLzFdpSMEyxT0sdskEcouw/HkG6VSkocCkD0yH3aryrg==
X-Received: by 2002:a05:6808:13d4:b0:2ce:2801:d7bb with SMTP id d20-20020a05680813d400b002ce2801d7bbmr166716oiw.44.1649109088003;
        Mon, 04 Apr 2022 14:51:28 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-349e-d2a8-b899-a3ee.res6.spectrum.com. [2603:8081:140c:1a00:349e:d2a8:b899:a3ee])
        by smtp.googlemail.com with ESMTPSA id e2-20020a0568301f2200b005cdafdea1d9sm5226441oth.50.2022.04.04.14.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:51:27 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v13 05/10] RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()
Date:   Mon,  4 Apr 2022 16:50:55 -0500
Message-Id: <20220404215059.39819-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404215059.39819-1-rpearsonhpe@gmail.com>
References: <20220404215059.39819-1-rpearsonhpe@gmail.com>
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

Move the code which tears down an mr to rxe_mr_cleanup to allow
operations holding a reference to the mr to complete.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 60a31b718774..fc3942e04a1f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -683,14 +683,10 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
 
-	if (atomic_read(&mr->num_mw) > 0) {
-		pr_warn("%s: Attempt to deregister an MR while bound to MWs\n",
-			__func__);
+	/* See IBA 10.6.7.2.6 */
+	if (atomic_read(&mr->num_mw) > 0)
 		return -EINVAL;
-	}
 
-	mr->state = RXE_MR_STATE_INVALID;
-	rxe_put(mr_pd(mr));
 	rxe_put(mr);
 
 	return 0;
@@ -700,6 +696,8 @@ void rxe_mr_cleanup(struct rxe_pool_elem *elem)
 {
 	struct rxe_mr *mr = container_of(elem, typeof(*mr), elem);
 
+	rxe_put(mr_pd(mr));
+
 	ib_umem_release(mr->umem);
 
 	if (mr->cur_map_set)
-- 
2.32.0

