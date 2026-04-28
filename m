Return-Path: <linux-rdma+bounces-19632-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HxhDkdI8GmIRAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19632-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:40:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAED47DB7E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33B5A3010B7A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 05:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5A334695;
	Tue, 28 Apr 2026 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jW3S66tb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD534104B;
	Tue, 28 Apr 2026 05:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354818; cv=fail; b=TYSVHUFX3ySLjERuDmSB34vCkodqPxOk3NjwMBb+Hsf9TA9gwHkFHJ53RqcaPqRUz3B50OjHoCayP1LSfVWOEGmtzkjOAxbDVQAIbCK4WhS08nggOuk1jQg8MZiyBrnuQEkn6F6stM++RPJP7iTu74Dut2qtIkLlZtWZnhXygbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354818; c=relaxed/simple;
	bh=vXTmB3myv1seqQT/Ieh8KBFwJ00yJHYtk8XEKor8RLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rkt75JUy9BpJQ7E8XjLu6+SsU0lCPjd5gS1MztEHLPs590xm5MCaYJ7YIfenkzRHNrNW7OcjcsmLVKatXitCv8czh4MlcotMjr0kH/FxGt5WQQTEvCeUtzKlvtKeWUKXeHOSYHPUP8h1pOpWGXx4lObW6Kp6JaJ15EdHdxPxUSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jW3S66tb; arc=fail smtp.client-ip=40.93.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMkcVeQBDULn7NRxorFlBwsO71oQmgCzeb1yD8I+EgUchTc7+KxtSSPitIiSCxyuNPwiK7ELNnfvQjmsUiKtj8epD6qZGG7QJiBcCuS/VV/wg/AFek8U2tog3Ste15kwm8g9gfMr9fFWUOIn77MKEtRKUXG452ou/0LWL8ge7vmv34p/5Sxy0tK7yuQEveIHBZCnLpWNn5P+hF5DIEBfplRCUDYHuD3PG1q7av3SR1yrWrzg+dF2/wboBgKD0e6f5I58ZFKQ988ZbTBbStvgVIOp4gRW2Vd3qGl9fSFY53KS8Vt2cj5DrxJ42J5WIMDAf7eLYmblTGxF8E4e6YkUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnYzYzIOV4J0Pg1YAnd/o0zscm+Kqp+e+5GI3fWiWaY=;
 b=y+AdjosmAEe2e4bz3wHKZo1IYUNvefz01XURwDavJj2FRs35k//m1RDysI4FD9A8Iqmvn+AavrrHLOaom2A8UTB/iBD9V1d2zTJECNmeinGxTvLbtZwtH/q2oJN5u3f64SfKhqRG7jUEwsIyv11PMML0Tq+yvFJTJABGELSlgkI8sNDxcuidjWZ9NLoQBSnTPh6sYX8dTPRk0MaH2ohmhHqfUFjYmCYSpIo7gUAAgAA+Qy3vVl8cpeZEguWOZrJ6TM+tW2d1PUL2hTiGBkEaKy17Fz4OCsOUnKvZ/UVDUjgpbE6ScB3QI9ERsMLlm1pIaPKGmb/PSZ1NUJ/5mO+frg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnYzYzIOV4J0Pg1YAnd/o0zscm+Kqp+e+5GI3fWiWaY=;
 b=jW3S66tbiOBkaV22XbCPrz8U19CfDpFDydcStxDTUgpbd5gudeu615NkYLYGaBcEvi2V+HJiQA5IPmzTe4qlg4VhjlWcOS2MI3v67A0mc+la045kxZFpUYZvXI5S1vhEYI6TKPU2gPwpUxNJ7I+RI8mk95MVEyARbW1EcdprgPCuQZa0tZOkZVJxZzBMIxbHu/KD1pv1mvr+hbMiD4ql+XqXunI1uT2NG350K2TQPqVKto79w54RxMzCcd4ymYBdRqlYE5KeEL2FHKBj6fItqH02O7jF4mu1B+KNuVvpRhwm7VDfdiIJIhqDuwlbw6fJ+em7iSSASwR9+yLym2uz8g==
Received: from SJ0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:33b::22)
 by SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 05:40:01 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::eb) by SJ0PR05CA0017.outlook.office365.com
 (2603:10b6:a03:33b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 05:40:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 05:40:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:39:45 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:39:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 22:39:38 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Simon Horman
	<horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH mlx5-next 1/4] mlx5: Rename the vport number enums for host PF and VF
