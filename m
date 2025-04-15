Return-Path: <linux-rdma+bounces-9457-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBF3A8A6AF
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 20:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D4F27A7EF1
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 18:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805DA224B02;
	Tue, 15 Apr 2025 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/Y1l2YK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F6224243;
	Tue, 15 Apr 2025 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744741365; cv=none; b=DzXFaNMS7L+PjwFcn2AbY6L1l95COtqDKFE7YCXk1d/f9PWr3Gc7naxtSBrkePUI/aE3hly1JXyBVBadenb+7ZzlLM1QD+pdZotCv55Tf6ucRVTP8UAySagxl19yNLMLSLkkVMnDSIM6LkPFFToLyka+kLQA6P2vkEPCrGOo13E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744741365; c=relaxed/simple;
	bh=rUrMaaxLgQCCoSzTn4irSynCiVXsqpAwS5/kKcUFuKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gT1bjaTSz4/ya9IZyFOR8JjBod3cvDjf2W7rqCHYZeE5LYTZytyZ9BuC8MjOEath2IxnR4tb2tnb64IsXJ5wRWX6ds2Mea6O3FuDji5z/c1e2gNGGsYUOfrUPV8WVD0O1mGfjAG7hsRBsd/TTrWbku0q1YNgGDTifxdX1JJYrQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/Y1l2YK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744741364; x=1776277364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rUrMaaxLgQCCoSzTn4irSynCiVXsqpAwS5/kKcUFuKM=;
  b=b/Y1l2YKNtZy54x91bm9QNK8FBs+l3V5TTSUA5XRfEcx7712CKlU+luM
   +SSwgagk50N8k43Jk9gka8fXeH0V7gcchZT7gdny9GB+8JeSkFN3E5Zic
   wZ3mf2lSL3I20j4NvgTcvKCBGWT2BuVzzsnJgLmfarQ7jclL08to8Jtxg
   TVkzC41jfrIPvG6ULL7uGuAq2y2WItvRRcGUvGOdxV1likgb3lOxXyVut
   eXK6RyuR8KqidFzCjh8jSgSTbk9MQ3ucAYu6WjxJHKYIF+5DzTiq03YZD
   0hnlsvAueUPy5x5BAUYiEKEPkhz2KPGe3ELdCRh1TzDywfR4HtoSEcvCC
   A==;
X-CSE-ConnectionGUID: tPun2om6T2OjfGpppF/pKA==
X-CSE-MsgGUID: c4+OuTBPSYevWc6QaZKCIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="45981240"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="45981240"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 11:22:43 -0700
X-CSE-ConnectionGUID: 3A1WTQKeQhazKaDW+WRoMg==
X-CSE-MsgGUID: DtPPOySfTHitTI96MHDViQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130512961"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa008.fm.intel.com with ESMTP; 15 Apr 2025 11:21:32 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	jonathan.lemon@gmail.com,
	richardcochran@gmail.com,
	aleksandr.loktionov@intel.com,
	milena.olech@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v2 1/4] dpll: use struct dpll_device_info for dpll registration
Date: Tue, 15 Apr 2025 20:15:40 +0200
Message-Id: <20250415181543.1072342-2-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250415181543.1072342-1-arkadiusz.kubalewski@intel.com>
References: <20250415181543.1072342-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of passing list of properties as arguments to
dpll_device_register(..) use a dedicated struct.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v2:
- new commit
---
 drivers/dpll/dpll_core.c                      | 34 ++++++++++++-------
 drivers/dpll/dpll_core.h                      |  2 +-
 drivers/dpll/dpll_netlink.c                   |  7 ++--
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 16 +++++----
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  1 +
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 10 +++---
 drivers/ptp/ptp_ocp.c                         |  7 ++--
 include/linux/dpll.h                          | 11 ++++--
 8 files changed, 57 insertions(+), 31 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 20bdc52f63a5..af9cda45a89c 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -34,7 +34,7 @@ static u32 dpll_pin_xa_id;
 
 struct dpll_device_registration {
 	struct list_head list;
-	const struct dpll_device_ops *ops;
+	const struct dpll_device_info *info;
 	void *priv;
 };
 
