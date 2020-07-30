Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2462232EAF
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jul 2020 10:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgG3I1j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jul 2020 04:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:32938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728883AbgG3I1i (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jul 2020 04:27:38 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD3D7204EA;
        Thu, 30 Jul 2020 08:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596097658;
        bh=I20Wd8J35yHT4BDP2/IuPk0Ezp3QLZbYUq98bZSuVlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isc+ZFdOqSWYjCOhjBhmqWFUXtBHMvibePkKFEerHPFbD9wRlRIh9UUKzI8AIhV1b
         uq2jbLjIzkGdrSP9o4gE7vQjBhCPREIReJ3e/ZiwougCUAt9wNR3POWSwcwlZkrstV
         0mdSPo02dyrJYLG+PwJH1xVcdnLahc9XfQguzYr4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH rdma-rc 3/3] RDMA/core: Free DIM memory in error unwind
Date:   Thu, 30 Jul 2020 11:27:19 +0300
Message-Id: <20200730082719.1582397-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200730082719.1582397-1-leon@kernel.org>
References: <20200730082719.1582397-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The memory allocated for the DIM wasn't freed in in error unwind path,
fix it by calling to rdma_dim_destroy().

Fixes: da6629793aa6 ("RDMA/core: Provide RDMA DIM support for ULPs")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 33759b39c3d3..513825e424bf 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -275,6 +275,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 	return cq;
 
 out_destroy_cq:
+	rdma_dim_destroy(cq);
 	rdma_restrack_del(&cq->res);
 	cq->device->ops.destroy_cq(cq, udata);
 out_free_wc:
-- 
2.26.2

