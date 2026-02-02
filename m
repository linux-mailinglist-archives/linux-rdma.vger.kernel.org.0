Return-Path: <linux-rdma+bounces-16350-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGcjHy3MgGl3AgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16350-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:09:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D75C9CEB1B
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8796530F023D
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5724272E6D;
	Mon,  2 Feb 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JJLQNy8F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB3D37BE79;
	Mon,  2 Feb 2026 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048068; cv=fail; b=XprB0G4/M2oW4EUezzKkl9tvFmottYqo9EDpEYSxxroiiW+o6tG/VMd74GQrIkgHxambuRBABg1mgq0eSfmhv1YPwrcLOsyxR6NVmhPMVcUtC7XcH2wbGPIEI/Llb1LpNkGGcA7t1KC1hFsmHp1O1nJ6BDQE/2m0JL9M/TXtn2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048068; c=relaxed/simple;
	bh=OFY72tFW9W+Ax97D2Oju1BAuiDzJUZqeiEfdgDB9cbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=s5DxFkdbNkkuvWt4x+9IrpYpO2KSSpGtLAl3/gHaHlSBCwii68TKyq0hviuiIIOZTaTvI4guwOuDUDUnnlm99XE2cys+bNtAHhnfEmPc4QwlZrFOSEaXQZPWqrf+vt77e9yRZC9rH9yjY+TegY/vj4plMr+At1F0lq7xtC2FaA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JJLQNy8F; arc=fail smtp.client-ip=40.93.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/GlVsJ66/ZETTu116tD/9cKwIT2x8MwMKQdXEx2VXT4raXtsTYl7Pfbm5O1fEPY3Oifg6Ce/5cqNmFR53sPPocKd3Mn60dfI51SeygTYXAd80/5fqheSx7HNSqaRKwsU5gYfKOkXfa4zduUW76b6P8fTNsFKJ/rOiyx9s2ZluC1vjPNXscahaGcjoCeKG9O3FxaMM5iWiEoRajF4SpGtMD/g2xXjxYgmRDhAFABxaSR8e18mAZrA1v107yFN/Sd+PYtIKyij5mbUZKjenx56Ly7Jjf15cdC8jQs/N5iFRlB5AX1NPsCCDiVw5VL1Q/pj56oasBGweDpJgsBeS/6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uTjLOHW6Z+Kg0kBWb5qFx2aGtanIa5Xb0lClCcFOCA=;
 b=M0N9B9f4LJTQN4U9NZ7iTEAGFFABm4cYjgobABfgubQXNhOe2b+GfMxGqjeFPq42iGw50zxolQ87vd1x22zPnUq6ZPQVQrudeLXdshI1HKiLG9ZGIscAp1m4gKBpzMpTzRtd5dJ8zXBZzaqtSL6yw21Fem82SK+VgxOOX/7GmeO+sBFAPMMn7ideb+NGEPjcly2hVbuWL4cyMw0DTEfJbe+oWfEPSIpZ13KiDjlWSoFCeU+LqXtV/vPnaz4iv9PWtiVZ3iogFfhiKxuY97FhTDh/1m2DT1tM2oU6uho/Si3HymIQDXNaQYMPmWgGoM/PlbyqpmXLNJmZvqAHyyv4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uTjLOHW6Z+Kg0kBWb5qFx2aGtanIa5Xb0lClCcFOCA=;
 b=JJLQNy8FEK4KvVMdolm4ZUPOxCafqBnao8STiaEpTOl5CvJY6/l36dsZYF5kRtKCTZ0xg+c/udyyKdL+1JmzwRsmlF4M5AbbZx0w6QH7e6VTo4CP2iABtnjHlwdxYswzir9Qb6dGM71Zuvq/9K2e6h9A+CseJlnc+n0ES46S9RJY0+2or79Mek4CGnydas6NR5MmEDZkwk0v1ILxufhHaSRb9iZmsU/633s6K1p59yTvPiBwe6P/L16TB0EAx3JVl7LiECJEu1OHR8GJJdWTEA5Mb6u9G04trFL5JXb7aZ13Bzfv5AIPrbLDfgt2C6onxhOr6qpmAxoz/AB7Kd0YeQ==
