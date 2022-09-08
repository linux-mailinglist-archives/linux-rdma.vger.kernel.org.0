Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458665B1706
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 10:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiIHIbJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 04:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIHIbH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 04:31:07 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DA828708
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 01:31:04 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="87671020"
X-IronPort-AV: E=Sophos;i="5.93,299,1654527600"; 
   d="scan'208";a="87671020"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 08 Sep 2022 17:31:02 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 83D9BD4F5B
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 17:31:01 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id C0693CFAB2
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 17:31:00 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 9CBCB200B42D;
        Thu,  8 Sep 2022 17:31:00 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH] RDMA/mlx5: Remove duplicate assignment in umr_rereg_pas()
Date:   Thu,  8 Sep 2022 17:30:58 +0900
Message-Id: <20220908083058.3993700-1-matsuda-daisuke@fujitsu.com>
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

The same value is assigned to 'mr->ibmr.length'. Remove redundant one.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index bfec9bc3cdd8..4fcb653b35bb 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1400,7 +1400,6 @@ static int umr_rereg_pas(struct mlx5_ib_mr *mr, struct ib_pd *pd,
 		upd_flags |= MLX5_IB_UPD_XLT_ACCESS;
 	}
 
-	mr->ibmr.length = new_umem->length;
 	mr->ibmr.iova = iova;
 	mr->ibmr.length = new_umem->length;
 	mr->page_shift = order_base_2(page_size);
-- 
2.31.1

