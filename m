Return-Path: <linux-rdma+bounces-16347-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DWdKkHLgGl3AgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16347-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:05:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ACACEA41
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EF12301F9B3
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 16:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6DA27380A;
	Mon,  2 Feb 2026 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dDQtwksU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FCB3EBF17;
	Mon,  2 Feb 2026 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048050; cv=fail; b=UxXZz22hspD95lVthqSsF4ziPHi24vXpB231OHESJb/pWdFOuH5xK4cxtE9IxmNZsYY6UVix8Wtzfons/u4PktBFHxeKgeqwoI9ekJd1J7uCTp+ErdcZJtrv1QfrNLxwhBP6PQ9p3gsLg+P/3FslQx+BuMOMNtOe53Iw3sUniWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048050; c=relaxed/simple;
	bh=mbkr4qLyCFbw3GFB/meu/pft7TO2fhSxHuhEiRZ6HRA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=m4SB5VXNQ7ca5JBdLNzTvd7Ps/M9OUf3z8qDRYVs4z+V9fyfUqrrFoJf7ROUIeAfje5SU4yWE5UPdUkWtG2WwbCpiIE4TghlUxOP6QPYXZuZiVeWQDW8XhPKm1x1yPUnUK3vAzZHl5u0p0ev+uQk/+5FxtDrMcawYnBLN+BCrdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dDQtwksU; arc=fail smtp.client-ip=40.93.195.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJ2v8xWwZTdSshYWT5vPRSBaS/4p9unkiH8lCw68gS+vK2OXtWNEPEMpE3qkj4d6eOfnAsl7IfLtsaw9Ol1XO8SoZfrmau8OQWqiOaoNNDAsEQJphu8SOrYesEsFGlJX2MxOBSrUE9nsGqPfR4mshQXYLucps4czZWoh3CTIqUB/iL6mEzmRBHscCJrcNnOc034WUzU14HVGwGjr7yIIL6GAZlBDpfh+xqrtNKzsUnxu1Nbf2dB0sdN9agxEaozOjpScFhOLFje2iwHJhQexvgsD2GNHB9p/AtvyZugKkTHFcrVnnwot41MYf3ychw2kVO4CvAMmVNcjqqgtdWh8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7gzyBRimeDGPiFmrIlQ3+QIU+qOit8UyFn4XMrRYH0=;
 b=smoNtV+nWw9/Awsla6KU0uCE8YC7MGn467G8BXwxwYThR5ZM5PY3ICRkdhZCWky35OuVET1+n3Zkojxhgho4se2QjX+rgPDe+ebrYC3/GMhQpvhhfDmoTr0/RVPPFNIHOB2oRd9pKHBjh5H4VzBbZJanyv/ieJR4L/rr6SqXWyd8zyqwWUUA0siEH2Mu9RTPa5y3PpKbEnwjp6LwpOc9clsT1GUYfGFYK4jM3UKuBLDTF5WlO/b3XNZc/imZEyWHyfTDPsAWVc/2CSsrSeIXdg22uNhUQ7r42QRMeyWUX0mm6TDqviMdUBtPXlYSdibWDh/FlGKFRGi2hiTn+eHPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7gzyBRimeDGPiFmrIlQ3+QIU+qOit8UyFn4XMrRYH0=;
 b=dDQtwksUjDvpobMBmmJyS+qQUR9XmppD8Aaca+wEiBP8MFHEXZP3T7aHi/JLuR0zBv2AtepaW41350mUzNz9Ai87bilNUakI/aGtB6Ri8sLxVgW+zbnRaKkpI4sPhJhn/++D+74jttHOeTFOIh672/zltdDwBC0mJddEhFsotSV98e2JxKpkWZJDfBpWOAtCAm96SFwZGi8t/h/u4VlOra8VMARvocnKmn6xHbG1WsXCxcKQ1qQ1yspH9k+fVvouXx1TyyKk4rpUtR034UfxrunYyOS7HH/+DgmAXIFESG/yzG3NCfvYpCpKWZhYol7RHwdntaHhgSVGJ/oUWpz5Hg==
