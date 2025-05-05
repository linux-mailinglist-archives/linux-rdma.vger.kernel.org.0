Return-Path: <linux-rdma+bounces-9980-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AF5AA9DF0
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 23:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C9477AA1F5
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 21:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA272741B2;
	Mon,  5 May 2025 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jS19yCgd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3F026F464;
	Mon,  5 May 2025 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480059; cv=none; b=L3XjhsDJ6wqZ5PMA71sd//U5EWFUKMG0RzBt6Ktu3AuHk+CpK7ard2gWAI/snYtNk79i867JUczDqq+ZfkYAStRDwbXGNBWpRydRTL37xPUGEqKl/CZPZdT1PJW0gTlnRuFm7m97pk5F7j+2pE0MAyRruHMwGEDCNN7/REj4mqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480059; c=relaxed/simple;
	bh=pb2G53y0M+2YP50zd/KF3FZvGntFG6pGoNtUI5qFowY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeNqfnsGlRRCw6mBFU/Po5S+evYmkOe7XB/L+Owwkh3l/Xzjb1/sIpZcgy1LVQ8FIa9epuzQwfU41SKFNso9TQtyYt2jU6vQOdISCDgiNIAbvEfPxWfOCqufCX8yQ7GEnUqvPu+jz5a18LMJ25051OgrvAtGFuE53C+vdWD8NuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jS19yCgd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746480058; x=1778016058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pb2G53y0M+2YP50zd/KF3FZvGntFG6pGoNtUI5qFowY=;
  b=jS19yCgdkxXdBQ6nJfrLPt5BciE77xf8FOdLWXC+Arbm5EWBOpYht1vo
   nISxwUL7NEVzaBEVFx/MJjWfQlb3wlcY1nfRn/UVNxOZBEWIVwToYAIa1
   IjjwBUT2oT1JFgidr+sydQDhXeODVKOcZmPDeuKawj6Hst8W5icOeSxax
   exCUHAbFYsPIYrG04jSfTQG277x3k2TGHJcLJeL2D3CQavFUj7KhGppcA
   LkAh+vp1TNFCSPyQdwSf8KeCcbT/KAokWOo6TtVNboG4cu0lQWvebsnUV
   M3iL3/Hx/r/Qfs5CicbT168neGrdqDqjedk2Q0QY+jpcK7cM0WGvjAr/O
   w==;
X-CSE-ConnectionGUID: DG3547qxRG+Rv2QK2/0G5g==
X-CSE-MsgGUID: NUbrjpR5TWOooLezbF3u6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="51762221"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="51762221"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 14:20:54 -0700
X-CSE-ConnectionGUID: JRWBh6m1Tt2wHDaqrDxVDg==
X-CSE-MsgGUID: yrDnFg8wQIqCYCj6JgkaTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="140352870"
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
Subject: [PATCH net-next,rdma-next 1/5] iidc/ice/irdma: Rename IDC header file
Date: Mon,  5 May 2025 14:20:30 -0700
Message-ID: <20250505212037.2092288-2-anthony.l.nguyen@intel.com>
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

To prepare for the IDC upgrade to support different CORE
PCI drivers, rename header file from iidc.h to iidc_rdma.h
since this files functionality is specifically for RDMA support.

