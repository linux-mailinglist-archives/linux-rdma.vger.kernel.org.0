Return-Path: <linux-rdma+bounces-7374-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124D7A26556
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 22:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B78C16636F
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 21:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D593211280;
	Mon,  3 Feb 2025 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efPAdzMx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B5420F081;
	Mon,  3 Feb 2025 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738616994; cv=none; b=I1ZjeGkkYIJQXhHgaKyPcJSVKiPW74EGRjEAVWuSHAr5jIxNbTH+WadY4uqq8wX4swZJrmZGth4sZrZKMpDU7sfPBN6tNx8Rixc6S9vVjFoKU09wF0t2YvQmKFvjqzmEYn9H9aYItOXXIIxDZ0GeJLWArbGYbwhVauw+7Ooh+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738616994; c=relaxed/simple;
	bh=xw1PfV/VSotZoPPlRteUAkF+rL5L+jHdJ/+glbkAGtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HenHNi544zMMqy7zwFmGtW0orlZ+zks3+BTUugqAp94z1FEkRebRt90pm/5bvJLq1u3x3REuQ/YmecERgLuH/2qR2Xf1y5OeG+LMeQf6RSZF8KfPVorizP+R02tW9NdsHEbqRT9nXvudsdtlb539/AQmybtNW1F6EwI8wuKsyjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efPAdzMx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738616990; x=1770152990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xw1PfV/VSotZoPPlRteUAkF+rL5L+jHdJ/+glbkAGtw=;
  b=efPAdzMxmto3++F86Tq1WznAZ17om9erwKR4rd/mWf+pgTD/XNhDozf9
   zGiCWn9S0hQUuYQbUtFhVXk5GmDQng+a//NA3RbPVmdPuK8KkoZHMmDP1
   m8JIOS9Yj4rZeG4D3vpCVicXsvbuOb+t/4wuOHJlW5X7w5odu7eTabF3h
   4DQgZpBFrOP+x1BCz7soIvmX2SijZ+PWca7Tr/Gelozidrdy5J1xYY5Nb
   WZCNacVGfGNI0EhlXxiwVJcY/l84cLv8gkAZuU46xYFsT/uAl/MhgkwIz
   +camUhkjQez6IjnnECb6Gl4kCZFr/n8s6KwWXiV95X3PiT4IqgHxJVHgV
   g==;
X-CSE-ConnectionGUID: kZRZOoCKREafWpgiTQMsgw==
X-CSE-MsgGUID: QafoB759QGGqwPx5xJ+DIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="49735572"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="49735572"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 13:09:48 -0800
X-CSE-ConnectionGUID: qrGl3iefT0KE5PgAA8LtWw==
X-CSE-MsgGUID: mur6XXeCT6C3aeeTYq7z/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="141273303"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 03 Feb 2025 13:09:48 -0800
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
Subject: [PATCH net-next 2/9] ice: devlink PF MSI-X max and min parameter
Date: Mon,  3 Feb 2025 13:09:31 -0800
Message-ID: <20250203210940.328608-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250203210940.328608-1-anthony.l.nguyen@intel.com>
References: <20250203210940.328608-1-anthony.l.nguyen@intel.com>
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
---
 Documentation/networking/devlink/ice.rst      | 11 +++
 .../net/ethernet/intel/ice/devlink/devlink.c  | 88 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice.h          |  7 ++
 drivers/net/ethernet/intel/ice/ice_irq.c      |  7 ++
 4 files changed, 113 insertions(+)

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
index d116e2b10bce..c53baecf8a90 100644
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
@@ -1530,6 +1552,37 @@ static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int
+ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
+				 union devlink_param_value val,
+				 struct netlink_ext_ack *extack)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+
+	if (val.vu32 > pf->hw.func_caps.common_cap.num_msix_vectors ||
+	    val.vu32 < pf->msix.min) {
+		NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
+				 union devlink_param_value val,
+				 struct netlink_ext_ack *extack)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+
+	if (val.vu32 < ICE_MIN_MSIX || val.vu32 > pf->msix.max) {
+		NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 enum ice_param_id {
 	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
@@ -1547,6 +1600,15 @@ static const struct devlink_param ice_dvl_rdma_params[] = {
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
@@ -1648,6 +1710,7 @@ void ice_devlink_unregister(struct ice_pf *pf)
 int ice_devlink_register_params(struct ice_pf *pf)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
+	union devlink_param_value value;
 	struct ice_hw *hw = &pf->hw;
 	int status;
 
@@ -1656,10 +1719,33 @@ int ice_devlink_register_params(struct ice_pf *pf)
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
 
@@ -1670,6 +1756,8 @@ void ice_devlink_unregister_params(struct ice_pf *pf)
 
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