Received: from CH5PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:1f1::18)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:00:40 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::45) by CH5PR03CA0018.outlook.office365.com
 (2603:10b6:610:1f1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 16:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 16:00:39 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:11 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:10 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 2 Feb 2026 08:00:05 -0800
From: Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next v3 00/11] RDMA/core: Introduce FRMR pools
 infrastructure
Date: Mon, 2 Feb 2026 17:59:52 +0200
Message-ID: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPjJgGkC/22NQQrCMBREryJZG2l+TEldeQ8Rib8/NmCTkpRQK
 b27IRspuBxm3puVJYqOErscVhYpu+SCL0EeDwwH41/EXV8ygwaUEKLlNo7xMYXwTtxqkIiKtFG
 aFWCKZN1SZTcW+9FwT8vM7qUaXJpD/NSbLOrgnzEL3nBFT4naKuzwfPXZ9c6cMIzVk+HHAsCOh
 cLapjVdh8YoqXfstm1ffGnwoewAAAA=
X-Change-ID: 20251116-frmr_pools-f823cc5e8a58
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Chiara Meiohas <cmeiohas@nvidia.com>, "Yishai
 Hadas" <yishaih@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770048005; l=6159;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=mbkr4qLyCFbw3GFB/meu/pft7TO2fhSxHuhEiRZ6HRA=;
 b=C1nEjWBDPnpBjNcpMwz6Gs93F5cq/ApSuCNXhWGH/Npf2U+9eec9+Q9ROr/vLg3m8G63OehFP
 ai2oku1bxSrCeQJm/GVp+xMDt8MdPvKYxm0ZBhoYcKAiS0DCyIF4gCy
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fddae5-3023-41a9-2e47-08de62743651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHBqaEZhU1Q2emw0aE44M2xSY0s0K1VPcXE1cGV0K3psUERVSkJwTGlaM1pk?=
 =?utf-8?B?UlpBc1NZVXQ5VTNYazBSaC9LeXhlODJxUkRwTnNCRENJNDNJT0hyeVNSdkIz?=
 =?utf-8?B?YTFNNVhaTU1mREtmeXJISS92czR4eThOQi9IU1d0N2lsWDJQczFFcjRvalZJ?=
 =?utf-8?B?bC9Oc0VVbThKdHErVlVva0s0R1NWTndUZEE4QTNzR3JtUkNYY2YyNjZ4MHBX?=
 =?utf-8?B?RDU4SklYaUpJU2plMmVIS1YvSTRDN3c5L0NZTCs4T3JOYlpsa25yM0Y4MUU3?=
 =?utf-8?B?YU5DU1Fzazc2eXJCS2JYbXdLQ3QzOW5Mc1Z2VUEzOFZPdzhSYUo1dkNUSTU0?=
 =?utf-8?B?Mm9sWDhjMkZwcldXbGgyVGlpZXdtQUxXOGNTZzBDZzB6WW9DTjE3Wng4MEw0?=
 =?utf-8?B?YTZQbXREV20rWG5rbHlhSnpDZFVBaTFDamYyTk8wNjhkYzRPTC9GR3VrRU1S?=
 =?utf-8?B?SkFKcFoxaGw3QmNYSVczeXlkWm1RNDBucDY0Nm9taElPZzNTWEtiMnlVZ0lo?=
 =?utf-8?B?VXlUelhya05SV1VsQ0g3TnNsclhoRHFLVnU1SHMwek5uSDJQZi9aZUQzck1J?=
 =?utf-8?B?YnlYUWx1SEpEakR1aTFqcFp0dER6cmszWk5rb3ovL3UxLytleldLQUlGdHha?=
 =?utf-8?B?RXN2SUdFY2pBNFllQW1UMmJ3dlJscWtvZFEvMlZEeTh5SXpDODRaY0t5eDBM?=
 =?utf-8?B?UDlPUFk2cDdEZWV6dWRXckFaMmdWVVllSlhBTlhKNWh0WkxBWHRVdUIzNDlu?=
 =?utf-8?B?azNIVUF1QlVveVA1bFZybHVCYjllZjVRTkczVWk4QzdNbk9QdmZrVXBpTmEw?=
 =?utf-8?B?Y3dzM0ZvQzFwRkRscUxGQlJOU280aTZzRzlhT3JzQVNBU1Z6OHJGN1lZd1Rs?=
 =?utf-8?B?M3N6YzR1cVRVeWJ3NUo3RDNzTy9sUlI2ZEdUTFRiL3YwVWEydGJ6bVZGWFU3?=
 =?utf-8?B?VWFzTGFPV2ZNZytkMXFkTnlsT0c3T1FCSmhiRnF3MTRZaTFJSXFGUGo3OVBK?=
 =?utf-8?B?a3diZEd0a3VXbENRN1JHajZUeWtyTVhmMFA4MHFqdWFPMCt2Ky9TT0w3ZVl3?=
 =?utf-8?B?bTNnSGRLVHA3NThHWHpoSFQwZE1LZ0VQZnh0TGhtSXh3UDcwRjl1NlYxd0dl?=
 =?utf-8?B?b1htOGp0a0ZsaFBwdVZqTnlZWFZtSDNOandXaVJmR0hzejY4a1hpRk13RHhU?=
 =?utf-8?B?WkFBaEExaFBxZjBhbDRnUXdHbndWMUgyUnMzakJIV3BRSUwwZzJybkdWMDRZ?=
 =?utf-8?B?MGJrTE9lZUVJY1NTMUliK3gxdjlIbzVsdkhwZ2c3R1A5bXA3NmV5T2RYMm0v?=
 =?utf-8?B?VGV1eXlsL1pOa0M4Wk5jYjdIcTM4akw4UFZsbDRFSXhRSkFGY0JVNHlUUElZ?=
 =?utf-8?B?d2RleHpZaEZBRlNpMlMrdFlkSG1udldBRTFtZEtKRFdWVlJFM0VDK1ZETXdq?=
 =?utf-8?B?VVdXKzBhd1dSenhUb3luRnZ4WE1vUU9jYmUzNDBZZXM3a0dKS3dlbDhJOTd1?=
 =?utf-8?B?RjlQb1UxRThlN0N6eG9WOEFyS0JQc21sYUZjZTlGVXhFSlZoYjBJWW1MZytE?=
 =?utf-8?B?U0hPZ0taanlCcmNPUDVWTDNnOTl0OXgrQUFLK05NQTA2Ti9zYmo1S1ArQnVh?=
 =?utf-8?B?bDF6Vy9EdmFvcTNFNmlXbi96RGgxSG9sUERMdDB4aFNmN2hlamJZTGFXb0Nj?=
 =?utf-8?B?eitPL3YyUFZMM24xVitFNFR3Q1ZiUjdIOHduL1V5QUk4WGlhRTY2bnV3c2Y0?=
 =?utf-8?B?UTkxRWZjNXVXdjlRSlNQaWxkWE81dytmdks3WXBzQWVWeEtTVHZyT0cxcHdH?=
 =?utf-8?B?WXg2cjFSSkoxSVJlbHAyNlY0WXRJL3JFQUVIbzF4NGd6Y210TTdhNUU5cGhO?=
 =?utf-8?B?RENWdG5sbnFta0J4TUM5WUNzWTUxa0RqcDFxM29PNnBYa0o1VEZFY1M4SFVn?=
 =?utf-8?B?R253NzcxbnZKNmFXaGlNS1VUNzY1VTZTdkhYTWQrRThaQ05IZFBSMGx2STBB?=
 =?utf-8?B?VFdXTXRyYTIya0dXTEJkcEZnV2xZeWhuanVvN1pwSUNabS9UdVNMNUN4QjZD?=
 =?utf-8?B?dkZlOU9EbFV0MHZ3a1UwSDk3M1M2V3UvN0p3S002U2IrbTRIdHAzcmk3S2w1?=
 =?utf-8?B?R2d1Wnd2MFdvVjVjeXRFeWJDeWdSelF5dFROREFUY0VmNXdkSjBYOHVpYkhI?=
 =?utf-8?B?cXlZRnkxYnJpRkFrOFhSLzE4aGJaa3dQdm9ndEVPN0R5UTNqdE5YVXFYS1Ry?=
 =?utf-8?Q?IOO99naDZDedu8pwATOk5hrxrfRmygGq1tkJBR79H8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XXMcp7TJrx9/+YHbE10ONxWEUrtMJiG3q4GqNdzLqpHKdyTSj6eQaynEs8yREjYLIrN3XbvPw6avUrB6PbzyWSAOg9Zj0IqVVCrwpKVSd/kcw/lfo188ZL0S80xX05sCpKeSFTH0ycVBH80Mjasz4jugBXktdyrKSWSsyNHVUiiNSXTgs6eiy7EDpCf832kUUeZEbvWFFXYj5L6PIOmM7F3d2WBJCnI7jZLKMZnn6ZVetK/HXQ3cOtMdoHqU8GPb4jRIcnlnG9xyIPjM6MB9uv/ny45T/s7GkeaKw9ah/oIH07+F2vyI9bAW4mAdR/ehVFoiSlAo6QLsL+vnlyxMPBFBeVkwnbf49ZwUoCj0xLaXEd2ditg6iruW+IPwq9edRPYBmw+e3nB1zJB3+zCdExbKkHM+5vLcpTcwOneRPVbs4jokiRMKRQBVdfo6BsoK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:00:39.8638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fddae5-3023-41a9-2e47-08de62743651
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-16347-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 52ACACEA41
X-Rspamd-Action: no action

