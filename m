Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B362C1F73EE
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2020 08:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgFLGfJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jun 2020 02:35:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5880 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbgFLGfJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jun 2020 02:35:09 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A43A7391322C2965F40D;
        Fri, 12 Jun 2020 14:35:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Fri, 12 Jun 2020 14:35:01 +0800
From:   Guo Fan <guofan5@huawei.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH] IB/mad: fix possible memory leak in ib_mad_post_receive_mads()
Date:   Fri, 12 Jun 2020 14:38:24 +0800
Message-ID: <20200612063824.180611-1-guofan5@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Fan Guo <guofan5@huawei.com>

If ib_dma_mapping_error() returns non-zero value, ib_mad_post_receive_mads
will jump out of loops and return -ENOMEM without freeing mad_priv. We fix
this memory-leak problem by freeing mad_priv in this case.

Fixes: 2c34e68f4261 ("IB/mad: Check and handle potential DMA mapping errors")
Signed-off-by: Fan Guo <guofan5@huawei.com>
---
 drivers/infiniband/core/mad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 186e0d652e8b..5e080191a725 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2718,6 +2718,7 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 						 DMA_FROM_DEVICE);
 		if (unlikely(ib_dma_mapping_error(qp_info->port_priv->device,
 						  sg_list.addr))) {
+			kfree(mad_priv);
 			ret = -ENOMEM;
 			break;
 		}
-- 
2.25.1

