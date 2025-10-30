Return-Path: <linux-rdma+bounces-14143-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF8EC203F1
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 14:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA6414E9A3C
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 13:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D856B23E320;
	Thu, 30 Oct 2025 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fo8ATFVz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170AC2557A;
	Thu, 30 Oct 2025 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831213; cv=fail; b=Uh7BjWbEa/ctDWtuwaW0QqTtyYGK4ceVkbfNFihC3Ap0ab7IXpSK/bR3W0LoFBUq2i/J9aBH2xi3iAykNVBTeD0ZtASxhGaczn0PFXO98Z0gAeTQ11DBQKfOiQsXPRIu3CGwOL3mN7FX4WjNmyj+sy45ftA7ox7n8tE7gjOSvUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831213; c=relaxed/simple;
	bh=GuWdAZZX157jv6ORFuG5muW7DVdIA1IP2LAExljAekM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sNE+jX7UIztal+NjnjFTB+T7fSqhN3wd8B8DkifjZ/Kypq11wzJDuH7jkea5Bk5tZNvQalHaN1v6wEnED5g2iXwe68p+Xd86rkOEumHQukVPVm3nMot+VVb1sh/cAQm3Y/mLXNddGKY7dIJXQGXQgl8n12rSDYwKeLg1a9TZhus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fo8ATFVz; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kR7uN1aboY80HOhD1ecrZG+je8muYyoW2k6liUuKV8MFZ/Qt0XYYU8mdLlNfFUkqtd8lLY7K9GTUOhQjon1WuOC71JlzI3ulYG1aAN/t9HeQOVv2TfDvtcdj2hGsUC23gp3zt/fBL54ng0/7znY5j+DIozJlWAkt0DPcFLmKW3iPJpam1URxPW2pcbd7P1d/8yQ8YY5Px2NFpvO2+Nf0Lktlz6N924JP45GJNTb2OA1glcj9pN9cHKIJ1XmRp17Vi+KezWwXtJ9HPgLabwuseS6201oVbaMWJhyA9dmooQAGh+rcaJCx4FcBnNBpScr6KciUBEkryWz9YRe+OVVt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pjsZ1rnyYhIe/JjBVCu6prpLbNQd13Hb+L0ahn5/vk=;
 b=y+cEbWxC3LQsDBfSTiWOa8JWXjufExBJr5UVrbwGWoKbH5IlI6/T1zBTp/FzwKcE0afAupvcZiB43paqM292F4sV9EeZfQJLpiK1oV3cK4DDHjH4BmqAq+BlUqZsUFtb28qfmttkgWZ/0U4up2dgtWpOZgifJwHkVXDNsFs44+9clt+H6ol0jiKWnXuLEMs06Rulc6UIri+QMTFF8KKFUpjwhXA9bjOjQedEn94Et94/74EBcjyMyC940Rtd4Te85ah7I/nru6kk4PpIxf9EQMBK7miW79545rJrKjeUEG3Y0sJrWq9WGBtF+lC4DGBdfnWa2JB4Bof7zZEwpe3/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pjsZ1rnyYhIe/JjBVCu6prpLbNQd13Hb+L0ahn5/vk=;
 b=fo8ATFVzYBnTzYyGaewZeUwyzO+Cvzjilp7HRx1u5eGT8jtb5Og4RvwOFV/IZgxwZqAGYwZ4YupMqS6jjBW5B1hxtlzbE5xz2VpBwL0i+VnTxDxkujfmRkHqTF73kiGGF2ueySDElTe4c8fVnhkxrR1P4YZGKcY8VVTMWEIxC2OxzM/ZxyARb7+D98JFXl1SZErnYW9sVmCEZwsPOzDqKHPHC7nG5F7QUiT+K3P5uqTQpsoQj1c/Sf8FPLShKFDN+nu4I+079aeDNnFeLP5K5ESn5PXuMbtKNazKmtTxpsh/lsUurdtzt/XnNXewayjJyHVZmBddD2EkZltSECh37w==
Received: from CH0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:610:11a::32)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 13:33:27 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:11a:cafe::44) by CH0PR03CA0346.outlook.office365.com
 (2603:10b6:610:11a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Thu,
 30 Oct 2025 13:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Thu, 30 Oct 2025 13:33:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 06:33:07 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 06:33:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Oct 2025 06:32:58 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 0/7] net/mlx5e: Reduce interface downtime on configuration change
