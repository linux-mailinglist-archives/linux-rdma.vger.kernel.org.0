Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30D0633547
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 07:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiKVG2Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 01:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiKVG2W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 01:28:22 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398ECB7CE;
        Mon, 21 Nov 2022 22:27:52 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NGZ6x1d9wz15Mps;
        Tue, 22 Nov 2022 14:27:21 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 14:27:49 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <markzhang@nvidia.com>,
        <haakon.bugge@oracle.com>, <mbloch@nvidia.com>
CC:     <sean.hefty@intel.com>, <rolandd@cisco.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wang Yufen <wangyufen@huawei.com>
Subject: [PATCH] infiniband: cma: fix the dev refcnt leak
Date:   Tue, 22 Nov 2022 14:47:53 +0800
Message-ID: <1669099673-12213-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Syzbot report the following issue:
  infiniband syj1: RDMA CMA: cma_listen_on_dev, error -98
  unregister_netdevice: waiting for vlan0 to become free. Usage count = 2

The causes are as follows:

rdma_listen()
  rdma_bind_addr()
    cma_acquire_dev_by_src_ip()
      cma_attach_to_dev()
        _cma_attach_to_dev()
          cma_dev_get()

  cma_check_port()
  <--The return value is -98， goto err

err:
<-- The error handling here is missing the operation of cma_release_dev.

To fix, add cma_release_dev to error handing.

Fixes: e51060f08a61 ("IB: IP address based RDMA connection manager")
Reported-by: syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
---
 drivers/infiniband/core/cma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 26d1772..3a50a8e 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4049,6 +4049,9 @@ int rdma_listen(struct rdma_cm_id *id, int backlog)
 	return 0;
 err:
 	id_priv->backlog = 0;
+	if (id_priv->cma_dev)
+		cma_release_dev(id_priv);
+
 	/*
 	 * All the failure paths that lead here will not allow the req_handler's
 	 * to have run.
-- 
1.8.3.1

