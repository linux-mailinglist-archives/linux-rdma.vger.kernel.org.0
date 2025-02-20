Return-Path: <linux-rdma+bounces-7922-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B539A3E6E3
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 22:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDB9170188
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 21:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30A726A086;
	Thu, 20 Feb 2025 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ezhtl7AR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBA726A082;
	Thu, 20 Feb 2025 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087700; cv=fail; b=L2pKue4QBFUE3v0g+3ViPe9QeWHlTHw2Z8M1pTbFwocabuCg3ubqWtA0XRyhk+T7c/h6QRRgPY+JceJNYZpefAGG/Dr4FRLeYbelb+HnNQzD7hU9lrVgMsikoUu3rtTSYMUArEzte1HY4HSpwrWugtSPLlcbreT0y5LjEhmyLHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087700; c=relaxed/simple;
	bh=oDfEFlR3TFO1C7uQOv38aRaUKy6oPAgNlgF9Uqm2bzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kv6Ip3Im2VSwPQoSYQwNlTt6jNDFICv/yo+xxVw9Bpt3k7ycWfZgXnPnXiGGmPhwlpa+zY7mdRD6M+RMOjpFkod1G7A8AaW5ezSs1KV64SgDvDp+u3e8nJcCRCba6h4t6zklnZhqo7VNFpLqzqpWaeeMgHsii7qB44W9jjK5wVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ezhtl7AR; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3UFUSKAiZrDb4uGTath60h99gwZ7fwiBLPfIY/z8sJp1F7gS2pZ0nyE/TKWe7IxudxzrvoAYksrLqvzaSfYDlAhblbP2iw3hNwcrH9cL9dgnNojvTCbhDM0HW4HG8/PisWPQS/YBlXZdKKLa63RlGRNb3jVpeuxUr2C6JA2lLJzC1YOJnaIlSKRnFRaU9Pxr4I3ir30qynKeJqv3vaON+A+fCX+45ltMQM96hTTBlJHIiz5uX6I3E29c1Z2DooiKt9A3FdvsxzU5RnkiAqOivPcl9VpobgRV65Jtw/v2N2JO1KvxnvlDZ//rnsqhhl28j8kptnFotKXVNG2HesuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w++5ok4E2Eng93IZMVr6eNhNBwp5lHhpLcA+EAWHTsg=;
 b=CdxaH2VZ1LctIQO4+0HWectdo3xvSINpjvMAQ83+kAn4QxCwoyPiPjZ3CacLf56ll3UaG+97RdN/HwfvcYvBC7T+bNHy/oOkAtB3F29mn0RgKwws904MLJCAFaIO3+6UydZjLpiA71ZYnljxnvSOx5dOpUZWnsExHX9pGFpSaT3u8OrrR07XB/yLZDREgqu1CabXfekMQM2kynIFiPVqu2hjTCA8iiY/1keulqxsW1D1dlvl8tH5WHjoMUUGBVjvUTF3C3MQTraIvdlKHOGcozuaBv+Su5YGRj/SuQ2dVMozLbe4NjUxwAEpSm25GeqhOhtzZTVQzUpKyKzKa0Cubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w++5ok4E2Eng93IZMVr6eNhNBwp5lHhpLcA+EAWHTsg=;
 b=ezhtl7ARVIQ2ztuQ6zTp7vZZrPxiHGUozPszsakNFlUZK/q8DS5uqhHV4IIXrT5aTdBFy3AWiCTo3D5zWSXoN5Tny5MAqkMRsz6dPTeLzZTMR2okKOq4p92holEcXvR/qHu4Mki24m7vJrGO7omla/Jh841T2Hfixe98W5m3fgRPU/PxLvSPT3ZJuxxsuQRI+mEvCwc5z4W7wUWaZbX3YkhmCg3ZlimZT/3RteyvvN3h7c2DNHZ03dAgcfpYZo/3uGPLy2Zek3CEnUAECZPxeJNPIUWHTDt9IVYYFfIv7/1OPwBdaP0bxSW6+Dgps3/9nJDhbEeV/3hRKE0BU4GH2g==
