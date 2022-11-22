Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853B26337CE
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 10:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiKVJCL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 04:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiKVJCK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 04:02:10 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4128BA456
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 01:02:09 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGdXq39dgzHw8f;
        Tue, 22 Nov 2022 17:01:31 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 17:02:06 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <lengchao@huawei.com>
Subject: [for-next PATCH] infiniband:cma: add a parameter for the packet lifetime
Date:   Tue, 22 Nov 2022 17:02:06 +0800
Message-ID: <20221122090206.865-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now the default packet lifetime(CMA_IBOE_PACKET_LIFETIME) is 18.
That means the minimum ack timeout is 2 seconds(2^(18+1)*4us=2.097seconds).
The packet lifetime means the maximum transmission time of packets
on the network, the maximum transmission time of packets is closely
related to the network. 2 seconds is too long for simple lossless networks.
The packet lifetime should allow the user to adjust according to the
network situation.
So add a parameter for the packet lifetime.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/infiniband/core/cma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index cc2222b85c88..8e2ff5d610e3 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -50,6 +50,10 @@ MODULE_LICENSE("Dual BSD/GPL");
 #define CMA_IBOE_PACKET_LIFETIME 18
 #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
 
+static unsigned char cma_packet_lifetime = CMA_IBOE_PACKET_LIFETIME;
+module_param_named(packet_lifetime, cma_packet_lifetime, byte, 0644);
+MODULE_PARM_DESC(packet_lifetime, "max transmission time of the packet");
+
 static const char * const cma_events[] = {
 	[RDMA_CM_EVENT_ADDR_RESOLVED]	 = "address resolved",
 	[RDMA_CM_EVENT_ADDR_ERROR]	 = "address error",
@@ -3301,7 +3305,7 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 	if (id_priv->timeout_set && id_priv->timeout)
 		route->path_rec->packet_life_time = id_priv->timeout - 1;
 	else
-		route->path_rec->packet_life_time = CMA_IBOE_PACKET_LIFETIME;
+		route->path_rec->packet_life_time = cma_packet_lifetime;
 	mutex_unlock(&id_priv->qp_mutex);
 
 	if (!route->path_rec->mtu) {
-- 
2.16.4

