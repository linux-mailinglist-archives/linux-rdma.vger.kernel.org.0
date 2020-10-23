Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1ED297448
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 18:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465803AbgJWQfh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 12:35:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbgJWQdv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:51 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6D6024689;
        Fri, 23 Oct 2020 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470827;
        bh=j7k7sytz8mKgmUBtNYdsAfWtUy2wSY3Ypl6djEUtgfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYJoqd4a41qjmTHYS0m/pi3m5fP/352dPxkQ6viKSFVOyNYQtPgtV2aebt+ONNEl8
         qs+Wm/tqWz1R+YXP6FHHy3mb3PFHJPEmp6/pr2oK5nRBSJvD9U5udJbDFQtghb/JLj
         Qs64/Qbn1CQ0AOQ60S2N8PrpFG2/R0zwFi14CWS8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00f-002Avu-6Y; Fri, 23 Oct 2020 18:33:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Danit Goldberg <danitg@mellanox.com>,
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
Subject: [PATCH v3 14/56] IB: fix kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:01 +0200
Message-Id: <f201c81b58f7087425387672b24af5b85aa04b1a.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
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
index 5740d1ba3568..2dfbfdd6cc57 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1251,7 +1251,8 @@ int ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id, __be64 service_mask)
 EXPORT_SYMBOL(ib_cm_listen);
 
 /**
- * Create a new listening ib_cm_id and listen on the given service ID.
+ * ib_cm_insert_listen - Create a new listening ib_cm_id and listen on
+ *			 the given service ID.
  *
  * If there's an existing ID listening on that same device and service ID,
  * return it.
@@ -1764,7 +1765,7 @@ static u16 cm_get_bth_pkey(struct cm_work *work)
 }
 
 /**
- * Convert OPA SGID to IB SGID
+ * cm_opa_to_ib_sgid - Convert OPA SGID to IB SGID
  * ULPs (such as IPoIB) do not understand OPA GIDs and will
  * reject them as the local_gid will not match the sgid. Therefore,
  * change the pathrec's SGID to an IB SGID.
diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 12ebacf52958..d4248bbe74da 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -123,7 +123,7 @@ static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *wcs,
 }
 
 /**
- * ib_process_direct_cq - process a CQ in caller context
+ * ib_process_cq_direct - process a CQ in caller context
  * @cq:		CQ to process
  * @budget:	number of CQEs to poll for
  *
@@ -197,7 +197,7 @@ static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
 }
 
 /**
- * __ib_alloc_cq        allocate a completion queue
+ * __ib_alloc_cq - allocate a completion queue
  * @dev:		device to allocate the CQ for
  * @private:		driver private data, accessible from cq->cq_context
  * @nr_cqe:		number of CQEs to allocate
diff --git a/drivers/infiniband/core/iwpm_util.h b/drivers/infiniband/core/iwpm_util.h
index 1bf87d9fd0bd..eeb8e6010907 100644
--- a/drivers/infiniband/core/iwpm_util.h
+++ b/drivers/infiniband/core/iwpm_util.h
@@ -141,7 +141,7 @@ int iwpm_wait_complete_req(struct iwpm_nlmsg_request *nlmsg_request);
 int iwpm_get_nlmsg_seq(void);
 
 /**
- * iwpm_add_reminfo - Add remote address info of the connecting peer
+ * iwpm_add_remote_info - Add remote address info of the connecting peer
  *                    to the remote info hash table
  * @reminfo: The remote info to be added
  */
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 8c930bf1df89..89a831fa1885 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1435,7 +1435,8 @@ enum opa_pr_supported {
 };
 
 /**
- * Check if current PR query can be an OPA query.
+ * opa_pr_query_possible - Check if current PR query can be an OPA query.
+ *
  * Retuns PR_NOT_SUPPORTED if a path record query is not
  * possible, PR_OPA_SUPPORTED if an OPA path record query
  * is possible and PR_IB_SUPPORTED if an IB path record
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 740f8454b6b4..89f379cd7909 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -244,7 +244,7 @@ EXPORT_SYMBOL(rdma_port_get_link_layer);
 /* Protection domains */
 
 /**
- * ib_alloc_pd - Allocates an unused protection domain.
+ * __ib_alloc_pd - Allocates an unused protection domain.
  * @device: The device on which to allocate the protection domain.
  * @flags: protection domain flags
  * @caller: caller's build-time module name
@@ -1662,7 +1662,7 @@ static bool is_qp_type_connected(const struct ib_qp *qp)
 		qp->qp_type == IB_QPT_XRC_TGT);
 }
 
-/**
+/*
  * IB core internal function to perform QP attributes modification.
  */
 static int _ib_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr,
