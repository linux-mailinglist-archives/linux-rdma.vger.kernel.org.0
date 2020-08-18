Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E18824846B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 14:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHRMG1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 08:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgHRMGY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Aug 2020 08:06:24 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1925B204EA;
        Tue, 18 Aug 2020 12:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597752383;
        bh=vmmcNKLEUsG6Hv4Rq4+sXgVow8uqpOAGRzcOacOTd2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wrloCdTWPDN+6MV7RfCmxqnzxGRuHZcRx2I34vvus8Us0cnjEn60C2YLTc+oDOc7k
         N4hIB8bPIZmUewFCPLphjhgubYwXtq/iEmaWTWGy7dmWP/6wo1xWZfmemoNYAWU2q8
         UMzb6HZI77itaRMRyOJVvQeZc8S2SBnzfYJdLNyA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 10/14] RDMA/ucma: Add missing locking around rdma_leave_multicast()
Date:   Tue, 18 Aug 2020 15:05:22 +0300
Message-Id: <20200818120526.702120-11-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818120526.702120-1-leon@kernel.org>
References: <20200818120526.702120-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

All entry points to the rdma_cm from a ULP must be single threaded,
even this error unwinds. Add the missing locking.

Fixes: 7c11910783a1 ("RDMA/ucma: Put a lock around every call to the rdma_cm layer")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/ucma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index ca5c44cac48c..ad78b05de656 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1535,7 +1535,9 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	return 0;
 
 err3:
+	mutex_lock(&ctx->mutex);
 	rdma_leave_multicast(ctx->cm_id, (struct sockaddr *) &mc->addr);
+	mutex_unlock(&ctx->mutex);
 	ucma_cleanup_mc_events(mc);
 err2:
 	xa_erase(&multicast_table, mc->id);
-- 
2.26.2

