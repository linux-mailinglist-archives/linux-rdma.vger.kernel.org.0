Return-Path: <linux-rdma+bounces-16983-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GU3AmVqlWkzQwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16983-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 08:29:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AFB153ACB
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 08:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13782300B9FE
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 07:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B80630F7E3;
	Wed, 18 Feb 2026 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UqdXr3TW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB7830EF66;
	Wed, 18 Feb 2026 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399778; cv=fail; b=hHi/d6+slPDFpInZa/QvVV11+pDgcy/5WyHZU39Hca+ZrqahXjoft36Pnf5ioAI0pfOZLGQ5S/sS9K/qGANz7CUMb7X8mt7iCGOrTnD6B9M1FQl1j/eK434xyi6TNwbxvbskNQRW1vZWOSZyLh2DLeLM/MQ3LaMecmh936TBJ0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399778; c=relaxed/simple;
	bh=dm2z8P5w8WsxPRzE02obWbd/c9sEVXTSvl3/gfwDxFA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qtI3P5uCq1VHR7kZzthwfJ7Xl6OxHSZ0r0v22dy3hVEkZgtA7oFhk22t7quirwix+baJjeDRin1FgvA0S5uzuNmUxQImcdelFJMNjKRs2QydviUVcvIXyjTo6o5/AzJ6KrddEqlRexkinP4+8uOwyHacf4GBv6HAxK5M8iXKFCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UqdXr3TW; arc=fail smtp.client-ip=52.101.85.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+63sUc4YA4CcCErqZzcsLKiz6xhdO3k00ChHpYIXDSqmQfjCFDf55fUETNxQ/ogiHjz4hTardk2hORDbB9/Fi9e5SMu4mffzt0GEMs9sOoSY4q3cD3nPUf0QpFlWKZh+p3x1a4vY0Hs9TsRBcaBNASH3CVblykNvLvMpDx+SifqDh0DvGIymlRGwmcMnalTurzczV/E/FxMBICcB2B2j1BsSbCfuh28TYm8f3mNUW/phaDkkiTIk4K7QdToQDOo7GvYCyFT5VnDl2g35pg/O9dhLijgLCx/OgDjHj+yPAKeObh6sVnaOYevTAJ2JWy085Sk5Ftbo3CUh/W+4ypnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTqRntK3WjsAq3Ii6qcxTxZOyGukdFW7xOxNbGZLeBY=;
 b=eIu3o+4BJeDJHUqL3FevF5PbVxQoJigYI9A/9JvCw/1Ru7631csBr8gnqClxqfDxh+XACC+zGuKbrRUEH4YYREZR70aHZp0Z8D+tLW+BHe60+cCtxpvR4iSmOe0twfzz/X8XlEyNJIXt4Qb2QEAnQTSmmY+Zxok9JEMZxUgkovm1aLSw+kRm5EU+m2syY9Z6G0/qtKZYCRw/4xHg4izx8d6X7V2SNpq4epywNupm5+KQ8Z1V5l6LucjHiRzqx1qQm6hjqil9tGIEs5FWqBeQwA21phlJJtrcJtEU09jp+au4qro6yGLCHuYBE3oTvjiFBZWtykLkhbo2QPyQO5P29w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTqRntK3WjsAq3Ii6qcxTxZOyGukdFW7xOxNbGZLeBY=;
 b=UqdXr3TWuRYhR6Idd8ltl9g9IaZpTvnjFLcKkNqDhTdsuiMB5+yBTLDaCL1XSKiuj311/XD7gvKyP90D+Ize2yD36TK5oV6lWRC9dKyg3LE9+eGti3GC2k0Doo2Vl9y9BWmlZ7kwoLmfLbOIqDMcFljZuZb3c8s4GtJmmH1OSRK4H5T29wF2x9EAyNc+MpJarM1jU84vyvo4VDwvZupGO0JNxKu6R25v/nVHQzV8bN7weMFLoVobqQKvvAVgB6Pkew5y0tofwOCqyUDJI72B/2G52BR9AG+Ye7BcMBg8m+qeSq0ACspeMdG7D7W5ignd2GvAlVo1LHUnvJP2/O4MEA==
Received: from CH2PR19CA0021.namprd19.prod.outlook.com (2603:10b6:610:4d::31)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 07:29:33 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::d8) by CH2PR19CA0021.outlook.office365.com
 (2603:10b6:610:4d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 07:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 07:29:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 23:29:20 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 23:29:19 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 17
 Feb 2026 23:29:16 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net V2 0/6] mlx5 misc fixes 2026-02-18
