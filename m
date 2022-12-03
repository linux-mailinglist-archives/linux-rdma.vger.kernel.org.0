Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD070641405
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Dec 2022 04:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiLCDhc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Dec 2022 22:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiLCDhb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Dec 2022 22:37:31 -0500
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FC8A0557;
        Fri,  2 Dec 2022 19:37:27 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="86269280"
X-IronPort-AV: E=Sophos;i="5.96,214,1665414000"; 
   d="scan'208";a="86269280"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 03 Dec 2022 12:37:24 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id CED8BD3EA3;
        Sat,  3 Dec 2022 12:37:23 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1B3F0F0A2D;
        Sat,  3 Dec 2022 12:37:23 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C75D23406A1;
        Sat,  3 Dec 2022 12:37:22 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     leon@kernel.org, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] RDMA/mlx5: no need to kfree NULL pointer
Date:   Sat,  3 Dec 2022 11:37:14 +0800
Message-Id: <20221203033714.25870-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27300.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27300.005
X-TMASE-Result: 10--5.794900-10.000000
X-TMASE-MatchedRID: rWcK0WiM0yyjC979w1k7DErOO5m0+0gEmSLeIgEDej/AuQ0xDMaXkH4q
        tYI9sRE/ZNUDHbPZ5K3LtJAGcfCTs8QmX0k7dptpngIgpj8eDcAZ1CdBJOsoY9mzcdRxL+xwKra
        uXd3MZDUaA0E8UdrP6nF6eQOQrAVPaaC7MUsggjz+CsA1rmXCp5RZ3pKiHPN/
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Goto label 'free' where it will kfree the 'in' is not needed though
it's safe to kfree NULL. Return err code directly to simplify the code.

1973 free:
1974         kfree(in);
1975         return err;

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
I stumbled across this little defect.
---
 drivers/infiniband/hw/mlx5/mr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 410cc5fd2523..053fe946e45a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1929,10 +1929,8 @@ int mlx5_ib_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	ndescs = req.num_klms ? roundup(req.num_klms, 4) : roundup(1, 4);
 
 	in = kzalloc(inlen, GFP_KERNEL);
-	if (!in) {
-		err = -ENOMEM;
-		goto free;
-	}
+	if (!in)
+		return -ENOMEM;
 
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
 
-- 
2.38.1

