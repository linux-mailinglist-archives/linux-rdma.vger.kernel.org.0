Return-Path: <linux-rdma+bounces-16348-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPMEGorLgGl3AgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16348-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:06:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C33DFCEA9C
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 642353098A31
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4961625F98B;
	Mon,  2 Feb 2026 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eNuCiPCQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5020022FAFD;
	Mon,  2 Feb 2026 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048060; cv=fail; b=HC8wAkA+hM2CEAfT39M79VxM36BDVQ76L9+hjC0fwIrQ1RYWGI9Yhl3XMI906UMu4jRPLJiMYe6akfx80HONubuDQCXXu74u8JNZ7bEvCTOmhvN/keqW5jv3DopdaVNEEZUngqMBpcEQpu3f5ut5q/h7ZvxJEQA0wxcYFo2t65E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048060; c=relaxed/simple;
	bh=8d8ZFvBerMmyK39V7DmdwEXPCC8pUAvFkFY4d6qavYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=M6ufYQEP//FFOWssLNLw/oVkPCwHtKxJfHxufXU1jEztprr37mHyp64UcOvORZfLAUxTKnG4itou36TdKgFnacC91JxcxaRa4nV2jotz1YzQZXEEa7fJtD/2k047dYKjJee/HUzyt5ZwEpvdasbpUNgeRzrrx1QnfhiRHFQS1mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eNuCiPCQ; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqEgCa1t/09avxdAoicgiqSEs0xsZlEK/gBprrQg38/lcT9hAs2of/IQo1SiZrYnpqhhIGKISkZ574a/TpmZ4YTGhV0DWcmHs/gUV+C9j40lUDeNJurQzxK6DAEHpUoG12nHmhLMyWIor0JguWr/aNFyEKhDqwGY7/6Yg0RtG4gWt3QxRLBjbcFkzOCC4lTtLJ4sXbSrVV6NfQAirKKLB4g1necHRu5VaYGNfBXuAd9V862ui2MzyXqOJ1/tl17J9bouzsEIO+3retftRb8CrQym6CKG2lqHoe27aZMSxbgCz8XHmzOUyDXO0qoMZ1NVa8w7wB0bXi2Uch6AeN/jRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzmgWuQr3nJW985A/qIJ0O5m2hlIgutBQB9byY3WGzo=;
 b=X4zbbEQUYjozVVGxyEoaTDr07H6i5AU+8ntGqyF4att8jk+6PlNzCY1lCMWpJiSCiZ6HQr2eODwQTetCAjnAaDPDaKJ22N4ExpL6WY2ulj68+Q8+MzCQiiMkPljXx35Rlp5+d8UuQO/DOZpstfEfzUD93/290BpZExXYN0u5z0/hx2CAJimAWJSzN57jXG6LjgzMX91HVvKvFwfWNVPHBGNVSBQtxMZRJLVR45h973uX+ZaBO58JEhKc0Hna1yR7xH0Up1tY8Xr8/L/imc0epVDfVxd1pLL5XyiLQ+0cFHLAzgL92wFOQnmbWJOHfJ5UP/da12BInqJhiBAWuVqevA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzmgWuQr3nJW985A/qIJ0O5m2hlIgutBQB9byY3WGzo=;
 b=eNuCiPCQQjSwZPHX9/E2QF00q0f61CYIxFhu97l7wlpllpWX5RXcB5mNNr4digU6KqpBnAyiva6hzrKYy8BlHtrwosjY87pgYSEt9t0ViOl4xrowiVXCKc/wJ08J0cPmSnB4UXKXQPQ9UsVMDA7dOFARXDcW5G8i3u6yGu3MyZPQh4ezmRjKN+ZMEvqWf55PH6AsquAkPRouUkFZg82aqZfeJ9AfBgZgZ5qzbKZEew8Vg26RLNrS9dOy+kapkolwduHZ2junu2dfpEfiA+/SqYACQQHYyoJmgknGzKkmUuz2jKzrDft6BcjDR+fakVHtN5zPJ6IBIGpweev5S/2aww==
