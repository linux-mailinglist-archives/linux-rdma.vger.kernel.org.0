Return-Path: <linux-rdma+bounces-19630-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBVCDzpI8GmIRAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19630-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:40:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D855347DB68
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88917301ECC0
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 05:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4DC326D75;
	Tue, 28 Apr 2026 05:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rLJv2OVf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC452D0615;
	Tue, 28 Apr 2026 05:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354802; cv=fail; b=A5cWB+3opCHLZHAlB9vLDQxqKYoXnmeOzJ9UIxZ320ZdT/th2FWg2jXqSkZJZw4best41BZTumHaWD4rzcvgS842Aqh2/4jlhIhdj45LX1JcFLQkIrioURBfpv72znDeLz19Aa4JssEmwiIpQ1n4lrJW0GKsRnAjylcDNcqDuvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354802; c=relaxed/simple;
	bh=GS3PiByqG1J4ZDdcb+IySTcvveWf2cMqOfSsvUGTc2Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p9uos6sg9/+UAtwnNAEaylfSpvoMKbV1F2f7WHYZmkGAi1Llkl9JlDx+bikF+/J7bdnQGXdKizUv5NDAzfqxY2pK15slzgQIGat9kC1cOoMESMkVDN39NkmDpn8WM5rKlvRvEfw3qSApdDCHzhBtkv8EPFz74mOmcPQzSAzkReQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rLJv2OVf; arc=fail smtp.client-ip=52.101.52.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAAUGj02GJcgqnvKEqXrqMmF3YbRwMi5ftHzQQl4sbzb6Nx+yKcaTNKyOOptnIHOogYTASGXwsWoUSn7IzueBbsHF/jESppbyvBwxIiYMYjvGw7n9bn0zubrqNJbYaJdkzqPhuDQFApk5EGBGlm1zARkgU7G5Ebsq3bq5GTBdxOuXoEhXcJU5dmXlwEzWzuPzr5SLb2/ETvQ6PnMQFGG5aYXW+2VllyeL3wPqPbBvla3MZ94+WemyubFKXTLs466T/XiWcq1lwqI1Hkc5VQ4/ps6i7tP34WXBAPBvCz7yylPcklmaaNkz2nM6DgXoNOdf7iTMGdAJjX9XCSVIBfu+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u84i9jA3VmhZLBfzvZnZJVqe0Om/HdQ/W22jat1sO0I=;
 b=saSNgPvI1p1BRW9BA1zKyIwOTu6JPXFU1jjG0h5nC5CDa7R9PxuYjNntbRwJyp8I2/GsPKy6uu0jDFiB4w1xKM8WVbrAJydK5/kcJYaizF/e+D8IV7Yl47zR0WzwWi49jf0yspuHajSL4mYqdi0e9sg3IX6kCh7SkNcpB8L/JpprV9G/gwkFgFUvcGj/WuIOKcmhkLRWvGbjJtCGyDkkF2ueyvrp71kYVLaT0uhXZbnQJN0lYasEJBNgPbWZunoQ42uXhHnLGZr9Bkg4Is9Ixrt9Xu0V7aAb9wfrTKVn55i1nP4ih3f0Y+OXEDRvuHixur9JwgwVr5PagKs/1EC1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u84i9jA3VmhZLBfzvZnZJVqe0Om/HdQ/W22jat1sO0I=;
 b=rLJv2OVfHnA4UCYxVjVYRWBc2QyV4VG+svUIUNVmwqS6JNHvvV6rIEvzZI4NANKclT9EDejF9qUl5uLiQMk4irZqeVotiTZynaEN01S66LH2i8eL00B8FsnIoHznu1wOS6MWDv0wCVE5brxyBSujb0lervTFKfDOGFKOPOsx4kbTtvVFxJJ+u738C/1PquJ5kycXwESjHer8CgqteOcdtJXmXYv1rrTh4E3fG6Ar+zdhir1mey4aTe0Jq5Szu9Ogt/4t4HNyLH0JOe9sgcGKj1l9Qzu2RhlzgpJKNl2BwjQa98RtqiSdJN2zWiMwMfp4YCLtExw2NkHYn3Jqd2K97Q==
