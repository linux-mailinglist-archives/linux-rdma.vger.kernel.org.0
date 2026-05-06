Return-Path: <linux-rdma+bounces-20073-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FeQFDVD+2mzYgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20073-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:33:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 470374DB057
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5CF2301285D
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35E5477E41;
	Wed,  6 May 2026 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gktlRKId"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7642E3E8C71;
	Wed,  6 May 2026 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074410; cv=fail; b=Yp3hIs3PvLPY4oO3ehCxvtq2k895Zb7uHweKvL99XeNATspvQ9bkQZ+RA0x1iIv+PkFdWOtG7Z7AFG9lAmLffawJ2wPRweqK40hcjyyuTGC0FIWmYZiH9FUSlrSBP8tPph6udbIJdI+tBjB3DneYuJ7CaOFvwQQDiA2f2IJCkv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074410; c=relaxed/simple;
	bh=nDH2J9rlAa2YXfdeb6Prpqcna6WNy3VGSNKyvtVLbtw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qwIIfH8Hd7CwSrtG44D3yzZkfNSDFV3rLtH52DdT79jIG73B8fH4dphNyenB3NSD+mQYRZideBuwjts0qu+qKtVPl88XJb1I8H1+HFfFy0Tst01h1/eFWliqXfbUsbL3HTxO3Sd6uRJ5p8yeikm574bkEMXylLfwZU2V59BX6N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gktlRKId; arc=fail smtp.client-ip=52.101.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHn7ub1fvATWP+DeYhQak8Ddwh2ZnMDyMvm6Crxv/2w8DCz99txmzr1mhWO6G04Bq+7A1Zb9mOz6TXjIgngqDu8Simt6MRIPiKnXwNhgkhJRqbUs6ziqAzWGxsqimf3p1D2IwdY/cN4skXX1POyOXmU907KkZL13xb1dPEa+kh8wBA4A5dLDoVUttIQfFz4OCNM4ay/WDRyAQQ/tt0K/qr41n0Y2AfbZc275QPKhdCr/bF5YCfrDBTN2AgRqpZeIUH+F2HtTDaqBwtsl/BjE/6axtbVfshpZQfY2Nr3AW/bbmJNq9i7A8KUuWmyzSJvfuLtp3p7LIE3zbv4yYbEGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HQ2Q6CIhYwwvrBrPjbRHExq6czrDWWu9URbJluVLxY=;
 b=GrhIEFAJYQAVgEftTq/Ue+AawjeEt15Hg5sNdC2Zv8t8SqZz6ya1bPwFXlR9YabkA2mBuuv7Q2r3UVZVTF/3R3q5kowe2et2Howo3XlmqbSbQKdnn5qIqIHfM/B+Hpkby29ec+92nLG1tKLjSRNkeBwsRNxfjmWU2lygca1m+/c9OFR19ieCRLaMdlFRkuWT4P1DPEP2W80l+vFM6YSxd9KUgtNHavI23kzHi1g9tq/ctwQPVSzt+PV2q4lVHQW+UG114WR5w6Zc97YyIv/nkXeTjZiJxeSqEFn9TJdswv5odxluokZ6dTb6wvqIpPXi4rx0PhWNb9fz9zcHyoVbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HQ2Q6CIhYwwvrBrPjbRHExq6czrDWWu9URbJluVLxY=;
 b=gktlRKId8qS1alwNj9riaFpsrljAP+gGrdaw+TTNJDL+t3JyMbC6sl2mRCuulJeouC8RnPJ2j1Dyr/EzEVnWfynW+KS5yDNatgqa6C9oO1gSQT9PXwotBkJ91ek04i/trGDTggcstRFTyqeDky3SyMq2G8L5C1PYKKfvm/qjTqtHzYBpGe23fHu33N0IC9SD0iRaqJdidAmreciOEAtOMK6u3DaJOrzG5dpL6ihFThLpOrRUJfgUMENntpmq3kg5fJZnDemZFBPxBBjrgYQ0sDLjce4Ukh5jIlaVm86IwwdXIItbCcRL9LE1SCg88mhnIhWJxDg1G6T7RI7V0rz7xA==
