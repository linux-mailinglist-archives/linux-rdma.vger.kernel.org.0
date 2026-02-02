Return-Path: <linux-rdma+bounces-16358-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO+zFoLLgGl3AgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16358-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:06:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA3CEA8E
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95F47301915C
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BE83816F0;
	Mon,  2 Feb 2026 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nOGWTwLg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0737D13C;
	Mon,  2 Feb 2026 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048096; cv=fail; b=qAsv+H+1RjfmjVtk9RxHgLdg1pgi7uuntjXcqI2Qd+sRakhwiAfuSAsVo0VbjWEjDETjJdAND44COtJg06dc0cVYUVM4Q/KTY2kurMVRi/W4W/Ng+zVM+Hpxd34LGMUlweKRk2Hfz7SibTRCb5spUWCOJtWrf3oQ7jh3OQsoBsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048096; c=relaxed/simple;
	bh=1tZkdIBL8cH/T3iBUqTvbzbHyNUjiF9giM1wEx/bykE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=D1cLmkhxepsGRSOSlhWllelzz02shjPjE6mv/m1Kqc2+uVEXbnhSfbp14a5OrfG+LTaEW1YscdIgCcxaf4/WGGECd+BmnaQlX5rZKzNetn/L27Is54LNLkCnxgrzSpEwDDkHGI6MYBhRlGwPJ6Kso4EUEUgeQsYf0Kva4LogEDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nOGWTwLg; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJ4Rls09LLw9Pdr3Df4T4sa4VodoePdL0zCJfWTHll4VtJdtIam7JdO3QCqELea7Ioao26ZaNh0JWDO3rZYhSL/MV1GLJlpYkMKQgiWOdqasol+h/xF5DPqHgCnRmelVxn7ZNIGxlFFlGTZf3P+QIpSu2T1JWPyqQUziSwWBUUEP3JibRtceuFJxXM/C06t6bg8Ea8W/Vo89D8eIzPeUBOF3OyOwd42IZaG1sD9WlAQZzOf9PxXcXugJD40GT+85XoAkFAvjSOWFRJ0TAXBBnNpHIPHB1MutIQj+yR2lzLmmpGZFwKm+4i0AYxZ1m5qacLGSlheDmZnyctXkWedMVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuC5Qu1mNYDuOgWC3k9XzK/4gub9rnTcYJdZrDxC14U=;
 b=tR7A7EWGrS5/uRUBCmNCWJ+3gdUzvnc2IP+87p1bN3odqVTtmRkoF4AgcdXGQFLo2TK8GPlEQqimmVNSwtQvjM3BhPeqCqniz2Yiz8JXmzCAUnygRXM9Y25kynAvWNleblpXEYXQaWsluDrORYDeSTEI7fdVktxoxdnI25nB2qyG4OlmDzmyGP/ggm1XBPqRuXh7yRwMv18x3GkiIGFvnd0dRQQ50XihEHweCCQrdzDNN30TmCN2ZhMoiMDxMgAp+xlFk0AfNUYLhrV8RHsbaDnAtlfo0OFx9R9+YT2mmDsYuWwsW0aBfvhjImz2LS5ycBtZSwZbw83COTKZlJh6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuC5Qu1mNYDuOgWC3k9XzK/4gub9rnTcYJdZrDxC14U=;
 b=nOGWTwLge5rnzEotQURAJ4jAGPuQkRAfi8a74tkU5Pgxi8SZZ3UIV++IvbIXtoPLN+fxUrm+Fv5IjU5xh4FtMJLcvcRVcu0O+q1El6TvPWnfvPGYTgZQtXdVTxhCDcy+j5TZvAV0pbHpQfECWA1QpnVxej56K3s4yUZlVQqehLvAtaUid0xNQdrPgKKzJgpf2CSotv3L7qlwbXkSsBLB6FvK//ILMp2OSq14xd8tyAByzjF7IaaacsiH3qfpm7T+Gr9DmNJQ/9cvwC91uOo9sJrwObI+33MLrcMaZ1Pxp03Wa9jmhksQjXrTiBMP5c1rRb8Y60Kk/xKNtnPT9J9acw==
