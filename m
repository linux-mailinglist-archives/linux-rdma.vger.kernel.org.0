Return-Path: <linux-rdma+bounces-13267-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D682AB52924
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 08:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C797BC29B
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 06:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49337258EE8;
	Thu, 11 Sep 2025 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B3s4dszW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA4E238C04;
	Thu, 11 Sep 2025 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572914; cv=fail; b=iY8FtN1ZFbnBbZUtTcf8zg3HpkUkpjzQRnpAn20EkZbguMfeXUvDhKMC+mulU9NsgFC98NcEbXiyyOuCgbFUQ/PUTPvmIB1fwUjGiyxlM5ZZGgWzKaMESAr19nxuHYrx8RfV6l95n4/+9HE+qru35zPdVLsc7kjm5ufkYZNJWgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572914; c=relaxed/simple;
	bh=8zE80gE2QDXPV+RFLZZ2f5hmnGO4ah2O+xRh+4W84BM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MCFAR7ePH6vB5XY9bWnqFWjUShJzhz9SXWLwcxHBDNdeUiCgU7W1c5/eGwVzoAVRReIJFoteQmOhUPGybHEEWjA/YkKR1uKMyy661j9tF5epJjn9Ch6i2nfrr2diCCV2NtPIT+XhHk79uzviCwcDF3tS4klDiFeP9u5LNqW4Uog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B3s4dszW; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+RuDSkCpDkqZI5HUe9i/5a5jeulpd5FaPRcTPyAKDe34bpvy6FSA4Unr061oPXUrznoRfJq7nxV+Nxu42+14a583Df3yGnZaop//B69/WCSAQd04lGmQx3fr7TzEZD3Du08Nw7xcC0DyvKn92MxMNFDKXYD2Knt9xTQAuBWxUCXFE3xQ4oPFCEITcXftwkccNR7YszKDECv7xaWDjCGunvJhhw1y/1ibQQFT8V9zYB9WK8Ds7gx1vaTgOVivZWDPWBRWZIJF2m5r/xe4JXaSsl1TYAiP0DnZZO1Nbd+08SvgS76DNKrCmrAhQpa8/OaG906jf3pN3HscfgV9MhNjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/Shp80bejjYz9e58eCG5iIa6fRHFwnSVkx8erAortM=;
 b=OUjRfABDpmM4CnnlVXIgSd34WOiMy/wzbTDsxJ+mlyB/DOlSRQsa/QQLjTjpN89vhJXdYar04+iuyuj+T9E/4I2q1dDXadhjxOh9RLn+M2qrNTKUTpyxOS84KbwOls7ZagGIkc6fa1GggS2C9dMWr7N8js5qIx/X4PZ/zsp8gaIzHkUgPflBCewpulIZ9mf2KughbGf2IKSfpB5U0blJ3J//vP+tk0pzBOc594d4BovjcrUvc1qPU4fVvdtqjs6OlDRPErdqNRgmaI4hhzYKUIlwh3AmGoLyko+5yaD7ZnDju86kRPHj7ptieStMVwaUoiSbqfYDK/4zTYKbHdi7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/Shp80bejjYz9e58eCG5iIa6fRHFwnSVkx8erAortM=;
 b=B3s4dszWlzFc1ZJjtW1vCv3NLR6vD8sdOeU2F4c9mbjr8ZqmG67XUv3pdEUgok2tIntNqtIG3NLny6y37DrEPrYomu7G+z0+I4D9/bN0PXoNT1WhSXNTYA/mf41rk5fUELiLbf6ZbBUDiPLMHTEAW/55DmqO/rco4w2Cc9hCYUEbeaGVghcvyMPM0T4qi0oPI0bVtbWNjRVMd92jihJp5bLLLcbDl7qLL+Jg9NcKc9wJPLn+mo/dQfzDn/xLqu3mtV01OqAeNMvlwuiNi8o4FHQ9eYiBtDtYa9HC1eKxFAvK1vxFP3ifcHAnyQMlAAAxGK7/rcY7zY8YXy17qjMhCA==
