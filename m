Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD07A4C4F2F
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 20:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiBYT7K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 14:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbiBYT7J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 14:59:09 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288F710BBE3
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:36 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id w3-20020a056830060300b005ad10e3becaso4376705oti.3
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I5T76N7eHiqTZ1HVR2qh4diVYgRLaYUjF3JzzmjGq+M=;
        b=GJS9S0XPOuQrOqz6bIyT7YkQ4N12KI1fLotB/cdh2AewDJWDGdQvNFipCrQe2TsXTC
         IrxBBRXPMyBWPGy2RNNZSgKicy3v3P6lapt1PKRbXYPUvQ8W8HPjfrs2cBqKud2fk6zd
         1gFKteSHOT7oDinyE1DL/vZHniZuUXR/DvgRau5hV0xEQii1f2wkGKJDc6yrNsnsJP/v
         HkyB1LizmXzbFenppGwF5dFKkQVGpEwKD2N7wIYAxDu5pKfcHJUCXKBy7B8RWGbuf22B
         xPGAElExp5G0D9BUltEzOn2noXqFRklhUjveqJvIk1l4oYEN2M8AHmY6fBoGcJRLCLyO
         zRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I5T76N7eHiqTZ1HVR2qh4diVYgRLaYUjF3JzzmjGq+M=;
        b=5Vdc1C8ujSCkG885DCxBnVVknlILoLEvHoT075V7s5i/0EzuD7nOV7+q0yomOsurhX
         CH1/htRoRfPiFzE4tlWXafjVHOvJGetR/XE/zL3abXzmfEt5/wX2gHxXGVp8hPT5EZW1
         TBhWVixwL8OC8WRo6C7qGHl03pdDMPBcNPj65NiCx3qWsrbAgBmQD9amm/8VxncYeb/5
         12e0SenPnBEPlezzSxcz5m+KugjIFUNn/J+3Tzs2/KCYcSGxNA4dOCINpd5PBxbqWh35
         zA+u3OyLaEzaap04hkE7NKTFWnBvVzlkKIVM0h2y1UvYxkegIdlNRd0HxMoeVts69XoC
         //lw==
X-Gm-Message-State: AOAM533t0p/nNg73do0elVVL9tOSKCTBhi5uonPSNyYEipe/Fjm0Yeib
        uh/W6/ShvoCEa+0dMbpOXIF9qi6PSac=
X-Google-Smtp-Source: ABdhPJzyo8aTmtrcyVIXUq2XHHQwrwTqyw/wD9WHiCodITN4cclUZhhloIngNBpRKlOPUCe7QuNgjg==
X-Received: by 2002:a05:6830:44a8:b0:5af:1534:4c85 with SMTP id r40-20020a05683044a800b005af15344c85mr1386549otv.92.1645819115557;
        Fri, 25 Feb 2022 11:58:35 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-bf76-707d-f6ed-c81c.res6.spectrum.com. [2603:8081:140c:1a00:bf76:707d:f6ed:c81c])
        by smtp.googlemail.com with ESMTPSA id e28-20020a0568301e5c00b005af640ec226sm1578424otj.56.2022.02.25.11.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:58:35 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 09/11] RDMA/rxe: Convert read side locking to rcu
Date:   Fri, 25 Feb 2022 13:57:49 -0600
Message-Id: <20220225195750.37802-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225195750.37802-1-rpearsonhpe@gmail.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_pool.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 1d1e10290991..713df1ce2bbc 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -202,16 +202,15 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
 	struct rxe_pool_elem *elem;
-	unsigned long flags;
 	void *obj;
 
-	spin_lock_irqsave(&pool->xa.xa_lock, flags);
+	rcu_read_lock();
 	elem = xa_load(&pool->xa, index);
 	if (elem && elem->enabled && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
 	else
 		obj = NULL;
-	spin_unlock_irqrestore(&pool->xa.xa_lock, flags);
+	rcu_read_unlock();
 
 	return obj;
 }
@@ -259,13 +258,18 @@ int __rxe_drop_ref(struct rxe_pool_elem *elem)
 			&pool->xa.xa_lock);
 }
 
-
 int __rxe_drop_wait(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	static int timeout = RXE_POOL_TIMEOUT;
 	int ret;
 
+	if (elem->enabled) {
+		pr_warn_once("%s#%d: should be disabled by now\n",
+			     elem->pool->name + 4, elem->index);
+		elem->enabled = false;
+	}
+
 	__rxe_drop_ref(elem);
 
 	if (timeout) {
@@ -284,6 +288,7 @@ int __rxe_drop_wait(struct rxe_pool_elem *elem)
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
+	/* if we reach here it is safe to free the object */
 	if (pool->flags & RXE_POOL_ALLOC)
 		kfree(elem->obj);
 
-- 
2.32.0

