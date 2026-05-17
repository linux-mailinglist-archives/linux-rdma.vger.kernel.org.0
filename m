Return-Path: <linux-rdma+bounces-20836-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JY/MWSmCWqpjQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20836-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:28:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C525560B73
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BB843024C93
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 11:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FDE35CB66;
	Sun, 17 May 2026 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s+EAq9SH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0BD8BE9;
	Sun, 17 May 2026 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779017247; cv=fail; b=BZ3oqOAZGlfpvwUkHEJqBlljrXhtHHGbSo4ljygKBjlz8fyOUbZA0oZKvkV9xssLjoi0hDezJGioN8uF76tsWkN+maNGCbXhvLth7DHttL2nnCGmbzlvQoDosGiD3oEvUBFI1BJkoMPRnlHIME5vYB4g8vQt+IOvYmhKut3Q0ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779017247; c=relaxed/simple;
	bh=j2lsjXtnX11zyAD1exa4mtOsl15ZNbH4ZTjqlfHRJjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABiX1uofVrb3VzELpffOe4acpNZG1xd3qFc9oJoy1ot0HKEbChSU8p+ClrGrGgzTs/D77uiFO/HgFmfjxLhMSDtXOlnL90F58Onm+24JhrUt1Msh9KowTEUsHBpMuhc4MtDmqMCqwk8L/DTPdpaVF2h0NATpz7FbgFu4DkonjCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s+EAq9SH; arc=fail smtp.client-ip=40.107.209.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zy66LghFyuYhbyPWkY2snVZ5ajvuU7Qqicb29tYcs/6TaHYtavz4Gu2Mngm6t4u51mXEAxrflmYI1Zt/qpLZQvpSgwUQzZ/bjsnN/pC3QaNr4lho5RaMP7q+JgbMyXU1ZCsIagZ36S4QE/GH5TWRa6+04cAH+EC1L/SuZXrENw8v7KToZgjI7tpnYHKsnFGlqyWTZNNO2BTe5mrYzi2LomQpXWsRb+bMX3HlUvuDRym0sLMbfZmsWXxo8mwvQXg5hRaCg4+zQLK07T79i6kxkdKObLPPn9wvyyVKEacIDaIrSQrYgaTJ78XtT0wwuMgIrh/I8YwZcuoBPUlsGDS16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMN5W+8RyRdlAKWymBV2oQizIWstw4dOqqP0ZpR2dqY=;
 b=K9fa1944DrEWVOe8PjK+HRDCzuNbUzxxmsIfpNk6xn0RwCpVJ9rEmqDCjAqar68BQj78FNDXRYfIui8LoKy/MGP1LMLZommXKZpFwI1XWvzFOdvapOmGdW1feGyPRWCevtskytmJDl6mi5Qq2ThmTcZZf8bbi4pvEIgfWZbzwL/dlIKNiRbvbNaHN7E9OrPf9n4qMq982MJq6NX6aLLzk5wm54YKUlNbo/7RillE8J5jRFTZ2yB0P/CB3CKJQOFil1R43CbrIMT9CP4Vcmb5p10gdHNEYbmJxgN3HIy5wVmH3qrpyE4alv43pVUbAgPEGisjHG2Tj5QYO7lt0jtRMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMN5W+8RyRdlAKWymBV2oQizIWstw4dOqqP0ZpR2dqY=;
 b=s+EAq9SHvUlZ/8CLnLEM7cxcK60N4OvpmlgIpxKbr6zlPgkSQAhUkzcHsHti3xZQF4FdvCK4J+luATJ4NuMZFw4vmodpWYvmq7Wao3Agg/3gZwH5GMECkz4o0+5IfflrPgkQj2qsApwQLsOcLzAOb5AWfJLWkZxYJCS5t9qunnUXEbIw6N7wucI11kTJEPIx0Qw6esDGjR7tLT5uJjAEipBF4hqJhFxGUhEJLIOOja2wQjMcgNtM+RAs/MCHP6d7t0SQLII6U2SXd1/PxxbmqTy5u442f1J8RJtxZ+dS4GQniVLvOoZRuqKb+XFtHz/60W7D9OqBEq4OZJSXTer57g==