Received: from CH0PR07CA0018.namprd07.prod.outlook.com (2603:10b6:610:32::23)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 05:39:55 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::9b) by CH0PR07CA0018.outlook.office365.com
 (2603:10b6:610:32::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 05:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 05:39:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:39:38 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:39:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 22:39:31 -0700
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
Subject: [PATCH mlx5-next 0/4] mlx5-next updates 2026-04-28
Date: Tue, 28 Apr 2026 08:38:47 +0300
Message-ID: <20260428053851.220089-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e31128-35f8-4bcd-7ad3-08dea4e8938d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Tssn5dMVuGwBo7PWDm9XsurdkU7i9roor/fyJjjRp/7PicTvtWBkF/IF8uuwWBS7xsX8IIkOw4oNROw1piHLdjwhXzOQ3w6cBzpUHy466jmwRsxJSal7zZG+ksG4I1cO8sgKu5UQaSOfyLbQYB/Evdq7/od+aOKCAifExFABYFnNzi9RFcdBtz7sgMLW21JyTsdiSK3eDW0vecVQ/Nzd1BfCdBoFtycYIoFeJWSo4U3mZYRcL8WR2Dmac/hklkGJe04JJyXEFsu0dn5XXCZjCLIDL1ZRK5mvxcYguxvS9IIo0hyBW2MePb3k427Kz+99PQPtIRzFBqr0UmGvwRKMIGgYPkLf0NdnsCvgJJzc9xX4YqKrDw1qjxXWPirRES4Xw3i/VDpzi76OW5UEEqDu9xcvUyFWsccfgQ+1BnYBHPVNW6jISAXcaPNzTtLs/9KWXXyjZOBWUGA2wLmKayn7ll2efirW3vaKKB1PW75JZRcfBmZsdHbjBMvZc11Pv+1F/nPjUPAtPRinnLjXoWQlD5bHWTGuyUTJdCUJducSZZDQNOf4ggrvPVSz0a19638Jl9bY0rQzva3is3kD7pcc/wxO/2ZDTqOlmeAQrTuDpDdSy0OU9DLHTDpfXZ3s/ufSwAdn+o3KNqS7Q+kvogaDv7d789s8z9L1ax0Fd3/hhwea3VBHjsEwx0vEIrIPVfT3tiwg2IgOTxM971/V3fshmsRSH1TtoFWXJvbfKP3IYSHN050V+Qw0u+1jSa7i3ccRbq12JDfCRVmLMuXLGlHt7w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m16HseH3FAXfJkLByBq/y3fX4aNtNCvgIBKB961T3XE571Tzy5DBbUqJgNZf55XS7K4MzDUBbf7OI21tTjfmns4Gi5FrfRGiLvBtqZ5O411e/5RV5Us/8fzGBJWpEs/az+V5rL6R0WVjg3t8/cPOMeGvb+rMDHJDtBo0C5WJqDbvYhlGIKw3ZMIBAoPguIxo2IwMtuZsT8sN1wg2Px0AMlxX2cuRn01m0j1KjaAWkheRXbPjgxJIfERaMtMxkswiINJZXdfvFaeR1d6tmAJFQjuphH3esmdDXfYVbibhQzzGqDvGP4eIfnuUt5eU9qA5LN6wMFlOKB/Yy+2KzYPJJ7ONOPHrK36MBe4w24y2mRfRt3R+GmJzm8liKEZmFJoQbOkjXQmJMpZfucZ0EY/mW8+Ar6g15jNp+6E3bL1rn/0IqGWKzOZ2v+uDDkwji9cI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:39:54.6420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e31128-35f8-4bcd-7ad3-08dea4e8938d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
X-Rspamd-Queue-Id: D855347DB68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19630-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Hi,

This series by Moshe contains mlx5 shared updates as preparation for
upcoming features.

Regards,
Tariq

Moshe Shemesh (4):
  mlx5: Rename the vport number enums for host PF and VF
  net/mlx5: Add function_id_type for enable/disable_hca cmds
  net/mlx5: Remove unused host_sf_enable field
  net/mlx5: Extend query_esw_functions output for multi-function support

 drivers/infiniband/hw/mlx5/counters.c         |  4 +-
 .../mellanox/mlx5/core/esw/devlink_port.c     |  7 +-
 .../ethernet/mellanox/mlx5/core/esw/ipsec.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 36 +++++----
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  2 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 42 +++++++----
 .../mlx5/core/sf/mlx5_ifc_vhca_event.h        |  8 --
 .../net/ethernet/mellanox/mlx5/core/sriov.c   |  7 +-
 .../mellanox/mlx5/core/steering/hws/vport.c   |  2 +-
 include/linux/mlx5/eswitch.h                  |  2 +-
 include/linux/mlx5/mlx5_ifc.h                 | 73 +++++++++++++++++--
 include/linux/mlx5/vport.h                    |  4 +-
 12 files changed, 130 insertions(+), 59 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.44.0


