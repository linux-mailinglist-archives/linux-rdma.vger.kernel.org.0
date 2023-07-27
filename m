Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B807655AF
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 16:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjG0OPT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 10:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjG0OPS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 10:15:18 -0400
Received: from out-101.mta0.migadu.com (out-101.mta0.migadu.com [IPv6:2001:41d0:1004:224b::65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C704C2685
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 07:15:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690466649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hNyt4TpfRCu2QkmN2Quw5XUjlAzJWTllAAJ+BYuaXKM=;
        b=J8RPxjMx6vNlCIxfFPuKgyHmsk1SkcIxZ682lU7Z8O9aDYPTiRJ42S5R4kf5M55D5YG2gh
        I58p9L4ghCBPW2LOPPuDHP7nhyHHKzpNOlzgPsOuhbRuBEbzhignkV67GgUZxX2Dahhuqy
        nxFRpwjHCKLfcHicNahj1ApJStWN874=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 4/5] RDMA/siw: Set siw_crypto_shash to NULL after it is freed
Date:   Thu, 27 Jul 2023 22:03:48 +0800
Message-Id: <20230727140349.25369-5-guoqing.jiang@linux.dev>
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

In case siw module can't be inserted successfully, then remove the
module from kernel, which means both siw_cm_exit and the failure
path in siw_init_module call crypto_free_shash. We can see below
call trace appears.

[   72.349344] ------------[ cut here ]------------
[   72.349348] refcount_t: underflow; use-after-free.
[   72.349386] WARNING: CPU: 1 PID: 1737 at lib/refcount.c:28 refcount_warn_saturate+0xfb/0x150
...
[   72.349469] RIP: 0010:refcount_warn_saturate+0xfb/0x150
...
[   72.349487] Call Trace:
[   72.349488]  <TASK>
[   72.349490]  ? show_regs+0x72/0x90
[   72.349493]  ? refcount_warn_saturate+0xfb/0x150
[   72.349495]  ? __warn+0x8d/0x1a0
[   72.349498]  ? refcount_warn_saturate+0xfb/0x150
[   72.349500]  ? report_bug+0x1f9/0x250
[   72.349505]  ? handle_bug+0x46/0x90
[   72.349508]  ? exc_invalid_op+0x19/0x80
[   72.349511]  ? asm_exc_invalid_op+0x1b/0x20
[   72.349517]  ? refcount_warn_saturate+0xfb/0x150
[   72.349519]  ? refcount_warn_saturate+0xfb/0x150
[   72.349521]  crypto_destroy_tfm+0x9b/0xe0
[   72.349525]  siw_exit_module+0xf6/0x590 [siw]

So we need to set siw_crypto_shash to null in the failure path of
siw_init_module.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 6709ed0de3a4..f8549d01887f 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -589,8 +589,10 @@ static __init int siw_init_module(void)
 			siw_tx_thread[nr_cpu] = NULL;
 		}
 	}
-	if (siw_crypto_shash)
+	if (siw_crypto_shash) {
 		crypto_free_shash(siw_crypto_shash);
+		siw_crypto_shash = NULL;
+	}
 
 	pr_info("SoftIWARP attach failed. Error: %d\n", rv);
 
-- 
2.34.1

