Return-Path: <linux-rdma+bounces-9466-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D82A8AE0C
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 04:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FF74439ED
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 02:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDE8227E9E;
	Wed, 16 Apr 2025 02:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWN3T6QS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008101A9B2B;
	Wed, 16 Apr 2025 02:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769776; cv=none; b=VbFCDzfJENROeWCVEHqXd1/1a7l4nHLND+ttWkx6Tdrr6j9kai+bSS3tDe/QAdpbA2wNOjG22B/ZCBSgsT2wygiKhxMGdrGiZeFPLGp4dq97ClX4v1zMHVl093uEuUZxknKPTDDQlWd+Mm28K69lcOQPh8cc6iKXH2L2dhwamfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769776; c=relaxed/simple;
	bh=38QObsG1g5kTMVujaR6jCjNzuQOn53n3e/9p1HGrddA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMmfMMkGfprbje2an7+4GBcD+S4UAA78Cnh7KJxf0RPytWlI4VRnA2hRoxB+BWgnCS8KcR1uvxXji4KYhj7YGF0Ovd4OmISyuriIci5NBy7WSoTwWoY1vAw0caL4I5kYglPE+4dDmkkDbSyAA7gzI+xMjueQa+ltJle7xwH3a04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWN3T6QS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744769775; x=1776305775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=38QObsG1g5kTMVujaR6jCjNzuQOn53n3e/9p1HGrddA=;
  b=mWN3T6QSjEKgaf5RLo+OFH66c1wcb/lkDGNdjp3w5KutqpsMsTL/t3eN
   g+M8g8thH9+MNRmRb3iZ9LlweH1UEN5RD5g7u4HviHC0pMrOXjImdhasI
   iSENnDjz5osNOgUvTiyuEKJlRFM10h3az7715SUj28zgxBzxSVzEvGXMS
   MmercjNwhZNKcGsC+jowq1NW1qcdzJy1VVZpSZU/6zJAo84iKWQiAsdEC
   ldTcmLOe4NG25bP/xeYorz/1OiHrdjKDTXZIhAiVzwwblITte87vhUZl3
   qr4YR9PmfKtqJ3aThX8oYDDDkg1hKYwy9iRw0/tDxEGg/JbJYtNbj5krv
   Q==;
X-CSE-ConnectionGUID: N3Z8HKETSUSVzyQoc4N76g==
X-CSE-MsgGUID: PXosvYkBS6y4ZJBO2FFHlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="50125567"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="50125567"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 19:16:13 -0700
X-CSE-ConnectionGUID: iv0vCAbwQn6kCUT7sZ91vQ==
X-CSE-MsgGUID: 3tgeltZvQFKKS0i/9YhNxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="130605800"
Received: from bnkannan-mobl1.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.114.218])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 19:16:13 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [iwl-next v5 4/5] ice: Replace ice specific DSCP mapping num with a kernel define
Date: Tue, 15 Apr 2025 21:15:48 -0500
Message-ID: <20250416021549.606-5-tatyana.e.nikolova@intel.com>
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

Replace ice driver specific DSCP mapping number defines
ICE_DSCP_NUM_VAL and IIDC_MAX_DSCP_MAPPING with
an equivalent kernel define DSCP_MAX.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb.c    | 2 +-
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 4 ++--
 drivers/net/ethernet/intel/ice/ice_idc.c    | 2 +-
 drivers/net/ethernet/intel/ice/ice_type.h   | 6 +++---
 include/linux/net/intel/iidc_rdma.h         | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
index 74418c445cc4..64737fc62306 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -1288,7 +1288,7 @@ ice_add_dscp_up_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
 	tlv->ouisubtype = htonl(ouisubtype);
 
 	/* bytes 0 - 63 - IPv4 DSCP2UP LUT */
