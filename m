Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987C14C7832
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 19:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbiB1Smw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 13:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240840AbiB1Sm0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 13:42:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EEB3FBEB
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 10:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646073479; x=1677609479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FL+TaFuvtxipAg9IpDGtPQTCJCPtbQbs4lRfcn0mPQY=;
  b=Ayl8bFuJZHVFRO9OX/0DaPGZTnMZAxxD4nbTcR3UXV7wlZG76zNdxbLG
   xGY9faQMErU12SWuzKFtufuGqQGUlLzBiAsAbar+CCpm+hYf+KRxJZKw3
   WU2gMSdtxtKNJ6w/9Lh7EAWzv7lpinnQdDVOh13WfWBYsjjuhhDm2bMAC
   sji7mg5Q4fb8QD22/hzCJ68+9iIHHhAknjfDT+8KZYNUmINv0A9llPbB9
   H/95wahYus7f10qsMijf7EFesbYeZTAzU6xBUacTk7wpKM9B8UG223ZQF
   Qu62pwIN9DlbJ2DQKW0rI341cXHzJPk2AoRJu8EBUI+g8ke3EFsoFbgHF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251786622"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="251786622"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 10:37:58 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="550356153"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.255.34.246])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 10:37:57 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-next v1] RDMA/irdma: Add support for address handle re-use
Date:   Mon, 28 Feb 2022 12:36:50 -0600
Message-Id: <20220228183650.290-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

