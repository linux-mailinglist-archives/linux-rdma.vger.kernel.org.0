Return-Path: <linux-rdma+bounces-17125-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMAWN/yQnWlKQgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17125-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 12:52:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B401869F6
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 12:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FBA330FE1EA
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BF03806B7;
	Tue, 24 Feb 2026 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZU5czGvb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7C3806B2;
	Tue, 24 Feb 2026 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933674; cv=fail; b=piM3upX08x3yX8pLTZR5vnlJRMorKoow2qlL4bSgI1jyeHHSckQy9/1uuy4eJx7C85UUnqA1ma2XG/sGX/1uXx+RWaWJs8WkbXekLssPCKQsy5MM3EVjYX2lEO1/EYcNOGweftUS+PfhdkvDesro5pTldYVkR7Ros2hUrCfiMBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933674; c=relaxed/simple;
	bh=WwT41rjyhlEKUkWpqupu6i7GxiCsPprxfWRv0fSioyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgKfZhcuGwrDGkHJ4xCHlkdiLNs77yKF/GrvxCHsOTV8I9Mz3VMkr/udDFJhn+jtcz17crIG1wW8Cd3GxK3aZu3IxeXjnrvabP6gMPh+AJ9ylh40SWMVIrD76e2b8OXJVbyryoHYmAOViNzoIEhMRpxu8woUzsD3kVVsiyYrcfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZU5czGvb; arc=fail smtp.client-ip=52.101.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OG1aSpbM3m6LjPSpO3bRGmiKZhBkMu07bNk+fxEXZSfbXPfruA2QBc/KUmdlyUfuCWHVVLRjJoXpC/zPTCRFYEoQVLsZYvIoVk988NrJLkOAu2l9hZufL19oVW/thE1dXncNLPBzhJqB6Fzyf6TfVuJrTzE+iHah4ocX0eHJyPgkurI7vqvvl0nuNRZ2a0N2sfExMpVaQ60IrFcZlwdep5tdWPiXkGLmY7jn4Zk2X7NdNd0jlJJZCMI+cy08Hiw3toQJcyxkHe8cxrxNBl6MxQ63LxS6S3jhGUc7/UJC53rYPXPFoXq1MVyXwwTJHbiOGs1hRvcUoYQll+wpzkyqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKfIlrfpKfW9qzrKg31x78PRNilWLRNmxa9EaYacNqs=;
 b=LfGQbltdNeB9qzjEMem4GcbQaRpvloVsTOZ5UHa2qfhnoFbaoxLMtIHxlvplaXGztIhcVOzwzLLUf5tagu1v2psDYEpLQ9lhhZb3Oi7mbmlFuumRa84392KyvisSI9iyMyUILlnLQET6gX6ve4xs2pXSmfFR03T3DheTbI8B3i/DlpRnGo0h4p8sMfBzfr95Dpo05alY35a9rJ4sRrizjizK6Dw6aS71BDn0KHqC2LBzDSXH+w8AFZ2PqkPzwz4Mlq0+LtxtFa0savdji12qMUx1VTEmjAB4YbxNKlg56BU9AfFKMCMkEjts3KKtAt/hACu74uh2EdOClilT/y8AFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKfIlrfpKfW9qzrKg31x78PRNilWLRNmxa9EaYacNqs=;
 b=ZU5czGvb7FI644Hn+8WFojZpSYHOkYsW7tViThPtAZWfKQHVIGewRaVW+ihi6v1UeuRHVgrJtIMa40qsA7W56OUvPzclFAbuvJ+k9nIUZjVqu/ENaqxFWWQKDI69Gm+QzXkN9Awd0we8Q2yMdvkgUN7t4ovzJpk/wmGUxa9T6xNJJe2Qtu8XrFmytHEtiWJFOeCIZ/gKW4nZWsyRuFMYDnCCO61NWyLshTzZUNCyuPA1HBISOXi6ZrAUWMxAzmUjtqQMM2s0rQ1J84aQDhku8mCnIxOxS5WW31aJoQE2g6PJL+SzBPsMpxnXGOoG/ngneZ76ZJaqg9XG7jaYHUg4vw==
Received: from BN9PR03CA0899.namprd03.prod.outlook.com (2603:10b6:408:13c::34)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 11:47:48 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::98) by BN9PR03CA0899.outlook.office365.com
 (2603:10b6:408:13c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 11:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 11:47:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 03:47:36 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 03:47:36 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Feb 2026 03:47:32 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net 5/5] net/mlx5e: Fix "scheduling while atomic" in IPsec MAC address query
