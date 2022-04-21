Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBFF5094B8
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 03:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383671AbiDUBoC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 21:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383667AbiDUBoA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 21:44:00 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078219FDC
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:13 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e5e8523fcbso3930171fac.10
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ir1rbhJVm4YOuatC8nTnW07YQS3a/+GpADxu2BBd+7A=;
        b=IhEiJ9cDVDiswMgcsh/b1RY1VOCbfsRVqQZSgSjJRCj/gcUqRq4VeBu1dnmLH7HdGn
         VDd46iZ0s4nyXLfuVoNxuNGswjMW9wZEM8YSPBcRUOJpgeDHYYqNuKIXZ1xSAE1IViWD
         DtGWhCuivYX8rFOa5nsBV7WlXnjh+l5IQwR4I5PvO0eTIni35APdpLgQKBdutkebmYq3
         LcL9b6K7obt+B517t6khXEh+i7meaR67s1wrSwWFxkMXw4v/vyXsocf4aIdsi3kP4Fwm
         0nrNOxBxXJkmqcqH9cIEZepwGns1k1ykbTH/ZqOTJTjH6oR+MjZLbCR/ab39QpYWThwZ
         t4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ir1rbhJVm4YOuatC8nTnW07YQS3a/+GpADxu2BBd+7A=;
        b=xf6AIcf+afW0ERtwVqjdxYgRhZoxEX1otGmLqSBcW8efq0xAyS/4RWpO4S/o4gIrgA
         Mg4aXDqtlXQDzl2vrHive6WVatC4KStDsl5PqPYuRtGwCQYNP3acpzjq4uVGppxgZA9p
         dEgTsqywOwqHvymbQKCehfiPpUuOFGYtAskj6E0EIG+DL5GjxttJLoKiAPbukaiHQmxS
         x8vImmfnc8WQtuNjzVESQdBN728lC4Otlky6EGtb7ANIDgmvERgKuTOP4FVFb0qN5kmz
         P5lw9gqsY3Q0eAMp4bJaUdGPt0YbyJosKvI8p1dlEm4newEmruGl5g5HBklc0MavZVhw
         g6vw==
X-Gm-Message-State: AOAM532OVuJkuURcS8FaN8vqAWjGtHuyRp6ZYb+jTKSWvYbwQ96G6izD
        CnBDaQOwAUwjxN825IrI+9EJNgajEcs=
X-Google-Smtp-Source: ABdhPJzISNOEq0rQ/TCbZoHCOD75lRZruLaoUDFG2c3+58Zr53wLBjIFxzteskKDGMYHjPCus8ns0w==
X-Received: by 2002:a05:6870:309:b0:e2:c44c:addf with SMTP id m9-20020a056870030900b000e2c44caddfmr2858442oaf.205.1650505272377;
        Wed, 20 Apr 2022 18:41:12 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-c7f7-b397-372c-b2f0.res6.spectrum.com. [2603:8081:140c:1a00:c7f7:b397:372c:b2f0])
        by smtp.googlemail.com with ESMTPSA id l16-20020a9d6a90000000b0060548d240d4sm4847710otq.74.2022.04.20.18.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:41:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v14 05/10] RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()
Date:   Wed, 20 Apr 2022 20:40:38 -0500
Message-Id: <20220421014042.26985-6-rpearsonhpe@gmail.com>
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

