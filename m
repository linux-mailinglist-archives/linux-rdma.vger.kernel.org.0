Return-Path: <linux-rdma+bounces-10635-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC22AC2821
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 19:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920983A2911
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FE02980A5;
	Fri, 23 May 2025 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iER59/Q7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FC6223710;
	Fri, 23 May 2025 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019966; cv=none; b=i0/RCQPmIXmt2gApWz1U98CiR6GWKN0d3MVhomFPH6aHyggDYTT6EXGObYAQOTNoLkkMVi32RLxSYUuz3FU48RLgvbROOJ61y433KIh+Pvv4yNW29BEJOxPzYDB8ggNYk3CDD1nKHYIfJ6FY2Bs3BCOePgp3RSUudMoN9L/Nk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019966; c=relaxed/simple;
	bh=DKKb6Nr+fFG8lmdlImt6CUI/cLon2YE+JYAhBts0mnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKghFbbkDVRFY5zwRZ2z7MHblrdYRto8Dj43t1ICLAr6v4eiCnwv76rXsrAW0ITqCD6rUUwCq1GiD83CX4CUXgUmcgsDuUMdsLVEu+TCTBxMgd0XKdhHw6CzD/cMo5qApiyVryKx31fFNf6dnpBgrL2bhczgY9BSCrzZTVzNNQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iER59/Q7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748019965; x=1779555965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DKKb6Nr+fFG8lmdlImt6CUI/cLon2YE+JYAhBts0mnc=;
  b=iER59/Q7jA2bTkwPC88vhv5GU4vKjynxgVKvx83znFosCXEyU8eYlkyH
   Rs9B2mFrCiDMDrorLguRMvW4xPU+QJh0AjDbhMCqKs/BL7AV1ADBlyKl6
   kPyWFZNHdnUvlWAty/cvkV50o59fzuaVDgcrnbPD4DLLtgo81ZWBKiw8g
   oaRAtbOVcPF78/ca26f29PRoESX7mvsm5y07tpWS916bTrlS1wl4h3XsA
   sOt9GBgptbi+B1X7jGTC4Tul1OF8qCRRNX7sKRxsbqJXZkK2jMW73xsYo
   hE+xXNCEA2jOoaZg+vijc2nLczz8nJOpSxPW35K5mzBy1a7wbrcAC3zOW
   w==;
X-CSE-ConnectionGUID: Stqorz5rQXKIdos6Me+jWw==
X-CSE-MsgGUID: d674vhlqQyeDvyUebTOEZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60738395"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="60738395"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 10:06:04 -0700
X-CSE-ConnectionGUID: pKXD5fNWRcijAVL3SymAqg==
X-CSE-MsgGUID: 7VXdg3seRAmVLswzEMhHIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="164457446"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 10:06:02 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: jgg@nvidia.com,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	anthony.l.nguyen@intel.com,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [iwl-next 4/6] idpf: implement remaining IDC RDMA core callbacks and handlers
Date: Fri, 23 May 2025 12:04:33 -0500
Message-ID: <20250523170435.668-5-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250523170435.668-1-tatyana.e.nikolova@intel.com>
References: <20250523170435.668-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

Implement the idpf_idc_request_reset and idpf_idc_rdma_vc_send_sync
callbacks for the rdma core auxiliary driver to issue reset events to
the idpf and send (synchronous) virtchnl messages to the control plane
respectively.

Implement and plumb the reset handler for the opposite flow as well,
i.e. when the idpf is resetiing and needs to notify the rdma core
auxiliary driver.

Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---

Changes since split:
- align with new header naming

[3]:
- remove unnecessary iadrv NULL check

 drivers/net/ethernet/intel/idpf/idpf.h        |  1 +
 drivers/net/ethernet/intel/idpf/idpf_idc.c    | 43 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 23 +++++++++-
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  3 +-
 5 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 54aaef4da059..9043a31b0282 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -873,5 +873,6 @@ int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
 			       enum iidc_function_type ftype);
 void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info *cdev_info);
 void idpf_idc_deinit_vport_aux_device(struct iidc_rdma_vport_dev_info *vdev_info);
+void idpf_idc_issue_reset_event(struct iidc_rdma_core_dev_info *cdev_info);
 
 #endif /* !_IDPF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index a869966b5941..a3c50104a3d7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -216,6 +216,38 @@ static void idpf_unplug_aux_dev(struct auxiliary_device *adev)
 	ida_free(&idpf_idc_ida, adev->id);
 }
 
