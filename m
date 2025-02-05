Return-Path: <linux-rdma+bounces-7463-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351EEA29984
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 19:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665BE1883533
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 18:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2621FF7D2;
	Wed,  5 Feb 2025 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YC56Xa0t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D961FECBF;
	Wed,  5 Feb 2025 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781727; cv=none; b=qs1JvIUFdvYqD3rxiSZD4/7cEnl16SLFWqEN681hBlAGW0Vq8G33KuaM2vN0RM3v9GFcXycBaz6JP6CUfRab7i18n0TmHVDwzrJ2qfoJqqEnA7Gzr1ZrT7jb5PZ+aeUzumFA8r33V/JZubcEvFa5w0f2fBJiVZbf52TNvn4zypU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781727; c=relaxed/simple;
	bh=OCyQW4vemfCtneuoZGxNjd2q1o6NN6ACNGwnOzRRSpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INaqVTjlKfRKlM8IoCkNTqYoN2/AyZa65NIBVoCAvnh5u+w5mzEuPEQt6RL4iwez2H8aHxbCwbdHTajQEMTG6Ffjd6dUq0KsDaEJ2FsbMo8gedo/e+XKyvLJ+L0OMdbICQ1+S5UcMCBnCICI/1TBTdKkb5fa0CscLb01hLf+IJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YC56Xa0t; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738781726; x=1770317726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OCyQW4vemfCtneuoZGxNjd2q1o6NN6ACNGwnOzRRSpw=;
  b=YC56Xa0tK+/E4YwjQytFhoFuaBBmexyLJVmQaCVON2OKHgKbL9HNWmhZ
   VSSdJho/BaxawEhSyrnas30eAQohf+ynpWc6gq6B5bUwIMohT0+k4U4dU
   vLPFEioc7yjPAFsDNobGgPWUU9ZxMKyH980bFgwLjMFzw9PsHPDxYsr7F
   4ATJY9Tmj2g5qah7/I5vmbXdw+PDZNuGRxqUQrt5uKlaTQsedY+7wYtbH
   eBOu/wc/ruzZXySbtFlMNSZKTwYGGjQ76IeMsrCGMRcIqhiEq6f2qFfk8
   hseSuBZLqI+JFGf6qGQ1Rx+ESmkvFzOVAGBpDpB2KDcKJL2IhlyXk9rvX
   A==;
X-CSE-ConnectionGUID: iYgzh6tYRC6/QLABXwTukg==
X-CSE-MsgGUID: 6g9f8QElR7yJdSCo3Oubrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="61834415"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="61834415"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 10:55:25 -0800
X-CSE-ConnectionGUID: 3uPCKM6gQCyViJHy92m3FQ==
X-CSE-MsgGUID: zm41Xx62Q+KLfAyFiVo1zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="111515263"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 05 Feb 2025 10:55:23 -0800
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
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2 2/9] ice: devlink PF MSI-X max and min parameter
Date: Wed,  5 Feb 2025 10:55:02 -0800
Message-ID: <20250205185512.895887-3-anthony.l.nguyen@intel.com>
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

Use generic devlink PF MSI-X parameter to allow user to change MSI-X
range.

Add notes about this parameters into ice devlink documentation.

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 Documentation/networking/devlink/ice.rst      | 11 +++
 .../net/ethernet/intel/ice/devlink/devlink.c  | 81 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice.h          |  7 ++
 drivers/net/ethernet/intel/ice/ice_irq.c      |  7 ++
 4 files changed, 106 insertions(+)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index e3972d03cea0..792e9f8c846a 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -69,6 +69,17 @@ Parameters
 
        To verify that value has been set:
        $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
+   * - ``msix_vec_per_pf_max``
+     - driverinit
+     - Set the max MSI-X that can be used by the PF, rest can be utilized for
+       SRIOV. The range is from min value set in msix_vec_per_pf_min to
+       2k/number of ports.
+   * - ``msix_vec_per_pf_min``
+     - driverinit
+     - Set the min MSI-X that will be used by the PF. This value inform how many
+       MSI-X will be allocated statically. The range is from 2 to value set
+       in msix_vec_per_pf_max.
+
 .. list-table:: Driver specific parameters implemented
     :widths: 5 5 90
 
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index d116e2b10bce..81de5fbc130e 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1202,6 +1202,25 @@ static int ice_devlink_set_parent(struct devlink_rate *devlink_rate,
 	return status;
 }
 
