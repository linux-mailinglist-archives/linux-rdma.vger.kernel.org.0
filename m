Return-Path: <linux-rdma+bounces-18693-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOBEL9LbxGlf4gQAu9opvQ
	(envelope-from <linux-rdma+bounces-18693-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:10:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61061330457
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 048B2311864E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 07:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AD53B38AE;
	Thu, 26 Mar 2026 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PsdupuY1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC4A34EF17;
	Thu, 26 Mar 2026 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508560; cv=fail; b=Z49M6HKSku8kK6wkkQmXV5xUgY9NZtK6NtHidZWeLzhfdTMUcz3UphtIwidnXebDoNb9kPP8FhxYiTHI/OKR3S6SaL2ubdHpEEB6mA8/abUQvJDSQiB4O2x4+jija93wKi2YKl2QdjriU8Xg49rDnOVzxit5FjUgChKUqta71rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508560; c=relaxed/simple;
	bh=3tRp1Tl7cnTBYzq1fxHhGd3GgGOpGo7kUASOclnx200=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKKm5N+N/rSUWb4p07zfnzYulgYwFHWWGT/gPxRkBcVphLvJ4vrIzWC/hf4BPRaGl+RGTTwhZB8tds4hFpnw0IIJu+/8GDSuI40h3T8fZJj+oCy+eQ02pqqpT0kY0EAz9Lcn7o8qaiNz63IKhY7s8DzZBZAc/aAQapO28PUmiHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PsdupuY1; arc=fail smtp.client-ip=52.101.61.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eX5Ths+Sc8XgbikS4EvbCUEBTorZyx9rgxFUp92KXiVz9KgQbuV9U7f47hOh5OGk3DQX9NQad213nroJM4jjP7oQ2DFSOTVc5XYB/pkWZpkvz84fTzrC/WAN1mvSWMOXE3K276ZVkJmR8CJlSne4P89Zcx82kOiKQJK9NfunfNiYuFTSlklgfkt5GgLIs1lxRwT1AyaAV7NnOKt5/KlOhgsZUzK60U0SUJJQ25DvJ2E8pJLbrrj8d2xthVpRjdQMF79W2PbBGtXzLUjZy6rmsqWnxbIm1B7gQaAv9Rfc4Nm8SW+NiYUfSZV98hR0YW805YuwQY9K483LuFEpsNDMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYaSUoiSM4D57t3xKo8f+e72plB42i65FopkWWskc80=;
 b=PpZFwAxQVRlXNf2eXvwCgHeyngGuVmcFt1ZG2Yvi79yNGB6zP2YNNc4Pvo9BeV+nWOGsyRXS35IFSPUbN8jL5J8n/ayDgp5hCyOWfzEH+DMAhEGbfU4crKCYWMk12Lg64sWSJDN/9LfGVJyTPS29QMY94MJFjx5dunNHqC1oKCC+wqJeAc2eR04PWty+Kqfygi+edMpZbIU9ogHfU0gUc7FBPafFtMtTdqRZlpg//VJCn+QIam8SntNxmJod2WHvrkPUE2aO1Z2+hvyIcbV097BiTL0PW7I3TLNl/NpycTpgmI2OrKn64hqufulztmKtxRZlL7B6gMpRqdszV9ofSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYaSUoiSM4D57t3xKo8f+e72plB42i65FopkWWskc80=;
 b=PsdupuY1G9pT2bj5RYwMysPNVMx22qXFa4pHzLo+uCccB1O79AnClg1G/a5+5UzFpCCSuUcvWJOgCl2G/Ctb77PKNbehwY7WDONHgFJ4677Uc+glorUbp+r7qnQIlfEqsUjEEcwaZRt8rgCgGlqY78m3Xkm2PDkeLLOSJEE/0SKJdpTWPW2AuxLrlgvrrKwhlzq+vMm3KQHKbm+JBIPIgGV3JOp6JgDuJ4iyAisNpBvVvnObXDx5Q72Qdh8s6ow1p4MLqWF2KJk1YzAe8qcDSHSENaffQFgX0ytwFsUYC4DDiKqL9LxkVAkgZdNe6DnLwPwt7Hym/4gwWTreqhE+QQ==
Received: from BN9PR03CA0773.namprd03.prod.outlook.com (2603:10b6:408:13a::28)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.21; Thu, 26 Mar
 2026 07:02:27 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::3f) by BN9PR03CA0773.outlook.office365.com
 (2603:10b6:408:13a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 07:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 26 Mar 2026 07:02:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 00:02:20 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 00:02:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 00:02:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Shahar Shitrit <shshitrit@nvidia.com>, "Daniel
 Zahka" <daniel.zahka@gmail.com>, Parav Pandit <parav@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, Kees Cook <kees@kernel.org>, "Shay
 Drori" <shayd@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Daniel Borkmann <daniel@iogearbox.net>, Joe Damato
	<joe@dama.to>, Nikolay Aleksandrov <razor@blackwall.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, "Antonio
 Quartulli" <antonio@openvpn.net>, Allison Henderson
	<allison.henderson@oracle.com>, Bui Quang Minh <minhquangbui99@gmail.com>,
	Nimrod Oren <noren@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V9 11/14] net/mlx5: qos: Remove qos domains and use shd lock
