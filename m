Return-Path: <linux-rdma+bounces-16352-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OESlONjKgGl3AgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16352-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:03:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F793CE9B2
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A0213029AAE
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A9537F0EF;
	Mon,  2 Feb 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gSF2e+kM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0767837BE6F;
	Mon,  2 Feb 2026 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048080; cv=fail; b=om1D/iRq5nGZKHZKZKkpnYc9OYZtUkzvup4VMAtGvM4MQObRdGPKSA/qrLwIlxIJVC7Pk5VrFqgWz7JXLaYJWqH4KfDV4TyeAzCcA47HpeUD2g/9+BWl1LmP91AedKpakpbELEwx9WcrElKYgLnzsUVRpBABJ0kL/OCzjmptoBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048080; c=relaxed/simple;
	bh=yZgZiYyfnetMT9m+TA0M2rH6CzeoMMv9cYbte2dupjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hZM4JPDLhFWltlRYl1HQS0PDuth51nsX8oOfFnPkS+UjByQEH6ZjqPryazqWCu2lbi2bxoD7Kb3hwEYLuo2DpgTiKy+92v2WRLkIDlPi9WdzQ/9Q/CVDmXtkPvsTIp2ME1HIH1nI23YSOTyMlobQU7xGZOA978w9N/Euv8KlwHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gSF2e+kM; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FByOkq1TmAgP8BOlzSQFxHNMOy5p1mZByZ3Sbk4fd14vWZTbPPPMXBMCWj5Kp8O9bTVXH2RYAsbGQjLwEROMsjqk1kyficaun3PmlkoG0jFtbiTvttpS4YpCrtdJ5RIO/oRzrNkEk3cWQIHSz5+FM8l404v2kT+ZGtYILDSb9LK1dpH75GipOgcG8n4d3UZBZC/JWaZDfI3reqGU0fA72WYPFx8OUSbN8IzdziiVpZciNJPX79S65Q8K6XJZ0dmbM3ZoEoprVHHunMsfckkhSv85Z6dORGV6O0Q4Wy0BbjQisNeZBTG1b3IGnusHF6SNyREV2+gndsF5MIrXMmK3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cVpk02Rc2WvB+qo/xzKn28GKpjZgB2PL5cy+wRA5FA=;
 b=wL1t1O34VSP5U8TM3WuWS07Jeps3NdgcpAkaJ7lt6+bTzrzrsfNTugqHUG398V/gTUCcyRc1z9bF21k8NVDXk0FwDCTd3vzMNVjids7ePigkqVC0m0PBxZJHTTp3OrAtMWbINv+FvoGn7+hU2wnEL2PVkf+NY3m17fqyuinc/m5e2LPKiWn6kAZDGD4Z9jJiqY/RxicGV8WAYxTzs6In/NCzTFraqLLlLQRVRno036bJw2Vmp2Zx2CGBTKryb/YaqKM+0VEiZ44RxZfhHCZzZRM72AHlWNyRs/PtuRSIKZZM/V847UCkGyt5It1/DVhYPscTcovQG6/Qf4ZX4OZfJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cVpk02Rc2WvB+qo/xzKn28GKpjZgB2PL5cy+wRA5FA=;
 b=gSF2e+kMb0545BcO89SARQePUHHRmvMhxQQyKxSb8Pfrr4bfU7W8zXUrvlvUKvOa4t9ubUApDWhejG62DYOS575VyjXQwjHlhwYpPVzmTzbt199wCLiQ9pqpWiu5nSlND7plw0PzutDVa1Vs5kAg5rbbwwKbGXXTnaJYkgg/ijEwF93IYPMU6jqDbdHINI/zmFUR2SEjj6WTizdLZ3VMNfMWeh1jSR9KL/Gqd00TVuj5scRpxhlUWSnzuOdEH8GhdnJXKlttH9ozfXqNt167yD4T1GKmOaQVk3qTcrwI/uiVx4Bh2GjOqrg7/OOHPk7pOEMq/mbuqVZTXGJ9reHojw==
