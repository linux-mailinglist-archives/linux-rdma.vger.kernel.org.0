Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7F06381FD
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Nov 2022 02:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKYBAb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Nov 2022 20:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKYBAb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Nov 2022 20:00:31 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB1CB7F1
        for <linux-rdma@vger.kernel.org>; Thu, 24 Nov 2022 17:00:29 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NJGjk4b6gz15Md7;
        Fri, 25 Nov 2022 08:59:54 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 25 Nov
 2022 09:00:27 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <lengchao@huawei.com>, <linux-rdma@vger.kernel.org>
Subject: [PATCH] infiniband:cma: change iboe packet life time from 18 to 16
Date:   Fri, 25 Nov 2022 09:00:26 +0800
Message-ID: <20221125010026.755-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The ack timeout retransmission time is affected by the following two
factors: one is packet life time, another is the HCA processing time.
Now the default packet lifetime(CMA_IBOE_PACKET_LIFETIME) is 18.
That means the minimum ack timeout is 2 seconds(2^(18+1)*4us=2.097seconds).
The packet lifetime means the maximum transmission time of packets
on the network, 2 seconds is too long.
Assume the network is a clos topology with three layers, every packet
will pass through five hops of switches. Assume the buffer of every
switch is 128MB and the port transmission rate is 25 Gbit/s,
the maximum transmission time of the packet is 200ms(128MB*5/25Gbit/s).
Add double redundancy, it is less than 500ms.
So change the CMA_IBOE_PACKET_LIFETIME to 16,
the maximum transmission time of the packet will be about 500+ms,
it is long enough.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/infiniband/core/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index cc2222b85c88..2f5b5e6f3d11 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -47,7 +47,7 @@ MODULE_LICENSE("Dual BSD/GPL");
 #define CMA_CM_RESPONSE_TIMEOUT 20
 #define CMA_MAX_CM_RETRIES 15
 #define CMA_CM_MRA_SETTING (IB_CM_MRA_FLAG_DELAY | 24)
-#define CMA_IBOE_PACKET_LIFETIME 18
+#define CMA_IBOE_PACKET_LIFETIME 16
 #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
 
 static const char * const cma_events[] = {
-- 
2.16.4

