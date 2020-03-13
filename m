Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 858AF185153
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 22:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCMVoT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 17:44:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:51905 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgCMVoT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Mar 2020 17:44:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 14:44:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,550,1574150400"; 
   d="scan'208";a="278377484"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.254.43.202])
  by fmsmga002.fm.intel.com with ESMTP; 13 Mar 2020 14:44:17 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        "Sindhu, Devale" <sindhu.devale@intel.com>,
        Jarod Wilson <jarod@redhat.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v1 rdma-next] i40iw: Report correct firmware version
Date:   Fri, 13 Mar 2020 16:44:06 -0500
Message-Id: <20200313214406.2159-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: "Sindhu, Devale" <sindhu.devale@intel.com>

The driver uses a hard-coded value for FW version and
reports an inconsistent FW version between ibv_devinfo
and /sys/class/infiniband/i40iw/fw_ver.
Retrieve the FW version via a Control QP (CQP) operation
and report it consistently across sysfs and query device.

Fixes: d37498417947 ("i40iw: add files for iwarp interface")
Reported-by: Jarod Wilson <jarod@redhat.com>
Signed-off-by: Sindhu, Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
v0-->v1:
-Remove implicit casts
-Use static inline function for computing FW version instead of macros
---
 drivers/infiniband/hw/i40iw/i40iw.h        | 22 ++++++-
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c   | 99 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/i40iw/i40iw_d.h      | 26 +++++++-
 drivers/infiniband/hw/i40iw/i40iw_main.c   |  6 ++
 drivers/infiniband/hw/i40iw/i40iw_p.h      |  1 +
 drivers/infiniband/hw/i40iw/i40iw_status.h |  3 +-
 drivers/infiniband/hw/i40iw/i40iw_type.h   | 12 ++++
 drivers/infiniband/hw/i40iw/i40iw_verbs.c  | 10 +--
 8 files changed, 170 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw.h b/drivers/infiniband/hw/i40iw/i40iw.h
index 8feec35..ca0ed55 100644
--- a/drivers/infiniband/hw/i40iw/i40iw.h
+++ b/drivers/infiniband/hw/i40iw/i40iw.h
@@ -67,7 +67,7 @@
 #include "i40iw_user.h"
 #include "i40iw_puda.h"
 
-#define I40IW_FW_VERSION  2
+#define I40IW_FW_VER_DEFAULT  2
 #define I40IW_HW_VERSION  2
 
 #define I40IW_ARP_ADD     1
@@ -326,6 +326,26 @@ struct i40iw_handler {
 };
 
 /**
+ * i40iw_fw_major_ver - get firmware major version
+ * @dev: iwarp device
+ **/
+static inline u64 i40iw_fw_major_ver(struct i40iw_sc_dev *dev)
+{
+	return RS_64(dev->feature_info[I40IW_FEATURE_FW_INFO],
+		     I40IW_FW_VER_MAJOR);
+}
+
+/**
+ * i40iw_fw_minor_ver - get firmware minor version
+ * @dev: iwarp device
+ **/
+static inline u64 i40iw_fw_minor_ver(struct i40iw_sc_dev *dev)
+{
+	return RS_64(dev->feature_info[I40IW_FEATURE_FW_INFO],
+		     I40IW_FW_VER_MINOR);
+}
+
+/**
  * to_iwdev - get device
  * @ibdev: ib device
  **/
diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
index 4d841a3..bc941a4 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -1022,6 +1022,97 @@ static enum i40iw_status_code i40iw_sc_commit_fpm_values(
 }
 
 /**
+ * i40iw_sc_query_rdma_features_done - poll cqp for query features done
+ * @cqp: struct for cqp hw
+ */
+static enum i40iw_status_code i40iw_sc_query_rdma_features_done(struct i40iw_sc_cqp *cqp)
+{
+	return i40iw_sc_poll_for_cqp_op_done(cqp,
+					     I40IW_CQP_OP_QUERY_RDMA_FEATURES,
+					     NULL);
+}
+
+/**
+ * i40iw_sc_query_rdma_features - query rdma features
+ * @cqp: struct for cqp hw
+ * @feat_mem: holds PA for HW to use
+ * @scratch: u64 saved to be used during cqp completion
+ */
+static enum i40iw_status_code i40iw_sc_query_rdma_features(struct i40iw_sc_cqp *cqp,
+							   struct i40iw_dma_mem *feat_mem,
+							   u64 scratch)
+{
+	u64 *wqe;
+	u64 header;
+
+	wqe = i40iw_sc_cqp_get_next_send_wqe(cqp, scratch);
+	if (wqe)
+		return I40IW_ERR_RING_FULL;
+
+	set_64bit_val(wqe, 32, feat_mem->pa);
+
+	header = LS_64(I40IW_CQP_OP_QUERY_RDMA_FEATURES, I40IW_CQPSQ_OPCODE) |
+		 LS_64(cqp->polarity, I40IW_CQPSQ_WQEVALID) |
+		 feat_mem->size;
+
+	i40iw_insert_wqe_hdr(wqe, header);
+
+	i40iw_debug_buf(cqp->dev, I40IW_DEBUG_WQE, "QUERY RDMA FEATURES WQE",
+			wqe, I40IW_CQP_WQE_SIZE * 8);
+
+	i40iw_sc_cqp_post_sq(cqp);
+
+	return 0;
+}
+
+/**
+ * i40iw_get_rdma_features - get RDMA features
+ * @dev - sc device struct
+ */
+enum i40iw_status_code i40iw_get_rdma_features(struct i40iw_sc_dev *dev)
+{
+	enum i40iw_status_code ret_code;
+	struct i40iw_dma_mem feat_buf;
+	u64 temp;
+	u16 byte_idx, feat_type, feat_cnt;
+
+	ret_code = i40iw_allocate_dma_mem(dev->hw,
+					  &feat_buf,
+					  I40IW_FEATURE_BUF_SIZE,
+					  I40IW_FEATURE_BUF_ALIGNMENT);
+
+	if (ret_code)
+		return I40IW_ERR_NO_MEMORY;
+
+	ret_code = i40iw_sc_query_rdma_features(dev->cqp, &feat_buf, 0);
+	if (!ret_code)
+		ret_code = i40iw_sc_query_rdma_features_done(dev->cqp);
+
+	if (ret_code)
+		goto exit;
+
+	get_64bit_val(feat_buf.va, 0, &temp);
+	feat_cnt = RS_64(temp, I40IW_FEATURE_CNT);
+	if (feat_cnt < I40IW_MAX_FEATURES) {
+		ret_code = I40IW_ERR_INVALID_FEAT_CNT;
+		goto exit;
+	} else if (feat_cnt > I40IW_MAX_FEATURES) {
+		i40iw_debug(dev, I40IW_DEBUG_CQP,
+			    "features buf size insufficient\n");
+	}
+
+	for (byte_idx = 0, feat_type = 0; feat_type < I40IW_MAX_FEATURES;
+	     feat_type++, byte_idx += 8) {
+		get_64bit_val((u64 *)feat_buf.va, byte_idx, &temp);
+		dev->feature_info[feat_type] = RS_64(temp, I40IW_FEATURE_INFO);
+	}
+exit:
+	i40iw_free_dma_mem(dev->hw, &feat_buf);
+
+	return ret_code;
+}
+
+/**
  * i40iw_sc_query_fpm_values_done - poll for cqp wqe completion for query fpm
  * @cqp: struct for cqp hw
  */
@@ -4265,6 +4356,14 @@ static enum i40iw_status_code i40iw_exec_cqp_cmd(struct i40iw_sc_dev *dev,
 				true,
 				I40IW_CQP_WAIT_EVENT);
 		break;
+	case OP_QUERY_RDMA_FEATURES:
+		values_mem.pa = pcmdinfo->in.u.query_rdma_features.cap_pa;
+		values_mem.va = pcmdinfo->in.u.query_rdma_features.cap_va;
+		status = i40iw_sc_query_rdma_features(
+				pcmdinfo->in.u.query_rdma_features.cqp,
+				&values_mem,
+				pcmdinfo->in.u.query_rdma_features.scratch);
+		break;
 	default:
 		status = I40IW_NOT_SUPPORTED;
 		break;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_d.h b/drivers/infiniband/hw/i40iw/i40iw_d.h