Date: Thu, 26 Mar 2026 08:59:46 +0200
Message-ID: <20260326065949.44058-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260326065949.44058-1-tariqt@nvidia.com>
References: <20260326065949.44058-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: a41aa111-0097-459b-0962-08de8b05a369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ukI2D1kfDPKCN1XbKHnesb1BcnE7yF/dOK04KXY1cJnzsQ6b5jAgLTi37p64dkxr1aPZ6KsBb2lCymqc5Rp4gXtS279N9rgapmsK5ZFgySxZD3yYIOG1dDXRI8unL90/SfVowgw+znfdyJwBFxE9lzEXHrDt5yio3p2CT3HIPBvxMXrbXV0p104Ir2J8UOUi1dclr72YbP3TQqoBfDac4zKnMOiV/UHyoRNihh5quvjU5Sq1zqg4PFB86ThY7xapAVC685G1z0FXI44UKHEUVzgdrXIZjqBaiZaVZqV8DIqAu8lrsHnILzWGz9Oix/KzxhOGquGZOPOrYyEY1Vur14CHNEI8/A7xp1YebE8zGx0ReNGYVY8aGvbuwKWaABXxeOEArvIoTdQQ9uSAiqPYvMTtG1VYubo7tMnjZVpL16YbzyIA+U2CvIKS0bEREnv5nXhwJBHTlecgtlwYqsLIZGT+PWDqxF2t67wgOiwlVlxVo1TjoNTjJWutQ4A4wznRm/wIVj3qBWGezvPRix/MpxBoAoKDdFq3jUmQgd8u4F8vKUIsG3LDs1FLlmPD+QFziHgn0ZFcfRKrnttmmGFpc80+Wqr+rpwITdvQLQMn3e2DNUviDhnnHrGwYQzeTT97iEATt4Gh27FWY6JfxbHSj3Y5IGMQZ5oA7CqqiVXhXJS/Qz0aayui49z1sP7lxTvl6UKDqaMXO97gX+FwhppoDbiOe2R42/tfw5M+raHTtQZvmdJ9NQ4W6riEP5lpsuGtm1EL52QKCOOH6KBckYaWAA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Kql9cfvNDod1ocksJyNdRF0wsqAlKD55+LUQhEQap+Srih4mQg37yDnpbqi8K7TYpbMjzI3XnLIWjcBH215RlbthzPcikIY/P/q/ciKvDNCZ0NAM3K3k/G1G7XRUo90nTYzwg+vthIM8JnEpv8gmtHEDxSg2j+EwEsoRZoD2+fQtRMemN/1WwuaiDLwodSP02M87f/bPEExeuQBGtRBsJJkvhk36enmk6TY172O8pc6731beMUPDOtdsg3lwXpuvwysBvuQrRavMyUP392vwJVsYvSbDTcCn6/KmHE/yXHs2rXNy8+SLm53uvPj+UkOlRuflFipzXWAZguQM4bn75MB+dpa8GxFlmdc/SKQrktMKJ4HEpM0ZJzC345C45aPu3TH+7fRWeJNOO1DuWeWxSfzhJAxOHtjwBK1srsqawuclFZTwstXfyC8db8ybXyb6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:02:26.4276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a41aa111-0097-459b-0962-08de8b05a369
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489
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
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,google.com,davidwei.uk,fomichev.me,iogearbox.net,dama.to,blackwall.org,linux.dev,redhat.com,openvpn.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18693-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 61061330457
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