Received: from BYAPR07CA0098.namprd07.prod.outlook.com (2603:10b6:a03:12b::39)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 13:33:19 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::11) by BYAPR07CA0098.outlook.office365.com
 (2603:10b6:a03:12b::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 13:33:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 13:33:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 06:32:54 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 06:32:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 6 May
 2026 06:32:50 -0700
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
Subject: [PATCH net-next V2 0/3] net/mlx5: ICM page management in VHCA_ID mode
Date: Wed, 6 May 2026 16:32:36 +0300
Message-ID: <20260506133239.276237-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: e85aeae1-c083-4f05-1b1f-08deab74094b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sANDeaC5Sfo8a2GwTloJyag84dIWDlzt6lKAMAVhXEDxu8zdXMz/yTcsLYYQ59kuEaDU/UY5KVHQ4OEXNjrDE18hQCRqbd0CJe8ByyV9YkVQSfCflAD6QYbErZKXu5utoYhoaW17cSVPCcIKW3EJx7g4Xz7j7/KoFzBPcGID0Ug+Oh0azdH2MOZBzEXdJFaiL7Styydw9ZLozR/LzM2NyvBpUdwTBeJajxRfvot1m7ez4aNqAX2hAwB5wsD20marbo8oAgldHmaKlURUlh5Pb/NjkmzjrGzWvGEqLwFDGvKcE5/FJC44GxWNPoxMJcMaIVPUzjDo1v/h4oHvK3XNZckJztBsewCVHnMfn0xAwvMuSxWV2KHNtjMf2s9RAH9GYrHJawQMRN+PpIxkDRMxBVp8c99rLJ2halKw1ncG+bgRnuVlLFbudZVXcKoHi33YHTsLAI1d3heKBcv/1GV4BxpXNMrhx9DI5q/KPeu+96FRRCEuiz1NFKi5uiJbi7qtNOkYESRhEnfOstdJG2tJiTOIhO+ZBxzoz1Su/rlKfgCA1xid35RvVycCpGRPUGHNdECrxVJOfj+LEYSJmqRgHrZy7I2/9kn2F2b3cWaKKuGsdld1ylywgdnW5FSJRJoF4243X9kZRLq3iLMQHE5riEg17cGt4Qxzvdl3HprYvXVGbUz9Pw474k7gzm+/pJsYcl2KtNQ/53UwCnAxuQnkT0CRlKboeEsNOuN7eo6cZ8LX6kfYzEGQ84TQ8facwwmq
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D9dnDfMpSINR5cJnq0R7N/0esGvu0qFOAzSQl5l9ePgXzptk2wR8tLvLhJZ7cT2IAH/qkJ526T9Cip7+Fq+IcoUOKer1KW9QK2ubz2wpPVG/N+p1sSvi1lpuhBY7ooFqYCxDb8EneevsPKp84qEwrn3UxLvOK+wxCEy3138YxCCrhG80Zw2xLGfY+gwI3nXnebGrC5wt/n/fmazi9u8+cqss0rXWUPrQNjLOGwpSW3a2t8qHD/0iYswSAzpt6fLr2M3ONzo1USTu07+4EavdTwfHyJo7s9/AzxDg2zrV8loGW7lkB8SyrCiK9DdBde9hunHUTCzUCF2tVUBxIAxJpg0Aps7ih+hm13nAliIfNlEpPqjm5YYRmidDJBh09RdS/zEqW98hoNnKdDs6+hPplkWGM5sQZH5NaP97hhZageeexkHpTPgSjx9HFsP2N4Fd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 13:33:19.2107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e85aeae1-c083-4f05-1b1f-08deab74094b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
X-Rspamd-Queue-Id: 470374DB057
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20073-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Hi,

Find detailed description by Moshe below.

Regards,
Tariq

This series adds driver support for the VHCA_ID page management mode.
When firmware and driver support this mode, ICM (Interconnect Context
Memory) page management uses the device vhca_id as the function
identifier in MANAGE_PAGES, QUERY_PAGES, and page request events instead
of the legacy function_id + ec_function pair.

Background
Firmware can operate page management in two modes:
FUNC_ID mode (current): Function identity is (function_id, ec_function).
This remains the default and is used for boot pages and when the new
mode capability is not set.
VHCA_ID mode (new): Function identity is vhca_id only; ec_function is
ignored. This aligns page management with the vhca_id-based model used
by other firmware commands and simplifies identification on SmartNIC and
multi-function setups.

---

V2:
- Cache vhca_id to type mapping to provide lockless lookup.
- Store the resolved type on each fw_page at allocation time so reclaim
  and release paths read it directly without any lookup.
- Reorder erase old key and insert new key on migrate function.
- Fixed comment on mlx5_satisfy_startup_pages.

V1: https://lore.kernel.org/all/20260501044156.260875-1-tariqt@nvidia.com/

Moshe Shemesh (3):
  net/mlx5: Relax capability check for eswitch query paths
  net/mlx5: Make debugfs page counters by function type dynamic
  net/mlx5: Add VHCA_ID page management mode support

 .../net/ethernet/mellanox/mlx5/core/debugfs.c |  39 ++-
 .../ethernet/mellanox/mlx5/core/esw/ipsec.c   |   2 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  49 +++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   8 +
 .../mellanox/mlx5/core/eswitch_offloads.c     |  14 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  10 +-
 .../ethernet/mellanox/mlx5/core/pagealloc.c   | 250 +++++++++++++-----
 include/linux/mlx5/driver.h                   |   9 +
 8 files changed, 304 insertions(+), 77 deletions(-)


base-commit: 7e0cccae6b45b12eaf71fc3ab8eb133bb50b28ad
-- 
2.44.0


