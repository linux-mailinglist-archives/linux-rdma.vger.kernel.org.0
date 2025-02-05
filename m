Return-Path: <linux-rdma+bounces-7468-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EE0A2998E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 19:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551A7169A01
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 18:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57E820E701;
	Wed,  5 Feb 2025 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYTL1W9A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD5B209F5B;
	Wed,  5 Feb 2025 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781732; cv=none; b=dnT/RtVnm0ropLDiwOsBI/Aj8QEnQbuz1STn5VFFNHa7uqGtKOvoejnVVh9YLoj3nDTuOtKVI7TbInRtq6x0ZIJhsta5MGdMjwZqkEljZI6xGdRyru3ngsW9McWTQPfRWsbHOnX51ytA/+pd8YqtMltiaWMo/Uug1k7Cods7Pis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781732; c=relaxed/simple;
	bh=LvHs5uq24Yngv0rD+Cesc7LzG3YHnTu1pn7DdIO/yjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jV/3ML1LcdOp7uOOADV+hFQuABwbAlQrns1nOQl6wcAlhgGpaay4ipXGW262gJLsTIm7kcMCzxbRtkn0mfXD24Sdwm5KYpwGbV/E4ICbb/wNBFfTCYsl2e2p2qweIGJVGyHizVoO+/eGEE26QdD8bLH69uLXObeP0qyH2bowlfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYTL1W9A; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738781731; x=1770317731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LvHs5uq24Yngv0rD+Cesc7LzG3YHnTu1pn7DdIO/yjk=;
  b=EYTL1W9A8Vx8ZgIWPSA45iaDKLpYzpC2H3rsaxPwNl6+XemFRlldPLl0
   C6khjF2sjjH31tpTA0DG0quApYFXcecDfxQpV7tCDInaB9JtHP9bLG3vG
   UZoU43a4Dzx1czyJWFFzvl/gQ/SbDP9/B0iuASJs81TfZt6f9k5WEpbiC
   FOovkYgRu1PSValHK6iKXU57PqMVRiyv04l4Iqki6OCFG4UjPPcu4prix
   s1MzMPa5RMMAVKc+uYuwvttljPnIdvFOvzxOp0Inf8i5v2kzAmgx+TR0W
   LNowEw0BPxZdjUDPX9EWTEzFJM6vWwP2uYHM8+K2RnOKMc394wplo8NhY
   A==;
X-CSE-ConnectionGUID: CPOtA2u2Tqyfcs39g/haCQ==
X-CSE-MsgGUID: JebawcijQra7JD13rGjg2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="61834497"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="61834497"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 10:55:31 -0800
X-CSE-ConnectionGUID: tgyE2QUZSo2gnGzPtuKIuA==
X-CSE-MsgGUID: him+2K1TRzS5bGr7roJ12Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="111515309"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 05 Feb 2025 10:55:29 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pio.raczynski@gmail.com,
	konrad.knitter@intel.com,
	marcin.szycik@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Laight@ACULAB.COM,
	pmenzel@molgen.mpg.de,
	mschmidt@redhat.com,
	tatyana.e.nikolova@intel.com,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Jan Sokolowski <jan.sokolowski@intel.com>
Subject: [PATCH net-next v2 7/9] ice: enable_rdma devlink param
Date: Wed,  5 Feb 2025 10:55:07 -0800
Message-ID: <20250205185512.895887-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250205185512.895887-1-anthony.l.nguyen@intel.com>
References: <20250205185512.895887-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Implement enable_rdma devlink parameter to allow user to turn RDMA
feature on and off.

It is useful when there is no enough interrupts and user doesn't need
RDMA feature.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 21 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.c      |  8 ++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 81de5fbc130e..504aaf4b8855 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1576,6 +1576,19 @@ ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int ice_devlink_enable_rdma_validate(struct devlink *devlink, u32 id,
+					    union devlink_param_value val,
+					    struct netlink_ext_ack *extack)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+	bool new_state = val.vbool;
+
+	if (new_state && !test_bit(ICE_FLAG_RDMA_ENA, pf->flags))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 enum ice_param_id {
 	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
@@ -1591,6 +1604,8 @@ static const struct devlink_param ice_dvl_rdma_params[] = {
 			      ice_devlink_enable_iw_get,
 			      ice_devlink_enable_iw_set,
 			      ice_devlink_enable_iw_validate),
+	DEVLINK_PARAM_GENERIC(ENABLE_RDMA, BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
+			      NULL, NULL, ice_devlink_enable_rdma_validate),
 };
 
 static const struct devlink_param ice_dvl_msix_params[] = {
@@ -1731,6 +1746,12 @@ int ice_devlink_register_params(struct ice_pf *pf)
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
 					value);
+
+	value.vbool = test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
+	devl_param_driverinit_value_set(devlink,
+					DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
+					value);
+
 	return 0;
 
 unregister_msix_params:
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 1827f1f20ce8..16c419809849 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -833,7 +833,13 @@ bool ice_is_safe_mode(struct ice_pf *pf)
  */
 bool ice_is_rdma_ena(struct ice_pf *pf)
 {
-	return test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
+	union devlink_param_value value;
+	int err;
+
+	err = devl_param_driverinit_value_get(priv_to_devlink(pf),
+					      DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
+					      &value);
+	return err ? test_bit(ICE_FLAG_RDMA_ENA, pf->flags) : value.vbool;
 }
 
 /**
-- 
2.47.1