Received: from SN7PR04CA0055.namprd04.prod.outlook.com (2603:10b6:806:120::30)
 by CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:01:04 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::f3) by SN7PR04CA0055.outlook.office365.com
 (2603:10b6:806:120::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 16:01:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 16:01:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:30 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:30 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 2 Feb 2026 08:00:25 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 2 Feb 2026 17:59:56 +0200
Subject: [PATCH rdma-next v3 04/11] RDMA/core: Add FRMR pools statistics
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-frmr_pools-v3-4-b8405ed9deba@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770048005; l=2176;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=gFAizGFRLu/hiSC1JMaRA9TLFgWjChGNFfn1V8IKMSA=;
 b=1ksveegmNxrwmg+iYt8DJtDu0te+iYQf13lhX9U3kYRkoEMkYF5ylOCoAFfxHEjnt6cytTn7d
 YzzeW1z8mu0DEBwPwq2NdwZcDdN6iSqAoIdiR/yNAeIHgRTLmzXtxJC
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d876df-0ad7-407f-fe71-08de62744489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cERwRW5ENWJhdnBhQ3BHQ1c3QzN4RHhzeW10SWFRSDllUGNtSjhQWDFDcFRT?=
 =?utf-8?B?MS9aM0l2NmxUNklTRE5ab0xlTHpCYk1vRUlNeW1sRHlPMGxDS1FzVWxpakI3?=
 =?utf-8?B?cURpcnlKZXhCa29HMXFjNW53bnI5MzMxY080NVFrSlVZanRUOXJLbkxIQ2pu?=
 =?utf-8?B?SHg4NHpWeWVPZU5XZ1FHajByMmtlelZSam42UlFMVWZ3WUFZT1RQNWE1WlFh?=
 =?utf-8?B?a2xOdjdpVVlvWjFlck5PZThOOElTa2x6TmZ1Wmw0RlkyWHVxbC9PNXdRZEZX?=
 =?utf-8?B?OWFhYWo2UFBYdGYwb25sc2lkMWg2Smh1bkhUTnZ3eGdkYzg4NitjVFhxVTh2?=
 =?utf-8?B?UDlOMkZGWDJwYUc2WS9oRE9pZ0NoQU45eE84c2lqVGloeXh6eE15Qlo2bUhW?=
 =?utf-8?B?OUI4SjFhUlZlSUVaZllLQnBnWnNOd3htVldFaWxGN1NDM3NMZ0F6b01BNkRE?=
 =?utf-8?B?OWpVc3Fyek1HTU5ETGJadkZoVTBJeU9LL0xCRW44UW9hTDdwOVJhY2prNlkx?=
 =?utf-8?B?MzJQR2FXSlYvVXRSOHZRVXpWaDFxU0VKMW0yME9nTkN6TlRTaWVxdmlFVlVs?=
 =?utf-8?B?Nng0TmpGcVpyeTRtdHhFRG9XTFhHM3dXZk52cGp1V2hyM3NqVkpXSjBjWkZu?=
 =?utf-8?B?NVdUNytNY29kUkErOExaTnAwWmlQL2gwSHpoSU9SdEN5VnFjeERiOUt3NHRl?=
 =?utf-8?B?WXhFcUpGNUNvN0YrK2pzVldqeEp3bmVKMVRqSDRYRVJwVWVKRzBnTjdPdEEw?=
 =?utf-8?B?YTJpem1LK0ozVDE1eDlOekQ1cWMwc2tuUktsMHZ4bjE0aGpFVmtNVXBRMyti?=
 =?utf-8?B?V3ZJam1QTGZTV2kyUGVUNkh2SEZPQ2ppazdZVlRaaDVyN2JhbTJVZHZ2WHJ3?=
 =?utf-8?B?NUxpTXJBYmovTXJPNHRqOU9YTGQ0NEtqT01HZG85N0R4djEzaEVLWlJNVWRL?=
 =?utf-8?B?cnFGREdoN0xiNWlackVDdHM0YW5kRGNSRXdNRElOWVduRUxsOUgrTm45RUhs?=
 =?utf-8?B?M0xmUEYwQ2FiYUt6cnVpOE9JS2hxVFhBVWxRZUc4c2gyMU5rTUw1dnJXQWNE?=
 =?utf-8?B?RnVucmJTRTkrN3pWajBaSUtRc2ZFallNM05xRDVEUk1CdjhnR0s3M21VRy9t?=
 =?utf-8?B?azZCc3lrRGFIOWFJcXRZZ3ZnbmNNUUJqTkRKRnplWW9wRjlBc3dob2pyeGw0?=
 =?utf-8?B?aU9nckh2MFZmeHltYmkrUkRlYXEvU1o2Rlk3c2JiV2ZsUy9aUVQvVEJYR0Zm?=
 =?utf-8?B?ZVZZMzBFZXZxWk4xSWZ3cmZDUzNOSXBtbEZsQjF4cHJFMnYyYUJydGRXdEJs?=
 =?utf-8?B?THJyOWlCa2NRdDByREhOeDdXYmhIbEZIZTd4aW9qWlhETXQzSTJOZFJJT3l1?=
 =?utf-8?B?UWVBbWF3VTlTQVd1emlLOEU4aXZENk1zYW05NnZmTWFxVCtFekdUUDBjNng3?=
 =?utf-8?B?b3N5T2dtdERHL0VxOW9tSGVFdFFvODBhNnBXTVBtWFF4L0lacis5UlAwSjRO?=
 =?utf-8?B?dkpDMnRzam50WXJwNDBnMGlRSXNLZ3FSMFFQdHh5dlI4OGNBaWxqSmNncito?=
 =?utf-8?B?c3pHTnRRV2M3THFKS1VoZnlnaXdpTWdmT2tpdy9QL1V6L25JVXdlMXlTV3Fj?=
 =?utf-8?B?RFhaN1FQd3J1RDc2bFBhMG1GeGdJY0xwcjI3amZXNXN5dlR2ZTdqSnVGK01J?=
 =?utf-8?B?QWZZWHVWc1ZaVzlHenR1Q0VIYmUwZFUrZzJWRHVBaWN5RGlZcFpvMVBsc2Zi?=
 =?utf-8?B?VUhMOXRrM2k0d05XS1NCN3BvY01RMHVrTjdLMUNMY3RCekhnSi9aa0VlcWFu?=
 =?utf-8?B?ZWJ0eVVuMlZ0ellyQ1hMSE8ySmlyS0lIRXlpOGgyOUJ5Mi94YVNiU3BYUFR1?=
 =?utf-8?B?eWl2VnRmbEdGMEhVUThtdFpYWGFCUXJ6cEorYnM4d29JWjgyU1AxeitqUklT?=
 =?utf-8?B?ZVVFM2dwMVc3K0Z3blU3dGRxOFJvRzdBbjNDTkg5aU1FNkZxenlwWjR4QU9Q?=
 =?utf-8?B?dUJHSVYzK1pNWU1Dd0swejh5MGVhNnVpOVFMYVliM055ZytVS01VVnRwczVp?=
 =?utf-8?B?RExEOFRZcURhQTRwaDNoTVErUGRlRjdnWXhzc3dNb2QwSW9oU3BLV2llMjdu?=
 =?utf-8?B?cnhtZ1lJeG5xN1RERFFvaVdGZHNSZjNPVC9IejBzQ3k5azdQaW1hR0h4STl6?=
 =?utf-8?B?QVdBR2txZkNxeS94VFBsRHlnNXVSZVpCWHFHNzAvOEk2bnhXUzhrZkgvbmFx?=
 =?utf-8?Q?37D+esQ5LQUpGeCbjj5XuzKxWupQEuKdqarHEKI8ZY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	He41dX+h7LPFZKh0K+zIXK+Dsc8xYj+luyFwop4tgblmlXe7x/XQClN4fGNwjBgqa0rm234KnlhWq8DHfccT+fUaq/ynjw/kgLcQ/bMCMsNS3qXe+28+5olHXdPd+KmBVzeSF0Jr9SaWtz3VnLnDGOZPwrsV+X6NIBphWBE1aoRs4wWQE1aIGS3BSimpRyr+pKqYxTZDT4kl4+LznOtFiPkNdEUThT8lxRJEEPXanbq5gXI5qH1wDDzO6q/bO6olulBHulveD+Xr1cwsNegJBEFoD6ty/jWvwTamb2kYYS6s02xEFz/NHvRGK5rVweEZ3R/epMmPkcLDdKBpxXndy+oqBxG66SgtppQtSUzCcbFmuCuCCjtfTa9oSOe9WRPez9lRmwd8zh6MYV7yi4jrLzTCvGgXHja0HEd+fpqGIeerAmXE3JyfUodblwSFArdB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:01:03.4100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d876df-0ad7-407f-fe71-08de62744489
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-16352-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7F793CE9B2
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Count for each pool the number of FRMR handles popped and held by user
MRs.
Also keep track of the max value of this counter.

Next patches will expose the statistics through netlink.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 12 ++++++++++--
 drivers/infiniband/core/frmr_pools.h |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index c0b2770df8bf..cba9d54a59c7 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -314,19 +314,24 @@ static int get_frmr_from_pool(struct ib_device *device,
 		if (pool->inactive_queue.ci > 0) {
 			handle = pop_handle_from_queue_locked(
 				&pool->inactive_queue);
-			spin_unlock(&pool->lock);
 		} else {
 			spin_unlock(&pool->lock);
 			err = pools->pool_ops->create_frmrs(device, &pool->key,
 							    &handle, 1);
 			if (err)
 				return err;
+			spin_lock(&pool->lock);
 		}
 	} else {
 		handle = pop_handle_from_queue_locked(&pool->queue);
-		spin_unlock(&pool->lock);
 	}
 
+	pool->in_use++;
+	if (pool->in_use > pool->max_in_use)
+		pool->max_in_use = pool->in_use;
+
+	spin_unlock(&pool->lock);
+
 	mr->frmr.pool = pool;
 	mr->frmr.handle = handle;
 
@@ -378,6 +383,9 @@ int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
 	if (pool->queue.ci == 0)
 		schedule_aging = true;
 	ret = push_handle_to_queue_locked(&pool->queue, mr->frmr.handle);
+	if (ret == 0)
+		pool->in_use--;
+
 	spin_unlock(&pool->lock);
 
 	if (ret == 0 && schedule_aging)
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
index a20323e03e3f..814d8a2106c2 100644
--- a/drivers/infiniband/core/frmr_pools.h
+++ b/drivers/infiniband/core/frmr_pools.h
@@ -42,6 +42,9 @@ struct ib_frmr_pool {
 
 	struct delayed_work aging_work;
 	struct ib_device *device;
+
+	u32 max_in_use;
+	u32 in_use;
 };
 
 struct ib_frmr_pools {

-- 
2.47.1


