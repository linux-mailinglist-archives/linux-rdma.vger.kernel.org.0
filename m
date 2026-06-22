Return-Path: <linux-rdma+bounces-22412-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FozRDMscOWoZnAcAu9opvQ
	(envelope-from <linux-rdma+bounces-22412-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 13:30:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E80B6AF13C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 13:30:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=MIAwxHQb;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22412-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22412-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96243301C6E4
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 11:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FE42773E4;
	Mon, 22 Jun 2026 11:30:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA219CCF7;
	Mon, 22 Jun 2026 11:30:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127816; cv=fail; b=BNJGo5uVBJpTn/LiFwGyY+Eb/6S3S9EQPf/h83g78iZCewsCuuGRKNHQii6Byo3tj+iShdGv4kCk43tSaaQrqfo5pvs74noVLITWgnNR3T74jaUmLYgy5PsYFpTVkhPCYza/gEapjHyg5BUrDQI6lh5YXbFtlgND8S1uU2FqluQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127816; c=relaxed/simple;
	bh=2Ni8flS1Kk/Q7u/zhMBDRy1hE0joGOIFVNrnfKXtPhY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fk9IW2AiAfo1Rny9tzp9kQ2uO6Wvp7/g+JVjDuojpOioiB6N76F/Az6aAAJCvHbaIaTd7JgZVBSUOudZzEbyMdb0o7JepXetfMStXaASryL3toq3I6trwQrH/hAyjRqog+9eCWFSbq62P29VHYTOEYXo9QFCOX+FLLXM3GirWcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MIAwxHQb; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfD/eMT1o26he6p00mLkLlflaFDVi8v1/zPz1AN9dKgYAgA1zZpVAFHv49oy4t8xr5Uf7OnwdmGMZpfPWJvbM5+yCqm+4k4/tq3bVDjhI0mcWlQ3xlRzO005P0NGEz5vf1tGVIeJ/y5sgU78BHxPi/4hl1JhicGxsJkiBAaIQI3nc/A1hntOriUzqsBqR+vDVeF9qGdSaqeCVmkFUDlZxV0u9RkkiaObxV5zn8CL1J0lnDY10vyX1lTQyTBssUQt0ijdBkZz7rBazdjkQtpsaTuz1NRdk0z57GqXE4UQ83VWLiOc6VdnVcL2KVAowwYHuGKsl5rfbnmK7/RMBLBvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33EybeHewoJKs8JIOgqON4GrIfWsnhbCpWRvEKKYams=;
 b=RyhIIfD2Ur2PpwqM11X8s6f8hcpE4rbHyTVmCBgYGXLJBkGyxyTgmFUHyUcUf9ySUVJ8E/dZJ1zQOLdrRFSSHACRxwXlt5zh9BpAiJd6MtRnbbbZ1x0wZz1WDcAF8cwcdDOYNbNV50Shgi4e7t01HSEWZBroACJDkxLCyuftU1V+49R6Cc86y4et/TKFwaykJq/wXnXKkn706ZC7jMyp1WnXkFmtF3ppJR5zBs3XC0FcHoZXkpRavSaayZk33kxmvBRp9SBDxMi912ZQ++rlera4tM9D4vXQr4nHJX/tSiSJasZlKp+iaKXjX1UDiaJk7NW+XBcOkEKuTec8Ok80hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33EybeHewoJKs8JIOgqON4GrIfWsnhbCpWRvEKKYams=;
 b=MIAwxHQbCdLyhO0XAQjmGx6bxHYtIWx+1grhOqDvER+Eu1n/LYCDdL7zt11Y6dtVWRuYhxSb3SrQqSEa6tC9VcWFWXbk953dM8CQYGJfAWxZj0UzJUZ94uri14aH9N1AQvS6jMTqU2lJOWvbgngOqNnOcXrNgOGNVZ5OqCOSHIZiExPo0W5+sQYmHa4zVSlxgP9mx+nt4aHLiHVnGFY+gK85POPy0DxOvtJ1RE2pMLOB9yBH0VI11RZJRDmqeix1D3YM5keqSMzcvkLVNH9K9rzyiDtra2r2cwZKgrlV69B+NBRPiw4K8rNdw/mtr9YbhZoTDyXIFNI7w5fqiqML9Q==
Received: from CH2PR12CA0002.namprd12.prod.outlook.com (2603:10b6:610:57::12)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 11:30:09 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::72) by CH2PR12CA0002.outlook.office365.com
 (2603:10b6:610:57::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 11:30:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 11:30:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 04:29:55 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Jun 2026 04:29:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Jun 2026 04:29:50 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Alexei Lazar <alazar@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net 0/3] net/mlx5e: Report zero bandwidth for non-ETS traffic
