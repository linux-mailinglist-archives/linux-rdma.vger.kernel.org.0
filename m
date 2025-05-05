Return-Path: <linux-rdma+bounces-9981-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78C0AA9DF4
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 23:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354A93A46C8
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 21:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB1274650;
	Mon,  5 May 2025 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEkWDyDN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691B4270EA2;
	Mon,  5 May 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480060; cv=none; b=NsgRC/g7yWZPxA6NePz0AlPTcTSE02VXzhQ6UAHEliGJpzfFQblWM8HzHEvavSDFWnUP1JZmUiMICf0efML1MATqAHzQWuM5UoaK96WomoLDnlXlXESHC1Zdz6ye6JgSm2HiGSMPrTc4EVSBjO8qF5uRsSGLmCSL436wz6s6cdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480060; c=relaxed/simple;
	bh=lc8C60zK/6uOc10isNQBRIzs7/iW2MxTNBhxRn6eFTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnCQ2ukVPk3o9nyMtZ0tlwqsqhBqaltIXZLOYVWX4dre9dFuu9k7ZdNO1Cf0wZk4tRDoo4Y714twPAV9NM36WQWuuaJPLuGohD1eHMWaFKnpb8q8E2d2BfhKCmfdXsscaUjcNwzu3mf8Kk7vDg0xaD+WWbTiQY3C32p+RaE3Eug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iEkWDyDN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746480058; x=1778016058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lc8C60zK/6uOc10isNQBRIzs7/iW2MxTNBhxRn6eFTQ=;
  b=iEkWDyDNoFsE+swe4RMcBsObS/Z94YrBe8w0r2KbDAT7LiLxWVW1BQx1
   FuMzYlNXuLvG4G/LnWUhK9BXZrkpQIXzKF4BWQ9Yk8qtJR5uto38ndb8C
   34F2IO3AeTlcRtJXFPhLpoJVWLz37IgMaJxI6HPxXGBFJO2T34ZN5HHu3
   O7VXm0tQdHumAArY51BeesPX5s/ZsYGOQIuzr8GdjUgoMqIzbj1REtCU4
   PKbHQDBUVLw/IxG+Ej4wEMsI4hM2yAIS1ebgO1PsMlNaL2Hu2de20sVuq
   tw+3r8UoLWgbXUzUoBrR/PxeGE9VuwzscY/2dJaCWM1mtoiP4TKqeNUey
   g==;
X-CSE-ConnectionGUID: dTdwaM1mTlavnR5vMr/6AQ==
X-CSE-MsgGUID: beg3nSVHRWGomVuMgXiP+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="51762235"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="51762235"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 14:20:54 -0700
X-CSE-ConnectionGUID: atFxQbq0RsSWXJef7wbUuA==
X-CSE-MsgGUID: jbJKbSW6SKqeLt72/7GXfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="140352876"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 05 May 2025 14:20:53 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	tatyana.e.nikolova@intel.com,
	przemyslaw.kitszel@intel.com
Subject: [PATCH net-next,rdma-next 3/5] iidc/ice/irdma: Break iidc.h into two headers
Date: Mon,  5 May 2025 14:20:32 -0700
Message-ID: <20250505212037.2092288-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505212037.2092288-1-anthony.l.nguyen@intel.com>
References: <20250505212037.2092288-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Ertman <david.m.ertman@intel.com>

In preparation of supporting more than a single core PCI driver
for RDMA, break the iidc_rdma.h header file into two more focused
headers.

Only the elements universal to all Intel drivers will remain in
the generic iidc_rdma.h header. Move the ice specific information
to an ice specific header file named iidc_rdma_ice.h.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_idc_int.h |  1 +
 include/linux/net/intel/iidc_rdma.h          | 14 +-------------
 include/linux/net/intel/iidc_rdma_ice.h      | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/net/intel/iidc_rdma_ice.h

diff --git a/drivers/net/ethernet/intel/ice/ice_idc_int.h b/drivers/net/ethernet/intel/ice/ice_idc_int.h
index 03cd7d8d1aaa..17dbfcfb6a2a 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc_int.h
+++ b/drivers/net/ethernet/intel/ice/ice_idc_int.h
@@ -5,6 +5,7 @@
 #define _ICE_IDC_INT_H_
 
 #include <linux/net/intel/iidc_rdma.h>
+#include <linux/net/intel/iidc_rdma_ice.h>
 
 struct ice_pf;
 
diff --git a/include/linux/net/intel/iidc_rdma.h b/include/linux/net/intel/iidc_rdma.h
index 2b24a9912fa0..1e8136395154 100644
--- a/include/linux/net/intel/iidc_rdma.h
+++ b/include/linux/net/intel/iidc_rdma.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2021, Intel Corporation. */
+/* Copyright (C) 2021-2025, Intel Corporation. */
 
 #ifndef _IIDC_RDMA_H_
 #define _IIDC_RDMA_H_
@@ -71,18 +71,6 @@ struct iidc_rdma_event {
 	u32 reg;
 };
 
-struct ice_pf;
-
-int ice_add_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset);
-int ice_del_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset);
-int ice_rdma_request_reset(struct ice_pf *pf,
-			   enum iidc_rdma_reset_type reset_type);
-int ice_rdma_update_vsi_filter(struct ice_pf *pf, u16 vsi_id, bool enable);
-void ice_get_qos_params(struct ice_pf *pf,
-			struct iidc_rdma_qos_params *qos);
-int ice_alloc_rdma_qvector(struct ice_pf *pf, struct msix_entry *entry);
-void ice_free_rdma_qvector(struct ice_pf *pf, struct msix_entry *entry);
-
 /* Structure representing auxiliary driver tailored information about the core
  * PCI dev, each auxiliary driver using the IIDC interface will have an
  * instance of this struct dedicated to it.
diff --git a/include/linux/net/intel/iidc_rdma_ice.h b/include/linux/net/intel/iidc_rdma_ice.h
new file mode 100644
index 000000000000..78d10003d776
--- /dev/null
+++ b/include/linux/net/intel/iidc_rdma_ice.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Intel Corporation. */
+
+#ifndef _IIDC_RDMA_ICE_H_
+#define _IIDC_RDMA_ICE_H_
+
+struct ice_pf;
+
+int ice_add_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset);
+int ice_del_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset);
+int ice_rdma_request_reset(struct ice_pf *pf,
+			   enum iidc_rdma_reset_type reset_type);
+int ice_rdma_update_vsi_filter(struct ice_pf *pf, u16 vsi_id, bool enable);
+void ice_get_qos_params(struct ice_pf *pf,
+			struct iidc_rdma_qos_params *qos);
+int ice_alloc_rdma_qvector(struct ice_pf *pf, struct msix_entry *entry);
+void ice_free_rdma_qvector(struct ice_pf *pf, struct msix_entry *entry);
+
+#endif /* _IIDC_RDMA_ICE_H_*/
-- 
2.47.1


