Return-Path: <linux-rdma+bounces-9299-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB42A82A9B
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 17:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BB446600F
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFCC268689;
	Wed,  9 Apr 2025 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P35bRT0K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58277267392;
	Wed,  9 Apr 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212725; cv=none; b=HcvTA9R54zfWsEWJl3rfX+HiOaXs8AVpY9wnWWhHRWURAH/D018jyHt4yRar7Nr2/wer1mfwN2JxqKgh1WMvKVWjjBUIRw8+zQgUPeURlc/8+jC2KrwbxwYM5ILeokA/OYh/hQHom8mrFMkwOk9pxIzcq2nNcdmcR5PBSB2OwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212725; c=relaxed/simple;
	bh=28g1pqf6DxdkRf49I35mHh1VPlqVSh/7qtjRLIX8Ea0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wz81mw0E9v68L28I4qjNKtVh5JU7o5Lh7NkzxR0aLcUb9VvfM/EjXscIRMsFDMCiTWyMMNQEjZdsJXDS2Rcp6gatJTQWHww2TLsUDz758pOnlHjskFBg8qkpvto22a7ibp3zuMj6h3G3es92fz6sV0qOKXmtmKIXccxL+UeuSO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P35bRT0K; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744212723; x=1775748723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=28g1pqf6DxdkRf49I35mHh1VPlqVSh/7qtjRLIX8Ea0=;
  b=P35bRT0KSVwn9n/lgkEmNvKSMh+Z2QCGU9o1OHbse6y7rjBfGXQwxMPd
   npTYS1TFlhxNTWIFM+4NghIW1NdFEp7xz8L8ahgc1fSdDuAenrEb5YCsz
   4447yKcodJZSEb122dQz4ny6YBp7A2mNMA2dj6fUwe2CTqU7bTXpFtYu2
   vPam0FNweszTl9xMogknIBzR8klYLzpmm10p/aXsrU4JrhsnGAb7IgNjG
   DgRZVWkBObbaSqadih3JDDTI4Uag08RnE2nByt8YCvzOFfKCFRqZpzKLf
   rFuLU2cAzDj/2Saju64jZd5tUwKhqstXuBXaOYvbj7/vkxzLmOPuMNq3g
   g==;
X-CSE-ConnectionGUID: cat+x2eiSIKZE7UiXJUYbA==
X-CSE-MsgGUID: ePfNs4utRtCpBjmKCIq05g==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="71072133"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="71072133"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:32:03 -0700
X-CSE-ConnectionGUID: sj4iMcWUR8yxnT64qsbEMw==
X-CSE-MsgGUID: lao44brNTDC0nVGykTVJ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="151796040"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa002.fm.intel.com with ESMTP; 09 Apr 2025 08:31:59 -0700
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
Subject: [PATCH net-next v1 2/4] dpll: pass capabilities on device register
Date: Wed,  9 Apr 2025 17:25:56 +0200
Message-Id: <20250409152558.1007335-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250409152558.1007335-1-arkadiusz.kubalewski@intel.com>
References: <20250409152558.1007335-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new argument on dpll device register, a capabilities bitmask of
features supported by the dpll device.
Provide capability value on dpll device dump.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/dpll/dpll_core.c                       | 5 ++++-
 drivers/dpll/dpll_core.h                       | 2 ++
 drivers/dpll/dpll_netlink.c                    | 2 ++
 drivers/net/ethernet/intel/ice/ice_dpll.c      | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c | 2 +-
 drivers/ptp/ptp_ocp.c                          | 2 +-
 include/linux/dpll.h                           | 3 ++-
 7 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 20bdc52f63a5..563ac37c83ad 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -342,6 +342,7 @@ dpll_device_registration_find(struct dpll_device *dpll,
  * dpll_device_register - register the dpll device in the subsystem
  * @dpll: pointer to a dpll
  * @type: type of a dpll
+ * @capabilities: mask of available features supported by dpll
  * @ops: ops for a dpll device
  * @priv: pointer to private information of owner
  *
@@ -353,7 +354,8 @@ dpll_device_registration_find(struct dpll_device *dpll,
  * * negative - error value
  */
 int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
-			 const struct dpll_device_ops *ops, void *priv)
+			 u32 capabilities, const struct dpll_device_ops *ops,
+			 void *priv)
 {
 	struct dpll_device_registration *reg;
 	bool first_registration = false;
@@ -382,6 +384,7 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 	reg->ops = ops;
 	reg->priv = priv;
 	dpll->type = type;
+	dpll->capabilities = capabilities;
 	first_registration = list_empty(&dpll->registration_list);
 	list_add_tail(&reg->list, &dpll->registration_list);
 	if (!first_registration) {
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 2b6d8ef1cdf3..70bbafb9b635 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -21,6 +21,7 @@
  * @clock_id:		unique identifier (clock_id) of a dpll
  * @module:		module of creator
  * @type:		type of a dpll
+ * @capabilities:	capabilities of a dpll
  * @pin_refs:		stores pins registered within a dpll
  * @refcount:		refcount
  * @registration_list:	list of registered ops and priv data of dpll owners
@@ -31,6 +32,7 @@ struct dpll_device {
 	u64 clock_id;
 	struct module *module;
 	enum dpll_type type;
+	u32 capabilities;
 	struct xarray pin_refs;
 	refcount_t refcount;
 	struct list_head registration_list;
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index c130f87147fa..41aed0d29be2 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -591,6 +591,8 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
 		return ret;
 	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
 		return -EMSGSIZE;
+	if (nla_put_u32(msg, DPLL_A_CAPABILITIES, dpll->capabilities))
+		return -EMSGSIZE;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index bce3ad6ca2a6..614a813c7772 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2012,7 +2012,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
 	d->pf = pf;
 	if (cgu) {
 		ice_dpll_update_state(pf, d, true);
-		ret = dpll_device_register(d->dpll, type, &ice_dpll_ops, d);
+		ret = dpll_device_register(d->dpll, type, 0, &ice_dpll_ops, d);
 		if (ret) {
 			dpll_device_put(d->dpll);
 			return ret;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 1e5522a19483..0e430f93b047 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -444,7 +444,7 @@ static int mlx5_dpll_probe(struct auxiliary_device *adev,
 		goto err_free_mdpll;
 	}
 
-	err = dpll_device_register(mdpll->dpll, DPLL_TYPE_EEC,
+	err = dpll_device_register(mdpll->dpll, DPLL_TYPE_EEC, 0,
 				   &mlx5_dpll_device_ops, mdpll);
 	if (err)
 		goto err_put_dpll_device;
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index b25635c5c745..87b9890d8ef2 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4745,7 +4745,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out;
 	}
 
-	err = dpll_device_register(bp->dpll, DPLL_TYPE_PPS, &dpll_ops, bp);
+	err = dpll_device_register(bp->dpll, DPLL_TYPE_PPS, 0, &dpll_ops, bp);
 	if (err)
 		goto out;
 
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 5e4f9ab1cf75..dde8dee83dc6 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -171,7 +171,8 @@ dpll_device_get(u64 clock_id, u32 dev_driver_id, struct module *module);
 void dpll_device_put(struct dpll_device *dpll);
 
 int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
-			 const struct dpll_device_ops *ops, void *priv);
+			 u32 capabilities, const struct dpll_device_ops *ops,
+			 void *priv);
 
 void dpll_device_unregister(struct dpll_device *dpll,
 			    const struct dpll_device_ops *ops, void *priv);
-- 
2.38.1


