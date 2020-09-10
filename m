Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9524C265317
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 23:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgIJV2Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 17:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731043AbgIJODs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 10:03:48 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43443221EC;
        Thu, 10 Sep 2020 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599746483;
        bh=QXwpAIdH1NaWXAWXUrDKGsXbnTJJMdEHmlLl7efnBxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Slka5RkZ5AAyL6Hq7LpLptv4NNlk/9atlqispJzYU+uIkRkVi48Q3jcp+W7j6jgo2
         PM37hru3zHRTA+xUbviC9Q7gmxlfilKaVQ+EdqQABtrS9PyKx4qlXDzcuCqdQjXmPC
         Ieo6n0mz1I/vbNQkr4LtUpwwwLUjM6HEZXJLet48=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Faisal Latif <faisal.latif@intel.com>,
        linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-next 10/10] RDMA/i40iw: Remove intermediate pointer that points to the same struct
Date:   Thu, 10 Sep 2020 17:00:46 +0300
Message-Id: <20200910140046.1306341-11-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910140046.1306341-1-leon@kernel.org>
References: <20200910140046.1306341-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

There is no real need to have an intermediate pointer for the same
struct, remove it, and use struct directly.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 9 +++------
 drivers/infiniband/hw/i40iw/i40iw_verbs.h | 1 -
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 4511e175c498..f5d54cb46f78 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -380,7 +380,7 @@ void i40iw_free_qp_resources(struct i40iw_device *iwdev,
 	i40iw_free_dma_mem(iwdev->sc_dev.hw, &iwqp->kqp.dma_mem);
 	kfree(iwqp->kqp.wrid_mem);
 	iwqp->kqp.wrid_mem = NULL;
-	kfree(iwqp->allocated_buffer);
+	kfree(iwqp);
 }
 
 /**
@@ -525,7 +525,6 @@ static struct ib_qp *i40iw_create_qp(struct ib_pd *ibpd,
 	struct i40iw_create_qp_req req;
 	struct i40iw_create_qp_resp uresp;
 	u32 qp_num = 0;
-	void *mem;
 	enum i40iw_status_code ret;
 	int err_code;
 	int sq_size;
@@ -567,12 +566,10 @@ static struct ib_qp *i40iw_create_qp(struct ib_pd *ibpd,
 	init_info.qp_uk_init_info.max_rq_frag_cnt = init_attr->cap.max_recv_sge;
 	init_info.qp_uk_init_info.max_inline_data = init_attr->cap.max_inline_data;
 
-	mem = kzalloc(sizeof(*iwqp), GFP_KERNEL);
-	if (!mem)
+	iwqp = kzalloc(sizeof(*iwqp), GFP_KERNEL);
+	if (!iwqp)
 		return ERR_PTR(-ENOMEM);
 
-	iwqp = (struct i40iw_qp *)mem;
-	iwqp->allocated_buffer = mem;
 	qp = &iwqp->sc_qp;
 	qp->back_qp = (void *)iwqp;
 	qp->push_idx = I40IW_INVALID_PUSH_PAGE_INDEX;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.h b/drivers/infiniband/hw/i40iw/i40iw_verbs.h
index 331bc21cbcc7..1bd790575bd4 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.h
@@ -138,7 +138,6 @@ struct i40iw_qp {
 	struct i40iw_pd *iwpd;
 	struct i40iw_qp_host_ctx_info ctx_info;
 	struct i40iwarp_offload_info iwarp_info;
-	void *allocated_buffer;
 	atomic_t refcount;
 	struct iw_cm_id *cm_id;
 	void *cm_node;
-- 
2.26.2

