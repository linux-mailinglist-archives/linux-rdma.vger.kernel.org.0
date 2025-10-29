Return-Path: <linux-rdma+bounces-14117-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66422C1C5FC
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 18:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD96E5A76
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0664733B6C8;
	Wed, 29 Oct 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QJ4CW8Qc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3399A331A6C;
	Wed, 29 Oct 2025 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752650; cv=fail; b=ZWZn5igEDkxl4eIRVk9cBZtOTmv+OvTaWJafxBnb+Jp3bKPP7WJd96zVjrHOg5lio4FNRyPhVJpZWib3nFjTdJQqR+t38gpkurMW5IDDyZNc3FPgRrs3ndkhwQuynqePw/5FsZN5A1SDPqG0ITO6+OWJXBK54jzfU/KotlfR2os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752650; c=relaxed/simple;
	bh=IDxb5lcFgcds3SYrWFYMP1qXlGkTHAPbj6Gl0FLlyqs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ukxBmIx94SV5dBot0hIn3oCzDKinLaL5N4oMHuiP5lOb0ege3sscieeZa3/u1zNhnGD5ZjofSQu8G/yyg+92KitBBxSzXdwyddK/4naaDq49O7VE010HTZ73kRPjs46qGKwQTAwxlxlmCJFzOCZUnAooMPq4JZ21oq4obFZmB/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QJ4CW8Qc; arc=fail smtp.client-ip=52.101.48.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obQYlskOuchtZGXP839krgrpoXF+pV9fd5wQ92LRQGDKi8VDJP//1KZF9qS9bn/J/ri7WZPkUaWAFjnHEWHBHleijYIWtFysuUBvKu9NpCOStlvjaBOmLfgpbss8JnFfzgH8gTCfkDgizc4j13qNsqKMj7S9A4aKPqxmTwaaIt8YkW5AsnqyrvTuvclxB4Im78O+AECZ+Lw7+ZxUTUyda6xUDFgwmjzU5x/lbGgX8ur2AltOmJltgfrxSC3ZCVATnSjD3Xu7Et0fezIpwllE0bUoWNkj6GfOIOJGs2Q4PSXuXhdZsVoo77qFX1M6ZbJMkbZjLyCgT3PMyea3T6SjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEgAMpc3kQ6Kr3rb3XlX10JK0jg3ryu/O0sayFxeirQ=;
 b=whUFCDeJF0wt2bk7gZ1oHRMZAOhGojaJl2KDsbgdp/SIq5RofLbIFyvAYFuxkC3ApdAz0j9FoO58PmPOu0WXDuP19UyM7I53cP2rHdy8gbgCRmwQBNK1Qhm7/qRukDjXLsKVT8nGJNTzAW8uyKfn/i3usS+8D8ybm/IguJea00uMlNy3ov123wDnXKzHuYlRF15YfaE6NRU1xFI4Ej7HBVbbCYR478PU6uqOiTLTo5eQzISxSELdwRKBD46dEoXO7rCq+qMmnxKAUay24ZjeiDNa0W0xInyPPvvuolI2rWcmpJ66Rioq033qXZsoi3uGcq45oyluve2FprK05/izug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEgAMpc3kQ6Kr3rb3XlX10JK0jg3ryu/O0sayFxeirQ=;
 b=QJ4CW8QclmKGFv0pUHRaMIQjSp1D7MCx8m3nv/j0HT792LyxW9YRrrMX2oChN4xeAuCIOxiLWkBfCBCZqbZgP0DQxavkoTAIin039V0S/K6kSoErN7sXm+zJ4Gx0untHzgGmY2f6Ll2W+5aQ8EcR8ZhFSaxAMFrwO9IZLNlYPQuawYu4zz+TdhrKiXqaiqojqmkElbQyrimiM7pjAh2txNYDFfi8TLvw6H57+vsPseWvyHYEfOUHuCnjCuzRGE0qS+BclUSPH46zp5T5mFnw/2HCNq8gjGmSia+7z9U/DDhv2YR20nTuJ61/xhkzNvNZPDfyJbU2uzojVY3QHlIWYw==
