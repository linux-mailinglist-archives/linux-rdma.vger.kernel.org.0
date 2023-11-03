Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668D27E005F
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 11:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347491AbjKCJ4N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 05:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347526AbjKCJ4M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 05:56:12 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7485D77;
        Fri,  3 Nov 2023 02:56:03 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="117864670"
X-IronPort-AV: E=Sophos;i="6.03,273,1694703600"; 
   d="scan'208";a="117864670"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 18:56:00 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D783ED6475;
        Fri,  3 Nov 2023 18:55:58 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0EFF8D5D15;
        Fri,  3 Nov 2023 18:55:58 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A4D3B200501B1;
        Fri,  3 Nov 2023 18:55:57 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id 15FD81A0072;
        Fri,  3 Nov 2023 17:55:57 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, bvanassche@acm.org,
        yi.zhang@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC V2 3/6] RDMA/rxe: remove unused rxe_mr.page_shift
Date:   Fri,  3 Nov 2023 17:55:46 +0800
Message-ID: <20231103095549.490744-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103095549.490744-1-lizhijian@fujitsu.com>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27974.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27974.006
X-TMASE-Result: 10--2.244700-10.000000
X-TMASE-MatchedRID: 6q73Zcfo6Jq1UOlz1sLXchF4zyLyne+ATJDl9FKHbrlCw17cr3HRB+K5
        fhRxt1aA92kNXgH07FbsbC/Vw6Dhkx8TzIzimOwP/hxxPCwzUoPEQdG7H66TyHEqm8QYBtMOZsY
        Fy96KWWKZqgH/izpwuaKHvyV1Zkh/LCZafsjE5s7ah7Q7AITJYLpgs6aeGU9hk8OVAzuAhGHiC9
        thELD2+yGkZFGhX/A+W4wbpXTb5DJKKve1kh3RY37qSWrndbmQn0bOriG5BVc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

it's assigned but never used.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 1 -
 drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 3755e530e6dc..bbfedcd8d2cb 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -243,7 +243,6 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 	mr->nbuf = 0;
 	mr->page_shift = ilog2(page_size);
 	mr->page_mask = ~((u64)page_size - 1);
-	mr->page_offset = mr->ibmr.iova & (page_size - 1);
 
 	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ccb9d19ffe8a..11647e976282 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -309,7 +309,6 @@ struct rxe_mr {
 	int			access;
 	atomic_t		num_mw;
 
-	unsigned int		page_offset;
 	unsigned int		page_shift;
 	u64			page_mask;
 
-- 
2.41.0

