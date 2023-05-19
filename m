Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CF2708E29
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 05:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjESDLf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 May 2023 23:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjESDLd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 May 2023 23:11:33 -0400
Received: from out-12.mta0.migadu.com (out-12.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB05E66
        for <linux-rdma@vger.kernel.org>; Thu, 18 May 2023 20:11:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684465888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9LRui45shy4gtsI+7hPrxBmeg1pUH2wOk3yvOahngWg=;
        b=N7zCsGIG/XbiwTVMdt1bZKWpcPwFxoRCRU2UvzoTt0V6MboE0cZoS9wOmYUpJTHthJvl89
        Mq348p40SVtTTX0XtlFPBqLSPUqEuEXwxTMWSlFALjfg8b0pU0nau+LudwkDUNw0ySCTHH
        iuKJBWksbwTOz8gYGTBd2ZdM8JAH8ls=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     pchelkin@ispras.ru, penguin-kernel@I-love.SAKURA.ne.jp,
        linux-rdma@vger.kernel.org
Subject: [PATCH for-rc] RDMA/core: Call dev_put after query_port in iw_query_port
Date:   Fri, 19 May 2023 11:11:19 +0800
Message-Id: <20230519031119.30103-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a UAF report by syzbot.

BUG: KASAN: slab-use-after-free in siw_query_port+0x37b/0x3e0 drivers/infiniband/sw/siw/siw_verbs.c:177
Read of size 4 at addr ffff888034efa0e8 by task kworker/1:4/24211

CPU: 1 PID: 24211 Comm: kworker/1:4 Not tainted 6.4.0-rc1-syzkaller-00012-g16a8829130ca #0
Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Workqueue: infiniband ib_cache_event_task
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 siw_query_port+0x37b/0x3e0 drivers/infiniband/sw/siw/siw_verbs.c:177
 iw_query_port drivers/infiniband/core/device.c:2049 [inline]
 ib_query_port drivers/infiniband/core/device.c:2090 [inline]
 ib_query_port+0x3c4/0x8f0 drivers/infiniband/core/device.c:2082
 ib_cache_update.part.0+0xcf/0x920 drivers/infiniband/core/cache.c:1487
 ib_cache_update drivers/infiniband/core/cache.c:1561 [inline]
 ib_cache_event_task+0x1b1/0x270 drivers/infiniband/core/cache.c:1561
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

It happened because netdev could be freed if the last reference
is released, but drivers still dereference netdev in query_port.
So let's guard query_port with dev_hold and dev_put.

Reported-by: syzbot+79f283f1f4ccc6e8b624@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/0000000000001f992805fb79ce97@google.com/
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
I guess another option could be call ib_device_get_netdev to get
netdev in siw_query_port instead of dereference netdev directly. 
If so, then other drivers (irdma_query_port and ocrdma_query_port)
may need to make relevant change as well.

 drivers/infiniband/core/device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a666847bd714..1f0aabeabc4e 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2016,6 +2016,7 @@ static int iw_query_port(struct ib_device *device,
 {
 	struct in_device *inetdev;
 	struct net_device *netdev;
+	int ret;
 
 	memset(port_attr, 0, sizeof(*port_attr));
 
@@ -2045,8 +2046,13 @@ static int iw_query_port(struct ib_device *device,
 		rcu_read_unlock();
 	}
 
+	/*
+	 * netdev need to be put after query port since it might be dereferenced
+	 * in some drivers such as siw.
+	 */
+	ret = device->ops.query_port(device, port_num, port_attr);
 	dev_put(netdev);
-	return device->ops.query_port(device, port_num, port_attr);
+	return ret;
 }
 
 static int __ib_query_port(struct ib_device *device,
-- 
2.35.3

