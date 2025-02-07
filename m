Return-Path: <linux-rdma+bounces-7531-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047E2A2CD0F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 20:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E24D3ABA4C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1938C19DF40;
	Fri,  7 Feb 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1nBIgGd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092D819D07E;
	Fri,  7 Feb 2025 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957826; cv=none; b=hDPV/CaK9BNuGfyqnuPAvoMNodjEHm1fnCbsYUzNM3gcFAC8Iu1W98515XgR7aFwbTHJ8VLta/E/HPzd/nBFRvJTm2kl7fBcfqt9K7jNlWaDxBOl5OgAWd0EzSNEAO5wdXyCcXD3Vvo7UoLKlErKOJnnkzcFBxPPxEaTstRS1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957826; c=relaxed/simple;
	bh=3aQClty/twmsdN4PzQ2eJXV0YBLtACad/Qo3LB0LQXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bsa58xbuDPvmCWnStr5MgM1gevfe7O7Qrb9dk98gBQN+FdAy7L3ng7skgM2fBBreCcoV02BbXQgs1vn4SrG2AnoBG7snKt1VYU8txWwQX6s6aQyrPu6cKhNovPXhDEd/PcX3/tcuJNpmdGROxybhyq67VJBBr+WOXxsOkIz4cbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1nBIgGd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738957825; x=1770493825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3aQClty/twmsdN4PzQ2eJXV0YBLtACad/Qo3LB0LQXE=;
  b=K1nBIgGdpJ+OWTG59vq5Gen0tqakgHHuvQuPrU5M0VfCCe176F4uucUJ
   7GK1pEm7UtoSOl9Z01T7jt9I6rgkqPwSCHLhyZJDlGStLlXDtTiirc6u+
   WOvO6EtCpKQRds9UapYJ3pjFFjuvDpRQMN3lGcQCXsQ+a1SqDyZD76qKz
   gYMGNc3Vd3CG68M7PyygNcrTDsWssNVy1mkIvaiY/LOsK0ENOf4K/kbv2
   NeRylonRBG6joQsADfPSo2I9TY1SbngGsBWY/76hrN7YivVGSqjLj15dQ
   mIf0Qboc/0gjbQR7mrxSlM/PHYx1rhhDSBUxfzrkUBDW5wuwQKEmg97dv
   w==;
X-CSE-ConnectionGUID: ClcUZUvNT4Go/xfBZdLlHQ==
X-CSE-MsgGUID: jTK+vdGbSH+5DvPZYZlSiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42451751"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="42451751"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:23 -0800
X-CSE-ConnectionGUID: RE1Rm8KHTHa6NkvWgANW9g==
X-CSE-MsgGUID: M4gPXyW9RrajCIcu675P5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112238115"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.81.134])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:21 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [iwl-next v3 02/24] idpf: use reserved RDMA vectors from control plane
Date: Fri,  7 Feb 2025 13:49:09 -0600
Message-Id: <20250207194931.1569-3-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
References: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

Fetch the number of reserved RDMA vectors from the control plane.
Adjust the number of reserved LAN vectors if necessary. Adjust the
minimum number of vectors the OS should reserve to include RDMA; and
fail if the OS cannot reserve enough vectors for the minimum number of
LAN and RDMA vectors required. Create a separate msix table for the
reserved RDMA vectors, which will just get handed off to the RDMA core
device to do with what it will.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h      | 28 +++++++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c  | 74 +++++++++++++++++----
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  1 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h |  5 +-
 4 files changed, 92 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 66544faab710..8ef7120e6717 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -489,10 +489,11 @@ struct idpf_vc_xn_manager;
  * @flags: See enum idpf_flags
  * @reset_reg: See struct idpf_reset_reg
  * @hw: Device access data
- * @num_req_msix: Requested number of MSIX vectors
  * @num_avail_msix: Available number of MSIX vectors
  * @num_msix_entries: Number of entries in MSIX table
  * @msix_entries: MSIX table
+ * @num_rdma_msix_entries: Available number of MSIX vectors for RDMA
+ * @rdma_msix_entries: RDMA MSIX table
  * @req_vec_chunks: Requested vector chunk data
  * @mb_vector: Mailbox vector data
  * @vector_stack: Stack to store the msix vector indexes