E-Switch QoS domains were added with the intention of eventually
implementing shared qos domains to support cross-esw scheduling in the
previous approach ([1]), but they are no longer necessary in the new
approach.

Remove QoS domains and switch to using the shd lock for protecting
against concurrent QoS modifications.
Enable the supported_cross_device_rate_nodes devink ops attribute so
that all calls originating from devlink rate acquire the shd lock. Only
the additional entry points into QoS need to acquire the shd lock.

Enabling supported_cross_device_rate_nodes now is safe, because
mlx5_esw_qos_vport_update_parent rejects cross-esw parent updates.
This will change in the next patch.

[1] https://lore.kernel.org/netdev/20250213180134.323929-1-tariqt@nvidia.com/

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   1 +
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 186 ++++--------------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   8 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   9 +-
 5 files changed, 45 insertions(+), 162 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 6698ac55a4bf..c051605fecd2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -385,6 +385,7 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.rate_node_del = mlx5_esw_devlink_rate_node_del,
 	.rate_leaf_parent_set = mlx5_esw_devlink_rate_leaf_parent_set,
 	.rate_node_parent_set = mlx5_esw_devlink_rate_node_parent_set,
+	.supported_cross_device_rate_nodes = true,
 #endif
 #ifdef CONFIG_MLX5_SF_MANAGER
 	.port_new = mlx5_devlink_sf_port_new,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 0be516003bcd..f67f99428959 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -11,51 +11,9 @@
 /* Minimum supported BW share value by the HW is 1 Mbit/sec */
 #define MLX5_MIN_BW_SHARE 1
 
-/* Holds rate nodes associated with an E-Switch. */
-struct mlx5_qos_domain {
-	/* Serializes access to all qos changes in the qos domain. */
-	struct mutex lock;
-};
-
-static void esw_qos_lock(struct mlx5_eswitch *esw)
-{
-	mutex_lock(&esw->qos.domain->lock);
-}
-
-static void esw_qos_unlock(struct mlx5_eswitch *esw)
-{
-	mutex_unlock(&esw->qos.domain->lock);
-}
-
 static void esw_assert_qos_lock_held(struct mlx5_eswitch *esw)
 {
-	lockdep_assert_held(&esw->qos.domain->lock);
-}
-
-static struct mlx5_qos_domain *esw_qos_domain_alloc(void)
-{
-	struct mlx5_qos_domain *qos_domain;
-
-	qos_domain = kzalloc_obj(*qos_domain);
-	if (!qos_domain)
-		return NULL;
-
-	mutex_init(&qos_domain->lock);
-
-	return qos_domain;
-}
-
-static int esw_qos_domain_init(struct mlx5_eswitch *esw)
-{
-	esw->qos.domain = esw_qos_domain_alloc();
-
-	return esw->qos.domain ? 0 : -ENOMEM;
-}
-
-static void esw_qos_domain_release(struct mlx5_eswitch *esw)
-{
-	kfree(esw->qos.domain);
-	esw->qos.domain = NULL;
+	devl_assert_locked(esw->dev->shd);
 }
 
 enum sched_node_type {
@@ -1110,7 +1068,7 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	struct mlx5_esw_sched_node *parent;
 
 	lockdep_assert_held(&esw->state_lock);
-	esw_qos_lock(esw);
+	devl_lock(esw->dev->shd);
 	if (!vport->qos.sched_node)
 		goto unlock;
 
@@ -1120,7 +1078,7 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 
 	mlx5_esw_qos_vport_disable_locked(vport);
 unlock:
-	esw_qos_unlock(esw);
+	devl_unlock(esw->dev->shd);
 }
 
 static int mlx5_esw_qos_set_vport_max_rate(struct mlx5_vport *vport, u32 max_rate,
@@ -1159,26 +1117,25 @@ int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *vport, u32 max_rate, u32 min_
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err;
 
-	esw_qos_lock(esw);
+	devl_lock(esw->dev->shd);
 	err = mlx5_esw_qos_set_vport_min_rate(vport, min_rate, NULL);
 	if (!err)
 		err = mlx5_esw_qos_set_vport_max_rate(vport, max_rate, NULL);
-	esw_qos_unlock(esw);
+	devl_unlock(esw->dev->shd);
 	return err;
 }
 
 bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *min_rate)
 {
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	bool enabled;
 
-	esw_qos_lock(esw);
+	devl_lock(vport->dev->shd);
 	enabled = !!vport->qos.sched_node;
 	if (enabled) {
 		*max_rate = vport->qos.sched_node->max_rate;
 		*min_rate = vport->qos.sched_node->min_rate;
 	}
-	esw_qos_unlock(esw);
+	devl_unlock(vport->dev->shd);
 	return enabled;
 }
 