Use net/dscp.h include in irdma osdep.h and DSCP_MAX type.h,
instead of iidc header and define.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 MAINTAINERS                                     | 2 +-
 drivers/infiniband/hw/irdma/main.h              | 2 +-
 drivers/infiniband/hw/irdma/osdep.h             | 2 +-
 drivers/infiniband/hw/irdma/type.h              | 4 ++--
 drivers/net/ethernet/intel/ice/ice_idc_int.h    | 2 +-
 include/linux/net/intel/{iidc.h => iidc_rdma.h} | 6 +++---
 6 files changed, 9 insertions(+), 9 deletions(-)
 rename include/linux/net/intel/{iidc.h => iidc_rdma.h} (97%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..136309587791 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11890,7 +11890,7 @@ F:	Documentation/networking/device_drivers/ethernet/intel/
 F:	drivers/net/ethernet/intel/
 F:	drivers/net/ethernet/intel/*/
 F:	include/linux/avf/virtchnl.h
-F:	include/linux/net/intel/iidc.h
+F:	include/linux/net/intel/*/
 
 INTEL ETHERNET PROTOCOL DRIVER FOR RDMA
 M:	Mustafa Ismail <mustafa.ismail@intel.com>
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index bb0b6494ccb2..e8083b0c8cb2 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -29,7 +29,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #endif
 #include <linux/auxiliary_bus.h>
-#include <linux/net/intel/iidc.h>
+#include <linux/net/intel/iidc_rdma.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_pack.h>
diff --git a/drivers/infiniband/hw/irdma/osdep.h b/drivers/infiniband/hw/irdma/osdep.h
index 4b4f78288d12..3f73ceacccb6 100644
--- a/drivers/infiniband/hw/irdma/osdep.h
+++ b/drivers/infiniband/hw/irdma/osdep.h
@@ -5,8 +5,8 @@
 
 #include <linux/pci.h>
 #include <linux/bitfield.h>
-#include <linux/net/intel/iidc.h>
 #include <rdma/ib_verbs.h>
+#include <net/dscp.h>
 
 #define STATS_TIMER_DELAY	60000
 
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 59b34afa867b..527c6da2c1ac 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -567,7 +567,7 @@ struct irdma_sc_vsi {
 	u8 qos_rel_bw;
 	u8 qos_prio_type;
 	u8 stats_idx;
-	u8 dscp_map[IIDC_MAX_DSCP_MAPPING];
+	u8 dscp_map[DSCP_MAX];
 	struct irdma_qos qos[IRDMA_MAX_USER_PRIORITY];
 	u64 hw_stats_regs[IRDMA_HW_STAT_INDEX_MAX_GEN_1];
 	bool dscp_mode:1;
@@ -695,7 +695,7 @@ struct irdma_l2params {
 	u16 qs_handle_list[IRDMA_MAX_USER_PRIORITY];
 	u16 mtu;
 	u8 up2tc[IRDMA_MAX_USER_PRIORITY];
-	u8 dscp_map[IIDC_MAX_DSCP_MAPPING];
+	u8 dscp_map[DSCP_MAX];
 	u8 num_tc;
 	u8 vsi_rel_bw;
 	u8 vsi_prio_type;
diff --git a/drivers/net/ethernet/intel/ice/ice_idc_int.h b/drivers/net/ethernet/intel/ice/ice_idc_int.h
index 4b0c86757df9..b0c504a6408e 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc_int.h
+++ b/drivers/net/ethernet/intel/ice/ice_idc_int.h
@@ -4,7 +4,7 @@
 #ifndef _ICE_IDC_INT_H_
 #define _ICE_IDC_INT_H_
 
-#include <linux/net/intel/iidc.h>
+#include <linux/net/intel/iidc_rdma.h>
 
 struct ice_pf;
 
diff --git a/include/linux/net/intel/iidc.h b/include/linux/net/intel/iidc_rdma.h
similarity index 97%
rename from include/linux/net/intel/iidc.h
rename to include/linux/net/intel/iidc_rdma.h
index 13274c3def66..0cd75404e459 100644
--- a/include/linux/net/intel/iidc.h
+++ b/include/linux/net/intel/iidc_rdma.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2021, Intel Corporation. */
 
-#ifndef _IIDC_H_
-#define _IIDC_H_
+#ifndef _IIDC_RDMA_H_
+#define _IIDC_RDMA_H_
 
 #include <linux/auxiliary_bus.h>
 #include <linux/dcbnl.h>
@@ -106,4 +106,4 @@ struct iidc_auxiliary_drv {
 	void (*event_handler)(struct ice_pf *pf, struct iidc_event *event);
 };
 
-#endif /* _IIDC_H_*/
+#endif /* _IIDC_RDMA_H_*/
-- 
2.47.1