@@ -542,10 +543,11 @@ struct idpf_adapter {
 	DECLARE_BITMAP(flags, IDPF_FLAGS_NBITS);
 	struct idpf_reset_reg reset_reg;
 	struct idpf_hw hw;
-	u16 num_req_msix;
 	u16 num_avail_msix;
 	u16 num_msix_entries;
 	struct msix_entry *msix_entries;
+	u16 num_rdma_msix_entries;
+	struct msix_entry *rdma_msix_entries;
 	struct virtchnl2_alloc_vectors *req_vec_chunks;
 	struct idpf_q_vector mb_vector;
 	struct idpf_vector_lifo vector_stack;
@@ -609,6 +611,17 @@ static inline int idpf_is_queue_model_split(u16 q_model)
 bool idpf_is_capability_ena(struct idpf_adapter *adapter, bool all,
 			    enum idpf_cap_field field, u64 flag);
 
+/**
+ * idpf_is_rdma_cap_ena - Determine if RDMA is supported
+ * @adapter: private data struct
+ *
+ * Return: true if RDMA capability is enabled, false otherwise
+ */
+static inline bool idpf_is_rdma_cap_ena(struct idpf_adapter *adapter)
+{
+	return idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_RDMA);
+}
+
 #define IDPF_CAP_RSS (\
 	VIRTCHNL2_CAP_RSS_IPV4_TCP	|\
 	VIRTCHNL2_CAP_RSS_IPV4_TCP	|\
@@ -663,6 +676,17 @@ static inline u16 idpf_get_reserved_vecs(struct idpf_adapter *adapter)
 	return le16_to_cpu(adapter->caps.num_allocated_vectors);
 }
 
+/**
+ * idpf_get_reserved_rdma_vecs - Get reserved RDMA vectors
+ * @adapter: private data struct
+ *
+ * Return: number of vectors reserved for RDMA
+ */
+static inline u16 idpf_get_reserved_rdma_vecs(struct idpf_adapter *adapter)
+{
+	return le16_to_cpu(adapter->caps.num_rdma_allocated_vectors);
+}
+
 /**
  * idpf_get_default_vports - Get default number of vports
  * @adapter: private data struct
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index b4fbb99bfad2..1330be825cd0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -87,6 +87,8 @@ void idpf_intr_rel(struct idpf_adapter *adapter)
 	idpf_deinit_vector_stack(adapter);
 	kfree(adapter->msix_entries);
 	adapter->msix_entries = NULL;
+	kfree(adapter->rdma_msix_entries);
+	adapter->rdma_msix_entries = NULL;
 }
 
 /**
@@ -314,13 +316,33 @@ int idpf_req_rel_vector_indexes(struct idpf_adapter *adapter,
  */
 int idpf_intr_req(struct idpf_adapter *adapter)
 {
+	u16 num_lan_vecs, min_lan_vecs, num_rdma_vecs = 0, min_rdma_vecs = 0;
 	u16 default_vports = idpf_get_default_vports(adapter);
 	int num_q_vecs, total_vecs, num_vec_ids;
 	int min_vectors, v_actual, err;
 	unsigned int vector;
 	u16 *vecids;
+	int i;
 
 	total_vecs = idpf_get_reserved_vecs(adapter);
+	num_lan_vecs = total_vecs;
+	if (idpf_is_rdma_cap_ena(adapter)) {
+		num_rdma_vecs = idpf_get_reserved_rdma_vecs(adapter);
+		min_rdma_vecs = IDPF_MIN_RDMA_VEC;
+
+		if (!num_rdma_vecs) {
+			/* If idpf_get_reserved_rdma_vecs is 0, vectors are
+			 * pulled from the LAN pool.
+			 */
+			num_rdma_vecs = min_rdma_vecs;
+		} else if (num_rdma_vecs < min_rdma_vecs) {
+			dev_err(&adapter->pdev->dev,
+				"Not enough vectors reserved for RDMA (min: %u, current: %u)\n",
+				min_rdma_vecs, num_rdma_vecs);
+			return -EINVAL;
+		}
+	}
+
 	num_q_vecs = total_vecs - IDPF_MBX_Q_VEC;
 
 	err = idpf_send_alloc_vectors_msg(adapter, num_q_vecs);
@@ -331,52 +353,75 @@ int idpf_intr_req(struct idpf_adapter *adapter)
 		return -EAGAIN;
 	}
 
