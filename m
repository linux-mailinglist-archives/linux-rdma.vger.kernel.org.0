Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1533546F3C1
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 20:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhLITTQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 14:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhLITTQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 14:19:16 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9A4C0617A1
        for <linux-rdma@vger.kernel.org>; Thu,  9 Dec 2021 11:15:42 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso7287147otr.2
        for <linux-rdma@vger.kernel.org>; Thu, 09 Dec 2021 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pnhpBnnL8EnWJb0jnNNV3t4uL86CCRWH9yVOJizw9n8=;
        b=oYmmhXWZgrJ8ehe2hiw478Yk6coqeRd1qtpqhRkJMr1jveSnaGtmMRx42RVCKPsfIG
         5Chu3a9X8X1mM5hb1wmTnz3zmidTcpldC/EOIbGZ6syTJtaXDqlrTGiqAPfINkvwXLKU
         5A8QmDPoRb+6wa/tj6Zv/wQMlROz2lPfutRVnzTBLK0MW1S5KVLhzlvnNhT+88VE7Phd
         APYfYmINmA39oar8YAc7f6wLLd6bAp1Bq/hagCYfOd1m6EM5oifC5XshFcQpeevqQfr6
         sJ9jRBBDynXsz1xh2fA3uqnstWWTBkJcAHvSwrh0couGsyYDQ4RX8V17bCChyBxdzTwV
         ynNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pnhpBnnL8EnWJb0jnNNV3t4uL86CCRWH9yVOJizw9n8=;
        b=wG+QpqWCR2SQdlu8IREFg+3JmYCdro/LblK5iO69j4Ilh+oFTR9nTYiHLiFZByttqu
         QlzJFb8s0QfTWX4ClWjQHWPMKngiThv42jHXUc5eqx/Q9ToRjfoeB+4K5PlZ7afDTDEG
         m44k/q0Fy6IutB08QzFoMYqskft9ht3ZmoI9EXoeH1a6mlaNzwKqxohdQ5q2leWr1gzP
         6rIW8r8Id8g9OoceagrXgG/CdJ7Kl5hmNEKPtL0KfJNU4O5H4PclM6gL1FkoU3MZyQD8
         IUoiI97G+Ck10fiu8pskiZkKF+dPrlrtakAbGUZ6gGxYWVL0VLcBlsyxiPEr/u+KdHJu
         U6gA==
X-Gm-Message-State: AOAM5339x4Qk3iWc/Cav/rMdgKc7oE7ZMTDCF4SG0+wa6czjq7AA1wgp
        85HkzmmjC8LYNWjsK5g3ne0SvSiBZ+k=
X-Google-Smtp-Source: ABdhPJzd5yjsc4M7RYA+yMMVj17oDB+eVDuLEYAFNcoXC/N59Mc8nV4L7gXAandCAppBcIhO84wnmw==
X-Received: by 2002:a9d:7ccb:: with SMTP id r11mr7218613otn.122.1639077341781;
        Thu, 09 Dec 2021 11:15:41 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-9c23-089d-4ab2-4477.res6.spectrum.com. [2603:8081:140c:1a00:9c23:89d:4ab2:4477])
        by smtp.googlemail.com with ESMTPSA id h3sm117807oon.34.2021.12.09.11.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:15:41 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v7 6/8] RDMA/rxe: Minor cleanups in rxe_pool.c/rxe_pool.h
Date:   Thu,  9 Dec 2021 13:14:25 -0600
Message-Id: <20211209191426.15596-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211209191426.15596-1-rpearsonhpe@gmail.com>
References: <20211209191426.15596-1-rpearsonhpe@gmail.com>
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
index 1349223bbab4..4998f206adf4 100644
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

