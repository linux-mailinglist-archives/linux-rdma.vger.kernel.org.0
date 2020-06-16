Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E121FAEC2
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 12:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFPK6b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 06:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPK6b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 06:58:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5BBF20786;
        Tue, 16 Jun 2020 10:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592305110;
        bh=a0A75i8CqznVgTY2KjPmWzUv06m9027ipUqUMxCXItk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmzxHw4UBmV0LxNgv9souqXAZcf9JiPNmX9tD65/3Z0UjEFAk/vj56Exn+cYTWMta
         00OdO4z8lV6opvh9Lsl4HUmUga1WwICw+NtmCZKHX320P579dlYYtjLrq9cP9DIg2s
         HlgWCNHrguv/plt5pl3P/n8YOtvZwOofLYVG8iSk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Steve Wise <larrystevenwise@gmail.com>
Subject: [PATCH rdma-next 2/7] IB/uverbs: Set IOVA on IB MR in uverbs layer
Date:   Tue, 16 Jun 2020 13:55:26 +0300
Message-Id: <20200616105531.2428010-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616105531.2428010-1-leon@kernel.org>
References: <20200616105531.2428010-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Set IOVA on IB MR in uverbs layer to let all drivers have it, this
includes both reg/rereg MR flows.
As part of this change cleaned-up this setting from the drivers that
already did it by themselves in their user flows.

Fixes: e6f0330106f4 ("mlx4_ib: set user mr attributes in struct ib_mr")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 4 ++++
 drivers/infiniband/hw/cxgb4/mem.c    | 1 -
 drivers/infiniband/hw/mlx4/mr.c      | 1 -
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index b48b3f6e632d..557644dcc923 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -770,6 +770,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	mr->uobject = uobj;
 	atomic_inc(&pd->usecnt);
 	mr->res.type = RDMA_RESTRACK_MR;
+	mr->iova = cmd.hca_va;
 	rdma_restrack_uadd(&mr->res);
 
 	uobj->object = mr;
@@ -861,6 +862,9 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 		atomic_dec(&old_pd->usecnt);
 	}
 
+	if (cmd.flags & IB_MR_REREG_TRANS)
+		mr->iova = cmd.hca_va;
+
 	memset(&resp, 0, sizeof(resp));
 	resp.lkey      = mr->lkey;
 	resp.rkey      = mr->rkey;
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index 962dc97a8ff2..1e4f4e525598 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -399,7 +399,6 @@ static int finish_mem_reg(struct c4iw_mr *mhp, u32 stag)
 	mmid = stag >> 8;
 	mhp->ibmr.rkey = mhp->ibmr.lkey = stag;
 	mhp->ibmr.length = mhp->attr.len;
-	mhp->ibmr.iova = mhp->attr.va_fbo;
 	mhp->ibmr.page_size = 1U << (mhp->attr.page_size + 12);
 	pr_debug("mmid 0x%x mhp %p\n", mmid, mhp);
 	return xa_insert_irq(&mhp->rhp->mrs, mmid, mhp, GFP_KERNEL);
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 7e0b205c05eb..d7c78f841d2f 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -439,7 +439,6 @@ struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	mr->ibmr.rkey = mr->ibmr.lkey = mr->mmr.key;
 	mr->ibmr.length = length;
-	mr->ibmr.iova = virt_addr;
 	mr->ibmr.page_size = 1U << shift;
 
 	return &mr->ibmr;
-- 
2.26.2

