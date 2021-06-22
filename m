Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6EE3B02F2
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 13:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhFVLmI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 07:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhFVLmI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 07:42:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 750E66113E;
        Tue, 22 Jun 2021 11:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624361993;
        bh=3W16h0Qhvidbw6bBtrkPf3V2LDrQFbXK3ZE6M+o2jOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rfc/F5TBRNTKAoATf93E9W730OpZcO0Vcvp1KYsN1JtF7juOfFzQyw0EmbpSOKItU
         B5O3bLpwVJqdDJt5uCt/PXtg2WC0SCk1Gd6mkq3xZ25JU38BXhQf05nrlQLJDLuQeL
         bD5Pw7PhVo2uRS+JUCBktqWWTOEhx42kJDH21FN6gns+kJu4950jplW85VQiglhqi5
         Onnavozn/ceSZ46yX8nHj38tI5sdPzRFIvKqDpm8PpX8tNVfJhilzH6L+nvYAt+KnY
         nWwpV92ZuP+rV0XJ2MZ+EHZny84jQUH3ei8puG28gZd1KpBtvoiTXDfMdySQGikwHL
         Ibt4zcDHF9AaQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Maor Gottlieb <maorg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 1/2] lib/scatterlist: Fix wrong update of orig_nents
Date:   Tue, 22 Jun 2021 14:39:41 +0300
Message-Id: <c592070ca8137d5e0b58b01abce9e14d8bf41fee.1624361199.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624361199.git.leonro@nvidia.com>
References: <cover.1624361199.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

orig_nents should represent the number of entries with pages,
but __sg_alloc_table_from_pages sets orig_nents as the number of
total entries in the table. This is wrong when the API is used for
dynamic allocation where not all the table entries are mapped with
pages. It wasn't observed until now, since RDMA umem who uses this
API in the dynamic form doesn't use orig_nents implicit or explicit
by the scatterlist APIs.

Fix it by:
1. Set orig_nents as number of entries with pages also in
   __sg_alloc_table_from_pages.
2. Add a new field total_nents to reflect the total number of entries
   in the table. This is required for the release flow (sg_free_table).
   This filed should be used internally only by scatterlist.

Fixes: 07da1223ec93 ("lib/scatterlist: Add support in dynamic allocation of SG table from pages")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/scatterlist.h |  8 ++++++--
 lib/scatterlist.c           | 32 ++++++++------------------------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 6f70572b2938..1c889141eb91 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -35,8 +35,12 @@ struct scatterlist {
 
 struct sg_table {
 	struct scatterlist *sgl;	/* the list */
-	unsigned int nents;		/* number of mapped entries */
-	unsigned int orig_nents;	/* original size of list */
+	unsigned int nents;		/* number of DMA mapped entries */
+	unsigned int orig_nents;	/* number of CPU mapped entries */
+	/* The fields below should be used internally only by
+	 * scatterlist implementation.
+	 */
+	unsigned int total_nents;	/* number of total entries in the table */
 };
 
 /*
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index a59778946404..6db70a1e7dd0 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -192,33 +192,26 @@ static void sg_kfree(struct scatterlist *sg, unsigned int nents)
 void __sg_free_table(struct sg_table *table, unsigned int max_ents,
 		     unsigned int nents_first_chunk, sg_free_fn *free_fn)
 {
-	struct scatterlist *sgl, *next;
+	struct scatterlist *sgl, *next = NULL;
 	unsigned curr_max_ents = nents_first_chunk ?: max_ents;
 
 	if (unlikely(!table->sgl))
 		return;
 
 	sgl = table->sgl;
-	while (table->orig_nents) {
-		unsigned int alloc_size = table->orig_nents;
-		unsigned int sg_size;
+	while (table->total_nents) {
+		unsigned int alloc_size = table->total_nents;
 
 		/*
 		 * If we have more than max_ents segments left,
 		 * then assign 'next' to the sg table after the current one.
-		 * sg_size is then one less than alloc size, since the last
-		 * element is the chain pointer.
 		 */
 		if (alloc_size > curr_max_ents) {
 			next = sg_chain_ptr(&sgl[curr_max_ents - 1]);
 			alloc_size = curr_max_ents;
-			sg_size = alloc_size - 1;
-		} else {
-			sg_size = alloc_size;
-			next = NULL;
 		}
 
-		table->orig_nents -= sg_size;
+		table->total_nents -= alloc_size;
 		if (nents_first_chunk)
 			nents_first_chunk = 0;
 		else
@@ -301,20 +294,11 @@ int __sg_alloc_table(struct sg_table *table, unsigned int nents,
 		} else {
 			sg = alloc_fn(alloc_size, gfp_mask);
 		}
-		if (unlikely(!sg)) {
-			/*
-			 * Adjust entry count to reflect that the last
-			 * entry of the previous table won't be used for
-			 * linkage.  Without this, sg_kfree() may get
-			 * confused.
-			 */
-			if (prv)
-				table->nents = ++table->orig_nents;
-
+		if (unlikely(!sg))
 			return -ENOMEM;
-		}
 
 		sg_init_table(sg, alloc_size);
+		table->total_nents += alloc_size;
 		table->nents = table->orig_nents += sg_size;
 
 		/*
@@ -385,12 +369,11 @@ static struct scatterlist *get_next_sg(struct sg_table *table,
 	if (!new_sg)
 		return ERR_PTR(-ENOMEM);
 	sg_init_table(new_sg, alloc_size);
+	table->total_nents += alloc_size;
 	if (cur) {
 		__sg_chain(next_sg, new_sg);
-		table->orig_nents += alloc_size - 1;
 	} else {
 		table->sgl = new_sg;
-		table->orig_nents = alloc_size;
 		table->nents = 0;
 	}
 	return new_sg;
@@ -515,6 +498,7 @@ struct scatterlist *__sg_alloc_table_from_pages(struct sg_table *sgt,
 		cur_page = j;
 	}
 	sgt->nents += added_nents;
+	sgt->orig_nents = sgt->nents;
 out:
 	if (!left_pages)
 		sg_mark_end(s);
-- 
2.31.1

