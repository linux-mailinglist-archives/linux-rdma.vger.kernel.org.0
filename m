Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D6E341D87
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 13:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCSM5R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 08:57:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:4853 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhCSM4q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 08:56:46 -0400
IronPort-SDR: AdTh5EJK63n6WWgAZnafsMSt3wkCLISqPuclegX8qTHrtUyr/zTIDdDoRUZ2JW2rRwSgLRJ9Lo
 6To+H0Hq/bSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="209910291"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="209910291"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 05:56:45 -0700
IronPort-SDR: 2XQrGRPApuHKhdpY/fbeNUntKqIdV7242JZ0wChHvQcNVZWANklY6Z7xrXVyrNinF1A/2/eoZ+
 u/cjJ7PpOg4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="450851752"
Received: from phwfstl014.hd.intel.com ([10.127.241.142])
  by orsmga001.jf.intel.com with ESMTP; 19 Mar 2021 05:56:44 -0700
From:   kaike.wan@intel.com
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, todd.rimmer@intel.com,
        Kaike Wan <kaike.wan@intel.com>
Subject: [PATCH RFC 8/9] RDMA/rv: Add functions for file operations
Date:   Fri, 19 Mar 2021 08:56:34 -0400
Message-Id: <20210319125635.34492-9-kaike.wan@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210319125635.34492-1-kaike.wan@intel.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

A process communicates with the rv module through the file interface:
- The process opens the /dev/rv device file.
- The process sends an Attach request to bind to an RDMA device.
- The process registers a number of user/kernel memory regions (MR).
- The process sends Create Conn request to create connection between
  two nodes. If the local node is the server, it will start to listen
  to IB CM for any incoming connection request.
- The process sends Connect request to start connection. For a server
  node, it does nothing. However, for a client node, it will send the
  IB CM connection request.
- The process will wait for all connections to be established by
  polling the rv module. Receiving buffers will be posted.
- The process mmaps the event ring into user space.
- The process starts RDMA transaction by sending RDMA write with
  immediate requests to rv module. Send completion events will be
  posted to the event ring.
- On the responder side, RDMA write with immediate requests will be
  received and receive completion events will be posted to the event
  ring buffer.
- The process will poll the event ring for completion events.
- When RDMA transactions are done, the process deregisters the memory
  regions.
- The process closes the file. In this process, any connection will
  be torn down, and the RDMA device will be detached if there is no
  more user. Explicit detach and disconnection are not required.

Technically, the MR registration, RDMA transactions, and MR
deregistration occurs for every application IO.

This patch adds the functions for the file operations and integrates
the functions with memory region registration, connection management,
and RDMA transactions.

Signed-off-by: Todd Rimmer <todd.rimmer@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
---
 drivers/infiniband/ulp/rv/rv_file.c    | 1040 ++++++++++++++++++++++++
 drivers/infiniband/ulp/rv/rv_main.c    |    2 +-
 drivers/infiniband/ulp/rv/trace_conn.h |   18 +
 drivers/infiniband/ulp/rv/trace_user.h |  169 ++++
 4 files changed, 1228 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rv/rv_file.c b/drivers/infiniband/ulp/rv/rv_file.c
index 9d23503a30d9..e10bcdee11f5 100644
--- a/drivers/infiniband/ulp/rv/rv_file.c
+++ b/drivers/infiniband/ulp/rv/rv_file.c
@@ -9,11 +9,58 @@
 #include "rv.h"
 #include "trace.h"
 
+static unsigned long service_id = RV_DFLT_SERVICE_ID;
+
+module_param(service_id, ulong, 0444);
+MODULE_PARM_DESC(service_id, "Default service_id for IB CM QP connections");
+
+static unsigned int num_conn = 4;
+
+module_param(num_conn, uint, 0444);
+MODULE_PARM_DESC(num_conn, "Default # QPs between each pair of nodes");
+
+/*
+ * these are per node to node connection.
+ *
+ * conservative for now, we should service CQEs fast enough that smaller numbers
+ * would work, however at 100 remote nodes (hence 100 connections), 400,000
+ * CQEs at say 64B each, is only 50MB including send and recv
+ *
+ * A given PSM receiver process
+ * will not allow any more than HFI_TF_NFLOWS (32) inflight RDMA's coming
+ * toward it. So if we have ~100 processes per node, that limits inflight to
+ * 3200 coming toward us.
+ * while a given sender can have many in flight, the total a given destination
+ * process will allow is HFI_TF_NFLOWS (32), so size this same as recv CQ
+ * same reasoning applies to QP sizes
+ */
+#define RV_Q_DEPTH 4000 /* some headroom */
+
+static unsigned int q_depth = RV_Q_DEPTH;
+
+module_param(q_depth, uint, 0444);
+MODULE_PARM_DESC(q_depth, "Default size of queues per remote node");
+
+static int rv_file_mmap(struct file *fp, struct vm_area_struct *vma);
+static void rv_user_ring_free(struct rv_user_ring *ring);
+static void rv_user_detach_all(struct rv_user *rv);
+
+static atomic_t seq;
 /* A workqueue for all */
 static struct workqueue_struct *rv_wq;
 static struct workqueue_struct *rv_wq2;
 static struct workqueue_struct *rv_wq3;
 
+/* Device file access  */
+struct rv_devdata {
+	struct class *class;
+	dev_t dev;
+	struct cdev user_cdev;
+	struct device user_device;
+};
+
+static struct rv_devdata *rv_dd;
+
 /*
  * We expect relatively few jobs per node (typically 1)
  * and relatively few devices per node (typically 1 to 8)
@@ -24,7 +71,9 @@ static struct workqueue_struct *rv_wq3;
  * mutex avoids duplicate get_alloc adds, RCU protects list access.
  * See rv.h comments about "get_alloc" for more information.
  */
+static struct mutex rv_job_dev_list_mutex;
 static struct list_head rv_job_dev_list;
+static atomic_t rv_job_dev_cnt;
 
 void rv_queue_work(struct work_struct *work)
 {
@@ -46,16 +95,268 @@ void rv_flush_work2(void)
 	flush_workqueue(rv_wq2);
 }
 
