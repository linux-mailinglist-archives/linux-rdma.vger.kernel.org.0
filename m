Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D420643EAC
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfFMPwT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:52:19 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:56543 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731646AbfFMJKj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 05:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560417037; x=1591953037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GDcW2J1LMpTyxzJGeN3EkyOspsCe/3Eiu31KLD6AWa8=;
  b=OyfnipWCB53PR67B85bvRb+Km/FkdhzVeJCMehblXO1Cd28IhUHgGdpR
   vnqjQvt18vQjJEVl4aM+Vz3wljnslt4RnqJK+XiN25u3884YtkRYmamEx
   jNzgFfM5fCLoF3xnmZS6Zu/0AJ952Q4h6M4WWhJxBL4B/j/ItxTzQTptu
   Y=;
X-IronPort-AV: E=Sophos;i="5.62,369,1554768000"; 
   d="scan'208";a="737284746"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 13 Jun 2019 09:10:36 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id B9A21A22DF;
        Thu, 13 Jun 2019 09:10:35 +0000 (UTC)
Received: from EX13D19EUA003.ant.amazon.com (10.43.165.175) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 13 Jun 2019 09:10:35 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUA003.ant.amazon.com (10.43.165.175) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 13 Jun 2019 09:10:34 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.75.47) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 13 Jun 2019 09:10:30 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Firas JahJah" <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        "Shiraz Saleem" <shiraz.saleem@intel.com>
Subject: [PATCH for-next 1/3] RDMA/efa: Use API to get contiguous memory blocks aligned to device supported page size
Date:   Thu, 13 Jun 2019 12:10:12 +0300
Message-ID: <20190613091014.93483-2-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613091014.93483-1-galpress@amazon.com>
References: <20190613091014.93483-1-galpress@amazon.com>
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

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 88 +++++++--------------------
 1 file changed, 21 insertions(+), 67 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 607aff869200..09afb5fbb49f 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1036,21 +1036,15 @@ static int umem_to_page_list(struct efa_dev *dev,
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
@@ -1381,56 +1375,6 @@ static int efa_create_pbl(struct efa_dev *dev,
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
@@ -1438,11 +1382,10 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
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
@@ -1479,13 +1422,24 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	params.iova = virt_addr;
 	params.mr_length_in_bytes = length;
 	params.permissions = access_flags & 0x1;
-	max_page_shift = fls64(dev->dev_attr.page_size_cap);
 
-	efa_cont_pages(mr->umem, start, max_page_shift, &npages,
-		       &params.page_shift, &params.page_num);
+	pg_sz = ib_umem_find_best_pgsz(mr->umem,
+				       dev->dev_attr.page_size_cap,
+				       virt_addr);
+	if (!pg_sz) {
+		err = -EOPNOTSUPP;
+		ibdev_dbg(&dev->ibdev, "Failed to find a suitable page size in page_size_cap %#llx\n",
+			  dev->dev_attr.page_size_cap);
+		goto err_unmap;
+	}
+
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
2.22.0

