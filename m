Return-Path: <linux-rdma+bounces-4538-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554A295DAE1
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 05:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90401F22A22
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 03:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24438481D5;
	Sat, 24 Aug 2024 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvOVAi1I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524C3D3B8;
	Sat, 24 Aug 2024 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724469646; cv=none; b=MjwRmISnljqwH/aJTUbNa9GYHVyPa7gJPY09oWeezzREKUnwa2OetJTlorWsKAC4A1mCObKV2OMNIT0DPU2zUnS6QO6VvZ+XzF4SzlM2mSAZ6jvBLFSNE5mk7uk3jM8v6PGfdo3CG+Qx77wmPeAr1EzqceT+5UqDnJGZy6q+V6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724469646; c=relaxed/simple;
	bh=xgKS2rR96ToGxk5i/MjvnzjXscsYJABmaHVYM3gb3vI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yph7644Q4vFoJw/rgo1JUT+PSvLaLJADY6tOR1iRX1YzHQxxIY0xfYte5PERNOU5kyPQoDQYZlx8sYkti/jWzMZlgSiSSlbUnphZdiKnPHUWRZHFg5tUcqgyuCDWMNHUYplJkv1ZpfSKBphc5EN3OIZEdrfk+bfCnG+hP9doaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvOVAi1I; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724469645; x=1756005645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xgKS2rR96ToGxk5i/MjvnzjXscsYJABmaHVYM3gb3vI=;
  b=WvOVAi1IkOYlV6+RQK09KrIUAvAiVZjEyBgHsZa9HeB2vtUlf1sDCFO0
   Q/IoATiKG3M+HDzVRVN5IXbWhkOdHYqgIQTh/qxaiqv2cdZhglowXUb8i
   jxxoCzey3zI1qBFaF2WkRtrsbjnQgiYeoA77I9Zgw371pOENice4qUlW6
   VV1tl5c9c5OQUdauSN4VVbQcm0DnT5hs9IApzf4Ye5HfUG6g9z3s6ee/t
   GZiUS5ZbmKloq778NvU0Q0jUOU2EYOig0K49MfP+PKVLWUJo4wBgaOhqa
   XISqBSI72k5h0t2RHbL8tusQfuKzVl9Rb+ieE71zFhwdRmbR48Qu4NUkf
   Q==;
X-CSE-ConnectionGUID: 2AV9teILQM++DZSwzZ49cA==
X-CSE-MsgGUID: ap5lDEaCROO4ahI1MDCCyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="13187788"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="13187788"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:42 -0700
X-CSE-ConnectionGUID: ebKuCH0QQv+DrqPDtSZNnQ==
X-CSE-MsgGUID: B2TX9a5pQReGo3v5kpU3OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="99492093"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.36.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:42 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC v2 08/25] idpf: implement idc vport aux driver mtu change handler
Date: Fri, 23 Aug 2024 22:19:07 -0500
Message-Id: <20240824031924.421-9-tatyana.e.nikolova@intel.com>
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

The only event an rdma vport aux driver cares about right now is an MTU
change on its underlying vport. Implement and plumb the handler to
signal the pre MTU change event and post MTU change events to the rdma
vport aux driver.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h     |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 31 ++++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 11 +++++---
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 5ff01927d471..53b39985eefd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -866,5 +866,7 @@ int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
 void idpf_idc_deinit_core_aux_device(struct idc_rdma_core_dev_info *cdev_info);
 void idpf_idc_deinit_vport_aux_device(struct idc_rdma_vport_dev_info *vdev_info);
 void idpf_idc_issue_reset_event(struct idc_rdma_core_dev_info *cdev_info);
+void idpf_idc_vdev_mtu_event(struct idc_rdma_vport_dev_info *vdev_info,
+			     enum idc_rdma_event_type event_type);
 
 #endif /* !_IDPF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index ac6746fd87f9..53c3b79d66f5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -133,6 +133,37 @@ static int idpf_idc_init_aux_vport_dev(struct idpf_vport *vport)
 	return 0;
 }
 
+/**
+ * idpf_idc_vdev_mtu_event - Function to handle IDC vport mtu change events
+ * @vdev_info: idc vport device info pointer
+ * @event_type: type of event to pass to handler
+ */
+void idpf_idc_vdev_mtu_event(struct idc_rdma_vport_dev_info *vdev_info,
+			     enum idc_rdma_event_type event_type)
+{
+	struct idc_rdma_vport_auxiliary_drv *iadrv;
+	struct idc_rdma_event event = { };
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
+			     struct idc_rdma_vport_auxiliary_drv,
+			     adrv.driver);
+	if (iadrv && iadrv->event_handler)
+		iadrv->event_handler(vdev_info, &event);
+unlock:
+	device_unlock(&vdev_info->adev->dev);
+}
+
 /**
  * idpf_core_adev_release - function to be mapped to aux dev's release op
  * @dev: pointer to device to free
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index db0b7ffd8df1..0cf4d419b45b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1944,6 +1944,8 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		idpf_vport_calc_num_q_desc(new_vport);
 		break;
 	case IDPF_SR_MTU_CHANGE:
+		idpf_idc_vdev_mtu_event(vport->vdev_info,
+					IDC_RDMA_EVENT_BEFORE_MTU_CHANGE);
 	case IDPF_SR_RSC_CHANGE:
 		break;
 	default:
@@ -1955,6 +1957,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	err = idpf_vport_queues_alloc(new_vport);
 	if (err)
 		goto free_vport;
+
 	if (current_state <= __IDPF_VPORT_DOWN) {
 		idpf_send_delete_queues_msg(vport);
 	} else {
@@ -1991,15 +1994,17 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	if (current_state == __IDPF_VPORT_UP)
 		err = idpf_vport_open(vport, false);
 
-	kfree(new_vport);
-
-	return err;
+	goto free_vport;
 
 err_reset:
 	idpf_vport_queues_rel(new_vport);
 free_vport:
 	kfree(new_vport);
 
+	if (reset_cause == IDPF_SR_MTU_CHANGE)
+		idpf_idc_vdev_mtu_event(vport->vdev_info,
+					IDC_RDMA_EVENT_AFTER_MTU_CHANGE);
+
 	return err;
 }
 
-- 
2.42.0