Received: from MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::23)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:41:46 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::31) by MW4P223CA0018.outlook.office365.com
 (2603:10b6:303:80::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 06:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 06:41:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 23:41:30 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 23:41:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 23:41:24 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>
Subject: [PATCH net-next] net/mlx5: Improve write-combining test reliability for ARM64 Grace CPUs
Date: Thu, 11 Sep 2025 09:41:13 +0300
Message-ID: <1757572873-602396-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: bde19f74-97dd-4e0d-e619-08ddf0fe4760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uFp7kOVUDdzgaivrBVFjvXUDyeuDPKi3vvgZot7KI7JqL6BeyDPDx0c14eTv?=
 =?us-ascii?Q?BpDNJRHAO4SC3VzYkytWCUkqgBJB0Qjfq/dFGikqkeXc1IAkLkSZ2ZoZCmud?=
 =?us-ascii?Q?+MOAQDE01n+xpbz41vuzARZo6FW/tt9MGvMcptt2mMo4xQsc4dbSMaYLE+Pd?=
 =?us-ascii?Q?Mp9WuKSPq4Etvj+OqJXRqKG3M5A3nyysdh7BGGa8mRU+2O6Nt4axqUkTeVJN?=
 =?us-ascii?Q?ouD9DZO5eK3FipapsrB3jRBOpfYw0LOi1d7x4DpG08VAKD3H/5JPxww6QR9q?=
 =?us-ascii?Q?TSU3svPH6ufDv13mzDi7L9EDfgkSYtpgQ45kBrGgz9+MTLmDEl7lym5rv5yF?=
 =?us-ascii?Q?Y2olKCsXr5t4Sn4L6lb+Y2bMoSXdccGEF7qB6g1czEY9rxWVG6AsZ7iS+uNX?=
 =?us-ascii?Q?r36p9dSMoLhosWwYirwqh0bKgw4bZj8snZW7r2pEyYD0aA0WC0LSKJ9fpbCV?=
 =?us-ascii?Q?G2bnDhDqEHT/WY7aIlV2S4947xrbAFb/CRVxYVy7wW/HqynjTNaFMC5PffAh?=
 =?us-ascii?Q?bPnvJUwzKbvxNWYIAPeSYc/wXdffmooMCdafFpi/2XGMofrNmErYFZ65Znhv?=
 =?us-ascii?Q?MjbgDRVmtNFKMfUalZYRAaY7nLo7QEJsHnBOv6p88nIJdVfYrtz9Oud/YOub?=
 =?us-ascii?Q?PhRFRT5BQ613YbuUBED0+KihUT2/pMzU8yeKN9HwU5qhj6IyaKDr1madk/3H?=
 =?us-ascii?Q?APrX/sPr4fb+8e3XYVrhIZCrgF213GodL+HDqFkKImFIIzW436OrlTxm/Fri?=
 =?us-ascii?Q?KIUBzOqreYw9933rU3ci/GoQcsVoCoCplnILZYKUh3JgNIFJzd45ahPC77P1?=
 =?us-ascii?Q?5IZ3jAcnCuTEv2xt/UDSzaRlYZNaSU1GG8RayBegKHf1Yo1IVzPyKP5PXm16?=
 =?us-ascii?Q?dQr6eS8JDwk6cz2LjEYtDjudUYcR2lHLG0/4QGSiIWrx2ptE4GyyhCE5uBnh?=
 =?us-ascii?Q?fDlsJYARzc7Dn+up6TTVuA80A29QrjlbxsKo2/n4iJL3ZIgNOrPJTlZhOUNY?=
 =?us-ascii?Q?lTJw+gVs2ccEOylWFeTlWQYsjoB/Jx10j1vRUkmD3cea9wZTTy3sEZrifgmt?=
 =?us-ascii?Q?0uFiLHngjgHqo1HJnbi5BX3k5UCoHUBNWikvHWeflhEFaTcp/A1IeV9O0TLz?=
 =?us-ascii?Q?3gSIuozPyMyME/MDckRZDWP2X6xHTQ+0biME7+KtBpygVYSJod2ki5z/KHZE?=
 =?us-ascii?Q?l6d+7jV5Yp9oj47y9wM1KU92V5sGBesr/oc20jmpQ16NMKRuIxJB4kNkmBuV?=
 =?us-ascii?Q?fchwR7gcYNW4jVEvOxlL/Q6BJjuHqeqP3ee5mWPoTU3Afa/SLVrmKcah7r3t?=
 =?us-ascii?Q?i18rrMUU13F7JIhuxXBBYpXGNQwB6mbb5p/rotoIlk3J9Tn1huwWQeYNNmF0?=
 =?us-ascii?Q?Fjmde/rB6xEFHsDcud+N3QY71Mi9xbRlCP6HJna235NWi2lVdroxwh39LUUP?=
 =?us-ascii?Q?pgGdewSOJInNsUl5ebUW4bRuN399RGT/h1/4yN38ae5xL3sTbLFmZWUoe57N?=
 =?us-ascii?Q?Zqsvsh/XZ89lFcj5GQl21hoDV6Cm2l9ximtKcyMAuPdYes+EGT6wAXzItw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 06:41:46.5389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bde19f74-97dd-4e0d-e619-08ddf0fe4760
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425

From: Patrisious Haddad <phaddad@nvidia.com>

Write combining is an optimization feature in CPUs that is frequently
used by modern devices to generate 32 or 64 byte TLPs at the PCIe level.
These large TLPs allow certain optimizations in the driver to HW
communication that improve performance. As WC is unpredictable and
optional the HW designs all tolerate cases where combining doesn't
happen and simply experience a performance degradation.

Unfortunately many virtualization environments on all architectures have
done things that completely disable WC inside the VM with no generic way
to detect this. For example WC was fully blocked in ARM64 KVM until
commit 8c47ce3e1d2c ("KVM: arm64: Set io memory s2 pte as normalnc for
vfio pci device").

Trying to use WC when it is known not to work has a measurable
performance cost (~5%). Long ago mlx5 developed an boot time algorithm
to test if WC is available or not by using unique mlx5 HW features to
measure how many large TLPs the device is receiving. The SW generates a
large number of combining opportunities and if any succeed then WC is
declared working.

In mlx5 the WC optimization feature is never used by the kernel except
for the boot time test. The WC is only used by userspace in rdma-core.

Sadly modern ARM CPUs, especially NVIDIA Grace, have a combining
implementation that is very unreliable compared to pretty much
everything prior. This is being fixed architecturally in new CPUs with a
new ST64B instruction, but current shipping devices suffer this problem.

Unreliable means the SW can present thousands of combining opportunities
and the HW will not combine for any of them, which creates a performance
degradation, and critically fails the mlx5 boot test. However, the CPU
is very sensitive to the instruction sequence used, with the better
options being sufficiently good that the performance loss from the
unreliable CPU is not measurable.

Broadly there are several options, from worst to best:
1) A C loop doing a u64 memcpy.
   This was used prior to commit ef302283ddfc
   ("IB/mlx5: Use __iowrite64_copy() for write combining stores")
   and failed almost all the time on Grace CPUs.

2) ARM64 assembly with consecutive 8 byte stores. This was implemented
   as an arch-generic __iowriteXX_copy() family of functions suitable
   for performance use in drivers for WC. commit ead79118dae6
   ("arm64/io: Provide a WC friendly __iowriteXX_copy()") provided the
   ARM implementation.

