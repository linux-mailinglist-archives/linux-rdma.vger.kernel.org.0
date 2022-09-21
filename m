Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFA55BF8A1
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Sep 2022 10:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIUIJd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Sep 2022 04:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIUIJc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Sep 2022 04:09:32 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF42241
        for <linux-rdma@vger.kernel.org>; Wed, 21 Sep 2022 01:09:28 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="68809803"
X-IronPort-AV: E=Sophos;i="5.93,332,1654527600"; 
   d="scan'208";a="68809803"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 21 Sep 2022 17:09:26 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4A78DDA68D
        for <linux-rdma@vger.kernel.org>; Wed, 21 Sep 2022 17:09:25 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 8338DD998C
        for <linux-rdma@vger.kernel.org>; Wed, 21 Sep 2022 17:09:24 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 500D82020A5C;
        Wed, 21 Sep 2022 17:09:24 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     leonro@nvidia.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     yishaih@nvidia.com, Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH v2 1/2] IB: Set IOVA/LENGTH on IB_MR in core/uverbs layers
Date:   Wed, 21 Sep 2022 17:08:43 +0900
Message-Id: <20220921080844.1616883-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Set 'iova' and 'length' on ib_mr in ib_uverbs and ib_core layers to let all
drivers have the members filled. Also, this commit removes redundancy in
the respective drivers.

Previously, commit 04c0a5fcfcf65 ("IB/uverbs: Set IOVA on IB MR in uverbs
layer") changed to set 'iova', but seems to have missed 'length' and the
ib_core layer at that time.

Fixes: 04c0a5fcfcf65 ("IB/uverbs: Set IOVA on IB MR in uverbs layer")
Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
v2
  Set 'iova' and 'length' in ib_reg_user_mr(), as commented by Romanovsky
  cf. https://patchwork.kernel.org/project/linux-rdma/patch/20220908090708.3997456-1-matsuda-daisuke@fujitsu.com/

 drivers/infiniband/core/uverbs_cmd.c    | 5 ++++-
 drivers/infiniband/core/verbs.c         | 2 ++
 drivers/infiniband/hw/hns/hns_roce_mr.c | 1 -
 drivers/infiniband/hw/mlx4/mr.c         | 1 -
 4 files changed, 6 insertions(+), 3 deletions(-)

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
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index e54b3f1b730e..f8964c8cf0ad 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2149,6 +2149,8 @@ struct ib_mr *ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	mr->pd = pd;
 	mr->dm = NULL;
 	atomic_inc(&pd->usecnt);
+	mr->iova =  virt_addr;
+	mr->length = length;
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
 	rdma_restrack_parent_name(&mr->res, &pd->res);
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