+static int doit_query(struct rv_user *rv, unsigned long arg)
+{
+	struct rv_query_params_out params = { 0 };
+	int ret = 0;
+
+	params.major_rev = RV_ABI_VER_MAJOR;
+	params.minor_rev = RV_ABI_VER_MINOR;
+	params.capability = 0;
+
+	if (copy_to_user((void __user *)arg, &params, sizeof(params)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+/*
+ * only for use by rv_job_dev_get_alloc,
+ * all other callers must use rv_job_dev_get_alloc or rv_job_dev_get
+ * user_array is sized at end of rv_job_dev
+ * When num_conn>1 we will stripe across all sconn, so
+ * any given sconn's qp_depth can be smaller. However, this striping can be
+ * imperfect since not every IO is the same size. We allocate an
+ * extra 5% to minimize skipping sconns on send scheduling
+ */
+static struct rv_job_dev *
+rv_job_dev_alloc(int rv_inx, struct rv_device *dev,
+		 const struct rv_attach_params *params)
+{
+	int ret;
+	struct rv_job_dev *jdev;
+	int max_users = (1 << params->in.index_bits);
+
+	jdev = kzalloc(sizeof(*jdev) + sizeof(jdev->user_array[0]) * max_users,
+		       GFP_KERNEL);
+	if (!jdev) {
+		ret = -ENOMEM;
+		goto bail;
+	}
+
+	jdev->kuid = current_uid();
+	jdev->uid = from_kuid(current_user_ns(), jdev->kuid);
+	jdev->max_users = max_users;
+	spin_lock_init(&jdev->user_array_lock);
+	kref_init(&jdev->kref);
+	kref_init(&jdev->user_kref);
+	mutex_init(&jdev->conn_list_mutex);
+	INIT_LIST_HEAD(&jdev->conn_list);
+	jdev->dev = dev;
+	jdev->pd = ib_alloc_pd(jdev->dev->ib_dev, 0);
+	if (IS_ERR(jdev->pd)) {
+		rv_err(rv_inx, "Could not allocate PD\n");
+		ret = PTR_ERR(jdev->pd);
+		goto bail_free;
+	}
+
+	memcpy(jdev->dev_name, params->in.dev_name, sizeof(jdev->dev_name));
+	jdev->port_num = params->in.port_num;
+	jdev->num_conn = params->in.num_conn;
+	jdev->index_bits = params->in.index_bits;
+	jdev->loc_gid_index = params->in.loc_gid_index;
+	jdev->loc_addr = params->in.loc_addr;
+	memcpy(jdev->loc_gid, params->in.loc_gid, sizeof(jdev->loc_gid));
+	memcpy(jdev->job_key, params->in.job_key, sizeof(jdev->job_key));
+	jdev->job_key_len = params->in.job_key_len;
+	jdev->service_id =  params->in.service_id;
+	jdev->q_depth =  params->in.q_depth;
+	jdev->qp_depth = (jdev->q_depth + jdev->num_conn - 1) / jdev->num_conn;
+	if (jdev->num_conn > 1)
+		jdev->qp_depth += jdev->qp_depth / 20;
+	jdev->reconnect_timeout =  params->in.reconnect_timeout;
+	jdev->hb_interval =  params->in.hb_interval;
+	jdev->sgid_attr = rdma_get_gid_attr(jdev->dev->ib_dev, jdev->port_num,
+					    jdev->loc_gid_index);
+	if (!jdev->sgid_attr) {
+		rv_err(rv_inx, "can't resolve sgid_attr\n");
+		ret = -ENOENT;
+		goto bail_mr;
+	}
+	if (memcmp(&jdev->loc_gid, &jdev->sgid_attr->gid,
+		   sizeof(jdev->loc_gid))) {
+		rv_err(rv_inx, "sgid_attr gid and loc_gid mismatch\n");
+		ret = -ENOENT;
+		goto bail_put;
+	}
+	trace_rv_jdev_alloc(jdev, jdev->dev_name, jdev->num_conn,
+			    jdev->index_bits, jdev->loc_gid_index,
+			    jdev->loc_addr, jdev->job_key_len,
+			    jdev->job_key, jdev->service_id,
+			    jdev->q_depth, jdev->user_array_next,
+			    kref_read(&jdev->kref));
+	return jdev;
+
+bail_put:
+	rdma_put_gid_attr(jdev->sgid_attr);
+bail_mr:
+	ib_dealloc_pd(jdev->pd);
+bail_free:
+	kfree(jdev);
+bail:
+	return ERR_PTR(ret);
+}
+
+static int rv_job_dev_consistent(struct rv_job_dev *jdev,
+				 const struct rv_attach_params *params)
+{
+	return (params->in.num_conn == jdev->num_conn &&
+		params->in.index_bits == jdev->index_bits &&
+		params->in.loc_gid_index == jdev->loc_gid_index &&
+		params->in.loc_addr == jdev->loc_addr &&
+		!memcmp(jdev->loc_gid, params->in.loc_gid,
+			   sizeof(jdev->loc_gid)) &&
+		params->in.service_id == jdev->service_id &&
+		params->in.q_depth == jdev->q_depth &&
+		params->in.reconnect_timeout == jdev->reconnect_timeout &&
+		params->in.hb_interval == jdev->hb_interval);
+}
+
+static void rv_job_dev_list_init(void)
+{
+	mutex_init(&rv_job_dev_list_mutex);
+	INIT_LIST_HEAD(&rv_job_dev_list);
+	atomic_set(&rv_job_dev_cnt, 0);
+}
+
+static void rv_job_dev_user_release(struct kref *kref)
+{
+	struct rv_job_dev *jdev = container_of(kref, struct rv_job_dev,
+					       user_kref);
+
+	mutex_lock(&rv_job_dev_list_mutex);
+	list_del_rcu(&jdev->job_dev_entry);
+	mutex_unlock(&rv_job_dev_list_mutex);
+}
+
+static void rv_job_dev_put_user(struct rv_job_dev *jdev)
+{
+	kref_put(&jdev->user_kref, rv_job_dev_user_release);
+}
+
+/*
+ * get a job_dev matching the given ATTACH.  If none is found, create one
+ * The job_dev returned must be released with rv_job_dev_put when done using.
+ * Get device 1st to reduce lock nesting.  Device search should be quick.
+ * While searching for jdev, likely to have more devs than jobs, so filter on
+ * dev 1st.  job_key_len can be 0, which matches only jobs with job_key_len==0
+ * Ideally each job should have a unique job_key (really just a job identifer),
+ * but all jobs or processes with the same job_key must have the same params.
+ */
+static struct rv_job_dev *rv_job_dev_get_alloc(struct rv_user *rv,
+					       struct rv_attach_params *params)
+{
+	struct rv_job_dev *jdev;
+	struct rv_device *dev;
+
+	dev = rv_device_get_add_user(params->in.dev_name, rv);
+	if (!dev) {
+		rv_err(rv->inx, "attach: KERNEL ib_dev %s not found\n",
+		       params->in.dev_name);
+		return ERR_PTR(-ENODEV);
+	}
+
+	mutex_lock(&rv_job_dev_list_mutex);
+	rcu_read_lock();
+	list_for_each_entry_rcu(jdev, &rv_job_dev_list, job_dev_entry) {
+		if (!uid_eq(jdev->kuid, current_uid()) ||
+		    dev != jdev->dev ||
+		    params->in.port_num != jdev->port_num ||
+		    params->in.job_key_len != jdev->job_key_len ||
+		    (params->in.job_key_len &&
+		     memcmp(params->in.job_key, jdev->job_key,
+			    jdev->job_key_len)))
+			continue;
+		if (!kref_get_unless_zero(&jdev->kref))
+			continue;
+		if (!kref_get_unless_zero(&jdev->user_kref)) {
+			rv_job_dev_put(jdev);
+			continue;
+		}
+		rcu_read_unlock();
+		if (!rv_job_dev_consistent(jdev, params)) {
+			mutex_unlock(&rv_job_dev_list_mutex);
+			rv_job_dev_put_user(jdev);
+			rv_job_dev_put(jdev);
+			jdev = ERR_PTR(-EBUSY);
+			goto bail_put;
+		}
+		mutex_unlock(&rv_job_dev_list_mutex);
+		rv_device_put(dev);
+		return jdev;
+	}
+	rcu_read_unlock();
+	jdev = rv_job_dev_alloc(rv->inx, dev, params);
+	if (IS_ERR(jdev))
+		goto bail_unlock;
+
+	list_add_tail_rcu(&jdev->job_dev_entry, &rv_job_dev_list);
+	atomic_inc(&rv_job_dev_cnt);
+
+	mutex_unlock(&rv_job_dev_list_mutex);
+	return jdev;
+
+bail_unlock:
+	mutex_unlock(&rv_job_dev_list_mutex);
+bail_put:
+	rv_device_del_user(rv);
+	rv_device_put(dev);
+	return jdev;
+}
+
 void rv_job_dev_get(struct rv_job_dev *jdev)
 {
 	kref_get(&jdev->kref);
 }
 
+struct rv_dest_pd_work_item {
+	struct work_struct destroy_work;
+	struct ib_pd *pd;
+	struct rv_device *dev;
+};
+
+static void rv_handle_destroy_pd(struct work_struct *work)
+{
+	struct rv_dest_pd_work_item *item = container_of(work,
+				struct rv_dest_pd_work_item, destroy_work);
+
+	flush_workqueue(rv_wq2);
+	ib_dealloc_pd(item->pd);
+	rv_device_put(item->dev);
+	kfree(item);
+}
+
 static void rv_job_dev_release(struct kref *kref)
 {
 	struct rv_job_dev *jdev = container_of(kref, struct rv_job_dev, kref);
+	struct rv_dest_pd_work_item *item;
+
+	trace_rv_jdev_release(jdev, jdev->dev_name, jdev->num_conn,
+			      jdev->index_bits, jdev->loc_gid_index,
+			      jdev->loc_addr, jdev->job_key_len,
+			      jdev->job_key, jdev->service_id,
+			      jdev->q_depth, jdev->user_array_next,
+			      kref_read(&jdev->kref));
 
+	WARN_ON(!list_empty(&jdev->conn_list)); /* RCU safe */
+
+	if (jdev->listener)
+		rv_listener_put(jdev->listener);
+	rdma_put_gid_attr(jdev->sgid_attr);
+	item = kzalloc(sizeof(*item), GFP_KERNEL);
+	if (item) {
+		INIT_WORK(&item->destroy_work, rv_handle_destroy_pd);
+		item->pd = jdev->pd;
+		item->dev = jdev->dev;
+		jdev->pd = NULL;
+		jdev->dev = NULL;
+		rv_queue_work3(&item->destroy_work);
+	} else {
+		ib_dealloc_pd(jdev->pd);
+		rv_device_put(jdev->dev);
+	}
 	kfree_rcu(jdev, rcu);
+	atomic_dec(&rv_job_dev_cnt);
 }
 
 void rv_job_dev_put(struct rv_job_dev *jdev)
@@ -63,6 +364,316 @@ void rv_job_dev_put(struct rv_job_dev *jdev)
 	kref_put(&jdev->kref, rv_job_dev_release);
 }
 
+/*
+ * make a bi-directional linkage between rv_user and rv_job_dev
+ * Each rv_user is assigned a unique index within it's job_dev.
+ * This will be placed in RDMA immediate data on
+ * remote node so in recv CQE we can figure out which rv to deliver
+ * the RDMA w/immediate recv CQE event to
+ */
+static int rv_job_dev_add_user(struct rv_job_dev *jdev, struct rv_user *rv)
+{
+	unsigned long flags;
+	int i;
+	struct rv_user **jentry;
+	u32 next;
+
+	spin_lock_irqsave(&jdev->user_array_lock, flags);
+	next = jdev->user_array_next;
+	jentry = &jdev->user_array[next];
+	for (i = 0; i < jdev->max_users && *jentry; i++) {
+		if (++next >= jdev->max_users) {
+			next = 0;
+			jentry = &jdev->user_array[0];
+		} else {
+			jentry++;
+		}
+	}
+	if (i >= jdev->max_users) {
+		i = -ENOMEM;
+		goto unlock;
+	}
+	i = next;
+	if (++next >= jdev->max_users)
+		next = 0;
+	jdev->user_array_next = next;
+	*jentry = rv;
+	rv->index = i;
+
+unlock:
+	spin_unlock_irqrestore(&jdev->user_array_lock, flags);
+	return i;
+}
+
+/* break the bi-directional linkage between rv_user and rv_job_dev */
+static void rv_job_dev_del_user(struct rv_job_dev *jdev, struct rv_user *rv)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&jdev->user_array_lock, flags);
+	WARN_ON(rv->index >= jdev->max_users);
+	WARN_ON(jdev->user_array[rv->index] != rv);
+	jdev->user_array[rv->index] = NULL;
+	rv->index = RV_INVALID;
+	spin_unlock_irqrestore(&jdev->user_array_lock, flags);
+}
+
+/* attach for rdma_mode KERNEL */
+static int rv_user_attach_kernel(struct rv_user *rv,
+				 struct rv_attach_params *params)
+{
+	struct rv_job_dev *jdev;
+	int ret;
+
+	jdev = rv_job_dev_get_alloc(rv, params);
+	if (IS_ERR(jdev))
+		return PTR_ERR(jdev);
+
+	rv->jdev = jdev;
+	rv->context = params->in.context;
+	rv->cq_entries = params->in.cq_entries;
+
+	ret = rv_job_dev_add_user(jdev, rv);
+	if (ret < 0) {
+		rv->jdev = NULL;
+		rv->context = 0;
+		rv->cq_entries = 0;
+		rv_job_dev_put_user(jdev);
+		rv_job_dev_put(jdev);
+		return ret;
+	}
+	return 0;
+}
+
+static void rv_user_detach_kernel(struct rv_user *rv)
+{
+	if (!rv->jdev)
+		return;
+	rv_job_dev_del_user(rv->jdev, rv);
+	rv_job_dev_put(rv->jdev);
+}
+
+/*
+ * Attach an rv_user to a jdev
+ * Note hb_interval must be less than reconnect_timeout otherwise listener
+ * could timeout before client side discovers it must reconnect
+ * To avoid deadlock rv_user_mrs_alloc must be called without rv->mutex
+ * because it will acquire mm->mmap_lock.
+ */
+static int doit_attach(struct rv_user *rv, unsigned long arg)
+{
+	struct rv_attach_params params;
+	int ret;
+	struct rv_user_mrs *umrs;
+	u32 reconnect_timeout = 0;
+	u32 depth_out = 0;
+
+	if (copy_from_user(&params.in, (void __user *)arg, sizeof(params.in)))
+		return -EFAULT;
+
+	trace_rv_attach_req(rv->inx, params.in.dev_name, params.in.rdma_mode,
+			    params.in.port_num, params.in.loc_addr,
+			    params.in.job_key_len, params.in.job_key,
+			    params.in.service_id,
+			    params.in.cq_entries, params.in.q_depth,
+			    params.in.reconnect_timeout,
+			    params.in.hb_interval);
+	if (!params.in.dev_name[0] ||
+	    strnlen(params.in.dev_name, RV_MAX_DEV_NAME_LEN) >=
+		    RV_MAX_DEV_NAME_LEN) {
+		rv_err(rv->inx,
+		       "attach: dev_name empty or not nul terminated\n");
+		return -EINVAL;
+	}
+	if (params.in.rdma_mode > RV_RDMA_MODE_MAX) {
+		rv_err(rv->inx, "attach: rdma_mode invalid\n");
+		return -EINVAL;
+	}
+	if (params.in.rdma_mode == RV_RDMA_MODE_KERNEL) {
+		if (!params.in.port_num) {
+			rv_err(rv->inx, "attach: port_num invalid\n");
+			return -EINVAL;
+		}
+		if (params.in.num_conn > RV_MAX_NUM_CONN) {
+			rv_err(rv->inx,
+			       "attach: num_conn too large %d max %d\n",
+			       params.in.num_conn, RV_MAX_NUM_CONN);
+			return -EINVAL;
+		}
+		if (params.in.index_bits > RV_MAX_INDEX_BITS) {
+			rv_err(rv->inx,
+			       "attach: index_bits too large %d max %d\n",
+			       params.in.index_bits, RV_MAX_INDEX_BITS);
+			return -EINVAL;
+		}
+		if (params.in.job_key_len > RV_MAX_JOB_KEY_LEN) {
+			rv_err(rv->inx,
+			       "attach: job_key too large %u max %u\n",
+			       params.in.job_key_len, RV_MAX_JOB_KEY_LEN);
+			return -EINVAL;
+		}
+		if (params.in.cq_entries > RV_MAX_CQ_ENTRIES) {
+			rv_err(rv->inx,
+			       "attach: cq_entries too large %d max %d\n",
+			       params.in.cq_entries, RV_MAX_CQ_ENTRIES);
+			return -EINVAL;
+		}
+	} else if (!enable_user_mr) {
+		rv_err(rv->inx, "attach: rdma_mode user disabled\n");
+		return -EINVAL;
+	}
+
+	if (!params.in.num_conn)
+		params.in.num_conn = num_conn;
+	if (!params.in.num_conn)
+		params.in.num_conn = 1;
+	if (!params.in.service_id)
+		params.in.service_id = service_id;
+	if (!params.in.q_depth)
+		params.in.q_depth = q_depth;
+	if (params.in.reconnect_timeout &&
+	    params.in.reconnect_timeout * 1000 <= params.in.hb_interval) {
+		rv_err(rv->inx,
+		       "reconnect_timeout (%u secs) < hb_interval (%u msec)\n",
+		       params.in.reconnect_timeout, params.in.hb_interval);
+		return -EINVAL;
+	}
+
+	umrs = rv_user_mrs_alloc(rv, params.in.mr_cache_size);
+	if (IS_ERR(umrs))
+		return PTR_ERR(umrs);
+
+	mutex_lock(&rv->mutex);
+	if (rv->attached || rv->was_attached) {
+		rv_err(rv->inx, "attach: already attached to device\n");
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	rv->rdma_mode = params.in.rdma_mode;
+
+	switch (rv->rdma_mode) {
+	case RV_RDMA_MODE_USER:
+		rv->dev = rv_device_get_add_user(params.in.dev_name, rv);
+		if (!rv->dev) {
+			rv_err(rv->inx, "attach: USER ib_dev %s not found\n",
+			       params.in.dev_name);
+			ret = -ENODEV;
+			goto unlock;
+		}
+		rv->index = RV_INVALID; /* N/A */
+		depth_out = 0; /* N/A */
+		reconnect_timeout = 0; /* N/A */
+		break;
+	case RV_RDMA_MODE_KERNEL:
+		ret = rv_user_attach_kernel(rv, &params);
+		if (ret) {
+			rv_err(rv->inx, "attach: for kernel mode\n");
+			goto unlock;
+		}
+		depth_out = rv->jdev->q_depth;
+		reconnect_timeout = rv->jdev->reconnect_timeout;
+		break;
+	}
+
+	rv->umrs = umrs;
+	rv_user_mrs_attach(rv);
+	params.out.rv_index = rv->index;
+	params.out.mr_cache_size = umrs->cache.max_size / (1024 * 1024);
+	params.out.q_depth = depth_out;
+	params.out.reconnect_timeout = reconnect_timeout;
+	if (copy_to_user((void __user *)arg, &params.out, sizeof(params.out))) {
+		ret = -EFAULT;
+		goto bail_detach;
+	}
+
+	/* set attached last */
+	rv->attached = 1;
+	rv->was_attached = 1;
+	trace_rv_user_attach(rv->inx, rv->rdma_mode, rv->attached,
+			     params.in.dev_name, rv->cq_entries, rv->index);
+	mutex_unlock(&rv->mutex);
+
+	return 0;
+
+bail_detach:
+	rv_device_del_user(rv);
+	rv_user_detach_all(rv);
+	mutex_unlock(&rv->mutex);
+	return ret;
+unlock:
+	mutex_unlock(&rv->mutex);
+	rv_user_mrs_put(umrs);
+	return ret;
+}
+
+/*
+ * detach everything we find, for USER or KERNEL rdma_mode.
+ * must hold rv->mutex before calling.
+ * Once rv_user.attached is 0, the rv_user.dev/jdev is not valid
+ * we are paranoid and detach everything we find even for USER mode
+ * We wait for umrs->kref to be 1, to ensure all pending writes have put
+ * their MRs.  This way our final umrs_put will free the mr_cache.
+ * Note: other callers of rv_user_mrs_put don't get rv->mutex
+ */
+static void rv_user_detach_all(struct rv_user *rv)
+{
+	struct rv_conn *conn;
+	unsigned long sleep_time = msecs_to_jiffies(100);
+
+	XA_STATE(xas, &rv->conn_xa, 0);
+
+	trace_rv_msg_detach_all(rv->inx, "rv_user_detach_all", 0, 0);
+	rv->attached = 0;
+	if (rv->rdma_mode == RV_RDMA_MODE_KERNEL && rv->jdev)
+		rv_job_dev_put_user(rv->jdev);
+	xas_for_each(&xas, conn, UINT_MAX) {
+		trace_rv_msg_uconn_remove(rv->inx, "rv_user remove uconn",
+					  (u64)conn, 0);
+		xas_store(&xas, NULL);
+		rv_conn_put(conn);
+	}
+
+	if (rv->umrs) {
+		while (kref_read(&rv->umrs->kref) > 1)
+			schedule_timeout_interruptible(sleep_time);
+
+		rv_user_mrs_put(rv->umrs);
+		rv->umrs = NULL;
+		flush_workqueue(rv_wq);
+	}
+
+	if (rv->rdma_mode == RV_RDMA_MODE_USER && rv->dev) {
+		rv_device_put(rv->dev);
+		rv->dev = NULL;
+	} else if (rv->rdma_mode == RV_RDMA_MODE_KERNEL && rv->jdev) {
+		rv_user_detach_kernel(rv);
+		rv->jdev = NULL;
+	}
+
+	rv->rdma_mode = RV_RDMA_MODE_USER;
+
+	complete(&rv->compl);
+}
+
+/* Other cleanup at file close time. Must hold rv->mutex. */
+static void rv_user_cleanup(struct rv_user *rv)
+{
+	if (rv->cqr) {
+		trace_rv_msg_cleanup(rv->inx, "freeing event ring",
+				     (u64)rv->cqr, 0);
+		rv_user_ring_free(rv->cqr);
+		rv->cqr = NULL;
+	}
+}
+
+void rv_detach_user(struct rv_user *rv)
+{
+	mutex_lock(&rv->mutex);
+	rv_user_detach_all(rv);
+	mutex_unlock(&rv->mutex);
+}
+
 /*
  * confirm that we expected a REQ from this remote node on this port.
  * Note CM swaps src vs dest so dest is remote node here
@@ -154,3 +765,432 @@ rv_find_sconn_from_req(struct ib_cm_id *id,
 
 	return sconn;
 }
+
+/* Technically don't need rv_user.mutex, but play it safe */
+static int doit_get_cache_stats(struct rv_user *rv, unsigned long arg)
+{
+	struct rv_cache_stats_params_out params;
+	int ret = 0;
+	unsigned long flags;
+
+	mutex_lock(&rv->mutex);
+
+	memset(&params, 0, sizeof(params));
+	if (rv->attached && rv->umrs) {
+		struct rv_mr_cache *cache = &rv->umrs->cache;
+
+		spin_lock_irqsave(&cache->lock, flags);
+
+		params.cache_size = cache->total_size;
+		params.max_cache_size = cache->stats.max_cache_size;
+		params.limit_cache_size = cache->max_size / (1024 * 1024);
+		params.count = cache->stats.count;
+		params.max_count = cache->stats.max_count;
+		params.inuse = cache->stats.inuse;
+		params.max_inuse = cache->stats.max_inuse;
+		params.inuse_bytes = cache->stats.inuse_bytes;
+		params.max_inuse_bytes = cache->stats.max_inuse_bytes;
+		params.max_refcount = cache->stats.max_refcount;
+		params.hit = cache->stats.hit;
+		params.miss = cache->stats.miss;
+		params.full = cache->stats.full;
+		params.failed = rv->umrs->stats.failed;
+		params.remove = cache->stats.remove;
+		params.evict = cache->stats.evict;
+
+		spin_unlock_irqrestore(&cache->lock, flags);
+	}
+
+	if (copy_to_user((void __user *)arg, &params, sizeof(params)))
+		ret = -EFAULT;
+
+	mutex_unlock(&rv->mutex);
+
+	return ret;
+}
+
+/* Technically don't need rv_user.mutex, but play it safe */
+static int doit_get_event_stats(struct rv_user *rv, unsigned long arg)
+{
+	struct rv_event_stats_params_out params;
+	int ret = 0;
+	unsigned long flags;
+
+	mutex_lock(&rv->mutex);
+
+	memset(&params, 0, sizeof(params));
+	if (rv->attached && rv->cqr) {
+		struct rv_user_ring *cqr = rv->cqr;
+
+		spin_lock_irqsave(&cqr->lock, flags);
+
+		params.send_write_cqe = cqr->stats.cqe[RV_WC_RDMA_WRITE];
+		params.send_write_cqe_fail =
+			cqr->stats.cqe_fail[RV_WC_RDMA_WRITE];
+		params.send_write_bytes = cqr->stats.bytes[RV_WC_RDMA_WRITE];
+
+		params.recv_write_cqe =
+			cqr->stats.cqe[RV_WC_RECV_RDMA_WITH_IMM];
+		params.recv_write_cqe_fail =
+			cqr->stats.cqe_fail[RV_WC_RECV_RDMA_WITH_IMM];
+		params.recv_write_bytes =
+			cqr->stats.bytes[RV_WC_RECV_RDMA_WITH_IMM];
+
+		spin_unlock_irqrestore(&cqr->lock, flags);
+	}
+
+	if (copy_to_user((void __user *)arg, &params, sizeof(params)))
+		ret = -EFAULT;
+
+	mutex_unlock(&rv->mutex);
+
+	return ret;
+}
+
+static int rv_file_open(struct inode *inode, struct file *fp)
+{
+	struct rv_user *rv;
+
+	rv = kzalloc(sizeof(*rv), GFP_KERNEL);
+	if (!rv)
+		return -ENOMEM;
+	mutex_init(&rv->mutex);
+	xa_init_flags(&rv->conn_xa, XA_FLAGS_ALLOC);
+	INIT_LIST_HEAD(&rv->user_entry);
+	init_completion(&rv->compl);
+	rv->inx = atomic_inc_return(&seq);
+	rv->index = RV_INVALID;
+	fp->private_data = rv;
+	trace_rv_user_open(rv->inx, rv->rdma_mode, rv->attached, "n/a",
+			   rv->cq_entries, rv->index);
+
+	return 0;
+}
+
+/*
+ * Remove rv_user from dev->user_list first. If it is already
+ * removed from dev->user_list by remove_one(), wait for the
+ * detach to finish.  Otherwise detach_all here will remove it.
+ */
+static int rv_file_close(struct inode *inode, struct file *fp)
+{
+	struct rv_user *rv = fp->private_data;
+
+	trace_rv_user_close(rv->inx, rv->rdma_mode, rv->attached, "n/a",
+			    rv->cq_entries, rv->index);
+
+	fp->private_data = NULL;
+
+	mutex_lock(&rv->mutex);
+	if (rv->attached && rv_device_del_user(rv))
+		goto unlock;
+
+	rv_user_detach_all(rv);
+unlock:
+	mutex_unlock(&rv->mutex);
+	wait_for_completion(&rv->compl);
+
+	mutex_lock(&rv->mutex);
+	rv_user_cleanup(rv);
+	mutex_unlock(&rv->mutex);
+	xa_destroy(&rv->conn_xa);
+	kfree(rv);
+
+	return 0;
+}
+
+static long rv_file_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct rv_user *rv = fp->private_data;
+
+	trace_rv_ioctl(rv->inx, cmd);
+	switch (cmd) {
+	case RV_IOCTL_QUERY:
+		return doit_query(rv, arg);
+
+	case RV_IOCTL_ATTACH:
+		return doit_attach(rv, arg);
+
+	case RV_IOCTL_REG_MEM:
+		return doit_reg_mem(rv, arg);
+
+	case RV_IOCTL_DEREG_MEM:
+		return doit_dereg_mem(rv, arg);
+
+	case RV_IOCTL_GET_CACHE_STATS:
+		return doit_get_cache_stats(rv, arg);
+
+	case RV_IOCTL_CONN_CREATE:
+		return doit_conn_create(rv, arg);
+
+	case RV_IOCTL_CONN_CONNECT:
+		return doit_conn_connect(rv, arg);
+
+	case RV_IOCTL_CONN_CONNECTED:
+		return doit_conn_connected(rv, arg);
+
+	case RV_IOCTL_CONN_GET_CONN_COUNT:
+		return doit_conn_get_conn_count(rv, arg);
+
+	case RV_IOCTL_CONN_GET_STATS:
+		return doit_conn_get_stats(rv, arg);
+
+	case RV_IOCTL_GET_EVENT_STATS:
+		return doit_get_event_stats(rv, arg);
+
+	case RV_IOCTL_POST_RDMA_WR_IMMED:
+		return doit_post_rdma_write(rv, arg);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct file_operations rv_file_ops = {
+	.owner = THIS_MODULE,
+	.open = rv_file_open,
+	.release = rv_file_close,
+	.unlocked_ioctl = rv_file_ioctl,
+	.llseek = noop_llseek,
+	.mmap = rv_file_mmap,
+};
+
+static void rv_dev_release(struct device *dev)
+{
+	kfree(rv_dd);
+	rv_dd = NULL;
+}
+
+static char *rv_devnode(struct device *dev, umode_t *mode)
+{
+	if (mode)
+		*mode = 0666;
+	return kasprintf(GFP_KERNEL, "%s", dev_name(dev));
+}
+
+int rv_file_init(void)
+{
+	int ret;
+	struct device *device;
+	struct cdev *cdev;
+
+	atomic_set(&seq, 0);
+	rv_job_dev_list_init();
+	rv_wq = alloc_workqueue("rv_wq",
+				WQ_SYSFS | WQ_HIGHPRI | WQ_CPU_INTENSIVE,
+				RV_CONN_MAX_ACTIVE_WQ_ENTRIES);
+	if (!rv_wq)
+		return -ENOMEM;
+
+	rv_wq2 = alloc_workqueue("rv_wq2",
+				 WQ_SYSFS | WQ_HIGHPRI | WQ_CPU_INTENSIVE,
+				 RV_CONN_MAX_ACTIVE_WQ_ENTRIES);
+	if (!rv_wq2) {
+		ret = -ENOMEM;
+		goto fail_wq;
+	}
+	rv_wq3 = alloc_workqueue("rv_wq3",
+				 WQ_SYSFS | WQ_HIGHPRI | WQ_CPU_INTENSIVE,
+				 10);
+	if (!rv_wq3) {
+		ret = -ENOMEM;
+		goto fail_wq;
+	}
+
+	rv_dd = kzalloc(sizeof(*rv_dd), GFP_KERNEL);
+	if (!rv_dd) {
+		ret = -ENOMEM;
+		goto fail_wq;
+	}
+
+	rv_dd->class = class_create(THIS_MODULE, DRIVER_NAME);
+	if (IS_ERR(rv_dd->class)) {
+		ret = PTR_ERR(rv_dd->class);
+		pr_err("Could not create device class: %d\n", ret);
+		goto fail_free;
+	}
+	rv_dd->class->devnode = rv_devnode;
+
+	/* Allocate the dev_t */
+	ret = alloc_chrdev_region(&rv_dd->dev, 0, 1, DRIVER_NAME);
+	if (ret < 0) {
+		pr_err("Could not allocate chrdev region (err %d)\n", -ret);
+		goto fail_destroy;
+	}
+
+	/* Add the char device to both sysfs and devfs */
+	device = &rv_dd->user_device;
+	device_initialize(device);
+	device->class = rv_dd->class;
+	device->parent = NULL;
+	device->devt = rv_dd->dev;
+	device->release = rv_dev_release;
+	dev_set_name(device, "%s", DRIVER_NAME);
+	cdev = &rv_dd->user_cdev;
+	cdev_init(cdev, &rv_file_ops);
+	cdev->owner = THIS_MODULE;
+	ret = cdev_device_add(cdev, device);
+	if (ret < 0) {
+		pr_err("Could not add cdev for %s\n", DRIVER_NAME);
+		goto fail_release;
+	}
+
+	return 0;
+
+fail_release:
+	unregister_chrdev_region(rv_dd->dev, 1);
+fail_destroy:
+	class_destroy(rv_dd->class);
+fail_free:
+	kfree(rv_dd);
+	rv_dd = NULL;
+fail_wq:
+	if (rv_wq3) {
+		destroy_workqueue(rv_wq3);
+		rv_wq3 = NULL;
+	}
+	if (rv_wq2) {
+		destroy_workqueue(rv_wq2);
+		rv_wq2 = NULL;
+	}
+	destroy_workqueue(rv_wq);
+	rv_wq = NULL;
+
+	return ret;
+}
+
+/*
+ * We wait for all job devs to finish. At this time, there are no more
+ * users. Please be reminded that in RV_RDMA_MODE_USER mode,
+ * no job_dev is allocated.
+ */
+void rv_file_uninit(void)
+{
+	unsigned long timeout = msecs_to_jiffies(100);
+
+	if (rv_dd) {
+		cdev_device_del(&rv_dd->user_cdev, &rv_dd->user_device);
+		unregister_chrdev_region(rv_dd->dev, 1);
+		class_destroy(rv_dd->class);
+		put_device(&rv_dd->user_device);
+	}
+
+	while (atomic_read(&rv_job_dev_cnt) > 0)
+		schedule_timeout_interruptible(timeout);
+
+	if (rv_wq3) {
+		flush_workqueue(rv_wq3);
+		destroy_workqueue(rv_wq3);
+		rv_wq3 = NULL;
+	}
+	if (rv_wq2) {
+		flush_workqueue(rv_wq2);
+		destroy_workqueue(rv_wq2);
+		rv_wq2 = NULL;
+	}
+	if (rv_wq) {
+		flush_workqueue(rv_wq);
+		destroy_workqueue(rv_wq);
+		rv_wq = NULL;
+	}
+}
+
+/* rv event reporting ring, allocated by mmap */
+static struct rv_user_ring *rv_user_ring_alloc(int rv_inx,
+					       u32 num_entries,
+					       struct vm_area_struct *vma)
+{
+	struct rv_user_ring *ring;
+	unsigned long len;
+	unsigned long pfn;
+	int ret;
+
+	len = RV_RING_ALLOC_LEN(num_entries);
+	len = ALIGN(len, SMP_CACHE_BYTES);
+	if (len > vma->vm_end - vma->vm_start) {
+		rv_err(rv_inx, "mmap too small for ring\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	ring = kzalloc(sizeof(*ring), GFP_KERNEL);
+	if (!ring)
+		return ERR_PTR(-ENOMEM);
+
+	ring->rv_inx = rv_inx;
+	ring->num_entries = num_entries;
+	ring->order = get_order(len);
+	ring->page =  __get_free_pages(GFP_KERNEL | __GFP_ZERO, ring->order);
+	if (!ring->page) {
+		rv_err(rv_inx, "ring alloc failure\n");
+		ret = -ENOMEM;
+		goto fail;
+	}
+	pfn = virt_to_phys((void *)ring->page) >> PAGE_SHIFT;
+
+	/* remap kernel memory to userspace */
+	ret = remap_pfn_range(vma, vma->vm_start, pfn, len, vma->vm_page_prot);
+	if (ret < 0) {
+		rv_err(rv_inx, "remap failed page:0x%lx pfn:0x%lx\n",
+		       (unsigned long)ring->page, pfn);
+		goto fail;
+	}
+	spin_lock_init(&ring->lock);
+	ring->hdr = (struct rv_ring_header *)ring->page;
+	ring->hdr->head = 0;
+	ring->hdr->tail = 0;
+	ring->hdr->overflow_cnt = 0;
+	trace_rv_user_ring_alloc(ring->rv_inx, ring->num_entries,
+				 ring->hdr->head, ring->hdr->tail);
+	return ring;
+
+fail:
+	if (ring->page)
+		free_pages(ring->page, ring->order);
+	kfree(ring);
+	return ERR_PTR(ret);
+}
+
+/* We sanity check ring->page, should always be != 0 here */
+static void rv_user_ring_free(struct rv_user_ring *ring)
+{
+	trace_rv_user_ring_free(ring->rv_inx, ring->num_entries,
+				ring->hdr->head, ring->hdr->tail);
+	if (ring->page)
+		free_pages(ring->page, ring->order);
+	kfree(ring);
+}
+
+/*
+ * we ignore offset, but if we decide we need multiple queues in future we
+ * can use that to identify which queue is being requested
+ */
+static int rv_file_mmap(struct file *fp, struct vm_area_struct *vma)
+{
+	struct rv_user *rv = fp->private_data;
+	struct rv_user_ring *ring;
+	int ret = -EINVAL;
+
+	trace_rv_msg_mmap(rv->inx, "vma", vma->vm_start, vma->vm_end);
+
+	mutex_lock(&rv->mutex);
+	if (rv->cqr) {
+		rv_err(rv->inx, "ring already allocated\n");
+		goto unlock;
+	}
+	if (!rv->cq_entries) {
+		rv_err(rv->inx, "ring disabled at attach time\n");
+		goto unlock;
+	}
+
+	ring  = rv_user_ring_alloc(rv->inx, rv->cq_entries, vma);
+	if (IS_ERR(ring)) {
+		ret = PTR_ERR(ring);
+		goto unlock;
+	}
+	rv->cqr = ring;
+	ret = 0;
+
+unlock:
+	mutex_unlock(&rv->mutex);
+	return ret;
+}
diff --git a/drivers/infiniband/ulp/rv/rv_main.c b/drivers/infiniband/ulp/rv/rv_main.c
index 7f81f97a01f0..c40ee36c6f9e 100644
--- a/drivers/infiniband/ulp/rv/rv_main.c
+++ b/drivers/infiniband/ulp/rv/rv_main.c
@@ -178,7 +178,7 @@ static void rv_device_detach_users(struct rv_device *dev)
 		list_del_init(&rv->user_entry);
 
 		spin_unlock_irqrestore(&rv_dev_list_lock, flags);
-		/* Detach user here */
+		rv_detach_user(rv);
 		spin_lock_irqsave(&rv_dev_list_lock, flags);
 	}
 	spin_unlock_irqrestore(&rv_dev_list_lock, flags);
diff --git a/drivers/infiniband/ulp/rv/trace_conn.h b/drivers/infiniband/ulp/rv/trace_conn.h
index 2626545b0df6..5ac7ce72dbaf 100644
--- a/drivers/infiniband/ulp/rv/trace_conn.h
+++ b/drivers/infiniband/ulp/rv/trace_conn.h
@@ -233,6 +233,24 @@ DEFINE_EVENT(/* event */
 		jkey_len, jkey, sid, q_depth, ua_next, refcount)
 );
 
+DEFINE_EVENT(/* event */
+	rv_jdev_template, rv_jdev_alloc,
+	TP_PROTO(void *ptr, const char *dev_name, u8 num_conn, u8 index_bits,
+		 u16 loc_gid_index, u32 loc_addr, u8 jkey_len, u8 *jkey,
+		 u64 sid, u32 q_depth, u32 ua_next, u32 refcount),
+	TP_ARGS(ptr, dev_name, num_conn, index_bits, loc_gid_index, loc_addr,
+		jkey_len, jkey, sid, q_depth, ua_next, refcount)
+);
+
+DEFINE_EVENT(/* event */
+	rv_jdev_template, rv_jdev_release,
+	TP_PROTO(void *ptr, const char *dev_name, u8 num_conn, u8 index_bits,
+		 u16 loc_gid_index, u32 loc_addr, u8 jkey_len, u8 *jkey,
+		 u64 sid, u32 q_depth, u32 ua_next, u32 refcount),
+	TP_ARGS(ptr, dev_name, num_conn, index_bits, loc_gid_index, loc_addr,
+		jkey_len, jkey, sid, q_depth, ua_next, refcount)
+);
+
 DECLARE_EVENT_CLASS(/* sconn */
 	rv_sconn_template,
 	TP_PROTO(void *ptr, u8 index, u32 qp_num, void *conn, u32 flags,
diff --git a/drivers/infiniband/ulp/rv/trace_user.h b/drivers/infiniband/ulp/rv/trace_user.h
index 90f67537d249..d03a53f89cc6 100644
--- a/drivers/infiniband/ulp/rv/trace_user.h
+++ b/drivers/infiniband/ulp/rv/trace_user.h
@@ -11,9 +11,70 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM rv_user
 
+#define RV_USER_PRN "Inx %d rdma_mode %u attached %u dev_name %s " \
+		    "cq_entries %u index %u"
+
 #define RV_USER_MRS_PRN "rv_nx %d jdev %p total_size 0x%llx max_size 0x%llx " \
 			"refcount %u"
 
+#define RV_ATTACH_REQ_PRN "inx %d Device %s rdma_mode %u port_num %u " \
+			  "loc_addr 0x%x jkey_len %u jkey 0x%s " \
+			  " service_id 0x%llx cq_entries %u q_depth %u " \
+			  " timeout %u hb_timeout %u"
+
+DECLARE_EVENT_CLASS(/* user */
+	rv_user_template,
+	TP_PROTO(int inx, u8 rdma_mode, u8 attached, const char *dev_name,
+		 u32 cq_entries, u16 index),
+	TP_ARGS(inx, rdma_mode, attached, dev_name, cq_entries, index),
+	TP_STRUCT__entry(/* entry */
+		__field(int, inx)
+		__field(u8, rdma_mode)
+		__field(u8, attached)
+		__string(name, dev_name)
+		__field(u32, cq_entries)
+		__field(u16, index)
+	),
+	TP_fast_assign(/* assign */
+		__entry->inx = inx;
+		__entry->rdma_mode = rdma_mode;
+		__entry->attached = attached;
+		__assign_str(name, dev_name);
+		__entry->cq_entries = cq_entries;
+		__entry->index = index;
+	),
+	TP_printk(/* print */
+		RV_USER_PRN,
+		__entry->inx,
+		__entry->rdma_mode,
+		__entry->attached,
+		__get_str(name),
+		__entry->cq_entries,
+		__entry->index
+	)
+);
+
+DEFINE_EVENT(/* event */
+	rv_user_template, rv_user_open,
+	TP_PROTO(int inx, u8 rdma_mode, u8 attached, const char *dev_name,
+		 u32 cq_entries, u16 index),
+	TP_ARGS(inx, rdma_mode, attached, dev_name, cq_entries, index)
+);
+
+DEFINE_EVENT(/* event */
+	rv_user_template, rv_user_close,
+	TP_PROTO(int inx, u8 rdma_mode, u8 attached, const char *dev_name,
+		 u32 cq_entries, u16 index),
+	TP_ARGS(inx, rdma_mode, attached, dev_name, cq_entries, index)
+);
+
+DEFINE_EVENT(/* event */
+	rv_user_template, rv_user_attach,
+	TP_PROTO(int inx, u8 rdma_mode, u8 attached, const char *dev_name,
+		 u32 cq_entries, u16 index),
+	TP_ARGS(inx, rdma_mode, attached, dev_name, cq_entries, index)
+);
+
 DECLARE_EVENT_CLASS(/* user msg */
 	rv_user_msg_template,
 	TP_PROTO(int inx, const char *msg, u64 d1, u64 d2),
@@ -51,6 +112,24 @@ DEFINE_EVENT(/* event */
 	TP_ARGS(inx, msg, d1, d2)
 );
 
+DEFINE_EVENT(/* event */
+	rv_user_msg_template, rv_msg_detach_all,
+	TP_PROTO(int inx, const char *msg, u64 d1, u64 d2),
+	TP_ARGS(inx, msg, d1, d2)
+);
+
+DEFINE_EVENT(/* event */
+	rv_user_msg_template, rv_msg_uconn_remove,
+	TP_PROTO(int inx, const char *msg, u64 d1, u64 d2),
+	TP_ARGS(inx, msg, d1, d2)
+);
+
+DEFINE_EVENT(/* event */
+	rv_user_msg_template, rv_msg_cleanup,
+	TP_PROTO(int inx, const char *msg, u64 d1, u64 d2),
+	TP_ARGS(inx, msg, d1, d2)
+);
+
 DEFINE_EVENT(/* event */
 	rv_user_msg_template, rv_msg_cmp_params,
 	TP_PROTO(int inx, const char *msg, u64 d1, u64 d2),
@@ -69,6 +148,12 @@ DEFINE_EVENT(/* event */
 	TP_ARGS(inx, msg, d1, d2)
 );
 
+DEFINE_EVENT(/* event */
+	rv_user_msg_template, rv_msg_mmap,
+	TP_PROTO(int inx, const char *msg, u64 d1, u64 d2),
+	TP_ARGS(inx, msg, d1, d2)
+);
+
 DECLARE_EVENT_CLASS(/* user_mrs */
 	rv_user_mrs_template,
 	TP_PROTO(int rv_inx, void *jdev, u64 total_size, u64 max_size,
@@ -112,6 +197,59 @@ DEFINE_EVENT(/* event */
 	TP_ARGS(rv_inx, jdev, total_size, max_size, refcount)
 );
 
+TRACE_EVENT(/* event */
+	rv_attach_req,
+	TP_PROTO(int inx, char *dev_name, u8 rdma_mode, u8 port_num,
+		 u32 loc_addr, u8 jkey_len, u8 *jkey, u64 service_id,
+		 u32 cq_entries, u32 q_depth, u32 timeout, u32 hb_timeout),
+	TP_ARGS(inx, dev_name, rdma_mode, port_num, loc_addr, jkey_len, jkey,
+		service_id, cq_entries, q_depth, timeout, hb_timeout),
+	TP_STRUCT__entry(/* entry */
+		__field(int, inx)
+		__string(device, dev_name)
+		__field(u8, rdma_mode)
+		__field(u8, port_num)
+		__field(u32, loc_addr)
+		__field(u8, jkey_len)
+		__array(u8, jkey, RV_MAX_JOB_KEY_LEN)
+		__field(u64, service_id)
+		__field(u32, cq_entries)
+		__field(u32, q_depth)
+		__field(u32, timeout)
+		__field(u32, hb_timeout)
+	),
+	TP_fast_assign(/* assign */
+		__entry->inx = inx;
+		__assign_str(device, dev_name);
+		__entry->inx = inx;
+		__entry->rdma_mode = rdma_mode;
+		__entry->port_num = port_num;
+		__entry->loc_addr = loc_addr;
+		__entry->jkey_len = jkey_len;
+		memcpy(__entry->jkey, jkey, RV_MAX_JOB_KEY_LEN);
+		__entry->service_id = service_id;
+		__entry->cq_entries = cq_entries;
+		__entry->q_depth = q_depth;
+		__entry->timeout = timeout;
+		__entry->hb_timeout = hb_timeout;
+	),
+	TP_printk(/* print */
+		RV_ATTACH_REQ_PRN,
+		__entry->inx,
+		__get_str(device),
+		__entry->rdma_mode,
+		__entry->port_num,
+		__entry->loc_addr,
+		__entry->jkey_len,
+		__print_hex_str(__entry->jkey, RV_MAX_JOB_KEY_LEN),
+		__entry->service_id,
+		__entry->cq_entries,
+		__entry->q_depth,
+		__entry->timeout,
+		__entry->hb_timeout
+	)
+);
+
 DECLARE_EVENT_CLASS(/* user_ring */
 	rv_user_ring_template,
 	TP_PROTO(int rv_inx, u32 count, u32 hd, u32 tail),
@@ -137,12 +275,43 @@ DECLARE_EVENT_CLASS(/* user_ring */
 	)
 );
 
+DEFINE_EVENT(/* event */
+	rv_user_ring_template, rv_user_ring_alloc,
+	TP_PROTO(int rv_inx, u32 count, u32 hd, u32 tail),
+	TP_ARGS(rv_inx, count, hd, tail)
+);
+
+DEFINE_EVENT(/* event */
+	rv_user_ring_template, rv_user_ring_free,
+	TP_PROTO(int rv_inx, u32 count, u32 hd, u32 tail),
+	TP_ARGS(rv_inx, count, hd, tail)
+);
+
 DEFINE_EVENT(/* event */
 	rv_user_ring_template, rv_user_ring_post_event,
 	TP_PROTO(int rv_inx, u32 count, u32 hd, u32 tail),
 	TP_ARGS(rv_inx, count, hd, tail)
 );
 
+TRACE_EVENT(/* event */
+	rv_ioctl,
+	TP_PROTO(int inx, u32 cmd),
+	TP_ARGS(inx, cmd),
+	TP_STRUCT__entry(/* entry */
+		__field(int, inx)
+		__field(u32, cmd)
+	),
+	TP_fast_assign(/* assign */
+		__entry->inx = inx;
+		__entry->cmd = cmd;
+	),
+	TP_printk(/* print */
+		"inx %d cmd 0x%x",
+		__entry->inx,
+		__entry->cmd
+	)
+);
+
 #endif /* __RV_TRACE_USER_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.18.1

