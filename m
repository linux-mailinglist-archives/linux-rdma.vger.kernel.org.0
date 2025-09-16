Return-Path: <linux-rdma+bounces-13404-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A291BB594D5
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 13:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F37116C0A2
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C732D061E;
	Tue, 16 Sep 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NFEro7Xn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A6E25B695;
	Tue, 16 Sep 2025 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021098; cv=fail; b=QGIIzvniDOK8dEGjOK54MvwlS6toLkVCXg65UMqa6WRhtaD/v/+wAbYmL5A7jAUa866uAOxuZlvfiq3nVJsd6l3sHUzuYI+Kk+nDppl9+GiH+QL6HzWZsb4rSSmRqHXjkKkdJ1Q0/AvnPlT7NkFMMQjhSyIqBEnuNpGkofAKVe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021098; c=relaxed/simple;
	bh=y3K3Z7aQeeBYkG0q2iRFE1FBWWT8oXOHO49nUb6m2jo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRn1Vi5nTARQfKkxmCl7QjLemknJgG5TLTd5L82CKafDPscz1DNWfHbKK8/v6Fi0L03UDnV26iLGP9T0pyrLrsISaO4uERwr88h1OYVZ1B+FdzgH/k5LMX6dhF6c1gdBPgogoFDUAkP+eXRVACbgo8kFdf2cGHlB5v0c4eFx5Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NFEro7Xn; arc=fail smtp.client-ip=52.101.57.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0Jujq2g5TFLcfe7W++RaJOr7TBKfmxf3nbAWnM6DPIlUCm5ozHr4CFOzSjVO0YBBV0zLfWjrVxU71kcWcGI1j5APuVK5NeNTNE1S9oNP4aOLKxGEIpBjvxJfEt3Z2JoUwXzH9SCeCwrqTISjhpBbItC+Wj7icd4YNmYV9gv4CAHBI5riW3DE0thqwozfSaaJdTisin9b0PVq8z2UfJSAzp+lcI5W7ShMbLLfWn7VVhR+8FfT5f3Yd0MPyPudnPB2MkyNaZyZ4kRuGDBKolr0UH4x/3HAAxP+uRLMvA8xCOZzLRNBb505eJ+u4q80uB672WBoDdyBda2wI1INrTzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUCHc/M1RH7BwM32AX0quOzHTI2iIVZ+8IaEE4NohtA=;
 b=d+0rvOTMq8b7nZ9u/m/NaxLUmWxSHyIcCply3w3deRQQKtJRB2WAAIPFjRlNLrvjdWvVdl6Gfizh1gZHmMUch42ed0CZPEGNdAZ4fntQ7OY8v7RT9uisbrhLwsbdcBb84XsorDUrkYYC9nBmvDjRz/tjQ2B2P6kJ4VMjqoKTWz2Sb89rHVoOuF3kzIGzGEwvdu5ilkGpRt3aS51bS3/g8IeQd4S/m823x1u3wFVVisjLRFTmhjbhL9XSKsndEF3XaK80xyBoorcdbp8KX5fkqOBhfwng9UQlno/Gr/p4ZvrNKR+XII1SmjFdQco8epKtl16WAevRA9AZZTv0npX2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUCHc/M1RH7BwM32AX0quOzHTI2iIVZ+8IaEE4NohtA=;
 b=NFEro7XnOJeM62ESYe2U5pGNRKI/MM5sfv4wr2RxKXe+LyuiRIlwUyx5/ojC8pA/zlkRcNUtQwTLGc0u/qrFpgZLG7pmvAIAHym+VcjfJtIfWvhZraENNSw5d/EpZ51XYrrfgSzGXGa+088wNn3/L3RcmNcQMif5GBx5/GXEpHVlu7+ZaHSVMhfMMWDH3d06roR8NtG96YIHVweaJcfNPTMv9/w8euRv9v5JjDiAbn5JaLgc4Nj6bZqVsoVofRzFuBxAu3sQpoA4yXHY1YZIJk4A5tiNOSBKDqClb6eUjus1hgqG1yXfu1HdiID6n18Ybf6+rSspnfJ8pTgYCHXPsw==
