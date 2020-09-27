Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA38E279F0D
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Sep 2020 08:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgI0GrK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Sep 2020 02:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730425AbgI0GrH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Sep 2020 02:47:07 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41E7F23A51;
        Sun, 27 Sep 2020 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601189227;
        bh=m2a9Oz2DB63lwgxQQj+FGgp6ecAxvfnEpmZRjOKwjzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nVGrLlOZntNclCIAhTNx9fGbNC5GNHwLw0vsJ3pyWAOXJ5yl6VMNyH/yknQgbJ3vM
         ju+3ChxnMHuEEqqHFg0Ec7IlyLPXiCkmMeknkQRe3eRITITMOQYKPH82iy/Qs41MR7
         dcMILQqHsJCYv5AagArelmJcAJph2HRuIfbF3jVk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>
Subject: [PATCH rdma-next v4 3/4] tools/testing/scatterlist: Show errors in human readable form
Date:   Sun, 27 Sep 2020 09:46:46 +0300
Message-Id: <20200927064647.3106737-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200927064647.3106737-1-leon@kernel.org>
References: <20200927064647.3106737-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Instead of just asserting dump some more useful info about what the test
saw versus what it expected to see.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 tools/testing/scatterlist/main.c | 44 ++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/tools/testing/scatterlist/main.c b/tools/testing/scatterlist/main.c
index 4899359a31ac..b2c7e9f7b8d3 100644
--- a/tools/testing/scatterlist/main.c
+++ b/tools/testing/scatterlist/main.c
@@ -5,6 +5,15 @@

 #define MAX_PAGES (64)

+struct test {
+	int alloc_ret;
+	unsigned num_pages;
+	unsigned *pfn;
+	unsigned size;
+	unsigned int max_seg;
+	unsigned int expected_segments;
+};
+
 static void set_pages(struct page **pages, const unsigned *array, unsigned num)
 {
 	unsigned int i;
@@ -17,17 +26,32 @@ static void set_pages(struct page **pages, const unsigned *array, unsigned num)

 #define pfn(...) (unsigned []){ __VA_ARGS__ }

+static void fail(struct test *test, struct sg_table *st, const char *cond)
+{
+	unsigned int i;
+
+	fprintf(stderr, "Failed on '%s'!\n\n", cond);
+
+	printf("size = %u, max segment = %u, expected nents = %u\nst->nents = %u, st->orig_nents= %u\n",
+	       test->size, test->max_seg, test->expected_segments, st->nents,
+	       st->orig_nents);
+
+	printf("%u input PFNs:", test->num_pages);
+	for (i = 0; i < test->num_pages; i++)
+		printf(" %x", test->pfn[i]);
+	printf("\n");
+
+	exit(1);
+}
+
+#define VALIDATE(cond, st, test) \
+	if (!(cond)) \
+		fail((test), (st), #cond);
+
 int main(void)
 {
 	const unsigned int sgmax = SCATTERLIST_MAX_SEGMENT;
-	struct test {
-		int alloc_ret;
-		unsigned num_pages;
-		unsigned *pfn;
-		unsigned size;
-		unsigned int max_seg;
-		unsigned int expected_segments;
-	} *test, tests[] = {
+	struct test *test, tests[] = {
 		{ -EINVAL, 1, pfn(0), PAGE_SIZE, PAGE_SIZE + 1, 1 },
 		{ -EINVAL, 1, pfn(0), PAGE_SIZE, 0, 1 },
 		{ -EINVAL, 1, pfn(0), PAGE_SIZE, sgmax + 1, 1 },
@@ -66,8 +90,8 @@ int main(void)
 		if (test->alloc_ret)
 			continue;

-		assert(st.nents == test->expected_segments);
-		assert(st.orig_nents == test->expected_segments);
+		VALIDATE(st.nents == test->expected_segments, &st, test);
+		VALIDATE(st.orig_nents == test->expected_segments, &st, test);

 		sg_free_table(&st);
 	}
--
2.26.2

