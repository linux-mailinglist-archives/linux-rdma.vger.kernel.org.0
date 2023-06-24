Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F211373C766
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jun 2023 09:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjFXHkw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 24 Jun 2023 03:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjFXHkv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 24 Jun 2023 03:40:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FBBE7D
        for <linux-rdma@vger.kernel.org>; Sat, 24 Jun 2023 00:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687592450; x=1719128450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=srdNvnLtJM4cXhiaa6KO7TQ2+8tSqelv/CbI9RrmN3k=;
  b=Bsj3qS8XRtdvMhhCQEg2KWWBmrgGIgA1/KPzZgu9Th6rZUxtuQ+xwyLw
   jrbVKVQuFIsI8UHH11tFhpTre9ZyaH3entaBMJnq0Mh7GhqapZZZXYImp
   UCpSZGNUc8GbSnBKVq0JAFv763jHRDcN5N3kvZ3LC2+IORfvxY+ZMLbrB
   Jtw3z9Vpj5xYEIhjsigmyWKIUKgyw+1WRbWXN3bUIreCULQVKT+wfenrF
   xAt7X/hDPBPzUu/gHKHN3VK6GsTX5SqoO3R1JtjDqvUYIB07rvle14bNY
   50UVal67tIuYskrZsfivqG6dSn9/5+Wkq8coLZDxT1JlCiEhYrc0xbcyC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="340517865"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="340517865"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 00:40:09 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="750240665"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="750240665"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga001.jf.intel.com with ESMTP; 24 Jun 2023 00:40:07 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, parav@nvidia.com, lehrer@gmail.com,
        rpearsonhpe@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
Subject: [PATCH v7 1/8] RDMA/rxe: Creating listening sock in newlink function
Date:   Sat, 24 Jun 2023 15:39:20 +0800
Message-Id: <20230624073927.707915-2-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230624073927.707915-1-yanjun.zhu@intel.com>
References: <20230624073927.707915-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
index 7a7e713de52d..89b24bc34299 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -194,6 +194,10 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 		goto err;
 	}
 
+	err = rxe_net_init();
+	if (err)
+		return err;
+
 	err = rxe_net_add(ibdev_name, ndev);
 	if (err) {
 		rxe_err("failed to add %s\n", ndev->name);
@@ -210,12 +214,6 @@ static struct rdma_link_ops rxe_link_ops = {
 
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

