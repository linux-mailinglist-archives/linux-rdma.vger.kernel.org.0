Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AF635664F
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 10:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbhDGISu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 04:18:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16373 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbhDGISt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 04:18:49 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FFcgS4cdnzjYY3;
        Wed,  7 Apr 2021 16:16:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 16:18:29 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 4/7] RDMA/core: Remove redundant spaces
Date:   Wed, 7 Apr 2021 16:15:50 +0800
Message-ID: <1617783353-48249-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617783353-48249-1-git-send-email-liweihang@huawei.com>
References: <1617783353-48249-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

Space is not required after '(', before ')', before ',' and between '*'
and symbol name of a definition.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/cm.c         | 31 +++++++++++++++----------------
 drivers/infiniband/core/mad.c        | 18 +++++++++---------
 drivers/infiniband/core/mad_rmpp.c   | 10 +++++-----
 drivers/infiniband/core/sysfs.c      |  6 +++---
 drivers/infiniband/core/user_mad.c   |  4 ++--
 drivers/infiniband/core/uverbs_cmd.c | 22 +++++++++++-----------
 6 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 28c8d13..190ac78 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -420,8 +420,7 @@ static int cm_alloc_response_msg(struct cm_port *port,
 	return 0;
 }
 
-static void * cm_copy_private_data(const void *private_data,
-				   u8 private_data_len)
+static void *cm_copy_private_data(const void *private_data, u8 private_data_len)
 {
 	void *data;
 
@@ -680,8 +679,8 @@ static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
 	return cm_id_priv;
 }
 
