Return-Path: <linux-rdma+bounces-3955-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9B693B981
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 01:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22EB1C23259
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 23:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DE1143C4B;
	Wed, 24 Jul 2024 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+dUowQQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B244143C5D
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864441; cv=none; b=iKYzEmdSxmzU2RdEEn1X6/+ufr/lPF7tClwYoA524+iHWIb+zDubg3nWrNatQUaGqddvZVazljNwn/PJuswXu4/m5oF68JQRJEDQciV5KX1wBBKHR9da5cAhm5QDsgfi4mErfwFmC+xgsscmGkM7muEw5/URRNbhtp6YFDoFOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864441; c=relaxed/simple;
	bh=B6nkGiyw+zEOoTYveMJYCcYSTD6CXaiHITb2OitCsHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oKHc0JCAfGnG80oDAMTOzhOPcElCG+5or62W9cMHSQpGAp3C37r/6ZNUSt418YD3yUS86gZXaiWpfUb+sKrXKJEU19CvkO09JeIbwA67T2HrLKW/VBXjw0hBD+g/9pAre8f3ObhC67fGvPmfa8OHgcpMpcW1MokZjy8luublRfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+dUowQQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721864440; x=1753400440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B6nkGiyw+zEOoTYveMJYCcYSTD6CXaiHITb2OitCsHo=;
  b=Z+dUowQQ9kz3uCkOmIYmgv2bGRqIcu+T870V+W5R1VRfSBAV/zzQn+Tf
   fe5JhCPu9kNSGz8g/Xz7/W15XdwtguGFW6h5lYVak/gwzdqBiKXVMp3/l
   Hnjh6fFjSu2a/tfrE2YsUHU7f0CdwmxEGMUs4JA2gGqr1fiRUgzW8Tn86
   SoPQiU7IW2Mlf6y+B4FoQYx+qt6FUeiYa7vtbP8l2eTJixkWZX2lnNiID
   uui3iRXTbJbTHP4hGMshzzfsYLzGQFNXvGFIqRPleuBBGZvhFX7S8gy3G
   VciVWudimxMLvavmwAToXebewryXu0Z8O+wkop3Q3u6oq2zcOd7mkhc1B
   g==;
X-CSE-ConnectionGUID: Z0ay4bX9SGq/AAyHP8I1Rw==
X-CSE-MsgGUID: Fr0n8bgwQP+EOZrYtt82pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="44999751"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="44999751"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:38 -0700
X-CSE-ConnectionGUID: ZGL3ZtATQzyBpNVH6wqsbw==
X-CSE-MsgGUID: usFEgiibSvm0nKjpZD2A9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52426016"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.96.138])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:37 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	mustafa.ismail@intel.com,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC PATCH 06/25] idpf: implement remaining idc rdma core callbacks and handlers
Date: Wed, 24 Jul 2024 18:38:58 -0500
Message-Id: <20240724233917.704-7-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
References: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
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
 drivers/net/ethernet/intel/idpf/idpf.h          |  1 +
 drivers/net/ethernet/intel/idpf/idpf_idc.c      | 43 ++++++++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c      |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 23 ++++++++++++-
 drivers/net/ethernet/intel/idpf/virtchnl2.h     |  3 +-
 5 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 46ec54e..0e3e7000 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -868,5 +868,6 @@ int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
 			       enum idc_function_type ftype);
 void idpf_idc_deinit_core_aux_device(struct idc_rdma_core_dev_info *cdev_info);
 void idpf_idc_deinit_vport_aux_device(struct idc_rdma_vport_dev_info *vdev_info);
+void idpf_idc_issue_reset_event(struct idc_rdma_core_dev_info *cdev_info);
 
 #endif /* !_IDPF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index bb69b2d..24ab9a4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -209,6 +209,38 @@ static void idpf_unplug_aux_dev(struct auxiliary_device *adev)
 }
 
 /**
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
+/**
  * idpf_idc_vport_dev_up - called when CORE is ready for vport aux devs
  * @adapter: private data struct
  */
@@ -285,7 +317,16 @@ static void idpf_idc_vport_dev_down(struct idpf_adapter *adapter)
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
index 718d40c..237cc04 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1814,6 +1814,8 @@ static int idpf_init_hard_reset(struct idpf_adapter *adapter)
 	} else if (test_and_clear_bit(IDPF_HR_FUNC_RESET, adapter->flags)) {
 		bool is_reset = idpf_is_reset_detected(adapter);
 
+		idpf_idc_issue_reset_event(adapter->cdev_info);
+
 		idpf_set_vport_state(adapter);
 		idpf_vc_core_deinit(adapter);
 		if (!is_reset)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index cdfd440..65936de 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3703,5 +3703,26 @@ int idpf_idc_rdma_vc_send_sync(struct idc_rdma_core_dev_info *cdev_info,
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
index 673a39e..e6541152 100644
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
1.8.3.1


