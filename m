Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1621189E8F
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 16:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgCRPDB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 11:03:01 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:38034 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726757AbgCRPDB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 11:03:01 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 18 Mar 2020 17:02:57 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02IF2vEO008733;
        Wed, 18 Mar 2020 17:02:57 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, bvanassche@acm.org, linux-rdma@vger.kernel.org
Cc:     kbusch@kernel.org, leonro@mellanox.com, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, rgirase@redhat.com,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH v2 4/5] RDMA/srpt: use ib_alloc_cq instead of ib_alloc_cq_any
Date:   Wed, 18 Mar 2020 17:02:56 +0200
Message-Id: <20200318150257.198402-5-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200318150257.198402-1-maxg@mellanox.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For spreading the completion vectors fairly, add global ida for RDMA
channeles and use ida_simple_{get,remove} API. This is a preparation
for the SRQ per core feature.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 21 +++++++++++++++++----
 drivers/infiniband/ulp/srpt/ib_srpt.h |  2 ++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 9855274..d0294d8 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -89,6 +89,8 @@ static int srpt_get_u64_x(char *buffer, const struct kernel_param *kp)
 		 "Using this value for ioc_guid, id_ext, and cm_listen_id instead of using the node_guid of the first HCA.");
 
 static struct ib_client srpt_client;
+/* Will be used to allocate an index for srpt_rdma_ch. */
+static DEFINE_IDA(srpt_channel_ida);
 /* Protects both rdma_cm_port and rdma_cm_id. */
 static DEFINE_MUTEX(rdma_cm_mutex);
 /* Port number RDMA/CM will bind to. */
@@ -1779,7 +1781,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	struct srpt_device *sdev = sport->sdev;
 	const struct ib_device_attr *attrs = &sdev->device->attrs;
 	int sq_size = sport->port_attrib.srp_sq_size;
-	int i, ret;
+	int i, ret, comp_vector;
 
 	WARN_ON(ch->rq_size < 1);
 
@@ -1788,9 +1790,11 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	if (!qp_init)
 		goto out;
 
+	 /* Spread the io channeles across completion vectors */
+	comp_vector = ch->idx % sdev->device->num_comp_vectors;
 retry:
-	ch->cq = ib_alloc_cq_any(sdev->device, ch, ch->rq_size + sq_size,
-				 IB_POLL_WORKQUEUE);
+	ch->cq = ib_alloc_cq(sdev->device, ch, ch->rq_size + sq_size,
+			     comp_vector, IB_POLL_WORKQUEUE);
 	if (IS_ERR(ch->cq)) {
 		ret = PTR_ERR(ch->cq);
 		pr_err("failed to create CQ cqe= %d ret= %d\n",
@@ -2119,6 +2123,8 @@ static void srpt_release_channel_work(struct work_struct *w)
 
 	kmem_cache_destroy(ch->req_buf_cache);
 
+	ida_simple_remove(&srpt_channel_ida, ch->idx);
+
 	kref_put(&ch->kref, srpt_free_ch);
 }
 
@@ -2215,6 +2221,10 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 		goto reject;
 	}
 
+	ch->idx = ida_simple_get(&srpt_channel_ida, 0, 0, GFP_KERNEL);
+	if (ch->idx < 0)
+		goto free_ch;
+
 	kref_init(&ch->kref);
 	ch->pkey = be16_to_cpu(pkey);
 	ch->nexus = nexus;
@@ -2243,7 +2253,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 	ch->rsp_buf_cache = kmem_cache_create("srpt-rsp-buf", ch->max_rsp_size,
 					      512, 0, NULL);
 	if (!ch->rsp_buf_cache)
-		goto free_ch;
+		goto free_idx;
 
 	ch->ioctx_ring = (struct srpt_send_ioctx **)
 		srpt_alloc_ioctx_ring(ch->sport->sdev, ch->rq_size,
@@ -2478,6 +2488,8 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 free_rsp_cache:
 	kmem_cache_destroy(ch->rsp_buf_cache);
 
+free_idx:
+	ida_simple_remove(&srpt_channel_ida, ch->idx);
 free_ch:
 	if (rdma_cm_id)
 		rdma_cm_id->context = NULL;
@@ -3916,6 +3928,7 @@ static void __exit srpt_cleanup_module(void)
 		rdma_destroy_id(rdma_cm_id);
 	ib_unregister_client(&srpt_client);
 	target_unregister_template(&srpt_template);
+	ida_destroy(&srpt_channel_ida);
 }
 
 module_init(srpt_init_module);
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index 2e1a698..5c40653 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -292,6 +292,7 @@ enum rdma_ch_state {
  * @sess:          Session information associated with this SRP channel.
  * @sess_name:     Session name.
  * @release_work:  Allows scheduling of srpt_release_channel().
+ * @idx:           channel index.
  */
 struct srpt_rdma_ch {
 	struct srpt_nexus	*nexus;
@@ -331,6 +332,7 @@ struct srpt_rdma_ch {
 	struct se_session	*sess;
 	u8			sess_name[40];
 	struct work_struct	release_work;
+	int			idx;
 };
 
 /**
-- 
1.8.3.1

