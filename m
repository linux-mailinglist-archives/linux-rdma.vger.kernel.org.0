Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20046279860
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Sep 2020 12:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgIZKZ2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Sep 2020 06:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgIZKZ2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Sep 2020 06:25:28 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 517A4238E6;
        Sat, 26 Sep 2020 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601115928;
        bh=VGWfwDfIOXhvRWkudvLTf0g3DPOBWkcShEILY+1SZB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3qXpuJu4uGtmAST2fCpFZcbGyojdTx/r9qefnZcHFBksaghqlWv7Iomw6YA1Fed2
         N91lpuMwE+qK48YcQPey0Nk74lenaa2ko3EReSRoo/kX6ssABk/WczBP7GaABhOxLZ
         qDzj8Ns+6JzuL3R6uFxwu97wgbcP64UkP025cXdo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Faisal Latif <faisal.latif@intel.com>,
        linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-next v1 10/10] RDMA/i40iw: Remove intermediate pointer that points to the same struct
Date:   Sat, 26 Sep 2020 13:24:50 +0300
Message-Id: <20200926102450.2966017-11-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200926102450.2966017-1-leon@kernel.org>
References: <20200926102450.2966017-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

There is no real need to have an intermediate pointer for the same
struct, remove it, and use struct directly.

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index ffb692d619b2..747b4de6faca 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -380,7 +380,7 @@ void i40iw_free_qp_resources(struct i40iw_qp *iwqp)
 	i40iw_free_dma_mem(iwdev->sc_dev.hw, &iwqp->kqp.dma_mem);
 	kfree(iwqp->kqp.wrid_mem);
 	iwqp->kqp.wrid_mem = NULL;
-	kfree(iwqp->allocated_buffer);
+	kfree(iwqp);
 }
 
 /**
@@ -537,7 +537,6 @@ static struct ib_qp *i40iw_create_qp(struct ib_pd *ibpd,
 	struct i40iw_create_qp_req req;
 	struct i40iw_create_qp_resp uresp;
 	u32 qp_num = 0;
-	void *mem;
 	enum i40iw_status_code ret;
 	int err_code;
 	int sq_size;
@@ -579,12 +578,10 @@ static struct ib_qp *i40iw_create_qp(struct ib_pd *ibpd,
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
-- 
2.26.2