Date: Tue, 24 Feb 2026 13:46:52 +0200
Message-ID: <20260224114652.1787431-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: f71e05b9-fdc8-46b4-14ad-08de739a8884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A656nYpGQc0ql+7wfyH1reuT3hbgKBolQKF25wS/GKyjXKej0vyNXn/KHoUT?=
 =?us-ascii?Q?wpefwHJ9AvIf+CJgyo0C/f/ZrJAj/KROK2K5Xfur35RVl52mkrOPvCYqwLRX?=
 =?us-ascii?Q?owsTB4C3y2UmFU4mfba2nrCx34rLw+lUYbMVxj03g2vf3CPEpMOixVWaIKTt?=
 =?us-ascii?Q?ObFbhnH/PeeyG2UEt4BQ42cxGQotUEJQFJsp5rXhoDO5BhdPYPk0CZsgBMhb?=
 =?us-ascii?Q?SzKSO4xo2KfXTCr4toiuhnXZ4BTZ9/8ib8fgIHvV3dP6hknXPufimIw7xkna?=
 =?us-ascii?Q?RM7lAPk2lBuaeCZ/UeBXMyl1HRaYG8yKt8nCqAM0Hw4DDnuqwynFDKj6Z9dt?=
 =?us-ascii?Q?kOFUnJV1EUDqG1NRusvCtiDe+s8qMwsWdSSgy1vYJd0gYPh31NKvckENbKe+?=
 =?us-ascii?Q?F3KwlB+jZe/jLUcer745ZvtstdBJZflOhPYzih1cbmoIv3uQKcy1OKb1XxnA?=
 =?us-ascii?Q?xh6DTAg55fWu9n/CCa3+yWsxAJ0P3oPjyV8LLbBQdL/MurrnnN/E3U6pmpn2?=
 =?us-ascii?Q?7EOM1D76beLn6qJw8AKsyj8OSOuASKKOQM7/5sHXGttI2FBeKV1yoPZ3NddG?=
 =?us-ascii?Q?yMikC0rcWcZgZbJmLLdF/eXLYACSG1OtBDUPubQqJC9TwIUlBCPMvi2e2RUt?=
 =?us-ascii?Q?HHmkur+wkb/YRcfITq7592iKQ6K4hO+mFQHY+VreO+qUA70Xpm92SffqjHlI?=
 =?us-ascii?Q?4uasVbI2WMGqiXh478FOg5a3N1nKFsyY4+6Hdi3Xq1n/SrXryEMMaqYuXUHr?=
 =?us-ascii?Q?DzyJB+1NyC/MYL9SQXXouk4MYiYcg9Z+/+p+81YyGvCd1ZFSa+y94/l/wT2J?=
 =?us-ascii?Q?YXEjnIcMVT9Jsu14Uo/8BvF7Q4ifzrRt3x36JM5GFAKaEovPReVVdJYqG0nI?=
 =?us-ascii?Q?1Ohzos+iSk47p4ygMMiVH6R+PwYmDGH4IQaPBM++Z5gi3c/PzapX74+s69uH?=
 =?us-ascii?Q?KEzXNxec/RTXKhW8ZezARWByNfAPQ4XFzwHFHKx0meeXgkO6i3qZ5+sQnqau?=
 =?us-ascii?Q?2qGL+GzIJdjle7OOEm4DPg67B3t9FqhpfJCIovd2vuP4NmA7JBwT6BKpcTgO?=
 =?us-ascii?Q?hdURiZPo4R8jHJufGMcULlNIZOo7lWlJXShlyMgYrW8PLEd43CV9AzkV1dI5?=
 =?us-ascii?Q?tWGMtDJCnSAGHxxtwWFJbBtFWrYdxNEtRhIflcuRHvzte67tDrbL8uE0dzjK?=
 =?us-ascii?Q?yYnNp1J82kgAm6GrTes8pOrLLUWjTuwvGkZxWnUgrn/D6xeSg+q+zg4ikuJO?=
 =?us-ascii?Q?dzA7N9vLQyqoBL+Z9AItko3mgn4lgKHyFC7vDgec1/PsyWvy7jPD7y2Qy/Ab?=
 =?us-ascii?Q?tQLaCyCl3lJOqfoY91pT4QelCi0gvjBBh8wnGx+Nn4B7YahP1GkePQ4zmji7?=
 =?us-ascii?Q?JLp/yaJoIUj4JxGp8bJltYQBqi7Ng1TcDL6d9PPxIuj3fwZQ8cvQatf6l9wQ?=
 =?us-ascii?Q?n2vTCTAWk2yQCsYkJfv/c2zdGwZBf2LMQRdKSDUmbD6g7037nLuM6A1+OsyI?=
 =?us-ascii?Q?h2EYTpbS9E4L8BKt1vUlnY2Dbw3X4+87Bu8JVsQq/eFlrkyOAdNgywfJAV95?=
 =?us-ascii?Q?2O1nqXd6S+IwIf2lnHXefTVLjSaVoGqarnslu71liYzLn2ie6ywoOAaT7zJx?=
 =?us-ascii?Q?IFqnHxMbCCRJMm/RisD/VjriVcTlM6UE5AHsEaphGyIdtXT5i4/l4YrzojmV?=
 =?us-ascii?Q?Jy2zWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Hk73TrtXRD0og9SBUF3xyLmUescJl5rvV+T5Vz1Sr+uzoNrjObz1+KTI5DuCvmvKnaXPM3M/yvmu2wC6mGz2DjdodP69a7mnyMzoWVaIK0kMRyLSfNYNUUnwjFJ61mRQyf6HRoKT7Ei8Rn9e4+tvxyZUelG6Pzy9uoYlt/sSDlFSEgSDaLGAF7tHvmjFGpTNQbaAxmtFHAQYd8U5ZAB57VA8uWaNdVyOrSMX5RQ1dVNdpzRqPkcb+E52j2a6bHxkT6y662DZVWvoFB47Ho1QJ5kKjxpPbZu6XhrVd77I4Ma23NWbAgueIIg6mIOuGDWmQdGYw/B6UlUuBBPzaJuiwgTAFWW7BIkouL/Hj6FEsdrT1o2QMaejUb50dQq7cNfdu+3n7++1wvpqgJPiwW1Zh3z/4d7qcMRQCLDUxwHsmt3JVyEq/6nWLDdZVVtRGmiR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 11:47:48.3938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f71e05b9-fdc8-46b4-14ad-08de739a8884
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076
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
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17125-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 52B401869F6
X-Rspamd-Action: no action

