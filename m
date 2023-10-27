Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73AC7D99BF
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 15:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345949AbjJ0N1Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 09:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345933AbjJ0N1X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 09:27:23 -0400
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EE91BC
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 06:27:18 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698413236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cRIh0/+cJy0iTqpkHFk8pRZcHVKwd/KMHQoBl+k6SCk=;
        b=dVQbuKgC2ccgBgjFummRqiN7bBBy0ZLvivCx5qVyckGoXDJ0nfYLblIJ11LWu1P+HAOaq9
        RrPSmrAxubDDCG/COyXtRrRENanqhSiIAr2XcTUm538W7UWOL1UPeaeGXO/QdLZgCggJa9
        ebZE+PYxxb6lSLgws3CRVVi2vJQbdC0=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V4 10/18] RDMA/siw: Add one parameter to siw_destroy_cpulist
Date:   Fri, 27 Oct 2023 21:26:36 +0800
Message-Id: <20231027132644.29347-11-guoqing.jiang@linux.dev>
In-Reply-To: <20231027132644.29347-1-guoqing.jiang@linux.dev>
References: <20231027132644.29347-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

With that we can reuse it in siw_init_cpulist.

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_main.c | 30 +++++++++++++---------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 1ab62982df74..61ad8ca3d1a2 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -109,6 +109,17 @@ static struct {
 	int num_nodes;
 } siw_cpu_info;
 
+static void siw_destroy_cpulist(int number)
+{
+	int i = 0;
+
+	while (i < number)
+		kfree(siw_cpu_info.tx_valid_cpus[i++]);
+
+	kfree(siw_cpu_info.tx_valid_cpus);
+	siw_cpu_info.tx_valid_cpus = NULL;
+}
+
 static int siw_init_cpulist(void)
 {
 	int i, num_nodes = nr_node_ids;
@@ -138,24 +149,11 @@ static int siw_init_cpulist(void)
 
 out_err:
 	siw_cpu_info.num_nodes = 0;
-	while (--i >= 0)
-		kfree(siw_cpu_info.tx_valid_cpus[i]);
-	kfree(siw_cpu_info.tx_valid_cpus);
-	siw_cpu_info.tx_valid_cpus = NULL;
+	siw_destroy_cpulist(i);
 
 	return -ENOMEM;
 }
 
-static void siw_destroy_cpulist(void)
-{
-	int i = 0;
-
-	while (i < siw_cpu_info.num_nodes)
-		kfree(siw_cpu_info.tx_valid_cpus[i++]);
-
-	kfree(siw_cpu_info.tx_valid_cpus);
-}
-
 /*
  * Choose CPU with least number of active QP's from NUMA node of
  * TX interface.
@@ -558,7 +556,7 @@ static __init int siw_init_module(void)
 	pr_info("SoftIWARP attach failed. Error: %d\n", rv);
 
 	siw_cm_exit();
-	siw_destroy_cpulist();
+	siw_destroy_cpulist(siw_cpu_info.num_nodes);
 
 	return rv;
 }
@@ -573,7 +571,7 @@ static void __exit siw_exit_module(void)
 
 	siw_cm_exit();
 
-	siw_destroy_cpulist();
+	siw_destroy_cpulist(siw_cpu_info.num_nodes);
 
 	if (siw_crypto_shash)
 		crypto_free_shash(siw_crypto_shash);
-- 
2.35.3