Date: Tue, 28 Apr 2026 08:38:48 +0300
Message-ID: <20260428053851.220089-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260428053851.220089-1-tariqt@nvidia.com>
References: <20260428053851.220089-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c25694-4656-46b0-72a9-08dea4e89726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3RMIofOv9HARQ2Lmtaux4voEMsyJvbBirLb1UxVa1w8zMMfW0y/xyuo5PMpdQ2AJv35UDpZh6oC1ecv8h/SBZriLq3otdk7Ko9atOdvRZK6d8WS1ExQ8gY8XrTUCimNlPTX9OkZi/fqfUqoW/RAo+ZZfp2fn0oBdmAFyIrANciHb0k7KPyLavd+HqVmyQH9JTPHvTxRKazgtXuWHwQchxA0CT+jWle5zrJDH0q+IAeAeIM5FNZ/mP2alw/PxI/vwvzrrdsCgNiNFMLY06aA40qtaQFonsv/lwQ2c+1JkDKeEzKGpyTP4HrqeCBs6er1HXfp2TXtvIhvajAzHF8R+YDcPQmiXywfAYDNe1u4QUx09hfYklEkt0Yss7Vnk/xOVOAThkQ6M1CKU4alHM49MtdYKc6XM1k5teGxjLin5kA+PVyBtQaToX4tZyFG8Vnqgo1kkxVO0dB+9iOjAQYKFsFt53BI9rc0XkEc4CCHEHgBdfLxeAexgbEg1PJdPSa2RJE5/vqYzptTQORprYMMwA9jwmJQCunoRCi5go9VolNK5QzMAxH0Y7gyPzUG9vXVv+yKt/cZdX5gSQZhJXtJtNks8a9FQ/0tbEOt8+taHLxu62+mBaLRuxhGrmOVrxiIKedHxgCNvDbrrmd86tzN2do+riQycagZb3F2skxaWZ751n2/+nFiKKdcAcJPa6amxpiVgAgqQQdx/ToMhFaPtNm0vFeDpyoNAbxLTbe/1BsvS12gx/IYM/8+3AxoV29WltZerd936A1UfZPzEfe7GLQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5IGade0Jg7NGDSi5vrjbYQ1knWeDWdEYhnKRsig0qj3gvaF3CFIDxeBYUAhMqkPw5RyrdZrYuQv6fj4d2d3FYi3Lb6RvTxxYNJd88egvfp0ODcorI2RaFa4EspW2HlYaP7J+Bk8shI8IepZaXgI6hJwbJ5CZrTyBkwNeuzMSLagICyXwCmaD7OCQwcDdjfLPfiLgehtcQkXsKIl/7bQ8NR/nvFepYmpLKMCLTvfAX0qUjk28M2yMpfgkEWHdyRRZRZS+ABDB+i6A1ZAa75sA2Im7ZTl7vt7jvOYAf2kJXPmlk03N+gslYCjGx5sYck7W2eLjzV7L9eUqqjWltMH0/i1QC19xHDL/e/MRqY1RmKmpSqdAubOfivq83UTu0A94ErDOpDM+2SWRld72fFgMxFYsTEMkn44JOceqR1nVI2qejHK16o1Abf0hW6V2o1v5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:40:00.7336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c25694-4656-46b0-72a9-08dea4e89726
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089
X-Rspamd-Queue-Id: BCAED47DB7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19632-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Moshe Shemesh <moshe@nvidia.com>

