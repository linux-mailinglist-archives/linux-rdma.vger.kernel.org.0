Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AC6495374
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 18:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiATRl2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jan 2022 12:41:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:48442 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231996AbiATRl1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jan 2022 12:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642700487; x=1674236487;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YsVKLH2FBag1I/qYmO0sbTjt3Vtf0bt6Pn/B85Oj+kM=;
  b=YhA43drwo1umnjHFIgM6NxNNzZWlT88ktA4nZ3FQWuuIoA5bCxa+gyuJ
   KYZJ3zVA42ixxrD/8U7mfhO54AqVJix8BwYQQ6IQeTW0yLVULv4TC1tYB
   pyFnAUshms2aE0eqL6+wVYwNdYoTXXqzWqmStto+0jjqdQ9DXpgW4SNNx
   ZZJqdzLqGOFFX8+dHr/b1uKvuSUkxbplu4GeKVwftcxz0kPri4sBViM7c
   FCDxa+DMa1EEanvliHV7ETFT+Rq8O8xZ0gEpsTtVW98/H1sb6TOKsCQm2
   bFbyhKLUf+mDEuxMtTqcHDSWCBecpoMfYCOTwd08mddkI3C0flI6whAdk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="331761450"
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="331761450"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 09:41:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="532884285"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.255.37.214])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 09:41:11 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Ismail Mustafa <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-next] RDMA/irdma: Add support for address handle re-use
Date:   Thu, 20 Jan 2022 11:40:41 -0600
Message-Id: <20220120174041.1714-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ismail Mustafa <mustafa.ismail@intel.com>

Address handles (AH) are a limited HW resource and some
user applications may create large numbers of identical AH's.
Avoid running out of AH's by reusing existing identical ones.

