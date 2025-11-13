Return-Path: <linux-rdma+bounces-14457-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7633C56ADC
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 10:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EDE1346425
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559D22DEA97;
	Thu, 13 Nov 2025 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XCzsVqHS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F5F2C17B6;
	Thu, 13 Nov 2025 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027318; cv=fail; b=co6VyeiJOZT7yceICHWX/mvs+TYOrm3fFZeLQInma/K+9SmMyf32/CInO805ZKiGmqwkdQL9WarrA07XHxnV7d77cdwaqcWk2s6lAG2cjHNYRgY5gux4H+17mVbQ0LbI2pw9lZyFB0WrcbkxmGK94WYqCgWIZWDDExSE1NlFLl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027318; c=relaxed/simple;
	bh=ZZfUclOYXlqErBU5bFcVZbGzUBDFto3WoIkExJ29Q5U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XDcuF0gETJBhjGN/3b27RnLj47YKpxCsY1LBMip9mDHhV/SuBJ5vLJ0MlLlJrdrbIbwRawda6m0vfOVFJqcrfA4s7quIEgmq5+mpmykgtEl2Nkl5t1jZ4bjvVFKPswxPhpU96yQPnSAPbTxki1BbxHE4nsNCHloMcUxKoEpjblU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XCzsVqHS; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1K7OTbpG2e8zRHyqg7GMinTc59r4B2KY0SvyJkfulmB+05UACGMh7Gnm91mA6mjFpgtXbxBW1tajPZXzH4rowo/k61XXFwJj4OeujVyv7FrAYXQDvzOUijMXfVLuYW6Rp5lbMzweqdlEo5jL+DHWujWdfFkAE9iZ45My9auJZvpDQiyefO8MH7SeeFU0NG2+EZ2FM1qJh9knBGcanUO3oELnhpmdVyiB8M3Orvrt697KW2nq32UOZOAMG4nR5WLinZKiY4PY8l9aEHZ+XAGy/YJ0MzwyfI9zj+vzRXXi/lBcUfFOdh7xKh+RoqNkmCIZsx3PEC86+KrklR16pq8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoPCaL+TpIFxrizmJ2ziMZyAEcB2VVmpdgOaXAO7V4I=;
 b=SEK00/O5cUTkQoHC2KQlmP5WKm+98J0dTTgBQevmLbnqD1ry32rNarzRkIn40IWWxoJIb9cNHlriEQSxnDtFDSA7k+4FwaW11sYOmoLl8TwvJyEfftW9Hx9h0PNCTZxtG+uZtGTLtQT9Frx9p94VWPRw/Arz+Z97xUxbHCOrytBUhu4nBRgpFwtdbjSkx2O+LNiLlUA/b6S7vdf8HHBJCW3hp1eHIkAlXCzl34yU2lDRa0la4nT4Xgp5StOLKOjXk4OUn0loD4kidNlZ/4J2ayBvQ+Xv8gAOldJzt/cldp82sYkk7xNRmJxjOT9s6jaJ7WRBgNN5YvImnv3VuDoerA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoPCaL+TpIFxrizmJ2ziMZyAEcB2VVmpdgOaXAO7V4I=;
 b=XCzsVqHS2k5fgLGW6Pq6Cx+Jo5ZoCSwmFtJwnXEPpFfZLI5yAm4Q8yVMRBaDi18GJI58fRM9ouF+h3x8vtGgTA+ohjqh9h620+z02zDObWFhynM8J2kOKIHsz6dLhwW9f7AaFk9CTT/6XaGWzmocI1D+8Qlide6Se9vlyqaAl61xxo2zJo8fPfpl7BJWZvTfs5v6OWqsL4go01qurYPkJn9/yr9Ckw777zFprgMtxTEYa7UD4kZR0mQayFBYS3VtwrTFWmIGsIBLB7xD0XlE3qiqd8tSRJWGJDz0SxCt/3OeLz0QstaYVZuqKpG20XSy8HGZRWUpi2VSsSCpJMZXsA==
