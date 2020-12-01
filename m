Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671022CA23A
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Dec 2020 13:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbgLAMKu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Dec 2020 07:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730768AbgLAMKj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Dec 2020 07:10:39 -0500
Received: from mail.kernel.org (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44746208FE;
        Tue,  1 Dec 2020 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606824555;
        bh=lsY7t9le25UCqvqFfPdKKVtm1EtnRLSo8RvDQXjF0Uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6EFSd9A2gTQtt9TZx9ZmyBbhy8KEN1fDQd6tuKrid4mPsrQ8W/i2KX+kKOve2OnB
         OJds8xpD1uz3SeT1jU9dv8e+afTm4wXs6SB8QORGm2jhzBa0x7x/pEJUoosqgwyw8g
         79cH/VoRsp92pok4K7ComUg56S6YwH8toHdjsVL4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kk4T2-00DGcw-RL; Tue, 01 Dec 2020 13:09:12 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Divya Indi <divya.indi@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Xi Wang <wangxi11@huawei.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH v5 02/16] IB: fix kernel-doc markups
Date:   Tue,  1 Dec 2020 13:08:55 +0100
Message-Id: <78b98c41a5a0f4c0106433d305b143028a4168b0.1606823973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606823973.git.mchehab+huawei@kernel.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some functions have different names between their prototypes
and the kernel-doc markup.

