Return-Path: <linux-rdma+bounces-15965-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGDQKXD/dWmMKQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15965-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:33:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2131980414
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DE7E300145B
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 11:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB05319847;
	Sun, 25 Jan 2026 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ssqimojS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEAC1D88B4;
	Sun, 25 Jan 2026 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340779; cv=fail; b=C+8bNp/03TdL4LulpYEFdK7zliCPDs60EV0iCH8vJmLHq36xqAW/N9nGd64fZnR/nqfVV4jnhXxFNS4M7lAUKSAF1OAPYun73Xw5aoDVbYRh7pYNtbtgn8U2M9ISweHC5k7GdKRaCDcIgKaLolEZUU6juF5xQX40NIdiRk8DJp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340779; c=relaxed/simple;
	bh=SixM0S8dj089ipMBzvHuNO0x0uFu/e0Z/G1TecCCsdA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pJeRZbLl1MWqSyRkNcwzPMbzAJHQgg/WIkG/87dOPBTOCda5Ta93sp43l7KZaXFOMnHVsp3A+N385pGi5s9Ma4xrh6X0JRdlctG+sj8Y/oO883cWBJP8F3e7jSCBjCmPt1XdK5sb7iUB0CVLGVhapQk2IIS1zu4zZeV6rCqNZqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ssqimojS; arc=fail smtp.client-ip=52.101.48.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3G3ulLSjNDQCUg94tbKcTuVO78p9Fp54Uz7KOum5dWLWhIUmZ32sV2E72VEh3NjiEG391t5BXFjv4thlTCRI+zjLq8lAxe+EqqS9EjO0D/9+L5f3WRMqd5weL/eSo0WnspkAO/Z5cE7EYMllTGGjVwSDIbL41u02sDvQX7u/xMT2bm6UrowCV4Gn0bW8ei0D32BnPMvQILdiRc7n0ZHXtUm2J/3HuEVmIxfN5EsUzdLwP052ahrci7Kso5qHqxcQlWzW1vgLhBmKjMci52xlvwEwQO+lpu2PKjF0x3wj8j6s2WG7caMNXTzPRbcu4o5VdINFpC7xAjXN1jSGVpl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KYUNjEX2M7+evT4u556zHqvVOIfB9aLc8PlatASMk4=;
 b=BarOkHNZH7nx5o8n5xLALfIKTXzbari6NwxqnWyGFWuVyTMKgwuQHOgMUXBqFb85SJDTsHtLS0UIlZhRSuDJrJ+B8lCGIwP6iFmsEV4o78baU/XToKk3/5I+y4dOpx/egNY213D1P3ZWFYGbhSopXf8zV4VHlKhpd+rA/CqE1x0baW/IGerKuTfsXaHBalktXhHHqpihuRaRpfancDUwchbAzguYS6/QnQCOPhzWknkvav6ycGXaDCCS5pA25Fh6DWNwvFK52++XjFn36CqY69EPawai713wpR2ZP+O7yRa4+7cVNGAVFZCSuB/ZFSM97LtD8XVymPT7LrONgyFEIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KYUNjEX2M7+evT4u556zHqvVOIfB9aLc8PlatASMk4=;
 b=ssqimojSNi+uESufsK9PsJ1JR56ljmncdwn47xnpkcMeEdkkUCor5nHNgeDyfSGt1qHZBBJkhjn3ZOQRcue4bt1SESgmoaY8eOVHmOLbuWEYs7GfYzCM5HWoPSAIiBgcqNFonYp3WksqjVAS//PbAsae1lHbofJ8Y8ah5l1UfYYlxpHMp+0Vtny23+jw1IKhWcr2iAX0gFD8mcUYIlT5bAt3Go4coA1b7v0Nex3Xp63VIpWebm14HqI/I+6TFvXWrbpaRX8YhRlZZgfzSHh1Etws5BGYhiioi5z3j2Mm0cNHcno/8Td9iVCm25dvoJ/5Z9R3n1NJOBKY+x9nhL5Ecg==