Rename the vport number enums MLX5_VPORT_PF to MLX5_VPORT_HOST_PF and
MLX5_VPORT_FIRST_VF to MLX5_VPORT_FIRST_HOST_VF to indicate that these
vport indices represent the host PF and its VFs. This prepares the code
for upcoming support of an additional PF type.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/hw/mlx5/counters.c         |  4 ++--
 .../mellanox/mlx5/core/esw/devlink_port.c     |  7 +++---
 .../ethernet/mellanox/mlx5/core/esw/ipsec.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 22 +++++++++----------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  2 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 17 ++++++++------
 .../mellanox/mlx5/core/steering/hws/vport.c   |  2 +-
 include/linux/mlx5/eswitch.h                  |  2 +-
 include/linux/mlx5/vport.h                    |  4 ++--
 9 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 5b4482dd6274..5a79e834ddea 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -697,7 +697,7 @@ static void mlx5_ib_fill_counters(struct mlx5_ib_dev *dev,
 				  u32 port_num)
 {
 	bool is_vport = is_mdev_switchdev_mode(dev->mdev) &&
-			port_num != MLX5_VPORT_PF;
+			port_num != MLX5_VPORT_HOST_PF;
 	const struct mlx5_ib_counter *names;
 	int j = 0, i, size;
 
@@ -802,7 +802,7 @@ static int __mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev,
 				    struct mlx5_ib_counters *cnts, u32 port_num)
 {
 	bool is_vport = is_mdev_switchdev_mode(dev->mdev) &&
-			port_num != MLX5_VPORT_PF;
+			port_num != MLX5_VPORT_HOST_PF;
 	u32 num_counters, num_op_counters = 0, size;
 
 	size = is_vport ? ARRAY_SIZE(vport_basic_q_cnts) :
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index e1d11326af1b..8a79764345e7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -13,7 +13,8 @@ mlx5_esw_get_port_parent_id(struct mlx5_core_dev *dev, struct netdev_phys_item_i
 
 static bool mlx5_esw_devlink_port_supported(struct mlx5_eswitch *esw, u16 vport_num)
 {
-	return (mlx5_core_is_ecpf(esw->dev) && vport_num == MLX5_VPORT_PF) ||
+	return (mlx5_core_is_ecpf(esw->dev) &&
+		vport_num == MLX5_VPORT_HOST_PF) ||
 	       mlx5_eswitch_is_vf_vport(esw, vport_num) ||
 	       mlx5_core_is_ec_vf_vport(esw->dev, vport_num);
 }
@@ -35,7 +36,7 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 	if (external)
 		controller_num = dev->priv.eswitch->offloads.host_number + 1;
 
-	if (vport_num == MLX5_VPORT_PF) {
+	if (vport_num == MLX5_VPORT_HOST_PF) {
 		memcpy(dl_port->attrs.switch_id.id, ppid.id, ppid.id_len);
 		dl_port->attrs.switch_id.id_len = ppid.id_len;
 		devlink_port_attrs_pci_pf_set(dl_port, controller_num, pfnum, external);
@@ -216,7 +217,7 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, struct mlx
 	if (err)
 		goto rate_err;
 
-	if (vport_num == MLX5_VPORT_PF) {
+	if (vport_num == MLX5_VPORT_HOST_PF) {
 		err = mlx5_esw_devlink_port_res_register(esw,
 							 &dl_port->dl_port);
 		if (err)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
index da10e04777cf..8b12c3ae0cf7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
@@ -209,7 +209,7 @@ static int esw_ipsec_vf_offload_set_bytype(struct mlx5_eswitch *esw, struct mlx5
 	struct mlx5_core_dev *dev = esw->dev;
 	int err;
 
-	if (vport->vport == MLX5_VPORT_PF)
+	if (vport->vport == MLX5_VPORT_HOST_PF)
 		return -EOPNOTSUPP;
 
 	if (type == MLX5_ESW_VPORT_IPSEC_CRYPTO_OFFLOAD) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 123c96716a54..80ba360347e7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -926,7 +926,7 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 	/* Sync with current vport context */
 	vport->enabled_events = enabled_events;
 	vport->enabled = true;
-	if (vport->vport != MLX5_VPORT_PF &&
+	if (vport->vport != MLX5_VPORT_HOST_PF &&
 	    (vport->info.ipsec_crypto_enabled || vport->info.ipsec_packet_enabled))
 		esw->enabled_ipsec_vf_count++;
 
@@ -979,7 +979,7 @@ void mlx5_esw_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 	    MLX5_CAP_GEN(esw->dev, vhca_resource_manager))
 		mlx5_esw_vport_vhca_id_unmap(esw, vport);
 
-	if (vport->vport != MLX5_VPORT_PF &&
+	if (vport->vport != MLX5_VPORT_HOST_PF &&
 	    (vport->info.ipsec_crypto_enabled || vport->info.ipsec_packet_enabled))
 		esw->enabled_ipsec_vf_count--;
 
@@ -1314,7 +1314,7 @@ int mlx5_esw_host_pf_enable_hca(struct mlx5_core_dev *dev)
 	if (!mlx5_core_is_ecpf(dev) || !mlx5_esw_allowed(esw))
 		return 0;
 
-	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_PF);
+	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_HOST_PF);
 	if (IS_ERR(vport))
 		return PTR_ERR(vport);
 
@@ -1340,7 +1340,7 @@ int mlx5_esw_host_pf_disable_hca(struct mlx5_core_dev *dev)
 	if (!mlx5_core_is_ecpf(dev) || !mlx5_esw_allowed(esw))
 		return 0;
 
-	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_PF);
+	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_HOST_PF);
 	if (IS_ERR(vport))
 		return PTR_ERR(vport);
 
@@ -1368,7 +1368,7 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 
 	/* Enable PF vport */
 	if (pf_needed && mlx5_esw_host_functions_enabled(esw->dev)) {
-		ret = mlx5_eswitch_load_pf_vf_vport(esw, MLX5_VPORT_PF,
+		ret = mlx5_eswitch_load_pf_vf_vport(esw, MLX5_VPORT_HOST_PF,
 						    enabled_events);
 		if (ret)
 			return ret;
@@ -1423,7 +1423,7 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 		mlx5_esw_host_pf_disable_hca(esw->dev);
 pf_hca_err:
 	if (pf_needed && mlx5_esw_host_functions_enabled(esw->dev))
-		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_PF);
+		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_HOST_PF);
 	return ret;
 }
 
@@ -1450,7 +1450,7 @@ void mlx5_eswitch_disable_pf_vf_vports(struct mlx5_eswitch *esw)
 	if ((mlx5_core_is_ecpf_esw_manager(esw->dev) ||
 	     esw->mode == MLX5_ESWITCH_LEGACY) &&
 	    mlx5_esw_host_functions_enabled(esw->dev))
-		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_PF);
+		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_HOST_PF);
 }
 
 static void mlx5_eswitch_get_devlink_param(struct mlx5_eswitch *esw)
