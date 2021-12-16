Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E632C4780AC
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Dec 2021 00:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhLPXeE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Dec 2021 18:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhLPXeD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Dec 2021 18:34:03 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8655DC061574
        for <linux-rdma@vger.kernel.org>; Thu, 16 Dec 2021 15:34:03 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so805984otl.3
        for <linux-rdma@vger.kernel.org>; Thu, 16 Dec 2021 15:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHJlHBGQEKLPNB7NU0XNAwaiiI209QcU3LGAPQ9g4f8=;
        b=GEiaiQAtjiZCq+dpw06FDVZDJYhLz3zxsvJDleWlnfeuhwOZQCaA1/HvwvzK1vTS+g
         R0xZoR+Mz9tZFNQPDIrxVRv2EhdC1059gamK7euoptXfCscssQIJdFXBvSKPoGULDnVp
         yvE1Qr6gEKAWoMrvKiWTkD/UeuFU5ibzN61JHtHIPFAJSLd8WUKFh4+Twqvu3F3MZleT
         GLCEUbJ/Cf3pTJ/Arw8UpJoVqeY/s9l7lodEIJanYJUgtZwdAwRqtTxwMOKYFaRz9Q0q
         aFWKO+WMqVpIDDz9HQN/evNMltZNwzoDOzewHEpEgavYyFnOZ59pHwItntMrZeVCdpoV
         eSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHJlHBGQEKLPNB7NU0XNAwaiiI209QcU3LGAPQ9g4f8=;
        b=W8rZRuwWqjVRuxk4lPie/ACru2pdMldj86FsSX0j+m+7Es9oJMWIFlMd8Jd5l+eMvt
         GIkycJAsWmGuQIGRWF83B+tgM93ujGr6Oe+PNt/nQiE1GijYlj0Woj+EO3a3gYOOM9SO
         imnIzsgkiydA3hHIc1ZZ+2IM2FNxqzmspvUJ85UgxJjFrZ33Zo4J9IStDO8U/0mXt+vI
         9ewQRnRZfVGS8cQ2DzBBIqaDneACGz63XLj0M3/u1n9l7kbIrO0g2KpEZBkt71ZHRHqp
         x8w/qcSnhKcpXchwNBG3QvZJanB6Ht9AZht0ZSveG1S9LRXi99D138UdZ6sRMSEVT2SF
         rmDQ==
X-Gm-Message-State: AOAM5308QO7H1G6lGIDuoRfWrnAs+NATZjzyFz/9Xi/JGZWw4PTQ+BmT
        pqsmR8Cxsw6u25X5X3wQcEwYnlKBtNU=
X-Google-Smtp-Source: ABdhPJzbmFm5Kgxxkczl1fonXWlmdaXm+LYAyVn1Rr/SyTytxCha2ieohbZ8GOjmOFjBAQmZSWU1WQ==
X-Received: by 2002:a9d:7dca:: with SMTP id k10mr344918otn.274.1639697642980;
        Thu, 16 Dec 2021 15:34:02 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-ec41-d089-dfdb-6fb5.res6.spectrum.com. [2603:8081:140c:1a00:ec41:d089:dfdb:6fb5])
        by smtp.googlemail.com with ESMTPSA id w19sm1253888oih.44.2021.12.16.15.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:34:02 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v8 6/8] RDMA/rxe: Minor cleanups in rxe_pool.c/rxe_pool.h
Date:   Thu, 16 Dec 2021 17:32:00 -0600
Message-Id: <20211216233201.14893-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216233201.14893-1-rpearsonhpe@gmail.com>
References: <20211216233201.14893-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch includes a couple of minor cleanups in rxe_pool.c and rxe_pool.h

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 10 +++-------
 drivers/infiniband/sw/rxe/rxe_pool.h |  1 -
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index a5ff2fd692c9..dcfbc2b932af 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -97,11 +97,8 @@ static const struct rxe_type_info {
 	},
 };
 
-void rxe_pool_init(
-	struct rxe_dev		*rxe,
-	struct rxe_pool		*pool,
-	enum rxe_elem_type	type,
-	unsigned int		max_elem)
+void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
+		   enum rxe_elem_type type, unsigned int max_elem)
 {
 	const struct rxe_type_info *info = &rxe_type_info[type];
 
@@ -109,7 +106,6 @@ void rxe_pool_init(
 
 	pool->rxe		= rxe;
 	pool->name		= info->name;
-	pool->type		= type;
 	pool->max_elem		= max_elem;
 	pool->elem_size		= ALIGN(info->size, RXE_POOL_ALIGN);
 	pool->elem_offset	= info->elem_offset;
@@ -227,7 +223,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 }
 
 /**
- * rxe_pool_get_index - lookup object from index
+ * rxe_pool_get_index() - lookup object from index
  * @pool: the object pool
  * @index: the index of the object
  *
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 894ffef4d6bd..be3b962d1c78 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -46,7 +46,6 @@ struct rxe_pool {
 	int			(*init)(struct rxe_pool_elem *elem);
 	void			(*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags	flags;
-	enum rxe_elem_type	type;
 	struct list_head	free_list;
 
 	unsigned int		max_elem;
-- 
2.32.0