Received: from DS7PR03CA0157.namprd03.prod.outlook.com (2603:10b6:5:3b2::12)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:00:55 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::a9) by DS7PR03CA0157.outlook.office365.com
 (2603:10b6:5:3b2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 16:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 16:00:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:25 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:25 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 2 Feb 2026 08:00:20 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 2 Feb 2026 17:59:55 +0200
Subject: [PATCH rdma-next v3 03/11] RDMA/core: Add aging to FRMR pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-frmr_pools-v3-3-b8405ed9deba@nvidia.com>
References: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
In-Reply-To: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770048005; l=6921;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=WS4Ew6jWefPz2eLqxW8q/rRh7YDQEAXpuVbUOSCZJcQ=;
 b=SMl4IQu8bSTyW3BHOUiaZbdoUalNGGTKAYZLFNNZYQk/tuS6uHmS1uxXhTUBnJWwfWXtHtYZb
 DlAiFxJVCM4BhVaU3zeaAW1zGKGwCERmCyOgyKoLE5k7Iwx13hjtwpq
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3cc80a-97e0-497f-3263-08de62743f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bndLT2RjaCthVVdwSWNLMStmZDA0YitlamkwN3p1dkF2dmNmZVBxS29yMGlQ?=
 =?utf-8?B?L0gvRUdwdFJjdndOT1NQK015Qk9Wb2FWSWlURVUzMTBiSXNObjdrU0NJUWJa?=
 =?utf-8?B?aVBOdVZuWVhNb3JrRDFHTDlDVGk2TlF5M29nZWhRL0NVU2ZqbEdBenhmS091?=
 =?utf-8?B?RkhGZ0piWjZQOFlRZGFDdUlocjhSeTdkcmtuakFPZ1FhWTA3MnNQYnkrKzQ2?=
 =?utf-8?B?N2VXdjRBVmxVMkwxWjBrd1NIaU9Welh6cXZ4T3lDdnVDbDZEVEFiT0ppVTdK?=
 =?utf-8?B?SnJ0UGwxYW5YVDR0TmhydWxIT1diV0gxVUFFeDRlbWNrd3J0UkIrY1o1YzlO?=
 =?utf-8?B?WHE4cHZDTkN0bEpMalp1VGhZTzV0clN2a2Q5UnZEU2Fyb1R5RXRWcUNCbkRW?=
 =?utf-8?B?MXZFMTRkdjkwOFErUkRyRmV4N1BtbEY4blJtOWpvSzdJSHptZUFROHc5Ym9C?=
 =?utf-8?B?ZnliUU8zZDlsOFlZK3plVVA2MVJ6aTI3YldzUHdmODdYVnRMTW15bzJhYmwz?=
 =?utf-8?B?UVJTZ1ZLTjFxbTBmVUNIK1R1WGNoVzhXQXEwMTB0UEVRcTlza1YwcVV4RVhl?=
 =?utf-8?B?SVVzR24ydG9oT1FiYm1TSHdIcnBnbDVCdzJCSThueHdad2NhZ1o4YlF1UnpH?=
 =?utf-8?B?L1c4NUhsSkdOc0NVRTlZanlWMTRpVzdjMmRLZTUzNUFiRS96SXpPRW82T0pL?=
 =?utf-8?B?ZVBHZFpEaTQxUTdYREFxZDIvTUc1SEJTVEg0Vk1YTEFBNENVVUs3Q0MrNUVM?=
 =?utf-8?B?d29id0lsa2hadFZuaTByalNqNHNnL2FLUXI0bG90d0RDNW5uSGx5UDVRR2Ri?=
 =?utf-8?B?UGVEQ0xrWlJKcERabGJDb3c4K3YvV1hpS0FsWUZwYkZFZVhHUzArYzdaZ1ph?=
 =?utf-8?B?V2Q0ZFFBeXVWeUo0U1pIcVg5dWFGUG9vQ0U2Q0ZCQnRJSXgwVW1XMGY0YzhO?=
 =?utf-8?B?UjVmOVJkaDhvY2pBR1U0QUttZjlYN1JwZUhFTmFGRXZsaDJuSkhyWDJZbDBD?=
 =?utf-8?B?d1M5NG5NR0E1UUZrR25XU0pMaWdZaTkvd3JwMnhRWENseXpvQjZqNm8zMXFU?=
 =?utf-8?B?VlJ1NThPVUZ2TjBXZU5ZblRjZlJ3c05WSEJ1MWxGcXllNnFBYVZkNnlaOGpV?=
 =?utf-8?B?cXQrTm9KVG4yc0NNaGpaMVQ3YmZNL0VTVWFSTzlkSGQ3bGtseXk2Y2JDRmEz?=
 =?utf-8?B?c24xbndjYVdOUVhDSVg0ZFFJbFpuQ0NZMjJIWkZ0QStSMXlqbHZqenFpSGJz?=
 =?utf-8?B?cTV3d1Q0blNHUG1rZUVEZEE1NEtCc3M0Skk2QzhHQ3FIalJZaGNlQVRWNmJr?=
 =?utf-8?B?aC9WK2Y3WHNqaDFTRWlEOG0yRWxwcjkxSmpwb25xYU15Z05qdWJuNndobEpP?=
 =?utf-8?B?ZTJucExlZWdYYXB3YWVIZU1HVmZzVGZqY2xFeGoyYzQxQmFqZ0Y1ZXBsK29W?=
 =?utf-8?B?YWVaYTU0UDNud1EyRUdiQjV6S3dIT2NuVmZ4NGx1SGs5RDhnSXByNVg0YXNo?=
 =?utf-8?B?VnZCaWVSZzB2UTFFdFgycjd2NHhadnFGeWZTaEE5L0lUUldsTlhOVzVzU2xX?=
 =?utf-8?B?dFZVeVZxalFnTFZUT1h2Q2lnbllwQi81cmhKZ1M4QnlUNlducFFTMUt4NkMx?=
 =?utf-8?B?eDZsTlI3VnFuMlFlNDZoL3hUR1NhdGNOSG41dVJyQU1rVG9uSDdQVmtKKzJn?=
 =?utf-8?B?ODNjYXJqb09ocEh6N2UxQXg0Y2tOUFpsQjFMQ0NJYm5GNmtRa1djWFQ2TGxU?=
 =?utf-8?B?OURrSzgxL2R3OFEvbXgwRmoxYkdYSko1RVRacldmS3RRRXNjWkMxNzRPTzJC?=
 =?utf-8?B?c01JQS9nQzEwcGhIYkZVeXN2Uk5WN1VrY1Z1aW5QOERFcnRBenBWQXpzeWhC?=
 =?utf-8?B?dlNBT3JJdk1MS0o4MXdoNzl1d0t4VXVCdnlhZ09QdlhuZVFmcmRrdStQTUZX?=
 =?utf-8?B?RlF3dThGRUovVmlVUkJrc1pTVWdScEY4UWpnemoxTDZQZEo2UE1FbmtVV1BK?=
 =?utf-8?B?Z2ZoZlltVUx2eUxwbWRCaGRodE9yaWtHakhURE1jNDJQOENpT3BwdzJTYkVp?=
 =?utf-8?B?OXdQbXlheXZSRjVjRTBFWW1iZjVHYXpvL0xxU3ZGNGNSMGRTVDNBTXp1NENz?=
 =?utf-8?B?UHRrekdMcWY3N1lJSVZRa3M4WU05eDIxS0haQnBTTUU5UXl0akx6TkdiOXZS?=
 =?utf-8?B?YnJXYitYeEk4MFArR0J0cmdNUklYbUhsV2t4T0ZEWkRtT0dXVytUOVJiMGtK?=
 =?utf-8?Q?6bEmpp8jZVHrZOQl5O3Iqifd9M84NSsfsRvNKwu6mw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xCm3VmxaMqO0vzXC+cSe3YvO4X1jk2he3H43anz7PWTYBN2ZNh45geb1QEO2i89q2E80kIhXgbwJ6hPIcaXvSUVVvGSIKnfMYLUehFmMA7dxmVJJOx6uW9jsPAJCBM8VBFVDvocYj3YAg/FsA+uOpCdV8ZEzWZ1V6iFwn4z0WT5d6yKpgXR2muEsSl0BjHuDkPSKjLeKYT/LX7DHoRSaeKqb1JaErXOFzGQ0hLaO3RP2Y5c+ki3pMxhrhu6wOFuOay0dxZyme3lMk2oaKBRZPIg2xZxJRXZfoRDLAkFv9f5dvicoxvTvexjxco0Sc/1i6LgucmF5TKgLWEc2IcWjGBqyg+aqkxA2RvYE0p45j8d027zPHdfg31ro8vdZoe0VI188aSbJt6/Wli3/fifCbhcYNpQP4rETgmk05R8ly1WJL9MdXght8+USOj0PxsQ9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:00:55.1621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3cc80a-97e0-497f-3263-08de62743f67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-16350-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D75C9CEB1B
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Add aging mechanism to handles of FRMR pools.
Keep the handles stored in FRMR pools for at least 1 minute for
application to reuse, destroy all handles which were not reused.

Add a new queue to each pool to accomplish that.
Upon aging trigger, destroy all FRMR handles from the new 'inactive'
queue and move all handles from the 'active' pool to the 'inactive' pool.
This ensures all destroyed handles were not reused for at least one aging
time period and were not held longer than 2 aging time periods.
Handles from the inactive queue will be popped only if the active queue is
empty.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 84 ++++++++++++++++++++++++++++++++----
 drivers/infiniband/core/frmr_pools.h |  7 +++
 2 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index eae15894a3b2..c0b2770df8bf 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -8,9 +8,12 @@
 #include <linux/sort.h>
 #include <linux/spinlock.h>
 #include <rdma/ib_verbs.h>
+#include <linux/timer.h>
 
 #include "frmr_pools.h"
 
+#define FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS 60
+
 static int push_handle_to_queue_locked(struct frmr_queue *queue, u32 handle)
 {
 	u32 tmp = queue->ci % NUM_HANDLES_PER_PAGE;
@@ -80,19 +83,58 @@ static bool pop_frmr_handles_page(struct ib_frmr_pool *pool,
 	return true;
 }
 
-static void destroy_frmr_pool(struct ib_device *device,
-			      struct ib_frmr_pool *pool)
+static void destroy_all_handles_in_queue(struct ib_device *device,
+					 struct ib_frmr_pool *pool,
+					 struct frmr_queue *queue)
 {
 	struct ib_frmr_pools *pools = device->frmr_pools;
 	struct frmr_handles_page *page;
 	u32 count;
 
-	while (pop_frmr_handles_page(pool, &pool->queue, &page, &count)) {
+	while (pop_frmr_handles_page(pool, queue, &page, &count)) {
 		pools->pool_ops->destroy_frmrs(device, page->handles, count);
 		kfree(page);
 	}
+}
+
+static void pool_aging_work(struct work_struct *work)
+{
+	struct ib_frmr_pool *pool = container_of(
+		to_delayed_work(work), struct ib_frmr_pool, aging_work);
+	struct ib_frmr_pools *pools = pool->device->frmr_pools;
+	bool has_work = false;
+
+	destroy_all_handles_in_queue(pool->device, pool, &pool->inactive_queue);
+
+	/* Move all pages from regular queue to inactive queue */
+	spin_lock(&pool->lock);
+	if (pool->queue.ci > 0) {
+		list_splice_tail_init(&pool->queue.pages_list,
+				      &pool->inactive_queue.pages_list);
+		pool->inactive_queue.num_pages = pool->queue.num_pages;
+		pool->inactive_queue.ci = pool->queue.ci;
+
+		pool->queue.num_pages = 0;
+		pool->queue.ci = 0;
+		has_work = true;
+	}
+	spin_unlock(&pool->lock);
 
-	rb_erase(&pool->node, &pools->rb_root);
+	/* Reschedule if there are handles to age in next aging period */
+	if (has_work)
+		queue_delayed_work(
+			pools->aging_wq, &pool->aging_work,
+			secs_to_jiffies(FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS));
+}
+
+static void destroy_frmr_pool(struct ib_device *device,
+			      struct ib_frmr_pool *pool)
+{
+	cancel_delayed_work_sync(&pool->aging_work);
+	destroy_all_handles_in_queue(device, pool, &pool->queue);
+	destroy_all_handles_in_queue(device, pool, &pool->inactive_queue);
+
+	rb_erase(&pool->node, &device->frmr_pools->rb_root);
 	kfree(pool);
 }
 
@@ -116,6 +158,11 @@ int ib_frmr_pools_init(struct ib_device *device,
 	pools->rb_root = RB_ROOT;
 	rwlock_init(&pools->rb_lock);
 	pools->pool_ops = pool_ops;
+	pools->aging_wq = create_singlethread_workqueue("frmr_aging_wq");
+	if (!pools->aging_wq) {
+		kfree(pools);
+		return -ENOMEM;
+	}
 
 	device->frmr_pools = pools;
 	return 0;
@@ -146,6 +193,7 @@ void ib_frmr_pools_cleanup(struct ib_device *device)
 		node = next;
 	}
 
+	destroy_workqueue(pools->aging_wq);
 	kfree(pools);
 	device->frmr_pools = NULL;
 }
@@ -233,7 +281,10 @@ static struct ib_frmr_pool *create_frmr_pool(struct ib_device *device,
 
 	memcpy(&pool->key, key, sizeof(*key));
 	INIT_LIST_HEAD(&pool->queue.pages_list);
+	INIT_LIST_HEAD(&pool->inactive_queue.pages_list);
 	spin_lock_init(&pool->lock);
+	INIT_DELAYED_WORK(&pool->aging_work, pool_aging_work);
+	pool->device = device;
 
 	write_lock(&pools->rb_lock);
 	existing = rb_find_add(&pool->node, &pools->rb_root, frmr_pool_cmp_add);
@@ -260,11 +311,17 @@ static int get_frmr_from_pool(struct ib_device *device,
 
 	spin_lock(&pool->lock);
 	if (pool->queue.ci == 0) {
-		spin_unlock(&pool->lock);
-		err = pools->pool_ops->create_frmrs(device, &pool->key, &handle,
-						    1);
-		if (err)
-			return err;
+		if (pool->inactive_queue.ci > 0) {
+			handle = pop_handle_from_queue_locked(
+				&pool->inactive_queue);
+			spin_unlock(&pool->lock);
+		} else {
+			spin_unlock(&pool->lock);
+			err = pools->pool_ops->create_frmrs(device, &pool->key,
+							    &handle, 1);
+			if (err)
+				return err;
+		}
 	} else {
 		handle = pop_handle_from_queue_locked(&pool->queue);
 		spin_unlock(&pool->lock);
@@ -312,12 +369,21 @@ EXPORT_SYMBOL(ib_frmr_pool_pop);
 int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
 {
 	struct ib_frmr_pool *pool = mr->frmr.pool;
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	bool schedule_aging = false;
 	int ret;
 
 	spin_lock(&pool->lock);
+	/* Schedule aging every time an empty pool becomes non-empty */
+	if (pool->queue.ci == 0)
+		schedule_aging = true;
 	ret = push_handle_to_queue_locked(&pool->queue, mr->frmr.handle);
 	spin_unlock(&pool->lock);
 
+	if (ret == 0 && schedule_aging)
+		queue_delayed_work(pools->aging_wq, &pool->aging_work,
+			secs_to_jiffies(FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS));
+
 	return ret;
 }
 EXPORT_SYMBOL(ib_frmr_pool_push);
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
index 5a4d03b3d86f..a20323e03e3f 100644
--- a/drivers/infiniband/core/frmr_pools.h
+++ b/drivers/infiniband/core/frmr_pools.h
@@ -11,6 +11,7 @@
 #include <linux/spinlock_types.h>
 #include <linux/types.h>
 #include <asm/page.h>
+#include <linux/workqueue.h>
 
 #define NUM_HANDLES_PER_PAGE \
 	((PAGE_SIZE - sizeof(struct list_head)) / sizeof(u32))
@@ -37,12 +38,18 @@ struct ib_frmr_pool {
 	/* Protect access to the queue */
 	spinlock_t lock;
 	struct frmr_queue queue;
+	struct frmr_queue inactive_queue;
+
+	struct delayed_work aging_work;
+	struct ib_device *device;
 };
 
 struct ib_frmr_pools {
 	struct rb_root rb_root;
 	rwlock_t rb_lock;
 	const struct ib_frmr_pool_ops *pool_ops;
+
+	struct workqueue_struct *aging_wq;
 };
 
 #endif /* RDMA_CORE_FRMR_POOLS_H */

-- 
2.47.1


