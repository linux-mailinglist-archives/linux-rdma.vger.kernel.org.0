Return-Path: <linux-rdma+bounces-7533-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD72A2CD13
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 20:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103A03ABB3B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 19:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2644E19F11B;
	Fri,  7 Feb 2025 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxA8hYQ8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D86923C8CB;
	Fri,  7 Feb 2025 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957827; cv=none; b=F9sRmjNLL8DAyFXCpVJ3ItMOBZZsMzeS+k4jr/QoCd6dY6gc6vAWs3n2CBbPPul/X12n2DZabwYUh0XgLvRyCKcPvMq62sFmCeJMkhDKAUW0YP2laH6p8usSJAWWcBqoSM2fDRPrIFydwTYloD93dXdoyPE3MiKru+sNTVMIv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957827; c=relaxed/simple;
	bh=Mcu3FHF7CZiRhw1aF6QTWnIon7UDojcu0eqdATRg22o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d9zdT3AsfvGFBUx2UPNJgUSXvyq7rLJes2IuzpCgTyuKOlSiCUIGIGnRlJeGjIJm5G29vrXBxGMZ9VfPkPIztFS1Zy9Qcxirb21gSMgnGNQQlSuQoc064AVDXV5JJrxrX0z+Lo2/yijl0/vG9fZF2IMSYPZd2ZhK+4EKw9YmNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxA8hYQ8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738957826; x=1770493826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mcu3FHF7CZiRhw1aF6QTWnIon7UDojcu0eqdATRg22o=;
  b=mxA8hYQ8EPxaqcf7HR794H0fwksLDZUJccCSa28jcd6F8vMHqZoXtkIv
   PROt4rONPzmsci/vTuMUqGg/Ea5uK0zrNDgWN6DpobmZQ68qa9hhv1Ywq
   adO8qWqCSuxX7seB/POFqOTdB74GPgGgE0P0SLdnJ5ck0oZxHmn1SI4Lq
   h5CTl+CWlJrO4rf+wVzkzWbvL2wyxWIn3TXtFDhwmiUe2SSGnpQck8UBp
   XTxLIMNWzf1YQ/c9xqBR6qRLDjacpHHBpLjQhTUWVbd6nFh89Lff2qHv8
   uqu3H7pvLS6UhGazmjAJ5qcxGJlWPG0DRxinJwHImZ2zdVTmklFlAogdU
   g==;
X-CSE-ConnectionGUID: p5OUIJf4R6WtxyZTOuLvhg==
X-CSE-MsgGUID: GKuHSqLTSDCWL8qGW7yTtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42451767"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="42451767"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:24 -0800
X-CSE-ConnectionGUID: 2sVf8VVRQ4iSPboYpj2erA==
X-CSE-MsgGUID: eEKFdfq5So6AWOVGP+Urxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112238133"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.81.134])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:23 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [iwl-next v3 05/24] idpf: implement remaining IDC RDMA core callbacks and handlers
Date: Fri,  7 Feb 2025 13:49:12 -0600
Message-Id: <20250207194931.1569-6-tatyana.e.nikolova@intel.com>
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

Implement the idpf_idc_request_reset and idpf_idc_rdma_vc_send_sync
callbacks for the rdma core auxiliary driver to issue reset events to
the idpf and send (synchronous) virtchnl messages to the control plane
respectively.

Implement and plumb the reset handler for the opposite flow as well,
i.e. when the idpf is resetiing and needs to notify the rdma core
auxiliary driver.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---

v3:
- remove unnecessary iadrv NULL check

 drivers/net/ethernet/intel/idpf/idpf.h        |  1 +
 drivers/net/ethernet/intel/idpf/idpf_idc.c    | 43 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 23 +++++++++-
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  3 +-
 5 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index a9c0639f0021..9516e946781a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -872,5 +872,6 @@ int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
 			       enum idc_function_type ftype);
 void idpf_idc_deinit_core_aux_device(struct idc_rdma_core_dev_info *cdev_info);
 void idpf_idc_deinit_vport_aux_device(struct idc_rdma_vport_dev_info *vdev_info);
+void idpf_idc_issue_reset_event(struct idc_rdma_core_dev_info *cdev_info);
 
 #endif /* !_IDPF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index a9049cb616a9..3dbd7e2a7e98 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -216,6 +216,38 @@ static void idpf_unplug_aux_dev(struct auxiliary_device *adev)
 	ida_free(&idpf_idc_ida, adev->id);
 }
 
+/**
+ * idpf_idc_issue_reset_event - Function to handle reset IDC event
+ * @cdev_info: IDC core device info pointer
+ */
+void idpf_idc_issue_reset_event(struct idc_rdma_core_dev_info *cdev_info)
+{
+	enum idc_rdma_event_type event_type = IDC_RDMA_EVENT_WARN_RESET;
+	struct idc_rdma_core_auxiliary_drv *iadrv;
+	struct idc_rdma_event event = { };
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
+			     struct idc_rdma_core_auxiliary_drv,
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
@@ -300,7 +332,16 @@ static int
 idpf_idc_request_reset(struct idc_rdma_core_dev_info *cdev_info,
 		       enum idc_rdma_reset_type __always_unused reset_type)
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
 
 /* Implemented by the Auxiliary Device and called by the Auxiliary Driver */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index a211fca9e925..88a33c8b18fe 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1803,6 +1803,8 @@ static int idpf_init_hard_reset(struct idpf_adapter *adapter)
 	} else if (test_and_clear_bit(IDPF_HR_FUNC_RESET, adapter->flags)) {
 		bool is_reset = idpf_is_reset_detected(adapter);
 
+		idpf_idc_issue_reset_event(adapter->cdev_info);
+
 		idpf_set_vport_state(adapter);
 		idpf_vc_core_deinit(adapter);
 		if (!is_reset)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index eaffda7a2673..bd20d7b148c2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3754,5 +3754,26 @@ int idpf_idc_rdma_vc_send_sync(struct idc_rdma_core_dev_info *cdev_info,
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