Received: from MN2PR06CA0027.namprd06.prod.outlook.com (2603:10b6:208:23d::32)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 11:32:54 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::b4) by MN2PR06CA0027.outlook.office365.com
 (2603:10b6:208:23d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Sun,
 25 Jan 2026 11:32:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 11:32:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:32:44 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:32:44 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 03:32:38 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V6 00/14] devlink and mlx5: Support cross-function rate scheduling
Date: Sun, 25 Jan 2026 13:31:49 +0200
Message-ID: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 191d6d63-47de-4ecf-01cd-08de5c057b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|30052699003|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UB63sshcQmudHgGSBzQu3vAA3jEKv+FRO6nuFdp5fjafNN94sEirUSMhwwAU?=
 =?us-ascii?Q?uTmGkixUQdkHgxcAqUnLoVK4FUUbB+h1vgOWPSEmrxPLEM0xlmsFoo4Nn/Ip?=
 =?us-ascii?Q?wuNvqsCtfBWnt8FiDw8yDmtXlIL8ENms6xpdogIWWn57oJh75+hPwoZcjCfy?=
 =?us-ascii?Q?G2b3umN/LUEB4y1Suc6Q0K0i0miscABTnOPw+D/X0ucqYZydENg/clhG9NSS?=
 =?us-ascii?Q?DDSl46BpWGZD0mKpGiw7zvHg5CTcKCHmKJqLJAu1mEvAi+OQQazhAptJdp61?=
 =?us-ascii?Q?9X6VQ0+n1bxQkhbWr7+WvHRDL3zm7NaeskaaI9lljpYCDVfFDHI02YHDvPK+?=
 =?us-ascii?Q?XRlSYB8wj0vEpF0ant3cCHmeEuqlswPouX0v8i+m6WVlhSK3nA7Ni90SKf0e?=
 =?us-ascii?Q?UzKigu0OqFRVSmsY0VusL2Eut8kxQUZtLvS1NgFAD8QrbeXCbwfcsKEFzYXk?=
 =?us-ascii?Q?joI1UvlD/5Ubaqih+ZFriuHlamMsfSUDbVIiq+JAzqsrUs/J4ax1z0mBapDF?=
 =?us-ascii?Q?m+eGTB/cseYDW5PelpMe2hx3E4FxgDwoyVzdBlcuIuX1sZ9HpzbOuypfmfW+?=
 =?us-ascii?Q?qqBJPt0qs5ybi0ZT0gtWMH5N/+mEpGHjdAq0D52XRJw4AoWKKgPqR+dyVS8/?=
 =?us-ascii?Q?7npI8iSs87XOGx6L5KHVDYMfIOizjmIZPLj/Ou/i+9zkOZ9usmuCLmTXh97J?=
 =?us-ascii?Q?HaH3GM3LWOOHzVuuM2liyZUzIgkzoYu3r0wptThu6AWf9LGaft52RAZQKXsk?=
 =?us-ascii?Q?yxiiIh/NFGcF4mS/h7g8UUvlZ/FxpiFW+tgi5v6xNxB8vaQ7GbUZ82xs7BZe?=
 =?us-ascii?Q?cz07ILr8zrkrx5XZ8OTHLsbYAdzhNU65jV62foig7KHo9eCgUFmua72CtdOX?=
 =?us-ascii?Q?2d2k897aiUh47vU78zS2Xr5zIjph8i97kHNW0BkAZh0lqzzwFWJnhAS0oQVr?=
 =?us-ascii?Q?q0E9UL9Cy/y9/n48/E8hXg7OxWVGQB5O3JNCi4T/oO6CKYUPr0v/SNwfeuSK?=
 =?us-ascii?Q?6jSYfdseu/eosNsMiw9i0u2e+B6ILU43jxA51PsLCCQ7QUxuST5KTjK0D4du?=
 =?us-ascii?Q?SdUbocp+iagpVgkFYjm/6g8DY+NNfe5/zOy8MteBfTIUgH6RCYDIDGPSaA8U?=
 =?us-ascii?Q?xTgTUtx6R4HzjoDsKL9vQ3GBiCe+/q6oZLxyo5VT6x6fHZfAJZY/spiuM/Eb?=
 =?us-ascii?Q?2gPZ+1SCPl+RAxsAhBig2DKA7X8L34kqc0cUuB2n6dEqu4/oIvUeHs/HS5IW?=
 =?us-ascii?Q?Jhodp7TvDREl3bBMHU+fGpsEeNXxGY7EExDYw1SyVSOVgxAj3eDudZLi3vZZ?=
 =?us-ascii?Q?8yavqqAhOEH2f5X1Ikw2gIag+unebwy/RIwtaf93dfsYMiaoz7kEG2pTaidH?=
 =?us-ascii?Q?4f64oHos+ImAjbNWVDCOeosQxJ2nAwsvTAyrb/jFMS7WfdSPX/y4NyNUpIH3?=
 =?us-ascii?Q?s+RwuzxKzReDwcgFcCf1rSV2Z4aAO87kbx7rlcvPCXTSC0iRoWnRqTaEGsj9?=
 =?us-ascii?Q?MbelZn8ESPT17Una8p35rnBSslHWUgzgrR/BKHIcUPhTBKFCwjvY4KuajbEV?=
 =?us-ascii?Q?8CwIXtg3EFYA1LrSe6X/pil3858giQBweFJFOob+AXPz1AKrrzT9WUnGwv9m?=
 =?us-ascii?Q?LqfVm+8QRnb8Esi03BfvtIceQj/AS5fhlvNCc8gMuduB72McXb63vyZ3qHKO?=
 =?us-ascii?Q?fftlYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(30052699003)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 11:32:54.0310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 191d6d63-47de-4ecf-01cd-08de5c057b0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15965-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2131980414