Date: Wed, 18 Feb 2026 09:28:58 +0200
Message-ID: <20260218072904.1764634-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: 7592cf6e-af45-4dc4-4d11-08de6ebf761a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cENJV28ySDhXbDBEYzNnMXE3TzI5Z21ySHd5WEpmSS9DQU8xM25tWU1ZcnE3?=
 =?utf-8?B?MmE1VmNaYzM5YUdIQlZ6anpMN2o2bHNKd2tCenVpY05SaVJTYmxCY0VsZjJW?=
 =?utf-8?B?Z0MzNEpUWkhNak1FSUU4a0JuUTVmdmo5ekNIU3hZcjhBN3cxaTNrNkdqV0hz?=
 =?utf-8?B?YVFEcGJBYXpTZUtFdVhxL2xmN0lvMWNaeG9sTSt0dHVvc245YnNycFNEV0Nk?=
 =?utf-8?B?Zm1KekJLSzV2RkthVjdQVmIzS2hBdCtRMFpqcVpudUZhWDd0cTFmVTA0dUlW?=
 =?utf-8?B?bzdLbkJ2SG5KTTNUUjZscmt3V05ybTdmQUI3Uzg0NmdvOTNxTDYzMzE0RDdE?=
 =?utf-8?B?eUZGM3dEMGNOK3g3R2N6QytKeDRkc0NxUUExWVNPc1BBUlV3SXZBTkQvdmRm?=
 =?utf-8?B?QTJvYm1hQU9CKzlPK1piTXZHVDlzeUhRMjZEc3ZWMFBwdG1rRWlpT2NSODJh?=
 =?utf-8?B?MnFCeTJFSmhHbjNwbnJ5SUZpc29ISGJXNVk2Vm9uTFl2L1dNL1BkdSsxWVlw?=
 =?utf-8?B?Z3BpUDZjd1hVM25qR0o4a1FKN2Z5Y2hXTXhLZ3JlOUdtM0ZoTGNUR0NTNTN0?=
 =?utf-8?B?amYxV0pCaWd0MmNaemd3ZFpTRWFYT0pHY1JWajdzY2prM2h4aUhneHEvUDBo?=
 =?utf-8?B?UWhOdnVRZkdlNi9sWThnMkVDa21IK3BEYkRjNGRwT0pPc3NKOTJVNC9oZkFj?=
 =?utf-8?B?cjI1Vk1QWVBiWlR1ZXVUS3p2azY1RnEvUVN1bEdCZFdKOXdMcE5DMm1xOEdu?=
 =?utf-8?B?bkNzOGdSWjc2blpTRDBTUndBL3BQcHJLbmlJMkFod1JOUEJGNkNzSkdxNFlo?=
 =?utf-8?B?T2xvVG5QZmhObExjL3BNeFE5Q1FiU0NFVGQzMHRNY1lIOTB4TFhuWndYcHNa?=
 =?utf-8?B?d1BrN0hhZmk0NVVrR2JuS0cxTFVWa1daUmg1NE1MbGk4aWQ3VG9xc0FZbCs0?=
 =?utf-8?B?Q2J3THhmMHp6QUNncTlmQ05pMXlMT1lWdWtRd1J2R1MwRmszMWlKTm5GUUw2?=
 =?utf-8?B?V20vMVJUNzFjOFArWThJVmJTN3FBVHVyTEJYUFU1eVpqdnBuYTVrS0NFdzYv?=
 =?utf-8?B?SVVHcVhhM0ZRVWZJekhEME4wQ3BrdUpXclV5SHZBMjJlUzFxKzBBRjZ0QXFt?=
 =?utf-8?B?bnZGZlpmOEYvZlJsdGJQYVVMMzF6bGpIOGkrU1ZPb3lRUnN2eUk2MlNaTUhE?=
 =?utf-8?B?T0VhUnRlYTBnZG5TZmU5NHZ3RnpnU3lIblU3TXNYcXFJeWxBeDJvZkd1TXY5?=
 =?utf-8?B?S2Y3Zk9iY2NnbEFqLzB2bTZ4S2Z2MzJYeE0wSWZsREp5elhUOFRGT2RKc3dL?=
 =?utf-8?B?N05rWXZSSzhVS3BIREx3Y0RhanU3UWYyTDRIQXBEc1lZOHlwbmkzUm5UK1o5?=
 =?utf-8?B?bEloWjZPOUp5VlBpM2FWb0xEeU5jRnFLL21ZTkpmR2UzTEpBYTBBS3dxaFl6?=
 =?utf-8?B?T1ZYM0RUeE9zdHNJcEVLVjR0bmp2cGhLMHlWQjFEa2VVSUJESlZMb3BiRVVE?=
 =?utf-8?B?UzdnbjJpN0xlUXE4d2tTV0tEUmJ5dFd3Mk1hRFNxUmxnUmVzRXNWd1BHbVRj?=
 =?utf-8?B?THdnZ1RKQTlJUEpWTlUzUFM3SS9tcmZQeVYyaFJmTjdTbGE2VW9ZOTNGSDND?=
 =?utf-8?B?MjNLNGtONThrV0tIL09jS1NEcTJiM0V3QjJHT0hWT1JVZHlISmw4cTV4ZFNx?=
 =?utf-8?B?ZjJlZEtTYzhGcXM5d29GNjBBSFZsRFhTVHVJaEVtR08vNzNHTmo4NnY5YVBl?=
 =?utf-8?B?dUVNdUlhQm9QYXRmS2tPVDFTQnlSVzhVWmNBZ3dxUVJFQTZyT2RkL2NNRHJX?=
 =?utf-8?B?WmUyR25rZUxLQ0Rob1d3ckFZNy9UQVdDQjkyZU1yQitEZDVEZVE4ZUdGdWxt?=
 =?utf-8?B?YzUzdWphNzQ1Y2Z0QmxobVlKY1ZDeVJhdDRubUlJZ3VyeElucXEwTENmU0dM?=
 =?utf-8?B?VGFvbHoyc3hzZ2tRR25iU2o3VUdWQnJDeDdwTXZVdHN5cVBEZUZBU1RtRUlD?=
 =?utf-8?B?UmNadFJuRkc4emduTThxNFFLcXVTZHNueGJuTWtkRGtxVmJEL1JtcC94amhZ?=
 =?utf-8?B?VU1Td0F1V3RBVDhCWENhVE5JQndIbW9kZyt4V0hKQUE5Y3RZTnJCZHREZmJh?=
 =?utf-8?B?Wk1BNzJXR3pIY3RLcGk1Q1lFakF2Mm1KNzRLSDZjTmJUajArcTZscFkwNy80?=
 =?utf-8?B?R0t6TGQ5bjZNbndmUVEwVXNYWGVHcjYxWm5oS1BGN0ZVRGpqbjQxSldDbkt3?=
 =?utf-8?B?d3JacXlDbVZtbVZrZmRIZWNVRjV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5wgRcaqo4dh9SPNhQ0JEIbO4L6w510CyxJ6YT5UFtv30oxcU94BaIvyNWCYOQH/ZZn+LZx1LmwySR/dNt1laYrJTIoTYAlppspiJN7u+Kwe0qqYEOtClFCpgZIe4LAHFHDqb0/dUD0evobeq0JkmgxOM3TlWfWeHdkU68r5eNhlXNdyxOJZfManXjvCDBIjmhgDzXCu0gqmKbpetTv7DVDc0UNwye2BecFEp7hTVV02An7dDY7jtw2G92hc0rucPlM4j4z+RKVYYuNlTt1UV0xY42mcUks0zIw+bAle6nyi6gYxTUOHc0UsZM6+C746UMl5aExr6DB0sG3YFJvScYm+1eWhcvha7NnEI3z27eJGg4Eo3CbSMpiA2XRPXkB9DLpC/DxUa7ELE8OqjWfJ7cLqMYhVzmogTTkVtDsilfA4nmBUd+/IO7Fv0UwshGv9L
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 07:29:33.0979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7592cf6e-af45-4dc4-4d11-08de6ebf761a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-16983-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A3AFB153ACB
X-Rspamd-Action: no action

