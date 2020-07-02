Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E8F211ECE
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 10:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgGBI3m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 04:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgGBI3m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jul 2020 04:29:42 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4274C20720;
        Thu,  2 Jul 2020 08:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593678582;
        bh=+yVN9qFSArUa1hfhdBDxqF3LYMkW4mGllJcGh+PS8Ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JoBpGqN485LKXG1WNekS1Ifg3JAtMQmrF2mVIIr996ZfY3l7YndLUHiCsJB/gIecM
         gLwiaubEXwTa6aqxHxWEOA5uAxyvTcyHV+mE5ksxWIErik6VYmiqC2+Hyex0fgC9eI
         0yvjvFIm83LBbYRTyBvAaPD7lB0WxSSf8vkpLBAM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Majd Dibbiny <majd@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 2/3] RDMA/counter: Only bind user QPs in auto mode
Date:   Thu,  2 Jul 2020 11:29:32 +0300
Message-Id: <20200702082933.424537-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702082933.424537-1-leon@kernel.org>
References: <20200702082933.424537-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

In auto mode only bind user QPs to a dynamic counter, since this feature
is mainly used for system statistic and diagnostic purpose, while there's
no need to counter kernel QPs so far.

Fixes: 99fa331dc862 ("RDMA/counter: Add "auto" configuration mode support")
Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 9ec8631c3970..104df52e9bdb 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -278,7 +278,7 @@ int rdma_counter_bind_qp_auto(struct ib_qp *qp, u8 port)
 	struct rdma_counter *counter;
 	int ret;
 
-	if (!qp->res.valid)
+	if (!qp->res.valid || rdma_is_kernel_res(&qp->res))
 		return 0;
 
 	if (!rdma_is_port_valid(dev, port))
-- 
2.26.2