diff --git a/drivers/infiniband/sw/rdmavt/ah.c b/drivers/infiniband/sw/rdmavt/ah.c
index b938c4ffa99a..3c175bd4ad55 100644
--- a/drivers/infiniband/sw/rdmavt/ah.c
+++ b/drivers/infiniband/sw/rdmavt/ah.c
@@ -126,7 +126,7 @@ int rvt_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 }
 
 /**
- * rvt_destory_ah - Destory an address handle
+ * rvt_destroy_ah - Destory an address handle
  * @ibah: address handle
  * @destroy_flags: destroy address handle flags (see enum rdma_destroy_ah_flags)
  *
diff --git a/drivers/infiniband/sw/rdmavt/mcast.c b/drivers/infiniband/sw/rdmavt/mcast.c
index dd11c6fcd060..5233a63d99a6 100644
--- a/drivers/infiniband/sw/rdmavt/mcast.c
+++ b/drivers/infiniband/sw/rdmavt/mcast.c
@@ -54,7 +54,7 @@
 #include "mcast.h"
 
 /**
- * rvt_driver_mcast - init resources for multicast
+ * rvt_driver_mcast_init - init resources for multicast
  * @rdi: rvt dev struct
  *
  * This is per device that registers with rdmavt
@@ -69,7 +69,7 @@ void rvt_driver_mcast_init(struct rvt_dev_info *rdi)
 }
 
 /**
- * mcast_qp_alloc - alloc a struct to link a QP to mcast GID struct
+ * rvt_mcast_qp_alloc - alloc a struct to link a QP to mcast GID struct
  * @qp: the QP to link
  */
 static struct rvt_mcast_qp *rvt_mcast_qp_alloc(struct rvt_qp *qp)
@@ -98,7 +98,7 @@ static void rvt_mcast_qp_free(struct rvt_mcast_qp *mqp)
 }
 
 /**
- * mcast_alloc - allocate the multicast GID structure
+ * rvt_mcast_alloc - allocate the multicast GID structure
  * @mgid: the multicast GID
  * @lid: the muilticast LID (host order)
  *
@@ -181,7 +181,7 @@ struct rvt_mcast *rvt_mcast_find(struct rvt_ibport *ibp, union ib_gid *mgid,
 EXPORT_SYMBOL(rvt_mcast_find);
 
 /**
- * mcast_add - insert mcast GID into table and attach QP struct
+ * rvt_mcast_add - insert mcast GID into table and attach QP struct
  * @mcast: the mcast GID table
  * @mqp: the QP to attach
  *
@@ -426,8 +426,8 @@ int rvt_detach_mcast(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
 }
 
 /**
- *rvt_mast_tree_empty - determine if any qps are attached to any mcast group
- *@rdi: rvt dev struct
+ * rvt_mcast_tree_empty - determine if any qps are attached to any mcast group
+ * @rdi: rvt dev struct
  *
  * Return: in use count
  */
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index ee48befc8978..a0cdde8a2335 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1823,7 +1823,7 @@ int rvt_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 }
 
 /**
- * rvt_post_receive - post a receive on a QP
+ * rvt_post_recv - post a receive on a QP
  * @ibqp: the QP to post the receive on
  * @wr: the WR to post
  * @bad_wr: the first bad WR is put here
@@ -2245,7 +2245,7 @@ int rvt_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 }
 
 /**
- * rvt_post_srq_receive - post a receive on a shared receive queue
+ * rvt_post_srq_recv - post a receive on a shared receive queue
  * @ibsrq: the SRQ to post the receive on
  * @wr: the list of work requests to post
  * @bad_wr: A pointer to the first WR to cause a problem is put here
@@ -2497,7 +2497,7 @@ int rvt_get_rwqe(struct rvt_qp *qp, bool wr_id_only)
 EXPORT_SYMBOL(rvt_get_rwqe);
 
 /**
- * qp_comm_est - handle trap with QP established
+ * rvt_comm_est - handle trap with QP established
  * @qp: the QP
  */
 void rvt_comm_est(struct rvt_qp *qp)
@@ -2943,7 +2943,7 @@ static enum ib_wc_status loopback_qp_drop(struct rvt_ibport *rvp,
 }
 
 /**
- * ruc_loopback - handle UC and RC loopback requests
+ * rvt_ruc_loopback - handle UC and RC loopback requests
  * @sqp: the sending QP
  *
  * This is called from rvt_do_send() to forward a WQE addressed to the same HFI
diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 3690e28cc7ea..84cebf937680 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -739,7 +739,7 @@ iscsi_iser_set_param(struct iscsi_cls_conn *cls_conn,
 }
 
 /**
- * iscsi_iser_set_param() - set class connection parameter
+ * iscsi_iser_conn_get_stats() - set class connection parameter
  * @cls_conn:    iscsi class connection
  * @stats:       iscsi stats to output
  *
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h b/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
index f64519872297..012fc27c5c93 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
@@ -437,7 +437,7 @@ struct opa_veswport_trap {
 } __packed;
 
 /**
- * struct opa_vnic_iface_macs_entry - single entry in the mac list
+ * struct opa_vnic_iface_mac_entry - single entry in the mac list
  * @mac_addr: MAC address
  */
 struct opa_vnic_iface_mac_entry {
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c
index 868b5aec1537..292c037aa239 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c
@@ -74,7 +74,7 @@ void opa_vnic_vema_report_event(struct opa_vnic_adapter *adapter, u8 event)
 }
 
 /**
- * opa_vnic_get_error_counters - get summary counters
+ * opa_vnic_get_summary_counters - get summary counters
  * @adapter: vnic port adapter
  * @cntrs: pointer to destination summary counters structure
  *
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index bdeb010efee6..76e66f630c17 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -347,7 +347,7 @@ struct srpt_nexus {
 };
 
 /**
- * struct srpt_port_attib - attributes for SRPT port
+ * struct srpt_port_attrib - attributes for SRPT port
  * @srp_max_rdma_size: Maximum size of SRP RDMA transfers for new connections.
  * @srp_max_rsp_size: Maximum size of SRP response messages in bytes.
  * @srp_sq_size: Shared receive queue (SRQ) size.
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9bf6c319a670..5837bf0ac451 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3430,6 +3430,17 @@ enum ib_pd_flags {
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
 
-- 
2.26.2

