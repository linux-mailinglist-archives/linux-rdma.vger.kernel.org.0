Return-Path: <linux-rdma+bounces-20837-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id m4dzBzamCWqxjQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20837-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:27:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE6560B45
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CDE43004F30
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 11:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A9C3603C0;
	Sun, 17 May 2026 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b9Ezqld1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559D731B100;
	Sun, 17 May 2026 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779017258; cv=fail; b=Hh1OeaKf2vxTcSzT+00orNJXEP/P7hUXfa68GlIeCeByd2O4g23Kd+OTvwRrqZjdVcSmBOVspw3SQZKqzHXL5l9czgWu9QnhyX+WOcX54hxgxJQWktSh2coXw53/iLQQfZHr7gznZYEYOlrpz9/F1mhUvLIwxPD0o//CJ3099Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779017258; c=relaxed/simple;
	bh=CclOb2iNt1DQKi0LAh8ETAqPevqpJgwpdamamFh40fk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4IpfLn89N+bNK6CSlfO9uuyOOrVKi1yFtWsxqiH6AYIfQ3em3tx8k4BquoRASW3d2+gS5e0BYYmNAT2wMqSNZmHHBnKcsW+Nleg0rondpR/Mj1MD21hnakgTe3B5iAmrx7gMBcoFLovlvRIOJOZbx/sNliMroaVSARqVV/iR8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b9Ezqld1; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgFNk1QPlZ696UAuJrJyDB1OBZXhMJo2Wgs3Cp09mpchCECV6wooZDxreFCZKGrk7HGpFnbN5yKNN/uiCmJFDGA2uK5Ie3kBckh46+emVewDEFSyo8De3lr562YVFNFdUuoBLAkHisfuNEG2cmjxQEU0SXzWpbgN7e1+sPwDbi+1YULLJCYp7ZQTQivNjv8Ub7loBKS5SJn0Rqj0MZLEVK8RpEt13BynneETe5K6wmgfP8EGw09SI33qOkNR+/cQ+uXC8jORwl93owAncm96MQvI5URpCol9EOv0FbGVYAet46HZc9UlaqopWaZAnIY7nEdcWLZPRXZHdMaIc1WcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qcmMQPGCK0q6LqMiPxBbJ2us4pqHrP2Wv6ghSnjtl8=;
 b=Gnd0sewkjBnW69PsCSFFwnN5KZUZ1x7chMcKTr8QrFoilg8sX3BLtHkEXgsoGSnEbg4MLulek3wwsRU5i55IzOuMox2e3D/GbGmjlxtyCjJQTNjlYz5y3klKxntCaR3SgAOHPRvZAdm6yBe9X3ZnQegw0vy0Z16wDZyss47I0mbN4ICXdROAs1MmTXwGRfakWZ7SVgqVJb3O4GdSiaBSYLSut+Fcds8mZtceTKiZtvrB3rE85ANmAZdMpxW7FrLG09uJASvdi5n3PakTQC/6AdjXzmJUAS0qI2fSQqYB5sfj3dmZPAGRu2vNeDV/gpbT9YjneQ12rkLqe1oE5eTiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qcmMQPGCK0q6LqMiPxBbJ2us4pqHrP2Wv6ghSnjtl8=;
 b=b9Ezqld1bVC3fd+7DaCqXWh+ERAM2rxLFqeh5rIV//hbQe7u59/3kqkIKoWqhefNgxooLFJVv+slNocp6PIW58RfeAtzZZcYKfmzkkNMnQcb2rFxvP/pNtBOzbRt+1GRFvMazqiA/BmTgNLIDh1IaQay7H9Ed3dFW6ugr5Peahjq/ylx/9LKLhdXd+Nagn/B+h851rzZ8D3WXFKjz3kG/cmQBHrbv/zSc8hXqiTRD+A+qnhR3/st3zTdsMAXed3m8HmeleQ9xoFyUjQO+7o+UrJTAmhIjwFFGmOBVzLsap7Bfc2RTPTHq06pkNnpsyYVWiXjUZAjWVNL0Cc+JPyLwg==