Received: from SN7PR04CA0002.namprd04.prod.outlook.com (2603:10b6:806:f2::7)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:01:17 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::95) by SN7PR04CA0002.outlook.office365.com
 (2603:10b6:806:f2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 16:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 16:01:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:50 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:50 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 2 Feb 2026 08:00:45 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 2 Feb 2026 18:00:00 +0200
Subject: [PATCH rdma-next v3 08/11] RDMA/nldev: Add command to get FRMR
 pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-frmr_pools-v3-8-b8405ed9deba@nvidia.com>
References: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
In-Reply-To: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770048005; l=7559;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=H69IJT0gSWJ/BQ1rnshAH8OOgF2pvDd2RNh8fItgBpw=;
 b=+7516NGBuLE+PBwXW5D4nmJagNmaCq0N3sjtxHQ6wHJqMgzd4uCTJopOMr1WRCFSTRgnqUKoF
 2s7XxQkdKmjD5lnfWpe91ZaP8CUduTUQRT0R/kqPeQMFwpH2+/hxdHH
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d79b18e-ca3f-41f9-02d3-08de62744ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTRUZElrbXhLdUJENEptQ0pCSk81NWFnZTVCZE9vZE14RUNBUVg2ZThnNXpj?=
 =?utf-8?B?b1NpZi84Ym1IWUVEZ0xNa0xMSUU5L2lnL3JsVElvVXllVW9ZNmNCcjhMQW1K?=
 =?utf-8?B?WmhEUFBBbTFPUkN5YzdlcnkvSUE1aVU4d1pHck55dzRpY0Z3NXp1WGlFTnEv?=
 =?utf-8?B?RkNpTUNGK0dlcVIxaXRLN2lkUUFoeGR1bnM0Z0JJM0JqWHMxLzRJWTFyTEpQ?=
 =?utf-8?B?Z3ZlbkVUSDN3am9Vb2RteVYzNUFJUmdGckdjdm9vTzdUd1dBblhPeUZNRW9G?=
 =?utf-8?B?b3RxY3RYdHBNR0pnQU1zSnNPZVdhVllTblhzVkRPbVgrMkFOUXNLRmlyWEw0?=
 =?utf-8?B?SmI5aUpWMW9McCs1c3JiU1QvK1V5czNBOHFua1d5Q1V1SU5Yb0c1UWJUR1Fj?=
 =?utf-8?B?am5DSkxSVzhnQ3RPbW56M1JZUU9iNkl2cXJxOEUrb0JSS3ZFQW1haVBVdXpa?=
 =?utf-8?B?bTNucW5UNDMybGdCUUR5RWZyYVZYYlFFV2VHV1U4UXdsQ1Fyc2FzSXhUSzhj?=
 =?utf-8?B?dlREb05Dd3NDdkhQRU9Kc2l5eXVJbTRJWUdldnVvOXZjSk51c2FmRGxDU1Fy?=
 =?utf-8?B?MzMrdHpaRUp3OGROWUhJSGlWazdUeko1Z0VHeGJRQVBnVDJrdGJoOFZyVjBY?=
 =?utf-8?B?ZTlrU1dMM0hIMnhxbnpvcjA0RTVhSEpVOU1pK2ROdTgwbXl0TWhMNnRwNjJu?=
 =?utf-8?B?R2pyNy9zK25OSU1iVTdTdnlPdWlYSDRFWEN0Z01Jam5SdzVObkNaMGNEOVVp?=
 =?utf-8?B?eDZYTjdUL1pHLzUwVnRJZVBENC84dDhkSFZwR1paalRUdHFiZjFJU2hGdlhS?=
 =?utf-8?B?SmQzSmhuc3BPQmR6RzZPeXVQMndxeDh1MjVOWGg0aTIxUEtocFNHTG90ZU5M?=
 =?utf-8?B?bisxc2NhamsrdzVlM3JtZEVMTjl6V01tVHVTcEllb3VHdEVvUmUvYURBL3Bq?=
 =?utf-8?B?U1NlYndOTkduUjE4anJUdnpTdWc5eGFnNURWREl6YlhKS0pyd0pDcXQyaDN2?=
 =?utf-8?B?enhTZFN3SGlFeThPczBUb2dsd3BKTXV4NlBJNklXWDBzeTU4VUg5VFhIU1lz?=
 =?utf-8?B?N2xlT3lGV3RMT0VUVTNiZXdGQzlkQUtjZ0FsQkJsSkVQQ01vWnQveTJPZklP?=
 =?utf-8?B?a0ZQYnV2VXYrOTlyNE52cXZ1Ym1nZVkwVGJoZEp4RERUc0hISWpyb01HVFFL?=
 =?utf-8?B?ZHFTeUZGaURtSVRBMkYxZFpWMktpWjFXc1ZvQzI5UGQwMkRQRTFmajEwUUVk?=
 =?utf-8?B?dEFqdFlLQ0IyOVRRWCtJK0loSWs3bURCSXRmV2tYTXdQYjJodWtFT0NDK0dC?=
 =?utf-8?B?dU5HdGdpUFFrcEsxQjBibTB6N1ZQeFpWRTF6dzZWQmYyMVQrYVl0M0VVQXZh?=
 =?utf-8?B?QnN2Nk5iMjdHMUVZQW9WU0ovaENRdFpvU2poSG83bWJERC9iSmV1WEU4QVdx?=
 =?utf-8?B?RlNHUlhXZTIxUExCVytZUkZCQWUzcHNqWlhwem1hVTdFaXp1Z3VrdVVQand3?=
 =?utf-8?B?UjhaSDNkVTFQOVJ2Mm8vRVB4cHZ3QzlSRzNHckc4U1I5YndBOTZhS0Q5Rndk?=
 =?utf-8?B?TjRzM2JTd3QxbS9hL1g5cmt6Z1ZkcnQyR2ZQMm1NUVlYa21sNWU1Q1dFQUZ1?=
 =?utf-8?B?L3Q1QWppbUkxU0pxelR2amZVSU96bmVPekk2V2lBZy8vWCtkWkRYMldNdGF1?=
 =?utf-8?B?TWJmZ1ZKVHJHZE4yNDF5K1NsWkFoNnp3UUFwYzAwWWt4bHNhTWZSOFlQTmFx?=
 =?utf-8?B?TTdhaWg3RWxFRUovaS9NTHV0a2R5WHRRSnR2MllucmJwNXc3N3RmRHZoRFZQ?=
 =?utf-8?B?SGE4Um5tbWpUNUQ1czlhQk9sbTdRZHRmc1lZVkNlRjdOQ3lUSG56R2FuUFhF?=
 =?utf-8?B?bG9EVmFITEdIeFVqQXRKaGdzcllwWW16c29lTUQ5TjZrTTgvSnk0MFVKb3NC?=
 =?utf-8?B?WUVHQ0JTOFdzaW9ncG5HcjJmOXRxYWh3dHJ1dTUvc1RCWW1VcDFSc0lNTDlr?=
 =?utf-8?B?elF2ZzY3OGJtMEhVMFEwZHdVNFNDSldyRS9zU051WTd2eFhKTDFMd3EzU2Rm?=
 =?utf-8?B?YWlGck85NHUyTThwMWZTWG81Sm00dzNnYzNGVXBiMVNpZlp6YWhBTVJjdUJm?=
 =?utf-8?B?YmtwNmFsZG1zeHhScHovV2lmVzlPTWhvSFdTYU1pZEhsNDBveGNEc1hVbEN0?=
 =?utf-8?B?c0ZHTks1RkQwRW5oNThZVW05SWJ2TFp0TGdrNmovNXJvUVZ3dm9mNlV6SXVu?=
 =?utf-8?Q?y4mZLbn1rEAiQ2E1zH36PO5aztMhJtYoxdSRm9CTDs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DXJk9k7XHAR4dGmf9CnJR8NXlwWc44vpYAhTCmu/ttET1MN35P7dv62vHPzpZMjYjz/NUQ7dM/TDAtlqjf8qb/cS/JHG+eESER1fUt46yr++qYHZXzKSg6TacybYjZ+PqjdW1xFzx7quqf3fU3WMO7exZ9VqVlGlyrZ9o6dQ2dCfJ386YC+aFg2hLb8ju187MCp5xnHGcmjMnShSkVK4brIMXTOEzuFVJVJi3rWhHNdWNXUH4pJPYRMvzLYtOUuvpRCsOZtuUjPrdiIphn7jgJvR7eoRRFh7OaPORdcRR7qZPNpBuxmIWrXPhqPsR6V/MJFM8Jtljsizhylo5JVQOyG3vOew6T+MMdrbfB260EqGTpom/+1uYI/M7EjUA62umdRUCV1GQw1sFNhKOUTCzvfKXLBPQ9Nb4H9WRCoGFOLTETCjqrFokcvc3q7m7LOA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:01:17.7403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d79b18e-ca3f-41f9-02d3-08de62744ce3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554
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
	TAGGED_FROM(0.00)[bounces-16358-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
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
X-Rspamd-Queue-Id: F1CA3CEA8E
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Add support for a new command in netlink to dump to user the state of
the FRMR pools on the devices.
Expose each pool with its key and the usage statistics for it.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 165 +++++++++++++++++++++++++++++++++++++++
 include/uapi/rdma/rdma_netlink.h |  17 ++++
 2 files changed, 182 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 2220a2dfab24..6637c76165be 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -37,11 +37,13 @@
 #include <net/netlink.h>
 #include <rdma/rdma_cm.h>
 #include <rdma/rdma_netlink.h>
+#include <rdma/frmr_pools.h>
 
 #include "core_priv.h"
 #include "cma_priv.h"
 #include "restrack.h"
 #include "uverbs.h"
+#include "frmr_pools.h"
 
 /*
  * This determines whether a non-privileged user is allowed to specify a
@@ -172,6 +174,16 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE]	= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_EVENT_TYPE]		= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED] = { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_FRMR_POOLS]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY]	= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]	= { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS] = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY] = { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS] = { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES] = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]	= { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]	= { .type = NLA_U64 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2637,6 +2649,156 @@ static int nldev_deldev(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return ib_del_sub_device_and_put(device);
 }
 
+static int fill_frmr_pool_key(struct sk_buff *msg, struct ib_frmr_key *key)
+{
+	struct nlattr *key_attr;
+
+	key_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY);
+	if (!key_attr)
+		return -EMSGSIZE;
+
+	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS, key->ats))
+		goto err;
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS,
+			key->access_flags))
+		goto err;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY,
+			      key->vendor_key, RDMA_NLDEV_ATTR_PAD))
+		goto err;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS,
+			      key->num_dma_blocks, RDMA_NLDEV_ATTR_PAD))
+		goto err;
+
+	nla_nest_end(msg, key_attr);
+	return 0;
+
+err:
+	return -EMSGSIZE;
+}
+
+static int fill_frmr_pool_entry(struct sk_buff *msg, struct ib_frmr_pool *pool)
+{
+	if (fill_frmr_pool_key(msg, &pool->key))
+		return -EMSGSIZE;
+
+	spin_lock(&pool->lock);
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES,
+			pool->queue.ci + pool->inactive_queue.ci))
+		goto err_unlock;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,
+			      pool->max_in_use, RDMA_NLDEV_ATTR_PAD))
+		goto err_unlock;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,
+			      pool->in_use, RDMA_NLDEV_ATTR_PAD))
+		goto err_unlock;
+	spin_unlock(&pool->lock);
+
+	return 0;
+
+err_unlock:
+	spin_unlock(&pool->lock);
+	return -EMSGSIZE;
+}
+
+static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
+				       struct netlink_callback *cb)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
+	struct ib_frmr_pools *pools;
+	int err, ret = 0, idx = 0;
+	struct ib_frmr_pool *pool;
+	struct nlattr *table_attr;
+	struct nlattr *entry_attr;
+	struct ib_device *device;
+	int start = cb->args[0];
+	struct rb_node *node;
+	struct nlmsghdr *nlh;
+	bool filled = false;
+
+	err = __nlmsg_parse(cb->nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, NL_VALIDATE_LIBERAL, NULL);
+	if (err || !tb[RDMA_NLDEV_ATTR_DEV_INDEX])
+		return -EINVAL;
+
+	device = ib_device_get_by_index(
+		sock_net(skb->sk), nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]));
+	if (!device)
+		return -EINVAL;
+
+	pools = device->frmr_pools;
+	if (!pools) {
+		ib_device_put(device);
+		return 0;
+	}
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
+					 RDMA_NLDEV_CMD_FRMR_POOLS_GET),
+			0, NLM_F_MULTI);
+
+	if (!nlh || fill_nldev_handle(skb, device)) {
+		ret = -EMSGSIZE;
+		goto err;
+	}
+
+	table_attr = nla_nest_start_noflag(skb, RDMA_NLDEV_ATTR_FRMR_POOLS);
+	if (!table_attr) {
+		ret = -EMSGSIZE;
+		goto err;
+	}
+
+	read_lock(&pools->rb_lock);
+	for (node = rb_first(&pools->rb_root); node; node = rb_next(node)) {
+		pool = rb_entry(node, struct ib_frmr_pool, node);
+		if (pool->key.kernel_vendor_key)
+			continue;
+
+		if (idx < start) {
+			idx++;
+			continue;
+		}
+
+		filled = true;
+
+		entry_attr = nla_nest_start_noflag(
+			skb, RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY);
+		if (!entry_attr) {
+			ret = -EMSGSIZE;
+			goto end_msg;
+		}
+
+		if (fill_frmr_pool_entry(skb, pool)) {
+			nla_nest_cancel(skb, entry_attr);
+			ret = -EMSGSIZE;
+			goto end_msg;
+		}
+
+		nla_nest_end(skb, entry_attr);
+		idx++;
+	}
+end_msg:
+	read_unlock(&pools->rb_lock);
+
+	nla_nest_end(skb, table_attr);
+	nlmsg_end(skb, nlh);
+	cb->args[0] = idx;
+
+	/*
+	 * No more entries to fill, cancel the message and
+	 * return 0 to mark end of dumpit.
+	 */
+	if (!filled)
+		goto err;
+
+	ib_device_put(device);
+	return skb->len;
+
+err:
+	nlmsg_cancel(skb, nlh);
+	ib_device_put(device);
+	return ret;
+}
+
 static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	[RDMA_NLDEV_CMD_GET] = {
 		.doit = nldev_get_doit,
@@ -2743,6 +2905,9 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 		.doit = nldev_deldev,
 		.flags = RDMA_NL_ADMIN_PERM,
 	},
+	[RDMA_NLDEV_CMD_FRMR_POOLS_GET] = {
+		.dump = nldev_frmr_pools_get_dumpit,
+	},
 };
 
 static int fill_mon_netdev_rename(struct sk_buff *msg,
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index f41f0228fcd0..8f17ffe0190c 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -308,6 +308,8 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_MONITOR,
 
+	RDMA_NLDEV_CMD_FRMR_POOLS_GET, /* can dump */
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -582,6 +584,21 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_SYS_ATTR_MONITOR_MODE,	/* u8 */
 
 	RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED,	/* u8 */
+
+	/*
+	 * FRMR Pools attributes
+	 */
+	RDMA_NLDEV_ATTR_FRMR_POOLS,		/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY,	/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY,		/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS,	/* u8 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
+
 	/*
 	 * Always the end
 	 */

-- 
2.47.1


