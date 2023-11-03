Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F47B7E0183
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 11:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347549AbjKCJ62 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 05:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347612AbjKCJ61 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 05:58:27 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4119D71;
        Fri,  3 Nov 2023 02:57:55 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="137953603"
X-IronPort-AV: E=Sophos;i="6.03,273,1694703600"; 
   d="scan'208";a="137953603"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 18:56:03 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 31184D9D8F;
        Fri,  3 Nov 2023 18:56:00 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5CBB5D88D6;
        Fri,  3 Nov 2023 18:55:59 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id DB3F4200501B0;
        Fri,  3 Nov 2023 18:55:58 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id 597851A006F;
        Fri,  3 Nov 2023 17:55:58 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, bvanassche@acm.org,
        yi.zhang@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC V2 6/6] RDMA/rxe: Support PAGE_SIZE aligned MR
Date:   Fri,  3 Nov 2023 17:55:49 +0800
Message-ID: <20231103095549.490744-7-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103095549.490744-1-lizhijian@fujitsu.com>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27974.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27974.006
X-TMASE-Result: 10--3.626700-10.000000
X-TMASE-MatchedRID: uf8KE2NGjd9Bt63ZJXZ1oU7nLUqYrlslFIuBIWrdOePfUZT83lbkEFI6
        c0LB6zRTgnKDgRN2gHJJNhitn2ZCFKimPM07Al9SnXdphQTSK/IO4jfa+nI3P5soi2XrUn/Jn6K
        dMrRsL14qtq5d3cxkNUZzh5+urigLQuzJLcC9/jgLiXnACqUA9wm53Cjx6YN5yPyw704COky5J1
        x/8WkKqRoeB7ARQTeWvE7sDZ3+mHhXOEE2otkM4RiKAP5Y7TkhFcUQf3Yp/ridO0/GUi4gFb0fO
        PzpgdcEKeJ/HkAZ8Is=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to support PAGE_SIZE aligned MR, rxe_map_mr_sg() should be able
to split a large buffer to N * page entry into the xarray page_list.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 39 +++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index a038133e1322..3761740af986 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -193,9 +193,8 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 	return err;
 }
 
-static int rxe_set_page(struct ib_mr *ibmr, u64 dma_addr)
+static int rxe_store_page(struct rxe_mr *mr, u64 dma_addr)
 {
-	struct rxe_mr *mr = to_rmr(ibmr);
 	struct page *page = ib_virt_dma_to_page(dma_addr);
 	bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
 	int err;
@@ -216,20 +215,48 @@ static int rxe_set_page(struct ib_mr *ibmr, u64 dma_addr)
 	return 0;
 }
 
+static int rxe_set_page(struct ib_mr *base_mr, u64 buf_addr)
+{
+	return 0;
+}
+
 int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
-		  int sg_nents, unsigned int *sg_offset)
+		  int sg_nents, unsigned int *sg_offset_p)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
+	struct scatterlist *sg;
+	unsigned int sg_offset = sg_offset_p ? *sg_offset_p : 0;
+	int i;
 
-	if (ibmr->page_size != PAGE_SIZE) {
-		rxe_err_mr(mr, "Unsupport mr page size %x, expect PAGE_SIZE(%lx)\n",
+	if (!IS_ALIGNED(ibmr->page_size, PAGE_SIZE)) {
+		rxe_err_mr(mr, "Misaligned page size %x, expect PAGE_SIZE(%lx) aligned\n",
 			   ibmr->page_size, PAGE_SIZE);
 		return -EINVAL;
 	}
 
 	mr->nbuf = 0;
 
-	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
+	for_each_sg(sgl, sg, sg_nents, i) {
+		u64 dma_addr = sg_dma_address(sg) + sg_offset;
+		unsigned int dma_len = sg_dma_len(sg) - sg_offset;
+		u64 end_dma_addr = dma_addr + dma_len;
+		u64 page_addr = dma_addr & PAGE_MASK;
+
+		if (sg_dma_len(sg) == 0) {
+			rxe_dbg_mr(mr, "empty SGE\n");
+			return -EINVAL;
+		}
+		do {
+			int ret = rxe_store_page(mr, page_addr);
+			if (ret)
+				return ret;
+
+			page_addr += PAGE_SIZE;
+		} while (page_addr < end_dma_addr);
+		sg_offset = 0;
+	}
+
+	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset_p, rxe_set_page);
 }
 
 static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
-- 
2.41.0