Hi,

This patchset provides misc bug fixes from the team to the mlx5
core and Eth drivers.

Thanks,
Tariq.

V2:
- Add review tags (Jacob).
- Use poll_timeout_us and variants (Jacob).
- Link to V1: https://lore.kernel.org/all/20260212103217.1752943-1-tariqt@nvidia.com/

Cosmin Ratiu (2):
  net/mlx5e: Fix deadlocks between devlink and netdev instance locks
  net/mlx5e: Use unsigned for mlx5e_get_max_num_channels

Gal Pressman (3):
  net/mlx5e: Fix misidentification of ASO CQE during poll loop
  net/mlx5: Fix misidentification of write combining CQE during poll
    loop
  net/mlx5e: MACsec, add ASO poll loop in macsec_aso_set_arm_event

Shay Drory (1):
  net/mlx5: Fix multiport device check over light SFs

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  | 14 -----
 .../mellanox/mlx5/core/en/reporter_rx.c       | 13 +++++
 .../mellanox/mlx5/core/en/reporter_tx.c       | 52 +++++++++++++++++--
 .../ethernet/mellanox/mlx5/core/en/tc/meter.c | 10 ++--
 .../mellanox/mlx5/core/en_accel/macsec.c      | 13 ++---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 40 --------------
 drivers/net/ethernet/mellanox/mlx5/core/wc.c  | 14 ++---
 include/linux/mlx5/driver.h                   |  4 +-
 9 files changed, 78 insertions(+), 85 deletions(-)


base-commit: ccd8e87748ad083047d6c8544c5809b7f96cc8df
-- 
2.44.0


