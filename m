Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F02D2C6EF
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 14:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfE1MrF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 08:47:05 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:47894 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfE1MrF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 08:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559047624; x=1590583624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=22+F5ANbHp/KLwibhmjECQBsniUjE+t/fFbVQXOy2Xo=;
  b=r1mKaI9eN58Ap60Wp5OXNdh4RKwJgk4EoajdOXS0Dq/hZ0H76nKia674
   CjmJjpM9EQ3FHv9KQ5QWSdZwNdy9PGzFwIH07miA5XYLPrvlibCdAuUmc
   l0jUIir8Bx/bP7ON6QbneiZTtK5kl3wgPDdxMXTbbNsjyWdGPFPn9bulI
   8=;
X-IronPort-AV: E=Sophos;i="5.60,523,1549929600"; 
   d="scan'208";a="404005811"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 May 2019 12:47:02 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x4SCkwoE069680
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 28 May 2019 12:47:02 GMT
Received: from EX13D19EUA004.ant.amazon.com (10.43.165.28) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 12:47:01 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUA004.ant.amazon.com (10.43.165.28) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 12:47:00 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.129) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 28 May 2019 12:46:57 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Shiraz Saleem" <shiraz.saleem@intel.com>,
        Firas JahJah <firasj@amazon.com>
Subject: [PATCH for-rc 4/6] RDMA/efa: Use API to get contiguous memory blocks aligned to device supported page size
Date:   Tue, 28 May 2019 15:46:16 +0300
Message-ID: <20190528124618.77918-5-galpress@amazon.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528124618.77918-1-galpress@amazon.com>
References: <20190528124618.77918-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the ib_umem_find_best_pgsz() and rdma_for_each_block() API when
registering an MR instead of coding it in the driver.

ib_umem_find_best_pgsz() is used to find the best suitable page size
which replaces the existing efa_cont_pages() implementation.
rdma_for_each_block() is used to iterate the umem in aligned contiguous
memory blocks.

Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Reviewed-by: Firas JahJah <firasj@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 81 +++++----------------------
 1 file changed, 14 insertions(+), 67 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 0640c2435f67..c1246c39f234 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1054,21 +1054,15 @@ static int umem_to_page_list(struct efa_dev *dev,
 			     u8 hp_shift)
 {
 	u32 pages_in_hp = BIT(hp_shift - PAGE_SHIFT);
-	struct sg_dma_page_iter sg_iter;
-	unsigned int page_idx = 0;
+	struct ib_block_iter biter;
 	unsigned int hp_idx = 0;
 
 	ibdev_dbg(&dev->ibdev, "hp_cnt[%u], pages_in_hp[%u]\n",
 		  hp_cnt, pages_in_hp);
 
-	for_each_sg_dma_page(umem->sg_head.sgl, &sg_iter, umem->nmap, 0) {
-		if (page_idx % pages_in_hp == 0) {
-			page_list[hp_idx] = sg_page_iter_dma_address(&sg_iter);
-			hp_idx++;
-		}
-
-		page_idx++;
-	}
+	rdma_for_each_block(umem->sg_head.sgl, &biter, umem->nmap,
+			    BIT(hp_shift))
+		page_list[hp_idx++] = rdma_block_iter_dma_address(&biter);
 
 	return 0;
 }
@@ -1402,56 +1396,6 @@ static int efa_create_pbl(struct efa_dev *dev,
 	return 0;
 }
 
-static void efa_cont_pages(struct ib_umem *umem, u64 addr,
-			   unsigned long max_page_shift,
-			   int *count, u8 *shift, u32 *ncont)
-{
-	struct scatterlist *sg;
-	u64 base = ~0, p = 0;
-	unsigned long tmp;
-	unsigned long m;
-	u64 len, pfn;
-	int i = 0;
-	int entry;
-
-	addr = addr >> PAGE_SHIFT;
-	tmp = (unsigned long)addr;
-	m = find_first_bit(&tmp, BITS_PER_LONG);
-	if (max_page_shift)
-		m = min_t(unsigned long, max_page_shift - PAGE_SHIFT, m);
-
-	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, entry) {
-		len = DIV_ROUND_UP(sg_dma_len(sg), PAGE_SIZE);
-		pfn = sg_dma_address(sg) >> PAGE_SHIFT;
-		if (base + p != pfn) {
-			/*
-			 * If either the offset or the new
-			 * base are unaligned update m
-			 */
-			tmp = (unsigned long)(pfn | p);
-			if (!IS_ALIGNED(tmp, 1 << m))
-				m = find_first_bit(&tmp, BITS_PER_LONG);
-
-			base = pfn;
-			p = 0;
-		}
-
-		p += len;
-		i += len;
-	}
-
-	if (i) {
-		m = min_t(unsigned long, ilog2(roundup_pow_of_two(i)), m);
-		*ncont = DIV_ROUND_UP(i, (1 << m));
-	} else {
-		m = 0;
-		*ncont = 0;
-	}
-
-	*shift = PAGE_SHIFT + m;
-	*count = i;
-}
-
 struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 			 u64 virt_addr, int access_flags,
 			 struct ib_udata *udata)
@@ -1459,11 +1403,10 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	struct efa_dev *dev = to_edev(ibpd->device);
 	struct efa_com_reg_mr_params params = {};
 	struct efa_com_reg_mr_result result = {};
-	unsigned long max_page_shift;
 	struct pbl_context pbl;
+	unsigned int pg_sz;
 	struct efa_mr *mr;
 	int inline_size;
-	int npages;
 	int err;
 
 	if (udata->inlen &&
@@ -1500,13 +1443,17 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	params.iova = virt_addr;
 	params.mr_length_in_bytes = length;
 	params.permissions = access_flags & 0x1;
-	max_page_shift = fls64(dev->dev_attr.page_size_cap);
 
-	efa_cont_pages(mr->umem, start, max_page_shift, &npages,
-		       &params.page_shift, &params.page_num);
+	pg_sz = ib_umem_find_best_pgsz(mr->umem,
+				       dev->dev_attr.page_size_cap,
+				       virt_addr);
+	params.page_shift = __ffs(pg_sz);
+	params.page_num = DIV_ROUND_UP(length + (start & (pg_sz - 1)),
+				       pg_sz);
+
 	ibdev_dbg(&dev->ibdev,
-		  "start %#llx length %#llx npages %d params.page_shift %u params.page_num %u\n",
-		  start, length, npages, params.page_shift, params.page_num);
+		  "start %#llx length %#llx params.page_shift %u params.page_num %u\n",
+		  start, length, params.page_shift, params.page_num);
 
 	inline_size = ARRAY_SIZE(params.pbl.inline_pbl_array);
 	if (params.page_num <= inline_size) {
-- 
2.21.0

