Return-Path: <linux-rdma+bounces-16349-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFu8EtXLgGl3AgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16349-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:07:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2FCEAD1
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6914230B6765
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C591C2741AB;
	Mon,  2 Feb 2026 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YtousS88"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41725273D66;
	Mon,  2 Feb 2026 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048064; cv=fail; b=ighDhBGc4c93VW0G1Z+JgdTZH/oGLa2IIr3BM3cYW+PZalRon2ydikwvsD+ttIwfjwwmUfDPXLc+QIq68cgKek13js39WPAigH+I5IBE6hyC4FmxAREkAlhkDWpJAl+Prntt+wjEzQ5PMZB2wpJiwrxCHMXhauaQY38ytvS1EBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048064; c=relaxed/simple;
	bh=xM1yIuPGfjvQUjzbhQwRIe5okGm/NZ0PEVCeRi3HV48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HB/x5sY9Q1MHjgh5fDIl5P4NRONIxUah6OFPJJZwyESMni6H3a9XmIoWXRuETPAJ+Ji6cPWg7zDRH45ytAn0t1pXaZe7geG0QbHdNxemAH5giTaLs3YKkZkDHyr2yjTxrtK4i81AwdILD2r50YzgM6xYcv3XnbUmDs8lkdfSt6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YtousS88; arc=fail smtp.client-ip=52.101.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQT8S725aREKOLAONC9J7WCQas9BjiwcuWgcZRWn2OHTzbdRXzNTEZrInNjZV5T+xGEagaUkIFwEvELnvrk9T/PuqYw45GnaImEKEc/BtdSS03O+6yvl3YN81JzcnTQpPWe9aYrdMH64a2SXSEqe+Be5UeP+H5EsdhURlcDhhDObF3o/ihO3zoo9UmaPAsWyXk+qvUrNkhHlzCb0NmjLte6ghxIe1K3nycPBb8MGs0G5VtsP/ILuYLO9bSpBTegIRSoJEqDcJOue2Wd2yabDaNjrK9E79E1NYWd4+zRACvPlzC0b7uqR3B1luSLtj7K8vW/TsAiUyttjhGD3SWgGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+68snrZxOrqff6V0tlA4ICmsX7eSF3x7nCfvNvG9P7s=;
 b=PTkTd0uoLmMGYeNk3+WF/CRHPjLh7KK9vfHx5r9x0TFaNLzrw/5PiJMpLf/87WWcRNbrTk0s/QH37NxSVuzlDOJGy6gvPnfKSKRTJ0fcuxEkwSIpkIhIsqHb491OsPK3gCAHQ7C1fmoAdlbfEBj0VEN62QFcw874FhXYdfknwQfddH+xUYNciiBE8KY98/kfy/KDNWQ3EfUBXgg2WZrp2/s2EvElOUOLMiyR25zzM5Zy3n3k2vxMLi3duZyom1MkIvhf4c6Pa9oKeew/+yV7x3FdPexa2mqIKOh+CjA+V8oJ1byMsUI1+wDeNZ84fzP6yitS0mSKmLZhWUQQJTcVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+68snrZxOrqff6V0tlA4ICmsX7eSF3x7nCfvNvG9P7s=;
 b=YtousS885dsY+I0DjR1zy8i3BknearBqJDIwFN6cV22cpzXXFrQv+azy0c1Vnkuk61tmmIVrhKSfjsx0EfGKh6SEpcUf7mdNKPPrnJfbrEsHpEi1PCF4+RMNNxPyw0TEDPduXCjXOCYG+bZ6GGTM0pW6uOc8OnhNvXWzCOwdXpntQX9NC+6RHfKtBxSotax4APhr3RGE7ntrAKWtu977G9Ij5qVGn9sRqD1OrbAquZrdvgwvFUe6FbRnqCTc4xeVhb313U2Rf/lZYgSekaiXLseGuXGkeW83HiSzlDby1AwsApHUJRpuTW0QO/2M2WlqgAdxQAHbvArseI211uXk0A==