From Michael:

This patch series introduces a new FRMR (Fast Registration Memory Region)
pool infrastructure for the RDMA core subsystem. The goal is to provide
efficient management and allow reuse of MRs (Memory Regions) for RDMA
device drivers.

Background
==========

Memory registration and deregistration can be a significant bottleneck in
RDMA applications that need to register memory regions dynamically in
their data path or must re-register memory on application restart.
Repeatedly allocating and freeing these resources introduces overhead,
particularly in high-throughput or latency-sensitive environments where
memory regions are frequently cycled. Notably, the mlx5_ib driver has
already adopted memory registration reuse mechanisms and has demonstrated
notable performance improvements as a result.

FRMR pools will store handles of the reusable objects, giving drivers
the flexibility to choose what to store (e.g: pointers or indexes).
Device driver integration requires the ability to modify the hardware
objects underlying MRs when reusing FRMR handles, allowing the update
of pre-allocated handles to fit the parameters of requested MR
registrations. The FRMR pools manage memory region handles with respect
to attributes that cannot be changed after allocation such as access flags,
ATS capabilities, vendor keys, and DMA block size so each pool is uniquely
characterized by these non-modifiable attributes.
This ensures compatibility and correctness while allowing drivers
flexibility in managing other aspects of the MR lifecycle.