Received: from PH7P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::29)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 15:44:01 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::5d) by PH7P221CA0012.outlook.office365.com
 (2603:10b6:510:32a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 15:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 15:44:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 29 Oct
 2025 08:43:37 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 08:43:37 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 29
 Oct 2025 08:43:32 -0700
From: Edward Srouji <edwards@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH rdma-next 0/7] Add other eswitch support
Date: Wed, 29 Oct 2025 17:42:52 +0200
Message-ID: <20251029-support-other-eswitch-v1-0-98bb707b5d57@nvidia.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e7815a-4004-486c-8f98-08de1701fb43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUxMZ290cDJUa0FDZmF5cVlNaDhIL1R1TmNKNjMxcHB1VE5NdWZtMnRhbkNv?=
 =?utf-8?B?TzFrZGthZHZuRzZnWGliam5SVm5DcFdHNzhZRHlNY3VUVVJremJ3QUxFZTBx?=
 =?utf-8?B?N2RIc3RSVndkSFQ5L1JBQ1g3OU9XT3U1dVpyNm11ZlZDaVRlS0xNYU1teE1O?=
 =?utf-8?B?QSt5K0NnZVp4Znl2d2tSVkRoWlM5cHhEK29vaW52UnBIUFBlWk1zRnBHT0hQ?=
 =?utf-8?B?d2VrZldiUG11Z0hFN21PeXYwelRLb1Z3cEJKeHZ6M1U5NlN5Rk1BTkxub0hi?=
 =?utf-8?B?UXlmemRDeEtWdENWc2lGWGp4WEtCdGwrZ0R2ak5NdHVGNVJHZ2c5SEZqUkl2?=
 =?utf-8?B?NUFDRjdSZ3FlbVJQWGFkbEdWYW5LMmNSQ1h0cC9GL24wc0lIY0sxS29RZXND?=
 =?utf-8?B?TWVOM0VEUG9obTdxYTJlaWQ2aDJVNTM0MTF2YW5KeE5ZNXdycFdCZ2pTWjZr?=
 =?utf-8?B?c2hUaVdOY21IdlVWVy9xaTBwaFFXbmtad3ZHS1ZENGdEdlo2dXJIY2phaGNP?=
 =?utf-8?B?clhSL0J1L1pNQ1AzQi9mMk1MNjJiSGJCeXhHRWpLcnJKM1hQR3VFT2VQWjY0?=
 =?utf-8?B?MEJybkxIN2JzYlVXdWtvL1JYRmZrZG04S2ppZ01ENlFOcERaM1JOOFlyRndQ?=
 =?utf-8?B?ZDZ1VndYTDZ4M3VCRTJ1RjB1eitXR2xzbDZ6NDNMclRXR2xSS0F1VU9hT0ds?=
 =?utf-8?B?bWlDWGtmU1VtdWxqN0JPeXlMK20xZHhhdTVxL3krM3dvbEh4S2g1bWxrb3o2?=
 =?utf-8?B?SmkwYzdOalg1bkhlRjBiOUFpdGp3ZitCS05MSEFLbENYN2xMMitlaVQ2MFox?=
 =?utf-8?B?MEtDZjhNcnJrdmM2UHFTOW82L1lEQ0w1bXBOSXdRZkR2Ym9zUDU5M092R1JW?=
 =?utf-8?B?SUpLSEcrZDlhOGZxdlRLWjJEVyttaXZzL3ZEY1dVa3B2OXQrUDdUc2JUN2Fn?=
 =?utf-8?B?eXYxOXc0ZjA3UDFzT3kxY3J1YXFXN1I4T3ppeVZ5cEF5U0h1N2J6a2w5UUlZ?=
 =?utf-8?B?QnZiNDZHS2FqTDJLM1JMR0FXdlMrQjdTNHJGTFN0V1JQS2dXUVAzZ0l1b3J3?=
 =?utf-8?B?eW52U2dBUWZHR2N0SnRIbkh5K3FZOTFpbmluZDVqbktGaTlOVXlZbUd2a3lh?=
 =?utf-8?B?RVhtZHNnUzhCZHFxTXlaMGxUeFNiS2dzUUdDNC9ZdTdJSTVZd3JJcExweXVn?=
 =?utf-8?B?N1BoWWJGdTFzNWo5RUN3ZE9palN2T3JaZm5RNm5SYS81UmxTem9UNG0rUFpC?=
 =?utf-8?B?U0p2a0JFbzk3Rlh0ZkVEKytqN3JSNlVjYzhxWE1EeFRRWXRGSENzdWoxVElk?=
 =?utf-8?B?ODlRQWdOTTJsRmdBSCtTeG54RnczTm9OdUNrcUJVWE9JcGVXU1dMc1ZsVERr?=
 =?utf-8?B?MlJ3ZFZTSCsram5COFVHTk85dGdYNkhjRWVYZnQzbUVUY1dubExFeHN5cFM1?=
 =?utf-8?B?TEtRQ3dDSW9EWFBWRFJ0b3lpakFmaldZb0U5YUJScWgrMVJSRHNGckdEVVk2?=
 =?utf-8?B?Y2RwRmFUMCtoUnBEb2ZIN05Cc1lGb0prTGc4M3BWZTRoVE1BN01SWmxBOHFZ?=
 =?utf-8?B?NlpORU50emRUd0VRbnRheDlzUDFJWUdEQ1Q1UjY1VWlRVW5PZlVKcWRPRFQ5?=
 =?utf-8?B?dVFPZ0h2c1ZWUnVJbG5UZ0pWWGs5LzMyL1c3enpMWGloT2tKSC9hZTNIcy8z?=
 =?utf-8?B?bmtab2syc0R0N1E2Q1p4ekRYQ0h0elpvMzJvMGpFRFBtd2Q2TDJrNVBIWDZX?=
 =?utf-8?B?OFBxa3dPTlQ0ZWlXYWpYQjNhNDUwUXhrckdtVGIyUXpQQ0g3UzlIS3lZQnQr?=
 =?utf-8?B?bzdtNmNVVVFnUndoYnZwbzMvV2xnQTBFOUtjdkFKRVp2RHl4QnpocCtxQjg5?=
 =?utf-8?B?NFJhd2NrZEJCQitzbGxrcDNqa1VMbXp2b0tQTndtOFFFNGt3ejJoMWhJeW1u?=
 =?utf-8?B?Q0Y3Q3QzNEQ1K1B6ay9GaDRiTkNEYWs1YmV5dUlJWEM1aUVyL2xoYUhCdzlO?=
 =?utf-8?B?YjlQbE9zUExZSDZ1clViYWNsM0xOTkNvMzE5M3BHWEpndGpqWG9MeUJkbHl5?=
 =?utf-8?B?VlFBVXVaVC9hMzFHSHpOU1UwYnFnRVIybGx5aElaK0hXMFJaTGZhclZVVjIv?=
 =?utf-8?Q?w7XM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:44:01.0002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e7815a-4004-486c-8f98-08de1701fb43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508