+static void ice_set_min_max_msix(struct ice_pf *pf)
+{
+	struct devlink *devlink = priv_to_devlink(pf);
+	union devlink_param_value val;
+	int err;
+
+	err = devl_param_driverinit_value_get(devlink,
+					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
+					      &val);
+	if (!err)
+		pf->msix.min = val.vu32;
+
+	err = devl_param_driverinit_value_get(devlink,
+					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
+					      &val);
+	if (!err)
+		pf->msix.max = val.vu32;
+}
+
 /**
  * ice_devlink_reinit_up - do reinit of the given PF
  * @pf: pointer to the PF struct
@@ -1217,6 +1236,9 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 		return err;
 	}
 
+	/* load MSI-X values */
+	ice_set_min_max_msix(pf);
+
 	err = ice_init_dev(pf);
 	if (err)
 		goto unroll_hw_init;
@@ -1530,6 +1552,30 @@ static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int
+ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
+				 union devlink_param_value val,
+				 struct netlink_ext_ack *extack)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+
+	if (val.vu32 > pf->hw.func_caps.common_cap.num_msix_vectors)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int
+ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
+				 union devlink_param_value val,
+				 struct netlink_ext_ack *extack)
+{
+	if (val.vu32 < ICE_MIN_MSIX)
+		return -EINVAL;
+
+	return 0;
+}
+
 enum ice_param_id {
 	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
@@ -1547,6 +1593,15 @@ static const struct devlink_param ice_dvl_rdma_params[] = {
 			      ice_devlink_enable_iw_validate),
 };
 
+static const struct devlink_param ice_dvl_msix_params[] = {
+	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MAX,
+			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
+			      NULL, NULL, ice_devlink_msix_max_pf_validate),
+	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MIN,
+			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
+			      NULL, NULL, ice_devlink_msix_min_pf_validate),
+};
+
 static const struct devlink_param ice_dvl_sched_params[] = {
 	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
 			     "tx_scheduling_layers",
@@ -1648,6 +1703,7 @@ void ice_devlink_unregister(struct ice_pf *pf)
 int ice_devlink_register_params(struct ice_pf *pf)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
+	union devlink_param_value value;
 	struct ice_hw *hw = &pf->hw;
 	int status;
 
@@ -1656,10 +1712,33 @@ int ice_devlink_register_params(struct ice_pf *pf)
 	if (status)
 		return status;
 
+	status = devl_params_register(devlink, ice_dvl_msix_params,
+				      ARRAY_SIZE(ice_dvl_msix_params));
+	if (status)
+		goto unregister_rdma_params;
+
 	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
 		status = devl_params_register(devlink, ice_dvl_sched_params,
 					      ARRAY_SIZE(ice_dvl_sched_params));
+	if (status)
+		goto unregister_msix_params;
+
+	value.vu32 = pf->msix.max;
+	devl_param_driverinit_value_set(devlink,
+					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
+					value);
+	value.vu32 = pf->msix.min;
+	devl_param_driverinit_value_set(devlink,
+					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
+					value);
+	return 0;
 
+unregister_msix_params:
+	devl_params_unregister(devlink, ice_dvl_msix_params,
+			       ARRAY_SIZE(ice_dvl_msix_params));
+unregister_rdma_params:
+	devl_params_unregister(devlink, ice_dvl_rdma_params,
+			       ARRAY_SIZE(ice_dvl_rdma_params));
 	return status;
 }
 
@@ -1670,6 +1749,8 @@ void ice_devlink_unregister_params(struct ice_pf *pf)
 
 	devl_params_unregister(devlink, ice_dvl_rdma_params,
 			       ARRAY_SIZE(ice_dvl_rdma_params));
+	devl_params_unregister(devlink, ice_dvl_msix_params,
+			       ARRAY_SIZE(ice_dvl_msix_params));
 
 	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
 		devl_params_unregister(devlink, ice_dvl_sched_params,
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 71e05d30f0fd..d041b04ff324 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -542,6 +542,12 @@ struct ice_agg_node {
 	u8 valid;
 };
 
+struct ice_pf_msix {
+	u32 cur;
+	u32 min;
+	u32 max;
+};
+
 struct ice_pf {
 	struct pci_dev *pdev;
 	struct ice_adapter *adapter;
@@ -612,6 +618,7 @@ struct ice_pf {
 	struct msi_map ll_ts_irq;	/* LL_TS interrupt MSIX vector */
 	u16 max_pf_txqs;	/* Total Tx queues PF wide */
 	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
+	struct ice_pf_msix msix;
 	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
 	u16 num_lan_tx;		/* num LAN Tx queues setup */
 	u16 num_lan_rx;		/* num LAN Rx queues setup */
diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index ad82ff7d1995..0659b96b9b8c 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -254,6 +254,13 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
 	int vectors, max_vectors;
 
+	/* load default PF MSI-X range */
+	if (!pf->msix.min)
+		pf->msix.min = ICE_MIN_MSIX;
+
+	if (!pf->msix.max)
+		pf->msix.max = total_vectors / 2;
+
 	vectors = ice_ena_msix_range(pf);
 
 	if (vectors < 0)
-- 
2.47.1


