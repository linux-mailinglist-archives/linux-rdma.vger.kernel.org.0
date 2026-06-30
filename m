Return-Path: <linux-rdma+bounces-22588-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4y2TGi6pQ2rjeQoAu9opvQ
	(envelope-from <linux-rdma+bounces-22588-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 13:31:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FF46E3A0E
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 13:31:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="O46M/BGr";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22588-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22588-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBCD93020862
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 11:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9923FA5CB;
	Tue, 30 Jun 2026 11:30:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702293672B3;
	Tue, 30 Jun 2026 11:30:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819032; cv=fail; b=r2iucLdUIPNiXwXEiURudWi9eohHbgc+9a8b/man2mAmASkLJQv1CIuxt+Vde/AEbE9ltaSqMQGPdIvjd7F5pGfuR+AEUy8dxrcHcogkZsB3QLN+VGoy2Dc75ZVcj42zVwlmFFsAIlpI5dhnUeffXk3vFKIMvCPecIq6IaEcNFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819032; c=relaxed/simple;
	bh=ySt8MteCmQ+NCcfI4HdfhRftL0JffmIE+50K30Ny5wA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jVzWMyxjUiZtF55uVocqBkcJGYvMxgkr9cDlpais3SY639ewH5scMCm55YCyTRBYF1C+KDg90zzcFdxEIpPmprIVCPFxujG4Q7FYg650nhq1LVC3hrq2zwuKWnyzOSCIEWUBaeU7glmFN/hwvXdhRjR1qBo6BPc5xgGrrLOwC1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O46M/BGr; arc=fail smtp.client-ip=52.101.61.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gG8IzGf+fd2F3uVIGs1ygS2LkinffQgMScZYrk7UXwLhdyMVjzUTFYLzTLu364modv+hzmYyoBRuOuzommLDJ6cVaSwI1X0M+ZDMtFk5cezGUYNv/BJVw5Xyv/j8qC7Cy4iPYDcA1uWE9fBnksdnbUGPh04mTySYdy1GelDaL+bYdCXDzok49/eQzPJEOvUsv5QzmHXM6dz1j7QXtLVigk6ImmL1YZUfRQiBIyaeLpIca1d6spjO4rLjKwN+cQI5X9ERp2AVurRouWuVrm25BdHsNmtaWwx2ieRV0wd/Zrx70vgWMciKrO/q0+kd4KEZRcpguYQ6vUVlHsMJsGf79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAdBh8xuUxypB5ivHp12yHwhV0ht2I+Q2wxqZAvMxo4=;
 b=QV3pvMHT8ZnCrmPUt/bpfKf47RZCxs5IRsNfIuk8/SFNaXFDBOpvGvxQWMi+w8j8t5d06NR3dk4P2v1EzzXEdeFW4xHCSDEIiuw8jnRBIwG2c63BZzzWXzP6gGzizsYiiLvVK4otUH5VCcHXMcgRpvPloOHBO2xUjmOJhoD7TGn70jNz1dB0NP9vFD9+j7NCWDXnKvHsGPDi8k8DlT7JtPELjJ4tvPtg4gWMqeeKj24D34PENHtpBQxfcMcSG0da+wBx0knX0fwcHQVU4qD/nwzVj/JO8tcgspaRk620z6d+RN5TBEq7rwKhQv90Ga5NRc8RvLb8QFNYoaR2bEOzgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAdBh8xuUxypB5ivHp12yHwhV0ht2I+Q2wxqZAvMxo4=;
 b=O46M/BGr9AW251gyUpxDgkUH1I4E5WujdrDU3AURkoPzDNBKPqynt6OYJzQaA3jUe7HaxP+AtrT7LUkSKLZAaLdPkeu+VidRxwoUrzgU0NDr/pPdmnV3PvJmbeKNJCmwdko8IA8gZDyBcM9rmFJg9FnJ1Ju6qpyR+8VTnBr22LPoZ8K6oJuwCxNE4Ho2+XERdm0kO0lHF1eeDIRONMtxJs4YR/SY6LtnJ/6+n4dHCPzYqpHxAB3Dktmcg6Z2pDV9SxMg8h9jbRs3yLPmzbR1ta3LC+gPxzesZ2eJ0jR3MZCfehhpoWsAY8zVeJ2RW0ocUqdqxKKOh1NnlnyuyC97pQ==
Received: from SJ0PR13CA0055.namprd13.prod.outlook.com (2603:10b6:a03:2c2::30)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 11:30:27 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::3a) by SJ0PR13CA0055.outlook.office365.com
 (2603:10b6:a03:2c2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 11:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 11:30:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 04:30:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 04:30:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 30
 Jun 2026 04:30:03 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Edward Srouji <edwards@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Maher Sanalla <msanalla@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Rongwei Liu <rongweil@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Shay Drori <shayd@nvidia.com>, Simon Horman
	<horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 0/3] net/mlx5: LAG bug fixes
