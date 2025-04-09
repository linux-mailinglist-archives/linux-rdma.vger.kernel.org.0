Return-Path: <linux-rdma+bounces-9300-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3215A82AE3
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 17:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916F28A5FE4
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2A1268C7A;
	Wed,  9 Apr 2025 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRnTJTpQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72351268C6B;
	Wed,  9 Apr 2025 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212730; cv=none; b=QiGV/nEepx8PAjz0FkmpIvVXaxEdYZa2e+QpxY7RIQXiZMABgCqYdOsbtRZcyrkhmABiIpzRvoR6YT0u2PgYIxnfhGx3hfozEDrahc8taPJHFDf7S/V0yKsyJo9Ka5hBIGXkQGiVm2qaO1rSEaKs7ijbhUY+8Pozrd2W38j62k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212730; c=relaxed/simple;
	bh=yKFsUwl/VeYLcbMN+FoLUcPKvtWP6Dd9f7S8pd3B4Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFh810Y2Agu1NDRIJ9KAavyf7VnwZbQGrNVBTCCI3zgEkng888TPJD/TqjdkNP/BCaHI29gMmtDbeKOizUpTTrpr+maASEB+X603H9pUfzmCZ5l0Fy6VpaY0WGrC3u3QJ4vJi3r4Bz3zNNL94EEjFucu+ZIS6pgYKKQVsH3LPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRnTJTpQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744212729; x=1775748729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yKFsUwl/VeYLcbMN+FoLUcPKvtWP6Dd9f7S8pd3B4Bc=;
  b=CRnTJTpQO0vhY3d4FVqOk/E/LgV8e9vIJhkaaSFRjHwFd39jbPjmue6F
   GElvcV335u5uwGeXWZBW07zqa0DeE5PiZtherZsywstfwz5BxH/tomTOw
   Y4hLmwhMx7T0wP6eLDgpan0HpTEbiiNUpFayOZN/3v0yWc0giO861S8HY
   MEcWUJwwK9jyYFx4/D/zkEHDcvNUNLoH0x01EvOBYVW2m5hI9Btaxqf6J
   qpWgTeNUDOwaB588xbLfcKZ0vYaiaFuQY/5h99NsfpWlCtcRkEcz5n+6S
   Kscgs9NhD+ADnnLOV6UTQtURuh0VCVUeFA3Tkz+8alj0Oz7dyLbCH12yE
   g==;
X-CSE-ConnectionGUID: LSPcMIpYQlmlLjZmWm2XZw==
X-CSE-MsgGUID: rd/H/2caTz+ePeIXJjIZpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="71072148"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="71072148"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:32:08 -0700
X-CSE-ConnectionGUID: 18VKBc06QxeoDGgjzhBDJg==
X-CSE-MsgGUID: FH97/4laRXGzyBa0oumc1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="151796145"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa002.fm.intel.com with ESMTP; 09 Apr 2025 08:32:05 -0700
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
Subject: [PATCH net-next v1 3/4] dpll: features_get/set callbacks
Date: Wed,  9 Apr 2025 17:25:57 +0200
Message-Id: <20250409152558.1007335-4-arkadiusz.kubalewski@intel.com>
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

Add new callback ops for a dpll device.
- features_get(..) - to obtain currently configured features from dpll
  device,
- feature_set(..) - to allow dpll device features configuration.
Provide features attribute and allow control over it to the users if
device driver implements callbacks.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/dpll/dpll_netlink.c | 76 ++++++++++++++++++++++++++++++++++++-
 include/linux/dpll.h        |  4 ++
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 41aed0d29be2..41eb848ce021 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -126,6 +126,25 @@ dpll_msg_add_mode_supported(struct sk_buff *msg, struct dpll_device *dpll,
 	return 0;
 }
 
+static int
+dpll_msg_add_features(struct sk_buff *msg, struct dpll_device *dpll,
+		      struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	u32 features;
+	int ret;
+
+	if (!ops->features_get)
+		return 0;
+	ret = ops->features_get(dpll, dpll_priv(dpll), &features, extack);
+	if (ret)
+		return ret;
+	if (nla_put_u32(msg, DPLL_A_FEATURES, features))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int
 dpll_msg_add_lock_status(struct sk_buff *msg, struct dpll_device *dpll,
 			 struct netlink_ext_ack *extack)
@@ -593,6 +612,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
 		return -EMSGSIZE;
 	if (nla_put_u32(msg, DPLL_A_CAPABILITIES, dpll->capabilities))
 		return -EMSGSIZE;
+	ret = dpll_msg_add_features(msg, dpll, extack);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -748,6 +770,33 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
 }
 EXPORT_SYMBOL_GPL(dpll_pin_change_ntf);
 
+static int
+dpll_features_set(struct dpll_device *dpll, struct nlattr *a,
+		  struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	u32 features = nla_get_u32(a), old_features;
+	int ret;
+
+	if (features && !(dpll->capabilities & features)) {
+		NL_SET_ERR_MSG_ATTR(extack, a, "dpll device not capable of this features");
+		return -EOPNOTSUPP;
+	}
+	if (!ops->features_get || !ops->features_set) {
+		NL_SET_ERR_MSG(extack, "dpll device not supporting any features");
+		return -EOPNOTSUPP;
+	}
+	ret = ops->features_get(dpll, dpll_priv(dpll), &old_features, extack);
+	if (ret) {
+		NL_SET_ERR_MSG(extack, "unable to get old features value");
+		return ret;
+	}
+	if (old_features == features)
+		return -EINVAL;
+
+	return ops->features_set(dpll, dpll_priv(dpll), features, extack);
+}
+
 static int
 dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 		  struct netlink_ext_ack *extack)
@@ -1535,10 +1584,33 @@ int dpll_nl_device_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
+static int
+dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info *info)
+{
+	struct nlattr *a;
+	int rem, ret;
+
+	nla_for_each_attr(a, genlmsg_data(info->genlhdr),
+			  genlmsg_len(info->genlhdr), rem) {
+		switch (nla_type(a)) {
+		case DPLL_A_FEATURES:
+			ret = dpll_features_set(dpll, a, info->extack);
+			if (ret)
+				return ret;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
 int dpll_nl_device_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	/* placeholder for set command */
-	return 0;
+	struct dpll_device *dpll = info->user_ptr[0];
+
+	return dpll_set_from_nlattr(dpll, info);
 }
 
 int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index dde8dee83dc6..5432d8479ed5 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -30,6 +30,10 @@ struct dpll_device_ops {
 				       void *dpll_priv,
 				       unsigned long *qls,
 				       struct netlink_ext_ack *extack);
+	int (*features_set)(const struct dpll_device *dpll, void *dpll_priv,
+			    u32 features, struct netlink_ext_ack *extack);
+	int (*features_get)(const struct dpll_device *dpll, void *dpll_priv,
+			    u32 *features, struct netlink_ext_ack *extack);
 };
 
 struct dpll_pin_ops {
-- 
2.38.1


