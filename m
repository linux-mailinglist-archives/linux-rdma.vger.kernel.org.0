Return-Path: <linux-rdma+bounces-17124-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJarBNaQnWlKQgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17124-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 12:51:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 872DA1869BB
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 12:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75D0130C25AA
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BB33806DC;
	Tue, 24 Feb 2026 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FXdBwbaV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BB13803F4;
	Tue, 24 Feb 2026 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933668; cv=fail; b=RRKYCQbZCges6h/WUfvO8UUCuP7Iydjyxgu8g3XeCw7MQIs21Q4YC3hmOPEyBWewOJIDAvfE6PrrgmlsgPOB2p/YnxliV9FOrJ/RbF565wKfz1EpoNsubF+fdSqBWtIy5U+Ca9hDeqHzouKXa3l3of0kOIm80kq4PDlZU47NbT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933668; c=relaxed/simple;
	bh=WpUOQUXkGYzBC+GkcBB5y0VK2uJEGasAsvmOBDxpiM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nxj9WqSerUdR98KRWDvw9Mwq5FCHck/Zx0pEw4xO+6R/vQNCWByyroU2uc16VrbhG1734DJEN+W57MUp/Bxlqm13yMBl8YOuvJxNX7N+ELW0E0rumgLTyLLRO+h7UZKRSHw4lZAmVBrQHixjNtfc/DM2K+xMmMdgExCcqJVuuac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FXdBwbaV; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHxHGGOUayEQtFUr9VriQ4hS6/UHrzWASnc0tiAuRyvJnQu0vUMrvB9SjLq02IeUGYSiBx2MmuCLkeg50G7iz7c4+Pa39w/cHtvhJZ41eHc79aM+33EZImIQgIas72ZL52fVWUcn1AIY2mhzsPdIRAbe+V6reaNtin9tXhqzCYRR7nw7Je8Z5lvPOhk/xmmKlXArg/8gXekdlKCOj8HI06xDL7YBxZ+vAl8tyqvmCqxTms1mK5X3/mHno6qrvz4cHyVWVmAaDXocAI28ewpSsxnlh84Hh2qSFVglEYxnaqg3q1j5hUahMM/+MgX+BgasG+zueLKXesrGiOhNZxZQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhdYikAD8yHnHJqoVDD+BnO9YCSk4dZ7ARilacq3J4s=;
 b=oZcH58Lc6DjODRn+1l3jEssa1P2MqDobgUW9jd4VlDz4Vev5lDnW5Mzz4besglW9xVeZuhankFbGxhflEVJcuq/Yt95UCr6d5djWn8F4QZoYIeXrbrhvMa0n8PCxFQbux3wmR4liREl8lihXbJT/moB8E04hAF8c3E2fxqBf54L00QeGIb17/hch6tOYFYZfWyxpqVv2bB+NX+30gzaYvzgCRmMOjjaDvK62EceZmCcEUqTdi8IrcV4nrirerp1a4HMT05rJN8YbhK8hXr4aUotAMv/1POaU1ZWVGpvm3LJkTMRGLWaT/FxB+N5OdDeD1WveTLLDX/v5RtJI6+6+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhdYikAD8yHnHJqoVDD+BnO9YCSk4dZ7ARilacq3J4s=;
 b=FXdBwbaVBqAtZPbWnSF0WTuScarmZutg/6H4vFb/6gWOL+a/H/Eyw1Ar0FHvh9+7HA4hUFyizC0RRrTKG1z8AqS8tyWjtAxUtGIC4/+degFxvG7OvykOpx3rRAiTFlkbDhk4kZ4fj9yh9TWr3PMmauvj+Sn7b4BYP0RRBj7/vibKzMUkthkEw6mfbIvL3ePDDCN3aBAv6NJdSHRB7b7v8EtZVEH9c3Gsi7IKzHMCRpvxOvMPj8ENRjN/vN/OBmLmzAs5MaQkZFfj3vBhh/YQOg3M1h6sV+iBRfFvPGZSTU9rzpmd6O62N+1B2q9K0DUMkQYe0J28CVzKcXg9rPCnMQ==