Received: from SN7PR04CA0030.namprd04.prod.outlook.com (2603:10b6:806:f2::35)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Mon, 2 Feb
 2026 16:00:51 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::d9) by SN7PR04CA0030.outlook.office365.com
 (2603:10b6:806:f2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 16:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 16:00:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:20 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:20 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 2 Feb 2026 08:00:16 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 2 Feb 2026 17:59:54 +0200
Subject: [PATCH rdma-next v3 02/11] IB/core: Introduce FRMR pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-frmr_pools-v3-2-b8405ed9deba@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770048005; l=15251;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=YiNc+YEvcQ9dVg9YcyhDUp/X/1cRw/UoUXVYwCbeGdE=;
 b=2GD6D42qzEEZQkw1cSjwFu0rlUIxMtDk8UHBRsjGjtW9u5D2XP3b1ohEG7/DYWrvgbwYRmvLb
 D1baJEOUDRvDvIvgHKZKoJklrMelkMGwVGW7a3qJoQlXXKgdxdbesx4
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: faf6d0f3-7d91-4e04-f0d7-08de62743d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHBNTzRXYUhqbUFhbHc4NjFDc2pPanpxWCsvVzBLSndzM3NHd3Y4NC8zSFA3?=
 =?utf-8?B?M2NYMkFHMXN2YkR5dkkzM2h5UXl4V1VtTHpPYUlSVnFMV1ZRSkNSSWRPZEVa?=
 =?utf-8?B?S1FHalM0Q1VLcURyWGlibUdUZVM5RzJFSHptWkpGVmlJMnFRQWsvdVhDTGhy?=
 =?utf-8?B?WHNka096Nk9PeTc4eVNvWG1scFVVaTNDQmxwY0R3bTh3Sys1cW1HVXpaYnAr?=
 =?utf-8?B?cEhzbC8wVUQvTGNzZERpMUNXN01pOVpEbExBS0RLa0NxZXVuRjJrVHhENll6?=
 =?utf-8?B?QUJaNWVEd2puMWJMNjZlc3lNYjBvMy9FUjhJcWVhN2gzdTlwb3AzNFovVWhy?=
 =?utf-8?B?bUwxUWdTSEdYV2xUK0pxL1krSVJoWXoySWlnSWFITDdsMTNmaHJ0cUFPQlJF?=
 =?utf-8?B?djI2a2tLRlM4WGNrZmxWWHpoSUdqWi9kVkVodlNsNGQ1K3JtelhrYUFsd0xi?=
 =?utf-8?B?RXFMc2pxZnBNazFkQm5ZdzRjK0pLZDRyalVibXExalVPajV6UWpmVk02MWVM?=
 =?utf-8?B?ZjlmY3hFeHhaT1NWdHJwejZWUjNVeTZvUmdWRE5qdU43eU5KNUJUOXF5SE4z?=
 =?utf-8?B?dDJ0Z0taOFY4U1Z6azQrQVJlaFRlQ09QSWNmc0RBb2RDRGJRYmZEN0pRWm9O?=
 =?utf-8?B?dVUzWmIrbmptcFltR2x5Z1I0TjlxY0tkdDB2WW1WTEdzSU9zTHlxOGZyNmxa?=
 =?utf-8?B?OE5wZElwRnYvbXNhNHFEakFLOU12RDNhNzVTa013RTN2L0tIRGVJSjBOekYx?=
 =?utf-8?B?dUhOM3pMd3R2TGluTjZteGVac2FhdDlpY0pzZlNzbElMRVJvYU1oKzRjTmND?=
 =?utf-8?B?S3d3dCszTmVoZHhzVm9rMmZHajNjYTZtNzdMQThxa2VzQ1MrMEQ5T2s5Yy9i?=
 =?utf-8?B?R3BPK3hhRkxQYkVabzdNYmZYQmwvSWlvRUxkWmVValQ3N3E0ZklONTF6UUFO?=
 =?utf-8?B?MWNDZW5WNnQvYmJoWjhqVEZzZmpOVWdmVHJmaVI0RFJVTXNtbHhxL0Z1ZFVJ?=
 =?utf-8?B?WmZFNlVNVDVySVpxN3hzdGU2aVArRjlYb3FqNFRlSzRaSzZMeWdFZm4ycG5X?=
 =?utf-8?B?MXhiQnhqT3BGRmZnODRpK1ViYUhpVDF4R1RXT2o0QXdhZXNsZnNLaVlrbHhB?=
 =?utf-8?B?RUxiVUYrOVZRdFJ1NEN1c3lUdVpDRis5TDB6VmRuUURJTlBwem9pVTA5K1R3?=
 =?utf-8?B?cnJOQnU0WlRNQy9SWEduOTh0MGpOUlh2NGpha2NWM3c4NTJPN3hVMzlHU2tH?=
 =?utf-8?B?cmVEcVh1WlByamhIQ2VVM3BSaWdHSDBWNjNsNldQN0FiYUo0SWZ3cS90ZWJi?=
 =?utf-8?B?aTA4TFROSnFEeTQrZk5ERmxpNEsrZUZRUkQ5TnExQmhkR2Nham9HdHB1OTZa?=
 =?utf-8?B?NjU0SHRIa1VhRE13eWRYSVd2bTRMeHcwUm0rU2EwVHY0VkJVNVVtb1FaQ0M2?=
 =?utf-8?B?TWpQUmJQeTFjbnJyR0Q3K1JJRldKeWpLajNvb0MwK0RqUzd4Yi80RzFlL0sz?=
 =?utf-8?B?aDZSc1VLM0ZMU25IaTRrTmx2bE5IOUpEMXByM3lnNjBiMUZGdXR5bEdLNm1y?=
 =?utf-8?B?NkZ2V0d3K2dMR2p1TTdZY2F6b29ETVlTRmFGUXh3dDF6MklwMEJ4TUk4aHdW?=
 =?utf-8?B?OVJwdUMwdyszNUxGQXVZVVBOaUEzUGc3c29HMkhieENFT2hCNDZZQjVCQm9P?=
 =?utf-8?B?Uk4xQWJlRnhUY2JObzlyaHRWK3BhM1RwNW1hUEIyc3NEa1NSWE8vVFFBaVdF?=
 =?utf-8?B?K2I3akc5SzZ4SlY2SThsdWFsUW41Tys2OXozMEc4d042Z2NFS2FEU2l2TmxY?=
 =?utf-8?B?ZEs3RHB0cEdTaWZYRUlDTUNwQyt0cUpxUFVESkwwN1l5TmpOWEJ5V0lZTjJB?=
 =?utf-8?B?SUwzbEhobEFuZnNkdERxYlEreXZEU0dYdlVKRHB5V1pHS0dUM1BhRi9Cc1pa?=
 =?utf-8?B?RTVtbGdPVGtTalBGTlhOMTN6TVh5TUI5cmg2dVBmckNldVhkaXVpQitTS1RB?=
 =?utf-8?B?cVJueFQ1bENwRWN2QnRzNjc0WkZxMTBmYXkyRXFnOTN0V0JoWEVjY1BVWDdl?=
 =?utf-8?B?Y1hyUkRtMGtVSlBQOGlmVnhod3Qrd0t6czFWdjJ1ZFdsNTlJV0tkaG50N3BX?=
 =?utf-8?B?SzdMR2MxREZGQms1MUVDWmsxOEp5cVA2SVlXempPWUhXMlp5aUNhM01nRHVn?=
 =?utf-8?B?U2FlVS9OU203R2YrZ1FzYVNldVRLVldWdm5mRjZkUk5rNDFpUUM2cDJHa1BL?=
 =?utf-8?Q?jWBw1weJTWVdoUCFoTbIqAgze5dbDleCYccbyC0Hv0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RoXpTXakBLrv5S87K/4SPP3rKKD4ndrHbl7786oH4BaUHB6sdW+T2ZGtUHPPHLXSgDJzpGxqrsl4BB3hSsZAQCTS/IKt54HchNn3CkEXRcAG5793izy9scC5VMHTUTisZ8zkdB7m+opNeqkKkA5O++UbQPjubYtPnj43b+JeI2mOE/nT6y/8H4kcbdRG8mKloCYvUELA3IM2mS0ucCd4IbR5h2T1DK42mEBU0m8IgqJQgofwjq+39rNPwxTSuRtG06YjaUTBJltEZW9ei2HRrUGDYo7MkR1XR9SHOaBor1RDFNR+Hhj0XLB1286TiyIVwxES1Bih68upPJX8ToDym+89GdJxmOnCJChvu9HJ9H6qU9mlPKa+vXaTstxBKSmCm3VqMxd727YHI/yrkWEkkYATOtCfVmnH58HIz002N5rwq37qUIutW2rgHAbtM8vG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:00:50.8843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf6d0f3-7d91-4e04-f0d7-08de62743d07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
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
	TAGGED_FROM(0.00)[bounces-16348-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
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
X-Rspamd-Queue-Id: C33DFCEA9C
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Add a generic Fast Registration Memory Region pools mechanism to allow
drivers to optimize memory registration performance.
Drivers that have the ability to reuse MRs or their underlying HW
objects can take advantage of the mechanism to keep a 'handle' for those
objects and use them upon user request.
We assume that to achieve this goal a driver and its HW should implement
a modify operation for the MRs that is able to at least clear and set the
MRs and in more advanced implementations also support changing a subset
of the MRs properties.

The mechanism is built using an RB-tree consisting of pools, each pool
represents a set of MR properties that are shared by all of the MRs
residing in the pool and are unmodifiable by the vendor driver or HW.

The exposed API from ib_core to the driver has 4 operations:
Init and cleanup - handles data structs and locks for the pools.
Push and pop - store and retrieve 'handle' for a memory registration
or deregistrations request.

The FRMR pools mechanism implements the logic to search the RB-tree for
a pool with matching properties and create a new one when needed and
requires the driver to implement creation and destruction of a 'handle'
when pool is empty or a handle is requested or is being destroyed.

Later patch will introduce Netlink API to interact with the FRMR pools
mechanism to allow users to both configure and track its usage.
A vendor wishing to configure FRMR pool without exposing it or without
exposing internal MR properties to users, should use the
kernel_vendor_key field in the pools key. This can be useful in a few
cases, e.g, when the FRMR handle has a vendor-specific un-modifiable
property that the user registering the memory might not be aware of.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/Makefile     |   2 +-
 drivers/infiniband/core/frmr_pools.c | 323 +++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/frmr_pools.h |  48 ++++++
 include/rdma/frmr_pools.h            |  37 ++++
 include/rdma/ib_verbs.h              |   8 +
 5 files changed, 417 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index f483e0c12444..7089a982b876 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
 				nldev.o restrack.o counters.o ib_core_uverbs.o \
-				trace.o lag.o
+				trace.o lag.o frmr_pools.o
 
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
new file mode 100644
index 000000000000..eae15894a3b2
--- /dev/null
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#include <linux/slab.h>
+#include <linux/rbtree.h>
+#include <linux/sort.h>
+#include <linux/spinlock.h>
+#include <rdma/ib_verbs.h>
+
+#include "frmr_pools.h"
+
+static int push_handle_to_queue_locked(struct frmr_queue *queue, u32 handle)
+{
+	u32 tmp = queue->ci % NUM_HANDLES_PER_PAGE;
+	struct frmr_handles_page *page;
+
+	if (queue->ci >= queue->num_pages * NUM_HANDLES_PER_PAGE) {
+		page = kzalloc(sizeof(*page), GFP_ATOMIC);
+		if (!page)
+			return -ENOMEM;
+		queue->num_pages++;
+		list_add_tail(&page->list, &queue->pages_list);
+	} else {
+		page = list_last_entry(&queue->pages_list,
+				       struct frmr_handles_page, list);
+	}
+
+	page->handles[tmp] = handle;
+	queue->ci++;
+	return 0;
+}
+
+static u32 pop_handle_from_queue_locked(struct frmr_queue *queue)
+{
+	u32 tmp = (queue->ci - 1) % NUM_HANDLES_PER_PAGE;
+	struct frmr_handles_page *page;
+	u32 handle;
+
+	page = list_last_entry(&queue->pages_list, struct frmr_handles_page,
+			       list);
+	handle = page->handles[tmp];
+	queue->ci--;
+
+	if (!tmp) {
+		list_del(&page->list);
+		queue->num_pages--;
+		kfree(page);
+	}
+
+	return handle;
+}
+
+static bool pop_frmr_handles_page(struct ib_frmr_pool *pool,
+				  struct frmr_queue *queue,
+				  struct frmr_handles_page **page, u32 *count)
+{
+	spin_lock(&pool->lock);
+	if (list_empty(&queue->pages_list)) {
+		spin_unlock(&pool->lock);
+		return false;
+	}
+
+	*page = list_first_entry(&queue->pages_list, struct frmr_handles_page,
+				 list);
+	list_del(&(*page)->list);
+	queue->num_pages--;
+
+	/* If this is the last page, count may be less than
+	 * NUM_HANDLES_PER_PAGE.
+	 */
+	if (queue->ci >= NUM_HANDLES_PER_PAGE)
+		*count = NUM_HANDLES_PER_PAGE;
+	else
+		*count = queue->ci;
+
+	queue->ci -= *count;
+	spin_unlock(&pool->lock);
+	return true;
+}
+
+static void destroy_frmr_pool(struct ib_device *device,
+			      struct ib_frmr_pool *pool)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct frmr_handles_page *page;
+	u32 count;
+
+	while (pop_frmr_handles_page(pool, &pool->queue, &page, &count)) {
+		pools->pool_ops->destroy_frmrs(device, page->handles, count);
+		kfree(page);
+	}
+
+	rb_erase(&pool->node, &pools->rb_root);
+	kfree(pool);
+}
+
+/*
+ * Initialize the FRMR pools for a device.
+ *
+ * @device: The device to initialize the FRMR pools for.
+ * @pool_ops: The pool operations to use.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int ib_frmr_pools_init(struct ib_device *device,
+		       const struct ib_frmr_pool_ops *pool_ops)
+{
+	struct ib_frmr_pools *pools;
+
+	pools = kzalloc(sizeof(*pools), GFP_KERNEL);
+	if (!pools)
+		return -ENOMEM;
+
+	pools->rb_root = RB_ROOT;
+	rwlock_init(&pools->rb_lock);
+	pools->pool_ops = pool_ops;
+
+	device->frmr_pools = pools;
+	return 0;
+}
+EXPORT_SYMBOL(ib_frmr_pools_init);
+
+/*
+ * Clean up the FRMR pools for a device.
+ *
+ * @device: The device to clean up the FRMR pools for.
+ *
+ * Call cleanup only after all FRMR handles have been pushed back to the pool
+ * and no other FRMR operations are allowed to run in parallel.
+ * Ensuring this allows us to save synchronization overhead in pop and push
+ * operations.
+ */
+void ib_frmr_pools_cleanup(struct ib_device *device)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct rb_node *node = rb_first(&pools->rb_root);
+	struct ib_frmr_pool *pool;
+
+	while (node) {
+		struct rb_node *next = rb_next(node);
+
+		pool = rb_entry(node, struct ib_frmr_pool, node);
+		destroy_frmr_pool(device, pool);
+		node = next;
+	}
+
+	kfree(pools);
+	device->frmr_pools = NULL;
+}
+EXPORT_SYMBOL(ib_frmr_pools_cleanup);
+
+static inline int compare_keys(struct ib_frmr_key *key1,
+			       struct ib_frmr_key *key2)
+{
+	int res;
+
+	res = cmp_int(key1->ats, key2->ats);
+	if (res)
+		return res;
+
+	res = cmp_int(key1->access_flags, key2->access_flags);
+	if (res)
+		return res;
+
+	res = cmp_int(key1->vendor_key, key2->vendor_key);
+	if (res)
+		return res;
+
+	res = cmp_int(key1->kernel_vendor_key, key2->kernel_vendor_key);
+	if (res)
+		return res;
+
+	/*
+	 * allow using handles that support more DMA blocks, up to twice the
+	 * requested number
+	 */
+	res = cmp_int(key1->num_dma_blocks, key2->num_dma_blocks);
+	if (res > 0) {
+		if (key1->num_dma_blocks - key2->num_dma_blocks <
+		    key2->num_dma_blocks)
+			return 0;
+	}
+
+	return res;
+}
+
+static int frmr_pool_cmp_find(const void *key, const struct rb_node *node)
+{
+	struct ib_frmr_pool *pool = rb_entry(node, struct ib_frmr_pool, node);
+
+	return compare_keys(&pool->key, (struct ib_frmr_key *)key);
+}
+
+static int frmr_pool_cmp_add(struct rb_node *new, const struct rb_node *node)
+{
+	struct ib_frmr_pool *new_pool =
+		rb_entry(new, struct ib_frmr_pool, node);
+	struct ib_frmr_pool *pool = rb_entry(node, struct ib_frmr_pool, node);
+
+	return compare_keys(&pool->key, &new_pool->key);
+}
+
+static struct ib_frmr_pool *ib_frmr_pool_find(struct ib_frmr_pools *pools,
+					      struct ib_frmr_key *key)
+{
+	struct ib_frmr_pool *pool;
+	struct rb_node *node;
+
+	/* find operation is done under read lock for performance reasons.
+	 * The case of threads failing to find the same pool and creating it
+	 * is handled by the create_frmr_pool function.
+	 */
+	read_lock(&pools->rb_lock);
+	node = rb_find(key, &pools->rb_root, frmr_pool_cmp_find);
+	pool = rb_entry_safe(node, struct ib_frmr_pool, node);
+	read_unlock(&pools->rb_lock);
+
+	return pool;
+}
+
+static struct ib_frmr_pool *create_frmr_pool(struct ib_device *device,
+					     struct ib_frmr_key *key)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct ib_frmr_pool *pool;
+	struct rb_node *existing;
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(&pool->key, key, sizeof(*key));
+	INIT_LIST_HEAD(&pool->queue.pages_list);
+	spin_lock_init(&pool->lock);
+
+	write_lock(&pools->rb_lock);
+	existing = rb_find_add(&pool->node, &pools->rb_root, frmr_pool_cmp_add);
+	write_unlock(&pools->rb_lock);
+
+	/* If a different thread has already created the pool, return it.
+	 * The insert operation is done under the write lock so we are sure
+	 * that the pool is not inserted twice.
+	 */
+	if (existing) {
+		kfree(pool);
+		return rb_entry(existing, struct ib_frmr_pool, node);
+	}
+
+	return pool;
+}
+
+static int get_frmr_from_pool(struct ib_device *device,
+			      struct ib_frmr_pool *pool, struct ib_mr *mr)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	u32 handle;
+	int err;
+
+	spin_lock(&pool->lock);
+	if (pool->queue.ci == 0) {
+		spin_unlock(&pool->lock);
+		err = pools->pool_ops->create_frmrs(device, &pool->key, &handle,
+						    1);
+		if (err)
+			return err;
+	} else {
+		handle = pop_handle_from_queue_locked(&pool->queue);
+		spin_unlock(&pool->lock);
+	}
+
+	mr->frmr.pool = pool;
+	mr->frmr.handle = handle;
+
+	return 0;
+}
+
+/*
+ * Pop an FRMR handle from the pool.
+ *
+ * @device: The device to pop the FRMR handle from.
+ * @mr: The MR to pop the FRMR handle from.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct ib_frmr_pool *pool;
+
+	WARN_ON_ONCE(!device->frmr_pools);
+	pool = ib_frmr_pool_find(pools, &mr->frmr.key);
+	if (!pool) {
+		pool = create_frmr_pool(device, &mr->frmr.key);
+		if (IS_ERR(pool))
+			return PTR_ERR(pool);
+	}
+
+	return get_frmr_from_pool(device, pool, mr);
+}
+EXPORT_SYMBOL(ib_frmr_pool_pop);
+
+/*
+ * Push an FRMR handle back to the pool.
+ *
+ * @device: The device to push the FRMR handle to.
+ * @mr: The MR containing the FRMR handle to push back to the pool.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
+{
+	struct ib_frmr_pool *pool = mr->frmr.pool;
+	int ret;
+
+	spin_lock(&pool->lock);
+	ret = push_handle_to_queue_locked(&pool->queue, mr->frmr.handle);
+	spin_unlock(&pool->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(ib_frmr_pool_push);
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
new file mode 100644
index 000000000000..5a4d03b3d86f
--- /dev/null
+++ b/drivers/infiniband/core/frmr_pools.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#ifndef RDMA_CORE_FRMR_POOLS_H
+#define RDMA_CORE_FRMR_POOLS_H
+
+#include <rdma/frmr_pools.h>
+#include <linux/rbtree_types.h>
+#include <linux/spinlock_types.h>
+#include <linux/types.h>
+#include <asm/page.h>
+
+#define NUM_HANDLES_PER_PAGE \
+	((PAGE_SIZE - sizeof(struct list_head)) / sizeof(u32))
+
+struct frmr_handles_page {
+	struct list_head list;
+	u32 handles[NUM_HANDLES_PER_PAGE];
+};
+
+/* FRMR queue holds a list of frmr_handles_page.
+ * num_pages: number of pages in the queue.
+ * ci: current index in the handles array across all pages.
+ */
+struct frmr_queue {
+	struct list_head pages_list;
+	u32 num_pages;
+	unsigned long ci;
+};
+
+struct ib_frmr_pool {
+	struct rb_node node;
+	struct ib_frmr_key key; /* Pool key */
+
+	/* Protect access to the queue */
+	spinlock_t lock;
+	struct frmr_queue queue;
+};
+
+struct ib_frmr_pools {
+	struct rb_root rb_root;
+	rwlock_t rb_lock;
+	const struct ib_frmr_pool_ops *pool_ops;
+};
+
+#endif /* RDMA_CORE_FRMR_POOLS_H */
diff --git a/include/rdma/frmr_pools.h b/include/rdma/frmr_pools.h
new file mode 100644
index 000000000000..da92ef4d7310
--- /dev/null
+++ b/include/rdma/frmr_pools.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#ifndef FRMR_POOLS_H
+#define FRMR_POOLS_H
+
+#include <linux/types.h>
+#include <asm/page.h>
+
+struct ib_device;
+struct ib_mr;
+
+struct ib_frmr_key {
+	u64 vendor_key;
+	/* A pool with non-zero kernel_vendor_key is a kernel-only pool. */
+	u64 kernel_vendor_key;
+	size_t num_dma_blocks;
+	int access_flags;
+	u8 ats:1;
+};
+
+struct ib_frmr_pool_ops {
+	int (*create_frmrs)(struct ib_device *device, struct ib_frmr_key *key,
+			    u32 *handles, u32 count);
+	void (*destroy_frmrs)(struct ib_device *device, u32 *handles,
+			      u32 count);
+};
+
+int ib_frmr_pools_init(struct ib_device *device,
+		       const struct ib_frmr_pool_ops *pool_ops);
+void ib_frmr_pools_cleanup(struct ib_device *device);
+int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr);
+int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr);
+
+#endif /* FRMR_POOLS_H */
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 0a85af610b6b..6cc557424e23 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -43,6 +43,7 @@
 #include <uapi/rdma/rdma_user_ioctl.h>
 #include <uapi/rdma/ib_user_ioctl_verbs.h>
 #include <linux/pci-tph.h>
+#include <rdma/frmr_pools.h>
 
 #define IB_FW_VERSION_NAME_MAX	ETHTOOL_FWVERS_LEN
 
@@ -1886,6 +1887,11 @@ struct ib_mr {
 	struct ib_dm      *dm;
 	struct ib_sig_attrs *sig_attrs; /* only for IB_MR_TYPE_INTEGRITY MRs */
 	struct ib_dmah *dmah;
+	struct {
+		struct ib_frmr_pool *pool;
+		struct ib_frmr_key key;
+		u32 handle;
+	} frmr;
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
@@ -2879,6 +2885,8 @@ struct ib_device {
 	struct list_head subdev_list;
 
 	enum rdma_nl_name_assign_type name_assign_type;
+
+	struct ib_frmr_pools *frmr_pools;
 };
 
 static inline void *rdma_zalloc_obj(struct ib_device *dev, size_t size,

-- 
2.47.1


