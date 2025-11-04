Return-Path: <linux-rdma+bounces-14225-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A55C2F7BB
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 07:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B2E3B51E6
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 06:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27AF19ABDE;
	Tue,  4 Nov 2025 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j9+btWys"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB119DDD2;
	Tue,  4 Nov 2025 06:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238949; cv=fail; b=Xm/xJRBdQ2qLRrl/nuxDB6/ZdKFeLTzIe+lbWYEXLYdjigRCpUSqz2FeXTj6R7yuPaekUe+AecXIE8pMjEfo3l1jPjcRBc/tt0cUFUn0ka4IfaXs9iPbveDW0S/AcVxDh3dXPN1uDpMkuv4CayaC/qQFido+qPbmC93s7QCPoi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238949; c=relaxed/simple;
	bh=+e84YBP8j/gF5YyrBWU6S0FFzVokGk6IeFVeul1+SrM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bw5rCnMbnXCyh7K7Fo4hRBw6og7/mPYNxHlWsMpdJKpMf9IWZ1O5F4ykAURCbHzkuxp0fMONBOIilt7H2QimpPB313vOMds0LtwoVMU/MbwyF0ZUqGtlm504z0ra9GTLPAe4x4NIzYOLGqRyH3YC8cxY3cTKEZAu56RXAGeYDKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j9+btWys; arc=fail smtp.client-ip=40.93.198.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihcMIxaPULNeTI65xOkrbXd5RTP+c5V6DQPG18EEwoT3VOwmUPZMmBqxz3voOR3MqruUPQ/J7RHu4PJ1NKlpBRXMpN+Sjjcj+YG8KHQLkTVd+CNGanJpQ4SR+sMjMbB0IT6S0MZqS1quMmCp6HINQIOkb/A0RCnjxj7XFxxL83jKlDr00jpYUQw90c30qHKgjtwXXtMZo2dZSmWQutHzh4fqfMB7OyRvKWGDhiBUqyFGPGxDxsBL2pLvidJdULz+S1C8QMUB+gxkshgWr0a+g6QepYayuwi7nI9u4QWAkpgn3h7SZZ/0Ed1KQBNQSTFPoY9bpOnfVEwFfyVJBH1e4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQtrej6a5rYK0WlsG3Sprp5Q4Ff6dnJvGfMp2OMrRK0=;
 b=NKnzfe6DD2oRcHSGszpw8KH6a2Vt6BcxsEsd1c/L8eWcOPhPMFzURTYAvdy62E7xf5VREuRP4n+0XDgxq9fm1AqoYYX20XEllKKMUQXpU+g3nZCetlCPtQ7e6RYTtZdhR1U/gE3iNwGmmN/JRtm6+nRZQnAAnbQSvwMOjC6kW33mi6Tp+KAz/CroaumXGQ+JSOwBFYTCaKmE2YCkSpTHl+wYAqI3Xg9dkkeNrsZ3DwgofZVsDnwfiqGIcfE8fInC1xMVN0Ek4gSCN66381ei29CT9X18dIs1mQj1RP3ANFxz5OHeYtSY+Ld6fEWsRMO9zyUPHjkoGrvSSv+O0GN9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQtrej6a5rYK0WlsG3Sprp5Q4Ff6dnJvGfMp2OMrRK0=;
 b=j9+btWysn5QpAJmX1rA2Vx1+qfUSBOi6lx25goubEDWRqXRfarh/HEAjihj0Vb7ZIBsjMHJs1g4dnydk7W3dxGvMVimnzg0rLfqZg0hHh45Le8OYd6oPGIrgkksieZnFd2dVGO/fUIN6JYLAJ89veWuOgTfxwU6u8tC2AvWf3FyHlbkVhHEFBmmaJlvOnmpL42SUdC0GWUJxYpACK1jQYD2zx7prYH4kxau9KJsCSlaOkL1U92ESMz3hp5MtrNZjuqd4mtd/xzk60Fd/o+tlRzFFIWsZCUFPmWiq2wAo09P9ck3Q1HFvtD+903SVcFN0KB4PihhUZtrVSSahXOE7Vw==
Received: from CH2PR02CA0025.namprd02.prod.outlook.com (2603:10b6:610:4e::35)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 06:49:02 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::47) by CH2PR02CA0025.outlook.office365.com
 (2603:10b6:610:4e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 06:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 06:49:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 22:48:51 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 3 Nov 2025 22:48:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 22:48:47 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net V2 0/3] net/mlx5e: SHAMPO fixes for 64KB page size