@@ -1513,9 +1470,9 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 			return err;
 	}
 
-	esw_qos_lock(esw);
+	devl_lock(esw->dev->shd);
 	err = mlx5_esw_qos_set_vport_max_rate(vport, rate_mbps, NULL);
-	esw_qos_unlock(esw);
+	devl_unlock(esw->dev->shd);
 
 	return err;
 }
@@ -1604,44 +1561,24 @@ static void esw_vport_qos_prune_empty(struct mlx5_vport *vport)
 	mlx5_esw_qos_vport_disable_locked(vport);
 }
 
-int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
-{
-	if (esw->qos.domain)
-		return 0;  /* Nothing to change. */
-
-	return esw_qos_domain_init(esw);
-}
-
-void mlx5_esw_qos_cleanup(struct mlx5_eswitch *esw)
-{
-	if (esw->qos.domain)
-		esw_qos_domain_release(esw);
-}
-
 /* Eswitch devlink rate API */
 
 int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
 	struct mlx5_vport *vport = priv;
-	struct mlx5_eswitch *esw;
 	int err;
 
-	esw = vport->dev->priv.eswitch;
-	if (!mlx5_esw_allowed(esw))
+	if (!mlx5_esw_allowed(vport->dev->priv.eswitch))
 		return -EPERM;
 
 	err = esw_qos_devlink_rate_to_mbps(vport->dev, "tx_share", &tx_share, extack);
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
 	err = mlx5_esw_qos_set_vport_min_rate(vport, tx_share, extack);
-	if (err)
-		goto out;
-	esw_vport_qos_prune_empty(vport);
-out:
-	esw_qos_unlock(esw);
+	if (!err)
+		esw_vport_qos_prune_empty(vport);
 	return err;
 }
 
@@ -1649,24 +1586,18 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 					  u64 tx_max, struct netlink_ext_ack *extack)
 {
 	struct mlx5_vport *vport = priv;
-	struct mlx5_eswitch *esw;
 	int err;
 
-	esw = vport->dev->priv.eswitch;
-	if (!mlx5_esw_allowed(esw))
+	if (!mlx5_esw_allowed(vport->dev->priv.eswitch))
 		return -EPERM;
 
 	err = esw_qos_devlink_rate_to_mbps(vport->dev, "tx_max", &tx_max, extack);
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
 	err = mlx5_esw_qos_set_vport_max_rate(vport, tx_max, extack);
-	if (err)
-		goto out;
-	esw_vport_qos_prune_empty(vport);
-out:
-	esw_qos_unlock(esw);
+	if (!err)
+		esw_vport_qos_prune_empty(vport);
 	return err;
 }
 
@@ -1677,34 +1608,30 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 {
 	struct mlx5_esw_sched_node *vport_node;
 	struct mlx5_vport *vport = priv;
-	struct mlx5_eswitch *esw;
 	bool disable;
 	int err = 0;
 
-	esw = vport->dev->priv.eswitch;
-	if (!mlx5_esw_allowed(esw))
+	if (!mlx5_esw_allowed(vport->dev->priv.eswitch))
 		return -EPERM;
 
 	disable = esw_qos_tc_bw_disabled(tc_bw);
-	esw_qos_lock(esw);
 
 	if (!esw_qos_vport_validate_unsupported_tc_bw(vport, tc_bw)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "E-Switch traffic classes number is not supported");
-		err = -EOPNOTSUPP;
-		goto unlock;
+		return -EOPNOTSUPP;
 	}
 
 	vport_node = vport->qos.sched_node;
 	if (disable && !vport_node)
-		goto unlock;
+		return 0;
 
 	if (disable) {
 		if (vport_node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
 			err = esw_qos_vport_update(vport, SCHED_NODE_TYPE_VPORT,
 						   vport_node->parent, extack);
 		esw_vport_qos_prune_empty(vport);
-		goto unlock;
+		return err;
 	}
 
 	if (!vport_node) {
@@ -1719,8 +1646,6 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 	}
 	if (!err)
 		esw_qos_set_tc_arbiter_bw_shares(vport_node, tc_bw, extack);
-unlock:
-	esw_qos_unlock(esw);
 	return err;
 }
 
