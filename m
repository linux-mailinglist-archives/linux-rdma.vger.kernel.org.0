Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB6F60C1DA
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 04:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJYCpT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 22:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiJYCpS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 22:45:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E9213F3C;
        Mon, 24 Oct 2022 19:45:16 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MxGQ468rkzVj6p;
        Tue, 25 Oct 2022 10:40:28 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:45:14 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:45:14 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <jgg@ziepe.ca>, <leon@kernel.org>,
        <wsa+renesas@sang-engineering.com>, <avihaih@nvidia.com>,
        <raeds@nvidia.com>, <penguin-kernel@I-love.SAKURA.ne.jp>,
        <dledford@redhat.com>, <matanb@mellanox.com>,
        <chenzhongjin@huawei.com>
Subject: [PATCH] RDMA/core: Fix null-ptr-deref in ib_core_cleanup()
Date:   Tue, 25 Oct 2022 10:41:46 +0800
Message-ID: <20221025024146.109137-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

KASAN reported a null-ptr-deref error:

KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
CPU: 1 PID: 379
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
RIP: 0010:destroy_workqueue+0x2f/0x740
RSP: 0018:ffff888016137df8 EFLAGS: 00000202
...
Call Trace:
 <TASK>
 ib_core_cleanup+0xa/0xa1 [ib_core]
 __do_sys_delete_module.constprop.0+0x34f/0x5b0
 do_syscall_64+0x3a/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa1a0d221b7
...
 </TASK>

It is because the fail of roce_gid_mgmt_init() is ignored:

ib_core_init()
  roce_gid_mgmt_init()
    gid_cache_wq = alloc_ordered_workqueue # fail
...
ib_core_cleanup()
  roce_gid_mgmt_cleanup()
    destroy_workqueue(gid_cache_wq)
    # destroy an unallocated wq

Fix this by catching the fail of roce_gid_mgmt_init() in ib_core_init().

Fixes: 03db3a2d81e6 ("IB/core: Add RoCE GID table management")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 drivers/infiniband/core/device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index ae60c73babcc..b45431e6817b 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2815,10 +2815,18 @@ static int __init ib_core_init(void)
 
 	nldev_init();
 	rdma_nl_register(RDMA_NL_LS, ibnl_ls_cb_table);
-	roce_gid_mgmt_init();
+	ret = roce_gid_mgmt_init();
+	if (ret) {
+		pr_warn("Couldn't init RoCE GID management\n");
+		goto err_parent;
+	}
 
 	return 0;
 
+err_parent:
+	nldev_exit();
+	rdma_nl_unregister(RDMA_NL_LS);
+	unregister_pernet_device(&rdma_dev_net_ops);
 err_compat:
 	unregister_blocking_lsm_notifier(&ibdev_lsm_nb);
 err_sa:
-- 
2.17.1