Date: Thu, 30 Oct 2025 15:32:32 +0200
Message-ID: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 1612fcd0-8110-4da1-7fee-08de17b8e898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ffcmXcpIU4ZmPL7OEWzu54vzNtUoCgUrFvgm5ZwTo2be8JKk5hThuzHhl6Hh?=
 =?us-ascii?Q?VA1Gmaw0IY7xqCav2qjMN5JuivhjNQUeZp0uDdgmEgQ+E4EQ4jcKgR6h7Kwc?=
 =?us-ascii?Q?Y+RgWwbS6VxhX8tn4Z/Zfl23PJA00Eqk6owIBu33T/0ib4SYbWPOwESrdJW/?=
 =?us-ascii?Q?C3GqPIhX/jdWfStXxP9F8Eo8JL6uo5a8Rq+QgaqE2sO9lt203Jla3iNbz5BW?=
 =?us-ascii?Q?3x7sjg8eVkYb+crEdyOjZ212xLrl0c34IOc1gLLiL1kWLrcznxg1W74gy/E9?=
 =?us-ascii?Q?3NCsUTAbwBWiPTUL1rItSVWOfXMdgI7V3XxVzJ1YAPtTLz7AS5u5R9u8K1uc?=
 =?us-ascii?Q?LpYO4zMT0OipmMk4uVKVaqhyYQRg02hb1BKOXVvuG7eQgWsFRC4TctAXqmYd?=
 =?us-ascii?Q?+BruIHPmkDuSTNeUqP9qVK2+OG7hCbiJ6AaUvipvv3kMWqv6APej9PPcUnF4?=
 =?us-ascii?Q?JjMXuC/3yIsQWRptFbamWp8hJEH/R35NZP3skfaITEU0NSFXcvCph5Pu6Dye?=
 =?us-ascii?Q?Jw6dhpxty9VgHZyAvkOucMPGhavsAlRFmRDQOPbpfR9lvzyVZ4OtbvMg8YwC?=
 =?us-ascii?Q?pPyYahoFuF7+tdavuxDlpj7/hv9oAuQCGpBeMAKKBnb41wcM05Npixs/xypq?=
 =?us-ascii?Q?2PAcvKB2FOMAXlpMLM3uuVfKyE0svOBJji2yCK3+XjDD3pSPreTQUslbV21E?=
 =?us-ascii?Q?IZPI/kdJZ1TGSqOOQ4YVRDXJxo6y7FSW9qmP1yeGg1hyy5hNX15mKz8aSuqg?=
 =?us-ascii?Q?U1yrmcLHk+ki0avdKcicuYrCr9HDZVT5WM3rtYJmHzbKTDbbB3Hg+MBMRFLe?=
 =?us-ascii?Q?piIC8stXGBb4Q26FEurF9p1Q4EMWBqT5pETIiAzXPEcA1ntwpj6bJYx6uV5X?=
 =?us-ascii?Q?Vk7WBKJWdfQYOAYgLfbqlMinds6EcjFjbZW2YPzs4GfpcMBlocZNaKrqI2F3?=
 =?us-ascii?Q?VvrwCIRQi1lpelKrNuWHrOFjBtEN5eCt5YKbMIv3xHmR+LWcH8zRw3z5hRDp?=
 =?us-ascii?Q?zWWkvSorVfJtURK/GEq5s3ZZhvM8zSPbcX//gzq1MKUDD1vEAlJM/uLk0i4i?=
 =?us-ascii?Q?sAiH/LLEqUpWBntzpwzJe3F0nT1f5BKYLYyfhRaLx4fBlJC43AfSBknn92g9?=
 =?us-ascii?Q?VGz0u/F6xF8acgpMEl+a5LK7Tjs9gDEBHpY1j1isHhBPOSgEl3Bbh59HjVNY?=
 =?us-ascii?Q?mB6Sv2uHfFCmggzuvS5QhwwGVrzExGdZcRKbAPWoMtsAdV3tLePpYFJ66D0l?=
 =?us-ascii?Q?Jz0BAM3MNlwJcVTetM735SzPEOo00DOxC+GPMB7EddyVKxLWVostC9joejH1?=
 =?us-ascii?Q?6lMEf1en6lEIYA7fonRaGeVV6QxGOMRnad32lw5+nVLW/tZbvsYBRB+ISTxi?=
 =?us-ascii?Q?4MzKpdgAe/9Mlm3fE3mpoeielL6pkgA0Pq7THmxwqD4DCluaBCi4T6u7+ux4?=
 =?us-ascii?Q?NY5jMPS0vziC2K7w3+OU5Byr7dJ+biyL1Ob5EsGt0xiVkN4DjlhbVocEpX26?=
 =?us-ascii?Q?KhGS5ZYcd30WzWQgSSBIUgHTSOnFVxEugb8zZ8VGs9leF1M4IA5gvVxzk46u?=
 =?us-ascii?Q?2zYGQ/ItYPXTQCYp2Cc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:33:27.5405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1612fcd0-8110-4da1-7fee-08de17b8e898
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424

Hi,

This series significantly reduces the interface downtime while swapping
channels during a configuration change, on capable devices.

Here we remove an old requirement on operations ordering that became
obsolete on recent capable devices. This helps cutting the downtime by a
factor of magnitude, ~80% in our example.

Perf numbers:
Measured the number of dropped packets in a simple ping flood test,
during a configuration change operation, that switches the number of
channels from 247 to 248.

Before: 71 packets lost
After:  15 packets lost, ~80% saving.

Regards,
Tariq

V2:
- Fix coccinelle false-positive in patch 2.


Tariq Toukan (7):
  net/mlx5e: Enhance function structures for self loopback prevention
    application
  net/mlx5e: Use TIR API in mlx5e_modify_tirs_lb()
  net/mlx5e: Allow setting self loopback prevention bits on TIR init
  net/mlx5: IPoIB, set self loopback prevention in TIR init
  net/mlx5e: Do not re-apply TIR loopback configuration if not necessary
  net/mlx5e: Pass old channels as argument to mlx5e_switch_priv_channels
  net/mlx5e: Defer channels closure to reduce interface down time

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 +-
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  |  2 +
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |  1 +
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |  7 +++
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/tir.c  | 29 +++++++++--
 .../net/ethernet/mellanox/mlx5/core/en/tir.h  |  3 ++
 .../ethernet/mellanox/mlx5/core/en_common.c   | 52 +++++++++----------
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 31 +++++++----
 .../ethernet/mellanox/mlx5/core/en_selftest.c |  4 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c |  7 ++-
 11 files changed, 97 insertions(+), 44 deletions(-)


base-commit: 1bae0fd90077875b6c9c853245189032cbf019f7
-- 
2.31.1