@@ -1730,28 +1655,22 @@ int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
 					 struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *node = priv;
-	struct mlx5_eswitch *esw = node->esw;
 	bool disable;
 	int err;
 
-	if (!esw_qos_validate_unsupported_tc_bw(esw, tc_bw)) {
+	if (!esw_qos_validate_unsupported_tc_bw(node->esw, tc_bw)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "E-Switch traffic classes number is not supported");
 		return -EOPNOTSUPP;
 	}
 
 	disable = esw_qos_tc_bw_disabled(tc_bw);
-	esw_qos_lock(esw);
-	if (disable) {
-		err = esw_qos_node_disable_tc_arbitration(node, extack);
-		goto unlock;
-	}
+	if (disable)
+		return esw_qos_node_disable_tc_arbitration(node, extack);
 
 	err = esw_qos_node_enable_tc_arbitration(node, extack);
 	if (!err)
 		esw_qos_set_tc_arbiter_bw_shares(node, tc_bw, extack);
-unlock:
-	esw_qos_unlock(esw);
 	return err;
 }
 
@@ -1759,17 +1678,14 @@ int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *node = priv;
-	struct mlx5_eswitch *esw = node->esw;
 	int err;
 
-	err = esw_qos_devlink_rate_to_mbps(esw->dev, "tx_share", &tx_share, extack);
+	err = esw_qos_devlink_rate_to_mbps(node->esw->dev, "tx_share",
+					   &tx_share, extack);
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
-	err = esw_qos_set_node_min_rate(node, tx_share, extack);
-	esw_qos_unlock(esw);
-	return err;
+	return esw_qos_set_node_min_rate(node, tx_share, extack);
 }
 
 int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *priv,
@@ -1783,10 +1699,7 @@ int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
-	err = esw_qos_sched_elem_config(node, tx_max, node->bw_share, extack);
-	esw_qos_unlock(esw);
-	return err;
+	return esw_qos_sched_elem_config(node, tx_max, node->bw_share, extack);
 }
 
 int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
@@ -1794,30 +1707,23 @@ int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 {
 	struct mlx5_esw_sched_node *node;
 	struct mlx5_eswitch *esw;
-	int err = 0;
 
 	esw = mlx5_devlink_eswitch_get(rate_node->devlink);
 	if (IS_ERR(esw))
 		return PTR_ERR(esw);
 
-	esw_qos_lock(esw);
 	if (esw->mode != MLX5_ESWITCH_OFFLOADS) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Rate node creation supported only in switchdev mode");
-		err = -EOPNOTSUPP;
-		goto unlock;
+		return -EOPNOTSUPP;
 	}
 
 	node = esw_qos_create_vports_sched_node(esw, extack);
-	if (IS_ERR(node)) {
-		err = PTR_ERR(node);
-		goto unlock;
-	}
+	if (IS_ERR(node))
+		return PTR_ERR(node);
 
 	*priv = node;
-unlock:
-	esw_qos_unlock(esw);
-	return err;
+	return 0;
 }
 
 int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
@@ -1826,10 +1732,9 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	struct mlx5_esw_sched_node *node = priv;
 	struct mlx5_eswitch *esw = node->esw;
 
-	esw_qos_lock(esw);
 	__esw_qos_destroy_node(node, extack);
 	esw_qos_put(esw);
-	esw_qos_unlock(esw);
+
 	return 0;
 }
 
@@ -1846,7 +1751,6 @@ mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
 		return -EOPNOTSUPP;
 	}
 
-	esw_qos_lock(esw);
 	if (!vport->qos.sched_node && parent) {
 		enum sched_node_type type;
 
@@ -1859,13 +1763,15 @@ mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
 						  parent ? : esw->qos.root,
 						  extack);
 	}
-	esw_qos_unlock(esw);
+
 	return err;
 }
 
 void mlx5_esw_qos_vport_clear_parent(struct mlx5_vport *vport)
 {
+	devl_lock(vport->dev->shd);
 	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
+	devl_unlock(vport->dev->shd);
 }
 
 int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
@@ -1878,13 +1784,8 @@ int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 	int err;
 
 	err = mlx5_esw_qos_vport_update_parent(vport, node, extack);
