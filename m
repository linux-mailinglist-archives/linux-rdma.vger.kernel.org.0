Return-Path: <linux-rdma+bounces-20292-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OFtFkgZAGo3DAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20292-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:36:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF1A502AA0
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EECD300D707
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 05:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E406352FA5;
	Sun, 10 May 2026 05:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EPiLn2A2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A292E6CB8;
	Sun, 10 May 2026 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391365; cv=fail; b=k7VUuzbdNBi6Gt0YfATdca0Zg+Qihc+lTqn6YHqI7Zwr2JaWcaWiT9q+No0U+BeoaH3ztx2mbXaky/mJVc55yBA+zY5t/zUPM8OS3J5lTDd3hfG+sJFxL8ODt4tLAcEEWLDeIJvf1SVT+vfTM5R+BXfEgPWZJHMhZdr8OujhWo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391365; c=relaxed/simple;
	bh=7cRR3dROHYOZW3uiR7MbvYW6XohxB2YMs3qlyQJfxoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcTp6bH1IzxEongoUNtvaXijbu5U2geEqACtHYHAhqzu9qFbUy5PB7x/rnbsnZYrH5BE08Wb2sgkSZtWMNoSk8LfTJNIilRIJYvH2wOMlU1+xqPw4mIOmlXwccHqfW629tOBnd4F+l/hEYinclqAQ1dNvCZrZNoC9IRFJXdCLyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EPiLn2A2; arc=fail smtp.client-ip=52.101.43.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSj8sO738WRlDadG5ED1TsRq4iw2GPRGpjvFbI9ZMh6VDEvDV3r+xOG8VXdw/6MUGSIYYINTyQC05qX0v8U/6h7rrvV6dUHv+RWEkPBCNzMgGo7QVwtcshBOHHp2Iwp4YiiBTPO4hSjaM80yC+IqYA+kEsKQvJigim85QGed3xEjs0DCEPX1/FpOzg8mqxe+ZnHyoBiuloe/dYWZLlBNmOXSV1jFGsayBzCo296f0sI+0ICL0CHZWKiMqS+Wbo6yASYAmMgrybfTMHnBwalizh00vMdCl2TW3IJqo30AjGug5gMAEwp9lIG1sAZZbkNy3IRq/d59bZXdPsx0DLXMSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eY/nYDpFIEhYnyC1EfCso5ub1d7CkBWH5ne33vU02Y=;
 b=Qo+MsX4e1nqNaPSMGUmdPHEStgkKXsQ+bGC/pc57ShmYs/pi4pasIKyf9sgw3ELzDBJz581Dp3HllqpU0CoWpq06f8PeUfvNWwZhmmIcWxD6wp7wmOl0F+1Rxd/xFMrZcQDitbbdz3/Ohr3Yx0BF0gpXLxO5miAkStzO3SiLfcFEGRQIcX2UbaySeNQ9tKLEKJ2gV/Ce82eX/dsXaORazkZNe+F1GNHr5xr/tTTEpqmzHu+2WnOX0EjM+MjfbSTYNy8tTXK7YG9++x5oIJXAQQ/j2CnFnz41Q89YamLjj7NRpjO+YNx+O6aHyx3On4t/X/RTfpo14ogjrWumkYSRnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eY/nYDpFIEhYnyC1EfCso5ub1d7CkBWH5ne33vU02Y=;
 b=EPiLn2A26qk5XUP8cZDJpodRJnYQ7OJJratyzAcxFiNFI2uTURpb2VQ3m00TR9UaIOCkSt2zHLMzqxhWq7m3oDH16ZP+NxSaQxS53jtWGxyRMmYPylBaUdd4zUumgWaItJpRRmTy/IFB6ZMjnHO1cCsJtNjuGNXdnHgI5535BMRTaRYSlP1jr+KypbDcBwx1/yAnT1EeE9VnDHEfAKgOOOvOHM8JWaFnWgC/dAj3IQsOl6osuOKMS81h0nbeIJWB7RQ5700WIL4InRP4w9hf/BHpzKXE95o6pwnQ0Pw6D5VbRXB1T7IVg8Olc89r91Vws9g3iMYJ1DqWCS3zOqKuCw==
Received: from PH8PR20CA0023.namprd20.prod.outlook.com (2603:10b6:510:23c::29)
 by DS1PR12MB999188.namprd12.prod.outlook.com (2603:10b6:8:495::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 10 May
 2026 05:35:56 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::c1) by PH8PR20CA0023.outlook.office365.com
 (2603:10b6:510:23c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Sun,
 10 May 2026 05:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 05:35:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 9 May
 2026 22:35:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 5/8] net/mlx5: Add mlx5_vport_set_other_func_general_cap macro
