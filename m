Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F658782AAC
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 15:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjHUNiR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 09:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjHUNiQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 09:38:16 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1967BCE
        for <linux-rdma@vger.kernel.org>; Mon, 21 Aug 2023 06:38:15 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RTtms5WNlz1L9R0;
        Mon, 21 Aug 2023 21:36:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 21:38:12 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-rdma@vger.kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] RDMA/hfi1: Use list_for_each_entry() helper
Date:   Mon, 21 Aug 2023 21:37:53 +0800
Message-ID: <20230821133753.3131936-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Convert list_for_each() to list_for_each_entry() where applicable.

No functional changed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/infiniband/hw/hfi1/affinity.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 77ee77d4000f..bbc957c578e1 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -230,11 +230,9 @@ static void node_affinity_add_tail(struct hfi1_affinity_node *entry)
 /* It must be called with node_affinity.lock held */
 static struct hfi1_affinity_node *node_affinity_lookup(int node)
 {
-	struct list_head *pos;
 	struct hfi1_affinity_node *entry;
 
-	list_for_each(pos, &node_affinity.list) {
-		entry = list_entry(pos, struct hfi1_affinity_node, list);
+	list_for_each_entry(entry, &node_affinity.list, list) {
 		if (entry->node == node)
 			return entry;
 	}
-- 
2.34.1