@@ -327,12 +327,12 @@ EXPORT_SYMBOL_GPL(dpll_device_put);
 
 static struct dpll_device_registration *
 dpll_device_registration_find(struct dpll_device *dpll,
-			      const struct dpll_device_ops *ops, void *priv)
+			      const struct dpll_device_info *info, void *priv)
 {
 	struct dpll_device_registration *reg;
 
 	list_for_each_entry(reg, &dpll->registration_list, list) {
-		if (reg->ops == ops && reg->priv == priv)
+		if (reg->info == info && reg->priv == priv)
 			return reg;
 	}
 	return NULL;
@@ -341,8 +341,7 @@ dpll_device_registration_find(struct dpll_device *dpll,
 /**
  * dpll_device_register - register the dpll device in the subsystem
  * @dpll: pointer to a dpll
- * @type: type of a dpll
- * @ops: ops for a dpll device
+ * @info: dpll device information and operations from registerer
  * @priv: pointer to private information of owner
  *
  * Make dpll device available for user space.
@@ -352,11 +351,13 @@ dpll_device_registration_find(struct dpll_device *dpll,
  * * 0 on success
  * * negative - error value
  */
-int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
-			 const struct dpll_device_ops *ops, void *priv)
+int dpll_device_register(struct dpll_device *dpll,
+			 const struct dpll_device_info *info, void *priv)
 {
+	const struct dpll_device_ops *ops = info->ops;
 	struct dpll_device_registration *reg;
 	bool first_registration = false;
+	enum dpll_type type = info->type;
 
 	if (WARN_ON(!ops))
 		return -EINVAL;
@@ -368,7 +369,7 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
-	reg = dpll_device_registration_find(dpll, ops, priv);
+	reg = dpll_device_registration_find(dpll, info, priv);
 	if (reg) {
 		mutex_unlock(&dpll_lock);
 		return -EEXIST;
@@ -379,9 +380,8 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 		mutex_unlock(&dpll_lock);
 		return -ENOMEM;
 	}
-	reg->ops = ops;
+	reg->info = info;
 	reg->priv = priv;
-	dpll->type = type;
 	first_registration = list_empty(&dpll->registration_list);
 	list_add_tail(&reg->list, &dpll->registration_list);
 	if (!first_registration) {
@@ -408,14 +408,14 @@ EXPORT_SYMBOL_GPL(dpll_device_register);
  * Context: Acquires a lock (dpll_lock)
  */
 void dpll_device_unregister(struct dpll_device *dpll,
-			    const struct dpll_device_ops *ops, void *priv)
+			    const struct dpll_device_info *info, void *priv)
 {
 	struct dpll_device_registration *reg;
 
 	mutex_lock(&dpll_lock);
 	ASSERT_DPLL_REGISTERED(dpll);
 	dpll_device_delete_ntf(dpll);
-	reg = dpll_device_registration_find(dpll, ops, priv);
+	reg = dpll_device_registration_find(dpll, info, priv);
 	if (WARN_ON(!reg)) {
 		mutex_unlock(&dpll_lock);
 		return;
@@ -807,7 +807,15 @@ const struct dpll_device_ops *dpll_device_ops(struct dpll_device *dpll)
 	struct dpll_device_registration *reg;
 
 	reg = dpll_device_registration_first(dpll);
-	return reg->ops;
+	return reg->info->ops;
+}
+
+const struct dpll_device_info *dpll_device_info(struct dpll_device *dpll)
+{
+	struct dpll_device_registration *reg;
+
+	reg = dpll_device_registration_first(dpll);
+	return reg->info;
 }
 
 static struct dpll_pin_registration *
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 2b6d8ef1cdf3..baeb10d7dc1e 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -30,7 +30,6 @@ struct dpll_device {
 	u32 device_idx;
 	u64 clock_id;
 	struct module *module;
-	enum dpll_type type;
 	struct xarray pin_refs;
 	refcount_t refcount;
 	struct list_head registration_list;
@@ -84,6 +83,7 @@ void *dpll_pin_on_pin_priv(struct dpll_pin *parent, struct dpll_pin *pin);
 const struct dpll_device_ops *dpll_device_ops(struct dpll_device *dpll);
 struct dpll_device *dpll_device_get_by_id(int id);
 const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref);
+const struct dpll_device_info *dpll_device_info(struct dpll_device *dpll);
 struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs);
 extern struct xarray dpll_device_xa;
 extern struct xarray dpll_pin_xa;
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index c130f87147fa..2de9ec08d551 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -564,6 +564,7 @@ static int
 dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
 		    struct netlink_ext_ack *extack)
 {
+	const struct dpll_device_info *info = dpll_device_info(dpll);
 	int ret;
 
 	ret = dpll_msg_add_dev_handle(msg, dpll);
@@ -589,7 +590,7 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
 	ret = dpll_msg_add_mode_supported(msg, dpll, extack);
 	if (ret)
 		return ret;
-	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
+	if (nla_put_u32(msg, DPLL_A_TYPE, info->type))
 		return -EMSGSIZE;
 
 	return 0;
@@ -1415,11 +1416,13 @@ dpll_device_find(u64 clock_id, struct nlattr *mod_name_attr,
 	unsigned long i;
 
 	xa_for_each_marked(&dpll_device_xa, i, dpll, DPLL_REGISTERED) {
+		const struct dpll_device_info *info = dpll_device_info(dpll);
+
 		cid_match = clock_id ? dpll->clock_id == clock_id : true;
 		mod_match = mod_name_attr ? (module_name(dpll->module) ?
 			!nla_strcmp(mod_name_attr,
 				    module_name(dpll->module)) : false) : true;
-		type_match = type ? dpll->type == type : true;
+		type_match = type ? info->type == type : true;
 		if (cid_match && mod_match && type_match) {
 			if (dpll_match) {
 				NL_SET_ERR_MSG(extack, "multiple matches");
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index bce3ad6ca2a6..0f7440a889ac 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1977,7 +1977,7 @@ static void
 ice_dpll_deinit_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
 {
 	if (cgu)
-		dpll_device_unregister(d->dpll, &ice_dpll_ops, d);
+		dpll_device_unregister(d->dpll, &d->info, d);
 	dpll_device_put(d->dpll);
 }
 
@@ -1996,8 +1996,7 @@ ice_dpll_deinit_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
  * * negative - initialization failure reason
  */
 static int
-ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
-		   enum dpll_type type)
+ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
 {
 	u64 clock_id = pf->dplls.clock_id;
 	int ret;
@@ -2012,7 +2011,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
 	d->pf = pf;
 	if (cgu) {
 		ice_dpll_update_state(pf, d, true);
-		ret = dpll_device_register(d->dpll, type, &ice_dpll_ops, d);
+		ret = dpll_device_register(d->dpll, &d->info, d);
 		if (ret) {
 			dpll_device_put(d->dpll);
 			return ret;
@@ -2363,7 +2362,12 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
 	if (ret)
 		return ret;
 	de->mode = DPLL_MODE_AUTOMATIC;
+	de->info.type = DPLL_TYPE_EEC;
+	de->info.ops = &ice_dpll_ops;
+
 	dp->mode = DPLL_MODE_AUTOMATIC;
+	dp->info.type = DPLL_TYPE_PPS;
+	dp->info.ops = &ice_dpll_ops;
 
 	dev_dbg(ice_pf_to_dev(pf),
 		"%s - success, inputs:%u, outputs:%u rclk-parents:%u\n",
@@ -2426,10 +2430,10 @@ void ice_dpll_init(struct ice_pf *pf)
 	err = ice_dpll_init_info(pf, cgu);
 	if (err)
 		goto err_exit;
-	err = ice_dpll_init_dpll(pf, &pf->dplls.eec, cgu, DPLL_TYPE_EEC);
+	err = ice_dpll_init_dpll(pf, &pf->dplls.eec, cgu);
 	if (err)
 		goto deinit_info;
-	err = ice_dpll_init_dpll(pf, &pf->dplls.pps, cgu, DPLL_TYPE_PPS);
+	err = ice_dpll_init_dpll(pf, &pf->dplls.pps, cgu);
 	if (err)
 		goto deinit_eec;
 	err = ice_dpll_init_pins(pf, cgu);
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index c320f1bf7d6d..9db7463e293a 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -66,6 +66,7 @@ struct ice_dpll {
 	enum dpll_mode mode;
 	struct dpll_pin *active_input;
 	struct dpll_pin *prev_input;
+	struct dpll_device_info info;
 };
 
 /** ice_dplls - store info required for CCU (clock controlling unit)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 1e5522a19483..f722b1de0754 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -20,6 +20,7 @@ struct mlx5_dpll {
 	} last;
 	struct notifier_block mdev_nb;
 	struct net_device *tracking_netdev;
+	struct dpll_device_info info;
 };
 
 static int mlx5_dpll_clock_id_get(struct mlx5_core_dev *mdev, u64 *clock_id)
@@ -444,8 +445,9 @@ static int mlx5_dpll_probe(struct auxiliary_device *adev,
 		goto err_free_mdpll;
 	}
 
-	err = dpll_device_register(mdpll->dpll, DPLL_TYPE_EEC,
-				   &mlx5_dpll_device_ops, mdpll);
+	mdpll->info.type = DPLL_TYPE_EEC;
+	mdpll->info.ops = &mlx5_dpll_device_ops;
+	err = dpll_device_register(mdpll->dpll, &mdpll->info, mdpll);
 	if (err)
 		goto err_put_dpll_device;
 
@@ -481,7 +483,7 @@ static int mlx5_dpll_probe(struct auxiliary_device *adev,
 err_put_dpll_pin:
 	dpll_pin_put(mdpll->dpll_pin);
 err_unregister_dpll_device:
-	dpll_device_unregister(mdpll->dpll, &mlx5_dpll_device_ops, mdpll);
+	dpll_device_unregister(mdpll->dpll, &mdpll->info, mdpll);
 err_put_dpll_device:
 	dpll_device_put(mdpll->dpll);
 err_free_mdpll:
@@ -500,7 +502,7 @@ static void mlx5_dpll_remove(struct auxiliary_device *adev)
 	dpll_pin_unregister(mdpll->dpll, mdpll->dpll_pin,
 			    &mlx5_dpll_pins_ops, mdpll);
 	dpll_pin_put(mdpll->dpll_pin);
-	dpll_device_unregister(mdpll->dpll, &mlx5_dpll_device_ops, mdpll);
+	dpll_device_unregister(mdpll->dpll, &mdpll->info, mdpll);
 	dpll_device_put(mdpll->dpll);
 	kfree(mdpll);
 
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 7945c6be1f7c..b3c5d294acb4 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -382,6 +382,7 @@ struct ptp_ocp {
 	struct ptp_ocp_sma_connector sma[OCP_SMA_NUM];
 	const struct ocp_sma_op *sma_op;
 	struct dpll_device *dpll;
+	struct dpll_device_info	dpll_info;
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -4745,7 +4746,9 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out;
 	}
 
-	err = dpll_device_register(bp->dpll, DPLL_TYPE_PPS, &dpll_ops, bp);
+	bp->dpll_info.type = DPLL_TYPE_PPS;
+	bp->dpll_info.ops = &dpll_ops;
+	err = dpll_device_register(bp->dpll, &bp->dpll_info, bp);
 	if (err)
 		goto out;
 
@@ -4796,7 +4799,7 @@ ptp_ocp_remove(struct pci_dev *pdev)
 			dpll_pin_put(bp->sma[i].dpll_pin);
 		}
 	}
-	dpll_device_unregister(bp->dpll, &dpll_ops, bp);
+	dpll_device_unregister(bp->dpll, &bp->dpll_info, bp);
 	dpll_device_put(bp->dpll);
 	devlink_unregister(devlink);
 	ptp_ocp_detach(bp);
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 5e4f9ab1cf75..0489464af958 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -97,6 +97,11 @@ struct dpll_pin_ops {
 			 struct netlink_ext_ack *extack);
 };
 
+struct dpll_device_info {
+	enum dpll_type type;
+	const struct dpll_device_ops *ops;
+};
+
 struct dpll_pin_frequency {
 	u64 min;
 	u64 max;
@@ -170,11 +175,11 @@ dpll_device_get(u64 clock_id, u32 dev_driver_id, struct module *module);
 
 void dpll_device_put(struct dpll_device *dpll);
 
-int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
-			 const struct dpll_device_ops *ops, void *priv);
+int dpll_device_register(struct dpll_device *dpll,
+			 const struct dpll_device_info *info, void *priv);
 
 void dpll_device_unregister(struct dpll_device *dpll,
-			    const struct dpll_device_ops *ops, void *priv);
+			    const struct dpll_device_info *info, void *priv);
 
 struct dpll_pin *
 dpll_pin_get(u64 clock_id, u32 dev_driver_id, struct module *module,
-- 
2.38.1