Received: from SJ0PR03CA0351.namprd03.prod.outlook.com (2603:10b6:a03:39c::26)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 11:11:31 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::37) by SJ0PR03CA0351.outlook.office365.com
 (2603:10b6:a03:39c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 11:11:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 11:11:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 04:11:21 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 16 Sep 2025 04:11:20 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 16 Sep 2025 04:11:17 -0700
From: Edward Srouji <edwards@nvidia.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parav@nvidia.com>, <cratiu@nvidia.com>, <vdumitrescu@nvidia.com>,
	<edwards@nvidia.com>, <kuba@kernel.org>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <gal@nvidia.com>, <idosch@nvidia.com>
Subject: [PATCH v1 0/4] Fix local destination address resolution with VRF
Date: Tue, 16 Sep 2025 14:10:59 +0300
Message-ID: <20250916111103.84069-1-edwards@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250907160833.56589-1-edwards@nvidia.com>
References: <20250907160833.56589-1-edwards@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e479472-81a4-4efc-c77e-08ddf511c9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oeAPV0JrHmqnwFSBkP9cSlcJQu9wDlXTDov4mdsg/CB7ID5HWLKZKdEzt1y9?=
 =?us-ascii?Q?HS/qIiNKCt1ZJDLJG33zHqcYFp9g4BUdNW3F4u6XmlM18ZJZl0gbdLrhjm8/?=
 =?us-ascii?Q?BwSYgVhczRMr460CLmnHqP5aq6i23ixjwY9rhavm0W5SfuI8Kx+cIx99wxlc?=
 =?us-ascii?Q?ABCg5tM/9sxTpWmm/0Whr5FVSgGSFWal/GB3mYddGJD2bZv2AAgl6oIJd/Os?=
 =?us-ascii?Q?i5KBRKHYwI0pQvTx49BvbGdVzLR2adjblLOiOK26gj49aIJOEhjmfFqN2Dwf?=
 =?us-ascii?Q?rBld6Oh2qnFmzXantvljF3y9nCESC3NyKFDzMvueWp8eEAcumNbmtTW/hx7Q?=
 =?us-ascii?Q?c4CReVZwNPToZDt1+19v+Ve5F+RlwzcfP9UwDIdke+WLWs3zz4FlumgisvR9?=
 =?us-ascii?Q?vEhcjIRhb5jolgM99w255a1LiPn43GmAIlgU94fU4KE5A06Oq7sP+xkqqa2M?=
 =?us-ascii?Q?uwWzHlkM6+CT14Twu466C/DNCvkd8JY19ug/vL/JmA9BUfDTvd+tAX6vgbyE?=
 =?us-ascii?Q?/PkCgW4TLwa0TeQ8u3Xy2NrqAycZzuHkHmKWEuJ5ga7O8Bs9zYOqCU4nc3MZ?=
 =?us-ascii?Q?Gf2hy+3zCN1Pgtj2C6c59FdrYRiLkvcRHFa3csCdGcpXuLHwefe3xL52CzqR?=
 =?us-ascii?Q?cULZXTglYJxLE+F+7H/JlclIXJf0vCwAmycWFoIZ3MayLrGM+I0ko5MS+1eB?=
 =?us-ascii?Q?6NltUTp2SxVcKWlQ6f/XzU/HavWh/N+gmeONknK6+Kuoma3zOrcnX4LSo1pE?=
 =?us-ascii?Q?1P6acni3kJVSsflMJPFvZ0QeLjU9Ru1YWDzNonpiace8THRW4COe6MzQ73HA?=
 =?us-ascii?Q?69QX6UNyiFBYyirgpOAogBmM3ZDSUntKAM/HSojFpykPvrH7jHeNJN8YKAv8?=
 =?us-ascii?Q?mdZTnPBn++c091upJcQ9VLhUgOlcC04GK2IyN7T/7vfsaNQ56l3TIFLMXveN?=
 =?us-ascii?Q?pW/mLg7CZjfbku2ZYGfiMuAdTn+wOSntJ7HNaO1JEAQ89MtjsCQV69MBCLre?=
 =?us-ascii?Q?6tOGQ6l1dD7LjaazltbbCHs69WneZqNNsYl4tWoLVxv8+l0PBdWiWDOK+tR4?=
 =?us-ascii?Q?mM0Ju1FcWqD96tm8zMwFBpU/seXLj8T6Vq4wAx29rCQcaq1WJ8BQqyPwMLAc?=
 =?us-ascii?Q?VEZmoHNGry7eypokfmT5fW/QGa0jVEYHZXVq9BvDTYTS+JIvw/cUDsQ+I1wo?=
 =?us-ascii?Q?GNGS/sOu69h8xEgYvRKWoEP14ttr5R/c60FKeWAsWdYkyTN0nrGNWJlpxdzs?=
 =?us-ascii?Q?SN88yd3M1HbCELuGOmk6YXQlGEneETOnaBENfNMnh3Gjm0hDq2mMk3KsPlQq?=
 =?us-ascii?Q?wHmilGZPXKKLKjONldbFK4gcPjyUn2luNCYLxALJPrNbgAO5Z8TnCfO7F9Iv?=
 =?us-ascii?Q?+QV8iSDB0MX2CgvkqE4RjilLuw5m04FdRaK1GVwT7dhvIVc3TeusYdYzNqua?=
 =?us-ascii?Q?q8IPzuifbgyy6bVXQ772k//9Bcx5eCzfgCN+1q1BasgPNqowG6Eek1+5NEI+?=
 =?us-ascii?Q?QjHWHchOTWnuOb7d+iK3SD4CnbsioPJrBy26piOTMdnOVCQxLh3tCrstLg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 11:11:30.4261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e479472-81a4-4efc-c77e-08ddf511c9c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555

From Parav:

Presently, address resolve routines consider a destination to be local
if the next-hop device of the resolved route for the destination is the 
loopback netdevice. While this works for simple configurations, it fails
when the source and destination IP addresses belong to an enslaved
netdevice of a VRF.
In that case the next-hop device is the VRF itself, so packets are 
generated with an incorrect destination MAC on the VRF netdevice and 
ib_write_bw times out.

This patch series fixes that by determining whether a destination is
local based on the resolved route's type rather than on the next-hop
netdevice's loopback flag.
That approach resolves loopback traffic consistently both with and 
without VRF configurations.

This series contains 4 patches:
  1/4: refactor address resolution code for reuse by subsequent patches
  2/4: resolve destination MAC via IP stack
  3/4: use route table entry instead of netdev loopback flag
  4/4: fix netdev lookup for IPoIB interfaces

Parav.

---

Changelog:
v0 -> v1:
- Addressed comments from Leon
- Updated commit message to reflect that dev_addr fields are invalid in
  case of failure in PATCH 1/4
- Removed incorrect commit log about 'no functional change' in PATCH 1/4

v0: https://lore-kernel.gnuweeb.org/lkml/20250907160833.56589-5-edwards@nvidia.com/T/

---

Parav Pandit (3):
  RDMA/core: Squash a single user static function
  RDMA/core: Resolve MAC of next-hop device without ARP support
  RDMA/core: Use route entry flag to decide on loopback traffic

Vlad Dumitrescu (1):
  IB/ipoib: Ignore L3 master device

 drivers/infiniband/core/addr.c            | 83 +++++++++++------------
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 21 +++---
 2 files changed, 50 insertions(+), 54 deletions(-)

-- 
2.21.3


