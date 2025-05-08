Return-Path: <linux-rdma+bounces-10159-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7F4AAF9E6
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 14:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 341B07BCA01
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 12:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FBA22A7F3;
	Thu,  8 May 2025 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rcog1iz+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9322577D;
	Thu,  8 May 2025 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707256; cv=none; b=XvBQQe/cDwno1r2AJX99FefaSHvBCiv7roWegh5ZXlnI/U9efyX5IAaI++r20FC2JHXmS5n2FGUo8bht9b2eDiJGXJ1oWvG1FDcg5P6Vh6Sg15bbCxulHNkQVWXH83cRfjk797MOSq1zE6FdjsP/vMvhxtQ6kI/HhoWrpd3zcdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707256; c=relaxed/simple;
	bh=sSdQu6zQOgWc79JFKnM4BAB4IFkoN+mT9JzGaCqpZ7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lY0WCt+nBkBdGjwW9ZAOoT7xPgm9biBc+AO8fRE3ZGsKRp+YrMPDB9tVAiy4UH+UJOyZJUIkNWxih3UYnvAFETpzNEb5DMoC1zWGlgk92xrfun5NFOqJnNymzoXxZ8Cpb63fY39pHbqF3vhNa5UXdjQrDCUazwopxC5TVDw6SvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rcog1iz+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746707255; x=1778243255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sSdQu6zQOgWc79JFKnM4BAB4IFkoN+mT9JzGaCqpZ7c=;
  b=Rcog1iz+8M9kOfuGINQLNVbtn6aJNflw9s9kAT1SMGYgZL+VC6ONyZVj
   6PW8ziZiv7XVNllE71wjYOZjtSNSYgLFxyJitTMMj1HqPpJIFA29YKIg1
   QIgjyW8oKsfbvXjoCsGBaiA4ZLzFcFFlPZ7fQ0KrvgRFtzun/NYnk6h+n
   WGNLzm1RQ64k80I3mZbecmlxb4CwaAbghcwl7two6Z5TpmW/pB6hKbq1z
   PqXi3TmxolBOm7jnUW11GnLXS+DPe1+94n+rdtPwiyOm/GF5khtMhMQ4J
   9P97ypaCbxuEzfKvNa2R+Md8Kt7adMP7jJlaBFcFV9l07+yHi5P0qMCQZ
   A==;
X-CSE-ConnectionGUID: q36dRCOASjSA6lEeGn30lg==
X-CSE-MsgGUID: XvmbiLa0QzKVy21MJrXJCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="36115148"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="36115148"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:27:35 -0700
X-CSE-ConnectionGUID: eVtnsdmgTNybV+HdPmO8DA==
X-CSE-MsgGUID: u/yvmuR7RX2gZULMEKOaxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="136772862"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa010.fm.intel.com with ESMTP; 08 May 2025 05:27:30 -0700
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
Subject: [PATCH net-next v3 2/3] dpll: add phase_offset_monitor_get/set callback ops
Date: Thu,  8 May 2025 14:21:27 +0200
Message-Id: <20250508122128.1216231-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250508122128.1216231-1-arkadiusz.kubalewski@intel.com>
References: <20250508122128.1216231-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new callback operations for a dpll device:
- phase_offset_monitor_get(..) - to obtain current state of phase offset
  monitor feature from dpll device,
- phase_offset_monitor_set(..) - to allow feature configuration.

Obtain the feature state value using the get callback and provide it to
the user if the device driver implements callbacks.

Execute the set callback upon user requests.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v3:
- remove feature flags and capabilities,
- add separated (per feature) callback ops,
- use callback ops to determine feature availability.
---
 drivers/dpll/dpll_netlink.c | 76 ++++++++++++++++++++++++++++++++++++-
 include/linux/dpll.h        |  8 ++++
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index c130f87147fa..6d2980455a46 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -126,6 +126,26 @@ dpll_msg_add_mode_supported(struct sk_buff *msg, struct dpll_device *dpll,
 	return 0;
 }
 
+static int
+dpll_msg_add_phase_offset_monitor(struct sk_buff *msg, struct dpll_device *dpll,
+				  struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	enum dpll_feature_state state;
+	int ret;
+
+	if (ops->phase_offset_monitor_set && ops->phase_offset_monitor_get) {
+		ret = ops->phase_offset_monitor_get(dpll, dpll_priv(dpll),
+						    &state, extack);
+		if (ret)
+			return -EINVAL;
+		if (nla_put_u32(msg, DPLL_A_PHASE_OFFSET_MONITOR, state))
+			return -EMSGSIZE;
+	}
+
+	return 0;
+}
+
 static int
 dpll_msg_add_lock_status(struct sk_buff *msg, struct dpll_device *dpll,
 			 struct netlink_ext_ack *extack)
@@ -591,6 +611,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
 		return ret;
 	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
 		return -EMSGSIZE;
+	ret = dpll_msg_add_phase_offset_monitor(msg, dpll, extack);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -746,6 +769,31 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
 }
 EXPORT_SYMBOL_GPL(dpll_pin_change_ntf);
 
+static int
+dpll_phase_offset_monitor_set(struct dpll_device *dpll, struct nlattr *a,
+			      struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	enum dpll_feature_state state = nla_get_u32(a), old_state;
+	int ret;
+
+	if (!(ops->phase_offset_monitor_set && ops->phase_offset_monitor_get)) {
+		NL_SET_ERR_MSG_ATTR(extack, a, "dpll device not capable of phase offset monitor");
+		return -EOPNOTSUPP;
+	}
+	ret = ops->phase_offset_monitor_get(dpll, dpll_priv(dpll), &old_state,
+					    extack);
+	if (ret) {
+		NL_SET_ERR_MSG(extack, "unable to get current state of phase offset monitor");
+		return -EINVAL;
+	}
+	if (state == old_state)
+		return 0;
+
+	return ops->phase_offset_monitor_set(dpll, dpll_priv(dpll), state,
+					     extack);
+}
+
 static int
 dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 		  struct netlink_ext_ack *extack)
@@ -1533,10 +1581,34 @@ int dpll_nl_device_get_doit(struct sk_buff *skb, struct genl_info *info)
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
+		case DPLL_A_PHASE_OFFSET_MONITOR:
+			ret = dpll_phase_offset_monitor_set(dpll, a,
+							    info->extack);
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
index 5e4f9ab1cf75..6ad6c2968a28 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -30,6 +30,14 @@ struct dpll_device_ops {
 				       void *dpll_priv,
 				       unsigned long *qls,
 				       struct netlink_ext_ack *extack);
+	int (*phase_offset_monitor_set)(const struct dpll_device *dpll,
+					void *dpll_priv,
+					enum dpll_feature_state state,
+					struct netlink_ext_ack *extack);
+	int (*phase_offset_monitor_get)(const struct dpll_device *dpll,
+					void *dpll_priv,
+					enum dpll_feature_state *state,
+					struct netlink_ext_ack *extack);
 };
 
 struct dpll_pin_ops {
-- 
2.38.1