Solution Overview
=================

This patch series introduces a centralized, per-device FRMR pooling
infrastructure that provides:

1. Pool Organization: Uses an RB-tree to organize pools by FRMR
   characteristics (ATS support, access flags, vendor-specific keys,
   and DMA block count). This allows efficient lookup and reuse of
   compatible FRMR handles.

2. Dynamic Allocation: Pools grow dynamically on demand when no cached
   handles are available, ensuring optimal memory usage without
   sacrificing performance.

3. Aging Mechanism: Implements an aging system. Unused handles are
   gradually moved to the freed after a configurable aging period
   (default: 60 seconds), preventing memory bloat during idle periods.

4. Pinned Handles: Supports pinning a minimum number of handles per
   pool to maintain performance for latency-sensitive workloads, avoiding
   allocation overhead on critical paths.

5. Driver Flexibility: Provides a callback-based interface
   (ib_frmr_pool_ops) that allows drivers to implement their own FRMR
   creation/destruction logic while leveraging the common pooling
   infrastructure.

API
===

The infrastructure exposes the following APIs:

- ib_frmr_pools_init(): Initialize FRMR pools for a device
- ib_frmr_pools_cleanup(): Clean up all pools for a device
- ib_frmr_pool_pop(): Get an FRMR handle from the pool
- ib_frmr_pool_push(): Return an FRMR handle to the pool
- ib_frmr_pools_set_aging_period(): Configure aging period
- ib_frmr_pools_set_pinned(): Set minimum pinned handles per pool

