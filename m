Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1D77BD443
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 09:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345393AbjJIHZg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 03:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345391AbjJIHZe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 03:25:34 -0400
Received: from out-194.mta0.migadu.com (out-194.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EE6CA
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 00:25:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696835922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mnb+gGmrjcx+DiyIe1j/ozcPWCSHKPv54GaWtqhVMG0=;
        b=qttbXwN+P5jgVZkBO1LCbdmnj9I1LKFPe6sDR2nRotUCcr9xJx0U65Pk0qqRAvRNnBKvpk
        wCkp17zbERfleoS2obm//pjOBPD/4UiKq/k4g/r4kV4LTptCSnw0a12tOtf9bGPAiJRUUS
        /m6hvR/I1Arq+ko+b6xfhrbRl60dlUY=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 10/19] RDMA/siw: Add one parameter to siw_destroy_cpulist
Date:   Mon,  9 Oct 2023 15:17:52 +0800
Message-Id: <20231009071801.10210-11-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-1-guoqing.jiang@linux.dev>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

With that we can reuse it in siw_init_cpulist.

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