Received: from BN0PR04CA0168.namprd04.prod.outlook.com (2603:10b6:408:eb::23)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 11:47:43 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::d6) by BN0PR04CA0168.outlook.office365.com
 (2603:10b6:408:eb::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 11:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 11:47:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 03:47:31 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 03:47:31 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Feb 2026 03:47:27 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net 4/5] net/mlx5: Fix missing devlink lock in SRIOV enable error path
Date: Tue, 24 Feb 2026 13:46:51 +0200
Message-ID: <20260224114652.1787431-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260224114652.1787431-1-tariqt@nvidia.com>
References: <20260224114652.1787431-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: fb99599e-e402-41b5-fc26-08de739a8527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DjNxUrVgOUQWislu+vUf9DEN6DIqwnuJmBZFD4VZ3fnbLoB756qvWj7YopVR?=
 =?us-ascii?Q?vNdDCE/tVxKs4WkufUty6UXBeY5tYaARqS/2va/HO/zL4/12AB9k/E/lVpfR?=
 =?us-ascii?Q?1V0V3AgZbtHrOwQB3YiFwe0c22FrpkIRzQm+HDIvnqBDU6AXSQH8f3G0TTWK?=
 =?us-ascii?Q?EivPThL7SbkYJp5v9d1RGXTTNYVAWkia0nPLRcdh4ApyyOrih59sLHagcwUO?=
 =?us-ascii?Q?YJ53Vu1aHD//x2lrFQpdoi4nmPB6drhvNXlNkFaRLqPCpJWwI6YuCK2+KumW?=
 =?us-ascii?Q?d1vj2/GKg+DS8KxYT8LdFDr0VJxBFNz3k3MO0duiUCSvMJZv7QUU5MmyhwIV?=
 =?us-ascii?Q?pTu0HKTzRTU8c/wGeHYO8bLxayvvaWEnTiA7bRvzTguRpnG+sUjzaashV6Bc?=
 =?us-ascii?Q?1yxcRj0EOpySJ7IOj1bbQ9NWFxVtp7qDqcqeexNaPaIG9XkDHhZQhFMzx5gA?=
 =?us-ascii?Q?2jvjPIbRNlRoil72eISV77gY1Q7moIZWQKaTOEiKUGetlPAFUHaoqPuORPrh?=
 =?us-ascii?Q?BZlH/hYQktaxHuXMpkNS6aeLD1hIxeTgksssOoD3hnnXp0lRsiNKFlHC5vhw?=
 =?us-ascii?Q?DzRLHHxU3BYvrCZekpTkr8LznNT/1ZOYK3T5VREOBPRh4ZQHE2a+uZo/v2Cq?=
 =?us-ascii?Q?J8lpK/IGaD50/s797qOed9r8/xHArDObNEoWzpQVOxarZyXVgL9Ty3O1LtF5?=
 =?us-ascii?Q?xVDMyxxNa3Baze2/FDVYOvquB/9UKUMvZU2WtXEjKcIZZNPa5Qj/EurT+dJr?=
 =?us-ascii?Q?e0P7ThBwJHK0FwtY3xmsu2w/7fNpRYKndvhGdE/oZgkH/hHoVH1VB04wLErI?=
 =?us-ascii?Q?8HsIOBLR7HzzzyICN6S3ahX4YfI1pRP+bYWNb6bbWdbXEfmKzESWruDcQcTF?=
 =?us-ascii?Q?toPLg3+x/cUXE86++bG58BDCa7d7wVTX4EzEfGbb7MVBDgHoimKEeVFZVm0V?=
 =?us-ascii?Q?98kWSBysZdOfrTKQvSkWCmoja8EV//icpYi7n78y4M3Nll+/ecQMtklL9V6W?=
 =?us-ascii?Q?EsEzQSJrwxEwcRGgZ2ZnphVGOwcgTUpKCbdyNRyOPAS2yY9fUcVT9e+H84JI?=
 =?us-ascii?Q?G8bg7yZ1AgywsDnp7RJZpSuEbJy/L7IcgV4lqdoMhDFuQOZvsq9jP0N8t0n6?=
 =?us-ascii?Q?F6nvUKhorHItZVdyZO+qC7CTJUiODWXA0hNyoM/zrk2XqitUl2zlrDXfOBGh?=
 =?us-ascii?Q?NMNPaS+/I1weOuhVkFjykIMHpS/05CeuCNZQGO0/HA2KJK885f3L7hbVOK+l?=
 =?us-ascii?Q?bfUmO9ix2Nq88g+6ZC7MXUXdQTqo5QebRMA6jDP3RtLi/+KkpGaozj7B97Yk?=
 =?us-ascii?Q?/Dmq5c5589FndsXaukf2P1AouM4IB6NoQn31majEG56MCqxdaZTvTnV4eSD5?=
 =?us-ascii?Q?37EJVdB2rEMCId9VCFIQ8PA+bJnhZsurx0Y8CZNtnYEjlUmP/XEeiJzGAOqB?=
 =?us-ascii?Q?Dk6hhGjL/fcznUz6epZXOOY3PokRUrlkgtqFpHFcKHVYW/LJdWGP+aoxvujm?=
 =?us-ascii?Q?y63jkYcZSuCxzm9eUOYDvr3rrT6m/ztPoyKVPuyVx1w71LwVFoiP3PFNOT7x?=
 =?us-ascii?Q?N8FEpolAjH5gX+RIcX+iqgtbZKCIfVVYUZzBsNGXn6i2cf49W0HjtqvjYjCQ?=
 =?us-ascii?Q?dnT3fDjfaAeodQRxVAYeblAr4Mvxf0bpB3pqhV3j86YjCecRfR4qE88x8xrW?=
 =?us-ascii?Q?N28aJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R9Utdc0rPfT0Wmq5NMEzJjgYQ1hkP22apSL7X1jEuBDbEAL1fubFTk5P+QW8vgGtavn0FelUJtX9eor9LhxmS1ouUoAqL4pOO/+SAvNAD3rp/hE0YQ4K4T89/gHNlzGUCNafAc3EObK4YW+Bgh9ckCsz9VdLTMqvjhfmg6St2zT5thC7FWJg9CwCFrDI2euBK08Z61htRl3wGYO53fMKm2ZZ9/1ac+O2VPD2e/5Dk0CAGoj9gbS67/6RoIPipFb1pRSCU0DMo02ga3J76GDUZcQnURaGoKq8UgaPJP+sWCvCBam0Wa6qMH97306msXG5jpbh4eQEr/ZfjQKxZE6Uvo9oNl0GBdJWfXe2FGV2XIGTynmz9f9Y5pOw8trhVr8BS/+sUXiS0FV803IVGYxnIYvz21LwZhDm510vj9tdmMkOe7/O+jfb0eeT4KYo7jzB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 11:47:42.7419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb99599e-e402-41b5-fc26-08de739a8527
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17124-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 872DA1869BB
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

The cited commit miss to add locking in the error path of
mlx5_sriov_enable(). When pci_enable_sriov() fails,
mlx5_device_disable_sriov() is called to clean up. This cleanup function
now expects to be called with the devlink instance lock held.

Add the missing devl_lock(devlink) and devl_unlock(devlink)

Fixes: 84a433a40d0e ("net/mlx5: Lock mlx5 devlink reload callbacks")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
index a2fc937d5461..172862a70c70 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
@@ -193,7 +193,9 @@ static int mlx5_sriov_enable(struct pci_dev *pdev, int num_vfs)
 	err = pci_enable_sriov(pdev, num_vfs);
 	if (err) {
 		mlx5_core_warn(dev, "pci_enable_sriov failed : %d\n", err);
+		devl_lock(devlink);
 		mlx5_device_disable_sriov(dev, num_vfs, true, true);
+		devl_unlock(devlink);
 	}
 	return err;
 }
-- 
2.44.0


