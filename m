Return-Path: <linux-rdma+bounces-4536-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DACF095DADD
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 05:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34881C20C21
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 03:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDF940862;
	Sat, 24 Aug 2024 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQd/GIEv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DFF38382;
	Sat, 24 Aug 2024 03:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724469645; cv=none; b=asWlgXphRyp4UDGoqU/2+ro3BP5dTifqiBHLpvoXV5Kc4LSOmt0DXh+8hqdP5ENn+KoGFetwMLsADUVEVXO0AHRnwJ48jNIk5FaZbkLxu1ObuQwB1km5OF460keG2sD3dnvmy8qsa8T8xg6j/vpHNSjbthd8YDLUwVtxHi9U1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724469645; c=relaxed/simple;
	bh=XHhTY7xzIB3NQjloeZyAACTpkUyYpjkaUPV1cWpH2JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sbcX6l02QkWYNRQBXkKPBLFz1J0c0kJkIRmXb79aNjZsjYe2UsgB/5frUQNmORdwslWm/gtoX04+Zn17+FBnPU3JSJpE6gcT579F0F7fPHm8dbGPpOhctKan+00gC1LuI2J2qLvL7wSMMsbF2OHC5E6T/qS/XODeHNr2rYaBJTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQd/GIEv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724469644; x=1756005644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XHhTY7xzIB3NQjloeZyAACTpkUyYpjkaUPV1cWpH2JE=;
  b=hQd/GIEveFfnCFrPD1owqN7DYb+PTy945ouDifA4mygz6OyrygXQ0jVx
   9zZCrSQaicLV9/cmDYgIRfAd6UleqJU4iV5rylBRnEM6dGuYbXUpBRFMO
   KGrFLio4/ig9l857MnRIuofwg0vDwslkLGlpRijAE3C3K+eObUa9yzxAx
   yMV/MlZ2/R+g/l+kAR3Ed1cEcnjU8ECi1lQOaqjmc8HPkV2FTl497VK2m
   h+BW2IpGyPUT6bwHp33kIzFq2Qpv49Dra3WA1fYm31T+QbciTziul1VZb
   WiDw8SdECHLRJs/sZdWsFBhFMWD3Pq2rpKfmw3heDI+gmXdOngiXUx2Up
   g==;
X-CSE-ConnectionGUID: MMGDHjQRQCyWTerkb2zpCw==
X-CSE-MsgGUID: sVVPWrkYRti2/cM+IWpcPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="13187782"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="13187782"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:41 -0700
X-CSE-ConnectionGUID: 3/DYd6+rTni0Fx4j1W8BYg==
X-CSE-MsgGUID: UGgDgwUdSS2tuiPj4xg65w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="99492087"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.36.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:41 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC v2 06/25] idpf: implement remaining idc rdma core callbacks and handlers
Date: Fri, 23 Aug 2024 22:19:05 -0500
Message-Id: <20240824031924.421-7-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
References: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
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
 drivers/net/ethernet/intel/idpf/idpf.h        |  1 +
 drivers/net/ethernet/intel/idpf/idpf_idc.c    | 43 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 23 +++++++++-
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  3 +-
 5 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 2299be4aee4b..5ff01927d471 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -865,5 +865,6 @@ int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
 			       enum idc_function_type ftype);
 void idpf_idc_deinit_core_aux_device(struct idc_rdma_core_dev_info *cdev_info);
 void idpf_idc_deinit_vport_aux_device(struct idc_rdma_vport_dev_info *vdev_info);
+void idpf_idc_issue_reset_event(struct idc_rdma_core_dev_info *cdev_info);
 
 #endif /* !_IDPF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 1f22868b8d75..ac6746fd87f9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -211,6 +211,38 @@ static void idpf_unplug_aux_dev(struct auxiliary_device *adev)
 	ida_free(&idpf_idc_ida, adev->id);
 }
 
+/**
+ * idpf_idc_issue_reset_event - Function to handle reset IDC event
+ * @cdev_info: idc core device info pointer
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
+	if (iadrv && iadrv->event_handler)
+		iadrv->event_handler(cdev_info, &event);
+unlock:
+	device_unlock(&cdev_info->adev->dev);
+}
+
 /**
  * idpf_idc_vport_dev_up - called when CORE is ready for vport aux devs
  * @adapter: private data struct
@@ -289,7 +321,16 @@ static int
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
index d4fb8b1652ae..db0b7ffd8df1 100644
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
index d5067932de00..6b7ead2d4cf2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3747,5 +3747,26 @@ int idpf_idc_rdma_vc_send_sync(struct idc_rdma_core_dev_info *cdev_info,
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
2.42.0


