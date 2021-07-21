Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EB43D0BC9
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 12:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhGUIl2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 04:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236235AbhGUI0r (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 04:26:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15D7C60FE9;
        Wed, 21 Jul 2021 09:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626858444;
        bh=tbn33wjjVuiv3kzeE4HsxsCHrdDaV9aipcwfnmjZej8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LOr+h7hzgUvO5OSjbzse7dwqjjdsOmgqknQ509BDgZMwB8wZGKUbeN/2WTMneqYuE
         Bek655opyXn95IPmu0tNvQWVlgUmI49435M4HPrOBsVdWvkVLdTGMAoPybFPk42IIa
         TYmh1FZnVfn0i9+kf3l4Q4mp0NcxdVnZkAIz6+gNBfKrNYhaTxoW904qWxG8bjhhRa
         EzLEddSubnA/5ydhLJiXNRTtqAqzb44IlkT4ZFVZITuh42hoggP5SfmnWe+A49/O1w
         WtxWvJKPOzMZRZR8G50PV2vrwArW33/KlRseMsZvhpjBkcpQ4G9yE2MTTU1xl2lVr1
         yiwj3mgG7eg2w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH rdma-next v1 3/7] RDMA/core: Remove protection from wrong in-kernel API usage
Date:   Wed, 21 Jul 2021 12:07:06 +0300
Message-Id: <82dc7840fa802a17bf80a2f9a07c1433b204269c.1626857976.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626857976.git.leonro@nvidia.com>
References: <cover.1626857976.git.leonro@nvidia.com>
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