Date: Tue, 30 Jun 2026 14:29:14 +0300
Message-ID: <20260630112917.698313-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d6c889-e9e7-4d52-073e-08ded69afb57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|23010399003|18002099003|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	r28AIfXWFXNGuv5FNRNNTunCzzZfQV6hqg4F+LFk8JJpMktrPJ7AtsvUOPfOAswFn1X7UEvgnZfQ+XDZ2yCyhisM89CEN3u0DPCU8STjQZrkfJvTa2mj85f3XFKzaMAtpPB/sAIy5eTwr5W3/Odse7S925zU6iLlSUc2cshKFkyZn32L9pzZtNryq3c6G0yMAto6c+k+qIZlAzJ+qW2rdT6qy3+2T8WPraWfimVrB24fFw4BwH736Huu/AR5nLpAmhu+I39J06V9eA5EHz9r1FSyXChyRjQL8Na/j8ORtqHPWd0+j9llZolpnMOTDVc6XxjM7z3n8+l+W5JjNnPKbkwG3gXpEfJg55Nw3Ov5yeBM5TBH5LQUCHc2+lIgA5cbl82QS4GOqJFxej5xM/clzHvmAOKFHvhWHoo17sn8ph0to/Gz6LsJXYzA8ptTXkAIBInWIzJXgYP0sbEehepH0VCSXTlD76Io6rIXYbTjDt575/l2v6CRd4UhW/at/aj1WDDbEiHNlILT9xSoMSORHCO+jXb9pVhNql2Gm37Wur4d6DvcMAg/f3kNPr7T4YkErfEFfjn9aRkQGKsccl67ew8Ft8D8TVTOjdWrRl/7JkjjQXfcGFvUlGMnuTbOXUDPzB6Gs9ZbNKB1zYhEMi3wG3umZtR3qr3GyqnZiHZx2z78kfUR703lBFFyrtb13hGfwWfUkyiESSaI9tDNcHhmnw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(23010399003)(18002099003)(11063799006)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cILhqHBgRlADE5iB5uIXjQhKYx+c8XUo6sfIkH5mT/J/rVdu13Be7ogES3pnNqvQzcTMYAJB4Byey+R2RTppWjjh2Zwffwz6W1b8D5bt/D31gFcFtasFsmcGzec7MJyHXvPF0T4GkOkx6dg96Q7gIl8kd7rQuuciGCAuku0FNlH0TaJs9rMYb1UqmpnGAUGQ1TNvIWuGIo5WzGaH8w7C6KH5LEml6jlxUK/XGEuwdKf3fP59XKw7bhbFOqSEXJteOAiBguymf+eZYIJhAvnus8699l9rDBD85SFIuLtg7Nikn+XoZN9tdLlzsN/ZvkjCGH+Lauid5BPsawhJx06A3uMZMqiXvMOZQoQEeAXFJ1LSHXZxwdvDLcDdkB8Cs2Q0oYQe0TgPGerHoT1e2LB6NLCzUfj6uNbuaFYGWkLLx98YLVpCIDBo0bLut9OfFiFc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:30:26.2964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d6c889-e9e7-4d52-073e-08ded69afb57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22588-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:edwards@nvidia.com,m:jacob.e.keller@intel.com,m:kees@kernel.org,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:msanalla@nvidia.com,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:rongweil@nvidia.com,m:saeedm@nvidia.com,m:shayd@nvidia.com,m:horms@kernel.org,m:tariqt@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0FF46E3A0E

Hi,

Three bug fixes by Shay in the mlx5 LAG subsystem.

Patch 1 fixes an off-by-one in the error rollback path of
mlx5_lag_create_single_fdb_filter(): the loop started from the
failed index i, potentially operating on uninitialized state or
double-tearing-down an entry that had already self-rolled-back.
The rollback should start from i - 1.

Patch 2 fixes a hang in mlx5_mpesw_work(): when
mlx5_lag_get_devcom_comp() returns NULL the function returned
early without calling complete(), blocking any caller waiting on
mpesww->comp indefinitely.

Patch 3 fixes a kernel crash during teardown when
mlx5_lag_get_dev_seq() returns an error because no device is
marked as master or the peer is no longer in the LAG. The peer
flow cleanup is now skipped instead of proceeding with a bad
pointer.

This series by Shay fixes three bugs in the mlx5 LAG subsystem.

Regards,
Tariq

V2:
- Rebase.
- Patch 3: simplify to a single 'continue' on seq lookup failure.

V1:
https://lore.kernel.org/all/20260617063204.547427-2-tariqt@nvidia.com/

Find replies to previous Sashiko comments here:
https://lore.kernel.org/all/e18662ac-413e-43f6-ac65-a4e15fd47bb7@nvidia.com/

Shay Drory (3):
  net/mlx5: LAG, Fix off-by-one in single-FDB error rollback
  net/mlx5: LAG, MPESW, Fix missing complete() on devcom error
  net/mlx5e: TC, skip peer flow cleanup when LAG seq is unavailable

 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c          | 3 +++
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c      | 7 +++++--
 drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)


base-commit: dbf803bc4a8b0522c9a12560c20905a5952d1cb9
-- 
2.44.0