Others need to be fixed, as kernel-doc markups should use this format:
        identifier - description

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/infiniband/core/cm.c                         |  5 +++--
 drivers/infiniband/core/cq.c                         |  4 ++--
 drivers/infiniband/core/iwpm_util.h                  |  2 +-
 drivers/infiniband/core/sa_query.c                   |  3 ++-
 drivers/infiniband/core/verbs.c                      |  4 ++--
 drivers/infiniband/sw/rdmavt/ah.c                    |  2 +-
 drivers/infiniband/sw/rdmavt/mcast.c                 | 12 ++++++------
 drivers/infiniband/sw/rdmavt/qp.c                    |  8 ++++----
 drivers/infiniband/ulp/iser/iscsi_iser.c             |  2 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h     |  2 +-
 .../infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c    |  2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.h                |  2 +-
 include/rdma/ib_verbs.h                              | 11 +++++++++++
 13 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 167e436ae11d..46c48690f909 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1222,65 +1222,66 @@ static int cm_init_listen(struct cm_id_private *cm_id_priv, __be64 service_id,
 int ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id, __be64 service_mask)
 {
 	struct cm_id_private *cm_id_priv =
 		container_of(cm_id, struct cm_id_private, id);
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	if (cm_id_priv->id.state != IB_CM_IDLE) {
 		ret = -EINVAL;
 		goto out;
 	}
 
 	ret = cm_init_listen(cm_id_priv, service_id, service_mask);
 	if (ret)
 		goto out;
 
 	if (!cm_insert_listen(cm_id_priv, NULL)) {
 		ret = -EBUSY;
 		goto out;
 	}
 
 	cm_id_priv->id.state = IB_CM_LISTEN;
 	ret = 0;
 
 out:
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(ib_cm_listen);
 
 /**
- * Create a new listening ib_cm_id and listen on the given service ID.
+ * ib_cm_insert_listen - Create a new listening ib_cm_id and listen on
+ *			 the given service ID.
  *
  * If there's an existing ID listening on that same device and service ID,
  * return it.
  *
  * @device: Device associated with the cm_id.  All related communication will
  * be associated with the specified device.
  * @cm_handler: Callback invoked to notify the user of CM events.
  * @service_id: Service identifier matched against incoming connection
  *   and service ID resolution requests.  The service ID should be specified
  *   network-byte order.  If set to IB_CM_ASSIGN_SERVICE_ID, the CM will
  *   assign a service ID to the caller.
  *
  * Callers should call ib_destroy_cm_id when done with the listener ID.
  */
 struct ib_cm_id *ib_cm_insert_listen(struct ib_device *device,
 				     ib_cm_handler cm_handler,
 				     __be64 service_id)
 {
 	struct cm_id_private *listen_id_priv;
 	struct cm_id_private *cm_id_priv;
 	int err = 0;
 
 	/* Create an ID in advance, since the creation may sleep */
 	cm_id_priv = cm_alloc_id_priv(device, cm_handler, NULL);
 	if (IS_ERR(cm_id_priv))
 		return ERR_CAST(cm_id_priv);
 
 	err = cm_init_listen(cm_id_priv, service_id, 0);
 	if (err)
 		return ERR_PTR(err);
 
 	spin_lock_irq(&cm_id_priv->lock);
@@ -1735,65 +1736,65 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 		alt_path->packet_life_time_selector = IB_SA_EQ;
 		alt_path->packet_life_time =
 			IBA_GET(CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT, req_msg);
 		alt_path->packet_life_time -= (alt_path->packet_life_time > 0);
 		alt_path->service_id =
 			cpu_to_be64(IBA_GET(CM_REQ_SERVICE_ID, req_msg));
 
 		if (sa_path_is_roce(alt_path))
 			alt_path->roce.route_resolved = false;
 	}
 	cm_format_path_lid_from_req(req_msg, primary_path, alt_path);
 }
 
 static u16 cm_get_bth_pkey(struct cm_work *work)
 {
 	struct ib_device *ib_dev = work->port->cm_dev->ib_device;
 	u8 port_num = work->port->port_num;
 	u16 pkey_index = work->mad_recv_wc->wc->pkey_index;
 	u16 pkey;
 	int ret;
 
 	ret = ib_get_cached_pkey(ib_dev, port_num, pkey_index, &pkey);
 	if (ret) {
 		dev_warn_ratelimited(&ib_dev->dev, "ib_cm: Couldn't retrieve pkey for incoming request (port %d, pkey index %d). %d\n",
 				     port_num, pkey_index, ret);
 		return 0;
 	}
 
 	return pkey;
 }
 
 /**
- * Convert OPA SGID to IB SGID
+ * cm_opa_to_ib_sgid - Convert OPA SGID to IB SGID
  * ULPs (such as IPoIB) do not understand OPA GIDs and will
  * reject them as the local_gid will not match the sgid. Therefore,
  * change the pathrec's SGID to an IB SGID.
  *
  * @work: Work completion
  * @path: Path record
  */
 static void cm_opa_to_ib_sgid(struct cm_work *work,
 			      struct sa_path_rec *path)
 {
 	struct ib_device *dev = work->port->cm_dev->ib_device;
 	u8 port_num = work->port->port_num;
 
 	if (rdma_cap_opa_ah(dev, port_num) &&
 	    (ib_is_opa_gid(&path->sgid))) {
 		union ib_gid sgid;
 
 		if (rdma_query_gid(dev, port_num, 0, &sgid)) {
 			dev_warn(&dev->dev,
 				 "Error updating sgid in CM request\n");
 			return;
 		}
 
 		path->sgid = sgid;
 	}
 }
 
 static void cm_format_req_event(struct cm_work *work,
 				struct cm_id_private *cm_id_priv,
 				struct ib_cm_id *listen_id)
 {
 	struct cm_req_msg *req_msg;
diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 12ebacf52958..d4248bbe74da 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -94,65 +94,65 @@ static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *wcs,
 			   int batch)
 {
 	int i, n, completed = 0;
 
 	trace_cq_process(cq);
 
 	/*
 	 * budget might be (-1) if the caller does not
 	 * want to bound this call, thus we need unsigned
 	 * minimum here.
 	 */
 	while ((n = __poll_cq(cq, min_t(u32, batch,
 					budget - completed), wcs)) > 0) {
 		for (i = 0; i < n; i++) {
 			struct ib_wc *wc = &wcs[i];
 
 			if (wc->wr_cqe)
 				wc->wr_cqe->done(cq, wc);
 			else
 				WARN_ON_ONCE(wc->status == IB_WC_SUCCESS);
 		}
 
 		completed += n;
 
 		if (n != batch || (budget != -1 && completed >= budget))
 			break;
 	}
 
 	return completed;
 }
 
 /**
- * ib_process_direct_cq - process a CQ in caller context
+ * ib_process_cq_direct - process a CQ in caller context
  * @cq:		CQ to process
  * @budget:	number of CQEs to poll for
  *
  * This function is used to process all outstanding CQ entries.
  * It does not offload CQ processing to a different context and does
  * not ask for completion interrupts from the HCA.
  * Using direct processing on CQ with non IB_POLL_DIRECT type may trigger
  * concurrent processing.
  *
  * Note: do not pass -1 as %budget unless it is guaranteed that the number
  * of completions that will be processed is small.
  */
 int ib_process_cq_direct(struct ib_cq *cq, int budget)
 {
 	struct ib_wc wcs[IB_POLL_BATCH_DIRECT];
 
 	return __ib_process_cq(cq, budget, wcs, IB_POLL_BATCH_DIRECT);
 }
 EXPORT_SYMBOL(ib_process_cq_direct);
 
 static void ib_cq_completion_direct(struct ib_cq *cq, void *private)
 {
 	WARN_ONCE(1, "got unsolicited completion for CQ 0x%p\n", cq);
 }
 
 static int ib_poll_handler(struct irq_poll *iop, int budget)
 {
 	struct ib_cq *cq = container_of(iop, struct ib_cq, iop);
 	struct dim *dim = cq->dim;
 	int completed;
 
 	completed = __ib_process_cq(cq, budget, cq->wc, IB_POLL_BATCH);
@@ -168,65 +168,65 @@ static int ib_poll_handler(struct irq_poll *iop, int budget)
 		rdma_dim(dim, completed);
 
 	return completed;
 }
 
 static void ib_cq_completion_softirq(struct ib_cq *cq, void *private)
 {
 	trace_cq_schedule(cq);
 	irq_poll_sched(&cq->iop);
 }
 
 static void ib_cq_poll_work(struct work_struct *work)
 {
 	struct ib_cq *cq = container_of(work, struct ib_cq, work);
 	int completed;
 
 	completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE, cq->wc,
 				    IB_POLL_BATCH);
 	if (completed >= IB_POLL_BUDGET_WORKQUEUE ||
 	    ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
 		queue_work(cq->comp_wq, &cq->work);
 	else if (cq->dim)
 		rdma_dim(cq->dim, completed);
 }
 
 static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
 {
 	trace_cq_schedule(cq);
 	queue_work(cq->comp_wq, &cq->work);
 }
 
 /**
- * __ib_alloc_cq        allocate a completion queue
+ * __ib_alloc_cq - allocate a completion queue
  * @dev:		device to allocate the CQ for
  * @private:		driver private data, accessible from cq->cq_context
  * @nr_cqe:		number of CQEs to allocate
  * @comp_vector:	HCA completion vectors for this CQ
  * @poll_ctx:		context to poll the CQ from.
  * @caller:		module owner name.
  *
  * This is the proper interface to allocate a CQ for in-kernel users. A
  * CQ allocated with this interface will automatically be polled from the
  * specified context. The ULP must use wr->wr_cqe instead of wr->wr_id
  * to use this CQ abstraction.
  */
 struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
 			    int comp_vector, enum ib_poll_context poll_ctx,
 			    const char *caller)
 {
 	struct ib_cq_init_attr cq_attr = {
 		.cqe		= nr_cqe,
 		.comp_vector	= comp_vector,
 	};
 	struct ib_cq *cq;
 	int ret = -ENOMEM;
 
 	cq = rdma_zalloc_drv_obj(dev, ib_cq);
 	if (!cq)
 		return ERR_PTR(ret);
 
 	cq->device = dev;
 	cq->cq_context = private;
 	cq->poll_ctx = poll_ctx;
 	atomic_set(&cq->usecnt, 0);
 	cq->comp_vector = comp_vector;
diff --git a/drivers/infiniband/core/iwpm_util.h b/drivers/infiniband/core/iwpm_util.h
index 1bf87d9fd0bd..eeb8e6010907 100644
--- a/drivers/infiniband/core/iwpm_util.h
+++ b/drivers/infiniband/core/iwpm_util.h
@@ -112,65 +112,65 @@ struct iwpm_nlmsg_request *iwpm_get_nlmsg_request(__u32 nlmsg_seq,
  * iwpm_free_nlmsg_request - Deallocate netlink message request
  * @kref: Holds reference of netlink message request
  */
 void iwpm_free_nlmsg_request(struct kref *kref);
 
 /**
  * iwpm_find_nlmsg_request - Find netlink message request in the request list
  * @echo_seq: Sequence number of the netlink request to find
  *
  * Returns the found netlink message request,
  * if not found, returns NULL
  */
 struct iwpm_nlmsg_request *iwpm_find_nlmsg_request(__u32 echo_seq);
 
 /**
  * iwpm_wait_complete_req - Block while servicing the netlink request
  * @nlmsg_request: Netlink message request to service
  *
  * Wakes up, after the request is completed or expired
  * Returns 0 if the request is complete without error
  */
 int iwpm_wait_complete_req(struct iwpm_nlmsg_request *nlmsg_request);
 
 /**
  * iwpm_get_nlmsg_seq - Get the sequence number for a netlink
  *			message to send to the port mapper
  *
  * Returns the sequence number for the netlink message.
  */
 int iwpm_get_nlmsg_seq(void);
 
 /**
- * iwpm_add_reminfo - Add remote address info of the connecting peer
+ * iwpm_add_remote_info - Add remote address info of the connecting peer
  *                    to the remote info hash table
  * @reminfo: The remote info to be added
  */
 void iwpm_add_remote_info(struct iwpm_remote_info *reminfo);
 
 /**
  * iwpm_valid_client - Check if the port mapper client is valid
  * @nl_client: The index of the netlink client
  *
  * Valid clients need to call iwpm_init() before using
  * the port mapper
  */
 int iwpm_valid_client(u8 nl_client);
 
 /**
  * iwpm_set_valid - Set the port mapper client to valid or not
  * @nl_client: The index of the netlink client
  * @valid: 1 if valid or 0 if invalid
  */
 void iwpm_set_valid(u8 nl_client, int valid);
 
 /**
  * iwpm_check_registration - Check if the client registration
  *			      matches the given one
  * @nl_client: The index of the netlink client
  * @reg: The given registration type to compare with
  *
  * Call iwpm_register_pid() to register a client
  * Returns true if the client registration matches reg,
  * otherwise returns false
  */
 u32 iwpm_check_registration(u8 nl_client, u32 reg);
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 8c930bf1df89..89a831fa1885 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1406,65 +1406,66 @@ void ib_sa_pack_path(struct sa_path_rec *rec, void *attribute)
 	ib_pack(path_rec_table, ARRAY_SIZE(path_rec_table), rec, attribute);
 }
 EXPORT_SYMBOL(ib_sa_pack_path);
 
 static bool ib_sa_opa_pathrecord_support(struct ib_sa_client *client,
 					 struct ib_sa_device *sa_dev,
 					 u8 port_num)
 {
 	struct ib_sa_port *port;
 	unsigned long flags;
 	bool ret = false;
 
 	port = &sa_dev->port[port_num - sa_dev->start_port];
 	spin_lock_irqsave(&port->classport_lock, flags);
 	if (!port->classport_info.valid)
 		goto ret;
 
 	if (port->classport_info.data.type == RDMA_CLASS_PORT_INFO_OPA)
 		ret = opa_get_cpi_capmask2(&port->classport_info.data.opa) &
 			OPA_CLASS_PORT_INFO_PR_SUPPORT;
 ret:
 	spin_unlock_irqrestore(&port->classport_lock, flags);
 	return ret;
 }
 
 enum opa_pr_supported {
 	PR_NOT_SUPPORTED,
 	PR_OPA_SUPPORTED,
 	PR_IB_SUPPORTED
 };
 
 /**
- * Check if current PR query can be an OPA query.
+ * opa_pr_query_possible - Check if current PR query can be an OPA query.
+ *
  * Retuns PR_NOT_SUPPORTED if a path record query is not
  * possible, PR_OPA_SUPPORTED if an OPA path record query
  * is possible and PR_IB_SUPPORTED if an IB path record
  * query is possible.
  */
 static int opa_pr_query_possible(struct ib_sa_client *client,
 				 struct ib_sa_device *sa_dev,
 				 struct ib_device *device, u8 port_num,
 				 struct sa_path_rec *rec)
 {
 	struct ib_port_attr port_attr;
 
 	if (ib_query_port(device, port_num, &port_attr))
 		return PR_NOT_SUPPORTED;
 
 	if (ib_sa_opa_pathrecord_support(client, sa_dev, port_num))
 		return PR_OPA_SUPPORTED;
 
 	if (port_attr.lid >= be16_to_cpu(IB_MULTICAST_LID_BASE))
 		return PR_NOT_SUPPORTED;
 	else
 		return PR_IB_SUPPORTED;
 }
 
 static void ib_sa_path_rec_callback(struct ib_sa_query *sa_query,
 				    int status,
 				    struct ib_sa_mad *mad)
 {
 	struct ib_sa_path_query *query =
 		container_of(sa_query, struct ib_sa_path_query, sa_query);
 
 	if (mad) {
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 33778f8674a1..2ae0e448a524 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -215,65 +215,65 @@ rdma_node_get_transport(unsigned int node_type)
 {
 
 	if (node_type == RDMA_NODE_USNIC)
 		return RDMA_TRANSPORT_USNIC;
 	if (node_type == RDMA_NODE_USNIC_UDP)
 		return RDMA_TRANSPORT_USNIC_UDP;
 	if (node_type == RDMA_NODE_RNIC)
 		return RDMA_TRANSPORT_IWARP;
 	if (node_type == RDMA_NODE_UNSPECIFIED)
 		return RDMA_TRANSPORT_UNSPECIFIED;
 
 	return RDMA_TRANSPORT_IB;
 }
 EXPORT_SYMBOL(rdma_node_get_transport);
 
 enum rdma_link_layer rdma_port_get_link_layer(struct ib_device *device, u8 port_num)
 {
 	enum rdma_transport_type lt;
 	if (device->ops.get_link_layer)
 		return device->ops.get_link_layer(device, port_num);
 
 	lt = rdma_node_get_transport(device->node_type);
 	if (lt == RDMA_TRANSPORT_IB)
 		return IB_LINK_LAYER_INFINIBAND;
 
 	return IB_LINK_LAYER_ETHERNET;
 }
 EXPORT_SYMBOL(rdma_port_get_link_layer);
 
 /* Protection domains */
 
 /**
- * ib_alloc_pd - Allocates an unused protection domain.
+ * __ib_alloc_pd - Allocates an unused protection domain.
  * @device: The device on which to allocate the protection domain.
  * @flags: protection domain flags
  * @caller: caller's build-time module name
  *
  * A protection domain object provides an association between QPs, shared
  * receive queues, address handles, memory regions, and memory windows.
  *
  * Every PD has a local_dma_lkey which can be used as the lkey value for local
  * memory operations.
  */
 struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 		const char *caller)
 {
 	struct ib_pd *pd;
 	int mr_access_flags = 0;
 	int ret;
 
 	pd = rdma_zalloc_drv_obj(device, ib_pd);
 	if (!pd)
 		return ERR_PTR(-ENOMEM);
 
 	pd->device = device;
 	pd->uobject = NULL;
 	pd->__internal_mr = NULL;
 	atomic_set(&pd->usecnt, 0);
 	pd->flags = flags;
 
 	rdma_restrack_new(&pd->res, RDMA_RESTRACK_PD);
 	rdma_restrack_set_name(&pd->res, caller);
 
 	ret = device->ops.alloc_pd(pd, NULL);
 	if (ret) {
@@ -1636,65 +1636,65 @@ EXPORT_SYMBOL(ib_modify_qp_is_ok);
  * returns 0 on success or appropriate error code. It initializes the
  * necessary ah_attr fields when call is successful.
  */
 static int ib_resolve_eth_dmac(struct ib_device *device,
 			       struct rdma_ah_attr *ah_attr)
 {
 	int ret = 0;
 
 	if (rdma_is_multicast_addr((struct in6_addr *)ah_attr->grh.dgid.raw)) {
 		if (ipv6_addr_v4mapped((struct in6_addr *)ah_attr->grh.dgid.raw)) {
 			__be32 addr = 0;
 
 			memcpy(&addr, ah_attr->grh.dgid.raw + 12, 4);
 			ip_eth_mc_map(addr, (char *)ah_attr->roce.dmac);
 		} else {
 			ipv6_eth_mc_map((struct in6_addr *)ah_attr->grh.dgid.raw,
 					(char *)ah_attr->roce.dmac);
 		}
 	} else {
 		ret = ib_resolve_unicast_gid_dmac(device, ah_attr);
 	}
 	return ret;
 }
 
 static bool is_qp_type_connected(const struct ib_qp *qp)
 {
 	return (qp->qp_type == IB_QPT_UC ||
 		qp->qp_type == IB_QPT_RC ||
 		qp->qp_type == IB_QPT_XRC_INI ||
 		qp->qp_type == IB_QPT_XRC_TGT);
 }
 
-/**
+/*
  * IB core internal function to perform QP attributes modification.
  */
 static int _ib_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr,
 			 int attr_mask, struct ib_udata *udata)
 {
 	u8 port = attr_mask & IB_QP_PORT ? attr->port_num : qp->port;
 	const struct ib_gid_attr *old_sgid_attr_av;
 	const struct ib_gid_attr *old_sgid_attr_alt_av;
 	int ret;
 
 	attr->xmit_slave = NULL;
 	if (attr_mask & IB_QP_AV) {
 		ret = rdma_fill_sgid_attr(qp->device, &attr->ah_attr,
 					  &old_sgid_attr_av);
 		if (ret)
 			return ret;
 
 		if (attr->ah_attr.type == RDMA_AH_ATTR_TYPE_ROCE &&
 		    is_qp_type_connected(qp)) {
 			struct net_device *slave;
 
 			/*
 			 * If the user provided the qp_attr then we have to
 			 * resolve it. Kerne users have to provide already
 			 * resolved rdma_ah_attr's.
 			 */
 			if (udata) {
 				ret = ib_resolve_eth_dmac(qp->device,
 							  &attr->ah_attr);
 				if (ret)
 					goto out_av;
 			}
diff --git a/drivers/infiniband/sw/rdmavt/ah.c b/drivers/infiniband/sw/rdmavt/ah.c
index f9754dcd250b..a3e5b368c5e7 100644
--- a/drivers/infiniband/sw/rdmavt/ah.c
+++ b/drivers/infiniband/sw/rdmavt/ah.c
@@ -97,65 +97,65 @@ EXPORT_SYMBOL(rvt_check_ah);
  *
  * Return: 0 on success
  */
 int rvt_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		  struct ib_udata *udata)
 {
 	struct rvt_ah *ah = ibah_to_rvtah(ibah);
 	struct rvt_dev_info *dev = ib_to_rvt(ibah->device);
 	unsigned long flags;
 
 	if (rvt_check_ah(ibah->device, init_attr->ah_attr))
 		return -EINVAL;
 
 	spin_lock_irqsave(&dev->n_ahs_lock, flags);
 	if (dev->n_ahs_allocated == dev->dparms.props.max_ah) {
 		spin_unlock_irqrestore(&dev->n_ahs_lock, flags);
 		return -ENOMEM;
 	}
 
 	dev->n_ahs_allocated++;
 	spin_unlock_irqrestore(&dev->n_ahs_lock, flags);
 
 	rdma_copy_ah_attr(&ah->attr, init_attr->ah_attr);
 
 	if (dev->driver_f.notify_new_ah)
 		dev->driver_f.notify_new_ah(ibah->device,
 					    init_attr->ah_attr, ah);
 
 	return 0;
 }
 
 /**
- * rvt_destory_ah - Destory an address handle
+ * rvt_destroy_ah - Destroy an address handle
  * @ibah: address handle
  * @destroy_flags: destroy address handle flags (see enum rdma_destroy_ah_flags)
  * Return: 0 on success
  */
 int rvt_destroy_ah(struct ib_ah *ibah, u32 destroy_flags)
 {
 	struct rvt_dev_info *dev = ib_to_rvt(ibah->device);
 	struct rvt_ah *ah = ibah_to_rvtah(ibah);
 	unsigned long flags;
 
 	spin_lock_irqsave(&dev->n_ahs_lock, flags);
 	dev->n_ahs_allocated--;
 	spin_unlock_irqrestore(&dev->n_ahs_lock, flags);
 
 	rdma_destroy_ah_attr(&ah->attr);
 	return 0;
 }
 
 /**
  * rvt_modify_ah - modify an ah with given attrs
  * @ibah: address handle to modify
  * @ah_attr: attrs to apply
  *
  * Return: 0 on success
  */
 int rvt_modify_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
 {
 	struct rvt_ah *ah = ibah_to_rvtah(ibah);
 
 	if (rvt_check_ah(ibah->device, ah_attr))
 		return -EINVAL;
 
diff --git a/drivers/infiniband/sw/rdmavt/mcast.c b/drivers/infiniband/sw/rdmavt/mcast.c
index dd11c6fcd060..5233a63d99a6 100644
--- a/drivers/infiniband/sw/rdmavt/mcast.c
+++ b/drivers/infiniband/sw/rdmavt/mcast.c
@@ -25,109 +25,109 @@
  *    notice, this list of conditions and the following disclaimer.
  *  - Redistributions in binary form must reproduce the above copyright
  *    notice, this list of conditions and the following disclaimer in
  *    the documentation and/or other materials provided with the
  *    distribution.
  *  - Neither the name of Intel Corporation nor the names of its
  *    contributors may be used to endorse or promote products derived
  *    from this software without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  */
 
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/rculist.h>
 #include <rdma/rdma_vt.h>
 #include <rdma/rdmavt_qp.h>
 
 #include "mcast.h"
 
 /**
- * rvt_driver_mcast - init resources for multicast
+ * rvt_driver_mcast_init - init resources for multicast
  * @rdi: rvt dev struct
  *
  * This is per device that registers with rdmavt
  */
 void rvt_driver_mcast_init(struct rvt_dev_info *rdi)
 {
 	/*
 	 * Anything that needs setup for multicast on a per driver or per rdi
 	 * basis should be done in here.
 	 */
 	spin_lock_init(&rdi->n_mcast_grps_lock);
 }
 
 /**
- * mcast_qp_alloc - alloc a struct to link a QP to mcast GID struct
+ * rvt_mcast_qp_alloc - alloc a struct to link a QP to mcast GID struct
  * @qp: the QP to link
  */
 static struct rvt_mcast_qp *rvt_mcast_qp_alloc(struct rvt_qp *qp)
 {
 	struct rvt_mcast_qp *mqp;
 
 	mqp = kmalloc(sizeof(*mqp), GFP_KERNEL);
 	if (!mqp)
 		goto bail;
 
 	mqp->qp = qp;
 	rvt_get_qp(qp);
 
 bail:
 	return mqp;
 }
 
 static void rvt_mcast_qp_free(struct rvt_mcast_qp *mqp)
 {
 	struct rvt_qp *qp = mqp->qp;
 
 	/* Notify hfi1_destroy_qp() if it is waiting. */
 	rvt_put_qp(qp);
 
 	kfree(mqp);
 }
 
 /**
- * mcast_alloc - allocate the multicast GID structure
+ * rvt_mcast_alloc - allocate the multicast GID structure
  * @mgid: the multicast GID
  * @lid: the muilticast LID (host order)
  *
  * A list of QPs will be attached to this structure.
  */
 static struct rvt_mcast *rvt_mcast_alloc(union ib_gid *mgid, u16 lid)
 {
 	struct rvt_mcast *mcast;
 
 	mcast = kzalloc(sizeof(*mcast), GFP_KERNEL);
 	if (!mcast)
 		goto bail;
 
 	mcast->mcast_addr.mgid = *mgid;
 	mcast->mcast_addr.lid = lid;
 
 	INIT_LIST_HEAD(&mcast->qp_list);
 	init_waitqueue_head(&mcast->wait);
 	atomic_set(&mcast->refcount, 0);
 
 bail:
 	return mcast;
 }
 
 static void rvt_mcast_free(struct rvt_mcast *mcast)
 {
 	struct rvt_mcast_qp *p, *tmp;
 
 	list_for_each_entry_safe(p, tmp, &mcast->qp_list, list)
 		rvt_mcast_qp_free(p);
 
 	kfree(mcast);
@@ -152,65 +152,65 @@ struct rvt_mcast *rvt_mcast_find(struct rvt_ibport *ibp, union ib_gid *mgid,
 	unsigned long flags;
 	struct rvt_mcast *found = NULL;
 
 	spin_lock_irqsave(&ibp->lock, flags);
 	n = ibp->mcast_tree.rb_node;
 	while (n) {
 		int ret;
 		struct rvt_mcast *mcast;
 
 		mcast = rb_entry(n, struct rvt_mcast, rb_node);
 
 		ret = memcmp(mgid->raw, mcast->mcast_addr.mgid.raw,
 			     sizeof(*mgid));
 		if (ret < 0) {
 			n = n->rb_left;
 		} else if (ret > 0) {
 			n = n->rb_right;
 		} else {
 			/* MGID/MLID must match */
 			if (mcast->mcast_addr.lid == lid) {
 				atomic_inc(&mcast->refcount);
 				found = mcast;
 			}
 			break;
 		}
 	}
 	spin_unlock_irqrestore(&ibp->lock, flags);
 	return found;
 }
 EXPORT_SYMBOL(rvt_mcast_find);
 
 /**
- * mcast_add - insert mcast GID into table and attach QP struct
+ * rvt_mcast_add - insert mcast GID into table and attach QP struct
  * @mcast: the mcast GID table
  * @mqp: the QP to attach
  *
  * Return: zero if both were added.  Return EEXIST if the GID was already in
  * the table but the QP was added.  Return ESRCH if the QP was already
  * attached and neither structure was added. Return EINVAL if the MGID was
  * found, but the MLID did NOT match.
  */
 static int rvt_mcast_add(struct rvt_dev_info *rdi, struct rvt_ibport *ibp,
 			 struct rvt_mcast *mcast, struct rvt_mcast_qp *mqp)
 {
 	struct rb_node **n = &ibp->mcast_tree.rb_node;
 	struct rb_node *pn = NULL;
 	int ret;
 
 	spin_lock_irq(&ibp->lock);
 
 	while (*n) {
 		struct rvt_mcast *tmcast;
 		struct rvt_mcast_qp *p;
 
 		pn = *n;
 		tmcast = rb_entry(pn, struct rvt_mcast, rb_node);
 
 		ret = memcmp(mcast->mcast_addr.mgid.raw,
 			     tmcast->mcast_addr.mgid.raw,
 			     sizeof(mcast->mcast_addr.mgid));
 		if (ret < 0) {
 			n = &pn->rb_left;
 			continue;
 		}
 		if (ret > 0) {
@@ -397,47 +397,47 @@ int rvt_detach_mcast(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
 		if (list_empty(&mcast->qp_list)) {
 			rb_erase(&mcast->rb_node, &ibp->mcast_tree);
 			last = 1;
 		}
 		break;
 	}
 
 	spin_unlock_irq(&ibp->lock);
 	/* QP not attached */
 	if (!delp)
 		return -EINVAL;
 
 	/*
 	 * Wait for any list walkers to finish before freeing the
 	 * list element.
 	 */
 	wait_event(mcast->wait, atomic_read(&mcast->refcount) <= 1);
 	rvt_mcast_qp_free(delp);
 
 	if (last) {
 		atomic_dec(&mcast->refcount);
 		wait_event(mcast->wait, !atomic_read(&mcast->refcount));
 		rvt_mcast_free(mcast);
 		spin_lock_irq(&rdi->n_mcast_grps_lock);
 		rdi->n_mcast_grps_allocated--;
 		spin_unlock_irq(&rdi->n_mcast_grps_lock);
 	}
 
 	return 0;
 }
 
 /**
- *rvt_mast_tree_empty - determine if any qps are attached to any mcast group
- *@rdi: rvt dev struct
+ * rvt_mcast_tree_empty - determine if any qps are attached to any mcast group
+ * @rdi: rvt dev struct
  *
  * Return: in use count
  */
 int rvt_mcast_tree_empty(struct rvt_dev_info *rdi)
 {
 	int i;
 	int in_use = 0;
 
 	for (i = 0; i < rdi->dparms.nports; i++)
 		if (rdi->ports[i]->mcast_tree.rb_node)
 			in_use++;
 	return in_use;
 }
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index e9db6bf10618..22fa9bde5419 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1798,65 +1798,65 @@ int rvt_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	attr->alt_ah_attr = qp->alt_ah_attr;
 	attr->pkey_index = qp->s_pkey_index;
 	attr->alt_pkey_index = qp->s_alt_pkey_index;
 	attr->en_sqd_async_notify = 0;
 	attr->sq_draining = qp->s_draining;
 	attr->max_rd_atomic = qp->s_max_rd_atomic;
 	attr->max_dest_rd_atomic = qp->r_max_rd_atomic;
 	attr->min_rnr_timer = qp->r_min_rnr_timer;
 	attr->port_num = qp->port_num;
 	attr->timeout = qp->timeout;
 	attr->retry_cnt = qp->s_retry_cnt;
 	attr->rnr_retry = qp->s_rnr_retry_cnt;
 	attr->alt_port_num =
 		rdma_ah_get_port_num(&qp->alt_ah_attr);
 	attr->alt_timeout = qp->alt_timeout;
 
 	init_attr->event_handler = qp->ibqp.event_handler;
 	init_attr->qp_context = qp->ibqp.qp_context;
 	init_attr->send_cq = qp->ibqp.send_cq;
 	init_attr->recv_cq = qp->ibqp.recv_cq;
 	init_attr->srq = qp->ibqp.srq;
 	init_attr->cap = attr->cap;
 	if (qp->s_flags & RVT_S_SIGNAL_REQ_WR)
 		init_attr->sq_sig_type = IB_SIGNAL_REQ_WR;
 	else
 		init_attr->sq_sig_type = IB_SIGNAL_ALL_WR;
 	init_attr->qp_type = qp->ibqp.qp_type;
 	init_attr->port_num = qp->port_num;
 	return 0;
 }
 
 /**
- * rvt_post_receive - post a receive on a QP
+ * rvt_post_recv - post a receive on a QP
  * @ibqp: the QP to post the receive on
  * @wr: the WR to post
  * @bad_wr: the first bad WR is put here
  *
  * This may be called from interrupt context.
  *
  * Return: 0 on success otherwise errno
  */
 int rvt_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 		  const struct ib_recv_wr **bad_wr)
 {
 	struct rvt_qp *qp = ibqp_to_rvtqp(ibqp);
 	struct rvt_krwq *wq = qp->r_rq.kwq;
 	unsigned long flags;
 	int qp_err_flush = (ib_rvt_state_ops[qp->state] & RVT_FLUSH_RECV) &&
 				!qp->ibqp.srq;
 
 	/* Check that state is OK to post receive. */
 	if (!(ib_rvt_state_ops[qp->state] & RVT_POST_RECV_OK) || !wq) {
 		*bad_wr = wr;
 		return -EINVAL;
 	}
 
 	for (; wr; wr = wr->next) {
 		struct rvt_rwqe *wqe;
 		u32 next;
 		int i;
 
 		if ((unsigned)wr->num_sge > qp->r_rq.max_sge) {
 			*bad_wr = wr;
 			return -EINVAL;
 		}
@@ -2220,65 +2220,65 @@ int rvt_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 
 	/*
 	 * If the send queue is empty, and we only have a single WR then just go
 	 * ahead and kick the send engine into gear. Otherwise we will always
 	 * just schedule the send to happen later.
 	 */
 	call_send = qp->s_head == READ_ONCE(qp->s_last) && !wr->next;
 
 	for (; wr; wr = wr->next) {
 		err = rvt_post_one_wr(qp, wr, &call_send);
 		if (unlikely(err)) {
 			*bad_wr = wr;
 			goto bail;
 		}
 		nreq++;
 	}
 bail:
 	spin_unlock_irqrestore(&qp->s_hlock, flags);
 	if (nreq) {
 		/*
 		 * Only call do_send if there is exactly one packet, and the
 		 * driver said it was ok.
 		 */
 		if (nreq == 1 && call_send)
 			rdi->driver_f.do_send(qp);
 		else
 			rdi->driver_f.schedule_send_no_lock(qp);
 	}
 	return err;
 }
 
 /**
- * rvt_post_srq_receive - post a receive on a shared receive queue
+ * rvt_post_srq_recv - post a receive on a shared receive queue
  * @ibsrq: the SRQ to post the receive on
  * @wr: the list of work requests to post
  * @bad_wr: A pointer to the first WR to cause a problem is put here
  *
  * This may be called from interrupt context.
  *
  * Return: 0 on success else errno
  */
 int rvt_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 		      const struct ib_recv_wr **bad_wr)
 {
 	struct rvt_srq *srq = ibsrq_to_rvtsrq(ibsrq);
 	struct rvt_krwq *wq;
 	unsigned long flags;
 
 	for (; wr; wr = wr->next) {
 		struct rvt_rwqe *wqe;
 		u32 next;
 		int i;
 
 		if ((unsigned)wr->num_sge > srq->rq.max_sge) {
 			*bad_wr = wr;
 			return -EINVAL;
 		}
 
 		spin_lock_irqsave(&srq->rq.kwq->p_lock, flags);
 		wq = srq->rq.kwq;
 		next = wq->head + 1;
 		if (next >= srq->rq.size)
 			next = 0;
 		if (next == READ_ONCE(wq->tail)) {
 			spin_unlock_irqrestore(&srq->rq.kwq->p_lock, flags);
@@ -2472,65 +2472,65 @@ int rvt_get_rwqe(struct rvt_qp *qp, bool wr_id_only)
 	ret = 1;
 	set_bit(RVT_R_WRID_VALID, &qp->r_aflags);
 	if (handler) {
 		/*
 		 * Validate head pointer value and compute
 		 * the number of remaining WQEs.
 		 */
 		if (kwq->count < srq->limit) {
 			kwq->count =
 				rvt_get_rq_count(rq,
 						 get_rvt_head(rq, ip), tail);
 			if (kwq->count < srq->limit) {
 				struct ib_event ev;
 
 				srq->limit = 0;
 				spin_unlock_irqrestore(&rq->kwq->c_lock, flags);
 				ev.device = qp->ibqp.device;
 				ev.element.srq = qp->ibqp.srq;
 				ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
 				handler(&ev, srq->ibsrq.srq_context);
 				goto bail;
 			}
 		}
 	}
 unlock:
 	spin_unlock_irqrestore(&rq->kwq->c_lock, flags);
 bail:
 	return ret;
 }
 EXPORT_SYMBOL(rvt_get_rwqe);
 
 /**
- * qp_comm_est - handle trap with QP established
+ * rvt_comm_est - handle trap with QP established
  * @qp: the QP
  */
 void rvt_comm_est(struct rvt_qp *qp)
 {
 	qp->r_flags |= RVT_R_COMM_EST;
 	if (qp->ibqp.event_handler) {
 		struct ib_event ev;
 
 		ev.device = qp->ibqp.device;
 		ev.element.qp = &qp->ibqp;
 		ev.event = IB_EVENT_COMM_EST;
 		qp->ibqp.event_handler(&ev, qp->ibqp.qp_context);
 	}
 }
 EXPORT_SYMBOL(rvt_comm_est);
 
 void rvt_rc_error(struct rvt_qp *qp, enum ib_wc_status err)
 {
 	unsigned long flags;
 	int lastwqe;
 
 	spin_lock_irqsave(&qp->s_lock, flags);
 	lastwqe = rvt_error_qp(qp, err);
 	spin_unlock_irqrestore(&qp->s_lock, flags);
 
 	if (lastwqe) {
 		struct ib_event ev;
 
 		ev.device = qp->ibqp.device;
 		ev.element.qp = &qp->ibqp;
 		ev.event = IB_EVENT_QP_LAST_WQE_REACHED;
 		qp->ibqp.event_handler(&ev, qp->ibqp.qp_context);
@@ -2918,65 +2918,65 @@ void rvt_copy_sge(struct rvt_qp *qp, struct rvt_sge_state *ss,
 		} else if (cacheless_copy) {
 			cacheless_memcpy(sge->vaddr, data, len);
 		} else {
 			memcpy(sge->vaddr, data, len);
 		}
 		rvt_update_sge(ss, len, release);
 		data += len;
 		length -= len;
 	}
 
 	if (copy_last) {
 		copy_last = false;
 		in_last = true;
 		length = 8;
 		goto again;
 	}
 }
 EXPORT_SYMBOL(rvt_copy_sge);
 
 static enum ib_wc_status loopback_qp_drop(struct rvt_ibport *rvp,
 					  struct rvt_qp *sqp)
 {
 	rvp->n_pkt_drops++;
 	/*
 	 * For RC, the requester would timeout and retry so
 	 * shortcut the timeouts and just signal too many retries.
 	 */
 	return sqp->ibqp.qp_type == IB_QPT_RC ?
 		IB_WC_RETRY_EXC_ERR : IB_WC_SUCCESS;
 }
 
 /**
- * ruc_loopback - handle UC and RC loopback requests
+ * rvt_ruc_loopback - handle UC and RC loopback requests
  * @sqp: the sending QP
  *
  * This is called from rvt_do_send() to forward a WQE addressed to the same HFI
  * Note that although we are single threaded due to the send engine, we still
  * have to protect against post_send().  We don't have to worry about
  * receive interrupts since this is a connected protocol and all packets
  * will pass through here.
  */
 void rvt_ruc_loopback(struct rvt_qp *sqp)
 {
 	struct rvt_ibport *rvp =  NULL;
 	struct rvt_dev_info *rdi = ib_to_rvt(sqp->ibqp.device);
 	struct rvt_qp *qp;
 	struct rvt_swqe *wqe;
 	struct rvt_sge *sge;
 	unsigned long flags;
 	struct ib_wc wc;
 	u64 sdata;
 	atomic64_t *maddr;
 	enum ib_wc_status send_status;
 	bool release;
 	int ret;
 	bool copy_last = false;
 	int local_ops = 0;
 
 	rcu_read_lock();
 	rvp = rdi->ports[sqp->port_num - 1];
 
 	/*
 	 * Note that we check the responder QP state after
 	 * checking the requester's state.
 	 */
diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 3690e28cc7ea..1a459b35000c 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -710,65 +710,65 @@ iscsi_iser_set_param(struct iscsi_cls_conn *cls_conn,
 			return -EPROTO;
 		}
 		break;
 	case ISCSI_PARAM_DATADGST_EN:
 		sscanf(buf, "%d", &value);
 		if (value) {
 			iser_err("DataDigest wasn't negotiated to None\n");
 			return -EPROTO;
 		}
 		break;
 	case ISCSI_PARAM_IFMARKER_EN:
 		sscanf(buf, "%d", &value);
 		if (value) {
 			iser_err("IFMarker wasn't negotiated to No\n");
 			return -EPROTO;
 		}
 		break;
 	case ISCSI_PARAM_OFMARKER_EN:
 		sscanf(buf, "%d", &value);
 		if (value) {
 			iser_err("OFMarker wasn't negotiated to No\n");
 			return -EPROTO;
 		}
 		break;
 	default:
 		return iscsi_set_param(cls_conn, param, buf, buflen);
 	}
 
 	return 0;
 }
 
 /**
- * iscsi_iser_set_param() - set class connection parameter
+ * iscsi_iser_conn_get_stats() - get iscsi connection statistics
  * @cls_conn:    iscsi class connection
  * @stats:       iscsi stats to output
  *
  * Output connection statistics.
  */
 static void
 iscsi_iser_conn_get_stats(struct iscsi_cls_conn *cls_conn, struct iscsi_stats *stats)
 {
 	struct iscsi_conn *conn = cls_conn->dd_data;
 
 	stats->txdata_octets = conn->txdata_octets;
 	stats->rxdata_octets = conn->rxdata_octets;
 	stats->scsicmd_pdus = conn->scsicmd_pdus_cnt;
 	stats->dataout_pdus = conn->dataout_pdus_cnt;
 	stats->scsirsp_pdus = conn->scsirsp_pdus_cnt;
 	stats->datain_pdus = conn->datain_pdus_cnt; /* always 0 */
 	stats->r2t_pdus = conn->r2t_pdus_cnt; /* always 0 */
 	stats->tmfcmd_pdus = conn->tmfcmd_pdus_cnt;
 	stats->tmfrsp_pdus = conn->tmfrsp_pdus_cnt;
 	stats->custom_length = 0;
 }
 
 static int iscsi_iser_get_ep_param(struct iscsi_endpoint *ep,
 				   enum iscsi_param param, char *buf)
 {
 	struct iser_conn *iser_conn = ep->dd_data;
 
 	switch (param) {
 	case ISCSI_PARAM_CONN_PORT:
 	case ISCSI_PARAM_CONN_ADDRESS:
 		if (!iser_conn || !iser_conn->ib_conn.cma_id)
 			return -ENOTCONN;
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h b/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
index f64519872297..012fc27c5c93 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
@@ -408,65 +408,65 @@ struct opa_veswport_error_counters {
 	__be64  rx_drop_state;
 	__be64  rx_logic;
 	__be64  rsvd8;
 
 	__be64  rsvd9[16];
 } __packed;
 
 /**
  * struct opa_veswport_trap - Trap message sent to EM by VNIC
  * @fabric_id: 10 bit fabric id
  * @veswid: 12 bit virtual ethernet switch id
  * @veswportnum: logical port number on the Virtual switch
  * @opaportnum: physical port num (redundant on host)
  * @veswportindex: switch port index on opa port 0 based
  * @opcode: operation
  * @reserved: 32 bit for alignment
  *
  * The VNIC will send trap messages to the Ethernet manager to
  * inform it about changes to the VNIC config, behaviour etc.
  * This is the format of the trap payload.
  */
 struct opa_veswport_trap {
 	__be16  fabric_id;
 	__be16  veswid;
 	__be32  veswportnum;
 	__be16  opaportnum;
 	u8      veswportindex;
 	u8      opcode;
 	__be32  reserved;
 } __packed;
 
 /**
- * struct opa_vnic_iface_macs_entry - single entry in the mac list
+ * struct opa_vnic_iface_mac_entry - single entry in the mac list
  * @mac_addr: MAC address
  */
 struct opa_vnic_iface_mac_entry {
 	u8 mac_addr[ETH_ALEN];
 };
 
 /**
  * struct opa_veswport_iface_macs - Msg to set globally administered MAC
  * @start_idx: position of first entry (0 based)
  * @num_macs_in_msg: number of MACs in this message
  * @tot_macs_in_lst: The total number of MACs the agent has
  * @gen_count: gen_count to indicate change
  * @entry: The mac list entry
  *
  * Same attribute IDS and attribute modifiers as in locally administered
  * addresses used to set globally administered addresses
  */
 struct opa_veswport_iface_macs {
 	__be16 start_idx;
 	__be16 num_macs_in_msg;
 	__be16 tot_macs_in_lst;
 	__be16 gen_count;
 	struct opa_vnic_iface_mac_entry entry[];
 } __packed;
 
 /**
  * struct opa_vnic_vema_mad - Generic VEMA MAD
  * @mad_hdr: Generic MAD header
  * @rmpp_hdr: RMPP header for vendor specific MADs
  * @reserved: reserved bytes
  * @oui: Unique org identifier
  * @data: MAD data
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c
index 868b5aec1537..292c037aa239 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c
@@ -45,65 +45,65 @@
  *
  */
 
 /*
  * This file contains OPA VNIC EMA Interface functions.
  */
 
 #include "opa_vnic_internal.h"
 
 /**
  * opa_vnic_vema_report_event - sent trap to report the specified event
  * @adapter: vnic port adapter
  * @event: event to be reported
  *
  * This function calls vema api to sent a trap for the given event.
  */
 void opa_vnic_vema_report_event(struct opa_vnic_adapter *adapter, u8 event)
 {
 	struct __opa_veswport_info *info = &adapter->info;
 	struct __opa_veswport_trap trap_data;
 
 	trap_data.fabric_id = info->vesw.fabric_id;
 	trap_data.veswid = info->vesw.vesw_id;
 	trap_data.veswportnum = info->vport.port_num;
 	trap_data.opaportnum = adapter->port_num;
 	trap_data.veswportindex = adapter->vport_num;
 	trap_data.opcode = event;
 
 	opa_vnic_vema_send_trap(adapter, &trap_data, info->vport.encap_slid);
 }
 
 /**
- * opa_vnic_get_error_counters - get summary counters
+ * opa_vnic_get_summary_counters - get summary counters
  * @adapter: vnic port adapter
  * @cntrs: pointer to destination summary counters structure
  *
  * This function populates the summary counters that is maintained by the
  * given adapter to destination address provided.
  */
 void opa_vnic_get_summary_counters(struct opa_vnic_adapter *adapter,
 				   struct opa_veswport_summary_counters *cntrs)
 {
 	struct opa_vnic_stats vstats;
 	__be64 *dst;
 	u64 *src;
 
 	memset(&vstats, 0, sizeof(vstats));
 	spin_lock(&adapter->stats_lock);
 	adapter->rn_ops->ndo_get_stats64(adapter->netdev, &vstats.netstats);
 	spin_unlock(&adapter->stats_lock);
 
 	cntrs->vp_instance = cpu_to_be16(adapter->vport_num);
 	cntrs->vesw_id = cpu_to_be16(adapter->info.vesw.vesw_id);
 	cntrs->veswport_num = cpu_to_be32(adapter->port_num);
 
 	cntrs->tx_errors = cpu_to_be64(vstats.netstats.tx_errors);
 	cntrs->rx_errors = cpu_to_be64(vstats.netstats.rx_errors);
 	cntrs->tx_packets = cpu_to_be64(vstats.netstats.tx_packets);
 	cntrs->rx_packets = cpu_to_be64(vstats.netstats.rx_packets);
 	cntrs->tx_bytes = cpu_to_be64(vstats.netstats.tx_bytes);
 	cntrs->rx_bytes = cpu_to_be64(vstats.netstats.rx_bytes);
 
 	/*
 	 * This loop depends on layout of
 	 * opa_veswport_summary_counters opa_vnic_stats structures.
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index bdeb010efee6..76e66f630c17 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -318,65 +318,65 @@ struct srpt_rdma_ch {
 	enum rdma_ch_state	state;
 	struct kmem_cache	*rsp_buf_cache;
 	struct srpt_send_ioctx	**ioctx_ring;
 	struct kmem_cache	*req_buf_cache;
 	struct srpt_recv_ioctx	**ioctx_recv_ring;
 	struct list_head	list;
 	struct list_head	cmd_wait_list;
 	uint16_t		pkey;
 	bool			using_rdma_cm;
 	bool			processing_wait_list;
 	struct se_session	*sess;
 	u8			sess_name[40];
 	struct work_struct	release_work;
 };
 
 /**
  * struct srpt_nexus - I_T nexus
  * @rcu:       RCU head for this data structure.
  * @entry:     srpt_port.nexus_list list node.
  * @ch_list:   struct srpt_rdma_ch list. Protected by srpt_port.mutex.
  * @i_port_id: 128-bit initiator port identifier copied from SRP_LOGIN_REQ.
  * @t_port_id: 128-bit target port identifier copied from SRP_LOGIN_REQ.
  */
 struct srpt_nexus {
 	struct rcu_head		rcu;
 	struct list_head	entry;
 	struct list_head	ch_list;
 	u8			i_port_id[16];
 	u8			t_port_id[16];
 };
 
 /**
- * struct srpt_port_attib - attributes for SRPT port
+ * struct srpt_port_attrib - attributes for SRPT port
  * @srp_max_rdma_size: Maximum size of SRP RDMA transfers for new connections.
  * @srp_max_rsp_size: Maximum size of SRP response messages in bytes.
  * @srp_sq_size: Shared receive queue (SRQ) size.
  * @use_srq: Whether or not to use SRQ.
  */
 struct srpt_port_attrib {
 	u32			srp_max_rdma_size;
 	u32			srp_max_rsp_size;
 	u32			srp_sq_size;
 	bool			use_srq;
 };
 
 /**
  * struct srpt_tpg - information about a single "target portal group"
  * @entry:	Entry in @sport_id->tpg_list.
  * @sport_id:	Port name this TPG is associated with.
  * @tpg:	LIO TPG data structure.
  *
  * Zero or more target portal groups are associated with each port name
  * (srpt_port_id). With each TPG an ACL list is associated.
  */
 struct srpt_tpg {
 	struct list_head	entry;
 	struct srpt_port_id	*sport_id;
 	struct se_portal_group	tpg;
 };
 
 /**
  * struct srpt_port_id - information about an RDMA port name
  * @mutex:	Protects @tpg_list changes.
  * @tpg_list:	TPGs associated with the RDMA port name.
  * @wwn:	WWN associated with the RDMA port name.
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 5c4a3c0dec5d..c20befb734ca 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3365,64 +3365,75 @@ int ib_query_pkey(struct ib_device *device,
 		  u8 port_num, u16 index, u16 *pkey);
 
 int ib_modify_device(struct ib_device *device,
 		     int device_modify_mask,
 		     struct ib_device_modify *device_modify);
 
 int ib_modify_port(struct ib_device *device,
 		   u8 port_num, int port_modify_mask,
 		   struct ib_port_modify *port_modify);
 
 int ib_find_gid(struct ib_device *device, union ib_gid *gid,
 		u8 *port_num, u16 *index);
 
 int ib_find_pkey(struct ib_device *device,
 		 u8 port_num, u16 pkey, u16 *index);
 
 enum ib_pd_flags {
 	/*
 	 * Create a memory registration for all memory in the system and place
 	 * the rkey for it into pd->unsafe_global_rkey.  This can be used by
 	 * ULPs to avoid the overhead of dynamic MRs.
 	 *
 	 * This flag is generally considered unsafe and must only be used in
 	 * extremly trusted environments.  Every use of it will log a warning
 	 * in the kernel log.
 	 */
 	IB_PD_UNSAFE_GLOBAL_RKEY	= 0x01,
 };
 
 struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 		const char *caller);
 
+/**
+ * ib_alloc_pd - Allocates an unused protection domain.
+ * @device: The device on which to allocate the protection domain.
+ * @flags: protection domain flags
+ *
+ * A protection domain object provides an association between QPs, shared
+ * receive queues, address handles, memory regions, and memory windows.
+ *
+ * Every PD has a local_dma_lkey which can be used as the lkey value for local
+ * memory operations.
+ */
 #define ib_alloc_pd(device, flags) \
 	__ib_alloc_pd((device), (flags), KBUILD_MODNAME)
 
 int ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata);
 
 /**
  * ib_dealloc_pd - Deallocate kernel PD
  * @pd: The protection domain
  *
  * NOTE: for user PD use ib_dealloc_pd_user with valid udata!
  */
 static inline void ib_dealloc_pd(struct ib_pd *pd)
 {
 	int ret = ib_dealloc_pd_user(pd, NULL);
 
 	WARN_ONCE(ret, "Destroy of kernel PD shouldn't fail");
 }
 
 enum rdma_create_ah_flags {
 	/* In a sleepable context */
 	RDMA_CREATE_AH_SLEEPABLE = BIT(0),
 };
 
 /**
  * rdma_create_ah - Creates an address handle for the given address vector.
  * @pd: The protection domain associated with the address handle.
  * @ah_attr: The attributes of the address vector.
  * @flags: Create address handle flags (see enum rdma_create_ah_flags).
  *
  * The address handle is used to reference a local or global destination
  * in all UD QP post sends.
  */
-- 
2.28.0

