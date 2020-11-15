Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B30F2B34C8
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 13:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgKOMG5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 07:06:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:54566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgKOMG5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Nov 2020 07:06:57 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A182F222EC;
        Sun, 15 Nov 2020 12:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605442016;
        bh=JRZSjVarsxQLypb7EVnp+PWZDhsMY65mg4XbHGA2k+Q=;
        h=From:To:Cc:Subject:Date:From;
        b=tguqOKgGvSrprCN9WXj80ZC3wBhF7aDfosEzlE8LfConQ4/aUOWONNNyGHJplEEFA
         kz5Taaa/VtU4sYNJN+r2GFA36KcvxXRLCbzNaRkag/B5VDG+kdHa7RJMYYkOARDSao
         g41FQjqfNoUtbZGwSAvsE/6gnE4HQKpgPjx+xE/U=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] tools/testing/scatterlist: Test dynamic __sg_alloc_table_from_pages
Date:   Sun, 15 Nov 2020 14:06:50 +0200
Message-Id: <20201115120650.139277-1-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Add few cases to test the dynamic allocation flow of
__sg_alloc_table_from_pages.

Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 tools/testing/scatterlist/main.c | 64 ++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/tools/testing/scatterlist/main.c b/tools/testing/scatterlist/main.c
index f561aed7c657..2d27e47bbf2f 100644
--- a/tools/testing/scatterlist/main.c
+++ b/tools/testing/scatterlist/main.c
@@ -9,6 +9,7 @@ struct test {
 	int alloc_ret;
 	unsigned num_pages;
 	unsigned *pfn;
+	unsigned *pfn_app;
 	unsigned size;
 	unsigned int max_seg;
 	unsigned int expected_segments;
@@ -52,31 +53,39 @@ int main(void)
 {
 	const unsigned int sgmax = SCATTERLIST_MAX_SEGMENT;
 	struct test *test, tests[] = {
-		{ -EINVAL, 1, pfn(0), PAGE_SIZE, 0, 1 },
-		{ 0, 1, pfn(0), PAGE_SIZE, PAGE_SIZE + 1, 1 },
-		{ 0, 1, pfn(0), PAGE_SIZE, sgmax + 1, 1 },
-		{ 0, 1, pfn(0), PAGE_SIZE, sgmax, 1 },
-		{ 0, 1, pfn(0), 1, sgmax, 1 },
-		{ 0, 2, pfn(0, 1), 2 * PAGE_SIZE, sgmax, 1 },
-		{ 0, 2, pfn(1, 0), 2 * PAGE_SIZE, sgmax, 2 },
-		{ 0, 3, pfn(0, 1, 2), 3 * PAGE_SIZE, sgmax, 1 },
-		{ 0, 3, pfn(0, 2, 1), 3 * PAGE_SIZE, sgmax, 3 },
-		{ 0, 3, pfn(0, 1, 3), 3 * PAGE_SIZE, sgmax, 2 },
-		{ 0, 3, pfn(1, 2, 4), 3 * PAGE_SIZE, sgmax, 2 },
-		{ 0, 3, pfn(1, 3, 4), 3 * PAGE_SIZE, sgmax, 2 },
-		{ 0, 4, pfn(0, 1, 3, 4), 4 * PAGE_SIZE, sgmax, 2 },
-		{ 0, 5, pfn(0, 1, 3, 4, 5), 5 * PAGE_SIZE, sgmax, 2 },
-		{ 0, 5, pfn(0, 1, 3, 4, 6), 5 * PAGE_SIZE, sgmax, 3 },
-		{ 0, 5, pfn(0, 1, 2, 3, 4), 5 * PAGE_SIZE, sgmax, 1 },
-		{ 0, 5, pfn(0, 1, 2, 3, 4), 5 * PAGE_SIZE, 2 * PAGE_SIZE, 3 },
-		{ 0, 6, pfn(0, 1, 2, 3, 4, 5), 6 * PAGE_SIZE, 2 * PAGE_SIZE, 3 },
-		{ 0, 6, pfn(0, 2, 3, 4, 5, 6), 6 * PAGE_SIZE, 2 * PAGE_SIZE, 4 },
-		{ 0, 6, pfn(0, 1, 3, 4, 5, 6), 6 * PAGE_SIZE, 2 * PAGE_SIZE, 3 },
-		{ 0, 0, NULL, 0, 0, 0 },
+		{ -EINVAL, 1, pfn(0), NULL, PAGE_SIZE, 0, 1 },
+		{ 0, 1, pfn(0), NULL, PAGE_SIZE, PAGE_SIZE + 1, 1 },
+		{ 0, 1, pfn(0), NULL, PAGE_SIZE, sgmax + 1, 1 },
+		{ 0, 1, pfn(0), NULL, PAGE_SIZE, sgmax, 1 },
+		{ 0, 1, pfn(0), NULL, 1, sgmax, 1 },
+		{ 0, 2, pfn(0, 1), NULL, 2 * PAGE_SIZE, sgmax, 1 },
+		{ 0, 2, pfn(1, 0), NULL, 2 * PAGE_SIZE, sgmax, 2 },
+		{ 0, 3, pfn(0, 1, 2), NULL, 3 * PAGE_SIZE, sgmax, 1 },
+		{ 0, 3, pfn(0, 1, 2), NULL, 3 * PAGE_SIZE, sgmax, 1 },
+		{ 0, 3, pfn(0, 1, 2), pfn(3, 4, 5), 3 * PAGE_SIZE, sgmax, 1 },
+		{ 0, 3, pfn(0, 1, 2), pfn(4, 5, 6), 3 * PAGE_SIZE, sgmax, 2 },
+		{ 0, 3, pfn(0, 2, 1), NULL, 3 * PAGE_SIZE, sgmax, 3 },
+		{ 0, 3, pfn(0, 1, 3), NULL, 3 * PAGE_SIZE, sgmax, 2 },
+		{ 0, 3, pfn(1, 2, 4), NULL, 3 * PAGE_SIZE, sgmax, 2 },
+		{ 0, 3, pfn(1, 3, 4), NULL, 3 * PAGE_SIZE, sgmax, 2 },
+		{ 0, 4, pfn(0, 1, 3, 4), NULL, 4 * PAGE_SIZE, sgmax, 2 },
+		{ 0, 5, pfn(0, 1, 3, 4, 5), NULL, 5 * PAGE_SIZE, sgmax, 2 },
+		{ 0, 5, pfn(0, 1, 3, 4, 6), NULL, 5 * PAGE_SIZE, sgmax, 3 },
+		{ 0, 5, pfn(0, 1, 2, 3, 4), NULL, 5 * PAGE_SIZE, sgmax, 1 },
+		{ 0, 5, pfn(0, 1, 2, 3, 4), NULL, 5 * PAGE_SIZE, 2 * PAGE_SIZE,
+		  3 },
+		{ 0, 6, pfn(0, 1, 2, 3, 4, 5), NULL, 6 * PAGE_SIZE,
+		  2 * PAGE_SIZE, 3 },
+		{ 0, 6, pfn(0, 2, 3, 4, 5, 6), NULL, 6 * PAGE_SIZE,
+		  2 * PAGE_SIZE, 4 },
+		{ 0, 6, pfn(0, 1, 3, 4, 5, 6), pfn(7, 8, 9, 10, 11, 12),
+		  6 * PAGE_SIZE, 12 * PAGE_SIZE, 2 },
+		{ 0, 0, NULL, NULL, 0, 0, 0 },
 	};
 	unsigned int i;

 	for (i = 0, test = tests; test->expected_segments; test++, i++) {
+		int left_pages = test->pfn_app ? test->num_pages : 0;
 		struct page *pages[MAX_PAGES];
 		struct sg_table st;
 		struct scatterlist *sg;
@@ -84,14 +93,23 @@ int main(void)
 		set_pages(pages, test->pfn, test->num_pages);

 		sg = __sg_alloc_table_from_pages(&st, pages, test->num_pages, 0,
-				test->size, test->max_seg, NULL, 0, GFP_KERNEL);
+				test->size, test->max_seg, NULL, left_pages, GFP_KERNEL);
 		assert(PTR_ERR_OR_ZERO(sg) == test->alloc_ret);

 		if (test->alloc_ret)
 			continue;

+		if (test->pfn_app) {
+			set_pages(pages, test->pfn_app, test->num_pages);
+			sg = __sg_alloc_table_from_pages(&st, pages, test->num_pages, 0,
+					test->size, test->max_seg, sg, 0, GFP_KERNEL);
+
+			assert(PTR_ERR_OR_ZERO(sg) == test->alloc_ret);
+		}
+
 		VALIDATE(st.nents == test->expected_segments, &st, test);
-		VALIDATE(st.orig_nents == test->expected_segments, &st, test);
+		if (!test->pfn_app)
+			VALIDATE(st.orig_nents == test->expected_segments, &st, test);

 		sg_free_table(&st);
 	}
--
2.28.0

