Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5752DDD04
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 08:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfJTG2G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 02:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfJTG2G (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 02:28:06 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74CBC21929;
        Sun, 20 Oct 2019 06:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571552886;
        bh=4hs6ZuJR+xou+in6JAZvtPcQvXsfHaaN7zl6VdDLM3w=;
        h=From:To:Cc:Subject:Date:From;
        b=nSeSu6RqaQc/nUVBCtT7w164rk63MprjTD0cGsYgSn4JwrEtlEVAPTtuP5+n6h/UY
         495U2GYM9RdJuXpEadwJAf1R4h5HIf2AqwIOD/5PU/vmkubX+6fjiz3+IuMY1qA/eK
         as+uFl/7uKlqThSmWYTx2k317nTI/g9/8c2pGAkg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] RDMA/nldev: Skip counter if port doesn't match
Date:   Sun, 20 Oct 2019 09:28:00 +0300
Message-Id: <20191020062800.8065-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

Counter resource should return -EAGAIN if it was requested for other
part. Such situation can occur in multi-port systems.

Fixes: c4ffee7c9bdb ("RDMA/netlink: Implement counter dumpit calback")
Signed-off-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/nldev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 5e056d5e5be3..b61005f03166 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -832,7 +832,7 @@ static int fill_res_counter_entry(struct sk_buff *msg, bool has_cap_net_admin,
 		container_of(res, struct rdma_counter, res);
 
 	if (port && port != counter->port)
-		return 0;
+		return -EAGAIN;
 
 	/* Dump it even query failed */
 	rdma_counter_query_stats(counter);
-- 
2.20.1

