Return-Path: <linux-rdma+bounces-10232-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEFDAB1DB4
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 22:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE609522409
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 20:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D42B25F7A0;
	Fri,  9 May 2025 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAktZK2U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C222025EF9B;
	Fri,  9 May 2025 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821243; cv=none; b=uzMLlh2Qpp9ROWZRDvUd3P/RNZGZGuJVFWxOO1GZ51Psqw7GTH4c7nEcY6X3eYlb760orTcN/uy5arKGR0XN/QhLOCnAChfIRkeiuANtzWDOEusFqAFQkVCYHh+s1TJBQy8u4i7SziDobl+ST/XtrXssZpOqLM13nzdEjXX6AUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821243; c=relaxed/simple;
	bh=lc8C60zK/6uOc10isNQBRIzs7/iW2MxTNBhxRn6eFTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmbGdNv+ONfl3gRk2jKMcxgmc1S9nK1GqKSfFgo6Q15/f0DoPV1dfYGWNcKFmxIUPqKfuQQazV1tycsvsc3TMjF/QGsoUjAyAyJaGD8k+t/e1uw36nxCWfIBmEu+kw0IzvXWhM0V/uFZQWJFzl4NtP9pUZ5iDASu0z65L8pT0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAktZK2U; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746821242; x=1778357242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lc8C60zK/6uOc10isNQBRIzs7/iW2MxTNBhxRn6eFTQ=;
  b=VAktZK2UA6YJtQn+U+JG1g3I1NrIGMx9bvKYX6iBKgm4SVqjL9jOcv6A
   dP8yfcguxlbdmtnSB3B8Z3qDlMRzD6Ts3o8TSBS2fQOB/sNvxmi9FlXik
   SyKJO2zkxEQKzp6bNLkKBvlbcXd4guHCrkjVLbJMg+Aq8Z2H+ODjIK8jn
   EVkRo8gVRk3bk3erGVqrvUz8SkxA6oftO3pOInOy/G987RkIQm8R52Jup
   vau14fz6rTGMYD2lLQCZOT5fek6x0KKSGZxfZJjRkAOLA2ET4fs9u9D4f
   eG83yV0yeiBe9AZIxXEPI2GXMjFUqFnt75Ccxfv/aSxqUp2TrGZezzVpY
   w==;
X-CSE-ConnectionGUID: 3RPNyMTERPyjK3ydWZsTzA==
X-CSE-MsgGUID: 8SAdcno5Q82imgrXYchp8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="36289898"
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="36289898"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 13:07:19 -0700
X-CSE-ConnectionGUID: c/hlbY5NT/6tGmx/xwRPeQ==
X-CSE-MsgGUID: Wefxhl08Rr6lN7DRrv6RIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="140780377"
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
Subject: [PATCH net-next,rdma-next v2 3/5] iidc/ice/irdma: Break iidc.h into two headers
Date: Fri,  9 May 2025 13:07:09 -0700
Message-ID: <20250509200712.2911060-4-anthony.l.nguyen@intel.com>
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