index 6ddaeec..e8367d6 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_d.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_d.h
@@ -403,7 +403,7 @@
 #define I40IW_CQP_OP_MANAGE_ARP                 0x0f
 #define I40IW_CQP_OP_MANAGE_VF_PBLE_BP          0x10
 #define I40IW_CQP_OP_MANAGE_PUSH_PAGES          0x11
-#define I40IW_CQP_OP_MANAGE_PE_TEAM             0x12
+#define I40IW_CQP_OP_QUERY_RDMA_FEATURES	0x12
 #define I40IW_CQP_OP_UPLOAD_CONTEXT             0x13
 #define I40IW_CQP_OP_ALLOCATE_LOC_MAC_IP_TABLE_ENTRY 0x14
 #define I40IW_CQP_OP_MANAGE_HMC_PM_FUNC_TABLE   0x15
@@ -431,6 +431,24 @@
 #define I40IW_CQP_OP_SHMC_PAGES_ALLOCATED       0x2b
 #define I40IW_CQP_OP_SET_HMC_RESOURCE_PROFILE   0x2d
 
+#define I40IW_FEATURE_BUF_SIZE                  (8 * I40IW_MAX_FEATURES)
+
+#define I40IW_FW_VER_MINOR_SHIFT        0
+#define I40IW_FW_VER_MINOR_MASK         \
+	(0xffffULL << I40IW_FW_VER_MINOR_SHIFT)
+
+#define I40IW_FW_VER_MAJOR_SHIFT        16
+#define I40IW_FW_VER_MAJOR_MASK	        \
+	(0xffffULL << I40IW_FW_VER_MAJOR_SHIFT)
+
+#define I40IW_FEATURE_INFO_SHIFT        0
+#define I40IW_FEATURE_INFO_MASK         \
+	(0xffffULL << I40IW_FEATURE_INFO_SHIFT)
+
+#define I40IW_FEATURE_CNT_SHIFT         32
+#define I40IW_FEATURE_CNT_MASK          \
+	(0xffffULL << I40IW_FEATURE_CNT_SHIFT)
+
 #define I40IW_UDA_QPSQ_NEXT_HEADER_SHIFT 16
 #define I40IW_UDA_QPSQ_NEXT_HEADER_MASK ((u64)0xff << I40IW_UDA_QPSQ_NEXT_HEADER_SHIFT)
 
@@ -1529,7 +1547,8 @@ enum i40iw_alignment {
 	I40IW_AEQ_ALIGNMENT =		0x100,
 	I40IW_CEQ_ALIGNMENT =		0x100,
 	I40IW_CQ0_ALIGNMENT =		0x100,
-	I40IW_SD_BUF_ALIGNMENT =	0x80
+	I40IW_SD_BUF_ALIGNMENT =	0x80,
+	I40IW_FEATURE_BUF_ALIGNMENT =	0x8
 };
 
 #define I40IW_WQE_SIZE_64	64
