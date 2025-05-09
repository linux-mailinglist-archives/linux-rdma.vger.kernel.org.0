Return-Path: <linux-rdma+bounces-10234-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7760AB1DB6
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 22:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2A652240F
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 20:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B3425F960;
	Fri,  9 May 2025 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtSXkyg8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6784225F789;
	Fri,  9 May 2025 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821244; cv=none; b=cfp1KP8kFZmcz4EBVv+PtFyHWAf9KvyYol4ecw0rNGI0qqRtPrb+A94oMatLHex/d9i1rVEQUqP2rmrLQhNl7Ew7f7PBYH/CIHzgkpU834wPHXS5e//zk4iK504hZtSIGMwbor/YivOh/mfqwXBi/FSyH9A7HTkRlPtZ6Z/qzVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821244; c=relaxed/simple;
	bh=/eMys4wvH60G3cd94ScBWWoyNbLHd8rBXb3Yl2B5qAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1fYvX0AEqHsroAd2U/2eqhP2zKQSiz8VuRN1F27De0Oc8QflXB2/x4U32SuIgw4pHWKgLXMl5MwFzZ7Mg/8i4WhcNowOyG9bLBn58Oyh2ztvXuB0uA7b0qGuTyuAPIuWqX/iFHWkL3hPc5zwNEQVuyg7ZkC8n4zUoHfAkU4U60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtSXkyg8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746821242; x=1778357242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/eMys4wvH60G3cd94ScBWWoyNbLHd8rBXb3Yl2B5qAQ=;
  b=WtSXkyg85CVloYBiBeZL3EcGjz8yU0n/yffumyzBe8ZgmiSF66WJYNJa
   wro6wlQ4pEOpPKY9ANvTK61fHunvZ7YjPPcEttfK3zfQ8KBfzRjmp+y1F
   VFvENwkN2ZgmYj3qFkJez9PNciA3pB+B8pbL/osCFqJ2KcyfBs8rkGZ25
   Vk/A+JSSQtKE851U7CXboLdMNOaK8M+2451fkkL2O0HSZut5rFhCRtFXG
   ZVuvs+ftnR7i/0N4X0Q89zsK87RM5XbsbDkJMuREbSUvPOh2u+kmtxKxt
   nlBBGRJ+ExggUYmzD6gQbbzWh/MmcK0DDi6vefuXulStxtOU5OfZEI0Z9
   w==;
X-CSE-ConnectionGUID: lJJrmPaDRVmCoSao1+XFaQ==
X-CSE-MsgGUID: F+IiiebSTYe6v0O+UjzqHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="36289905"
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="36289905"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 13:07:19 -0700
X-CSE-ConnectionGUID: 6Hnt3M0/TO6FgOEY/zVtcQ==
X-CSE-MsgGUID: UAYvK1wHS/KWqv2Kp3RhDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="140780380"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 09 May 2025 13:07:19 -0700
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
Cc: Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	anthony.l.nguyen@intel.com,
	david.m.ertman@intel.com,
	przemyslaw.kitszel@intel.com,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next,rdma-next v2 4/5] ice: Replace ice specific DSCP mapping num with a kernel define
Date: Fri,  9 May 2025 13:07:10 -0700
Message-ID: <20250509200712.2911060-5-anthony.l.nguyen@intel.com>
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

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

Replace ice driver specific DSCP mapping number defines
ICE_DSCP_NUM_VAL and IIDC_MAX_DSCP_MAPPING with
an equivalent kernel define DSCP_MAX.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
index d55107077d8c..4421ba024396 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -225,7 +225,7 @@ void ice_get_qos_params(struct ice_pf *pf, struct iidc_rdma_qos_params *qos)
 
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
2.47.1


