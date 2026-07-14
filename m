Return-Path: <linux-rdma+bounces-23172-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8qTDF6bUVWpQuAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23172-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:18:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BD7751686
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:18:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ptcW9S6b;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23172-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23172-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88149300BE8E
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 06:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A663A6EE6;
	Tue, 14 Jul 2026 06:18:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017B343D9D;
	Tue, 14 Jul 2026 06:18:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009886; cv=fail; b=XoaTfUwrsqZc7PRGEoSddD54/tuRWwqnfuVR7IifqvsP/OVQNNDtrcx8mvpeIkwZ1UHfHLRkmtdhIPBnOeC4kOabju8NjJjd58uRpVRrgnlTPd+oS4Yyi+T60E0hFKhR+zJk3tvKsLIJqf7S83hQECJ8pSaZ3a+Z4QD/GMRHlew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009886; c=relaxed/simple;
	bh=0aepUmaHfGEzlpKuM9uJS4GVNXAD/MujGLf1swlpfq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aa/vqkU9Odr9osGkutZ/25DBKCLO7M9po6OZxMEkibNP9VuR1vKe6hCpdkeiawWr/I36BVxWBLsKyZ9LMml0jMKT7xjjmSJGge+/KEsKVTzbFJiW/6bsh8dkeJhghx+lfqoPMMYfzzZXRPus4c8ig33VsjSuWEXvx9WfZsh6VIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ptcW9S6b; arc=fail smtp.client-ip=40.107.208.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ou21+oaUGYYO8LDCvuVDRE1TnRemOY3ktcsB1H+naBAQwTnbX+3lfoFCyoNy4NnAZUtM8K2SVdIEbGvOzVYUE4LtBttvyQ/gTgk/nnVxO0vnnuUSP8JpehvhT6UB3Gf76vTTsVl1BVGQnNMqT1ODbN891kycOJeHvrv2luBzpWnP89QixLRKJols/qL1WXrQEMACw/tgxgiTJ+bIcaHtD7r5hnvn1Gw8pvPKTOqG82/Opi8/Ai96XX7nRM6JEHq6eAgVnu2S7S0Glh4ZbHPIl8rub7P242+wzfMmr5AUONRDGZkAUgHUKGXrhpxX0/mNOG8NzVD9HplwosUgoN0ywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDiikaJ5zvJaW8yCgfg0tlpE12u3EBbSF8AnAakiX9s=;
 b=pT3HUX5//dSrjVq14L2FcGOGKgM7rdvJ2X/n6VL/jN2bKlxE82ytS0OUCOWl92KSQENU1CNPvxu57HHEkd+9wYlaf/KBcLkadUyRNvNRzTHWljIcf3gXopPZmOW1Vo2EcrPsQZvlBfZgPZZSP6SJp5XFB5vsABGUWA0PEzMmv7cckqLj/y3oSIb/kMXlSjog04oNYDDnMKX31/CEUoOH9sa2cp+mJFIQexyvupAL2lYB06jVlYq0GFxGomlI4/JvqIzuyr9ABpryDXp0/FG5APH91youGCZJbcrddqZjB0mLK3hhH0ARs2xbacatC216LsWsZ0htf5I3p3bTipSMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDiikaJ5zvJaW8yCgfg0tlpE12u3EBbSF8AnAakiX9s=;
 b=ptcW9S6bGJNVXOZtUA5sSNTH8IacR70V16gHp9lb0Gorioqu/A2fts0wrT/FGWA8Fd1OMtuNaRQFx5GPVs+lEe2batdD565v40oKUrlbYZIrvh9NsaPMdK1Uj05PWBqsiGZ1J1BWXGnujKNSAJLq60hCqQNO2+Ole93bpPvIqOeLeXcQ32hQg8OmQ2GBdK7fgyMkLtFmtYi3RnhaDlMTZMzFN2SDsainotRgXiC2qOTC+nZoildAQlbEDqQqgZdI6YkcP5vgf3EUnVZ0GJuMDrIy8RzI6jFOdPTw7EA6I+fdLeI7G4zm/n46Hgxn1iSnUSmxbQZEAmq/GYR4LTA+3A==
Received: from SJ2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:a03:505::24)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 06:17:59 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::5f) by SJ2PR07CA0022.outlook.office365.com
 (2603:10b6:a03:505::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.20 via Frontend Transport; Tue,
 14 Jul 2026 06:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 06:17:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 23:17:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 23:17:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Jul 2026 23:17:42 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V6 2/4] devlink: Factor out eswitch mode setting
