Return-Path: <linux-rdma+bounces-18570-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M2qGIGHwmkAegQAu9opvQ
	(envelope-from <linux-rdma+bounces-18570-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:45:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA613088DB
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9938D303B45F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 12:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F0C3FCB25;
	Tue, 24 Mar 2026 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PSf4KfHt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108703F9F27;
	Tue, 24 Mar 2026 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355463; cv=fail; b=GXxXNzB3KmHb62CDqyPuZawjMr/1tvDv9eMDWdYlKDEd0V/EzgldNe1m20guZEDTjDZWOXZPHkUdFmJTYQasjFYmk4DdkxVvawgRMzDlcrTiZgSdI/AcG9ub4txQdNDS2Y50P6UTD27l0WheOdV6FPuGOFMrl9jhNBmRdUL5DrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355463; c=relaxed/simple;
	bh=Iu1vYg7GwNi/dR7ygmOkqrIZ8P1sVBVwR3biMW8Fb5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apYSAs8Cd2YRWBUW+B/OtVS9dkYZRbqM8MGR3mrsII3AG4/PW/AVDfR2QLdP1eB9zTMy2xWBCjMv6X+8184+UQTTXTHav4otXsEFiwKnnjwZK9ZWacAeRCvgmawhSM0fNW//WO1rFH5kyE84RFJNkv2aCdcCd8mULUJrTxVH528=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PSf4KfHt; arc=fail smtp.client-ip=52.101.85.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNP1ekIxOYIs5EewYLfw3nsoMmLskMFZxDRYzgbZszu5gMaixj1R5DHD0G37LM8zirIVqN7HV7IasbHTSPrHmrghPA/fvlM12FFE7rZWs2xtxc5K4yc74vuOei1e5tM134NG0xLAVoNiEGiRos3lSSODr05K26BVtjMc5KueqcCGPY8E6S86w+33Yu4ju7vGP7t1W2d9xDeEmUJhHX37Fhvx9lwzg72CLjNwguNeq4hyrAl9p+mFQ+26oj7qpqeHz+F8xSJVq9zmPGkmOnyZEGRHHhaVECoR8j06I6NpufRSceIXdP7UDTmyTEgImNmS1ZNHIQLwy3LoQCnDnljTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lyfd0WUUrXN7Za1ZG5LPN0gi/IumMVLCdLLSgfBJZb8=;
 b=ylKfmhsYU7sh6gEU/N24PihMbiwL6xSCSqVNRC5S1IvTIoaCpLQXJA1kvNL7PNShNmNegAPbcdodvBEABNMYiw6ehshSJkXJUJdrmuwJutdn+xDv2QTmGF6TJF4NniFz64N7cx0mKMIOPg2q/eMyhKEKIFdgjNApmf+7aCyyXWELKpdd2YJSAJxpCRreOXqTsmwYJs8bD7s3plkEk7VDBLqMSDfzBzcJpcKiUmlZzAjOPIVNTee15M7u8E+PaPLrZh+taQt56f3QDuYgRSG16cCncRl0wQ+23Y6Dxzo9xt5avnUH88hl5I3EY9XsXqx+w0QOARgyFp6V46aBsazpsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lyfd0WUUrXN7Za1ZG5LPN0gi/IumMVLCdLLSgfBJZb8=;
 b=PSf4KfHtqFx31D8wm2p2kcuDFEUfX4Aq8OR61B/Qjf6V5NTYJ8Iyj9ggnYRrQAtocoDh785YxAo3Jz2A6Qq4YKkR136DQncwLHyAAHa+41q0KKOIz4FDTSR2uKYY4u2aCaXY4MYOS7NkPQNf2hdut+W037km5VqGRV8fHA0lMwf4lGlb4MRpMjnbGC82+v7bn1gPyoebdCRcHonL4uIpcPFmCSHmTfQcq4Tb0xkmhbFH6unocBR9KFuvPz64JfwNRChGDH2MB3IPzt1EV4W0hkZPiXVTQuv0u1Wel8qzeU+W0MrK69PBy4PToTCAZtuW/Zlbpf2Z5xNQ4PVSSbE42w==
Received: from PH7PR13CA0010.namprd13.prod.outlook.com (2603:10b6:510:174::20)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:30:52 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::22) by PH7PR13CA0010.outlook.office365.com
 (2603:10b6:510:174::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Tue,
 24 Mar 2026 12:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:30:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:30:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:30:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Mar 2026 05:30:20 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Chuck Lever <chuck.lever@oracle.com>, "Matthieu Baerts
 (NGI0)" <matttbe@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Shay
 Drory" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next V8 07/14] devlink: Allow rate node parents from other devlinks
Date: Tue, 24 Mar 2026 14:28:41 +0200
Message-ID: <20260324122848.36731-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260324122848.36731-1-tariqt@nvidia.com>
References: <20260324122848.36731-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 39affc60-6095-4bb4-a7d6-08de89a12f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ycVwoYU9P4O3lVLKPvFuC/KH9oF2LcDPG59BHu9krzi4XzXh1ITNVbLRkC1rCUi8OQbJfZEY8vlIRIyCXJ028dLb7NQoGNYaQcVjL1v5IMGGC6kKtlp7SlBDurMRXskP/QJ3gXOuhG+heCajT8OSDEVxvrC/YAKQHVa7/wk61nBQR2n7BgxJalnSelMCZ4bZQAA9hgPhQLP+/UGV6FLiky9lxAMpZWAgzVljK0MDPV28sR6QE+A3kFP9yEZXSBQbJxTEyn0HaORKQiPbv0BMy95MT8U1tel/e14/0Qfe5Zuvb4xjYnNvh6zr+CHx//AYG4rJjLmuCDLZNgf1DlDTNs94YgP6K0KdJQLSnL20b2fELXijit1KQEV3JadxpsQfvZ6Os70ufAuTublV0ycD54qyx/ZYfR5XIF31s4mfVaQzVb9M4ZMgIQPGv3eNXNLPEHNIXv3WHU09QzoO1aLhAbaE5MGAYrcZO3CHVggTeYNe4Ya+y4Q82OuRfwA780Wz3+NwJoadeK/sFoD0uQGZiVa5mb73/9tnWMMUkhSUdgYy72nEIFh4oxw1OmQE5PV5uEIO7TnvkFBuU2VkSTLp1yBIjKOfpbw+rWH+miUYchWWRlsw8pHlHd83OmUMdg21V8kPH8k5vLRhxK9CJ4c8paU4PiT37+MOYJWf7JqC7Q/+o3ZVluA2LFLsnV33R5dEulugrf87moEPkbLGj+EbM8/8DzQZD8rgpu3cYu4GjGuIr5iV1nrewS50sfYxSv83HvvxcUTirhQ/Wjua8mfJ+g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iLvOdS/JFaQrQLgyvVYqCOZ9ZRepRBNpN2vEeFduNsUZXToOpFAx0B6QPGdz/gPMp/MCwU+KSWImiMndSlG2++BBXTmmamThr0UyFNWVfFRZfntsNScYL8DjmE84z3trZqp6fVN46dd81uPKTP2XlhAUnzxBjcY0LqLtQeyITwr+wF4cgPz4BBD3wA+xUJESJ7v5md6oVf8z87WaDlRGZcnY+/VfSXV4KjLV/Jch2vfwbJvwwqa4rgXFemjF9hWOHTiY2N84AhyNpYg6sKitudPZ8p9WZzhkjWyS00ozPGpmzGKETCIpM7bAJmOsyUnXkgyM3gB2LPgDOQtnttKi4GdQg9I3vn409ghV98VF4yrK5pM2Gg7YN1frbQGVe2/Kn9FMrvgsObRRCPgzzrWHU5dzmAsOh4vwzsz9CfFZq2NQSSMeXt84LJwk4uer+25D
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:30:50.4204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39affc60-6095-4bb4-a7d6-08de89a12f11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,google.com,davidwei.uk,fomichev.me,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18570-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5AA613088DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

This commit makes use of the building blocks previously added to
implement cross-device rate nodes.

A new 'supported_cross_device_rate_nodes' bool is added to devlink_ops
which lets drivers advertise support for cross-device rate objects.
If enabled and if there is a common shared devlink instance, then:
- all rate objects will be stored in the top-most common nested instance
  and
- rate objects can have parents from other devices sharing the same
  common instance.

The parent devlink from info->ctx is not locked, so none of its mutable
fields can be used. But parent setting only requires comparing devlink
pointer comparisons. Additionally, since the shared devlink is locked,
other rate operations cannot concurrently happen.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-port.rst       |  2 +
 include/net/devlink.h                         |  5 +
 net/devlink/rate.c                            | 92 +++++++++++++++++--
 3 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 5e397798a402..976bc5ca0962 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -417,6 +417,8 @@ API allows to configure following rate object's parameters:
   Parent node name. Parent node rate limits are considered as additional limits
   to all node children limits. ``tx_max`` is an upper limit for children.
   ``tx_share`` is a total bandwidth distributed among children.
+  If the device supports cross-function scheduling, the parent can be from a
+  different function of the same underlying device.
 
 ``tc_bw``
   Allow users to set the bandwidth allocation per traffic class on rate
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 3038af6ec017..8d5ad5d4f1d0 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1585,6 +1585,11 @@ struct devlink_ops {
 				    struct devlink_rate *parent,
 				    void *priv_child, void *priv_parent,
 				    struct netlink_ext_ack *extack);
+	/* Indicates if cross-device rate nodes are supported.
+	 * This also requires a shared common ancestor object all devices that
+	 * could share rate nodes are nested in.
+	 */
+	bool supported_cross_device_rate_nodes;
 	/**
 	 * selftests_check() - queries if selftest is supported
 	 * @devlink: devlink instance
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 1949746fab29..f243cccc95be 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -30,19 +30,53 @@ devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
 	return devlink_rate ?: ERR_PTR(-ENODEV);
 }
 
+/* Repeatedly locks the nested-in devlink instances while cross device rate
+ * nodes are supported. Returns the devlink instance where rates should be
+ * stored.
+ */
 static struct devlink *devl_rate_lock(struct devlink *devlink)
 {
-	return devlink;
+	struct devlink *rate_devlink = devlink;
+
+	while (rate_devlink->ops &&
+	       rate_devlink->ops->supported_cross_device_rate_nodes) {
+		devlink = devlink_nested_in_get_lock(rate_devlink->rel);
+		if (!devlink)
+			break;
+		rate_devlink = devlink;
+	}
+	return rate_devlink;
 }
 
+/* Variant of the above for when the nested-in devlink instances are already
+ * locked.
+ */
 static struct devlink *
 devl_get_rate_node_instance_locked(struct devlink *devlink)
 {
-	return devlink;
+	struct devlink *rate_devlink = devlink;
+
+	while (rate_devlink->ops &&
+	       rate_devlink->ops->supported_cross_device_rate_nodes) {
+		devlink = devlink_nested_in_get_locked(rate_devlink->rel);
+		if (!devlink)
+			break;
+		rate_devlink = devlink;
+	}
+	return rate_devlink;
 }
 
+/* Repeatedly unlocks the nested-in devlink instances of 'devlink' while cross
+ * device nodes are supported.
+ */
 static void devl_rate_unlock(struct devlink *devlink)
 {
+	if (!devlink || !devlink->ops ||
+	    !devlink->ops->supported_cross_device_rate_nodes)
+		return;
+
+	devl_rate_unlock(devlink_nested_in_get_locked(devlink->rel));
+	devlink_nested_in_put_unlock(devlink->rel);
 }
 
 static struct devlink_rate *
@@ -120,6 +154,24 @@ static int devlink_rate_put_tc_bws(struct sk_buff *msg, u32 *tc_bw)
 	return -EMSGSIZE;
 }
 