Date: Sun, 10 May 2026 08:34:45 +0300
Message-ID: <20260510053448.326823-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260510053448.326823-1-tariqt@nvidia.com>
References: <20260510053448.326823-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS1PR12MB999188:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0cb460-e218-40ef-d202-08deae5601fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UnKJ1D10u8/bAePqg7soFyaPgBZ2ZzG9Zw8UW5Rm8TgLFS81Ivm226oDO0K9G+5BE+C8jnBkzV9jrFiY0yJ89YkvQ8NUsVzYQ5OBrwqxfTgojomVbg1iwhCMVNQwupwuPC8Vk0Wkneik0saO9jcEf26TlC28XeEpluHYntEpwnMdycmvwQeSWAp6OlXVNTXyUC/trZZnqRVwMAsr4lgsPqIScPqQ97FNAnqSNhcZItRq/N48G5x8zoqFPuu8twT+ck4KolzMWz+U8s2/ETE9G6LncVtuFE4NEvhzUKlB/RM0Bq+XCMOLuTOw0SiaBCM+NDKQwPd3zPtEjJg27ciFh+OUAOZkoqdwp8UbNfeCzWxkKbkkzXYSRs1/WAspZrdcscdIm4cclgOLBEEsqZPiqvZVRgL5WYtWrZqmyQ/fHa27On8HZ81zMUB6K4XgtWPJFLo2OGDEdVWayFSIankwaUm2P1UAdDS6iwFRUA6X21HQEqO8tVx2erhNytx6hllMGK5KIqA1QhbASgIvB7uDT3C0gMIuLFRCesL/nXixhYz7ptwsJszY6Dca1y3DMUMxkDBbWsRgJqUSRrAQTPDK8OjFgh9T6IA5GLvEy/oKNZCNoXZAXpqMqEjqXlzQ4KK1G7ko6Ut+GufTAVSaulyWvv7MLXjdlaPbX0NLheX9sKWMJYtrJggX7XqIU89dzQQNzdH/FN8yNEWdUHmyf0mzDLPXVKGhcRXZciE5FanuL5E=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2HF+yIKl/CUdOhRQfsLDkzkY/f3FzwzMUMhcSmavsDwteMCVFsAzqUPOFRKaOO32+U0Dv9VHwGYwe3BJZnFF8jNIgaKkp3viUGMFgsH84G8bHYmvJ09NIDNJXuCy4cnpY51M820lzD2QDdm/wkmhzTkrqADuBpgmvicf3PDy4lKrJYV+toCvCBWuIN74eUEFOUgw2xo8EH3TgzH1E35wPW58b5mYd4WpEXwWA6dK0vZ4eoGQqMLyh7NfujPyBq51ElfVjB9516zd+skHritXYgePghPfs6uYmipDtqW1R9aahpGkog2NsF5J2+TfU8ae/6PUKV89fwm9ROV4nhOs7YzAmRHe0q2kQjtHRfq+4v4tpPw/MeEoXRcdgPgmAQW9+3Gp+8ag0tMyf9I65lr7JINTkqyO0VKSh637zkKFUSJ/FkXSFWbO1p4Smu3ezZsp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 05:35:55.5816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0cb460-e218-40ef-d202-08deae5601fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999188
X-Rspamd-Queue-Id: CBF1A502AA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20292-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Moshe Shemesh <moshe@nvidia.com>

Add mlx5_vport_set_other_func_general_cap() convenience macro, symmetric
to the existing mlx5_vport_get_other_func_general_cap(), and use it in
mlx5_devlink_port_fn_roce_set().

No functional change in this patch.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h        | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index acbc37b05308..b06b10d443bd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4951,8 +4951,8 @@ int mlx5_devlink_port_fn_roce_set(struct devlink_port *port, bool enable,
 	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
 	MLX5_SET(cmd_hca_cap, hca_caps, roce, enable);
 
-	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport_num,
-					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE);
+	err = mlx5_vport_set_other_func_general_cap(esw->dev, hca_caps,
+						    vport_num);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA roce cap");
 		goto out_free;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index d70907f499a9..2eba141bd521 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -457,6 +457,10 @@ int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap
 #define mlx5_vport_get_other_func_general_cap(dev, vport, out)		\
 	mlx5_vport_get_other_func_cap(dev, vport, out, MLX5_CAP_GENERAL)
 
+#define mlx5_vport_set_other_func_general_cap(dev, hca_cap, vport)	\
+	mlx5_vport_set_other_func_cap(dev, hca_cap, vport,		\
+				      MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE)
+
 static inline u32 mlx5_sriov_get_vf_total_msix(struct pci_dev *pdev)
 {
 	struct mlx5_core_dev *dev = pci_get_drvdata(pdev);
-- 
2.44.0


