Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4417B2B34C7
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 13:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgKOMGb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 07:06:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:54426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgKOMGb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Nov 2020 07:06:31 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB4CD222EC;
        Sun, 15 Nov 2020 12:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605441990;
        bh=wVAA0gnVI00HjbKBD3icjWz65zBa/BXcaAoD6DMDhnM=;
        h=From:To:Cc:Subject:Date:From;
        b=qarSCJTi33f1fm6lH9nIkRhVISzHd5aYYtmkc+oxOU05Yw1oxqe8IZOwQm558P1y3
         li06C6Ih04RsEV1i7lqdOnc2rtY/lK9nfRjMxBsVAE3oxx4Oo/usk+aSyGF88CYafK
         vXOIkaPZcoI50Ef45Jf7RVIhoMIOcg62j6OioDHo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] tools/testing/scatterlist: Fix test to compile and run
Date:   Sun, 15 Nov 2020 14:06:23 +0200
Message-Id: <20201115120623.139113-1-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Add missing define of ALIGN_DOWN to make the test build and run.
In addition, __sg_alloc_table_from_pages now support unaligned maximum
segment, so adapt the test result accordingly.

Fixes: 07da1223ec93 ("lib/scatterlist: Add support in dynamic allocation of SG table from pages")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 tools/testing/scatterlist/linux/mm.h | 1 +
 tools/testing/scatterlist/main.c     | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/scatterlist/linux/mm.h b/tools/testing/scatterlist/linux/mm.h
index 6ae907f375d2..f9a12005fcea 100644
--- a/tools/testing/scatterlist/linux/mm.h
+++ b/tools/testing/scatterlist/linux/mm.h
@@ -33,6 +33,7 @@ typedef unsigned long dma_addr_t;
 #define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
 #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 #define ALIGN(x, a)			__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)		__ALIGN_KERNEL((x) - ((a) - 1), (a))

 #define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)

diff --git a/tools/testing/scatterlist/main.c b/tools/testing/scatterlist/main.c
index b2c7e9f7b8d3..f561aed7c657 100644
--- a/tools/testing/scatterlist/main.c
+++ b/tools/testing/scatterlist/main.c
@@ -52,9 +52,9 @@ int main(void)
 {
 	const unsigned int sgmax = SCATTERLIST_MAX_SEGMENT;
 	struct test *test, tests[] = {
-		{ -EINVAL, 1, pfn(0), PAGE_SIZE, PAGE_SIZE + 1, 1 },
 		{ -EINVAL, 1, pfn(0), PAGE_SIZE, 0, 1 },
-		{ -EINVAL, 1, pfn(0), PAGE_SIZE, sgmax + 1, 1 },
+		{ 0, 1, pfn(0), PAGE_SIZE, PAGE_SIZE + 1, 1 },
+		{ 0, 1, pfn(0), PAGE_SIZE, sgmax + 1, 1 },
 		{ 0, 1, pfn(0), PAGE_SIZE, sgmax, 1 },
 		{ 0, 1, pfn(0), 1, sgmax, 1 },
 		{ 0, 2, pfn(0, 1), 2 * PAGE_SIZE, sgmax, 1 },
--
2.28.0