+static int devlink_nl_rate_parent_fill(struct sk_buff *msg,
+				       struct devlink_rate *devlink_rate)
+{
+	struct devlink_rate *parent = devlink_rate->parent;
+	struct devlink *devlink = parent->devlink;
+
+	if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
+			   parent->name))
+		return -EMSGSIZE;
+
+	if (devlink != devlink_rate->devlink &&
+	    devlink_nl_put_nested_handle(msg, devlink_net(devlink), devlink,
+					 DEVLINK_ATTR_PARENT_DEV))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int devlink_nl_rate_fill(struct sk_buff *msg,
 				struct devlink_rate *devlink_rate,
 				enum devlink_command cmd, u32 portid, u32 seq,
@@ -164,10 +216,9 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 			devlink_rate->tx_weight))
 		goto nla_put_failure;
 
-	if (devlink_rate->parent)
-		if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
-				   devlink_rate->parent->name))
-			goto nla_put_failure;
+	if (devlink_rate->parent &&
+	    devlink_nl_rate_parent_fill(msg, devlink_rate))
+		goto nla_put_failure;
 
 	if (devlink_rate_put_tc_bws(msg, devlink_rate->tc_bw))
 		goto nla_put_failure;
@@ -320,13 +371,14 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 				struct genl_info *info,
 				struct nlattr *nla_parent)
 {
-	struct devlink *devlink = devlink_rate->devlink;
+	struct devlink *devlink = devlink_rate->devlink, *parent_devlink;
 	const char *parent_name = nla_data(nla_parent);
 	const struct devlink_ops *ops = devlink->ops;
 	size_t len = strlen(parent_name);
 	struct devlink_rate *parent;
 	int err = -EOPNOTSUPP;
 
+	parent_devlink = devlink_nl_ctx(info)->parent_devlink ? : devlink;
 	parent = devlink_rate->parent;
 
 	if (parent && !len) {
@@ -344,7 +396,13 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 		refcount_dec(&parent->refcnt);
 		devlink_rate->parent = NULL;
 	} else if (len) {
-		parent = devlink_rate_node_get_by_name(devlink, parent_name);
+		/* parent_devlink (when different than devlink) isn't locked,
+		 * but the rate node devlink instance is, so nobody from the
+		 * same group of devices sharing rates could change the used
+		 * fields or unregister the parent.
+		 */
+		parent = devlink_rate_node_get_by_name(parent_devlink,
+						       parent_name);
 		if (IS_ERR(parent))
 			return -ENODEV;
 
@@ -625,7 +683,8 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 
 int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
+	struct devlink_nl_ctx *ctx = devlink_nl_ctx(info);
+	struct devlink *devlink = ctx->devlink;
 	struct devlink_rate *devlink_rate;
 	const struct devlink_ops *ops;
 	int err;
@@ -644,6 +703,14 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 		goto unlock;
 	}
 
+	if (ctx->parent_devlink && ctx->parent_devlink != devlink &&
+	    !ops->supported_cross_device_rate_nodes) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Cross-device rate parents aren't supported");
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
 	err = devlink_nl_rate_set(devlink_rate, ops, info);
 
 	if (!err)
@@ -671,6 +738,13 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!devlink_rate_set_ops_supported(ops, info, DEVLINK_RATE_TYPE_NODE))
 		return -EOPNOTSUPP;
 
+	if (ctx->parent_devlink && ctx->parent_devlink != devlink &&
+	    !ops->supported_cross_device_rate_nodes) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Cross-device rate parents aren't supported");
+		return -EOPNOTSUPP;
+	}
+
 	rate_devlink = devl_rate_lock(devlink);
 	rate_node = devlink_rate_node_get_from_attrs(devlink, info->attrs);
 	if (!IS_ERR(rate_node)) {
-- 
2.44.0


