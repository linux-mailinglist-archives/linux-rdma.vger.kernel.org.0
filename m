Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF75B1803
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 11:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiIHJHx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 05:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiIHJHm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 05:07:42 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC86DFF5C
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 02:07:41 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="66535356"
X-IronPort-AV: E=Sophos;i="5.93,299,1654527600"; 
   d="scan'208";a="66535356"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 08 Sep 2022 18:07:39 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 69E7AD624B
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 18:07:38 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B9F0BD35DC
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 18:07:37 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 8F18D200B435;
        Thu,  8 Sep 2022 18:07:37 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     leonro@nvidia.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     liangwenpeng@huawei.com, liweihang@huawei.com, yishaih@nvidia.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH 1/2] IB/uverbs: Set LENGTH on IB MR in uverbs layer
Date:   Thu,  8 Sep 2022 18:07:07 +0900
Message-Id: <20220908090708.3997456-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Set 'length' on ib_mr in uverbs layer to let all drivers have it, this
includes both reg/rereg MR flows. Also, this commit removes redundancy in
each driver.

Previously, commit 04c0a5fcfcf65 ("IB/uverbs: Set IOVA on IB MR in uverbs
layer") changed to set 'iova', but seems to have missed 'length' at that
time.

Fixes: 04c0a5fcfcf65 ("IB/uverbs: Set IOVA on IB MR in uverbs layer")
Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/core/uverbs_cmd.c    | 5 ++++-
 drivers/infiniband/hw/hns/hns_roce_mr.c | 1 -
 drivers/infiniband/hw/mlx4/mr.c         | 1 -
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 046376bd68e2..4796f6a8828c 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -739,6 +739,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	mr->uobject = uobj;
 	atomic_inc(&pd->usecnt);
 	mr->iova = cmd.hca_va;
+	mr->length = cmd.length;
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
 	rdma_restrack_set_name(&mr->res, NULL);
@@ -861,8 +862,10 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 			mr->pd = new_pd;
 			atomic_inc(&new_pd->usecnt);
 		}
-		if (cmd.flags & IB_MR_REREG_TRANS)
+		if (cmd.flags & IB_MR_REREG_TRANS) {
 			mr->iova = cmd.hca_va;
+			mr->length = cmd.length;
+		}
 	}
 
 	memset(&resp, 0, sizeof(resp));
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 867972c2a894..dedfa56f5773 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -249,7 +249,6 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		goto err_alloc_pbl;
 
 	mr->ibmr.rkey = mr->ibmr.lkey = mr->key;
-	mr->ibmr.length = length;
 
 	return &mr->ibmr;
 
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 04a67b481608..a40bf58bcdd3 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -439,7 +439,6 @@ struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		goto err_mr;
 
 	mr->ibmr.rkey = mr->ibmr.lkey = mr->mmr.key;
-	mr->ibmr.length = length;
 	mr->ibmr.page_size = 1U << shift;
 
 	return &mr->ibmr;
-- 
2.31.1