Date: Tue, 4 Nov 2025 08:48:32 +0200
Message-ID: <1762238915-1027590-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d00815c-e85b-47b4-9aa6-08de1b6e3d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SHuQPf1Da66PDILKFNletZJ9bXi81wPTNqtHtrPoShy4x0R/EsUgHkMU5dx8?=
 =?us-ascii?Q?qe0MePjsr4+f3IolGSISfpdMc/tBUlClnbBXsZGXR1FA4vwMc4oJm37R/hhr?=
 =?us-ascii?Q?ABOAIR0OA3BVPSASeek4HkIQsk9eo/3kJs6XDQZtBVYaLl/gPrJ+TyP/a6xu?=
 =?us-ascii?Q?n6olTwcMcFZB1OcIeHlaKQpaP84v1+KGstmjQ8OVP2c4NWFhokQUKWuG9XDM?=
 =?us-ascii?Q?kiG3SBMvJVr0tpC6hJ17uG5aKbClaMBYcZSZ1lBzk2TI1hECEJa0rrkHp2uQ?=
 =?us-ascii?Q?nCfrTQoFElPHX6ppok1Et8DBWBbrCs9hMdzilVJc297OAQLKHU0iDU7TjsjV?=
 =?us-ascii?Q?u5kec+t60ijhwBf5nXlv/OCXU9cHHrNa+dL+x4XvZsbqKjxloymAmbDT580F?=
 =?us-ascii?Q?hCxkWbCbvu3DPtTADP4oUyV7wbaUskCaObVVLPwxFEAXKaKvU8wDFzCRlAAp?=
 =?us-ascii?Q?zC5kREGzq1GqpUo7xM/YEvyf/BUzBOL1nLg/eGN5hl1r2rTOY6flzc2+Tf7N?=
 =?us-ascii?Q?gM4pAPWniPmDRn5Ig1Oju+SORQAQKOd9WFDc9FjmOB3h4m90+L5gdC/J5D24?=
 =?us-ascii?Q?I4++Jm69l6q1hdZhPXFtl+WzqP3yT7wvdeWwj0Uv+bUaohr7rdtdKTc9lGb8?=
 =?us-ascii?Q?6InJNgfg9VXNjyhV4Ob4rJ6rCHWF48kF3F+CnifbPhk1rNDqx8HjDIKcNPBy?=
 =?us-ascii?Q?yxuO0rhIPw5S1i2gKLTUGPFqjVhE2Zjtz4/fwsHE5+0WsV9OxoCBtpv+/yXF?=
 =?us-ascii?Q?PftZu/057xi/YmjesIQV3er6gf3/mIO2akcAre4HhG6rdXarP5pfxK6jfutK?=
 =?us-ascii?Q?tVmQg4SBGvKehLVxdKUbRCxZqoSUPptwUDcb26tJpI5WR/ZvauiwZX/relKB?=
 =?us-ascii?Q?vsHsaUj6oHDjW6/3iMlZk8sumOm1kUVtVY5G8o8M5NG9bjTJmTGgwIsK9Ekg?=
 =?us-ascii?Q?tT+7NjWYj8IIPRpBGMkpFKBFlE0mQwJ6kWeYKqELvgtj3lxyN568fPug5ezS?=
 =?us-ascii?Q?Ur2OsxkflDNXToai5togR/m0I4IfrflEkTPnrjv6T+TTr5mCDjs08IpHoCLA?=
 =?us-ascii?Q?2IPZUJquaP96tpr5DBTbuHVoYAs8SJ1fhpG3FBGpVWzTakbmTBinrFu3iGzb?=
 =?us-ascii?Q?eZrgEMtEkxhi+gkTOPnLoGaZ5fQE6D5yGbnJVMKWg7OAm4X+MxjPWnND4T1l?=
 =?us-ascii?Q?3o9vlyPLqQ7B6jZ1wF66d7HDpIhfQCT3AmVYhlOZ8AJBKyOVHdMd7QSKKRy6?=
 =?us-ascii?Q?vjU6tfBHOfbvCgMd+ptPgfKyQGpmwSZQxiq9e/DF9NpotG2AEFbqLj44p0G0?=
 =?us-ascii?Q?5hM1P+PYLyrHiR8Cdqs6LdUgtUiRsBMGMPec/uN8e2V2e83ai38jE1aQQOe5?=
 =?us-ascii?Q?c/T8UfQPhk5kz2OfX1zH78R3qfWQdAo2RROaBR6aI6K51MyEEwr1f7azgUv+?=
 =?us-ascii?Q?izcVBJy5xTlkbyworJGOw6mrIw8Uu5PsmUZI64P/zMdP+pPD2yQd+vcErDge?=
 =?us-ascii?Q?W1YZX7iarsLMiyAPjtIgRzgfGorrrEZGlJlr0FtRv5TNHreWHy7vIL1c+Qoa?=
 =?us-ascii?Q?WV41XWfHkuRCug6Hftw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:49:02.1927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d00815c-e85b-47b4-9aa6-08de1b6e3d61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029


Hi,

This series by Dragos contains fixes for HW-GRO issues found on systems
with 64KB page size.

Regards,
Tariq

V2:
- Patch 1: init i in for loop.
- Patch 1: fix wrong function name in commit message.
- Patch 2: enhanced commit message.

Dragos Tatulea (3):
  net/mlx5e: SHAMPO, Fix header mapping for 64K pages
  net/mlx5e: SHAMPO, Fix skb size check for 64K pages
  net/mlx5e: SHAMPO, Fix header formulas for higher MTUs and 64K pages

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  3 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 24 +++++--
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 72 ++++++++++---------
 3 files changed, 61 insertions(+), 38 deletions(-)


base-commit: e120f46768d98151ece8756ebd688b0e43dc8b29
-- 
2.31.1