X-Rspamd-Action: no action

Hi,

This series by Cosmin and Jiri adds support for cross-function rate
scheduling in devlink and mlx5.
See detailed explanation by Cosmin below [1].

Regards,
Tariq


[1]
devlink objects support rate management for TX scheduling, which
involves maintaining a tree of rate nodes that corresponds to TX
schedulers in hardware. 'man devlink-rate' has the full details.

The tree of rate nodes is maintained per devlink object, protected by
the devlink lock.

There exists hardware capable of instantiating TX scheduling trees
spanning multiple functions of the same physical device (and thus
devlink objects) and therefore the current API and locking scheme is
insufficient.

This patch series changes the devlink rate implementation and API to
allow supporting such hardware and managing TX scheduling trees across
multiple functions of a physical device.

Modeling this requires having devlink rate nodes with parents in other
devlink objects. A naive approach that relies on the current
one-lock-per-devlink model is impossible, as it would require in some
cases acquiring multiple devlink locks in the correct order.

The solution proposed in this patch series consists of two parts:

1. Representing the underlying physical NIC as a shared devlink object
   on the faux bus and nesting all its PF devlink instances in it.

2. Changing the devlink rate implementation to store rates in this
   shared devlink object, if it exists, and use its lock to protect
   against concurrent changes of the scheduling tree.

With these in place, cross-esw scheduling support is added to mlx5.
The neat part about this approach is that it works for SFs as well,
which are already nested in their parent PF instances. So with this
series, complex scheduling trees spanning multiple SFs across multiple
PFs of the same NIC can now be supported.

V1 of this patch series was sent a long time ago [2], using a different
approach of storing rates in a shared rate domain with special locking
rules. This new approach uses standard devlink instances and nesting.

Patches:

devlink rate changes for cross-device TX scheduling:
devlink: Reverse locking order for nested instances
documentation: networking: add shared devlink documentation
devlink: Add helpers to lock nested-in instances
devlink: Refactor devlink_rate_nodes_check
devlink: Decouple rate storage from associated devlink object
devlink: Add parent dev to devlink API
devlink: Allow parent dev for rate-set and rate-new
devlink: Allow rate node parents from other devlinks
devlink: introduce shared devlink instance for PFs on same chip

mlx5 support for cross-device TX scheduling:
net/mlx5: Add a shared devlink instance for PFs on same chip
net/mlx5: Expose a function to clear a vport's parent
net/mlx5: Store QoS sched nodes in the sh_devlink
net/mlx5: qos: Support cross-esw tx scheduling
net/mlx5: Document devlink rates and cross-esw scheduling

[2] https://lore.kernel.org/netdev/20250213180134.323929-1-tariqt@nvidia.com/

V6:
- Really stopped using __free (Krzysztof Kozlowski).
- Fixed incorrect state->idx usage in rate dump (AI tool).
- Merged patches V5.12 and V5.14 to close a bisect bug (AI tool).
- Link to V5: https://lore.kernel.org/all/1768895878-1637182-1-git-send-email-tariqt@nvidia.com/

V5:
- Made parts of shd generic devlink infra (Jakub).
- Stopped using __free (Krzysztof Kozlowski).
- Moved some generated netlink in the correct patch (Simon Horman).
- Addressed cleanup bug (Jakub).
- Clarified uses of shared devlink in documentation.

V4:
- Fix typo in documentation (Randy Dunlap).

V3:
- Remove mistakenly repeated devlink interface in docs (Jakub).
- Add Jiri's review tags on ML.

V2:
- Rebase.
- Add Jiri's review tags on ML.

Cosmin Ratiu (11):
  devlink: Reverse locking order for nested instances
  devlink: Add helpers to lock nested-in instances
  devlink: Refactor devlink_rate_nodes_check
  devlink: Decouple rate storage from associated devlink object
  devlink: Add parent dev to devlink API
  devlink: Allow parent dev for rate-set and rate-new
  devlink: Allow rate node parents from other devlinks
  net/mlx5: Expose a function to clear a vport's parent
  net/mlx5: Store QoS sched nodes in the sh_devlink
  net/mlx5: qos: Support cross-device tx scheduling
  net/mlx5: Document devlink rates

Jiri Pirko (3):
  documentation: networking: add shared devlink documentation
  devlink: introduce shared devlink instance for PFs on same chip
  net/mlx5: Add a shared devlink instance for PFs on same chip

 Documentation/netlink/specs/devlink.yaml      |  22 +-
 .../networking/devlink/devlink-port.rst       |   2 +
 .../networking/devlink/devlink-shared.rst     |  94 +++++
 Documentation/networking/devlink/index.rst    |   1 +
 Documentation/networking/devlink/mlx5.rst     |  33 ++
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   1 +
 .../mellanox/mlx5/core/esw/devlink_port.c     |   2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 332 ++++++++----------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   9 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  14 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  17 +
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  99 ++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  14 +
 include/linux/mlx5/driver.h                   |   1 +
 include/net/devlink.h                         |  13 +
 include/uapi/linux/devlink.h                  |   2 +
 net/devlink/Makefile                          |   2 +-
 net/devlink/core.c                            |  48 ++-
 net/devlink/dev.c                             |   7 +-
 net/devlink/devl_internal.h                   |  11 +-
 net/devlink/netlink.c                         |  67 +++-
 net/devlink/netlink_gen.c                     |  23 +-
 net/devlink/netlink_gen.h                     |   8 +
 net/devlink/rate.c                            | 290 +++++++++++----
 net/devlink/sh_dev.c                          | 163 +++++++++
 27 files changed, 984 insertions(+), 299 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
 create mode 100644 net/devlink/sh_dev.c


base-commit: eac026ff97a9447d34113dd7c4adbcd185185142
-- 
2.40.1


