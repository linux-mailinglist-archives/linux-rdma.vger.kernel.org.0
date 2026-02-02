Return-Path: <linux-rdma+bounces-16356-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Pc3KsrNgGkfBwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16356-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:16:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3D3CECC0
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAA42314DA2D
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBEA3806D7;
	Mon,  2 Feb 2026 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iQamsAp4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013067.outbound.protection.outlook.com [40.93.196.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183627510E;
	Mon,  2 Feb 2026 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048096; cv=fail; b=tmoPRNpiRFiiIF3exiehN+mcaoiHRFqpCXzTnkjKL8KjrvlccpyciDavXUpHc8rznfzSWyEEiyDY5N/YP+HSxYiwQgzMIiixnU7uPcI0lg3DBums9ZAV/1xj3EAfv7B5Wzi4axvfNYpV1WPZyKNDMc2PUDkF2gtRKv/PwveXSb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048096; c=relaxed/simple;
	bh=1scGxlhH+Eez/rUPFRmPY3vWHdBUB/1sfpA54UDD1t4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ga52kO/ZGZJ04efVo0/ZAbOKDf082GJa47ULvayNOEEWlxM7CQqz510AsGDp7FigA8fCN0z1BDbk9mPnFZRWsSlkx8G0jv9hzmQtc78DVSK+g+kQ6sSxx3FVFvdxE8smIiej/IS87HjBtApB6yCApZEEK/YO/FRc4WYQtkfviCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iQamsAp4; arc=fail smtp.client-ip=40.93.196.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqKy1d0ZmwL8qxuSLfeRzGVF9Nabpb3VHjkHOOgC0kL1c+A8+RdwUjgVVEpbRjU0pK3KWK1obnV238JRu2YEFx/apda9Bj+iNx5Xzb+bixRpPc98vlDzeN087EXeESqxwByEn5d+SBVmqvB1hznOlD1oJJQ6fcLjlU2lIbPUC1me3GTJoh0LLQ+zBsJAdf6+FlYh720YynJLGxUxRJMBzpGlTRI7j3wNrf8v5ncGi5GMiEmwybApRN5hrjYCeWIwGeDRQI/3TjIEOW5/t4+oQShtsAVTr1z6lwt9XkbNZHXQK9nbHmNoy1rCMv6aM/CV8w+QC0qg5692TpDnbEKr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lUiZC8VMEE1G1zYDLtlRvq7p9sXYZ4fseLcy7X4IGg=;
 b=sz108kqViJPbFOk/KRKWi8AshcSa0JciZKjZdaUbw7q42PiF3reeOv5sMFQm7MAn9AfX+F8fPcPtiUfuAIPdYsA7xe0NnfCosfhauqHekqLG05jp2E0U0lkj+GXNb2gocFLu9/qb4twvOVll3QjmCcNy30P2pCEpa7XMDxr0RqijBAle0AqUjIvrBWOxmaflqbDIcvi9zBtuS99vYbdUNaw1si3j0MduE6wYRrxQ1pQOrkSsO80gE/7pof8DORUgaOXorCmf0pPUHD22Rsdd/ZqaGzXKoZUwlhYNrhU7PmTFvp+nfYJGjbp1dhXWrcuJo74pZiUnRc4EtkJlFp+UnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lUiZC8VMEE1G1zYDLtlRvq7p9sXYZ4fseLcy7X4IGg=;
 b=iQamsAp4ouSHxRBr6V95yPIL57PE/fKiEAxmPaW1Jgd4GkC9hDFdPHj/eub4RdQDrQnHut9+F3abgtCRtCRKteTYNWE7Y7csgWtJllh+Ro3pq12qdYjIJG+fj3HL1wb1MXxb0ynveGmkBZ8qv8Wl77C5b1l//cGlsYPs6YK7leS0FjYPjAu46MG76JZTGHSfJH9JcWF9uotWZmWZK/PIbl4DioTYb1J+4ex4wsAaeutquY9uIhZniFflLLcZqMGOiZJUYKvf1tjbP+LgTS+3/CZUoWRjO/kznjP0tD8WNKCrtxxAoa/0BTNUS7ON0eBl+xvD0muNQPR2R0y7bplnHQ==
Received: from SA9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::7) by
 BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Mon, 2 Feb 2026 16:01:26 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::1a) by SA9P221CA0002.outlook.office365.com
 (2603:10b6:806:25::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 2 Feb 2026 16:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 16:01:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:01:00 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:01:00 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 2 Feb 2026 08:00:55 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 2 Feb 2026 18:00:02 +0200
Subject: [PATCH rdma-next v3 10/11] RDMA/nldev: Add command to set pinned
 FRMR handles
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-frmr_pools-v3-10-b8405ed9deba@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770048005; l=5422;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=whJjXh7f0Iir5lsuc4vlsEsgCT3DIZpbQeN0p7Xz8Ns=;
 b=Xi9M/CBGCsn/z2HPzjDUz/nWFKsBirSwsyfyRBNUhCqrvDvB20Q8cb+dulROFuXJWCwc9u+oS
 WpAq30IZqEcD+zod92KytHOJxf3IJYETOTOe4UpZd/09BHVA+82VkQm
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: bc660138-7df3-4498-279b-08de627451b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEVKdFpCNTVNOWtnblprYkIxTmQ4N2NKYjJ1VExFTWtxd0tqazViMkVSUGQ1?=
 =?utf-8?B?RTFZdnEyVUxacHNYV21Wek9XR3dSYVJmcnZ1cVhYMGxZUFJMOVh3OUgwdkYx?=
 =?utf-8?B?amIvamYzM1BUM1R6ejA3VjBCNlZJaEFPQmlRTTB6MnNsYjNWcTdYR2RadUlU?=
 =?utf-8?B?YXh6TDRHQ0Q5S2NqYmg3NTBYYUk1OWFRRDdpVzJ4SUhuT0c2aWY3bzRqSkJO?=
 =?utf-8?B?dUtYcERDWkdRQkdZNjg4T0o3dEZXS01QQk8wYlB1MGhQNmRJTzJuWDN2dWNJ?=
 =?utf-8?B?SFFaZzdsc1IrclB1cTFnQnQvYms0eW1pdytQL2JERThBWGdWZzJpZ1VOYzNm?=
 =?utf-8?B?cldLbFByc3A4NW9EUzB6LzVwTm55eG1YTlhwTExqM1Z2ZTB5ejNYOUM4YVZy?=
 =?utf-8?B?d3pYK1pDd3R3dlJNa2pBS29ZQlBtdVF0cWxiREZSVkdmdkl5M1J0VHRBZXNp?=
 =?utf-8?B?NlRQRzhwaVhNYi9uWXNzb2dpMW90Q09SeTIzQjBnUkM4MW9GSWh5L2g1QXlZ?=
 =?utf-8?B?VHN4bG5RcnJkakhCcldRUFJQUnJlZk02MnNKWExJK2VBcGJ5TVZDVlo0S25u?=
 =?utf-8?B?MTZkeXhpbUFvTnhDSXluUG1hYTNqZEFmMHhRcHJ6NjhlUzA4VGEyZnFKeG0y?=
 =?utf-8?B?aHd5NVdyeFdQcGE4aG95ckcwc1lCODNSUWVsenVkYm1rbG90UVJvcVRCSzNr?=
 =?utf-8?B?YWNEUTRNNk9RNVFZc0V6RW5tcDE5aGhLcjlnTklQamV4dWoxYkR1YjYvdUg1?=
 =?utf-8?B?R0d6S2hKdU1QSXcxUW40bk0vd0U0bTBjbGVMdllpaXJvcXM4RW5IUDhpM09a?=
 =?utf-8?B?OUhKY3A2ZXNZY0ZHbHlzdVNPY3V2WVhjTkZUUDJRSTRHUGUwNGZjY0ZjYy90?=
 =?utf-8?B?Tng3a3NQQ29jU2ZJLzlSUWV5a0Z5bEZ3N1ZmRnl1Rml6bjB2ZFI2U3laOStC?=
 =?utf-8?B?YVhONGYveVovSjIxVDlMNEtCVDc2SjRTdEtKSmZBQmlaUkc1dlMvVEZjM0ky?=
 =?utf-8?B?R0hXdDNqaHp3eGxZek1mdGJkOXZQaUNhaXd4ZmtEcXd2T2lGMVZFSGdJUEl3?=
 =?utf-8?B?R2NkZ3p0VU9yWjF5Y0VYTENZbXBxck1lYjBoUWd3K3lyZUx4TUNXYSs1Q3FB?=
 =?utf-8?B?KzVxSDNxVFZ0UjdTZnBWRHFwS1hVYXRqSkdpT3dnS1BmcGpYOGIxVURmK2s1?=
 =?utf-8?B?dXc2QW1UZWV2K09sd2czeHcrMVc3MG1LbGVrZGV4VTNlSEFMMmNYUU1GOXND?=
 =?utf-8?B?OGw1WW5XMlhzSzdDR2dvQ1ZOYUpqdm00VVgrTXdHTEZoTmRwMVg4b2RST1JE?=
 =?utf-8?B?ZFZoZVM1bFlOcnB3UHE4TXE4UHBkbXZ3bHgyWjJYYXFOSGdDcXF4enpDa0sw?=
 =?utf-8?B?ekJZQ013T0lhWjRpYXdYWkhZKzRudXF4MG56dFZ4ODBaUXNmUVk3TU9PRno4?=
 =?utf-8?B?ZnMza1JVSXdzVVd0Uzl6UEVkazZnMk8vMXBlU0FHclRjNDJmQmFCdlpCZlc5?=
 =?utf-8?B?VGwvVWN1dmMrR1NNelFvbzl0dlBaQjB3YnZZczkzWEowNnNqUGtOWjBRTkpo?=
 =?utf-8?B?dnhCN2RrTEJCQS8zeGNyL3VEdHhKRE9xVFdoUFZvMExRVE04a1Z1ZC9VZkwy?=
 =?utf-8?B?MXQ1VWxQek11MnFKaHl1aFQ1YWx1MDJhRUNUYjc4NWFnZVk5YmQvYXAwdVUx?=
 =?utf-8?B?cWVWM2poQnc1cE5QbHM1dzFKTkVtSlJ3R0xhNmNKc0M2YXliODhDbFd1N01K?=
 =?utf-8?B?ZjNnejdpN1ltcnpEWHFROXRYZWJxWk55MVc1VHpNazg3dlBYZjF6dVd5bm1R?=
 =?utf-8?B?UFVvWlJBNmpTUWxucWpyeTBVWXJ1QjVYZHdMb3htV3lDVXpYS1BNMkJTRFJY?=
 =?utf-8?B?QmVMRUJVOWdUaFF5T3phUDhSQnJEL1R6cTVoSjBzL2JFL0NCS0V0VkFhNE4v?=
 =?utf-8?B?MExLWS9HTXJ0UGZkS0IzaU1MdDMvVnE1aGFkcVRDRlNXVVIzRFNIRmpTdmd6?=
 =?utf-8?B?Vy9oQjJ6R3oyVVRTUjlldFJhT1FtTzBFc0FybE5qNGNaSEMvWVhXc09aMzUz?=
 =?utf-8?B?SmlWdkhmVDFxN0t2ZjU3NmYzaGMvK0Y1L0t0NzhocHFCVGpWWW10ZEo2cU9r?=
 =?utf-8?B?bSs1RXpWdDdhNU9LR01qd0xsUVU1ME13OFRLajNGOWpmbFlVU0hsWFRJcnN0?=
 =?utf-8?B?bzYzbUk1MTFqUzJSbkhpYWVIeFp1d1o4TXJkdHlzMW0zTGNHUXRhMnBBSzFy?=
 =?utf-8?Q?QoE5oYXBS71q2QqmlErkAXsxKxZRwlE2xWMbCjqrTU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DfR9+30IYfgQaNolbhALN2xGGuKSAZ9rzPaBaCnlMQaXNm5eFUiT05mBJ8R00PpMRJ6UCZdxDv33itqIBRuUqa8YbDodrPeiT5NUtG1wrKTug8sRokeX8wkBPUpEYMP440zYRZB0rhTAYE23lgZIABG0FYp3/GlrXZ2bWHAY3SyyfS1LSuC1Mb44hrtuUe3MV6tQTM+/zD1xbVwOU+xLYNgT4T1q80gmBY7XYHmYUIdE9viK/956kRPoY4JrAESoQr08CIhnKGI1eZpOOsoecYmNkQFE6PThgvSwXFVA7tHdtbOdRIX29NnRYwvy+sF3G/r0Zv93tNpNevhqfO3/wKTuoI40/CG5+wuUlYygFecTNuCNVUKVN3+cZ/Y+4Tw56e2egtqt7ywb/Ec9yR9AqfVg9sz0lAWybsheKmOJhnNUALpio19sk7S+zopQB30C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:01:25.8504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc660138-7df3-4498-279b-08de627451b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
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
	TAGGED_FROM(0.00)[bounces-16356-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
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
X-Rspamd-Queue-Id: 0E3D3CECC0
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Allow users to set through netlink, for a specific FRMR pool, the amount
of handles that are not aged, and fill the pool to this amount.

This allows users to warm-up the FRMR pools to an expected amount of
handles with specific attributes that fits their expected usage.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 88 +++++++++++++++++++++++++++++++++++-----
 include/uapi/rdma/rdma_netlink.h |  1 +
 2 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 8d004b7568b7..0b0f689eadd7 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -185,6 +185,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD] = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES] = { .type = NLA_U32 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2692,6 +2693,9 @@ static int fill_frmr_pool_entry(struct sk_buff *msg, struct ib_frmr_pool *pool)
 	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,
 			      pool->in_use, RDMA_NLDEV_ATTR_PAD))
 		goto err_unlock;
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,
+			pool->pinned_handles))
+		goto err_unlock;
 	spin_unlock(&pool->lock);
 
 	return 0;
