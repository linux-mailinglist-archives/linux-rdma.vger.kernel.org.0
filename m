Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA011CA1F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 11:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfLLKCt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 05:02:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:52988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbfLLKCt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 05:02:49 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E680B22527;
        Thu, 12 Dec 2019 10:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576144967;
        bh=4TKUzQ5YemDdKwi52QYKV5oi2+6PhqStWiAWD+eO4RI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2G1gd688GGx0A+3PYgzCS3GfwCsyttao7ruMjmgrofiQI2Bat4AadBnRU0pAZZVl
         RlfoNJ+bMfobt8pyFTWtWwNvaFhmPI1mwc9sNGB+n4Z1aqTd/0SMyJcNplh6PghAJP
         LMPd7X+PaVXVJRMq1eK/VHYjdihkp1k7R+NXujtk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc 1/2] IB/core: Introduce rdma_user_mmap_entry_insert_range() API
Date:   Thu, 12 Dec 2019 12:02:36 +0200
Message-Id: <20191212100237.330654-2-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212100237.330654-1-leon@kernel.org>
References: <20191212100237.330654-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Introduce rdma_user_mmap_entry_insert_range() API to be used once the
required key for the given entry should be in a given range.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/ib_core_uverbs.c | 48 +++++++++++++++++++-----
 include/rdma/ib_verbs.h                  |  5 +++
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
index f509c478b469..b7cb59844ece 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -238,28 +238,32 @@ void rdma_user_mmap_entry_remove(struct rdma_user_mmap_entry *entry)
 EXPORT_SYMBOL(rdma_user_mmap_entry_remove);
 
 /**
- * rdma_user_mmap_entry_insert() - Insert an entry to the mmap_xa
+ * rdma_user_mmap_entry_insert_range() - Insert an entry to the mmap_xa
+ *					 in a given range.
  *
  * @ucontext: associated user context.
  * @entry: the entry to insert into the mmap_xa
  * @length: length of the address that will be mmapped
+ * @min_pgoff: minimum pgoff to be returned
+ * @max_pgoff: maximum pgoff to be returned
  *
  * This function should be called by drivers that use the rdma_user_mmap
  * interface for implementing their mmap syscall A database of mmap offsets is
  * handled in the core and helper functions are provided to insert entries
  * into the database and extract entries when the user calls mmap with the
- * given offset.  The function allocates a unique page offset that should be
- * provided to user, the user will use the offset to retrieve information such
- * as address to be mapped and how.
+ * given offset. The function allocates a unique page offset in a given range
+ * that should be provided to user, the user will use the offset to retrieve
+ * information such as address to be mapped and how.
  *
  * Return: 0 on success and -ENOMEM on failure
  */
-int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
-				struct rdma_user_mmap_entry *entry,
-				size_t length)
+int rdma_user_mmap_entry_insert_range(struct ib_ucontext *ucontext,
+				      struct rdma_user_mmap_entry *entry,
+				      size_t length, u32 min_pgoff,
+				      u32 max_pgoff)
 {
 	struct ib_uverbs_file *ufile = ucontext->ufile;
-	XA_STATE(xas, &ucontext->mmap_xa, 0);
+	XA_STATE(xas, &ucontext->mmap_xa, min_pgoff);
 	u32 xa_first, xa_last, npages;
 	int err;
 	u32 i;
@@ -285,7 +289,7 @@ int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 	entry->npages = npages;
 	while (true) {
 		/* First find an empty index */
-		xas_find_marked(&xas, U32_MAX, XA_FREE_MARK);
+		xas_find_marked(&xas, max_pgoff, XA_FREE_MARK);
 		if (xas.xa_node == XAS_RESTART)
 			goto err_unlock;
 
@@ -332,4 +336,30 @@ int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 	mutex_unlock(&ufile->umap_lock);
 	return -ENOMEM;
 }
+EXPORT_SYMBOL(rdma_user_mmap_entry_insert_range);
+
+/**
+ * rdma_user_mmap_entry_insert() - Insert an entry to the mmap_xa.
+ *
+ * @ucontext: associated user context.
+ * @entry: the entry to insert into the mmap_xa
+ * @length: length of the address that will be mmapped
+ *
+ * This function should be called by drivers that use the rdma_user_mmap
+ * interface for handling user mmapped addresses. The database is handled in
+ * the core and helper functions are provided to insert entries into the
+ * database and extract entries when the user calls mmap with the given offset.
+ * The function allocates a unique page offset that should be provided to user,
+ * the user will use the offset to retrieve information such as address to
+ * be mapped and how.
+ *
+ * Return: 0 on success and -ENOMEM on failure
+ */
+int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
+				struct rdma_user_mmap_entry *entry,
+				size_t length)
+{
+	return rdma_user_mmap_entry_insert_range(ucontext, entry, length, 0,
+						 U32_MAX);
+}
 EXPORT_SYMBOL(rdma_user_mmap_entry_insert);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index cacb48faf670..5608e14e3aad 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2832,6 +2832,11 @@ int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
 int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 				struct rdma_user_mmap_entry *entry,
 				size_t length);
+int rdma_user_mmap_entry_insert_range(struct ib_ucontext *ucontext,
+				      struct rdma_user_mmap_entry *entry,
+				      size_t length, u32 min_pgoff,
+				      u32 max_pgoff);
+
 struct rdma_user_mmap_entry *
 rdma_user_mmap_entry_get_pgoff(struct ib_ucontext *ucontext,
 			       unsigned long pgoff);
-- 
2.20.1

