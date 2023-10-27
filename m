Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007C07D8E3E
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 07:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjJ0FmW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 01:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0FmV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 01:42:21 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAAC1A7;
        Thu, 26 Oct 2023 22:42:19 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="137517268"
X-IronPort-AV: E=Sophos;i="6.03,255,1694703600"; 
   d="scan'208";a="137517268"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 14:42:11 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7D2C1D6186;
        Fri, 27 Oct 2023 14:42:08 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id AF8D5D3F3B;
        Fri, 27 Oct 2023 14:42:07 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 43BD72007471E;
        Fri, 27 Oct 2023 14:42:07 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id 682921A0070;
        Fri, 27 Oct 2023 13:42:06 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, bvanassche@acm.org,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
Date:   Fri, 27 Oct 2023 13:41:53 +0800
Message-ID: <20231027054154.2935054-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27960.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27960.005
X-TMASE-Result: 10--2.709700-10.000000
X-TMASE-MatchedRID: 362T4rQL1OeMCPk/lvFUOp13aYUE0ivy2FA7wK9mP9dHpEd1UrzmFcyY
        +KNsy3oNEtuR7TIdaKXplZ0MI+xAXtAy2LXTI7g3EXjPIvKd74BMkOX0UoduuZBz1ZAU7t9T5s7
        uzWaKyAzi8zVgXoAltr8hWd4lAsFlC24oEZ6SpSmcfuxsiY4QFAusc5H1417CXea3jCa2pjxA+d
        r4vevoQ6AYfsZo2EAGB3zb8qgE6aUTkfXrC6tp/rLvgdRTF0C9JtAM880Fc9lxfsHyeP4fXJsNE
        GpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

mr->page_list only encodes *page without page offset, when
page_size != PAGE_SIZE, we cannot restore the address with a wrong
page_offset.

Note that this patch will break some ULPs that try to register 4K
MR when PAGE_SIZE is not 4K.
SRP and nvme over RXE is known to be impacted.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index f54042e9aeb2..61a136ea1d91 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -234,6 +234,12 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 	struct rxe_mr *mr = to_rmr(ibmr);
 	unsigned int page_size = mr_page_size(mr);
 
+	if (page_size != PAGE_SIZE) {
+		rxe_info_mr(mr, "Unsupported MR with page_size %u, expect %lu\n",
+			   page_size, PAGE_SIZE);
+		return -EOPNOTSUPP;
+	}
+
 	mr->nbuf = 0;
 	mr->page_shift = ilog2(page_size);
 	mr->page_mask = ~((u64)page_size - 1);
-- 
2.41.0