From: Jianbo Liu <jianbol@nvidia.com>

Fix a "scheduling while atomic" bug in mlx5e_ipsec_init_macs() by
replacing mlx5_query_mac_address() with ether_addr_copy() to get the
local MAC address directly from netdev->dev_addr.

The issue occurs because mlx5_query_mac_address() queries the hardware
which involves mlx5_cmd_exec() that can sleep, but it is called from
the mlx5e_ipsec_handle_event workqueue which runs in atomic context.

The MAC address is already available in netdev->dev_addr, so no need
to query hardware. This avoids the sleeping call and resolves the bug.

Call trace:
  BUG: scheduling while atomic: kworker/u112:2/69344/0x00000200
  __schedule+0x7ab/0xa20
  schedule+0x1c/0xb0
  schedule_timeout+0x6e/0xf0
  __wait_for_common+0x91/0x1b0
  cmd_exec+0xa85/0xff0 [mlx5_core]
  mlx5_cmd_exec+0x1f/0x50 [mlx5_core]
  mlx5_query_nic_vport_mac_address+0x7b/0xd0 [mlx5_core]
  mlx5_query_mac_address+0x19/0x30 [mlx5_core]
  mlx5e_ipsec_init_macs+0xc1/0x720 [mlx5_core]
  mlx5e_ipsec_build_accel_xfrm_attrs+0x422/0x670 [mlx5_core]
  mlx5e_ipsec_handle_event+0x2b9/0x460 [mlx5_core]
  process_one_work+0x178/0x2e0
  worker_thread+0x2ea/0x430

Fixes: cee137a63431 ("net/mlx5e: Handle ESN update events")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 9c7064187ed0..f03507a522b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -259,7 +259,6 @@ static void mlx5e_ipsec_init_limits(struct mlx5e_ipsec_sa_entry *sa_entry,
 static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 				  struct mlx5_accel_esp_xfrm_attrs *attrs)
 {
-	struct mlx5_core_dev *mdev = mlx5e_ipsec_sa2dev(sa_entry);
 	struct mlx5e_ipsec_addr *addrs = &attrs->addrs;
 	struct net_device *netdev = sa_entry->dev;
 	struct xfrm_state *x = sa_entry->x;
@@ -276,7 +275,7 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	    attrs->type != XFRM_DEV_OFFLOAD_PACKET)
 		return;
 
-	mlx5_query_mac_address(mdev, addr);
+	ether_addr_copy(addr, netdev->dev_addr);
 	switch (attrs->dir) {
 	case XFRM_DEV_OFFLOAD_IN:
 		src = attrs->dmac;
-- 
2.44.0