Signed-off-by: Ismail Mustafa <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/main.c  |   3 +-
 drivers/infiniband/hw/irdma/main.h  |   3 +
 drivers/infiniband/hw/irdma/verbs.c | 216 ++++++++++++++++++++++++++----------
 drivers/infiniband/hw/irdma/verbs.h |   4 +
 4 files changed, 167 insertions(+), 59 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 51a4135..e9aaee8 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -235,7 +235,8 @@ static void irdma_fill_device_info(struct irdma_device *iwdev, struct ice_pf *pf
 	rf->gen_ops.request_reset = irdma_request_reset;
 	rf->limits_sel = 7;
 	rf->iwdev = iwdev;
-
+	INIT_LIST_HEAD(&iwdev->ah_list);
+	mutex_init(&iwdev->ah_list_lock);
 	iwdev->netdev = vsi->netdev;
 	iwdev->vsi_num = vsi->vsi_num;
 	iwdev->init_state = INITIAL_STATE;
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index cb218ca..54d5c80 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -332,6 +332,9 @@ struct irdma_device {
 	struct workqueue_struct *cleanup_wq;
 	struct irdma_sc_vsi vsi;
 	struct irdma_cm_core cm_core;
+	struct list_head ah_list;
+	struct mutex ah_list_lock; /* protect AH list access */
+	u32 ah_list_cnt;
 	u32 roce_cwnd;
 	u32 roce_ackcreds;
 	u32 vendor_id;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 460e757..5bc3815 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4132,17 +4132,47 @@ static int irdma_detach_mcast(struct ib_qp *ibqp, union ib_gid *ibgid, u16 lid)
 	return 0;
 }
 
-/**
- * irdma_create_ah - create address handle
- * @ibah: address handle
- * @attr: address handle attributes
- * @udata: User data
- *
- * returns 0 on success, error otherwise
- */
-static int irdma_create_ah(struct ib_ah *ibah,
-			   struct rdma_ah_init_attr *attr,
-			   struct ib_udata *udata)
+static int irdma_create_hw_ah(struct irdma_device *iwdev, struct irdma_ah *ah, bool sleep)
+{
+	struct irdma_pci_f *rf = iwdev->rf;
+	int err;
+
+	err = irdma_alloc_rsrc(rf, rf->allocated_ahs, rf->max_ah, &ah->sc_ah.ah_info.ah_idx,
+			       &rf->next_ah);
+	if (err)
+		return err;
+
+	err = irdma_ah_cqp_op(rf, &ah->sc_ah, IRDMA_OP_AH_CREATE, sleep,
+			      irdma_gsi_ud_qp_ah_cb, &ah->sc_ah);
+
+	if (err) {
+		ibdev_dbg(&iwdev->ibdev, "VERBS: CQP-OP Create AH fail");
+		goto err_ah_create;
+	}
+
+	if (!sleep) {
+		int cnt = CQP_COMPL_WAIT_TIME_MS * CQP_TIMEOUT_THRESHOLD;
+
+		do {
+			irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
+			mdelay(1);
+		} while (!ah->sc_ah.ah_info.ah_valid && --cnt);
+
+		if (!cnt) {
+			ibdev_dbg(&iwdev->ibdev, "VERBS: CQP create AH timed out");
+			err = -ETIMEDOUT;
+			goto err_ah_create;
+		}
+	}
+	return 0;
+
+err_ah_create:
+	irdma_free_rsrc(iwdev->rf, iwdev->rf->allocated_ahs, ah->sc_ah.ah_info.ah_idx);
+
+	return err;
+}
+
+static int irdma_setup_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *attr)
 {
 	struct irdma_pd *pd = to_iwpd(ibah->pd);
 	struct irdma_ah *ah = container_of(ibah, struct irdma_ah, ibah);
@@ -4151,9 +4181,7 @@ static int irdma_create_ah(struct ib_ah *ibah,
 	struct irdma_device *iwdev = to_iwdev(ibah->pd->device);
 	struct irdma_pci_f *rf = iwdev->rf;
 	struct irdma_sc_ah *sc_ah;
-	u32 ah_id = 0;
 	struct irdma_ah_info *ah_info;
-	struct irdma_create_ah_resp uresp;
 	union {
 		struct sockaddr saddr;
 		struct sockaddr_in saddr_in;
@@ -4162,14 +4190,8 @@ static int irdma_create_ah(struct ib_ah *ibah,
 	int err;
 	u8 dmac[ETH_ALEN];
 
-	err = irdma_alloc_rsrc(rf, rf->allocated_ahs, rf->max_ah, &ah_id,
-			       &rf->next_ah);
-	if (err)
-		return err;
-
 	ah->pd = pd;
 	sc_ah = &ah->sc_ah;
-	sc_ah->ah_info.ah_idx = ah_id;
 	sc_ah->ah_info.vsi = &iwdev->vsi;
 	irdma_sc_init_ah(&rf->sc_dev, sc_ah);
 	ah->sgid_index = ah_attr->grh.sgid_index;
@@ -4182,7 +4204,6 @@ static int irdma_create_ah(struct ib_ah *ibah,
 	ah->av.sgid_addr.saddr = sgid_addr.saddr;
 	ah->av.dgid_addr.saddr = dgid_addr.saddr;
 	ah_info = &sc_ah->ah_info;
-	ah_info->ah_idx = ah_id;
 	ah_info->pd_idx = pd->sc_pd.pd_id;
 	if (ah_attr->ah_flags & IB_AH_GRH) {
 		ah_info->flow_label = ah_attr->grh.flow_label;
@@ -4219,15 +4240,13 @@ static int irdma_create_ah(struct ib_ah *ibah,
 	err = rdma_read_gid_l2_fields(sgid_attr, &ah_info->vlan_tag,
 				      ah_info->mac_addr);
 	if (err)
-		goto error;
+		return err;
 
 	ah_info->dst_arpindex = irdma_add_arp(iwdev->rf, ah_info->dest_ip_addr,
 					      ah_info->ipv4_valid, dmac);
 
-	if (ah_info->dst_arpindex == -1) {
-		err = -EINVAL;
-		goto error;
-	}
+	if (ah_info->dst_arpindex == -1)
+		return -EINVAL;
 
 	if (ah_info->vlan_tag >= VLAN_N_VID && iwdev->dcb)
 		ah_info->vlan_tag = 0;
@@ -4238,43 +4257,34 @@ static int irdma_create_ah(struct ib_ah *ibah,
 			rt_tos2priority(ah_info->tc_tos) << VLAN_PRIO_SHIFT;
 	}
 
-	err = irdma_ah_cqp_op(iwdev->rf, sc_ah, IRDMA_OP_AH_CREATE,
-			      attr->flags & RDMA_CREATE_AH_SLEEPABLE,
-			      irdma_gsi_ud_qp_ah_cb, sc_ah);
-
-	if (err) {
-		ibdev_dbg(&iwdev->ibdev,
-			  "VERBS: CQP-OP Create AH fail");
-		goto error;
-	}
-
-	if (!(attr->flags & RDMA_CREATE_AH_SLEEPABLE)) {
-		int cnt = CQP_COMPL_WAIT_TIME_MS * CQP_TIMEOUT_THRESHOLD;
+	return 0;
+}
 
-		do {
-			irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
-			mdelay(1);
-		} while (!sc_ah->ah_info.ah_valid && --cnt);
+/**
+ * irdma_ah_exists - Check for existing identical AH
+ * @iwdev: irdma device
+ * @new_ah: AH to check for
+ *
+ * returns true if AH is found, false if not found.
+ */
+static bool irdma_ah_exists(struct irdma_device *iwdev,
+			    struct irdma_ah *new_ah)
+{
+	struct irdma_ah *ah;
 
-		if (!cnt) {
-			ibdev_dbg(&iwdev->ibdev,
-				  "VERBS: CQP create AH timed out");
-			err = -ETIMEDOUT;
-			goto error;
+	list_for_each_entry (ah, &iwdev->ah_list, list) {
+		/* Set ah_valid and ah_id the same so memcmp can work */
+		new_ah->sc_ah.ah_info.ah_idx = ah->sc_ah.ah_info.ah_idx;
+		new_ah->sc_ah.ah_info.ah_valid = ah->sc_ah.ah_info.ah_valid;
+		if (!memcmp(&ah->sc_ah.ah_info, &new_ah->sc_ah.ah_info,
+			    sizeof(ah->sc_ah.ah_info))) {
+			refcount_inc(&ah->refcnt);
+			new_ah->parent_ah = ah;
+			return true;
 		}
 	}
 
-	if (udata) {
-		uresp.ah_id = ah->sc_ah.ah_info.ah_idx;
-		err = ib_copy_to_udata(udata, &uresp,
-				       min(sizeof(uresp), udata->outlen));
-	}
-	return 0;
-
-error:
-	irdma_free_rsrc(iwdev->rf, iwdev->rf->allocated_ahs, ah_id);
-
-	return err;
+	return false;
 }
 
 /**
@@ -4287,6 +4297,18 @@ static int irdma_destroy_ah(struct ib_ah *ibah, u32 ah_flags)
 	struct irdma_device *iwdev = to_iwdev(ibah->device);
 	struct irdma_ah *ah = to_iwah(ibah);
 
+	if ((ah_flags & RDMA_DESTROY_AH_SLEEPABLE) && ah->parent_ah) {
+		mutex_lock(&iwdev->ah_list_lock);
+		if (!refcount_dec_and_test(&ah->parent_ah->refcnt)) {
+			mutex_unlock(&iwdev->ah_list_lock);
+			return 0;
+		}
+		list_del(&ah->parent_ah->list);
+		kfree(ah->parent_ah);
+		iwdev->ah_list_cnt--;
+		mutex_unlock(&iwdev->ah_list_lock);
+	}
+
 	irdma_ah_cqp_op(iwdev->rf, &ah->sc_ah, IRDMA_OP_AH_DESTROY,
 			false, NULL, ah);
 
@@ -4297,6 +4319,84 @@ static int irdma_destroy_ah(struct ib_ah *ibah, u32 ah_flags)
 }
 
 /**
+ * irdma_create_user_ah - create user address handle
+ * @ibah: address handle
+ * @attr: address handle attributes
+ * @udata: User data
+ *
+ * returns 0 on success, error otherwise
+ */
+static int irdma_create_user_ah(struct ib_ah *ibah,
+				struct rdma_ah_init_attr *attr,
+				struct ib_udata *udata)
+{
+	struct irdma_ah *ah = container_of(ibah, struct irdma_ah, ibah);
+	struct irdma_device *iwdev = to_iwdev(ibah->pd->device);
+	struct irdma_create_ah_resp uresp;
+	struct irdma_ah *parent_ah;
+	int err;
+
+	err = irdma_setup_ah(ibah, attr);
+	if (err)
+		return err;
+	if (attr->flags & RDMA_CREATE_AH_SLEEPABLE) {
+		mutex_lock(&iwdev->ah_list_lock);
+		if (!irdma_ah_exists(iwdev, ah)) {
+			err = irdma_create_hw_ah(iwdev, ah, true);
+			if (err) {
+				mutex_unlock(&iwdev->ah_list_lock);
+				return err;
+			}
+			/* Add new AH to list */
+			if (iwdev->ah_list_cnt < IRDMA_MAX_AH_LIST_SZ) {
+				parent_ah = kmemdup(ah, sizeof(*ah), GFP_KERNEL);
+				if (parent_ah) {
+					ah->parent_ah = parent_ah;
+					list_add(&parent_ah->list, &iwdev->ah_list);
+					iwdev->ah_list_cnt++;
+					refcount_set(&parent_ah->refcnt, 1);
+				}
+			}
+		}
+		mutex_unlock(&iwdev->ah_list_lock);
+	} else {
+		err = irdma_create_hw_ah(iwdev, ah, false);
+		if (err)
+			return err;
+	}
+
+	uresp.ah_id = ah->sc_ah.ah_info.ah_idx;
+	err = ib_copy_to_udata(udata, &uresp, min(sizeof(uresp), udata->outlen));
+	if (err)
+		irdma_destroy_ah(ibah, attr->flags);
+
+	return err;
+}
+
+/**
+ * irdma_create_ah - create address handle
+ * @ibah: address handle
+ * @attr: address handle attributes
+ * @udata: NULL
+ *
+ * returns 0 on success, error otherwise
+ */
+static int irdma_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *attr,
+			   struct ib_udata *udata)
+{
+	struct irdma_ah *ah = container_of(ibah, struct irdma_ah, ibah);
+	struct irdma_device *iwdev = to_iwdev(ibah->pd->device);
+	int err;
+
+	err = irdma_setup_ah(ibah, attr);
+	if (err)
+		return err;
+	err = irdma_create_hw_ah(iwdev, ah, attr->flags & RDMA_CREATE_AH_SLEEPABLE);
+
+	return err;
+}
+
+/**
  * irdma_query_ah - Query address handle
  * @ibah: pointer to address handle
  * @ah_attr: address handle attributes
@@ -4329,7 +4429,7 @@ static enum rdma_link_layer irdma_get_link_layer(struct ib_device *ibdev,
 static const struct ib_device_ops irdma_roce_dev_ops = {
 	.attach_mcast = irdma_attach_mcast,
 	.create_ah = irdma_create_ah,
-	.create_user_ah = irdma_create_ah,
+	.create_user_ah = irdma_create_user_ah,
 	.destroy_ah = irdma_destroy_ah,
 	.detach_mcast = irdma_detach_mcast,
 	.get_link_layer = irdma_get_link_layer,
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index d0fdef8..4640bef 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -7,6 +7,7 @@
 
 #define IRDMA_PKEY_TBL_SZ		1
 #define IRDMA_DEFAULT_PKEY		0xFFFF
+#define IRDMA_MAX_AH_LIST_SZ		0x20000
 
 struct irdma_ucontext {
 	struct ib_ucontext ibucontext;
@@ -43,6 +44,9 @@ struct irdma_ah {
 	struct irdma_av av;
 	u8 sgid_index;
 	union ib_gid dgid;
+	struct list_head list;
+	refcount_t refcnt;
+	struct irdma_ah *parent_ah; /* AH from cached list */
 };
 
 struct irdma_hmc_pble {
-- 
1.8.3.1