3) ARM64 assembly with consecutive 16 byte stores. This was rejected
   from kernel use over fears of virtualization failures. Common ARM
   VMMs will crash if STP is used against emulated memory.

4) A single NEON store instruction. Userspace has used this option for a
   very long time, it performs well.

5) For future silicon the new ST64B instruction is guaranteed to
   generate a 64 byte TLP 100% of the time

The past upgrade from #1 to #2 was thought to be sufficient to solve
this problem. However, more testing on more systems shows that #3 is
still problematic at a low frequency and the kernel test fails.

Thus, make the mlx5 use the same instructions as userspace during the
boot time WC self test. This way the WC test matches the userspace and
will properly detect the ability of HW to support the WC workload that
userspace will generate. While #4 still has imperfect combining
performance, it is substantially better than #2, and does actually give
a performance win to applications. Self-test failures with #2 are like
3/10 boots, on some systems, #4 has never seen a boot failure.

There is no real general use case for a NEON based WC flow in the
kernel. This is not suitable for any performance path work as getting
into/out of a NEON context is fairly expensive compared to the gain of
WC. Future CPUs are going to fix this issue by using an new ARM
instruction and __iowriteXX_copy() will be updated to use that
automatically, probably using the ALTERNATES mechanism.

Since this problem is constrained to mlx5's unique situation of needing
a non-performance code path to duplicate what mlx5 userspace is doing as
a matter of self-testing, implement it as a one line inline assembly in
the driver directly.

