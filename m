Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4D7466D99
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Dec 2021 00:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbhLBXZC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 18:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349398AbhLBXY6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 18:24:58 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AF8C06175A
        for <linux-rdma@vger.kernel.org>; Thu,  2 Dec 2021 15:21:34 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id r18-20020a4a7252000000b002c5f52d1834so458055ooe.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 Dec 2021 15:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uwbuD++AdKb6OgZGQhl5akKy/OaaklSk5QsxCYgnG4I=;
        b=BwZtWvPTkZrNqFD1x2cmpZCqB3xz3B3zN5EiGuzmljMSEf9D0EwBUGq6XxiF8tShXB
         bdnOYtH1xXAbv3gF6vTVxgJiIRtbF7q7zDHN4guwEHtYXd9Ur5RXEf/rCMRuBubxaTWi
         wVZXknhniY3nB0npyp6tgrAx2ISKEApGV4LtGk6rqdmlT2sksmxQIJPeY00KyEoC8A+i
         o7UwMj3t8AVYaCxPvfD18ITJDd0HDLdN6U+14tPM4zYutxxNzRAb+BWmhie7IBhTPlcs
         N8aO2ovQJ02WcByLQt4huzZqbHmUqm34yPePKUPbv3EXU3C3xeWFDrSLTOprS8OixVXY
         nw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uwbuD++AdKb6OgZGQhl5akKy/OaaklSk5QsxCYgnG4I=;
        b=Wau+BolG0cyscvG7LH4S6IA4UGVfXfV9sL3vW26upAhWOH/5VJiq7Osb7jxZex/+lQ
         MlXDW/5zNHq61iQOS7LxAnk4lvstkZDVOOfdUxMscyAaU29+Ux7mPPqT31TTS3xqd7yG
         zxICFxOh5oK22ypBLALBnkLOGPczxf8IyT6QYsfawLTghm0gwAUoyc1cgJR9KPzaR9PE
         iEAeEpoXrzTPxqx5V0g2w3C+g0/IZNY1L5hUCbEi/+A4cRXFpaSqILqhnWQDNKBvMsVM
         AlAvtD5W6H9byVNPQW8QJ/SYM8atKityokYm3xiynAeYHpMLm+RXB9Zu2eNFeATCW3Cs
         VO3A==
X-Gm-Message-State: AOAM5314IuecvoLzYmw9f82CD9EECFIRBrCHMqVXL9LUU2aWCI/36Uqj
        N7pDkAYLzaEp5Kf7xnCaubY=
X-Google-Smtp-Source: ABdhPJwrXXaPw7a443Vn8ms8YBB5SEST/mXdKP08VHl/Pb2NFbDYC/zWyxdOpdIJYQ2/qWvBh+hGZA==
X-Received: by 2002:a4a:a88d:: with SMTP id q13mr10301665oom.5.1638487294214;
        Thu, 02 Dec 2021 15:21:34 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-369f-9a20-b320-aa23.res6.spectrum.com. [2603:8081:140c:1a00:369f:9a20:b320:aa23])
        by smtp.googlemail.com with ESMTPSA id g7sm296425oon.27.2021.12.02.15.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:21:33 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v5 for-next 6/8] RDMA/rxe: Minor cleanups in rxe_pool.c,h
Date:   Thu,  2 Dec 2021 17:20:33 -0600
Message-Id: <20211202232035.62299-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211202232035.62299-1-rpearsonhpe@gmail.com>
References: <20211202232035.62299-1-rpearsonhpe@gmail.com>
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
index fea28a48b36b..c00eef344f98 100644
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
@@ -222,7 +218,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 }
 
 /**
- * rxe_pool_get_index - lookup object from index
+ * rxe_pool_get_index() - lookup object from index
  * @pool: the object pool
  * @index: the index of the obkect
  *
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 01f23f57d666..62e9e439c99c 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -46,7 +46,6 @@ struct rxe_pool {
 	int			(*init)(struct rxe_pool_elem *elem);
 	void			(*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags	flags;
-	enum rxe_elem_type	type;
 
 	unsigned int		max_elem;
 	atomic_t		num_elem;
-- 
2.32.0