@@ -1822,7 +1822,7 @@ static int mlx5_query_hca_cap_host_pf(struct mlx5_core_dev *dev, void *out)
 
 	MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
 	MLX5_SET(query_hca_cap_in, in, op_mod, opmod);
-	MLX5_SET(query_hca_cap_in, in, function_id, MLX5_VPORT_PF);
+	MLX5_SET(query_hca_cap_in, in, function_id, MLX5_VPORT_HOST_PF);
 	MLX5_SET(query_hca_cap_in, in, other_function, true);
 	return mlx5_cmd_exec_inout(dev, query_hca_cap, in, out);
 }
@@ -1914,10 +1914,10 @@ static int mlx5_esw_vports_init(struct mlx5_eswitch *esw)
 	xa_init(&esw->vports);
 
 	if (mlx5_esw_host_functions_enabled(dev)) {
-		err = mlx5_esw_vport_alloc(esw, idx, MLX5_VPORT_PF);
+		err = mlx5_esw_vport_alloc(esw, idx, MLX5_VPORT_HOST_PF);
 		if (err)
 			goto err;
-		if (esw->first_host_vport == MLX5_VPORT_PF)
+		if (esw->first_host_vport == MLX5_VPORT_HOST_PF)
 			xa_set_mark(&esw->vports, idx, MLX5_ESW_VPT_HOST_FN);
 		idx++;
 		for (i = 0; i < mlx5_core_max_vfs(dev); i++) {
@@ -2195,7 +2195,7 @@ bool mlx5_eswitch_is_vf_vport(struct mlx5_eswitch *esw, u16 vport_num)
 
 bool mlx5_eswitch_is_pf_vf_vport(struct mlx5_eswitch *esw, u16 vport_num)
 {
-	return vport_num == MLX5_VPORT_PF ||
+	return vport_num == MLX5_VPORT_HOST_PF ||
 		mlx5_eswitch_is_vf_vport(esw, vport_num);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 5128f5020dae..f6a23930f308 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -684,7 +684,7 @@ static inline bool mlx5_esw_is_owner(struct mlx5_eswitch *esw, u16 vport_num,
 static inline u16 mlx5_eswitch_first_host_vport_num(struct mlx5_core_dev *dev)
 {
 	return mlx5_core_is_ecpf_esw_manager(dev) ?
-		MLX5_VPORT_PF : MLX5_VPORT_FIRST_VF;
+		MLX5_VPORT_HOST_PF : MLX5_VPORT_FIRST_HOST_VF;
 }
 
 static inline bool mlx5_eswitch_is_funcs_handler(const struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index a078d06f4567..c32335df6b64 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1216,9 +1216,10 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 
 	if (mlx5_core_is_ecpf_esw_manager(peer_dev) &&
 	    mlx5_esw_host_functions_enabled(peer_dev)) {
-		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_PF);
+		peer_vport = mlx5_eswitch_get_vport(peer_esw,
+						    MLX5_VPORT_HOST_PF);
 		esw_set_peer_miss_rule_source_port(esw, peer_esw, spec,
-						   MLX5_VPORT_PF);
+						   MLX5_VPORT_HOST_PF);
 
 		flow = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(esw),
 					   spec, &flow_act, &dest, 1);
@@ -1300,7 +1301,8 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 
 	if (mlx5_core_is_ecpf_esw_manager(peer_dev) &&
 	    mlx5_esw_host_functions_enabled(peer_dev)) {
-		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_PF);
+		peer_vport = mlx5_eswitch_get_vport(peer_esw,
+						    MLX5_VPORT_HOST_PF);
 		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 add_pf_flow_err:
@@ -1342,7 +1344,8 @@ static void esw_del_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 
 	if (mlx5_core_is_ecpf_esw_manager(peer_dev) &&
 	    mlx5_esw_host_functions_enabled(peer_dev)) {
-		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_PF);
+		peer_vport = mlx5_eswitch_get_vport(peer_esw,
+						    MLX5_VPORT_HOST_PF);
 		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 
@@ -4435,7 +4438,7 @@ static bool
 mlx5_eswitch_vport_has_rep(const struct mlx5_eswitch *esw, u16 vport_num)
 {
 	/* Currently, only ECPF based device has representor for host PF. */
-	if (vport_num == MLX5_VPORT_PF &&
+	if (vport_num == MLX5_VPORT_HOST_PF &&
 	    (!mlx5_core_is_ecpf_esw_manager(esw->dev) ||
 	     !mlx5_esw_host_functions_enabled(esw->dev)))
 		return false;
@@ -4791,7 +4794,7 @@ int mlx5_devlink_pf_port_fn_state_get(struct devlink_port *port,
 	const u32 *query_out;
 	bool pf_disabled;
 
-	if (vport->vport != MLX5_VPORT_PF) {
+	if (vport->vport != MLX5_VPORT_HOST_PF) {
 		NL_SET_ERR_MSG_MOD(extack, "State get is not supported for VF");
 		return -EOPNOTSUPP;
 	}
@@ -4820,7 +4823,7 @@ int mlx5_devlink_pf_port_fn_state_set(struct devlink_port *port,
 	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
 	struct mlx5_core_dev *dev;
 
-	if (vport->vport != MLX5_VPORT_PF) {
+	if (vport->vport != MLX5_VPORT_HOST_PF) {
 		NL_SET_ERR_MSG_MOD(extack, "State set is not supported for VF");
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/vport.c
index d8e382b9fa61..6dc3b11b7926 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/vport.c
@@ -50,7 +50,7 @@ static int hws_vport_add_gvmi(struct mlx5hws_context *ctx, u16 vport)
 static bool hws_vport_is_esw_mgr_vport(struct mlx5hws_context *ctx, u16 vport)
 {
 	return ctx->caps->is_ecpf ? vport == MLX5_VPORT_ECPF :
-				    vport == MLX5_VPORT_PF;
+				    vport == MLX5_VPORT_HOST_PF;
 }
 
 int mlx5hws_vport_get_gvmi(struct mlx5hws_context *ctx, u16 vport, u16 *vport_gvmi)
diff --git a/include/linux/mlx5/eswitch.h b/include/linux/mlx5/eswitch.h
index 67256e776566..3b29a3c6794d 100644
--- a/include/linux/mlx5/eswitch.h
+++ b/include/linux/mlx5/eswitch.h
@@ -217,7 +217,7 @@ static inline bool is_mdev_switchdev_mode(struct mlx5_core_dev *dev)
 static inline u16 mlx5_eswitch_manager_vport(struct mlx5_core_dev *dev)
 {
 	return mlx5_core_is_ecpf_esw_manager(dev) ?
-		MLX5_VPORT_ECPF : MLX5_VPORT_PF;
+		MLX5_VPORT_ECPF : MLX5_VPORT_HOST_PF;
 }
 
 #endif
diff --git a/include/linux/mlx5/vport.h b/include/linux/mlx5/vport.h
index dfa2fe32217a..90641f67da46 100644
--- a/include/linux/mlx5/vport.h
+++ b/include/linux/mlx5/vport.h
@@ -51,8 +51,8 @@ enum {
 
 /* Vport number for each function must keep unchanged */
 enum {
-	MLX5_VPORT_PF			= 0x0,
-	MLX5_VPORT_FIRST_VF		= 0x1,
+	MLX5_VPORT_HOST_PF		= 0x0,
+	MLX5_VPORT_FIRST_HOST_VF	= 0x1,
 	MLX5_VPORT_ECPF			= 0xfffe,
 	MLX5_VPORT_UPLINK		= 0xffff
 };
-- 
2.44.0