Received: from SN1PR12CA0074.namprd12.prod.outlook.com (2603:10b6:802:20::45)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.24; Thu, 20 Feb
 2025 21:41:30 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::d3) by SN1PR12CA0074.outlook.office365.com
 (2603:10b6:802:20::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 21:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 21:41:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 13:41:13 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 13:41:13 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Feb 2025 13:41:09 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jianbo Liu
	<jianbol@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>, Patrisious
 Haddad <phaddad@nvidia.com>
Subject: [PATCH net-next 8/8] net/mlx5e: Support RX xfrm state selector's UPSPEC for packet offload
Date: Thu, 20 Feb 2025 23:39:58 +0200
Message-ID: <20250220213959.504304-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220213959.504304-1-tariqt@nvidia.com>
References: <20250220213959.504304-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: f6534499-ab5a-4db4-944d-08dd51f7563b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FaJrzgfzfi74vSyaQNBj5oG8mggKylr/VLJkAwByL1/iZhJdpYZzhF0UoAOC?=
 =?us-ascii?Q?C8/XiR5SI/tYAYS1eCs9jWEynEy7bmpq24oxWBrccvU/VJ5XpEiTeUuPjfD0?=
 =?us-ascii?Q?7XKq5Vq13pxdWq1IeI0WFcs1VU9P9T9VHbLHsDxI8D8358HZmxBilg6lJeEy?=
 =?us-ascii?Q?UC9O+CJVL7KkCB4TCAnlsEZd06px0ZPCorqYD/v6GEC/WTrwwM6A/ka+qfRK?=
 =?us-ascii?Q?y5Fu2P9d1HYMKT9JrNiWd07Oja/LobhgNvW0QvvOWnmnFXXby0ytXjD2wk3y?=
 =?us-ascii?Q?2UIH/IfNUfgCxR7JwemUYcfhj05heFYhxPKnv/zZToeNc75wZo8dOoYrLmtA?=
 =?us-ascii?Q?fL7R52EajRE4wQKK10PSXXhSx4e487wmGw8jFCzsNmaNWJ9OGrqakL6T3YbF?=
 =?us-ascii?Q?JOPRldLDkFb1foFodCvHJP05XCeQNSVI09/zgp1CNiRcA2bZvwm61Jn61IfE?=
 =?us-ascii?Q?wpNxz2Z99Q0xir4lFyOw6cVo4gU0sF5B2hdh6Tfjmtk7ztIfUWPMSHO1Jkj3?=
 =?us-ascii?Q?jzRwsZ/g/MZvEttN4bNCRR3XZRxYuRJPYez3YU+DXJuw32lelZkihP397gvn?=
 =?us-ascii?Q?7yKHlmJ2A1TVQoPhgpLMgn72i/loNAQ8AX7i7kcecbTn4ftabV9uFIEd2OS2?=
 =?us-ascii?Q?3wRORWRhRQWh08vQfprIeAUkzymGSk7W6yLH9qs3SOKTt0SdNXEas+Wwq63G?=
 =?us-ascii?Q?H774JulV48JqUcyD3wHKEz3XfnO6wlgTV3cJkhpJdczwHytPyKCJuaNIVATx?=
 =?us-ascii?Q?UP1JNR733ZyMHW14dqDv2gAEPUxh8edGa0dcn5iEWrMedex31Ea+9+wcY0rV?=
 =?us-ascii?Q?0KUMtVcVB2amiE8u3T+F33ZATOKibbSvSUBBXe/6r5ZBbrzZrFX8MXHAg5Zk?=
 =?us-ascii?Q?kQ7v2anXj2b0xNPa9SOFEje7I990b8Sx9Q4VN/G4IgYnW48dVFj3dvNAUz0f?=
 =?us-ascii?Q?52YHhBnFv64mLSyjyatq3KRtAPcl2mPPloah9vX01RGa5e3Ovq5Zp9r82pXD?=
 =?us-ascii?Q?uPsEUHiBn+LB6gVn8W4zIxjlNpGjfZNjzLUgnsVVs1wR8aQFlO9IarFNd6oR?=
 =?us-ascii?Q?5MOsxi6+/f5o5mfUJ4BAyQEvnUIq9pAK7SPLT6yozISdYhgpms8LGZTy3u77?=
 =?us-ascii?Q?ZsNGdi8hsJfkFZ0GZgHB4xYJATs/MfUI0nCO9rFHDhP3IT7xDdNmLhycx/Ec?=
 =?us-ascii?Q?KSiJoeuvYQgXGl3h5e8L6B+uMF2QYHvs15r8AwvPMnLu4cypNY0EHZpu7LBB?=
 =?us-ascii?Q?YKC/pGTj1dGIbhymWb6msAGSCFCSxtAL6I7C4uJKO7z+8dHjxSXfkVaGkSWm?=
 =?us-ascii?Q?crojC2P+osMyHkcKmQoI+antXvGCGS7M+PKuPu1wKBgwL3N73LZWqUguyEyD?=
 =?us-ascii?Q?WBxgFRRIstXNglkZiLyyCgtEkir8E2NSZhn6FbpBbVt8MGd496o4VilQtj9l?=
 =?us-ascii?Q?5OsvY6o4KIMzD6mMeClgiv/Glk/ir+x/RzSGg+6cnWopI3dhX+5RPJe3aWlp?=
 =?us-ascii?Q?Kmqg6WkeGpeAbfI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 21:41:30.0745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6534499-ab5a-4db4-944d-08dd51f7563b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715

From: Jianbo Liu <jianbol@nvidia.com>

Previously, the upper layer matches are added for the decryption rule
when xfrm selector's UPSPEC is specified in the command. However, it's
impossible as packets are not decrypted, and there is no way to do
match on the upper protocol (TCP/UDP) with specific source/destination
port. The result is that packets are not decrypted by hardware because
of this mismatch. Instead, they are forwarded to kernel, and
decryption is done by software.

To resolve this issue, this patch adds new table (sa_sel) after status
table and before policy table. When UPSPEC's proto is specified in
xfrm state's selector, a rule is added in status table to forward the
decrypted packets to sa_sel table, where the corresponding rule for
selector's UPSPEC is added, and packet's upper headers are checked
there. If matched, they will be forward to policy table to do policy
check. Otherwise, they are dropped immediately.

Besides, add a global count for this kind of packet drop.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.h       |   5 +
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 238 +++++++++++++++++-
 .../mellanox/mlx5/core/en_accel/ipsec_stats.c |   1 +
 3 files changed, 242 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index 7d943e93cf6d..ad8db9e1fd1d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -128,6 +128,7 @@ struct mlx5e_ipsec_hw_stats {
 	u64 ipsec_rx_bytes;
 	u64 ipsec_rx_drop_pkts;
 	u64 ipsec_rx_drop_bytes;
+	u64 ipsec_rx_drop_mismatch_sa_sel;
 	u64 ipsec_tx_pkts;
 	u64 ipsec_tx_bytes;
 	u64 ipsec_tx_drop_pkts;
@@ -184,6 +185,7 @@ struct mlx5e_ipsec_ft {
 	struct mutex mutex; /* Protect changes to this struct */
 	struct mlx5_flow_table *pol;
 	struct mlx5_flow_table *sa;
+	struct mlx5_flow_table *sa_sel;
 	struct mlx5_flow_table *status;
 	u32 refcnt;
 };
@@ -195,6 +197,8 @@ struct mlx5e_ipsec_drop {
 
 struct mlx5e_ipsec_rule {
 	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_handle *status_pass;
+	struct mlx5_flow_handle *sa_sel;
 	struct mlx5_modify_hdr *modify_hdr;
 	struct mlx5_pkt_reformat *pkt_reformat;
 	struct mlx5_fc *fc;
@@ -206,6 +210,7 @@ struct mlx5e_ipsec_rule {
 struct mlx5e_ipsec_miss {
 	struct mlx5_flow_group *group;
 	struct mlx5_flow_handle *rule;
+	struct mlx5_fc *fc;
 };
 
 struct mlx5e_ipsec_tx_create_attr {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 840d9e0514d3..d51ace739637 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -16,6 +16,8 @@
 #define MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_SIZE 16
 #define IPSEC_TUNNEL_DEFAULT_TTL 0x40
 
+#define MLX5_IPSEC_FS_SA_SELECTOR_MAX_NUM_GROUPS 16
+
 enum {
 	MLX5_IPSEC_ASO_OK,
 	MLX5_IPSEC_ASO_BAD_REPLY,
@@ -52,6 +54,7 @@ struct mlx5e_ipsec_rx {
 	struct mlx5e_ipsec_ft ft;
 	struct mlx5e_ipsec_miss pol;
 	struct mlx5e_ipsec_miss sa;
+	struct mlx5e_ipsec_miss sa_sel;
 	struct mlx5e_ipsec_status_checks status_checks;
 	struct mlx5e_ipsec_fc *fc;
 	struct mlx5_fs_chains *chains;
@@ -689,6 +692,16 @@ static void ipsec_rx_policy_destroy(struct mlx5e_ipsec_rx *rx)
 	}
 }
 
+static void ipsec_rx_sa_selector_destroy(struct mlx5_core_dev *mdev,
+					 struct mlx5e_ipsec_rx *rx)
+{
+	mlx5_del_flow_rules(rx->sa_sel.rule);
+	mlx5_fc_destroy(mdev, rx->sa_sel.fc);
+	rx->sa_sel.fc = NULL;
+	mlx5_destroy_flow_group(rx->sa_sel.group);
+	mlx5_destroy_flow_table(rx->ft.sa_sel);
+}
+
 static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 		       struct mlx5e_ipsec_rx *rx, u32 family)
 {
@@ -704,6 +717,8 @@ static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	mlx5_ipsec_rx_status_destroy(ipsec, rx);
 	mlx5_destroy_flow_table(rx->ft.status);
 
+	ipsec_rx_sa_selector_destroy(mdev, rx);
+
 	ipsec_rx_policy_destroy(rx);
 
 	mlx5_ipsec_fs_roce_rx_destroy(ipsec->roce, family, mdev);
@@ -892,6 +907,115 @@ static int ipsec_rx_policy_create(struct mlx5e_ipsec *ipsec,
 	return err;
 }
 
+static int ipsec_rx_sa_selector_create(struct mlx5e_ipsec *ipsec,
+				       struct mlx5e_ipsec_rx *rx,
+				       struct mlx5e_ipsec_rx_create_attr *attr)
+{
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_core_dev *mdev = ipsec->mdev;
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_destination dest;
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_table *ft;
+	struct mlx5_flow_group *fg;
+	u32 *flow_group_in;
+	struct mlx5_fc *fc;
+	int err;
+
+	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
+	if (!flow_group_in)
+		return -ENOMEM;
+
+	ft = ipsec_ft_create(attr->ns, attr->status_level, attr->prio, 1,
+			     MLX5_IPSEC_FS_SA_SELECTOR_MAX_NUM_GROUPS, 0);
+	if (IS_ERR(ft)) {
+		err = PTR_ERR(ft);
+		mlx5_core_err(mdev, "Failed to create RX SA selector flow table, err=%d\n",
+			      err);
+		goto err_ft;
+	}
+
+	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index,
+		 ft->max_fte - 1);
+	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index,
+		 ft->max_fte - 1);
+	fg = mlx5_create_flow_group(ft, flow_group_in);
+	if (IS_ERR(fg)) {
+		err = PTR_ERR(fg);
+		mlx5_core_err(mdev, "Failed to create RX SA selector miss group, err=%d\n",
+			      err);
+		goto err_fg;
+	}
+
+	fc = mlx5_fc_create(mdev, false);
+	if (IS_ERR(fc)) {
+		err = PTR_ERR(fc);
+		mlx5_core_err(mdev,
+			      "Failed to create ipsec RX SA selector miss rule counter, err=%d\n",
+			      err);
+		goto err_cnt;
+	}
+
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dest.counter = fc;
+	flow_act.action =
+		MLX5_FLOW_CONTEXT_ACTION_COUNT | MLX5_FLOW_CONTEXT_ACTION_DROP;
+
+	rule = mlx5_add_flow_rules(ft, NULL, &flow_act, &dest, 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(mdev, "Failed to create RX SA selector miss drop rule, err=%d\n",
+			      err);
+		goto err_rule;
+	}
+
+	rx->ft.sa_sel = ft;
+	rx->sa_sel.group = fg;
+	rx->sa_sel.fc = fc;
+	rx->sa_sel.rule = rule;
+
+	kvfree(flow_group_in);
+
+	return 0;
+
+err_rule:
+	mlx5_fc_destroy(mdev, fc);
+err_cnt:
+	mlx5_destroy_flow_group(fg);
+err_fg:
+	mlx5_destroy_flow_table(ft);
+err_ft:
+	kvfree(flow_group_in);
+	return err;
+}
+
+/* The decryption processing is as follows:
+ *
+ *   +----------+                         +-------------+
+ *   |          |                         |             |
+ *   |  Kernel  <--------------+----------+ policy miss <------------+
+ *   |          |              ^          |             |            ^
+ *   +----^-----+              |          +-------------+            |
+ *        |                  crypto                                  |
+ *      miss                offload ok                         allow/default
+ *        ^                    ^                                     ^
+ *        |                    |                  packet             |
+ *   +----+---------+     +----+-------------+   offload ok   +------+---+
+ *   |              |     |                  |   (no UPSPEC)  |          |
+ *   | SA (decrypt) +----->      status      +--->------->----+  policy  |
+ *   |              |     |                  |                |          |
+ *   +--------------+     ++---------+-------+                +-^----+---+
+ *                         |         |                          |    |
+ *                         v        packet             +-->->---+    v
+ *                         |       offload ok        match           |
+ *                       fails    (with UPSPEC)        |           block
+ *                         |         |   +-------------+-+           |
+ *                         v         v   |               |  miss     v
+ *                        drop       +--->    SA sel     +--------->drop
+ *                                       |               |
+ *                                       +---------------+
+ */
+
 static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 		     struct mlx5e_ipsec_rx *rx, u32 family)
 {
@@ -907,13 +1031,17 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	if (err)
 		return err;
 
-	ft = ipsec_ft_create(attr.ns, attr.status_level, attr.prio, 3, 3, 0);
+	ft = ipsec_ft_create(attr.ns, attr.status_level, attr.prio, 3, 4, 0);
 	if (IS_ERR(ft)) {
 		err = PTR_ERR(ft);
 		goto err_fs_ft_status;
 	}
 	rx->ft.status = ft;
 
+	err = ipsec_rx_sa_selector_create(ipsec, rx, &attr);
+	if (err)
+		goto err_fs_ft_sa_sel;
+
 	/* Create FT */
 	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_TUNNEL)
 		rx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
@@ -956,6 +1084,8 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	if (rx->allow_tunnel_mode)
 		mlx5_eswitch_unblock_encap(mdev);
 err_fs_ft:
+	ipsec_rx_sa_selector_destroy(mdev, rx);
+err_fs_ft_sa_sel:
 	mlx5_destroy_flow_table(rx->ft.status);
 err_fs_ft_status:
 	mlx5_ipsec_fs_roce_rx_destroy(ipsec->roce, family, mdev);
@@ -1781,6 +1911,85 @@ static int setup_pkt_reformat(struct mlx5e_ipsec *ipsec,
 	return 0;
 }
 
+static int rx_add_rule_sa_selector(struct mlx5e_ipsec_sa_entry *sa_entry,
+				   struct mlx5e_ipsec_rx *rx,
+				   struct upspec *upspec)
+{
+	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
+	struct mlx5_core_dev *mdev = ipsec->mdev;
+	struct mlx5_flow_destination dest[2];
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_spec *spec;
+	int err = 0;
+
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+			 misc_parameters_2.ipsec_syndrome);
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+			 misc_parameters_2.metadata_reg_c_4);
+	MLX5_SET(fte_match_param, spec->match_value,
+		 misc_parameters_2.ipsec_syndrome, 0);
+	MLX5_SET(fte_match_param, spec->match_value,
+		 misc_parameters_2.metadata_reg_c_4, 0);
+	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
+
+	ipsec_rx_rule_add_match_obj(sa_entry, rx, spec);
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
+			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	flow_act.flags = FLOW_ACT_IGNORE_FLOW_LEVEL;
+	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	dest[0].ft = rx->ft.sa_sel;
+	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dest[1].counter = rx->fc->cnt;
+
+	rule = mlx5_add_flow_rules(rx->ft.status, spec, &flow_act, dest, 2);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(mdev,
+			      "Failed to add ipsec rx pass rule, err=%d\n",
+			      err);
+		goto err_add_status_pass_rule;
+	}
+
+	sa_entry->ipsec_rule.status_pass = rule;
+
+	MLX5_SET(fte_match_param, spec->match_criteria,
+		 misc_parameters_2.ipsec_syndrome, 0);
+	MLX5_SET(fte_match_param, spec->match_criteria,
+		 misc_parameters_2.metadata_reg_c_4, 0);
+
+	setup_fte_upper_proto_match(spec, upspec);
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	dest[0].ft = rx->ft.pol;
+
+	rule = mlx5_add_flow_rules(rx->ft.sa_sel, spec, &flow_act, &dest[0], 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(mdev,
+			      "Failed to add ipsec rx sa selector rule, err=%d\n",
+			      err);
+		goto err_add_sa_sel_rule;
+	}
+
+	sa_entry->ipsec_rule.sa_sel = rule;
+
+	kvfree(spec);
+	return 0;
+
+err_add_sa_sel_rule:
+	mlx5_del_flow_rules(sa_entry->ipsec_rule.status_pass);
+err_add_status_pass_rule:
+	kvfree(spec);
+	return err;
+}
+
 static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 {
 	struct mlx5_accel_esp_xfrm_attrs *attrs = &sa_entry->attrs;
@@ -1813,7 +2022,6 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	if (!attrs->encap)
 		setup_fte_esp(spec);
 	setup_fte_no_frags(spec);
-	setup_fte_upper_proto_match(spec, &attrs->upspec);
 
 	if (!attrs->drop) {
 		if (rx != ipsec->rx_esw)
@@ -1861,6 +2069,13 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 		mlx5_core_err(mdev, "fail to add RX ipsec rule err=%d\n", err);
 		goto err_add_flow;
 	}
+
+	if (attrs->upspec.proto && attrs->type == XFRM_DEV_OFFLOAD_PACKET) {
+		err = rx_add_rule_sa_selector(sa_entry, rx, &attrs->upspec);
+		if (err)
+			goto err_add_sa_sel;
+	}
+
 	if (attrs->type == XFRM_DEV_OFFLOAD_PACKET)
 		err = rx_add_rule_drop_replay(sa_entry, rx);
 	if (err)
@@ -1884,6 +2099,11 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 		mlx5_fc_destroy(mdev, sa_entry->ipsec_rule.replay.fc);
 	}
 err_add_replay:
