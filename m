Return-Path: <linux-rdma+bounces-9465-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8C1A8AE0A
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 04:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAC53B533B
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 02:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68053227BA1;
	Wed, 16 Apr 2025 02:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Las0IuSl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC91922FD;
	Wed, 16 Apr 2025 02:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769776; cv=none; b=qvQOvyWmoSZ6eaB9/8iGX3UCgKb6GjMVXhuh33WSpskmcP4Z5QIOr79cgiMbQ4+jHb0sCe/UYImGfLEmkmPqx3ObBJAZeSpPKAYF13800tGeyBhvAYEIy0VlpWORUkA+8KsjS2dj4JMgKbIKDsYYT2rbIZgxbWGB9+a8Tb6T0+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769776; c=relaxed/simple;
	bh=Eugl+iwPYiUbcjjg4YiJWs7t0iy+ISFbBlQ++IkUipA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8Iqz8MhvmJrjwo8BikEmVLpWEcEQsUAaPh5Ak4e0a+Phet1u9988Ft6Qgcbrwakkhv6WWnEzyyL8+4biXPDOZXlIQmeibdBcjlbrFPPLQSi02LHn6jihf9TuW6csBdvtvZ/PLBBUHEXYH56b3GO8lY/aCISEYk0xeHl4ZXtSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Las0IuSl; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744769774; x=1776305774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eugl+iwPYiUbcjjg4YiJWs7t0iy+ISFbBlQ++IkUipA=;
  b=Las0IuSlCRisLLw0aKpP9a1XpVrGeDj1SIKbsy4EFcq2m1ctMtSOIKd4
   nuZJ7Z8URk0khFprdgkwbsV7HXNQNf+ytw5of1SB2osLLFR9P7JO94PYp
   zFXSnZgqOxHIu5KhwWF2ZImKvgMOhFWNdXhZyc8iFscvAlrLkDcCGB8pw
   pG5l7y+UI4Yl7s8imknMaSG6RpNVWEqOzBCB1Iue434iiyiWa6yOSnb0G
   ZV6FvaMeq8jqulLfStn9uskVrKuk7T0vNQ20LUtE/+7FZRvdnIw1B8DIc
   Jkqz1qxdbpdXRzdQECnz7xzZBNrxEpyie7CDmbZNMrSQn9ENUQert20qI
   Q==;
X-CSE-ConnectionGUID: VEHE5xfOQsOJWrivnCJ3Mw==
X-CSE-MsgGUID: JJeaXt8ZQ4Cj9p68WEKhNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="50125563"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="50125563"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 19:16:13 -0700
X-CSE-ConnectionGUID: ta8xRsepS8+ybMA18p2GKg==
X-CSE-MsgGUID: Gz1cvMVzSwyfS92iPYvYQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="130605797"
Received: from bnkannan-mobl1.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.114.218])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 19:16:12 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [iwl-next v5 3/5] iidc/ice/irdma: Break iidc.h into two headers
Date: Tue, 15 Apr 2025 21:15:47 -0500
Message-ID: <20250416021549.606-4-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250416021549.606-1-tatyana.e.nikolova@intel.com>
References: <20250416021549.606-1-tatyana.e.nikolova@intel.com>
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
2.37.3


