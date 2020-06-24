Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19886207192
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 12:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388985AbgFXKyp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 06:54:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbgFXKyp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jun 2020 06:54:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B31DE2084D;
        Wed, 24 Jun 2020 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592996084;
        bh=XYpIqFF9X3x5HTziqBx/4GtLO15CnQxtnGvsFR+fiHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w9+i/wRT6HScbj881AQi4FsuPiDJdov7AVSq7ViZIoSwZjwltgy+GPAzafi900nYl
         BgdQ1STDtwDbNLu5yKngML9Otkr4ZotZY6ARLzi6YiJuJKYdT1HerMXcWlhGaQSgiH
         LDKwjrXxWu6A4/a4euSBuXvN6V3m7K8KPcDix2So=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 4/5] RDMA/core: Delete not-used create RWQ table function
Date:   Wed, 24 Jun 2020 13:54:21 +0300
Message-Id: <20200624105422.1452290-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624105422.1452290-1-leon@kernel.org>
References: <20200624105422.1452290-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The RWQ table is used for RSS uverbs and not in used for the kernel
consumers, delete ib_create_rwq_ind_table() routine that is not
called at all.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/verbs.c | 39 ---------------------------------
 include/rdma/ib_verbs.h         |  3 ---
 2 files changed, 42 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 6a2becd624c3..65c9118a931c 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2412,45 +2412,6 @@ int ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 }
 EXPORT_SYMBOL(ib_modify_wq);
 
-/*
- * ib_create_rwq_ind_table - Creates a RQ Indirection Table.
- * @device: The device on which to create the rwq indirection table.
- * @ib_rwq_ind_table_init_attr: A list of initial attributes required to
- * create the Indirection Table.
- *
- * Note: The life time of ib_rwq_ind_table_init_attr->ind_tbl is not less
- *	than the created ib_rwq_ind_table object and the caller is responsible
- *	for its memory allocation/free.
- */
-struct ib_rwq_ind_table *ib_create_rwq_ind_table(struct ib_device *device,
-						 struct ib_rwq_ind_table_init_attr *init_attr)
-{
-	struct ib_rwq_ind_table *rwq_ind_table;
-	int i;
-	u32 table_size;
-
-	if (!device->ops.create_rwq_ind_table)
-		return ERR_PTR(-EOPNOTSUPP);
-
-	table_size = (1 << init_attr->log_ind_tbl_size);
-	rwq_ind_table = device->ops.create_rwq_ind_table(device,
-							 init_attr, NULL);
-	if (IS_ERR(rwq_ind_table))
-		return rwq_ind_table;
-
-	rwq_ind_table->ind_tbl = init_attr->ind_tbl;
-	rwq_ind_table->log_ind_tbl_size = init_attr->log_ind_tbl_size;
-	rwq_ind_table->device = device;
-	rwq_ind_table->uobject = NULL;
-	atomic_set(&rwq_ind_table->usecnt, 0);
-
-	for (i = 0; i < table_size; i++)
-		atomic_inc(&rwq_ind_table->ind_tbl[i]->usecnt);
-
-	return rwq_ind_table;
-}
-EXPORT_SYMBOL(ib_create_rwq_ind_table);
-
 /*
  * ib_destroy_rwq_ind_table - Destroys the specified Indirection Table.
  * @wq_ind_table: The Indirection Table to destroy.
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index f1a5c89466aa..6e2cb69fe90b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4430,9 +4430,6 @@ struct ib_wq *ib_create_wq(struct ib_pd *pd,
 int ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
 int ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *attr,
 		 u32 wq_attr_mask);
-struct ib_rwq_ind_table *ib_create_rwq_ind_table(struct ib_device *device,
-						 struct ib_rwq_ind_table_init_attr*
-						 wq_ind_table_init_attr);
 int ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table);
 
 int ib_map_mr_sg(struct ib_mr *mr, struct scatterlist *sg, int sg_nents,
-- 
2.26.2

