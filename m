Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A615A6958CB
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Feb 2023 07:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjBNGIV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Feb 2023 01:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjBNGIT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Feb 2023 01:08:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82042CC16
        for <linux-rdma@vger.kernel.org>; Mon, 13 Feb 2023 22:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676354896; x=1707890896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=stoYlkDujT4xuDAjuGucIJmRDNHsYIir8HsAU2bM9c4=;
  b=hn1hr4K4CEKa473cyLV8ywqZXx2WctTG6SbGUOfw+mY3Nn+kv79BWZMi
   /1WZOvqRqkZ7iYiHUqxvq4Z4yWy91DGZLGUJjM6Yul5KEjvePadCLFJbO
   6tiMcj7AC9Uvm8zkX5epK28xBod5reEtVwoRw62Sk5CxO/0ajG9/pptVY
   qH8/o20hXT0OI32cm/QCWT2JsoQmiLu1CnCmwfPuX/pesaGn/RJ6ombBE
   YLSqZdSknIbqvwmw4NTRZf1/bFrFMYlCBNzk7CLOzt7pOP6w9eq2zfvh2
   eM1vlodWZ6VdqE87uv/4Q5NvKGYFjwXPm9FqhiDO+Knez3ci9C4ip083C
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="332400541"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="332400541"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 22:08:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="618924777"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="618924777"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2023 22:08:00 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, parav@nvidia.com, yanjun.zhu@intel.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCHv3 1/8] RDMA/rxe: Creating listening sock in newlink function
Date:   Tue, 14 Feb 2023 14:06:27 +0800
Message-Id: <20230214060634.427162-2-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230214060634.427162-1-yanjun.zhu@intel.com>
References: <20230214060634.427162-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
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
2.34.1