@@ -2701,6 +2705,54 @@ static int fill_frmr_pool_entry(struct sk_buff *msg, struct ib_frmr_pool *pool)
 	return -EMSGSIZE;
 }
 
+static void nldev_frmr_pools_parse_key(struct nlattr *tb[],
+				       struct ib_frmr_key *key,
+				       struct netlink_ext_ack *extack)
+{
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS])
+		key->ats = nla_get_u8(tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]);
+
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS])
+		key->access_flags = nla_get_u32(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS]);
+
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY])
+		key->vendor_key = nla_get_u64(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY]);
+
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS])
+		key->num_dma_blocks = nla_get_u64(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
+}
+
+static int nldev_frmr_pools_set_pinned(struct ib_device *device,
+				       struct nlattr *tb[],
+				       struct netlink_ext_ack *extack)
+{
+	struct nlattr *key_tb[RDMA_NLDEV_ATTR_MAX];
+	struct ib_frmr_key key = { 0 };
+	u32 pinned_handles = 0;
+	int err = 0;
+
+	pinned_handles =
+		nla_get_u32(tb[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES]);
+
+	if (!tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY])
+		return -EINVAL;
+
+	err = nla_parse_nested(key_tb, RDMA_NLDEV_ATTR_MAX - 1,
+			       tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY], nldev_policy,
+			       extack);
+	if (err)
+		return err;
+
+	nldev_frmr_pools_parse_key(key_tb, &key, extack);
+
+	err = ib_frmr_pools_set_pinned(device, &key, pinned_handles);
+
+	return err;
+}
+
 static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 				       struct netlink_callback *cb)
 {
@@ -2803,32 +2855,46 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 static int nldev_frmr_pools_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 				     struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
 	struct ib_device *device;
+	struct nlattr **tb;
 	u32 aging_period;
 	int err;
 
+	tb = kcalloc(RDMA_NLDEV_ATTR_MAX, sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		return -ENOMEM;
+
 	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1, nldev_policy,
 			  extack);
 	if (err)
-		return err;
-
-	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX])
-		return -EINVAL;
+		goto free_tb;
 
-	if (!tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD])
-		return -EINVAL;
+	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX]) {
+		err = -EINVAL;
+		goto free_tb;
+	}
 
 	device = ib_device_get_by_index(
 		sock_net(skb->sk), nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]));
-	if (!device)
-		return -EINVAL;
+	if (!device) {
+		err = -EINVAL;
+		goto free_tb;
+	}
 
-	aging_period = nla_get_u32(tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD]);
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD]) {
+		aging_period = nla_get_u32(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD]);
+		err = ib_frmr_pools_set_aging_period(device, aging_period);
+		goto done;
+	}
 
-	err = ib_frmr_pools_set_aging_period(device, aging_period);
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES])
+		err = nldev_frmr_pools_set_pinned(device, tb, extack);
 
+done:
 	ib_device_put(device);
+free_tb:
+	kfree(tb);
 	return err;
 }
 
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index f9c295caf2b1..39178df104f0 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -601,6 +601,7 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,	/* u64 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
 	RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
 
 	/*
 	 * Always the end

-- 
2.47.1


