Return-Path: <linux-rdma+bounces-13478-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD3B84331
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 12:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2771742AA
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1922F7456;
	Thu, 18 Sep 2025 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JbzNDnX4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0A2F25FD;
	Thu, 18 Sep 2025 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192273; cv=fail; b=IVvNuPaSipIzIE26o2ow+pbfJK8PmbatKeEGyc4Hn8n8o55coYPRnkzVykU5tSRY4wfunA0DHQgIM8N1FzE/IJTtgvVFLGry6ptEZT/+zwdYarD0sLL9umx8VOmxtXAmGjbtYx/aRDD21Ba9tfbXURV3+6rLE9CCyn+7iosdQF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192273; c=relaxed/simple;
	bh=+h04XTHOgp4c782PI2SCnSRuIjTyt8jMc4HuRpn+eAI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FgiNi795cQXhS3PSBLx6ABG1ruJ3G3kHVCUVt+OhksUZZSQ1/cbDFIxL5d2GdJ8C/YuiIFimobfmMh/yW+sDDC0tdS9ecQJkif2gCbEv1dTeRFPAn7S2j277hQzV4CFx3yXnTleF8OanDg73tmK87JWK/BBqTepz1vvoO+cCPzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JbzNDnX4; arc=fail smtp.client-ip=52.101.52.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G83ibNXW6kAOR18Hr6afGlZWCZvck5JNLWJYjgOi5jTLs930lTrM1AOPrtp5hS7W8kOMJdQPuo5StOat8KIGQd2F4mM3mQQJFlI9Wt/ej7VzgEFYc4woStfWskrtztLYsvdsqAtqYGTMw8IxD8b9nNKSdyN+/+edNfb17X2o0M918jY14kjsQKWD1O2VYY6BT4A9RIV/pueVFVTzpZMYxATYUKX8wm2MVuh/RF5cx4f9nCbcrVyPNgjd7xYGj0X4K6/du0rZN8vRPK39N+XZz55mi/n15U1sQ31+F5F9x1C+TX4KelzsE0XqdDLA9zJJFy2/ZDTnbUZN9LMENHvrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ula2+7ScwHWkFIYp/g8zFTK6+r7YyejOggXDu2/CeKs=;
 b=ywHlywmUeFmEmh50u7/gUh9ywzSLAOn3KURMzuBN216ZSHvneDZglpjzSC6FoV173kvWLQqt595Ha7L/Cx8n/ajggpi4Pb35AZxJy+O/YF9rakTsRZu/1NV3reRSq4MQwoD8EJ/K+4Erho/GO8n+zGeyQj68W8F8aGyi/CtDZ1qKDDzGCPTD0wMuabr3m/KCOeyACHMM/4mOTJCqPWxbk1V+WlOywR3oh/UV3qGWL6S4rNfwC5SlJsjNxuoGwFWOqda9EPEexIsTTX82yGQdw1SZyQ+J6/05tG6bE5w/cd46ivtJkQx18612P+9NxzrqXDcUJT+yhy3hH+DEmjinQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ula2+7ScwHWkFIYp/g8zFTK6+r7YyejOggXDu2/CeKs=;
 b=JbzNDnX4qninSekfhPEDCstrKvWPFKsmCHnciwtCZuu1/4YeLmOIcBmollU/IbSQEE54Qv3IRRqypTbq1RQoAUzO1l4DVvLFRFyFYeP8Jsj18VL3221oa+VmbdgBTGjoN/W9UB3we6dW92bZ10/sAasCoWZ0FkDLrjZ+o6oLhVIgMHntQVu5ZCZEvsaMz/gjQXhyUVPn43MW4trrHrGBR4HOj2FIpDsZNBtqC3C57GdVjdC6ato3C5khifMdGMHYnQ2d7RT+yqOXw24UdXj+7UP31s/zqiz/Z4NMRjs1i0EDod8m1NgSWfs9LFUSwATmtdEw6QH+0hIKzelZaKDTHg==
