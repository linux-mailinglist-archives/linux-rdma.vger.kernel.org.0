Return-Path: <linux-rdma+bounces-10636-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 025A1AC2822
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 19:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51E0541811
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 17:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CEF298253;
	Fri, 23 May 2025 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGmufioP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CEA297B71;
	Fri, 23 May 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019967; cv=none; b=Bc/imCrfvea6mcvl1oWO4089N7dGpDGz7Rbygyetc9QiWoRsl7WJMfQvfHXGqjUsiXGU2NbrXsRCgTGUvVh0N0YYXGWywdpGh5jVelEUI9NO2B8XxpFulMc2e96OuyQe57fOZwTYh9wf5Kx/5t9baJZCg4C6CWQBHhv4UuNpmjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019967; c=relaxed/simple;
	bh=4Ny0smhDfp/L4YAs6aaepziBsHxEPZo6AQrtHir2sD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQqOyBfhGhW+aCIcJZK0tiGqWv/LHEOtjQuxrijJd1N8XWucjHlo+kNu4amaqy++xZgUmE/dZW6o9n6i+cRs+Ly7EEvifPfcG7fUhy6OShIFunBCPyi9+LkIj67uuarorwgbgbasvCjM4fLCFBy7oWR7oWfkgMTMRfasx1i8Lho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGmufioP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748019966; x=1779555966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Ny0smhDfp/L4YAs6aaepziBsHxEPZo6AQrtHir2sD4=;
  b=eGmufioPhV+a9NkXYhcB/kTkvksrM12/pEedbOBddmMBCRLNM5k7KWgN
   Ka44Ky0ADlLXscAi/onb+Rabs1rVnjc+q2rhYY1RxWFCb3a797PxyWHZn
   VIM9hDME+hSABiXxQjdqAo6dOEIRR8YwytSvLUrtEFIeDNpJZElXhaW4C
   kXmue73R2vsNxlq5gsfNck6BF2LDjMuo/tRq7CgwGc1OUx79IjUhc7iU4
   dZficv8znw5xON6r5p9jCfB7U3uQK2+L472csW/h0Jzs3sggcHfjLRlO6
   3oP85vqOHcTpxypejI+ua1JlsL4/DLEAgpWRfp7wi0iGhyw9M2OJp83R+
   g==;
X-CSE-ConnectionGUID: t3pozmNoTD2Cyd1o4uEuxg==
X-CSE-MsgGUID: +1RY99l/QEWAPzWKhxhJtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60738402"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="60738402"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 10:06:04 -0700
X-CSE-ConnectionGUID: +16fznY+QFekBkE/tkgF2w==
X-CSE-MsgGUID: HHf98DEgQXmDAFCltnDuhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="164457461"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 10:06:03 -0700
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
Subject: [iwl-next 5/6] idpf: implement IDC vport aux driver MTU change handler
Date: Fri, 23 May 2025 12:04:34 -0500
Message-ID: <20250523170435.668-6-tatyana.e.nikolova@intel.com>
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

The only event an RDMA vport aux driver cares about right now is an MTU
change on its underlying vport. Implement and plumb the handler to
signal the pre MTU change event and post MTU change events to the RDMA
vport aux driver.

Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---

Changes since split:
- align with iidc_rdma header naming

[3]:
- add missing break statement
- remove unnecessary iadrv NULL check

 drivers/net/ethernet/intel/idpf/idpf.h     |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 31 ++++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 11 +++++---
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 9043a31b0282..7b5f2e274cfa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -874,5 +874,7 @@ int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
 void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info *cdev_info);
 void idpf_idc_deinit_vport_aux_device(struct iidc_rdma_vport_dev_info *vdev_info);
 void idpf_idc_issue_reset_event(struct iidc_rdma_core_dev_info *cdev_info);
+void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
+			     enum iidc_rdma_event_type event_type);
 
 #endif /* !_IDPF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index a3c50104a3d7..51e54525a2c4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -137,6 +137,37 @@ static int idpf_idc_init_aux_vport_dev(struct idpf_vport *vport)
 	return 0;
 }
 
+/**
+ * idpf_idc_vdev_mtu_event - Function to handle IDC vport mtu change events
+ * @vdev_info: IDC vport device info pointer
+ * @event_type: type of event to pass to handler
+ */
+void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
+			     enum iidc_rdma_event_type event_type)
+{
+	struct iidc_rdma_vport_auxiliary_drv *iadrv;
+	struct iidc_rdma_event event = { };
+	struct auxiliary_device *adev;
+
+	if (!vdev_info)
+		/* RDMA is not enabled */
+		return;
+
+	set_bit(event_type, event.type);
+
+	device_lock(&vdev_info->adev->dev);
+	adev = vdev_info->adev;
+	if (!adev || !adev->dev.driver)
+		goto unlock;
+	iadrv = container_of(adev->dev.driver,
+			     struct iidc_rdma_vport_auxiliary_drv,
+			     adrv.driver);
+	if (iadrv->event_handler)
+		iadrv->event_handler(vdev_info, &event);
+unlock:
+	device_unlock(&vdev_info->adev->dev);
+}
+
 /**
  * idpf_core_adev_release - function to be mapped to aux dev's release op
  * @dev: pointer to device to free
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 9358dabe852a..465d39448fe5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1945,6 +1945,9 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		idpf_vport_calc_num_q_desc(new_vport);
 		break;
 	case IDPF_SR_MTU_CHANGE:
+		idpf_idc_vdev_mtu_event(vport->vdev_info,
+					IIDC_RDMA_EVENT_BEFORE_MTU_CHANGE);
+		break;
 	case IDPF_SR_RSC_CHANGE:
 		break;
 	default:
@@ -1989,9 +1992,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	if (current_state == __IDPF_VPORT_UP)
 		err = idpf_vport_open(vport);
 
-	kfree(new_vport);
-
-	return err;
+	goto free_vport;
 
 err_reset:
 	idpf_send_add_queues_msg(vport, vport->num_txq, vport->num_complq,
@@ -2004,6 +2005,10 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 free_vport:
 	kfree(new_vport);
 
+	if (reset_cause == IDPF_SR_MTU_CHANGE)
+		idpf_idc_vdev_mtu_event(vport->vdev_info,
+					IIDC_RDMA_EVENT_AFTER_MTU_CHANGE);
+
 	return err;
 }
 
-- 
2.37.3


