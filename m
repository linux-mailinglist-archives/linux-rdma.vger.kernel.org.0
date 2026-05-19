Return-Path: <linux-rdma+bounces-20993-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGuoEBHEDGo+lwUAu9opvQ
	(envelope-from <linux-rdma+bounces-20993-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 22:12:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7207584890
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 22:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F56D30E0644
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 20:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54333B7B79;
	Tue, 19 May 2026 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IgF2iANL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEF23B52F4;
	Tue, 19 May 2026 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221150; cv=fail; b=OoMf9FMZ7qwwVk8BkLIw/23JAFUV7CzCeFdQd+u5tFRAVqYcZt1EXDNQbDLxcoz+IKq5BqVsHbPyRaFDuJFkiJzcgvcfAZn2yqAbdeP+66KfS21mvD0SCKCYoHLN/gW1mGkksmGJfF7ghcVqhftLYSTta1Pz3p5Siurrz7kKiIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221150; c=relaxed/simple;
	bh=aFkA4/vpjN6JJDQ8eB8SPCi4f/Qp10g1nD8Yn2Cv1dM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGjFWY4Ps5CnKlj2m5Q077k65NFeMAxEWiTWPb8y6Kl+5R3Tzn33saeja3eMQ2JKusq8dbCROP/32DqoDTV5RQT+kN325ms74FmiAx7UipldOzQyfrR86Pjq/ogbngo/tWHv69QJVopANNEagIQIB2BUKwgRmhTXpS11uiQm3kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IgF2iANL; arc=fail smtp.client-ip=52.101.56.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwGyoAKzm4xP+ZYHFsoA9KFbWmsH+gJO+OYolveiqRlY2ofAjPQo81/beJ/7eAWinut5ndfg5waVBl7iJSf162uvMhaFhJqqjMZoawRxEOIFarjhBWVOKtS/lW3o5dW5wdPPRy7SRH8JBSNam4ybm5ePPYITslAdXVPsGgYhpENRbf2O1ZxzHI6oqfoeDcwT3yeW40xD+bb3htqY8+GVP1qPEXAf1EkdWbvXRdiEaOtIaO2C/M4gC3usBjLUtUmIv3cE4ooQHjWU/9w3TlcQH/VLPvbRxkh1sE8tKUr3o9Awre/ajMcZfjEvoLPPo/IXwI3FgrbRfpE4VLfbcFWPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2X3UErV7xQcXYjOfUaq1WGZFVviKDTv7Jy9Svx/MzeU=;
 b=TOOehqzRTFkXXz4T8eOfYE2odQWgnU+HAVx434rzeXpN3r4G/dwY8g+Wp3+pvDH6JMIYYR/rEtR9Bz44+ThA05HS5EPMfuKOZM80OsGGzVBAcspLYqM7olmlid5zHzRH6GpIfnle0oSF37XW3oiLgA8rX/KgkfuJbOosjiEkAtP2PeS81iA6lO/qp4rvOa/m4uW5vfcNqtxYKVpYz+T24/dieiZy9Xd4mFPV55Ac7ID0r6l0/L1wdyqNVO97EoF2txeI8C5D63Z0IvBsziJFa3VZInWrZIAbuvi3+7tcxGrdOGEVwHQeJoKJuq5H92uGMO3NvXxjLAPCBEwVH6FNvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2X3UErV7xQcXYjOfUaq1WGZFVviKDTv7Jy9Svx/MzeU=;
 b=IgF2iANLy41Q+oOaCMw5CWh55LzlHEkc0hMoJAg3NfEEi9fPy+KwECF+Ps8t9ONkyIUT8dCZL/evGjtY5MugDyWUup1Ex1I8wqQ+N8pAI9TRv9WlUO2cXs7kdDFtx2SxngYP0FQk/9RvoLlmRmpUE8UVJx1+H5OMz4Dj92jAQ9nPtHbtpTREHAFwPHb5qcSkBWmMl/9TFi8gs0Ni0EttwZck6Xk8G+K0Y6tK/EjiuG3GzZaZ453ShfpUaxOZ0hJJL+rA2WxNrvyCgoZRIfftKO5VJP/7lPa+4BU0xO8FKWyKTdhz/WB2Jg0/P5lHawy/pvurMMInsM3ZupgVnNuCBg==
Received: from SJ0PR13CA0061.namprd13.prod.outlook.com (2603:10b6:a03:2c4::6)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 20:05:40 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::8) by SJ0PR13CA0061.outlook.office365.com
 (2603:10b6:a03:2c4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Tue, 19
 May 2026 20:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 20:05:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 13:05:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 13:05:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 19
 May 2026 13:05:03 -0700
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
Subject: [PATCH net-next V2 1/2] devlink: add generic device max_sfs parameter
Date: Tue, 19 May 2026 23:04:35 +0300
Message-ID: <20260519200436.353249-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260519200436.353249-1-tariqt@nvidia.com>
References: <20260519200436.353249-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab3dcb4-f61e-49be-6c0c-08deb5e1fe8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vPqd9BH9oXSWoCLd/bg5f/Iu1FqanpEgCRykgbWoUFKBU1vK1ZHkHYguYQ/wnb8LMD1yik9hGzI7jGD2QCZxjFQqKG/N+DN7jo6B9aBRIuqyD5jr8r6y/9jTIgZi9N2hdTP4984spTWRtfG0U8iSeIzaeQMnlfj/nrozZXX/RRCbsQQn2f8rc96AxGleU/Rn3OWnQefaHx0qQTnU3FJBVQDe1xg8JNRrD/QqbeUhCPYcKTOHSmahgwMFZn31Hq4tWYy0qfMpUFXJeA0jTC3E6beRn25a2WjqabsUm0IAwUse6m+ER4H8CXXDriXBqvKImi1t6kGC48Axb8VcPN8EjFa1kquSYZtgpvsqKdhWnL8weYFlZUpcdnPYK1IXqmrEu1wSAqHoPAmNXybsiAAxGS9Dlchi01uIEiRXZUzG8h+xrTgaVGXIv/wtQT6nVp67sfUQmNQc6BtOV4I1vGB2k8BMncEXp6OAqu8l75/dKxmSAYZnzX29QoFx8Sdd1yD4N7p/8/iLiVQuQLRsChBSxITkNhS55Ept7sTnbRp/IOjyO5hEsr2VopOUHHgVVJV8iLXJUrGIr1XdYI2sJ0vVl1IIRiooiOljgFw4yE388lEF0t5IMiadT6SMm5jU/n3tzlXEjok8FklChdk3R/cKa6HOdcg3+3jzCWDC+uZ3BqvYfwLqbr4EytKivw84L0EstlBaZaGU1BTEe2Bk34ojHPJUwyr86bfWUzIf06yV+ZA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	voDigP675mUaSAs+pEe7jWihc42ut43R5dz+I9N/oeU5PNzATbExmZf9nidnvFYDMPEdqQYre8WwoTXUguRBIR76LsojXyOzq9e98MNrl20BFEXFyC1nPPb63y/a7YH4Gjr4Xpqves7jdR77SrLYTdCDymsZBAN67ocFxggNpJ+ZlC/cr62Wm1qX1uVDdPFwElgCw6qRE6PpXXSy8+W4/wAGln4yNx4sYwSPVKqF0QMThvLxJpHp6THu+6nxeoOxed3a5Ral/AJf1Truq4j2iOdEOYl/KYpSNs+nVWQWU+6BJURY0VwugbPE5dUizg6e9HBmcrBxVLl1rBKK9ODthSdrpaZSzkGayAW3/sU6xGzj279ITbN5mJKdWnoP8epOV8xQjlCPYIhLrMmFDiPa5YDmsDf9fsKKZTudFxxYdQWPRObc7tdzhigoaUse8bmV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 20:05:37.5227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab3dcb4-f61e-49be-6c0c-08deb5e1fe8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316
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
	FREEMAIL_CC(0.00)[resnulli.us,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,intel.com,gmail.com,blackwall.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20993-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D7207584890
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
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