-static struct cm_id_private * cm_find_listen(struct ib_device *device,
-					     __be64 service_id)
+static struct cm_id_private *cm_find_listen(struct ib_device *device,
+					    __be64 service_id)
 {
 	struct rb_node *node = cm.listen_service_table.rb_node;
 	struct cm_id_private *cm_id_priv;
@@ -708,8 +707,8 @@ static struct cm_id_private * cm_find_listen(struct ib_device *device,
 	return NULL;
 }
 
-static struct cm_timewait_info * cm_insert_remote_id(struct cm_timewait_info
-						     *timewait_info)
+static struct cm_timewait_info *cm_insert_remote_id(struct cm_timewait_info
+						    *timewait_info)
 {
 	struct rb_node **link = &cm.remote_id_table.rb_node;
 	struct rb_node *parent = NULL;
@@ -767,8 +766,8 @@ static struct cm_id_private *cm_find_remote_id(__be64 remote_ca_guid,
 	return res;
 }
 
-static struct cm_timewait_info * cm_insert_remote_qpn(struct cm_timewait_info
-						      *timewait_info)
+static struct cm_timewait_info *cm_insert_remote_qpn(struct cm_timewait_info
+						     *timewait_info)
 {
 	struct rb_node **link = &cm.remote_qp_table.rb_node;
 	struct rb_node *parent = NULL;
@@ -797,8 +796,8 @@ static struct cm_timewait_info * cm_insert_remote_qpn(struct cm_timewait_info
 	return NULL;
 }
 
-static struct cm_id_private * cm_insert_remote_sidr(struct cm_id_private
-						    *cm_id_priv)
+static struct cm_id_private *cm_insert_remote_sidr(struct cm_id_private
+						   *cm_id_priv)
 {
 	struct rb_node **link = &cm.remote_sidr_table.rb_node;
 	struct rb_node *parent = NULL;
@@ -897,7 +896,7 @@ struct ib_cm_id *ib_create_cm_id(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_create_cm_id);
 
-static struct cm_work * cm_dequeue_work(struct cm_id_private *cm_id_priv)
+static struct cm_work *cm_dequeue_work(struct cm_id_private *cm_id_priv)
 {
 	struct cm_work *work;
 
@@ -986,7 +985,7 @@ static void cm_remove_remote(struct cm_id_private *cm_id_priv)
 	}
 }
 
-static struct cm_timewait_info * cm_create_timewait_info(__be32 local_id)
+static struct cm_timewait_info *cm_create_timewait_info(__be32 local_id)
 {
 	struct cm_timewait_info *timewait_info;
 
@@ -1977,8 +1976,8 @@ unlock:	spin_unlock_irq(&cm_id_priv->lock);
 free:	cm_free_msg(msg);
 }
 
-static struct cm_id_private * cm_match_req(struct cm_work *work,
-					   struct cm_id_private *cm_id_priv)
+static struct cm_id_private *cm_match_req(struct cm_work *work,
+					  struct cm_id_private *cm_id_priv)
 {
 	struct cm_id_private *listen_cm_id_priv, *cur_cm_id_priv;
 	struct cm_timewait_info *timewait_info;
@@ -2994,7 +2993,7 @@ static void cm_format_rej_event(struct cm_work *work)
 		IBA_GET_MEM_PTR(CM_REJ_PRIVATE_DATA, rej_msg);
 }
 
-static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
+static struct cm_id_private *cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
 {
 	struct cm_id_private *cm_id_priv;
 	__be32 remote_id;
@@ -3156,7 +3155,7 @@ error2:	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 }
 EXPORT_SYMBOL(ib_send_cm_mra);
 
-static struct cm_id_private * cm_acquire_mraed_id(struct cm_mra_msg *mra_msg)
+static struct cm_id_private *cm_acquire_mraed_id(struct cm_mra_msg *mra_msg)
 {
 	switch (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg)) {
 	case CM_MSG_RESPONSE_REQ:
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 16ecb81..092b660 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -807,7 +807,7 @@ static int alloc_send_rmpp_list(struct ib_mad_send_wr_private *send_wr,
 
 	/* Allocate data segments. */
 	for (left = send_buf->data_len + pad; left > 0; left -= seg_size) {
-		seg = kmalloc(sizeof (*seg) + seg_size, gfp_mask);
+		seg = kmalloc(sizeof(*seg) + seg_size, gfp_mask);
 		if (!seg) {
 			free_send_rmpp_list(send_wr);
 			return -ENOMEM;
@@ -837,12 +837,12 @@ int ib_mad_kernel_rmpp_agent(const struct ib_mad_agent *agent)
 }
 EXPORT_SYMBOL(ib_mad_kernel_rmpp_agent);
 
-struct ib_mad_send_buf * ib_create_send_mad(struct ib_mad_agent *mad_agent,
-					    u32 remote_qpn, u16 pkey_index,
-					    int rmpp_active,
-					    int hdr_len, int data_len,
-					    gfp_t gfp_mask,
-					    u8 base_version)
+struct ib_mad_send_buf *ib_create_send_mad(struct ib_mad_agent *mad_agent,
+					   u32 remote_qpn, u16 pkey_index,
+					   int rmpp_active,
+					   int hdr_len, int data_len,
+					   gfp_t gfp_mask,
+					   u8 base_version)
 {
 	struct ib_mad_agent_private *mad_agent_priv;
 	struct ib_mad_send_wr_private *mad_send_wr;
@@ -1679,7 +1679,7 @@ static inline int rcv_has_same_class(const struct ib_mad_send_wr_private *wr,
 
 static inline int rcv_has_same_gid(const struct ib_mad_agent_private *mad_agent_priv,
 				   const struct ib_mad_send_wr_private *wr,
-				   const struct ib_mad_recv_wc *rwc )
+				   const struct ib_mad_recv_wc *rwc)
 {
 	struct rdma_ah_attr attr;
 	u8 send_resp, rcv_resp;
@@ -2256,7 +2256,7 @@ void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
 	adjust_timeout(mad_agent_priv);
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
-	if (mad_send_wr->status != IB_WC_SUCCESS )
+	if (mad_send_wr->status != IB_WC_SUCCESS)
 		mad_send_wc->status = mad_send_wr->status;
 	if (ret == IB_RMPP_RESULT_INTERNAL)
 		ib_rmpp_send_handler(mad_send_wc);
diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
index e0573e4..8af0619 100644
--- a/drivers/infiniband/core/mad_rmpp.c
+++ b/drivers/infiniband/core/mad_rmpp.c
@@ -382,8 +382,8 @@ static inline int get_seg_num(struct ib_mad_recv_buf *seg)
 	return be32_to_cpu(rmpp_mad->rmpp_hdr.seg_num);
 }
 
-static inline struct ib_mad_recv_buf * get_next_seg(struct list_head *rmpp_list,
-						    struct ib_mad_recv_buf *seg)
+static inline struct ib_mad_recv_buf *get_next_seg(struct list_head *rmpp_list,
+						   struct ib_mad_recv_buf *seg)
 {
 	if (seg->list.next == rmpp_list)
 		return NULL;
@@ -396,8 +396,8 @@ static inline int window_size(struct ib_mad_agent_private *agent)
 	return max(agent->qp_info->recv_queue.max_active >> 3, 1);
 }
 
-static struct ib_mad_recv_buf * find_seg_location(struct list_head *rmpp_list,
-						  int seg_num)
+static struct ib_mad_recv_buf *find_seg_location(struct list_head *rmpp_list,
+						 int seg_num)
 {
 	struct ib_mad_recv_buf *seg_buf;
 	int cur_seg_num;
@@ -449,7 +449,7 @@ static inline int get_mad_len(struct mad_rmpp_recv *rmpp_recv)
 	return hdr_size + rmpp_recv->seg_num * data_size - pad;
 }
 
-static struct ib_mad_recv_wc * complete_rmpp(struct mad_rmpp_recv *rmpp_recv)
+static struct ib_mad_recv_wc *complete_rmpp(struct mad_rmpp_recv *rmpp_recv)
 {
 	struct ib_mad_recv_wc *rmpp_wc;
 
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index dcff5e7..52401d7 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -297,7 +297,7 @@ static ssize_t rate_show(struct ib_port *p, struct port_attribute *unused,
 
 static const char *phys_state_to_str(enum ib_port_phys_state phys_state)
 {
-	static const char * phys_state_str[] = {
+	static const char *phys_state_str[] = {
 		"<unknown>",
 		"Sleep",
 		"Polling",
@@ -470,14 +470,14 @@ static ssize_t show_port_pkey(struct ib_port *p, struct port_attribute *attr,
 struct port_table_attribute port_pma_attr_##_name = {			\
 	.attr  = __ATTR(_name, S_IRUGO, show_pma_counter, NULL),	\
 	.index = (_offset) | ((_width) << 16) | ((_counter) << 24),	\
-	.attr_id = IB_PMA_PORT_COUNTERS ,				\
+	.attr_id = IB_PMA_PORT_COUNTERS,				\
 }
 
 #define PORT_PMA_ATTR_EXT(_name, _width, _offset)			\
 struct port_table_attribute port_pma_attr_ext_##_name = {		\
 	.attr  = __ATTR(_name, S_IRUGO, show_pma_counter, NULL),	\
 	.index = (_offset) | ((_width) << 16),				\
-	.attr_id = IB_PMA_PORT_COUNTERS_EXT ,				\
+	.attr_id = IB_PMA_PORT_COUNTERS_EXT,				\
 }
 
 /*
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 2e90517..852efed 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -165,8 +165,8 @@ static void ib_umad_dev_put(struct ib_umad_device *dev)
 
 static int hdr_size(struct ib_umad_file *file)
 {
-	return file->use_pkey_index ? sizeof (struct ib_user_mad_hdr) :
-		sizeof (struct ib_user_mad_hdr_old);
+	return file->use_pkey_index ? sizeof(struct ib_user_mad_hdr) :
+				      sizeof(struct ib_user_mad_hdr_old);
 }
 
 /* caller must hold file->mutex */
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 9e070ff..8d9c344 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2002,12 +2002,12 @@ static int ib_uverbs_destroy_qp(struct uverbs_attr_bundle *attrs)
 
 static void *alloc_wr(size_t wr_size, __u32 num_sge)
 {
-	if (num_sge >= (U32_MAX - ALIGN(wr_size, sizeof (struct ib_sge))) /
-		       sizeof (struct ib_sge))
+	if (num_sge >= (U32_MAX - ALIGN(wr_size, sizeof(struct ib_sge))) /
+		       sizeof(struct ib_sge))
 		return NULL;
 
-	return kmalloc(ALIGN(wr_size, sizeof (struct ib_sge)) +
-			 num_sge * sizeof (struct ib_sge), GFP_KERNEL);
+	return kmalloc(ALIGN(wr_size, sizeof(struct ib_sge)) +
+		       num_sge * sizeof(struct ib_sge), GFP_KERNEL);
 }
 
 static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
@@ -2216,7 +2216,7 @@ ib_uverbs_unmarshall_recv(struct uverbs_req_iter *iter, u32 wr_count,
 	const struct ib_sge __user *sgls;
 	const void __user *wqes;
 
-	if (wqe_size < sizeof (struct ib_uverbs_recv_wr))
+	if (wqe_size < sizeof(struct ib_uverbs_recv_wr))
 		return ERR_PTR(-EINVAL);
 
 	wqes = uverbs_request_next_ptr(iter, wqe_size * wr_count);
@@ -2249,14 +2249,14 @@ ib_uverbs_unmarshall_recv(struct uverbs_req_iter *iter, u32 wr_count,
 		}
 
 		if (user_wr->num_sge >=
-		    (U32_MAX - ALIGN(sizeof *next, sizeof (struct ib_sge))) /
-		    sizeof (struct ib_sge)) {
+		    (U32_MAX - ALIGN(sizeof(*next), sizeof(struct ib_sge))) /
+		    sizeof(struct ib_sge)) {
 			ret = -EINVAL;
 			goto err;
 		}
 
-		next = kmalloc(ALIGN(sizeof *next, sizeof (struct ib_sge)) +
-			       user_wr->num_sge * sizeof (struct ib_sge),
+		next = kmalloc(ALIGN(sizeof(*next), sizeof(struct ib_sge)) +
+			       user_wr->num_sge * sizeof(struct ib_sge),
 			       GFP_KERNEL);
 		if (!next) {
 			ret = -ENOMEM;
@@ -2274,8 +2274,8 @@ ib_uverbs_unmarshall_recv(struct uverbs_req_iter *iter, u32 wr_count,
 		next->num_sge    = user_wr->num_sge;
 
 		if (next->num_sge) {
-			next->sg_list = (void *) next +
-				ALIGN(sizeof *next, sizeof (struct ib_sge));
+			next->sg_list = (void *)next +
+				ALIGN(sizeof(*next), sizeof(struct ib_sge));
 			if (copy_from_user(next->sg_list, sgls + sg_ind,
 					   next->num_sge *
 						   sizeof(struct ib_sge))) {
-- 
2.8.1