Received: from DM6PR01CA0016.prod.exchangelabs.com (2603:10b6:5:296::21) by
 SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Sun, 17 May
 2026 11:27:20 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::b0) by DM6PR01CA0016.outlook.office365.com
 (2603:10b6:5:296::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.21 via Frontend Transport; Sun, 17
 May 2026 11:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Sun, 17 May 2026 11:27:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 04:27:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 17 May 2026 04:27:17 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 17 May 2026 04:27:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dumitrescu
	<vdumitrescu@nvidia.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Daniel Zahka <daniel.zahka@gmail.com>,
	"David Ahern" <dsahern@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>
Subject: [PATCH net-next 1/2] devlink: add generic device max_sfs parameter
Date: Sun, 17 May 2026 14:26:59 +0300
Message-ID: <20260517112700.343575-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260517112700.343575-1-tariqt@nvidia.com>
References: <20260517112700.343575-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e9e4bf-611b-4433-015f-08deb407422b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jdALpJj7qGlUryYnWgCzoe/2g30sIXd7ltQQI7v/RTIDA65nQfo8A1sdICRjFMnKHN6/BVdXRsilM8FmEY42L9izbbyMzfRAtg2Nv1GBD+bQrPrm6yUs5btuBiHrvElgBpSVFVmy1MVrVpG+JQqR7VY2FYSW5T51EwtmW9KkoG2BSkJEXJc2XfsVNFc651s/gxBF84aT8sqIhwPuC+VxqNA+rjiaKs3CFEYYYJk1dhvfXZEmVIMn8unNVpMRGUvmeo1BfcvnOj+/RFwx12FpFzHF59CCP3i4kjjBvVpzTgLTBApdy0rlZLe2epQB34nKcJBndFHP81e+RI0H0mnArFQdSAtjBhSpQoqtVyp+OKVlUxGkfFhGYJadDaTeDMxFC6P/tHXxG3tfmS4wMiJ7lgdt0URindwrWuMUpcUyfshzsIfk5BxIakjtLZJf1tDrKhIaXl/bZwjKmAdQLZSlkwqqSGDSQxQWqAa3GqG04CnRhGjTgS0nZUEXFggDsA0xlxYyPgMPhpTy6+Q5zObcpKPm3o5tXE2XLEfFsCoFIHLw4j61Zs5OxD7FP+VwroqVWtiPWEskEIYzXQkQBDdFuHRm7ulNwVMWnkf5RHrCf3ja31BoFl2P9LeDRFnh3w+/pTRA2VFgoClaDJPhtTQ+izcH9wtKkKlVepasSy/f9USwstVMegC+SMHJxbRqCSJCbb9MaKS6O/Lxn8CQnlwmzvvCIlsRmVDl4DHYw5TpHFg=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IUJbNXnNO4o/Y1ZHfCgsbts0zUewebXZHjTb0CLkldY77hbwjMfG/iug5T5T6VrJFGyWKLf/ZfAWO16zTKAEg9GdmBbbhyg/uDRMqU4ntJvceyxJ+uTNgT8DModPj80p7tkt3gzFiobT/d0qHZw6Y84b3VA6NqzsmEGjLFdnZekm+d1Mf/k8daittXUXMw4NdSmVVELQWF+iWy0qArWvLxc2PEPAk6IOv6KX4GfmxJUkkp0Gf+nMKsgUlfOGsRUGqNve23T8hhCioRNP5NHpWVdJTKGnMx9fo8ruwIxJrflL8ETwHPGUMu9XYcR9aFYpy4VAxt45qu+AqOedFueNpbNglqIWYqSx2aTVXDmFunEa/1z65ud78qrNMNFda6Si6S0PE7Mh/gSUTC6eBte1fEuAFbqRWuFI5EgSbJewz0mCTrBcQkWHMNN7pb37hMgJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 11:27:19.9614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e9e4bf-611b-4433-015f-08deb407422b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812
X-Rspamd-Queue-Id: 6C525560B73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20836-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[resnulli.us,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,intel.com,gmail.com,blackwall.org,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Add a new generic devlink device parameter (max_sfs) to control if and
how many light-weight NIC subfunctions can be created. Subfunctions are
a light-weight network functions backed by an underlying PCI function.
Their lifecycle can already be managed by devlink, but currently users
cannot enable them in the device. They can be enabled/disabled only via
external vendor tools. This parameter allows subfunctions to be enabled
(>0) or disabled (0) via devlink. A subsequent patch will add support
for max_sfs to the mlx5 driver.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/devlink-params.rst | 6 ++++++
 include/net/devlink.h                               | 4 ++++
 net/devlink/param.c                                 | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index ea17756dcda6..29b8a9246fb6 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -165,3 +165,9 @@ own name.
      - u32
      - Controls the maximum number of MAC address filters that can be assigned
        to a Virtual Function (VF).
+   * - ``max_sfs``
+     - u32
+     - The maximum number of subfunctions which can be created on the device.
+       Modifying this parameter may require a device restart and PCI bus
+       rescanning because the BAR layout may change. A value of 0 disables
+       subfunction creation.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index bcd31de1f890..4ec455cfe7a4 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -546,6 +546,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
 	DEVLINK_PARAM_GENERIC_ID_NUM_DOORBELLS,
 	DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
+	DEVLINK_PARAM_GENERIC_ID_MAX_SFS,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -619,6 +620,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME "max_mac_per_vf"
 #define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE DEVLINK_PARAM_TYPE_U32
 
+#define DEVLINK_PARAM_GENERIC_MAX_SFS_NAME "max_sfs"
+#define DEVLINK_PARAM_GENERIC_MAX_SFS_TYPE DEVLINK_PARAM_TYPE_U32
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index cf95268da5b0..523243e49d88 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -117,6 +117,11 @@ static const struct devlink_param devlink_param_generic[] = {
 		.name = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME,
 		.type = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE,
 	},
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_MAX_SFS,
+		.name = DEVLINK_PARAM_GENERIC_MAX_SFS_NAME,
+		.type = DEVLINK_PARAM_GENERIC_MAX_SFS_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
-- 
2.44.0


