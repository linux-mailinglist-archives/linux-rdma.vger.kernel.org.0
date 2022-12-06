Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6B16443E0
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Dec 2022 14:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiLFNC7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Dec 2022 08:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiLFNCU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Dec 2022 08:02:20 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D1595AF;
        Tue,  6 Dec 2022 05:02:18 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="98847116"
X-IronPort-AV: E=Sophos;i="5.96,222,1665414000"; 
   d="scan'208";a="98847116"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 06 Dec 2022 22:02:16 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7DDE5DE50E;
        Tue,  6 Dec 2022 22:02:15 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B4AE4D3617;
        Tue,  6 Dec 2022 22:02:14 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id A2708234090F;
        Tue,  6 Dec 2022 22:02:13 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, tom@talpey.com,
        tomasz.gromadzki@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH 04/10] RDMA/rxe: Allow registering persistent flag for pmem MR only
Date:   Tue,  6 Dec 2022 21:01:55 +0800
Message-Id: <20221206130201.30986-5-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206130201.30986-1-lizhijian@fujitsu.com>
References: <20221206130201.30986-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27306.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27306.007
X-TMASE-Result: 10--9.829400-10.000000
X-TMASE-MatchedRID: 5HHZS01SLJwrH07ux06QXUXBhxFdFgcQtGonEOW5g+bRjBmBWsa9ROgU
        rKBxousFuVbZ8RRkSPuhSdh91d47Acez6vGnS3H6AoNa2r+Edw1F5qVUCGhwT99zZd3pUn7Kpie
        YwslGH4lyZDY+7jsHGuaffHI8kAmiHY/bzRmIaZHfSQNpZkETVFK6+0HOVoSomAzUQV15ItomZX
        uPVZCqh8NUkvwuYWUM3BTxUdcaKkIfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPB5iyGxbD2EkOl2j
        3P/UNbaywCqFC58e28lk8sR0kCfvaUgZdIaXg4f
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Memory region could  support at most 2 flush access flags:
IB_ACCESS_FLUSH_PERSISTENT and IB_ACCESS_FLUSH_GLOBAL

But we only allow user to register persistent flush flags to the pmem MR
where it has the ability of persisting data across power cycles.

So registering a persistent access flag to a non-pmem MR will be rejected.

CC: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V7: pr_debug -> rxe_dbg_mr
V6: Minimize pmem checking side effect # Jason
V5: make sure the whole MR is pmem # Bob
V4: set is_pmem more simple
V2: new scheme check is_pmem # Dan
    update commit message, get rid of confusing ib_check_flush_access_flags() # Tom
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index b7c9ff1ddf0e..81a438e5010a 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -111,6 +111,15 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
 	mr->ibmr.type = IB_MR_TYPE_DMA;
 }
 
+static bool is_pmem_page(struct page *pg)
+{
+	unsigned long paddr = page_to_phys(pg);
+
+	return REGION_INTERSECTS ==
+	       region_intersects(paddr, PAGE_SIZE, IORESOURCE_MEM,
+				 IORES_DESC_PERSISTENT_MEMORY);
+}
+
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr)
 {
@@ -146,16 +155,25 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 	num_buf			= 0;
 	map = mr->map;
 	if (length > 0) {
-		buf = map[0]->buf;
+		bool persistent_access = access & IB_ACCESS_FLUSH_PERSISTENT;
 
+		buf = map[0]->buf;
 		for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
+			struct page *pg = sg_page_iter_page(&sg_iter);
+
+			if (persistent_access && !is_pmem_page(pg)) {
+				rxe_dbg_mr(mr, "Unable to register persistent access to non-pmem device\n");
+				err = -EINVAL;
+				goto err_release_umem;
+			}
+
 			if (num_buf >= RXE_BUF_PER_MAP) {
 				map++;
 				buf = map[0]->buf;
 				num_buf = 0;
 			}
 
-			vaddr = page_address(sg_page_iter_page(&sg_iter));
+			vaddr = page_address(pg);
 			if (!vaddr) {
 				rxe_dbg_mr(mr, "Unable to get virtual address\n");
 				err = -ENOMEM;
-- 
2.31.1

