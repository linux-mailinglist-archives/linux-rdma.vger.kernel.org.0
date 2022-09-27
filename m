Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74B5EBA3B
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 07:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiI0F4Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 01:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiI0F4H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 01:56:07 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50793A61FB;
        Mon, 26 Sep 2022 22:55:26 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="77857527"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="77857527"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 27 Sep 2022 14:54:04 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 171DCD4F5B;
        Tue, 27 Sep 2022 14:54:04 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 53882CFBAE;
        Tue, 27 Sep 2022 14:54:03 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2334E11416F0;
        Tue, 27 Sep 2022 14:54:02 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v5 05/11] RDMA/rxe: Allow registering persistent flag for pmem MR only
Date:   Tue, 27 Sep 2022 13:53:31 +0800
Message-Id: <20220927055337.22630-6-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220927055337.22630-1-lizhijian@fujitsu.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27166.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27166.005
X-TMASE-Result: 10--8.619200-10.000000
X-TMASE-MatchedRID: TXpevnfF2xwrH07ux06QXUXBhxFdFgcQtGonEOW5g+bRjBmBWsa9ROgU
        rKBxousFuVbZ8RRkSPuhSdh91d47Acez6vGnS3H6CtzGvPCy/m4Ea8g1x8eqF6ILsEPieIGYttJ
        z0Nnmewki+t+0AiFaYvL3NxFKQpq1fDPEC/yQgPTOvXpg7ONnXb/I3arxTrvic759besLmmt5bB
        iV7e/VjIb1oRJzA0abgDLqnrRlXrZ8nn9tnqel2DsAVzN+Ov/sXWjKDWViOOJGU9H5Qx3ry7vP9
        dBtdfPM+dULentFltl5eMc+lEROAg==
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

So register a persistent access flag to a non-pmem MR will be rejected.

CC: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V5: make sure the whole MR is pmem
V4: set is_pmem more simple
V2: new scheme check is_pmem # Dan
    update commit message, get rid of confusing ib_check_flush_access_flags() # Tom
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 74a38d06332f..1da3ad5eba64 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -112,6 +112,13 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
 	mr->type = IB_MR_TYPE_DMA;
 }
 
+static bool vaddr_in_pmem(char *vaddr)
+{
+	return REGION_INTERSECTS ==
+	       region_intersects(virt_to_phys(vaddr), 1, IORESOURCE_MEM,
+				 IORES_DESC_PERSISTENT_MEMORY);
+}
+
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr)
 {
@@ -122,6 +129,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 	int			num_buf;
 	void			*vaddr;
 	int err;
+	bool is_pmem = false;
 	int i;
 
 	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
@@ -149,6 +157,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 	num_buf			= 0;
 	map = mr->map;
 	if (length > 0) {
+		is_pmem = true;
 		buf = map[0]->buf;
 
 		for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
@@ -166,6 +175,10 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 				goto err_cleanup_map;
 			}
 
+			/* True only if the *whole* MR is pmem */
+			if (is_pmem)
+				is_pmem = vaddr_in_pmem(vaddr);
+
 			buf->addr = (uintptr_t)vaddr;
 			buf->size = PAGE_SIZE;
 			num_buf++;
@@ -174,6 +187,12 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		}
 	}
 
+	if (!is_pmem && access & IB_ACCESS_FLUSH_PERSISTENT) {
+		pr_warn("Cannot register IB_ACCESS_FLUSH_PERSISTENT for non-pmem memory\n");
+		err = -EINVAL;
+		goto err_release_umem;
+	}
+
 	mr->umem = umem;
 	mr->access = access;
 	mr->offset = ib_umem_offset(umem);
-- 
2.31.1

