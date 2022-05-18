Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8E552B1B7
	for <lists+linux-rdma@lfdr.de>; Wed, 18 May 2022 07:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiERE4g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 May 2022 00:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiERE4f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 May 2022 00:56:35 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 May 2022 21:56:32 PDT
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3FE103;
        Tue, 17 May 2022 21:56:31 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="51985739"
X-IronPort-AV: E=Sophos;i="5.91,234,1647270000"; 
   d="scan'208";a="51985739"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 18 May 2022 13:55:25 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5FA2ED5026;
        Wed, 18 May 2022 13:55:25 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B7224E6627;
        Wed, 18 May 2022 13:55:24 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 8D70520403C1;
        Wed, 18 May 2022 13:55:24 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     leonro@nvidia.com, jgg@nvidia.com
Cc:     aharonl@nvidia.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH] RDMA/mlx5: Remove duplicate pointer assignment in mlx5_ib_alloc_implicit_mr()
Date:   Wed, 18 May 2022 04:49:14 +0000
Message-Id: <20220518044914.1903125-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pointer imr->umem is assigned twice. Fix this by removing the
redundant one.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 41c964a45f89..b501ba0d7717 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -510,7 +510,6 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	imr->ibmr.lkey = imr->mmkey.key;
 	imr->ibmr.rkey = imr->mmkey.key;
 	imr->ibmr.device = &dev->ib_dev;
-	imr->umem = &umem_odp->umem;
 	imr->is_odp_implicit = true;
 	xa_init(&imr->implicit_children);
 
-- 
2.25.1