@@ -1732,6 +1751,7 @@ enum i40iw_alignment {
 #define OP_REQUESTED_COMMANDS                   31
 #define OP_COMPLETED_COMMANDS                   32
 #define OP_GEN_AE                               33
-#define OP_SIZE_CQP_STAT_ARRAY                  34
+#define OP_QUERY_RDMA_FEATURES                  34
+#define OP_SIZE_CQP_STAT_ARRAY			35
 
 #endif
diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index 84e1b52..9e8bc4c 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -1683,6 +1683,12 @@ static int i40iw_open(struct i40e_info *ldev, struct i40e_client *client)
 		status = i40iw_setup_ceqs(iwdev, ldev);
 		if (status)
 			break;
+
+		status = i40iw_get_rdma_features(dev);
+		if (status)
+			dev->feature_info[I40IW_FEATURE_FW_INFO] =
+						I40IW_FW_VER_DEFAULT;
+
 		iwdev->init_state = CEQ_CREATED;
 		status = i40iw_initialize_hw_resources(iwdev);
 		if (status)
diff --git a/drivers/infiniband/hw/i40iw/i40iw_p.h b/drivers/infiniband/hw/i40iw/i40iw_p.h
index 11d3a2a..4c42956 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_p.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_p.h
@@ -105,6 +105,7 @@ enum i40iw_status_code i40iw_sc_static_hmc_pages_allocated(struct i40iw_sc_cqp *
 							   bool poll_registers);
 
 enum i40iw_status_code i40iw_config_fpm_values(struct i40iw_sc_dev *dev, u32 qp_count);
+enum i40iw_status_code i40iw_get_rdma_features(struct i40iw_sc_dev *dev);
 
 void free_sd_mem(struct i40iw_sc_dev *dev);
 
diff --git a/drivers/infiniband/hw/i40iw/i40iw_status.h b/drivers/infiniband/hw/i40iw/i40iw_status.h
index f7013f1..d1c5855 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_status.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_status.h
@@ -95,7 +95,8 @@ enum i40iw_status_code {
 	I40IW_ERR_INVALID_MAC_ADDR = -65,
 	I40IW_ERR_BAD_STAG      = -66,
 	I40IW_ERR_CQ_COMPL_ERROR = -67,
-	I40IW_ERR_QUEUE_DESTROYED = -68
+	I40IW_ERR_QUEUE_DESTROYED = -68,
+	I40IW_ERR_INVALID_FEAT_CNT = -69
 
 };
 #endif
diff --git a/drivers/infiniband/hw/i40iw/i40iw_type.h b/drivers/infiniband/hw/i40iw/i40iw_type.h
index adc8d2e..54c323c 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_type.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_type.h
@@ -234,6 +234,11 @@ enum i40iw_hw_stats_index_64b {
 	I40IW_HW_STAT_INDEX_MAX_64
 };
 
+enum i40iw_feature_type {
+	I40IW_FEATURE_FW_INFO = 0,
+	I40IW_MAX_FEATURES
+};
+
 struct i40iw_dev_hw_stats_offsets {
 	u32 stats_offset_32[I40IW_HW_STAT_INDEX_MAX_32];
 	u32 stats_offset_64[I40IW_HW_STAT_INDEX_MAX_64];
@@ -501,6 +506,7 @@ struct i40iw_sc_dev {
 	const struct i40iw_vf_cqp_ops *iw_vf_cqp_ops;
 
 	struct i40iw_hmc_fpm_misc hmc_fpm_misc;
+	u64 feature_info[I40IW_MAX_FEATURES];
 	u32 debug_mask;
 	u8 hmc_fn_id;
 	bool is_pf;
@@ -1340,6 +1346,12 @@ struct cqp_info {
 			struct i40iw_sc_qp *qp;
 			u64 scratch;
 		} suspend_resume;
+		struct {
+			struct i40iw_sc_cqp *cqp;
+			void *cap_va;
+			u64 cap_pa;
+			u64 scratch;
+		} query_rdma_features;
 	} u;
 };
 
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index fa12929..1b6fb13 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -64,7 +64,8 @@ static int i40iw_query_device(struct ib_device *ibdev,
 		return -EINVAL;
 	memset(props, 0, sizeof(*props));
 	ether_addr_copy((u8 *)&props->sys_image_guid, iwdev->netdev->dev_addr);
-	props->fw_ver = I40IW_FW_VERSION;
+	props->fw_ver = i40iw_fw_major_ver(&iwdev->sc_dev) << 32 |
+			i40iw_fw_minor_ver(&iwdev->sc_dev);
 	props->device_cap_flags = iwdev->device_cap_flags;
 	props->vendor_id = iwdev->ldev->pcidev->vendor;
 	props->vendor_part_id = iwdev->ldev->pcidev->device;
@@ -2534,10 +2535,11 @@ static int i40iw_port_immutable(struct ib_device *ibdev, u8 port_num,
 
 static void i40iw_get_dev_fw_str(struct ib_device *dev, char *str)
 {
-	u32 firmware_version = I40IW_FW_VERSION;
+	struct i40iw_device *iwdev = to_iwdev(dev);
 
-	snprintf(str, IB_FW_VERSION_NAME_MAX, "%u.%u", firmware_version,
-		 (firmware_version & 0x000000ff));
+	snprintf(str, IB_FW_VERSION_NAME_MAX, "%llu.%llu",
+		 i40iw_fw_major_ver(&iwdev->sc_dev),
+		 i40iw_fw_minor_ver(&iwdev->sc_dev));
 }
 
 /**
-- 
1.8.3.1

