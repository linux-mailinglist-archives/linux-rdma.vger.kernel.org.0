Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47715F8D1
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfGDNEP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 09:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfGDNEP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Jul 2019 09:04:15 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79B8F218BA;
        Thu,  4 Jul 2019 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562245454;
        bh=04BJvRNOpN0kDh69tGIX4UvBaHSkEBKlOQUdl1kmrKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3VEf9yr3cGTqD3Z1z3NRjKPPqJ6CZ7JaeI9uhL5vx9QyKJQ0jg0e4K7mRVLq52hL
         ATxRwKDRCzV2x6EKKsMsphGFhwJs5tsRew1q1ZOAX2SkwLlOWSY5AWfTpbGnZpI+Kt
         0IzNkajK7mYI5uIRYU0pGUcfhtVVoeKwTA3ibJIM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rdma-next 1/2] IB/core: Work on the caller socket net namespace in nldev_newlink()
Date:   Thu,  4 Jul 2019 16:04:01 +0300
Message-Id: <20190704130402.8431-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190704130402.8431-1-leon@kernel.org>
References: <20190704130402.8431-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

While creating new RDMA devices based on netdevice name,
consider the net namespace of the caller skb's socket similar to rest of
the doit() callbacks and nldev_dellink() which deletes the RDMA device
created using nldev_newlink().

Fixes: 3856ec4b93c94 ("RDMA/core: Add RDMA_NLDEV_CMD_NEWLINK/DELLINK support")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/nldev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index d9f2a30e6467..783e465e7c41 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1476,7 +1476,7 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	nla_strlcpy(ndev_name, tb[RDMA_NLDEV_ATTR_NDEV_NAME],
 		    sizeof(ndev_name));

-	ndev = dev_get_by_name(&init_net, ndev_name);
+	ndev = dev_get_by_name(sock_net(skb->sk), ndev_name);
 	if (!ndev)
 		return -ENODEV;

--
2.20.1