Received: from BN9PR03CA0228.namprd03.prod.outlook.com (2603:10b6:408:f8::23)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 09:48:29 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::6e) by BN9PR03CA0228.outlook.office365.com
 (2603:10b6:408:f8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 09:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Thu, 13 Nov 2025 09:48:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 01:48:14 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 01:48:14 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 13
 Nov 2025 01:48:10 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [pull-request] mlx5-next updates 2025-11-13
Date: Thu, 13 Nov 2025 11:47:32 +0200
Message-ID: <1763027252-1168760-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f51913-de61-4a4c-0011-08de2299cc72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZK6yMOGZQ04AirLNvXNMH/aDgzLhEzR8rpp6ypNK/QqYeiQvnxQ7gyYg0KGD?=
 =?us-ascii?Q?CUrDGsHznGGdPOY0xZFF8xdIxlgYomi7VjgfkgZenbxZlAhSYRtouBhr6oMJ?=
 =?us-ascii?Q?AIj7oVghGKi7jxMDhqSAyjYh16LRCM53LO1FXOjkv6QDyjQpi2BJNXr7keku?=
 =?us-ascii?Q?yr4noa71P976OK/bXGYUr/A8TMKBJHEVIOWSnfMW2SesUozqI6l8Z7x2W0Xn?=
 =?us-ascii?Q?+fhOBcM34oo9ZXPk7hioOMVA8idCjfl/KDlIsHbKzq6NJBpULnNnmfzdzhw5?=
 =?us-ascii?Q?Ia7aRnuJdXCdD2jmMFn+coo2vVSvmC1kURinY/qI8C5hNgxFMBSVPCrok0sX?=
 =?us-ascii?Q?PmfVYgyLRICth2TTeYVQlnh+f80OOx6BVq2Yp/A3RvWycXy0qIqF21iKsJn5?=
 =?us-ascii?Q?wnQHv8/INlOAevqHfoD2AzHBiyOyV6+j0kQnI3/sXkBPr9MESNkURsz2CLxR?=
 =?us-ascii?Q?WC/J8+Qr45gR/kXbsxSBTqIPb6QsfyH7kfDMWXAYsI9jAy9IEu2Wg7kVHqPa?=
 =?us-ascii?Q?Kwc+VMqym7h2uUXyNt71bdimbRJoJOJZNvdvNDIBGpHv54GSQ/JNaixgA6lx?=
 =?us-ascii?Q?jJ0uj3gFeVFJSGSmj1RmDIMwr+OJpT9xcrIS0z/9OQZKrf7qHJ1inhsW/16X?=
 =?us-ascii?Q?vzPgnweOA3Bgiq8qgf7nzyLxINtC++sgx/eI7ZN2EMuyDm6ppy6Upmj3EWsT?=
 =?us-ascii?Q?rUyO9Cry4fZgyF16At9ZdG7u/YcTfD1EGwTxGFKjtvLXcR91/A5bcHki+c9G?=
 =?us-ascii?Q?7738tRxb+itD8QryIH87CVMlUl7Y9vgdsZChzQsNwjsoojfwD6KIPJiUAMJB?=
 =?us-ascii?Q?O1KCe4boIHZdfzuyAIjQ5Uh+Fl8n06sSmtjr++8A142cpAQNo60dxf6puv6o?=
 =?us-ascii?Q?4di1lmXucebsId2g0m+UouktXWgRert4LdCSjUlKMuVuATNjiMpPDGdIha9V?=
 =?us-ascii?Q?gyrGQYlfOmiUTQiCoRt7ZZTFOSRmycxuyYL3LLaha7oHqJSL1ISdRMUqiQi8?=
 =?us-ascii?Q?P2/UIE3Ua1AtnBQJdoQt14RJEPg9Co4DbAqPIV7+ag1juKU7nOgz6U/u9gGM?=
 =?us-ascii?Q?MNXG61bn6xsGfDNP5rBCgEsF9+rFfvr1mW+/5FNc5508fbQCOIk9Wuku8lqd?=
 =?us-ascii?Q?+cbgBc5GjFsS6O5KATWuhnVVvCDmdMelAzQ4CCkVB4IhT9es/GSwRzkTH8Qh?=
 =?us-ascii?Q?Vqj7MXfssC4hIJs9B75U1FgLvKdsgQ41mNipzafTUslL9wVOdq49Y1ptnxB6?=
 =?us-ascii?Q?XA9DmwKmnzkU7q1bj/p93zRz+tAaweC5DEOPBHM9y6yWw8qULBMhZ6uypOkf?=
 =?us-ascii?Q?Tt+fFL3DXRA0Qa/hfGdB4SEGLtD3RPndySrDenHgapN2dVZ2tLA/sXnvEjcs?=
 =?us-ascii?Q?RnqpZzNIl8npCyp0HnefMgW5l2M2SYlunAT88fT7SGzjGtq2T3uuAGaGHg52?=
 =?us-ascii?Q?F0NmNi1vjiLNJFc3K0RyOtlz1tN8I1SlHWGDULQRMjq19RQpNXt7xPe6whbH?=
 =?us-ascii?Q?ymm17nBJ4FZ5/pzQ23Dcj0eBsXzSXMfgVf2RYJKUzUDSlY7U1S+mZ+MwOu5/?=
 =?us-ascii?Q?EKPZPbnDbJlc8nmjqGc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 09:48:28.6567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f51913-de61-4a4c-0011-08de2299cc72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

Hi,

The following pull-request contains common mlx5 updates
for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------
The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to 5422318e27d7a4662701f518e2e51b9f73a331b1:

  net/mlx5: Expose definition for 1600Gbps link mode (2025-11-12 03:35:14 -0500)

----------------------------------------------------------------
Adithya Jayachandran (1):
      {rdma,net}/mlx5: Query vports mac address from device

Patrisious Haddad (3):
      net/mlx5: Add OTHER_ESWITCH HW capabilities
      net/mlx5: fs, Add other_eswitch support for steering tables
      net/mlx5: fs, set non default device per namespace

Tariq Toukan (1):
      net/mlx5: Expose definition for 1600Gbps link mode

Yishai Hadas (2):
      PCI/TPH: Expose pcie_tph_get_st_table_loc()
      net/mlx5: Add direct ST mode support for RDMA

 drivers/infiniband/hw/mlx5/main.c                  |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  | 20 ++----
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  3 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   | 31 +++++++++
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  | 74 +++++++++++++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  | 19 +-----
 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c   | 29 +++++++--
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    | 24 +++----
 drivers/pci/tph.c                                  | 16 ++++-
 include/linux/mlx5/fs.h                            | 24 +++++++
 include/linux/mlx5/mlx5_ifc.h                      | 47 +++++++++-----
 include/linux/mlx5/port.h                          |  1 +
 include/linux/mlx5/vport.h                         |  3 +-
 include/linux/pci-tph.h                            |  1 +
 14 files changed, 216 insertions(+), 78 deletions(-)

