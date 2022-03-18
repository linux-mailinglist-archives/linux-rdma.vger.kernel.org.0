Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FED4DD2A4
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 02:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiCRB5B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 21:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiCRB47 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 21:56:59 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E117024371F
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:36 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso4782873otj.0
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/XVrqL1j/fKwDAY2wInSzzWzgO8c6dYaexgt/1KeDA=;
        b=AM06jl0kMvxtLaPx2IUYL52JiYPZt7LkFzsP7h/VdcSV6d3DYPZVl0BCEDcfnUb0H+
         x7sZS0AbQlEbZG7Y6Y5za4B21FnEajM3Yv/v9OSKyMqoS2v05LDLdkIAioSFTogLICj3
         ofZCQcxBEAD5X8fNyDFfsQhZW7IF3/QKkXpUtsO/3KlVOpNnytFM1v1hZJ4+qxEoj8sX
         vFCLIOVwZjq39xhklgvdnyvDSxHkXykCyo2dTe48SPuPy978NgwKZoNhv9GDzP9hGnbL
         9H61UHuwrPiTL3SaSYc0ggS6xO5KYrc+cZ6z6F59lKQ+i32el9SwrefbBKqIHC16eaRy
         FWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/XVrqL1j/fKwDAY2wInSzzWzgO8c6dYaexgt/1KeDA=;
        b=2SYRQiYYxyDZ3VjOfD1bWWBlCT8xWpoZP9BRCX5ThkdcZupqX+NOY1j5bFqRWCX//U
         ewXSvYa7w5+t1vJcjiDb+/9LH6GUE2VELW1Hx7I7Q1gIzLVAuuRXODC8dlIxZVqTLCaW
         lfM5lS5+DcCJSMqhSADTM/mXt5kAdfEHvHZ76nrKA2H50vawKpn7pacBl6QxlBXvNolN
         UlWOuvSUnssvlceG+OcE58mhpjYwtKwrvEuB3pnbUaA49VWIq3v/32MVjh73BawxdiVt
         7Yvzt3X0qqASst26PhNwRDVVHLX8LvCRdR/gfMtSZpQBlclKRxTv6/VIePpOQzlziyA9
         ndkw==
X-Gm-Message-State: AOAM530kRAE56sU21L19BnOGAWfuiNXAo63ec14xvRZagtosi3y2MMDE
        232ixHErSS147kzUzRVqQIU=
X-Google-Smtp-Source: ABdhPJxe9LbC26+AJyCNGBtz2icSYTQEEZCfJUVA34aP1fDmkyA/etTziXwMyaGkeRXRJd6m8OrZRg==
X-Received: by 2002:a9d:6f07:0:b0:5b2:38e8:41f7 with SMTP id n7-20020a9d6f07000000b005b238e841f7mr2629574otq.308.1647568536330;
        Thu, 17 Mar 2022 18:55:36 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-257e-2cb6-0a79-8c62.res6.spectrum.com. [2603:8081:140c:1a00:257e:2cb6:a79:8c62])
        by smtp.googlemail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm3292878oaf.10.2022.03.17.18.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:55:36 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 10/11] RDMA/rxe: Convert read side locking to rcu
Date:   Thu, 17 Mar 2022 20:55:13 -0500
Message-Id: <20220318015514.231621-11-rpearsonhpe@gmail.com>
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

Use rcu_read_lock() for protecting read side operations in rxe_pool.c.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 6f39f74233d2..a2c74beceeae 100644
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
@@ -242,7 +241,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem)
 		pool->cleanup(elem);
 
 	if (pool->flags & RXE_POOL_ALLOC)
-		kfree(elem->obj);
+		kfree_rcu(elem->obj);
 
 	atomic_dec(&pool->num_elem);
 
-- 
2.32.0

