Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B41354E74
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbhDFIWi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 04:22:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15915 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239733AbhDFIWh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 04:22:37 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FF0pL11GXzkgVC;
        Tue,  6 Apr 2021 16:20:42 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 16:22:18 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 5/6] RDMA/core: Correct format of braces
Date:   Tue, 6 Apr 2021 16:19:43 +0800
Message-ID: <1617697184-48683-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617697184-48683-1-git-send-email-liweihang@huawei.com>
References: <1617697184-48683-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

Do following cleanups about braces:
- Add the necessary braces to maintain context alignment.
- Fix the open '{' that is not on the same line as "switch".
- Remove braces that are not necessary for single statement blocks.
- Fix "else" that doesn't follow close brace '}'.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/cache.c |  3 ++-
 drivers/infiniband/core/cm.c    |  3 +--
 drivers/infiniband/core/cma.c   | 21 ++++++++++++---------
 drivers/infiniband/core/mad.c   | 20 ++++++++------------
 drivers/infiniband/core/sysfs.c |  6 ++----
 5 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 0b8c410..1147b9b 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1113,8 +1113,9 @@ int ib_find_cached_pkey(struct ib_device *device, u32 port_num,
 				*index = i;
 				ret = 0;
 				break;
-			} else
+			} else {
 				partial_ix = i;
+			}
 		}
 
 	if (ret && partial_ix >= 0) {
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 190ac78..ed7b70b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3917,8 +3917,7 @@ static int cm_establish(struct ib_cm_id *cm_id)
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
-	switch (cm_id->state)
-	{
+	switch (cm_id->state) {
 	case IB_CM_REP_SENT:
 	case IB_CM_MRA_REP_RCVD:
 		cm_id->state = IB_CM_ESTABLISHED;
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 670608c..8f73866 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1126,8 +1126,9 @@ int rdma_init_qp_attr(struct rdma_cm_id *id, struct ib_qp_attr *qp_attr,
 						 qp_attr_mask);
 		qp_attr->port_num = id_priv->id.port_num;
 		*qp_attr_mask |= IB_QP_PORT;
-	} else
+	} else {
 		ret = -ENOSYS;
+	}
 
 	if ((*qp_attr_mask & IB_QP_TIMEOUT) && id_priv->timeout_set)
 		qp_attr->timeout = id_priv->timeout;
@@ -4116,10 +4117,11 @@ int rdma_connect_locked(struct rdma_cm_id *id,
 			ret = cma_resolve_ib_udp(id_priv, conn_param);
 		else
 			ret = cma_connect_ib(id_priv, conn_param);
-	} else if (rdma_cap_iw_cm(id->device, id->port_num))
+	} else if (rdma_cap_iw_cm(id->device, id->port_num)) {
 		ret = cma_connect_iw(id_priv, conn_param);
-	else
+	} else {
 		ret = -ENOSYS;
+	}
 	if (ret)
 		goto err_state;
 	return 0;
@@ -4226,9 +4228,9 @@ static int cma_accept_iw(struct rdma_id_private *id_priv,
 	iw_param.ird = conn_param->responder_resources;
 	iw_param.private_data = conn_param->private_data;
 	iw_param.private_data_len = conn_param->private_data_len;
-	if (id_priv->id.qp) {
+	if (id_priv->id.qp)
 		iw_param.qpn = id_priv->qp_num;
-	} else
+	else
 		iw_param.qpn = conn_param->qp_num;
 
 	return iw_cm_accept(id_priv->cm_id.iw, &iw_param);
@@ -4311,11 +4313,11 @@ int rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
 			else
 				ret = cma_rep_recv(id_priv);
 		}
-	} else if (rdma_cap_iw_cm(id->device, id->port_num))
+	} else if (rdma_cap_iw_cm(id->device, id->port_num)) {
 		ret = cma_accept_iw(id_priv, conn_param);
-	else
+	} else {
 		ret = -ENOSYS;
-
+	}
 	if (ret)
 		goto reject;
 
@@ -4401,8 +4403,9 @@ int rdma_reject(struct rdma_cm_id *id, const void *private_data,
 	} else if (rdma_cap_iw_cm(id->device, id->port_num)) {
 		ret = iw_cm_reject(id_priv->cm_id.iw,
 				   private_data, private_data_len);
-	} else
+	} else {
 		ret = -ENOSYS;
+	}
 
 	return ret;
 }
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index f066fb1..909c58f 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -155,8 +155,7 @@ static inline u8 convert_mgmt_class(u8 mgmt_class)
 
 static int get_spl_qp_index(enum ib_qp_type qp_type)
 {
-	switch (qp_type)
-	{
+	switch (qp_type) {
 	case IB_QPT_SMI:
 		return 0;
 	case IB_QPT_GSI:
@@ -707,8 +706,7 @@ static int handle_outgoing_dr_smp(struct ib_mad_agent_private *mad_agent_priv,
 				      (const struct ib_mad *)smp,
 				      (struct ib_mad *)mad_priv->mad, &mad_size,
 				      &out_mad_pkey_index);
-	switch (ret)
-	{
+	switch (ret) {
 	case IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY:
 		if (ib_response_mad((const struct ib_mad_hdr *)mad_priv->mad) &&
 		    mad_agent_priv->agent.recv_handler) {
@@ -1275,11 +1273,9 @@ static void remove_methods_mad_agent(struct ib_mad_mgmt_method_table *method,
 	int i;
 
 	/* Remove any methods for this mad agent */
-	for (i = 0; i < IB_MGMT_MAX_METHODS; i++) {
-		if (method->agent[i] == agent) {
+	for (i = 0; i < IB_MGMT_MAX_METHODS; i++)
+		if (method->agent[i] == agent)
 			method->agent[i] = NULL;
-		}
-	}
 }
 
 static int add_nonoui_reg_req(struct ib_mad_reg_req *mad_reg_req,
@@ -1454,9 +1450,8 @@ static void remove_mad_reg_req(struct ib_mad_agent_private *agent_priv)
 	 * Was MAD registration request supplied
 	 * with original registration ?
 	 */
-	if (!agent_priv->reg_req) {
+	if (!agent_priv->reg_req)
 		goto out;
-	}
 
 	port_priv = agent_priv->qp_info->port_priv;
 	mgmt_class = convert_mgmt_class(agent_priv->reg_req->mgmt_class);
@@ -2200,9 +2195,10 @@ static void wait_for_response(struct ib_mad_send_wr_private *mad_send_wr)
 				       temp_mad_send_wr->timeout))
 				break;
 		}
-	}
-	else
+	} else {
 		list_item = &mad_agent_priv->wait_list;
+	}
+
 	list_add(&mad_send_wr->agent_list, list_item);
 
 	/* Reschedule a work item if we have a shorter timeout */
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 43a3dc7..095b3a2 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1074,9 +1074,8 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	ret = kobject_init_and_add(&p->kobj, &port_type,
 				   coredev->ports_kobj,
 				   "%d", port_num);
-	if (ret) {
+	if (ret)
 		goto err_put;
-	}
 
 	p->gid_attr_group = kzalloc(sizeof(*p->gid_attr_group), GFP_KERNEL);
 	if (!p->gid_attr_group) {
@@ -1087,9 +1086,8 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	p->gid_attr_group->port = p;
 	ret = kobject_init_and_add(&p->gid_attr_group->kobj, &gid_attr_type,
 				   &p->kobj, "gid_attrs");
-	if (ret) {
+	if (ret)
 		goto err_put_gid_attrs;
-	}
 
 	if (device->ops.process_mad && is_full_dev) {
 		p->pma_table = get_counter_table(device, port_num);
-- 
2.8.1