Date: Tue, 14 Jul 2026 09:17:28 +0300
Message-ID: <20260714061731.531849-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714061731.531849-1-mbloch@nvidia.com>
References: <20260714061731.531849-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e68d93b-0531-4867-742a-08dee16fa733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	lJatt29fMriOeORB1P3BKIW3m94djsS/zMZOasLtKeHbsC9I+lcN5sJghVeu0d8VXhQWpkhcfhtCv/74w62onGNHMuAGhXHztC4vMY6DOS5SOh88wzkCNt66QyPERToTI3B7qk/Fpxa0nPcYEe57Gl8AKSKoYjSGSsnL0gCeiZJiOI8ewFCo224QwqniB5bI+DjbQl/iPAn+S9Lth0So4CNbDK+T++aAqAWZX7bG7AJehi/kbsOr/OgNuuBpYfvn0DKXbvrqG3cI+vXiiiazovgsQrY89re1ZMyAOPbtMj5S21FeyPPRoM0EeLOFVLteI4W9AakBtEKOBZDmQ7MLyBxSSRXWWfmCJNaZcyTmKbPnHaSDBdbdRYmfIWWSaRCmp8z3knCtmEHgKXT2gJu82U4q+OV78v5JMqeTGyTDhTUvlklbwXzei87ik1zoTTw9moNv79JEDRzc4VwrBHw9AT/6+j0mZ6ye73HfL4bL8+EkJFei/EyC0IfNdX7bCqLxzX6nCqWHtrjDwKP4WpvLlP/HU2/KMpFjT5xQc/J9+t1sINyoazz1BAx0GndZw5BVg3DheKEQE6dZ6xPyJ6++RxBDIJuOiCqFHgcEhkMC5EeaqdDqxgK1A0umlG3K+zVaTfftkfnQu8Rh0wV1hNnLRbL5vk7p4idTVkkv4U3Fy5PM9vdUAodTylySifnhaDhm
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OVr4LR/vZdJ2YJF8Eyiu7ITqpsG7X/4CU3PLVqFE8U8MU93O4KKMrXGjnuSTDYbUGW3HPe2yO6MaOqDa7lEvrHi3ZH4cfU5iWawxHSXhWU4lkBmDURiefMmCzXLxQT1PaHFtfgWYKTuvAWCu1018TDLhiivrw9vV3vQNQGS6Q96Bbhgfqmt/iMyRH2V+KNGxdtDbhipq4mKv6PyRDpbCKUEJ7ulhkTbk9C71RpSBX36Xp5M0AZDCEUunjDAfft46s37EXQCteSruHc3aiF02Ire08AyY+XsHDCp46N8r+HmCQHXieFacQrA0zj50BAsjU3IFBa7M881Kj2aoeIsutgslVmraqxQF4mU+rNfpXAje32o4FDeMc8BZgpOoKz62HxkHV+yz8LL9jsJtftxdxbDInAn8ReSfmnFmxIYORQ+m6GLr2NBBSwQ1KZWjhmum
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:17:59.5649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e68d93b-0531-4867-742a-08dee16fa733
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23172-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:mbloch@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57BD7751686

Move the common eswitch mode set checks into a small helper and use it
from the netlink eswitch set command. This makes the same validation
available to the devlink core path that applies eswitch mode defaults.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 net/devlink/dev.c           | 27 ++++++++++++++++++++-------
 net/devlink/devl_internal.h |  3 +++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index bcf001554e84..119ef105d0a7 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -702,6 +702,25 @@ int devlink_nl_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
+int devlink_eswitch_mode_set(struct devlink *devlink,
+			     enum devlink_eswitch_mode mode,
+			     struct netlink_ext_ack *extack)
+{
+	const struct devlink_ops *ops = devlink->ops;
+	int err;
+
+	devl_assert_locked(devlink);
+
+	if (!ops->eswitch_mode_set)
+		return -EOPNOTSUPP;
+
+	err = devlink_rates_check(devlink, devlink_rate_is_node, extack);
+	if (err)
+		return err;
+
+	return ops->eswitch_mode_set(devlink, mode, extack);
+}
+
 int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
@@ -712,14 +731,8 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 	u16 mode;
 
 	if (info->attrs[DEVLINK_ATTR_ESWITCH_MODE]) {
-		if (!ops->eswitch_mode_set)
-			return -EOPNOTSUPP;
-		err = devlink_rates_check(devlink, devlink_rate_is_node,
-					  info->extack);
-		if (err)
-			return err;
 		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
-		err = ops->eswitch_mode_set(devlink, mode, info->extack);
+		err = devlink_eswitch_mode_set(devlink, mode, info->extack);
 		if (err)
 			return err;
 	}
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index cdf894ba5a9d..af43b7163f78 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -348,6 +348,9 @@ bool devlink_rate_is_node(const struct devlink_rate *devlink_rate);
 int devlink_rates_check(struct devlink *devlink,
 			bool (*rate_filter)(const struct devlink_rate *),
 			struct netlink_ext_ack *extack);
+int devlink_eswitch_mode_set(struct devlink *devlink,
+			     enum devlink_eswitch_mode mode,
+			     struct netlink_ext_ack *extack);
 
 /* Linecards */
 unsigned int devlink_linecard_index(struct devlink_linecard *linecard);
-- 
2.43.0