+/**
+ * idpf_idc_issue_reset_event - Function to handle reset IDC event
+ * @cdev_info: IDC core device info pointer
+ */
+void idpf_idc_issue_reset_event(struct iidc_rdma_core_dev_info *cdev_info)
+{
+	enum iidc_rdma_event_type event_type = IIDC_RDMA_EVENT_WARN_RESET;
+	struct iidc_rdma_core_auxiliary_drv *iadrv;
+	struct iidc_rdma_event event = { };
+	struct auxiliary_device *adev;
+
+	if (!cdev_info)
+		/* RDMA is not enabled */
+		return;
+
+	set_bit(event_type, event.type);
+
+	device_lock(&cdev_info->adev->dev);
+
+	adev = cdev_info->adev;
+	if (!adev || !adev->dev.driver)
+		goto unlock;
+
+	iadrv = container_of(adev->dev.driver,
+			     struct iidc_rdma_core_auxiliary_drv,
+			     adrv.driver);
+	if (iadrv->event_handler)
+		iadrv->event_handler(cdev_info, &event);
+unlock:
+	device_unlock(&cdev_info->adev->dev);
+}
+
 /**
  * idpf_idc_vport_dev_up - called when CORE is ready for vport aux devs
  * @adapter: private data struct
@@ -298,7 +330,16 @@ EXPORT_SYMBOL_GPL(idpf_idc_vport_dev_ctrl);
 int idpf_idc_request_reset(struct iidc_rdma_core_dev_info *cdev_info,
 			   enum iidc_rdma_reset_type __always_unused reset_type)
 {
-	return -EOPNOTSUPP;
+	struct idpf_adapter *adapter = pci_get_drvdata(cdev_info->pdev);
+
+	if (!idpf_is_reset_in_prog(adapter)) {
+		set_bit(IDPF_HR_FUNC_RESET, adapter->flags);
+		queue_delayed_work(adapter->vc_event_wq,
+				   &adapter->vc_event_task,
+				   msecs_to_jiffies(10));
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(idpf_idc_request_reset);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 5c2b7a76db33..9358dabe852a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1817,6 +1817,8 @@ static int idpf_init_hard_reset(struct idpf_adapter *adapter)
 	} else if (test_and_clear_bit(IDPF_HR_FUNC_RESET, adapter->flags)) {
 		bool is_reset = idpf_is_reset_detected(adapter);
 
+		idpf_idc_issue_reset_event(adapter->cdev_info);
+
 		idpf_set_vport_state(adapter);
 		idpf_vc_core_deinit(adapter);
 		if (!is_reset)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d10f4676875c..7bb1059e917f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3754,6 +3754,27 @@ int idpf_idc_rdma_vc_send_sync(struct iidc_rdma_core_dev_info *cdev_info,
 			       u8 *send_msg, u16 msg_size,
 			       u8 *recv_msg, u16 *recv_len)
 {
-	return -EOPNOTSUPP;
+	struct idpf_adapter *adapter = pci_get_drvdata(cdev_info->pdev);
+	struct idpf_vc_xn_params xn_params = { };
+	ssize_t reply_sz;
+	u16 recv_size;
+
+	if (!recv_msg || !recv_len || msg_size > IDPF_CTLQ_MAX_BUF_LEN)
+		return -EINVAL;
+
+	recv_size = min_t(u16, *recv_len, IDPF_CTLQ_MAX_BUF_LEN);
+	*recv_len = 0;
+	xn_params.vc_op = VIRTCHNL2_OP_RDMA;
+	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
+	xn_params.send_buf.iov_base = send_msg;
+	xn_params.send_buf.iov_len = msg_size;
+	xn_params.recv_buf.iov_base = recv_msg;
+	xn_params.recv_buf.iov_len = recv_size;
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
+	if (reply_sz < 0)
+		return reply_sz;
+	*recv_len = reply_sz;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(idpf_idc_rdma_vc_send_sync);
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 673a39e6698d..e6541152ca58 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -62,8 +62,9 @@ enum virtchnl2_op {
 	VIRTCHNL2_OP_GET_PTYPE_INFO		= 526,
 	/* Opcode 527 and 528 are reserved for VIRTCHNL2_OP_GET_PTYPE_ID and
 	 * VIRTCHNL2_OP_GET_PTYPE_INFO_RAW.
-	 * Opcodes 529, 530, 531, 532 and 533 are reserved.
 	 */
+	VIRTCHNL2_OP_RDMA			= 529,
+	/* Opcodes 530 through 533 are reserved. */
 	VIRTCHNL2_OP_LOOPBACK			= 534,
 	VIRTCHNL2_OP_ADD_MAC_ADDR		= 535,
 	VIRTCHNL2_OP_DEL_MAC_ADDR		= 536,
-- 
2.37.3


