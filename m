Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5816B765597
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 16:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjG0OKk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 10:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjG0OKj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 10:10:39 -0400
X-Greylist: delayed 390 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Jul 2023 07:10:37 PDT
Received: from out-101.mta0.migadu.com (out-101.mta0.migadu.com [91.218.175.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1D31BD6
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 07:10:37 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690466645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAA4pfJA29nzPxcpA9hPAR83WDofKRCLlu29O9SRpkk=;
        b=PRpVeEVdYXY1BEQWr+zckLp3mxHqIR8rME65914weXKnFXVFVir+JU85szAh5fGABOp5sk
        aDPH91vdb8bkhbOuMlskE9WptqIer6Cs3EuIP1OUG8dO0W50tXD3Pc73OQztfTYHePiJmx
        PGBypUxWd0t9ohUecwYWVZpjWfQc8TI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 2/5] RDMA/siw: Ensure siw_destroy_cpulist can be called more than once
Date:   Thu, 27 Jul 2023 22:03:46 +0800
Message-Id: <20230727140349.25369-3-guoqing.jiang@linux.dev>
In-Reply-To: <20230727140349.25369-1-guoqing.jiang@linux.dev>
References: <20230727140349.25369-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In case siw module can't be inserted successfully, then if remove
the module from kernel, then both siw_cm_exit and the failure path
in siw_init_module call siw_destroy_cpulist. Let's set tx_valid_cpus
and num_nodes to prevent double free issues.

[   32.197293] general protection fault, probably for non-canonical address 0xb4965e5a58a488: 0000 [#1] PREEMPT SMP NOPTI
[   32.197300] CPU: 0 PID: 1676 Comm: modprobe Tainted: G           OE      6.5.0-rc3+ #16
[   32.197304] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
[   32.197306] RIP: 0010:kfree+0x62/0x150
...
[   32.197339] Call Trace:
[   32.197341]  <TASK>
[   32.197343]  ? show_regs+0x72/0x90
[   32.197348]  ? die_addr+0x38/0xb0
[   32.197351]  ? exc_general_protection+0x1bf/0x4a0
[   32.197357]  ? asm_exc_general_protection+0x27/0x30
[   32.197362]  ? kfree+0x62/0x150
[   32.197366]  siw_exit_module+0xb8/0x590 [siw]
[   32.197376]  __do_sys_delete_module.constprop.0+0x18f/0x300

So let's set tx_valid_cpus and num_nodes to prevent the issue.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 65b5cda5457b..b3547253c099 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -178,6 +178,8 @@ static void siw_destroy_cpulist(void)
 		kfree(siw_cpu_info.tx_valid_cpus[i++]);
 
 	kfree(siw_cpu_info.tx_valid_cpus);
+	siw_cpu_info.tx_valid_cpus = NULL;
+	siw_cpu_info.num_nodes = 0;
 }
 
 /*
-- 
2.34.1