Lastly, this was concluded from the discussion with ARM maintainers
which confirms that this is the best approach for the solution:
https://lore.kernel.org/r/aHqN_hpJl84T1Usi@arm.com

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  6 +++++
 .../mlx5/core/lib/wc_neon_iowrite64_copy.c    | 14 +++++++++++
 .../mlx5/core/lib/wc_neon_iowrite64_copy.h    | 12 ++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/wc.c  | 24 +++++++++++++++++--
 4 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index d77696f46eb5..06d0eb190816 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -176,3 +176,9 @@ mlx5_core-$(CONFIG_PCIE_TPH) += lib/st.o
 
 obj-$(CONFIG_MLX5_DPLL) += mlx5_dpll.o
 mlx5_dpll-y :=	dpll.o
+
+#
+# NEON WC specific for mlx5
+#
+mlx5_core-$(CONFIG_KERNEL_MODE_NEON) += lib/wc_neon_iowrite64_copy.o
+FLAGS_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_FPU)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c
new file mode 100644
index 000000000000..8c07d2040607
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include "lib/wc_neon_iowrite64_copy.h"
+
+void mlx5_wc_neon_iowrite64_copy(void __iomem *to, const void *from)
+{
+	asm volatile
+	("ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
+	"st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%1]"
+	:
+	: "r"(from), "r"(to)
+	: "memory", "v0", "v1", "v2", "v3");
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.h
new file mode 100644
index 000000000000..ff2a2e263190
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_LIB_WC_NEON_H__
+#define __MLX5_LIB_WC_NEON_H__
+
+/* Executes a 64 byte copy between the two provided pointers via ARM neon
+ * instruction.
+ */
+void mlx5_wc_neon_iowrite64_copy(void __iomem *to, const void *from);
+
+#endif /* __MLX5_LIB_WC_NEON_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 2f0316616fa4..44c2ac953ea2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -7,6 +7,11 @@
 #include "mlx5_core.h"
 #include "wq.h"
 
+#ifdef CONFIG_KERNEL_MODE_NEON
+#include "lib/wc_neon_iowrite64_copy.h"
+#include <asm/neon.h>
+#endif
+
 #define TEST_WC_NUM_WQES 255
 #define TEST_WC_LOG_CQ_SZ (order_base_2(TEST_WC_NUM_WQES))
 #define TEST_WC_SQ_LOG_WQ_SZ TEST_WC_LOG_CQ_SZ
@@ -249,6 +254,22 @@ static int mlx5_wc_create_sq(struct mlx5_core_dev *mdev, struct mlx5_wc_sq *sq)
 	return err;
 }
 
+static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
+				size_t mmio_wqe_size)
+{
+#ifdef CONFIG_KERNEL_MODE_NEON
+	if (cpu_has_neon()) {
+		kernel_neon_begin();
+		mlx5_wc_neon_iowrite64_copy(sq->bfreg.map + sq->bfreg.offset,
+					    mmio_wqe);
+		kernel_neon_end();
+		return;
+	}
+#endif
+	__iowrite64_copy(sq->bfreg.map + sq->bfreg.offset, mmio_wqe,
+			 mmio_wqe_size / 8);
+}
+
 static void mlx5_wc_destroy_sq(struct mlx5_wc_sq *sq)
 {
 	mlx5_core_destroy_sq(sq->cq.mdev, sq->sqn);
@@ -288,8 +309,7 @@ static void mlx5_wc_post_nop(struct mlx5_wc_sq *sq, bool signaled)
 	 */
 	wmb();
 
-	__iowrite64_copy(sq->bfreg.map + sq->bfreg.offset, mmio_wqe,
-			 sizeof(mmio_wqe) / 8);
+	mlx5_iowrite64_copy(sq, mmio_wqe, sizeof(mmio_wqe));
 
 	sq->bfreg.offset ^= buf_size;
 }

base-commit: 1f24a240974589ce42f70502ccb3ff3f5189d69a
-- 
2.31.1