+	if (sa_entry->ipsec_rule.sa_sel) {
+		mlx5_del_flow_rules(sa_entry->ipsec_rule.sa_sel);
+		mlx5_del_flow_rules(sa_entry->ipsec_rule.status_pass);
+	}
+err_add_sa_sel:
 	mlx5_del_flow_rules(rule);
 err_add_flow:
 	mlx5_fc_destroy(mdev, counter);
@@ -2265,6 +2485,7 @@ void mlx5e_accel_ipsec_fs_read_stats(struct mlx5e_priv *priv, void *ipsec_stats)
 	stats->ipsec_rx_bytes = 0;
 	stats->ipsec_rx_drop_pkts = 0;
 	stats->ipsec_rx_drop_bytes = 0;
+	stats->ipsec_rx_drop_mismatch_sa_sel = 0;
 	stats->ipsec_tx_pkts = 0;
 	stats->ipsec_tx_bytes = 0;
 	stats->ipsec_tx_drop_pkts = 0;
@@ -2274,6 +2495,9 @@ void mlx5e_accel_ipsec_fs_read_stats(struct mlx5e_priv *priv, void *ipsec_stats)
 	mlx5_fc_query(mdev, fc->cnt, &stats->ipsec_rx_pkts, &stats->ipsec_rx_bytes);
 	mlx5_fc_query(mdev, fc->drop, &stats->ipsec_rx_drop_pkts,
 		      &stats->ipsec_rx_drop_bytes);
