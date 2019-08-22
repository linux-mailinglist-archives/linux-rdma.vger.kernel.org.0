Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57072196773
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 17:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgC1Qng (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 12:43:36 -0400
Received: from mx.sdf.org ([205.166.94.20]:49996 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbgC1Qnf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:35 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhNhF000428
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:23 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhN9T020186;
        Sat, 28 Mar 2020 16:43:23 GMT
Message-Id: <202003281643.02SGhN9T020186@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Wed, 21 Aug 2019 20:21:45 -0400
Subject: [RFC PATCH v1 42/50] drivers/ininiband: Use get_random_u32()
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There's no need to get_random_bytes() into a temporary buffer.

This is not a no-brainer change; get_random_u32() has slightly weaker
security guarantees, but code like this is the classic example of when
it's appropriate: the random value is stored in the kernel for as long
as it's valuable.

TODO: Could any of the call sites be further weakened to prandom_u32()?
If we're randomizing to avoid collisions with a *cooperating* (as opposed
to malicious) partner, we don't need cryptographic strength.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-rdma@vger.kernel.org
Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/core/cm.c              | 2 +-
 drivers/infiniband/core/cma.c             | 3 +--
 drivers/infiniband/core/sa_query.c        | 2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 2 +-
 drivers/infiniband/sw/siw/siw_mem.c       | 9 ++-------
 drivers/infiniband/sw/siw/siw_verbs.c     | 2 +-
 drivers/infiniband/ulp/srp/ib_srp.c       | 3 +--
 7 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 4decc1d4cc997..8af4368faf8ee 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -4449,7 +4449,7 @@ static int __init ib_cm_init(void)
 	cm.remote_qp_table = RB_ROOT;
 	cm.remote_sidr_table = RB_ROOT;
 	xa_init_flags(&cm.local_id_table, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
-	get_random_bytes(&cm.random_id_operand, sizeof cm.random_id_operand);
+	cm.random_id_operand = (__force __be32)get_random_u32();
 	INIT_LIST_HEAD(&cm.timewait_list);
 
 	ret = class_register(&cm_class);
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index a5874d2fac54e..1fce71e625c15 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -873,9 +873,8 @@ struct rdma_cm_id *__rdma_create_id(struct net *net,
 	mutex_init(&id_priv->handler_mutex);
 	INIT_LIST_HEAD(&id_priv->listen_list);
 	INIT_LIST_HEAD(&id_priv->mc_list);
-	get_random_bytes(&id_priv->seq_num, sizeof id_priv->seq_num);
+	id_priv->seq_num = get_random_u32() & 0x00ffffff;
 	id_priv->id.route.addr.dev_addr.net = get_net(net);
-	id_priv->seq_num &= 0x00ffffff;
 
 	return &id_priv->id;
 }
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 30d4c126a2db0..0db882e247234 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -2426,7 +2426,7 @@ int ib_sa_init(void)
 {
 	int ret;
 
-	get_random_bytes(&tid, sizeof tid);
+	tid = get_random_u32();
 
 	atomic_set(&ib_nl_sa_request_seq, 0);
 
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index dbd96d029d8bd..4c62b3a4f4233 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1262,7 +1262,7 @@ static u32 i40iw_create_stag(struct i40iw_device *iwdev)
 	u8 consumer_key;
 	int ret;
 
-	get_random_bytes(&random, sizeof(random));
+	random = get_random_u32();
 	consumer_key = (u8)random;
 
 	driver_key = random & ~iwdev->mr_stagmask;
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index e99983f076631..50c84f6a98e51 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -21,10 +21,7 @@
 int siw_mem_add(struct siw_device *sdev, struct siw_mem *m)
 {
 	struct xa_limit limit = XA_LIMIT(1, 0x00ffffff);
-	u32 id, next;
-
-	get_random_bytes(&next, 4);
-	next &= 0x00ffffff;
+	u32 id, next = get_random_u32() & 0x00ffffff;
 
 	if (xa_alloc_cyclic(&sdev->mem_xa, &id, m, limit, &next,
 	    GFP_KERNEL) < 0)
@@ -107,9 +104,7 @@ int siw_mr_add_mem(struct siw_mr *mr, struct ib_pd *pd, void *mem_obj,
 	kref_init(&mem->ref);
 
 	mr->mem = mem;
-
-	get_random_bytes(&next, 4);
-	next &= 0x00ffffff;
+	next = get_random_u32() & 0x00ffffff;
 
 	if (xa_alloc_cyclic(&sdev->mem_xa, &id, mem, limit, &next,
 	    GFP_KERNEL) < 0) {
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 5fd6d6499b3d7..42f3ced4ca7c7 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1139,7 +1139,7 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 		rv = -ENOMEM;
 		goto err_out;
 	}
-	get_random_bytes(&cq->id, 4);
+	cq->id = get_random_u32();
 	siw_dbg(base_cq->device, "new CQ [%u]\n", cq->id);
 
 	spin_lock_init(&cq->lock);
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index cd1181c39ed29..2a954db0d6b55 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -903,8 +903,7 @@ static int srp_send_req(struct srp_rdma_ch *ch, uint32_t max_iu_len,
 		req->ib_param.primary_path = &ch->ib_cm.path;
 		req->ib_param.alternate_path = NULL;
 		req->ib_param.service_id = target->ib_cm.service_id;
-		get_random_bytes(&req->ib_param.starting_psn, 4);
-		req->ib_param.starting_psn &= 0xffffff;
+		req->ib_param.starting_psn = get_random_u32() & 0xffffff;
 		req->ib_param.qp_num = ch->qp->qp_num;
 		req->ib_param.qp_type = ch->qp->qp_type;
 		req->ib_param.local_cm_response_timeout = subnet_timeout + 2;
-- 
2.26.0

