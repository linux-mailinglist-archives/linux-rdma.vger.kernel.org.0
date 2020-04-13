Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B4D1A6738
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 15:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgDMNjL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 09:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730096AbgDMNjK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 09:39:10 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D93B22073E;
        Mon, 13 Apr 2020 13:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586785150;
        bh=m9v40O4z5rM63QUIyriPSECKuk0t4XqmpU4Iy8jlXjc=;
        h=From:To:Cc:Subject:Date:From;
        b=2XEyMS5USz/GfwizdrZhzDZX4qYzX8Fq47hqIQ70SfP+Mud+zDcTDMy1kXjwtSSDx
         f75JAPzTvDT8e+yRdunTEbd4egsv2olGik2nndWi0vDWaU5ZaQB+TKwjTBsCuyOxqe
         wRufhfaujsfW6Fv+UCJ/yndq4Ttc8fonnY8Lc7RU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/rw: use DIV_ROUND_UP to calculate nr_ops
Date:   Mon, 13 Apr 2020 16:39:05 +0300
Message-Id: <20200413133905.933343-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Max Gurtovoy <maxg@mellanox.com>

Don't open-code DIV_ROUND_UP() kernel macro.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/rw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 557efbf29197..614cff89fc71 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -129,7 +129,7 @@ static int rdma_rw_init_mr_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 						    qp->integrity_en);
 	int i, j, ret = 0, count = 0;
 
-	ctx->nr_ops = (sg_cnt + pages_per_mr - 1) / pages_per_mr;
+	ctx->nr_ops = DIV_ROUND_UP(sg_cnt, pages_per_mr);
 	ctx->reg = kcalloc(ctx->nr_ops, sizeof(*ctx->reg), GFP_KERNEL);
 	if (!ctx->reg) {
 		ret = -ENOMEM;
-- 
2.25.2

