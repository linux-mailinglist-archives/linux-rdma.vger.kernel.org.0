Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19724F1F28
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Apr 2022 00:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiDDWaM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 18:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239116AbiDDW2X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 18:28:23 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A720451E69
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 14:51:31 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so8127931otj.10
        for <linux-rdma@vger.kernel.org>; Mon, 04 Apr 2022 14:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gGxKJaSNHEDlk3VmEnBxiQ/pB/AHoJYFuCZI7oHQbys=;
        b=DPqmwEIGSB15fBlhTufYBMX5PxkKG7InYh5qcWUmZsc5FQ2LwCpYP44T/JLgelRt32
         DMaAUYGYoVlvK2zVTigIZ0t7zk592pU+XpLEBbZqu+i7aJJrTgSChuK9MFtFBftX1ooV
         /F4uOCNrUoPhWqn6Y2X6Tr+d/5d4RhAbbWYwC2zw0QwQ35Xy0sGwd6aieWl70jMWKEF2
         oWiSCaMmqAIhXlElitXxrh4HI2jaOuYF351Jp49YqIz5Vk1T+PWki1JkNVg/L9ZDdGjW
         jUdyeP+K3/viXGwqgHtdIWmh5glqcU/gdfn1f6T66HCPXedYPt4WA8yAs6KieMNntuTy
         kO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGxKJaSNHEDlk3VmEnBxiQ/pB/AHoJYFuCZI7oHQbys=;
        b=Q3qtTb83Z3wAZhnrXQt6oHRqq+qxKqCIDYBR1NsN94bj4cs7lO0axyj3r2wd4ZVUJm
         +iFyMR9G8pSd9I769uiPqkoeFm2Djh9GeefFL34WkOSjqSIxPbBSfPCPiI/lxSIAn9Fc
         172pRqYKXx+IZqEMohsfWKvjMGoC3HOcQ61tE4rgLfo3cdKCDvPHi41EopTPL3987ZPC
         aeKFctHJLPz7ekSFTELChTFy154e9j1qRCQJcP1NhEefEe4xdPAT+qzYsgRW28BvJZ2U
         GWWCicP+9ezyMKL7NBk5RHOKlXb33+z5NjqSlcFBgnbwQQvScw/HUWFXi2ZZovTxaIyG
         4x3A==
X-Gm-Message-State: AOAM532UbvpywmJA0A56zuBKT20zJetQx8ci+9L4iGr1FtPIaLp3HX+w
        0Ac8hjY+cOkHIBJ6eDqLeHtumtELzss=
X-Google-Smtp-Source: ABdhPJzyLjX+PxUQoR6F1CJBy/A8RBW6amm25V0HMPo97mxjohSI9mu9OcQhRD+xSTzzZFP4gRxRfw==
X-Received: by 2002:a9d:7f04:0:b0:5ce:417:e176 with SMTP id j4-20020a9d7f04000000b005ce0417e176mr123727otq.39.1649109091007;
        Mon, 04 Apr 2022 14:51:31 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-349e-d2a8-b899-a3ee.res6.spectrum.com. [2603:8081:140c:1a00:349e:d2a8:b899:a3ee])
        by smtp.googlemail.com with ESMTPSA id e2-20020a0568301f2200b005cdafdea1d9sm5226441oth.50.2022.04.04.14.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:51:30 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v13 09/10] RDMA/rxe: Convert read side locking to rcu
Date:   Mon,  4 Apr 2022 16:50:59 -0500
Message-Id: <20220404215059.39819-10-rpearsonhpe@gmail.com>
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

Use rcu_read_lock() for protecting read side operations in rxe_pool.c.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 38f435762238..cbe7b05c3b66 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -190,16 +190,15 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
 	struct rxe_pool_elem *elem;
 	struct xarray *xa = &pool->xa;
-	unsigned long flags;
 	void *obj;
 
-	xa_lock_irqsave(xa, flags);
+	rcu_read_lock();
 	elem = xa_load(xa, index);
 	if (elem && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
 	else
 		obj = NULL;
-	xa_unlock_irqrestore(xa, flags);
+	rcu_read_unlock();
 
 	return obj;
 }
@@ -250,7 +249,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem)
 		pool->cleanup(elem);
 
 	if (pool->flags & RXE_POOL_ALLOC)
-		kfree(elem->obj);
+		kfree_rcu(elem->obj);
 
 	atomic_dec(&pool->num_elem);
 
-- 
2.32.0