Received: from BL1PR13CA0078.namprd13.prod.outlook.com (2603:10b6:208:2b8::23)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sun, 17 May
 2026 11:27:31 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::4a) by BL1PR13CA0078.outlook.office365.com
 (2603:10b6:208:2b8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Sun, 17
 May 2026 11:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Sun, 17 May 2026 11:27:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 04:27:24 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 17 May 2026 04:27:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 17 May 2026 04:27:18 -0700
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
Subject: [PATCH net-next 2/2] net/mlx5: implement max_sfs parameter
Date: Sun, 17 May 2026 14:27:00 +0300
Message-ID: <20260517112700.343575-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 710f8d87-4afc-410c-5a61-08deb407488b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|7416014|11063799003|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	05MT6lMEQAk6StyrL74C7aF3JIEpmtdiBQhJVYLaBYNmzBW7A4LVoqx6c9BQ34yAFUU3g4BF4i16EPSbb07nVFx2P8tNAp8XbgXUfzcCiJVcicnVAmzKXJeAfK4MqIJo9X3Yl6w6cN7xIH28FzYQgpOLcOuznqSQfVyzXQJ2z37p2c2Ri4buzYpZ2KPhdR9BAiIRbh4inGuQ03XMNiLvdC9Pk5koSYoMB7GKedKdw2yd+6gKC+Lkt7JXGzxeFJ7AZMQ98b/hv0NgdGMdYrF8nUxdgvVIA4X5MJWjMAyuC65RcLWTUORBLPEEHGo2xe6oIf/jhbGFuQ73lHcWa23dD/LxeknyfBtFtbfNVYv6Gu4zCnxKrrfxV+XMDwTSu2+Cpf6LmszSix7uJkC6I8fakTe6ljH/Wi4ovtG7S1t8xFLCwEy8Xw9r7lC/x1HU+cR88PBvDByb9ujyJEPI+RhoQlOoHi3XgYqAGtrEMpLKRzodEkxqsGzTCCVSG2ZKBFS1klelOwMR7IfbYJX3OsM+AqQ0Ev8XNQKDdjUl5s/Ycp+bpJNRbury02rfNqEcqWuvf6leUe+LaN8bUtBpNN+EJW8HcPCVhaIWulZzruhJymGELoBZ3bSVPp/mWlbhAJ6V/03R0PLQilsMH/6UFv6i2KxdoAEEoNlPbd0ZNOsiHH+hXlumYzrl4RNjf9y0ggLsa6dQyNTbExmWMThw2hI2KvdoEsc28jX6Nx18p9G4NGY=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(7416014)(11063799003)(22082099003)(56012099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DlEHwpOVvkuKq2xOSTBGmqTbJM4oFvTznZZlq3aKmUPuTtj4HNwVvY9jUue7RtNEMCscYOzSQ7eUoDxeQaQwnihWObrZyj6JLBXmGZsFKR8aKiSK+HSd4K1XOHSqo8J89GsuR9p2J1yz8CQhsPi4lp/h332s7XODumIvcwST6bViWPS5Jd52jbsFODj+un9c180t7ZHb5Mt6sXn8nvYH3knWC8+QoCpoVwrUPvgemgn9pQE3Shui7QHMfnvHz5WMkocrLO7JxFs5GqdhgCshsqV589s1OrKkVYnnwWa4v9h2iwRVRZ1pZyJVbCU/YlXZj/CdBuMKeJxT3ZYUrfyQYoQjEkYaQdiPRPEYwlY3xmj3quHzimhyxneoOF5hQB4nsxOJyRNa504e36jhi+p0qcI3WGmxWX0rZRcMwPhhlMUTUlHFLlmjd6PKPcAFUdzI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 11:27:30.6139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 710f8d87-4afc-410c-5a61-08deb407488b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568
X-Rspamd-Queue-Id: C2AE6560B45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20837-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[resnulli.us,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,intel.com,gmail.com,blackwall.org,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Implement max_sfs generic parameter to allow users to control the total
light-weight NIC subfunctions that can be created using devlink instead
of external vendor tools. A value of 0 will effectively disable creation
of new subfunction devices. A warning is sent to user-space via extack
(returning extack without error code is interpreted as a warning by
user-space tools).

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst     |  7 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 83 ++++++++++++++++++-
 2 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 4bba4d780a4a..283b93d16861 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -45,8 +45,13 @@ Parameters
      - The range is between 1 and a device-specific max.
      - Applies to each physical function (PF) independently, if the device
        supports it. Otherwise, it applies symmetrically to all PFs.
+   * - ``max_sfs``
+     - permanent
+     - The range is between 0 and a device-specific max.
+     - Applies to each physical function (PF) independently.
 
-Note: permanent parameters such as ``enable_sriov`` and ``total_vfs`` require FW reset to take effect
+Note: permanent parameters such as ``enable_sriov``, ``total_vfs` and ``max_sfs``
+      require FW reset to take effect
 
 .. code-block:: bash
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
index 19bb620b7436..eff3a67e4ca0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
@@ -68,7 +68,9 @@ struct mlx5_ifc_mnvda_reg_bits {
 
 struct mlx5_ifc_nv_global_pci_conf_bits {
 	u8         sriov_valid[0x1];
-	u8         reserved_at_1[0x10];
+	u8         reserved_at_1[0xa];
+	u8         per_pf_num_sf[0x1];
+	u8         reserved_at_c[0x5];
 	u8         per_pf_total_vf[0x1];
 	u8         reserved_at_12[0xe];
 
@@ -93,9 +95,11 @@ struct mlx5_ifc_nv_global_pci_cap_bits {
 };
 
 struct mlx5_ifc_nv_pf_pci_conf_bits {
-	u8         reserved_at_0[0x9];
+	u8         log_sf_bar_size[0x8];
+	u8         pf_total_sf_en[0x1];
 	u8         pf_total_vf_en[0x1];
-	u8         reserved_at_a[0x16];
+	u8         reserved_at_a[0x6];
+	u8         total_sf[0x10];
 
 	u8         reserved_at_20[0x20];
 
@@ -755,6 +759,76 @@ static int mlx5_devlink_total_vfs_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int mlx5_devlink_max_sfs_get(struct devlink *devlink, u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	int err;
+
+	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to read PF configuration");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	ctx->val.vu32 = MLX5_GET(nv_pf_pci_conf, data, total_sf);
+
+	return 0;
+}
+
+static int mlx5_devlink_max_sfs_set(struct devlink *devlink, u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	int err;
+
+	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to read global PCI configuration");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	MLX5_SET(nv_global_pci_conf, data, per_pf_num_sf, !!ctx->val.vu32);
+
+	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to change per_pf_num_sf global PCI configuration");
+		return err;
+	}
+
+	memset(mnvda, 0, sizeof(mnvda));
+	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to read PF configuration");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	MLX5_SET(nv_pf_pci_conf, data, log_sf_bar_size, ctx->val.vu32 ? 12 : 0);
+	MLX5_SET(nv_pf_pci_conf, data, pf_total_sf_en, !!ctx->val.vu32);
+	MLX5_SET(nv_pf_pci_conf, data, total_sf, ctx->val.vu32);
+
+	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to change PF PCI configuration");
+		return err;
+	}
+	NL_SET_ERR_MSG(extack, "Modifying max_sfs requires a reboot");
+
+	return 0;
+}
+
 static const struct devlink_param mlx5_nv_param_devlink_params[] = {
 	DEVLINK_PARAM_GENERIC(ENABLE_SRIOV, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
 			      mlx5_devlink_enable_sriov_get,
@@ -763,6 +837,9 @@ static const struct devlink_param mlx5_nv_param_devlink_params[] = {
 			      mlx5_devlink_total_vfs_get,
 			      mlx5_devlink_total_vfs_set,
 			      mlx5_devlink_total_vfs_validate),
+	DEVLINK_PARAM_GENERIC(MAX_SFS, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
+			      mlx5_devlink_max_sfs_get,
+			      mlx5_devlink_max_sfs_set, NULL),
 	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
 			     "cqe_compress_type", DEVLINK_PARAM_TYPE_STRING,
 			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
-- 
2.44.0