-	for (i = 0; i < ICE_DSCP_NUM_VAL; i++) {
+	for (i = 0; i < DSCP_MAX; i++) {
 		/* IPv4 mapping */
 		buf[i] = dcbcfg->dscp_map[i];
 		/* IPv6 mapping */
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index 6d50b90a7359..a10c1c8d8697 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -754,7 +754,7 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
 	if (!ice_is_feature_supported(pf, ICE_F_DSCP))
 		return -EOPNOTSUPP;
 
-	if (app->protocol >= ICE_DSCP_NUM_VAL) {
+	if (app->protocol >= DSCP_MAX) {
 		netdev_err(netdev, "DSCP value 0x%04X out of range\n",
 			   app->protocol);
 		return -EINVAL;
@@ -931,7 +931,7 @@ static int ice_dcbnl_delapp(struct net_device *netdev, struct dcb_app *app)
 	/* if the last DSCP mapping just got deleted, need to switch
 	 * to L2 VLAN QoS mode
 	 */
-	if (bitmap_empty(new_cfg->dscp_mapped, ICE_DSCP_NUM_VAL) &&
+	if (bitmap_empty(new_cfg->dscp_mapped, DSCP_MAX) &&
 	    new_cfg->pfc_mode == ICE_QOS_MODE_DSCP) {
 		ret = ice_aq_set_pfc_mode(&pf->hw,
 					  ICE_AQC_PFC_VLAN_BASED_PFC,
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 3f678426b7c9..0a19200000ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -224,7 +224,7 @@ void ice_get_qos_params(struct ice_pf *pf, struct iidc_rdma_qos_params *qos)
 
 	qos->pfc_mode = dcbx_cfg->pfc_mode;
 	if (qos->pfc_mode == IIDC_DSCP_PFC_MODE)
-		for (i = 0; i < IIDC_MAX_DSCP_MAPPING; i++)
+		for (i = 0; i < DSCP_MAX; i++)
 			qos->dscp_map[i] = dcbx_cfg->dscp_map[i];
 }
 EXPORT_SYMBOL_GPL(ice_get_qos_params);
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 0aab21113cc4..529f978ea45a 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -19,6 +19,7 @@
 #include "ice_vlan_mode.h"
 #include "ice_fwlog.h"
 #include <linux/wait.h>
+#include <net/dscp.h>
 
 static inline bool ice_is_tc_ena(unsigned long bitmap, u8 tc)
 {
@@ -695,7 +696,6 @@ struct ice_dcb_app_priority_table {
 
 #define ICE_MAX_USER_PRIORITY	8
 #define ICE_DCBX_MAX_APPS	64
-#define ICE_DSCP_NUM_VAL	64
 #define ICE_LLDPDU_SIZE		1500
 #define ICE_TLV_STATUS_OPER	0x1
 #define ICE_TLV_STATUS_SYNC	0x2
@@ -718,9 +718,9 @@ struct ice_dcbx_cfg {
 	u8 pfc_mode;
 	struct ice_dcb_app_priority_table app[ICE_DCBX_MAX_APPS];
 	/* when DSCP mapping defined by user set its bit to 1 */
-	DECLARE_BITMAP(dscp_mapped, ICE_DSCP_NUM_VAL);
+	DECLARE_BITMAP(dscp_mapped, DSCP_MAX);
 	/* array holding DSCP -> UP/TC values for DSCP L3 QoS mode */
-	u8 dscp_map[ICE_DSCP_NUM_VAL];
+	u8 dscp_map[DSCP_MAX];
 	u8 dcbx_mode;
 #define ICE_DCBX_MODE_CEE	0x1
 #define ICE_DCBX_MODE_IEEE	0x2
diff --git a/include/linux/net/intel/iidc_rdma.h b/include/linux/net/intel/iidc_rdma.h
index 1e8136395154..7f1910289534 100644
--- a/include/linux/net/intel/iidc_rdma.h
+++ b/include/linux/net/intel/iidc_rdma.h
@@ -10,6 +10,7 @@
 #include <linux/if_ether.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
+#include <net/dscp.h>
 
 enum iidc_rdma_event_type {
 	IIDC_RDMA_EVENT_BEFORE_MTU_CHANGE,
@@ -32,7 +33,6 @@ enum iidc_rdma_protocol {
 };
 
 #define IIDC_MAX_USER_PRIORITY		8
-#define IIDC_MAX_DSCP_MAPPING		64
 #define IIDC_DSCP_PFC_MODE		0x1
 
 /* Struct to hold per RDMA Qset info */
@@ -63,7 +63,7 @@ struct iidc_rdma_qos_params {
 	u8 vport_priority_type;
 	u8 num_tc;
 	u8 pfc_mode;
-	u8 dscp_map[IIDC_MAX_DSCP_MAPPING];
+	u8 dscp_map[DSCP_MAX];
 };
 
 struct iidc_rdma_event {
-- 
2.37.3


