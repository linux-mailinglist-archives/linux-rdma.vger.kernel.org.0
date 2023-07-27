Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FE5765599
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 16:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjG0OKk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 10:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjG0OKj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 10:10:39 -0400
X-Greylist: delayed 393 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Jul 2023 07:10:38 PDT
Received: from out-101.mta0.migadu.com (out-101.mta0.migadu.com [IPv6:2001:41d0:1004:224b::65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AECA30C0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 07:10:38 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690466647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1aYJKaIIBdZyN0JBze4ryf7XRpEcse3z5//WfNqFzEA=;
        b=skMkIeTeSx8lUz7q/t0JOhXZTy+c/WkxyZglyiWkhCSZz0tw/vealc+O4HiqEqyfveRhjf
        5eKTkQZb1nCXdNi7kSQjFhgeh59GpvpmVn3VhhjDnEdDNfl+0hjYbO8jhZkEAlIZ2o70q7
        DmoALl+wijeP5r3orD8qwzFgzpD8uW8=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 3/5] RDMA/siw: Initialize siw_link_ops.list
Date:   Thu, 27 Jul 2023 22:03:47 +0800
Message-Id: <20230727140349.25369-4-guoqing.jiang@linux.dev>
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
the module from kernel, then siw_cm_exit can trigger below trace
because siw_link_ops.list is still NULL since rdma_link_register
is not called. So we need to init the list earlier.

[   45.306864] BUG: kernel NULL pointer dereference, address: 0000000000000008
[   45.306869] #PF: supervisor write access in kernel mode
[   45.306871] #PF: error_code(0x0002) - not-present page
[   45.306872] PGD 0 P4D 0
[   45.306874] Oops: 0002 [#1] PREEMPT SMP NOPTI
[   45.306876] CPU: 1 PID: 1742 Comm: modprobe Tainted: G           OE      6.5.0-rc3+ #16
[   45.306879] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
[   45.306880] RIP: 0010:rdma_link_unregister+0x27/0x60 [ib_core]
...
[   45.306916] Call Trace:
[   45.306917]  <TASK>
[   45.306918]  ? show_regs+0x72/0x90
[   45.306922]  ? __die+0x25/0x80
[   45.306924]  ? page_fault_oops+0x154/0x4d0
[   45.306927]  ? __this_cpu_preempt_check+0x13/0x20
[   45.306929]  ? lockdep_unlock+0x63/0xe0
[   45.306933]  ? do_user_addr_fault+0x381/0x8d0
[   45.306934]  ? rcu_is_watching+0x13/0x70
[   45.306937]  ? exc_page_fault+0x87/0x240
[   45.306940]  ? asm_exc_page_fault+0x27/0x30
[   45.306944]  ? rdma_link_unregister+0x27/0x60 [ib_core]
[   45.306956]  ? rdma_link_unregister+0x19/0x60 [ib_core]
[   45.306967]  siw_exit_module+0x87/0x590 [siw]
[   45.306973]  __do_sys_delete_module.constprop.0+0x18f/0x300
[   45.306975]  ? syscall_enter_from_user_mode+0x21/0x70
[   45.306977]  ? __this_cpu_preempt_check+0x13/0x20
[   45.306978]  ? lockdep_hardirqs_on+0x86/0x120
[   45.306980]  __x64_sys_delete_module+0x12/0x20
[   45.306982]  do_syscall_64+0x5c/0x90

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index b3547253c099..6709ed0de3a4 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -526,6 +526,7 @@ static int siw_newlink(const char *basedev_name, struct net_device *netdev)
 }
 
 static struct rdma_link_ops siw_link_ops = {
+	.list = LIST_HEAD_INIT(siw_link_ops.list),
 	.type = "siw",
 	.newlink = siw_newlink,
 };
-- 
2.34.1