+	if (ipsec->rx_ipv4->sa_sel.fc)
+		mlx5_fc_query(mdev, ipsec->rx_ipv4->sa_sel.fc,
+			      &stats->ipsec_rx_drop_mismatch_sa_sel, &bytes);
 
 	fc = ipsec->tx->fc;
 	mlx5_fc_query(mdev, fc->cnt, &stats->ipsec_tx_pkts, &stats->ipsec_tx_bytes);
@@ -2302,6 +2526,11 @@ void mlx5e_accel_ipsec_fs_read_stats(struct mlx5e_priv *priv, void *ipsec_stats)
 			stats->ipsec_tx_drop_pkts += packets;
 			stats->ipsec_tx_drop_bytes += bytes;
 		}
+
+		if (ipsec->rx_esw->sa_sel.fc &&
+		    !mlx5_fc_query(mdev, ipsec->rx_esw->sa_sel.fc,
+				   &packets, &bytes))
+			stats->ipsec_rx_drop_mismatch_sa_sel += packets;
 	}
 }
 
@@ -2399,6 +2628,11 @@ void mlx5e_accel_ipsec_fs_del_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	mlx5_del_flow_rules(ipsec_rule->auth.rule);
 	mlx5_fc_destroy(mdev, ipsec_rule->auth.fc);
 
+	if (ipsec_rule->sa_sel) {
+		mlx5_del_flow_rules(ipsec_rule->sa_sel);
+		mlx5_del_flow_rules(ipsec_rule->status_pass);
+	}
+
 	if (ipsec_rule->replay.rule) {
 		mlx5_del_flow_rules(ipsec_rule->replay.rule);
 		mlx5_fc_destroy(mdev, ipsec_rule->replay.fc);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c
index 92bf3fa44a3b..93be388068f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c
@@ -42,6 +42,7 @@ static const struct counter_desc mlx5e_ipsec_hw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_hw_stats, ipsec_rx_bytes) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_hw_stats, ipsec_rx_drop_pkts) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_hw_stats, ipsec_rx_drop_bytes) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_hw_stats, ipsec_rx_drop_mismatch_sa_sel) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_hw_stats, ipsec_tx_pkts) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_hw_stats, ipsec_tx_bytes) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_ipsec_hw_stats, ipsec_tx_drop_pkts) },
-- 
2.45.0


