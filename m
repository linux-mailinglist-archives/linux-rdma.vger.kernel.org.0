Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708742D993B
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Dec 2020 14:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgLNNmh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Dec 2020 08:42:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9605 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730343AbgLNNmg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Dec 2020 08:42:36 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CvjGC50gnzM2Nc;
        Mon, 14 Dec 2020 21:41:07 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:41:47 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] ulp/ipoib/ipoib_multicast: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:42:18 +0800
Message-ID: <20201214134218.4510-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 86e4ed64e4e2..e3e4447c0f51 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -275,7 +275,7 @@ static int ipoib_mcast_join_finish(struct ipoib_mcast *mcast,
 
 	memset(&av, 0, sizeof(av));
 	av.type = rdma_ah_find_type(priv->ca, priv->port);
-	rdma_ah_set_dlid(&av, be16_to_cpu(mcast->mcmember.mlid)),
+	rdma_ah_set_dlid(&av, be16_to_cpu(mcast->mcmember.mlid));
 	rdma_ah_set_port_num(&av, priv->port);
 	rdma_ah_set_sl(&av, mcast->mcmember.sl);
 	rdma_ah_set_static_rate(&av, mcast->mcmember.rate);
-- 
2.22.0