Received: from SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::16)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 10:44:28 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::4d) by SN7P222CA0016.outlook.office365.com
 (2603:10b6:806:124::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.15 via Frontend Transport; Thu,
 18 Sep 2025 10:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 10:44:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 18 Sep
 2025 03:44:15 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 03:44:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 18
 Sep 2025 03:44:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Julia
 Lawall" <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
	Richard Cochran <richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, <cocci@inria.fr>,
	"Gal Pressman" <gal@nvidia.com>
Subject: [PATCH net-next 0/2] scripts/coccinelle: Symbolic error names script
Date: Thu, 18 Sep 2025 13:43:45 +0300
Message-ID: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 6535646d-7bb6-44f5-eff9-08ddf6a057ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?agrwTTaKjfyMkJE2abE8Udqv6z0M44FA2O9+iXFoHbDsjcRWrvRVfih21G9S?=
 =?us-ascii?Q?xqLhYkr6EYfUAX8GiLvbSHREDOrUyrv1CZGREf3skXjrs5y8gzmgTVL0tDhM?=
 =?us-ascii?Q?ZDQJgXfnJhAJ5/lDa9qnmhKXPodBv+Wcw2Wz0mlA23bFH83Z5sJIJwJ5QYne?=
 =?us-ascii?Q?5Oi5eYDfunqalA5fb8lBFBURxNywvQNxs2/ot4LKid0aTaRQEd1ZV7eAX6J1?=
 =?us-ascii?Q?JQAe5YsujdNBGvTU9W3+0Jw5/Vz7V0ePxga9oUesTOSxtHm6qciv8OZX5fut?=
 =?us-ascii?Q?ahaikspkRA+hZRC50B8StURrzWFRGcRAL18Se6GmVmGLbGnNXspVSlCA7U3Z?=
 =?us-ascii?Q?fCl1YNYc8lmcs2jP4A1ejwAAF5F9mwUOncTTCQl22DFJfom1ZPbsbKUmxzq/?=
 =?us-ascii?Q?03Ev5aKE+t7jy7+xWZQDH0NPb8NXPbXnaGtCJZuZJM5xT4pP1PeAipDgokxt?=
 =?us-ascii?Q?NfGDmNu+NQXo0VDE+H8jSu1whoMbzWYJ4NfaDqFaFYB3zfzNUHhZxWzIiPO8?=
 =?us-ascii?Q?7fYtpOI0BLVHPW4OI02mR280uGoF3Tc1GACQd9qhgfB7fMjjcGXsFzgy+X3b?=
 =?us-ascii?Q?qHWI/LPov1YHE0cMNOTNlCdorPrcmS3G24iKzLMXcC2+6mAZW+/udyko3k0y?=
 =?us-ascii?Q?2NmHPLTUILkBEX2RP/RMiXc5yXAVhioS9LUdsGkdOWJUlqhtZUCuqdbVHtl2?=
 =?us-ascii?Q?mIgPxz/I2bRAbEIE+FZ5TuXEB8JfGR8BKhgGyEIrXqsJ+CWltgE5LCTn4kna?=
 =?us-ascii?Q?SrJ6iVbnB9m554B+KJa8tsfAvnLTImMjDF96Y/aOqr8LHmMgxmZw4NoZzCRq?=
 =?us-ascii?Q?02EZYaQSxdcqQsvhKSUWnq1RVYxrKqvf67dLT+0Ybs7Tjj0PEFelN0BJZ3iL?=
 =?us-ascii?Q?Gt1AvP9pe4Pw3ST8lnvm0YqgElGrcBLbXiSB3z4ifdWmmy7+1MTq8pRViM0r?=
 =?us-ascii?Q?i5d6xGJykvaB1AmC62eOZtK8wWBYxdzy6U3i2E1aWwTxNZSWfw1t0ZEtoITa?=
 =?us-ascii?Q?hraUZfIV3cr/LqBnNJ26hkXiGl7rVESPLzaOvJaofhOfM4zfR5wuT/uWSglx?=
 =?us-ascii?Q?koTSzO9PtutWwRtb4xkqKHiQDfE4j50uSK8tEr6Q7OqV6XfFTp2U8Apm4yWH?=
 =?us-ascii?Q?nmD/3nhI301mkFw0asqjnGDlK78LsXaeo9JMr7sl+u3Ev9GSB9OlKqqSSNVW?=
 =?us-ascii?Q?s85uRwdZ55XQT2UoeJ5tHKEHYkty9S13YFR1SgrD1mhXOmVsMH3vpI+t9wtL?=
 =?us-ascii?Q?BN3fXQD79HiesvyJDJcsSP8/9dfZHqAj80El5XSH5m9HPNqR+k5u42LqTLON?=
 =?us-ascii?Q?ijwxIecf2bCazum+SVvW4gz3Ig/4jbAX8tpEOjShvAP0zrVNzNpx9wudhcLu?=
 =?us-ascii?Q?fBxbYzBOZ0qG1XauzQoNIyYVJRPSjX/fTENTzn4HP+PzXLrkPE62JcPhShtv?=
 =?us-ascii?Q?ZTS30S2gPYOkMhfcXh1WD1bc2BaN5K9pdQ/G1Cbg8dwilfbE99+KwHp0BtWj?=
 =?us-ascii?Q?zSqmgLZPw5kdGy2WOySVWdlz949RyjC27Q8z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 10:44:28.1133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6535646d-7bb6-44f5-eff9-08ddf6a057ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317

Hi,

This small series by Gal adds a new coccinelle script that spots
potential transitions to symbolic error names in print functions, and
then uses it in mlx5 driver.

Regards,
Tariq

Gal Pressman (2):
  scripts/coccinelle: Find PTR_ERR() to %pe candidates
  net/mlx5: Use %pe format specifier for error pointers

 .../mellanox/mlx5/core/diag/reporter_vnic.c   |  4 +-
 .../mellanox/mlx5/core/en/hv_vhca_stats.c     |  4 +-
 .../mellanox/mlx5/core/en/rep/bridge.c        |  7 +--
 .../mellanox/mlx5/core/en/reporter_rx.c       |  4 +-
 .../mellanox/mlx5/core/en/reporter_tx.c       |  4 +-
 .../mellanox/mlx5/core/en/tc/ct_fs_hmfs.c     |  4 +-
 .../mellanox/mlx5/core/en/tc/ct_fs_smfs.c     |  4 +-
 .../mellanox/mlx5/core/en/tc/int_port.c       |  8 ++--
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |  8 ++--
 .../mellanox/mlx5/core/en_accel/fs_tcp.c      |  2 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  4 +-
 .../ethernet/mellanox/mlx5/core/en_common.c   |  4 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  4 +-
 .../mellanox/mlx5/core/esw/acl/egress_lgcy.c  |  4 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge.c  | 47 ++++++++++---------
 .../mellanox/mlx5/core/esw/vporttbl.c         |  4 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  4 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 16 ++++---
 .../net/ethernet/mellanox/mlx5/core/health.c  |  8 ++--
 .../mellanox/mlx5/core/irq_affinity.c         |  4 +-
 .../ethernet/mellanox/mlx5/core/lib/clock.c   |  4 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  4 +-
 scripts/coccinelle/misc/ptr_err_to_pe.cocci   | 34 ++++++++++++++
 23 files changed, 114 insertions(+), 76 deletions(-)
 create mode 100644 scripts/coccinelle/misc/ptr_err_to_pe.cocci


base-commit: 152ba35c04ade1a164c774d6fccbf8e8cf4652cf
-- 
2.31.1


