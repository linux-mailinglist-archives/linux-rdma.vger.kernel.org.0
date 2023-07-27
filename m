Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CE076559A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 16:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjG0OKl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjG0OKk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 10:10:40 -0400
Received: from out-86.mta0.migadu.com (out-86.mta0.migadu.com [IPv6:2001:41d0:1004:224b::56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFAD30C7
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 07:10:38 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690466644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JOPZ39/5EC5YSntQUhlwxq5R8ADpit4B5fPorVnB/Tw=;
        b=W6WBsKZcis0XhG9u3Hw4q2PfmXWRj2c/4/tEySAh/JljwANbx8MJnEqFRNBd7ZtnoZQyl2
        YEp4mjpfvDhf5Boo6+PGitd+D/VVUvjkgJUREzPAFMkqyQPtX/MJ7KN5K9Gda/qio1fSVm
        KAPXOOvuJMtDynxg2CjndBpXyPkqPcE=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 1/5] RDMA/siw: Set siw_cm_wq to NULL after it is destroyed
Date:   Thu, 27 Jul 2023 22:03:45 +0800
Message-Id: <20230727140349.25369-2-guoqing.jiang@linux.dev>
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

In case siw module can't be inserted successfully, after that remove the module
from kernel, then both siw_cm_exit and the failure path in siw_init_module call
siw_cm_exit, which cause below issue.

[   73.561312] BUG: unable to handle page fault for address: 000000040000004c
[   73.561317] #PF: supervisor read access in kernel mode
[   73.561319] #PF: error_code(0x0000) - not-present page
[   73.561320] PGD 0 P4D 0
[   73.561322] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   73.561324] CPU: 1 PID: 1693 Comm: modprobe Tainted: G           OE      6.5.0-rc3+ #16
[   73.561326] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
[   73.561327] RIP: 0010:device_del+0x22/0x3d0
...
[   73.561347] Call Trace:
[   73.561348]  <TASK>
[   73.561350]  ? show_regs+0x72/0x90
[   73.561353]  ? __die+0x25/0x80
[   73.561355]  ? page_fault_oops+0x154/0x4d0
[   73.561357]  ? lockdep_unlock+0x63/0xe0
[   73.561361]  ? do_user_addr_fault+0x381/0x8d0
[   73.561363]  ? rcu_is_watching+0x13/0x70
[   73.561365]  ? exc_page_fault+0x87/0x240
[   73.561369]  ? asm_exc_page_fault+0x27/0x30
[   73.561373]  ? device_del+0x22/0x3d0
[   73.561374]  ? __this_cpu_preempt_check+0x13/0x20
[   73.561377]  device_unregister+0x18/0x70
[   73.561378]  destroy_workqueue+0x33/0x2d0
[   73.561381]  siw_cm_exit+0x1a/0x30 [siw]
[   73.561387]  siw_exit_module+0x96/0x5a0 [siw]

So we need to set the workqueue to NULL after it is destroyed.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index da530c0404da..758ac8a22f7a 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1958,6 +1958,8 @@ int siw_cm_init(void)
 
 void siw_cm_exit(void)
 {
-	if (siw_cm_wq)
+	if (siw_cm_wq) {
 		destroy_workqueue(siw_cm_wq);
+		siw_cm_wq = NULL;
+	}
 }
-- 
2.34.1

