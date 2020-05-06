Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642AA1C6B97
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 10:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgEFIZA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 04:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbgEFIZA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 04:25:00 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BEB720714;
        Wed,  6 May 2020 08:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588753500;
        bh=IShz6PM5LOq/KW0OC3D+5ZEtm7aNeeCGItheaOxcO8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYsNNI2DbVPML77JfiomL3Bc8cQs0WJI2pOkdbXYAug2JwEds0yc9M0wNwiWU1o7O
         t4k26/izfnJUvmXL8CEyLgewhvqLuzc/rGyO7tGLNuzxq22rx3Xf1M0jiUhrQi7Yx6
         QdaLc7TiKSeQEdR6Seg5LoXlznu4r/0Lo/i+i4Sw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 04/10] IB/uverbs: Cleanup wq/srq context usage from uverbs layer
Date:   Wed,  6 May 2020 11:24:38 +0300
Message-Id: <20200506082444.14502-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506082444.14502-1-leon@kernel.org>
References: <20200506082444.14502-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Both wq_context and srq_context are some leftover from the past in
uverbs layer, they are not really in use, drop them.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 1d147beaf4cc..4cdc9bebd114 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2966,7 +2966,6 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	wq_init_attr.cq = cq;
 	wq_init_attr.max_sge = cmd.max_sge;
 	wq_init_attr.max_wr = cmd.max_wr;
-	wq_init_attr.wq_context = attrs->ufile;
 	wq_init_attr.wq_type = cmd.wq_type;
 	wq_init_attr.event_handler = ib_uverbs_wq_event_handler;
 	wq_init_attr.create_flags = cmd.create_flags;
@@ -2984,7 +2983,6 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	wq->cq = cq;
 	wq->pd = pd;
 	wq->device = pd->device;
-	wq->wq_context = wq_init_attr.wq_context;
 	atomic_set(&wq->usecnt, 0);
 	atomic_inc(&pd->usecnt);
 	atomic_inc(&cq->usecnt);
@@ -3458,7 +3456,6 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 	}
 
 	attr.event_handler  = ib_uverbs_srq_event_handler;
-	attr.srq_context    = attrs->ufile;
 	attr.srq_type       = cmd->srq_type;
 	attr.attr.max_wr    = cmd->max_wr;
 	attr.attr.max_sge   = cmd->max_sge;
@@ -3477,7 +3474,6 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 	srq->srq_type	   = cmd->srq_type;
 	srq->uobject       = obj;
 	srq->event_handler = attr.event_handler;
-	srq->srq_context   = attr.srq_context;
 
 	ret = pd->device->ops.create_srq(srq, &attr, udata);
 	if (ret)
-- 
2.26.2