From: Patrisious Haddad <phaddad@nvidia.com>

From Patrisious:
When the device in switchdev mode, the RDMA device manages all the
vports which belong to its representors, which can lead to a situation
where the PF that is used to manage the RDMA device isn't the native PF
of some of the vports it manages.

Add infrastructure to allow the master PF to manage all the hardware
resources for the vports under its management.
Whereas currently the only such resource is RDMA TRANSPORT steering
domains.

That is done by adding new FW argument other_eswitch which is passed by
the driver to the FW to allow the master PF to properly manage vports
belonging to other native PF.

---
Patrisious Haddad (7):
      net/mlx5: Add OTHER_ESWITCH HW capabilities
      net/mlx5: fs, Add other_eswitch support for steering tables
      net/mlx5: fs, set non default device per namespace
      RDMA/mlx5: Change default device for LAG slaves in RDMA TRANSPORT namespaces
      RDMA/mlx5: Add other_eswitch support for devx destruction
      RDMA/mlx5: Refactor _get_prio() function
      RDMA/mlx5: Add other eswitch support to userspace tables

 drivers/infiniband/hw/mlx5/devx.c                 | 14 +++++
 drivers/infiniband/hw/mlx5/fs.c                   | 65 ++++++++++++--------
 drivers/infiniband/hw/mlx5/ib_rep.c               | 74 ++++++++++++++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c  | 31 ++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 74 ++++++++++++++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h | 19 +-----
 include/linux/mlx5/fs.h                           | 24 ++++++++
 include/linux/mlx5/mlx5_ifc.h                     | 47 +++++++++-----
 8 files changed, 277 insertions(+), 71 deletions(-)
---
base-commit: be180c847a6db6646d7bb4740a1d73f6f67d1030
change-id: 20251029-support-other-eswitch-0ed3232ce04e

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>

