Return-Path: <linux-rdma+bounces-3957-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EA493B984
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 01:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9AD3B23636
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 23:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7129C147C82;
	Wed, 24 Jul 2024 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O71hxf8x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCBD1448EF
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864443; cv=none; b=EQcWNDzghEAQwN0Y2lYmG7cJCUrYP71YDSsBNhmt7Xiws0zhMz1h/eml6BDv+S2QZunj2GoPVimN6LdB0JtSVs1vp58tHP1hbV9e7RfAn3iPTQ4reRWLurqQXficpbJFT/PCSzEvIAsxMui3w1VjUNSl/z+QElOCXDhDjHHdDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864443; c=relaxed/simple;
	bh=wWfecCuykLAnG/JpTZs4+0+xCzJ5Fqfh/KSmhqZwg3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lRsDipXvEFmmPk+0ujiQNpCcd4AqZVF4sbwZftL0akdvSDRi1LnIm6N7659BnI3d47w+jE3s7C9VN8JTcSCs1oraVFsu/Or5u0/yCdozOOdcMe/elNW7FJo7sM+l5UZm+GAYzOh9sq8yVAzq622kxOg0qa+0grk37jjJeXVTGo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O71hxf8x; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721864442; x=1753400442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wWfecCuykLAnG/JpTZs4+0+xCzJ5Fqfh/KSmhqZwg3s=;
  b=O71hxf8xwp1Zb1QuPRrUkJEziCYrQeCNAutnNl32DOBZabb5srfPr/TZ
   I8QSoPgmGj4oGlki3t9pnN6kPnTz6gtSzJrHrmgMiQ3rHCEO+SeaCytDn
   xvy5r+mW6iF/AhO0HAgisxRpyujPZ9hmDVMADevvyFV96PiwGm5Rnp+bD
   M3HWLC2byJbIeXbUXqRqIW9uWN7b6JzfIXvuQGc+V6rYJBUL4IE3xm63u
   CuMzJfg5cfDhcArVayM0HF394exvZtiuZHyB4EkBRsYJbHmBBBy/xkQkv
   1UJw3qf60i1IrFtdn7YmyYSEW6YBQil2nCn70gNZHjWpMDy0/kW/5I6hL
   A==;
X-CSE-ConnectionGUID: 1vr4zR01RQ2sVLonykCDhw==
X-CSE-MsgGUID: /xNLsjgrReeUXWuT0HXQaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="44999757"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="44999757"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:39 -0700
X-CSE-ConnectionGUID: xLWN3TkuSiOHY6jZ4mjnzA==
X-CSE-MsgGUID: MHtrrj6aQueHkeDosWY/xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52426030"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.96.138])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:38 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	mustafa.ismail@intel.com,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC PATCH 08/25] idpf: implement idc vport aux driver mtu change handler
Date: Wed, 24 Jul 2024 18:39:00 -0500
Message-Id: <20240724233917.704-9-tatyana.e.nikolova@intel.com>
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

The only event an rdma vport aux driver cares about right now is an MTU
change on its underlying vport. Implement and plumb the handler to
signal the pre MTU change event and post MTU change events to the rdma
vport aux driver.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h     |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 31 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 11 ++++++++---
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 0e3e7000..8ab4b935 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -869,5 +869,7 @@ int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
 void idpf_idc_deinit_core_aux_device(struct idc_rdma_core_dev_info *cdev_info);
 void idpf_idc_deinit_vport_aux_device(struct idc_rdma_vport_dev_info *vdev_info);
 void idpf_idc_issue_reset_event(struct idc_rdma_core_dev_info *cdev_info);
+void idpf_idc_vdev_mtu_event(struct idc_rdma_vport_dev_info *vdev_info,
+			     enum idc_rdma_event_type event_type);
 
 #endif /* !_IDPF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 24ab9a4..b87a72b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -134,6 +134,37 @@ static int idpf_idc_init_aux_vport_dev(struct idpf_vport *vport)
 }
 
 /**
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
+/**
  * idpf_core_adev_release - function to be mapped to aux dev's release op
  * @dev: pointer to device to free
  */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 237cc04..8124aa8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1941,6 +1941,8 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		idpf_vport_calc_num_q_desc(new_vport);
 		break;
 	case IDPF_SR_MTU_CHANGE:
+		idpf_idc_vdev_mtu_event(vport->vdev_info,
+					IDC_RDMA_EVENT_BEFORE_MTU_CHANGE);
 	case IDPF_SR_RSC_CHANGE:
 		break;
 	default:
@@ -1952,6 +1954,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	err = idpf_vport_queues_alloc(new_vport);
 	if (err)
 		goto free_vport;
+
 	if (current_state <= __IDPF_VPORT_DOWN) {
 		idpf_send_delete_queues_msg(vport);
 	} else {
@@ -2028,15 +2031,17 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
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
1.8.3.1