Date: Mon, 22 Jun 2026 14:29:22 +0300
Message-ID: <20260622112925.624795-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b05c4fc-3dda-4006-7a72-08ded0519da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nHazDpVthRuprDQ9p92O7w8p6XpRyo6gvTi9xRnZYnvh9ZkK6BrrBvGrzqECcJjM7N+H69IbLLpGhOICwbNz8LKrPW9f5Y1ZmwEZ3LYE8GVZTW6jB3Osu/4PmNcAwhrOQc2gJJMZ/AYw2mxIWjd9nBSCM0ibwZYWVYr96oveSElWk2F98AXvdXASWLZvvVXQJrViIXL53BWaGM688Gnru+P2AhlFnAw110ky8TC/is7M2mjuN+jaN6EKH361AohTcB3hlLvkguv6cXkYGj8se4llpoyYTlMijbAkrmzjQUiRHIVYUgAQiEEMVImL4LuIhGJaNxlQDMt5va/gL01WkVT2jR1SlbPdqnTsikr93FrRGoh/NlZp5AYtzGP78MhanVRTSC51RksfZOHSGIqgcebGNPEf6BFKeOKunRGBDsWKV536cZLRiUzYUoPNlkYBYSqF30XCh0bLycuPGVr3XkGOkqSbCUXPhFlbOfidkVWCufcj80HMLI3nOJ1wCX+9dr/VYe2fQJX3OmMPpSM98wGPqAfyG+hojjFF4wqumc8qyksEEdd7a7HwCYSkdx6wT2BTz62ONdYErNqeWQ6lYT+MVb+WpB6IoB6KZEIWPn/2R1HjA9cL8pKXHnWRQbga9fO+Es1zCAQb7knS6g9uBcTbsmQ0R71kAmXgsYFh2gKoaASm0bHZaXmQZPrp4aEW7WB6GkaNqp+uyT1xIxEPJg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Nw/fQMz03U8LAD8UUP77vdkeWC2V2woax0f6j3VR9kbrdYCNcRG9uqQMyu4d8Z9nbY020Z9DZHdGC4Lqfe2w+ueGK0SZIvAkVRnSoeNauOQV5myijrQf5leMxkyJ6ElcbkuPccowRXMfPDOOQFIWMofWkKvUhAc2LMm+coewB7zLPsYlOOxcmtZKadu+AnAepZ/Bx18BSxxGUHQCDnaeRr6g5ld/mV2+n2oONPQp0NyjGxdhQwg5rPx+QKlJ/qdojdzH0/uFthUhyEf2ub/mC+l+rCbVeXT4BZj0mzGfS3VGmxV+RM6xWdbFR2OF7I2PsIra+pabOghliYFMYp0gWZ9Iy6hIOC5Gz5BSFMdGhGSMPw4D8+z+XJrL4XBy0hdVyVqAyVIo75l7OGCTlve1kzgAm+SDtFb0uR1IO96Zrl+QSGNQAy11IuqMefLQi/C4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:30:08.7188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b05c4fc-3dda-4006-7a72-08ded0519da0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22412-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:alazar@nvidia.com,m:cjubran@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E80B6AF13C

Hi,

The IEEE 802.1Qaz standard restricts bandwidth allocation percentages
to Enhanced Transmission Selection (ETS) traffic classes; STRICT,
VENDOR, and CB Shaper TSA types carry no bandwidth semantics.  Two
problems exist in the mlx5e DCBNL ETS implementation: the get path
reports 100% bandwidth for all TCs regardless of TSA type due to a
hardware limitation, and the set path neither rejects non-zero
bandwidth values for non-ETS TCs nor rejects the unsupported CB
Shaper TSA altogether.  The first issue was introduced by commit
820c2c5e773d ("net/mlx5e: Read ETS settings directly from firmware")
and the latter two by commit 08fb1dacdd76 ("net/mlx5e: Support DCBNL
IEEE ETS").

This series by Alexei Lazar fixes the get path to report zero
bandwidth for non-ETS traffic classes, adds validation to reject
non-zero bandwidth for non-ETS TCs on the set path, and rejects CB
Shaper TSA configurations that the driver does not support.

Regards,
Tariq

Alexei Lazar (3):
  net/mlx5e: Report zero bandwidth for non-ETS traffic classes
  net/mlx5e: Validate bandwidth for non-ETS traffic classes
  net/mlx5e: Reject unsupported CB Shaper TSA in ETS validation

 .../ethernet/mellanox/mlx5/core/en_dcbnl.c    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)


base-commit: d07d80b6a129a44538cda1549b7acf95154fb197
-- 
2.44.0


