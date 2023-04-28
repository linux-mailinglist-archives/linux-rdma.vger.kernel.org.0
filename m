Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158506F1450
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Apr 2023 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345621AbjD1JnG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Apr 2023 05:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345455AbjD1JnF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Apr 2023 05:43:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FF24690
        for <linux-rdma@vger.kernel.org>; Fri, 28 Apr 2023 02:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682674983; x=1714210983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oC+vQEcrZoXSOOPg8qfiEA8dpCptDmqO+lSlOzglrm4=;
  b=Yg97M/6vVg9JYCsgMvNojDw6tx8U3QotF7gzAxGJ9JNq2T8R2M83nj5o
   af4FZDhOWf2tZGMqQNrjyMTY4NS89mZjfL3gGrs6tmDto1KaC2O1bI7kf
   mbUQSqDKpojQXogaMnfs1j660pYgYYPV4GEycO910nxowQ1gpnb1CAE4K
   HfTY4+G5nQzHR5D1lIvkmsO5lOeZjFNX32MN4mfxH4x6SUumTsrrvc2fv
   mMuaYmRdgJHJyGzI6xw9TZLUw5R+MM3Uu32vMV6f01z48egeDkLQn1CuZ
   UP8BNcSA9iS6eROUibCy5llWl9KvjZPm35zJZNuIXWM0AGMRsLOun93Hy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="328035121"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="328035121"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 02:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="764220293"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="764220293"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga004.fm.intel.com with ESMTP; 28 Apr 2023 02:43:00 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, parav@nvidia.com, lehrer@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
Subject: [PATCHv5 for-rc1 v5 1/8] RDMA/rxe: Creating listening sock in newlink function
Date:   Fri, 28 Apr 2023 17:39:07 +0800
Message-Id: <20230428093914.2121131-2-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230428093914.2121131-1-yanjun.zhu@intel.com>
References: <20230428093914.2121131-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Tested-by: Rain River <rain.1986.08.12@gmail.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 136c2efe3466..64644cb0bb38 100644
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
 		rxe_dbg(exists, "failed to add %s\n", ndev->name);
@@ -208,12 +212,6 @@ static struct rdma_link_ops rxe_link_ops = {
 
 static int __init rxe_module_init(void)
 {
-	int err;
-
-	err = rxe_net_init();
-	if (err)
-		return err;
-
 	rdma_link_register(&rxe_link_ops);
 	pr_info("loaded\n");
 	return 0;
-- 
2.27.0

