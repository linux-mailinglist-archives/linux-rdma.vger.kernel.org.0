Return-Path: <linux-rdma+bounces-10230-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 666DEAB1DB2
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 22:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE2A1895316
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 20:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC6C25EFA0;
	Fri,  9 May 2025 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTHCxhv2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399125EF82;
	Fri,  9 May 2025 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821241; cv=none; b=aePy4uMGvSIl/qbV8F4R/NkrVK5JhqXQ/qv8bBSadoxQOSWsZ/5v1lPWf6BsPQd2VuJGE7MVhfn6Dsx7t/yMe5nXqdMnJw7tzp/I2Z8XNFwgFQoeHSNSkmybfWNdoQrMOBqy0Q0fhIokF0KIQOfJPMRsKbGSX2hMYJXSso4hL84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821241; c=relaxed/simple;
	bh=pb2G53y0M+2YP50zd/KF3FZvGntFG6pGoNtUI5qFowY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzH2vsRAvMAIt9up5qHCSBAj3gyk78ip+CYlyEJ5G5Dwr9fPeyLWSRhyWOfFnH+t8UsXPngeuX7yrYbALa2Sl9VdOU8MMxPZJDT5ePbJ/30UmbcVOzr7yrb7jn9QvJdcLtqt4YobIyJT+H4dSexaFhegqm9QztbvZD+zaN+ykr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTHCxhv2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746821240; x=1778357240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pb2G53y0M+2YP50zd/KF3FZvGntFG6pGoNtUI5qFowY=;
  b=FTHCxhv237CuEuCPvWglFyl9Z3ta+7VQ0quOgFkmnd0seKjbBsRiq/fm
   SqF4beBdEAPhJscmkSsFqhZtcVo5TXdxNNcsfxMZ2ypBRwPm8auDu24Za
   iEeRwl9ESA9Bk3xXmUD3CEpnBEnS419P+dhvx1U3tbVp0tg+K/608UG42
   eQpgLhvzN8DYQKnUg5Yv/XvcyBoFYgDi6ar0Q/vYLJmHwgCc7wq6b8T7R
   6WZylCEgxd+2+idqBMAYhPswy20vROZtlmmfUZNw1ov3guo7d0fHrS5g4
   5mMGiT/3OlHKJmA3W1gb//e75APo5ULxGBSABMbO13ajMP5JxkIRmBbqr
   Q==;
X-CSE-ConnectionGUID: sqbzlF7/TBi3TeiBNCoTAw==
X-CSE-MsgGUID: eRIvVDcCQJeZ7bMAYKdB5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="36289884"
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="36289884"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 13:07:18 -0700
X-CSE-ConnectionGUID: lLBuJ30mQemUGGby79vPrA==
X-CSE-MsgGUID: 7vMSJ/JJTqSyZ+HGzeyOlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="140780371"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 09 May 2025 13:07:18 -0700
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
Subject: [PATCH net-next,rdma-next v2 1/5] iidc/ice/irdma: Rename IDC header file
Date: Fri,  9 May 2025 13:07:07 -0700
Message-ID: <20250509200712.2911060-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250509200712.2911060-1-anthony.l.nguyen@intel.com>
References: <20250509200712.2911060-1-anthony.l.nguyen@intel.com>
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


