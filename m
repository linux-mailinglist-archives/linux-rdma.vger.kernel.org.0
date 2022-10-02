Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844AF5F1C14
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Oct 2022 14:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJAMPg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 Oct 2022 08:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJAMPf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 1 Oct 2022 08:15:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5731C5C9E9
        for <linux-rdma@vger.kernel.org>; Sat,  1 Oct 2022 05:15:32 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="328763285"
X-IronPort-AV: E=Sophos;i="5.93,360,1654585200"; 
   d="scan'208";a="328763285"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 05:15:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="653848528"
X-IronPort-AV: E=Sophos;i="5.93,360,1654585200"; 
   d="scan'208";a="653848528"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 01 Oct 2022 05:15:30 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: [PATCH 1/6] RDMA/rxe: Creating listening sock in newlink function
Date:   Sun,  2 Oct 2022 00:41:47 -0400
Message-Id: <20221002044152.933021-2-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221002044152.933021-1-yanjun.zhu@linux.dev>
References: <20221002044152.933021-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Originally when the module rdma_rxe is loaded, the sock listening on udp
port 4791 is created. Currently moving the creating listening port to
newlink function.

So when running "rdma link add" command, the sock listening on udp port
4791 is created.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 51daac5c4feb..a22ff2207b42 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -192,6 +192,10 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 		goto err;
 	}
 
+	err = rxe_net_init();
+	if (err)
+		return err;
+
 	err = rxe_net_add(ibdev_name, ndev);
 	if (err) {
 		pr_err("failed to add %s\n", ndev->name);
@@ -210,10 +214,6 @@ static int __init rxe_module_init(void)
 {
 	int err;
 
-	err = rxe_net_init();
-	if (err)
-		return err;
-
 	rdma_link_register(&rxe_link_ops);
 	pr_info("loaded\n");
 	return 0;
-- 
2.25.1