mlx5_ib
=======

The partial control and visability we had only over the 'persistent'
cache entries through debugfs is replaced by the netlink FRMR API that
allows showing and setting properties of all available pools.
This series also changes the default behavior MR cache had for PFs
(Physical Functions) by dropping the pre-allocation of MKEYs that was
costing 100MB of memory per PF and slowing down the loading and
unloading of the driver.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
Changes in v3:
- Use rbtree helpers for pool find and find_add operations.
- Use cmp_int() for pool key comparison.
- Make key comparison inline.
- Link to v2: https://lore.kernel.org/r/20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com

Changes in v2:
- Fix stack size warning in netlink set_pinned flow.
- Add commit to move async command context init and cleanup out of MR
  cache logic.
- Add enforcement of access flags in set_pinned flow and enforce used
  bits in vendor specific fields to ensure old kernels fail if any
  unknown parameter is passed.
- Add an option to expose kernel-internal pools through netlink.
- Link to v1: https://lore.kernel.org/r/20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com

---
Chiara Meiohas (1):
      RDMA/mlx5: Move device async_ctx initialization

Michael Guralnik (10):
      IB/core: Introduce FRMR pools
      RDMA/core: Add aging to FRMR pools
      RDMA/core: Add FRMR pools statistics
      RDMA/core: Add pinned handles to FRMR pools
      RDMA/mlx5: Switch from MR cache to FRMR pools
      net/mlx5: Drop MR cache related code
      RDMA/nldev: Add command to get FRMR pools
      RDMA/core: Add netlink command to modify FRMR aging
      RDMA/nldev: Add command to set pinned FRMR handles
      RDMA/nldev: Expose kernel-internal FRMR pools in netlink

 drivers/infiniband/core/Makefile               |    2 +-
 drivers/infiniband/core/frmr_pools.c           |  551 ++++++++++++
 drivers/infiniband/core/frmr_pools.h           |   63 ++
 drivers/infiniband/core/nldev.c                |  286 ++++++
 drivers/infiniband/hw/mlx5/main.c              |   10 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h           |   86 +-
 drivers/infiniband/hw/mlx5/mr.c                | 1145 ++++--------------------
 drivers/infiniband/hw/mlx5/odp.c               |   19 -
 drivers/infiniband/hw/mlx5/umr.h               |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c |   67 +-
 include/linux/mlx5/driver.h                    |   11 -
 include/rdma/frmr_pools.h                      |   39 +
 include/rdma/ib_verbs.h                        |    8 +
 include/uapi/rdma/rdma_netlink.h               |   22 +
 14 files changed, 1165 insertions(+), 1145 deletions(-)
---
base-commit: d056bc45b62b5981ebcd18c4303a915490b8ebe9
change-id: 20251116-frmr_pools-f823cc5e8a58

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


