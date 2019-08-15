Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6627B8E6F8
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 10:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfHOIim (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 04:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfHOIim (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 04:38:42 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA48322387;
        Thu, 15 Aug 2019 08:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565858322;
        bh=aEhbEIJvaeRc9m9j1JAXD6aHvWZvVWRh38CHquhzCek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pqnU0RTlMGztRP8O2bL4bchYzja4KaUX9y7DUJGfdMErplH0z327oynhzz1oeGv6b
         77dItO0tH/3BePrWB8UwHuBlljPpVhynDfgjx/h8xyMpqJ04y9bb3N9I0bYTRfrume
         IWn9dwrD0mTOLZFp/1f5m5rgsl97fAVpYEJGQRH0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Ido Kalir <idok@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-rc 1/8] IB/core: Fix NULL pointer dereference when bind QP to counter
Date:   Thu, 15 Aug 2019 11:38:27 +0300
Message-Id: <20190815083834.9245-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815083834.9245-1-leon@kernel.org>
References: <20190815083834.9245-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ido Kalir <idok@mellanox.com>

If QP is not visible to the pid, then we try to decrease its reference
count and return from the function before the QP pointer is
initialized. This lead to NULL pointer dereference.
Fix it by pass directly the res to the rdma_restract_put as arg instead of
&qp->res.

This fixes below call trace:
[ 5845.110329] BUG: kernel NULL pointer dereference, address:
00000000000000dc
[ 5845.120482] Oops: 0002 [#1] SMP PTI
[ 5845.129119] RIP: 0010:rdma_restrack_put+0x5/0x30 [ib_core]
[ 5845.169450] Call Trace:
[ 5845.170544]  rdma_counter_get_qp+0x5c/0x70 [ib_core]
[ 5845.172074]  rdma_counter_bind_qpn_alloc+0x6f/0x1a0 [ib_core]
[ 5845.173731]  nldev_stat_set_doit+0x314/0x330 [ib_core]
[ 5845.175279]  rdma_nl_rcv_msg+0xeb/0x1d0 [ib_core]
[ 5845.176772]  ? __kmalloc_node_track_caller+0x20b/0x2b0
[ 5845.178321]  rdma_nl_rcv+0xcb/0x120 [ib_core]
[ 5845.179753]  netlink_unicast+0x179/0x220
[ 5845.181066]  netlink_sendmsg+0x2d8/0x3d0
[ 5845.182338]  sock_sendmsg+0x30/0x40
[ 5845.183544]  __sys_sendto+0xdc/0x160
[ 5845.184832]  ? syscall_trace_enter+0x1f8/0x2e0
[ 5845.186209]  ? __audit_syscall_exit+0x1d9/0x280
[ 5845.187584]  __x64_sys_sendto+0x24/0x30
[ 5845.188867]  do_syscall_64+0x48/0x120
[ 5845.190097]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 1bd8e0a9d0fd1 ("RDMA/counter: Allow manual mode configuration support")
Signed-off-by: Ido Kalir <idok@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index b79890739a2c..955d061af06a 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -424,7 +424,7 @@ static struct ib_qp *rdma_counter_get_qp(struct ib_device *dev, u32 qp_num)
 	return qp;
 
 err:
-	rdma_restrack_put(&qp->res);
+	rdma_restrack_put(res);
 	return NULL;
 }
 
-- 
2.20.1