Address handles (AH) are a limited HW resource and some
user applications may create large numbers of identical AH's.
Avoid running out of AH's by reusing existing identical ones.

Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
v0->v1:
*Use a hash table instead of linear list for storing AH's
*Remove limit on number of cached AH's
*Remove check for RDMA_CREATE_AH_SLEEPABLE in create_user_ah

 drivers/infiniband/hw/irdma/main.c  |   2 +-
 drivers/infiniband/hw/irdma/main.h  |   2 +
 drivers/infiniband/hw/irdma/verbs.c | 217 ++++++++++++++++++++++++++----------
 drivers/infiniband/hw/irdma/verbs.h |   3 +
 4 files changed, 164 insertions(+), 60 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index babbe8a..07467eb 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -241,7 +241,7 @@ static void irdma_fill_device_info(struct irdma_device *iwdev, struct ice_pf *pf
 	rf->gen_ops.request_reset = irdma_request_reset;
 	rf->limits_sel = 7;
 	rf->iwdev = iwdev;
-
+	mutex_init(&iwdev->ah_tbl_lock);
 	iwdev->netdev = vsi->netdev;
 	iwdev->vsi_num = vsi->vsi_num;
 	iwdev->init_state = INITIAL_STATE;
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 94c41f8..8f8e5c0 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -331,6 +331,8 @@ struct irdma_device {
 	struct workqueue_struct *cleanup_wq;
 	struct irdma_sc_vsi vsi;
 	struct irdma_cm_core cm_core;
+	DECLARE_HASHTABLE(ah_hash_tbl, 8);
+	struct mutex ah_tbl_lock; /* protect AH hash table access */
 	u32 roce_cwnd;
 	u32 roce_ackcreds;
 	u32 vendor_id;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index ad57c53..00cef0d 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4074,17 +4074,47 @@ static int irdma_detach_mcast(struct ib_qp *ibqp, union ib_gid *ibgid, u16 lid)
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
@@ -4093,21 +4123,13 @@ static int irdma_create_ah(struct ib_ah *ibah,
 	struct irdma_device *iwdev = to_iwdev(ibah->pd->device);
 	struct irdma_pci_f *rf = iwdev->rf;
 	struct irdma_sc_ah *sc_ah;
-	u32 ah_id = 0;
 	struct irdma_ah_info *ah_info;
-	struct irdma_create_ah_resp uresp;
 	union irdma_sockaddr sgid_addr, dgid_addr;
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
@@ -4118,7 +4140,6 @@ static int irdma_create_ah(struct ib_ah *ibah,
 	ah->av.attrs = *ah_attr;
 	ah->av.net_type = rdma_gid_attr_network_type(sgid_attr);
 	ah_info = &sc_ah->ah_info;
-	ah_info->ah_idx = ah_id;
 	ah_info->pd_idx = pd->sc_pd.pd_id;
 	if (ah_attr->ah_flags & IB_AH_GRH) {
 		ah_info->flow_label = ah_attr->grh.flow_label;
@@ -4155,15 +4176,13 @@ static int irdma_create_ah(struct ib_ah *ibah,
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
 
 	if (ah_info->vlan_tag >= VLAN_N_VID && iwdev->dcb_vlan_mode)
 		ah_info->vlan_tag = 0;
@@ -4174,43 +4193,38 @@ static int irdma_create_ah(struct ib_ah *ibah,
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
-
-		do {
-			irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
-			mdelay(1);
-		} while (!sc_ah->ah_info.ah_valid && --cnt);
+	return 0;
+}
 
-		if (!cnt) {
-			ibdev_dbg(&iwdev->ibdev,
-				  "VERBS: CQP create AH timed out");
-			err = -ETIMEDOUT;
-			goto error;
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
+	u32 key = new_ah->sc_ah.ah_info.dest_ip_addr[0] ^
+		  new_ah->sc_ah.ah_info.dest_ip_addr[1] ^
+		  new_ah->sc_ah.ah_info.dest_ip_addr[2] ^
+		  new_ah->sc_ah.ah_info.dest_ip_addr[3];
+
+	hash_for_each_possible(iwdev->ah_hash_tbl, ah, list, key) {
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
@@ -4223,6 +4237,17 @@ static int irdma_destroy_ah(struct ib_ah *ibah, u32 ah_flags)
 	struct irdma_device *iwdev = to_iwdev(ibah->device);
 	struct irdma_ah *ah = to_iwah(ibah);
 
+	if ((ah_flags & RDMA_DESTROY_AH_SLEEPABLE) && ah->parent_ah) {
+		mutex_lock(&iwdev->ah_tbl_lock);
+		if (!refcount_dec_and_test(&ah->parent_ah->refcnt)) {
+			mutex_unlock(&iwdev->ah_tbl_lock);
+			return 0;
+		}
+		hash_del(&ah->parent_ah->list);
+		kfree(ah->parent_ah);
+		mutex_unlock(&iwdev->ah_tbl_lock);
+	}
+
 	irdma_ah_cqp_op(iwdev->rf, &ah->sc_ah, IRDMA_OP_AH_DESTROY,
 			false, NULL, ah);
 
@@ -4233,6 +4258,80 @@ static int irdma_destroy_ah(struct ib_ah *ibah, u32 ah_flags)
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
+	mutex_lock(&iwdev->ah_tbl_lock);
+	if (!irdma_ah_exists(iwdev, ah)) {
+		err = irdma_create_hw_ah(iwdev, ah, true);
+		if (err) {
+			mutex_unlock(&iwdev->ah_tbl_lock);
+			return err;
+		}
+		/* Add new AH to list */
+		parent_ah = kmemdup(ah, sizeof(*ah), GFP_KERNEL);
+		if (parent_ah) {
+			u32 key = parent_ah->sc_ah.ah_info.dest_ip_addr[0] ^
+				  parent_ah->sc_ah.ah_info.dest_ip_addr[1] ^
+				  parent_ah->sc_ah.ah_info.dest_ip_addr[2] ^
+				  parent_ah->sc_ah.ah_info.dest_ip_addr[3];
+
+			ah->parent_ah = parent_ah;
+			hash_add(iwdev->ah_hash_tbl, &parent_ah->list, key);
+			refcount_set(&parent_ah->refcnt, 1);
+		}
+	}
+	mutex_unlock(&iwdev->ah_tbl_lock);
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
@@ -4265,7 +4364,7 @@ static enum rdma_link_layer irdma_get_link_layer(struct ib_device *ibdev,
 static const struct ib_device_ops irdma_roce_dev_ops = {
 	.attach_mcast = irdma_attach_mcast,
 	.create_ah = irdma_create_ah,
-	.create_user_ah = irdma_create_ah,
+	.create_user_ah = irdma_create_user_ah,
 	.destroy_ah = irdma_destroy_ah,
 	.detach_mcast = irdma_detach_mcast,
 	.get_link_layer = irdma_get_link_layer,
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index 541105b..08ba24d 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -45,6 +45,9 @@ struct irdma_ah {
 	struct irdma_av av;
 	u8 sgid_index;
 	union ib_gid dgid;
+	struct hlist_node list;
+	refcount_t refcnt;
+	struct irdma_ah *parent_ah; /* AH from cached list */
 };
 
 struct irdma_hmc_pble {
-- 
1.8.3.1

