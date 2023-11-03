Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248FD7E0094
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 11:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347536AbjKCJ4M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 05:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347502AbjKCJ4K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 05:56:10 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3FAD6D;
        Fri,  3 Nov 2023 02:56:02 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="126169479"
X-IronPort-AV: E=Sophos;i="6.03,273,1694703600"; 
   d="scan'208";a="126169479"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 18:56:00 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 44DB1D6475;
        Fri,  3 Nov 2023 18:55:58 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 35AB1D52C1;
        Fri,  3 Nov 2023 18:55:57 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id BA5C51EB1D5;
        Fri,  3 Nov 2023 18:55:56 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id 3779B1A0072;
        Fri,  3 Nov 2023 17:55:56 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, bvanassche@acm.org,
        yi.zhang@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC V2 1/6] RDMA/rxe: RDMA/rxe: don't allow registering !PAGE_SIZE mr
Date:   Fri,  3 Nov 2023 17:55:44 +0800
Message-ID: <20231103095549.490744-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103095549.490744-1-lizhijian@fujitsu.com>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27974.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27974.006
X-TMASE-Result: 10--4.672600-10.000000
X-TMASE-MatchedRID: rDfjNDBkNcOMCPk/lvFUOt9JA2lmQRNU2FA7wK9mP9cRt1EvyOXA0dyQ
        dWCH/YgKQZCd2iT0MflsOacVUHP+r+W5YZxMb7aKGqSG/c50XgOaDC/RGGCVV5LFwf1lbHnIgK6
        qCGa1Z9fDzSde0I1kYIAy6p60ZV62G2i4y8P2xXndB/CxWTRRu+rAZ8KTspSzxtaprLqF3ntFDM
        BLjwF3v4FTBTx0LGJ0Spt5K+Tfxbm4lv7CWjd+M51xKvhXp79eP+XouMjD7/vMOuUN/hZxXilzw
        1xveMciIcmnZRhVxyrE4HwnSlEuHInEpJmLAFfpC1FNc6oqYVV+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_set_page() only store one PAGE_SIZE page by the step of page_size.
when page_size != PAGE_SIZE, we cannot restore the address with wrong
index and page_offset.

Let's take a look how current the xarray is being used.

0. offset = iova & (page_size -1); // offset is less than page_size
                                      but may not PAGE_SIZE
1. index = (iova - mr.iova) >> page_shift;
2. page = xa_load(&mr->page_list, index);
3. page_va = kmap_local_page(page) // map one page only, that means only
                                      memory [page_va, page_va + PAGE_SIZE)
                                      is valid for this mapping.
4. memcpy(addr, page_va + offset, bytes);

- when page_size > PAGE_SIZE, the offset could be beyond PAGE_SIZE,
  then page_va + offset may be invalid.
- when page_size < PAGE_SIZE, the offset may get lost.

Note that this patch will break some ULPs that try to register 4K
MR when PAGE_SIZE is not 4K. SRP and nvme over RXE is known to be
impacted.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

---
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index f54042e9aeb2..3755e530e6dc 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -234,6 +234,12 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 	struct rxe_mr *mr = to_rmr(ibmr);
 	unsigned int page_size = mr_page_size(mr);
 
+	if (page_size != PAGE_SIZE) {
+		rxe_err_mr(mr, "Unsupport mr page size %x, expect PAGE_SIZE(%lx)\n",
+			   page_size, PAGE_SIZE);
+		return -EINVAL;
+	}
+
 	mr->nbuf = 0;
 	mr->page_shift = ilog2(page_size);
 	mr->page_mask = ~((u64)page_size - 1);
-- 
2.41.0

