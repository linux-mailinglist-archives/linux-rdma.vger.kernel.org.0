Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6893DF48F
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 20:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbhHCSVE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 14:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239013AbhHCSVB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 14:21:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CD0B60FC2;
        Tue,  3 Aug 2021 18:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628014850;
        bh=tbn33wjjVuiv3kzeE4HsxsCHrdDaV9aipcwfnmjZej8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZ9rF5NdQphOWYFlczaO3f5nyLBZn7cSNZBFaRS22qlG4dc25pRp4OY/Ay7QotulQ
         7EL6pwXGZfDEgfRgHFxz5nbXzEb6l+rN2mstiL4Le7dGI799m7HIc96XPcG9ajYsBu
         hxTtvEWmxci8BqNKA/AvmOwKc2XFvOTeBonRe8Uc/YYCkfzl+jGWh0KlNcOtzg0lqq
         hZDJgsP0o1W6jCkbLIhmoSEeNApC7M7ivUVQRjiws4MtGqd8MNeON5DfIfyswhMyvx
         VhzEOFORjIkUUrSoFnrXgjFp00RHxCOtFDwesUPZSqnOYTXXkXQTi1ooVatfJCiWMK
         zM8Rvu5qOdnKA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next v2 3/7] RDMA/core: Remove protection from wrong in-kernel API usage
Date:   Tue,  3 Aug 2021 21:20:34 +0300
Message-Id: <b9b9e981d1af148b750750196e686199dbbf61f8.1628014762.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628014762.git.leonro@nvidia.com>
References: <cover.1628014762.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The ib_create_named_qp() is kernel verb that is not used for user
supplied attributes. In such case, it is ULP responsibility to provide
valid QP attributes.

In-kernel API shouldn't check it, exactly like other functions that
don't check device capabilities.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 635642a3ecbc..2090f3c9f689 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1219,16 +1219,6 @@ struct ib_qp *ib_create_named_qp(struct ib_pd *pd,
 	struct ib_qp *qp;
 	int ret;
 
-	if (qp_init_attr->rwq_ind_tbl &&
-	    (qp_init_attr->recv_cq ||
-	    qp_init_attr->srq || qp_init_attr->cap.max_recv_wr ||
-	    qp_init_attr->cap.max_recv_sge))
-		return ERR_PTR(-EINVAL);
-
-	if ((qp_init_attr->create_flags & IB_QP_CREATE_INTEGRITY_EN) &&
-	    !(device->attrs.device_cap_flags & IB_DEVICE_INTEGRITY_HANDOVER))
-		return ERR_PTR(-EINVAL);
-
 	/*
 	 * If the callers is using the RDMA API calculate the resources
 	 * needed for the RDMA READ/WRITE operations.
-- 
2.31.1