-	min_vectors = IDPF_MBX_Q_VEC + IDPF_MIN_Q_VEC * default_vports;
+	min_lan_vecs = IDPF_MBX_Q_VEC + IDPF_MIN_Q_VEC * default_vports;
+	min_vectors = min_lan_vecs + min_rdma_vecs;
 	v_actual = pci_alloc_irq_vectors(adapter->pdev, min_vectors,
 					 total_vecs, PCI_IRQ_MSIX);
 	if (v_actual < min_vectors) {
-		dev_err(&adapter->pdev->dev, "Failed to allocate MSIX vectors: %d\n",
+		dev_err(&adapter->pdev->dev, "Failed to allocate minimum MSIX vectors required: %d\n",
 			v_actual);
 		err = -EAGAIN;
 		goto send_dealloc_vecs;
 	}
 
-	adapter->msix_entries = kcalloc(v_actual, sizeof(struct msix_entry),
-					GFP_KERNEL);
+	if (idpf_is_rdma_cap_ena(adapter)) {
+		if (v_actual < total_vecs) {
+			dev_warn(&adapter->pdev->dev,
+				 "Warning: not enough vectors available. Defaulting to minimum for RDMA and remaining for LAN.\n");
+			num_rdma_vecs = IDPF_MIN_RDMA_VEC;
+		}
 
+		adapter->rdma_msix_entries =
+			kcalloc(num_rdma_vecs,
+				sizeof(struct msix_entry), GFP_KERNEL);
+		if (!adapter->rdma_msix_entries) {
+			err = -ENOMEM;
+			goto free_irq;
+		}
+	}
+
+	num_lan_vecs = v_actual - num_rdma_vecs;
+	adapter->msix_entries = kcalloc(num_lan_vecs, sizeof(struct msix_entry),
+					GFP_KERNEL);
 	if (!adapter->msix_entries) {
 		err = -ENOMEM;
-		goto free_irq;
+		goto free_rdma_msix;
 	}
 
 	idpf_set_mb_vec_id(adapter);
 
-	vecids = kcalloc(total_vecs, sizeof(u16), GFP_KERNEL);
+	vecids = kcalloc(v_actual, sizeof(u16), GFP_KERNEL);
 	if (!vecids) {
 		err = -ENOMEM;
 		goto free_msix;
 	}
 
-	num_vec_ids = idpf_get_vec_ids(adapter, vecids, total_vecs,
+	num_vec_ids = idpf_get_vec_ids(adapter, vecids, v_actual,
 				       &adapter->req_vec_chunks->vchunks);
 	if (num_vec_ids < v_actual) {
 		err = -EINVAL;
 		goto free_vecids;
 	}
 
-	for (vector = 0; vector < v_actual; vector++) {
-		adapter->msix_entries[vector].entry = vecids[vector];
-		adapter->msix_entries[vector].vector =
+	for (i = 0, vector = 0; vector < num_lan_vecs; vector++, i++) {
+		adapter->msix_entries[i].entry = vecids[vector];
+		adapter->msix_entries[i].vector =
+			pci_irq_vector(adapter->pdev, vector);
+	}
+	for (i = 0; i < num_rdma_vecs; vector++, i++) {
+		adapter->rdma_msix_entries[i].entry = vecids[vector];
+		adapter->rdma_msix_entries[i].vector =
 			pci_irq_vector(adapter->pdev, vector);
 	}
 
-	adapter->num_req_msix = total_vecs;
-	adapter->num_msix_entries = v_actual;
 	/* 'num_avail_msix' is used to distribute excess vectors to the vports
 	 * after considering the minimum vectors required per each default
 	 * vport
 	 */
-	adapter->num_avail_msix = v_actual - min_vectors;
+	adapter->num_avail_msix = num_lan_vecs - min_lan_vecs;
+	adapter->num_msix_entries = num_lan_vecs;
+	if (idpf_is_rdma_cap_ena(adapter))
+		adapter->num_rdma_msix_entries = num_rdma_vecs;
 
 	/* Fill MSIX vector lifo stack with vector indexes */
 	err = idpf_init_vector_stack(adapter);
@@ -398,6 +443,9 @@ int idpf_intr_req(struct idpf_adapter *adapter)
 free_msix:
 	kfree(adapter->msix_entries);
 	adapter->msix_entries = NULL;
+free_rdma_msix:
+	kfree(adapter->rdma_msix_entries);
+	adapter->rdma_msix_entries = NULL;
 free_irq:
 	pci_free_irq_vectors(adapter->pdev);
 send_dealloc_vecs:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 0f71a6f5557b..faa8774b69f8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -57,6 +57,7 @@
 /* Default vector sharing */
 #define IDPF_MBX_Q_VEC		1
 #define IDPF_MIN_Q_VEC		1
+#define IDPF_MIN_RDMA_VEC	2
 
 #define IDPF_DFLT_TX_Q_DESC_COUNT		512
 #define IDPF_DFLT_TX_COMPLQ_DESC_COUNT		512
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 63deb120359c..80c17e4a394e 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -473,6 +473,8 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_version_info);
  *			segment offload.
  * @max_hdr_buf_per_lso: Max number of header buffers that can be used for
  *			 an LSO.
+ * @num_rdma_allocated_vectors: Maximum number of allocated RDMA vectors for
+ *				the device.
  * @pad1: Padding for future extensions.
  *
  * Dataplane driver sends this message to CP to negotiate capabilities and
@@ -520,7 +522,8 @@ struct virtchnl2_get_capabilities {
 	__le32 device_type;
 	u8 min_sso_packet_len;
 	u8 max_hdr_buf_per_lso;
-	u8 pad1[10];
+	__le16 num_rdma_allocated_vectors;
+	u8 pad1[8];
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(80, virtchnl2_get_capabilities);
 
-- 
2.37.3