Received: from DS7PR03CA0176.namprd03.prod.outlook.com (2603:10b6:5:3b2::31)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:00:43 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::9a) by DS7PR03CA0176.outlook.office365.com
 (2603:10b6:5:3b2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 2 Feb 2026 16:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 16:00:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:16 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:15 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 2 Feb 2026 08:00:11 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 2 Feb 2026 17:59:53 +0200
Subject: [PATCH rdma-next v3 01/11] RDMA/mlx5: Move device async_ctx
 initialization
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-frmr_pools-v3-1-b8405ed9deba@nvidia.com>
References: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
In-Reply-To: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Chiara Meiohas <cmeiohas@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770048005; l=2149;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=RvT/DTWYYSHBGfslGw2tAwDY1DXRXLqhLAQT1hbPf/0=;
 b=Ig3u+t0wOq1zg0lueuPQE4XSlVhemcKuqhOiIs2Sa4CLYsnEU9Z9mB5jYA3qigZFBrwCfgVuT
 OEK+gdB8IZ3Dh2cdR3Q9nXWxhM6gIZVBaFGKkLPfpjvOdZ90UpWlxh1
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e4577b-ec77-474b-2978-08de62743859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjVQb2F4S0w0SjBiR1JJd1EyWlYwU3NrM0Uvck8vTWtkbFlWUG9MY3hCM3hF?=
 =?utf-8?B?OE9LaHVCWW5lY3poQmRMS29lVEhobk83TER2czNHanlUMVdYSTI3Q2E5WFNY?=
 =?utf-8?B?QStTTENBNkxlSEJRbWcrK2tLdzVLby9HRWZ6c24zWmdEYm5waVlLOEhEUElV?=
 =?utf-8?B?MlpubTlYMWdjejQwSnpwdUFYU3ZyZjBlcmxzTHlDTXZ0aC9NeXdyMk5yaDg3?=
 =?utf-8?B?bnZNTXpqTWZ3b1RTczFLczc2T2YzTGVmSGgxb3VQNFE2enZiOHorVVY2dk1B?=
 =?utf-8?B?azdQWVAycWlXUjRKa1RURWlWT3Yvd214Ni9FQXZ0ZUdLZHFNeHQzeFlsWkJi?=
 =?utf-8?B?ZjROQjlIa1lzbVBjbEZXdXorMkR6VG5URmtmbjRscWpCRlVwMnRoRDRvbk5R?=
 =?utf-8?B?b3ptRWVnOXdTSDgxZzl1MVJOOXZ6a1UyalVoeXpXUVpoRnZYV01sZmNNWFVs?=
 =?utf-8?B?eHZMWnZBR0lmZ1Rpc0ZvLyt0ZnVBY1lxVmFWYUVyU2YwZmtJTTYyd3FNZGl0?=
 =?utf-8?B?Qy9RcXBtRG9jUUYzSFF0Mkx4VVNFaGgyenlrSERkUEo2ZWdheVJlSHhrdHZN?=
 =?utf-8?B?eUZXWFFiZHZEK2J6ZThaOG5GaGRCUjdqT3Z3eXB2ZWZoenJDQ0R1MStTQVlZ?=
 =?utf-8?B?UWlvTjFmbnQ5TnhNQjE1ek90RzZBNis2SitlN2MyNGRtRG1BZSs2TmdYdFh4?=
 =?utf-8?B?NkFvOGxOd0dLVFpsakZrLzZqeXNVSEw5Q05FRUxJU3JVa1haZVhtRDRBby9B?=
 =?utf-8?B?bEk4TmNpazdaUGV4SWJGdmRkOFBaS3VQYU8welk3NnZNd1ZOVVBNanlUS0E5?=
 =?utf-8?B?VmhsUG9NbDJKbHFxUTNwU05RTEMwQ1JFNDVodDVWaEc1Wi9hcVk1WG9UMFE3?=
 =?utf-8?B?SzZRMEF2eDFmYlFqUFdJWXZFazY4eHQwa3FmN0hvNTYxRkU1R3hkRm81WlFI?=
 =?utf-8?B?SVNJeFFlcGZBVGNHaHJzQzNlYkM2YTQyblNRZ2lpY3lMTndwRzUxMHpFMjB6?=
 =?utf-8?B?bVZUUXdtZVVZUHdPQ2hYbUJjdjJRLzMzaGNweEJtejErM2oxSC91VGVSNm0w?=
 =?utf-8?B?TzNWVE5aVlRHcS9JUUpiTjZtUzlTNmF5dHhNVmx4TXViTHFnL1Q0Ym9xTytl?=
 =?utf-8?B?VXlOWjZEdGMrV3QyMDZ2U09hdEo5b1VnZ2UwZ2piN3g0c043TWlRc1ZtSG1T?=
 =?utf-8?B?Y3kvdDVGaWtYMThUbmdzZ3V3QWJ6QllvbUtNMVVsbGxrZHl1RC9xdW0vb0RP?=
 =?utf-8?B?ZE5seDdyODc4WmFtbWc5aUM0NmxSWG9kRWZQYi8yVjVtcm5EdTRNTjNCRWsv?=
 =?utf-8?B?ZUZCMjRrUUhtZW51MC9nVXVTRkVFWk5WMTVTU2RYdmhTR2hYcXFsRFBiMm95?=
 =?utf-8?B?bjVOdVlNQzFwNTFTT1ZiVkV3eDhNSnhyQ1FFOWNXLzlUUlNBdW82b3VkVWJR?=
 =?utf-8?B?SndWek1vOXVONmtqVlVUY0hoZW5Ma0xoT21OYWJLTWZDMFFweFJPYlRmYUpB?=
 =?utf-8?B?MFd1RHZjUWwyenpvMnUyT3NyNlVPZnJxK2FrK2FFckU5UTdYSEdUT0tIbzUy?=
 =?utf-8?B?U3VMN2JqRFNFQnJmNEphamxrYUlsQXhnRG4rbTU1L2t6ZXdMa1dxL3VOT3JX?=
 =?utf-8?B?cy9xS3lJRUR0RWpIWnNWK0dlY1ZiWUFiVDE0NmdyaGhkTk9GakEzR25XV3U1?=
 =?utf-8?B?MlY3ME16ZXBKZ3R1MTF2UnFhNS9CR2JNRHQwc2pFWHF4b3VrMWdEQU5Pbkto?=
 =?utf-8?B?bzVaN3RIdmZjMVg5MlFXQVJBd3Y1a1JpUHpGMDQzQklwZGIzS1p6V1ZJU3ly?=
 =?utf-8?B?UUZ6bDgrZ0xoREN6NzNjTlBPVGVXaUNJMlpXeUwwZTYwZXFTWmVqem82RVcw?=
 =?utf-8?B?NXY1MHZtMHpOY015MDQ5ckx0TmVsZmFyd05wV2FZd1NObWhpTjAzYkJBZTB1?=
 =?utf-8?B?ZUN5SzVRbldlWjJzcFFqcDV0eEhtK3pmb1VJNEdrdEt4bDF5TUlqdjMzYnlv?=
 =?utf-8?B?akpLNlJTY29jVGVyaEhsWlR0VlNDUXZrWEJjTEhTRGEzZDdCcXl1ME0zZ2t1?=
 =?utf-8?B?R0hxZEVyNmdQeFNwSjBHbTdINE1PSW53MlNBSFFRT0ZESUYxRjJUdFR3SG5l?=
 =?utf-8?B?VVI0MmpMZW9ydVI3aXdEdTBEb2VRMFJYeFJ1MVVpTFl0aHRibVR4L3BtZmhI?=
 =?utf-8?B?UnlIdGp5SGhFcGVKUEE2YnZiajNKQ3BKdkl4c3YvQTYxTDlZd2JWQlZQOXl3?=
 =?utf-8?Q?dBU+gjumOuJnx5rjpSlh9C5zu/blPPbn8RV4t1lyMk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2U4Hl9f6+dPFlXVO0EoW+gITgaQB82NCyf1htJVw4J0ZR5thvb9FWLL/+Joj37xPdYDpOnbkzXBj2c+BNEZ/TOwrMEg3zIGImGEqn8pnPVS8qpHzou31xIO7J6/I3aiAyz/EUHBTqmfq8vaiX/88t487IGeJtcjK0OBVpd9OP0xtHyIgD5Z1+CpdyJCnbYMK2mHDO9WBGxSfgmxr+5H0Ab34tcJyjfjdZePenETEnYURndPnrqPPP2Szka/FD1cn7pBYQcwPwtUtS9HThj1dEKFb+QIAtIrCyM9WZTTUMc2t++X7ExQNXVQrdXJ8gKTEFtt3wyWEtXUYhESGhAbTn5rKigDiKzoNzcCr/JTZNvAlkzxS0JysgO72ngiT/zgTEp/OAuT7XTpntMHmnx2wfcJBkbaqhdjL8XR5NKxKCPG7RyG4uLTLnc1UkVjD/fAQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:00:43.2755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e4577b-ec77-474b-2978-08de62743859
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148
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
	TAGGED_FROM(0.00)[bounces-16349-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
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
X-Rspamd-Queue-Id: A8F2FCEAD1
X-Rspamd-Action: no action

From: Chiara Meiohas <cmeiohas@nvidia.com>

Move the async_ctx initialization from mlx5_mkey_cache_init() to
mlx5_ib_stage_init_init() since the async_ctx is used by both the MR
cache and DEVX.

Also add the corresponding cleanup in mlx5_ib_stage_init_cleanup() to
properly release the async_ctx resources.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 3 +++
 drivers/infiniband/hw/mlx5/mr.c   | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 90daa58126f4..629d09fd08bc 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4160,6 +4160,7 @@ static const struct uapi_definition mlx5_ib_defs[] = {
 
 static void mlx5_ib_stage_init_cleanup(struct mlx5_ib_dev *dev)
 {
+	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);
 	mlx5_ib_data_direct_cleanup(dev);
 	mlx5_ib_cleanup_multiport_master(dev);
 	WARN_ON(!xa_empty(&dev->odp_mkeys));
@@ -4225,6 +4226,8 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	if (err)
 		goto err_mp;
 
+	mlx5_cmd_init_async_ctx(mdev, &dev->async_ctx);
+
 	return 0;
 err_mp:
 	mlx5_ib_cleanup_multiport_master(dev);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 325fa04cbe8a..56687add34f7 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -979,7 +979,6 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 		return -ENOMEM;
 	}
 
-	mlx5_cmd_init_async_ctx(dev->mdev, &dev->async_ctx);
 	timer_setup(&dev->delay_timer, delay_time_func, 0);
 	mlx5_mkey_cache_debugfs_init(dev);
 	mutex_lock(&cache->rb_lock);
@@ -1041,7 +1040,6 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 	flush_workqueue(dev->cache.wq);
 
 	mlx5_mkey_cache_debugfs_cleanup(dev);
-	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);
 
 	/* At this point all entries are disabled and have no concurrent work. */
 	mlx5r_destroy_cache_entries(dev);

-- 
2.47.1