-	if (!err) {
-		struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-
-		esw_qos_lock(esw);
+	if (!err)
 		esw_vport_qos_prune_empty(vport);
-		esw_qos_unlock(esw);
-	}
 
 	return err;
 }
@@ -2007,18 +1908,15 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 					   struct mlx5_esw_sched_node *parent,
 					   struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_sched_node *curr_parent;
-	struct mlx5_eswitch *esw = node->esw;
+	struct mlx5_esw_sched_node *curr_parent = node->parent;
 	int err;
 
-	esw_qos_lock(esw);
-	curr_parent = node->parent;
 	if (!parent)
-		parent = esw->qos.root;
+		parent = node->esw->qos.root;
 
 	err = mlx5_esw_qos_node_validate_set_parent(node, parent, extack);
 	if (err)
-		goto out;
+		return err;
 
 	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
 		err = esw_qos_tc_arbiter_node_update_parent(node, parent,
@@ -2028,15 +1926,11 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 	}
 
 	if (err)
-		goto out;
+		return err;
 
 	esw_qos_normalize_min_rate(curr_parent, extack);
 	esw_qos_normalize_min_rate(parent, extack);
-
-out:
-	esw_qos_unlock(esw);
-
-	return err;
+	return 0;
 }
 
 int mlx5_esw_devlink_rate_node_parent_set(struct devlink_rate *devlink_rate,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index 0a50982b0e27..f275e850d2c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -6,9 +6,6 @@
 
 #ifdef CONFIG_MLX5_ESWITCH
 
-int mlx5_esw_qos_init(struct mlx5_eswitch *esw);
-void mlx5_esw_qos_cleanup(struct mlx5_eswitch *esw);
-
 int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *evport, u32 max_rate, u32 min_rate);
 bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *min_rate);
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 123c96716a54..f6bbc92d2817 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1647,10 +1647,6 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 	MLX5_NB_INIT(&esw->nb, eswitch_vport_event, NIC_VPORT_CHANGE);
 	mlx5_eq_notifier_register(esw->dev, &esw->nb);
 
-	err = mlx5_esw_qos_init(esw);
-	if (err)
-		goto err_esw_init;
-
 	if (esw->mode == MLX5_ESWITCH_LEGACY) {
 		err = esw_legacy_enable(esw);
 	} else {
@@ -2057,9 +2053,6 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 		goto reps_err;
 
 	esw->mode = MLX5_ESWITCH_LEGACY;
-	err = mlx5_esw_qos_init(esw);
-	if (err)
-		goto reps_err;
 
 	mutex_init(&esw->offloads.encap_tbl_lock);
 	hash_init(esw->offloads.encap_tbl);
@@ -2109,7 +2102,6 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 
 	esw_info(esw->dev, "cleanup\n");
 
-	mlx5_esw_qos_cleanup(esw);
 	destroy_workqueue(esw->work_queue);
 	WARN_ON(refcount_read(&esw->qos.refcnt));
 	mutex_destroy(&esw->state_lock);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 9b3949a64784..c8865ea3858d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -224,8 +224,9 @@ struct mlx5_vport {
 
 	struct mlx5_vport_info  info;
 
-	/* Protected with the E-Switch qos domain lock. The Vport QoS can
-	 * either be disabled (sched_node is NULL) or in one of three states:
+	/* Protected by mlx5_shd_lock().
+	 * The Vport QoS can either be disabled (sched_node is NULL) or in one
+	 * of three states:
 	 * 1. Regular QoS (sched_node is a vport node).
 	 * 2. TC QoS enabled on the vport (sched_node is a TC arbiter).
 	 * 3. TC QoS enabled on the vport's parent node
@@ -359,7 +360,6 @@ enum {
 };
 
 struct dentry;
-struct mlx5_qos_domain;
 
 struct mlx5_eswitch {
 	struct mlx5_core_dev    *dev;
@@ -386,11 +386,10 @@ struct mlx5_eswitch {
 	struct rw_semaphore mode_lock;
 	atomic64_t user_count;
 
-	/* Protected with the E-Switch qos domain lock. */
+	/* QoS changes are serialized with mlx5_shd_lock(). */
 	struct {
 		/* Initially 0, meaning no QoS users and QoS is disabled. */
 		refcount_t refcnt;
-		struct mlx5_qos_domain *domain;
 		/* The root node of the hierarchy. */
 		struct mlx5_esw_sched_node *root;
 	} qos;
-- 
2.44.0


