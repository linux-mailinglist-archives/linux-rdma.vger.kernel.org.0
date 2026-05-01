Return-Path: <linux-rdma+bounces-19810-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEOxIAzw82n38wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19810-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:13:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2674E4A92CB
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38B2E307EAD5
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 00:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61E613C9C4;
	Fri,  1 May 2026 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gp44vL/E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB3227732;
	Fri,  1 May 2026 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777594144; cv=fail; b=IMGphqQ00bKDKxhfsF29T3lXfQez7wGtUbRfPs+7rKIu7oRaAKqtajPasWsOvAtamJ+o6bgYkj03w4Mj3Dp7zTbhddw81zmHyu7f48fjMxC6fjZ8kGbc9d8fmpnDMjo/vI+S/JHg/BdHbVTHJ2BrucEmEhGvo7TMHpMikc1uJCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777594144; c=relaxed/simple;
	bh=7Z4Y0vv6JhEzBtCLq8fko1Y/oLVEBC/zm+eVlFgypds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=apoH5blEtFJGoGUGuqkknTUGcbxZjr57bUbxut/7eJ+WV34M33mbG50myDMwInvMN5p21F6Vpy+qRiAF60+v0MCBX/2P1q4jtH+9ScAUGtHgjOl7guoIaecp8wKrX+qK+BY+mN2D4/EWM9sUkKNwISVK9EbA+Fg9gIoI/KyrPeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gp44vL/E; arc=fail smtp.client-ip=52.101.61.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxD4QHfwxLabJlY1/97Cs0obD/FyMNHY01EAUcLTduYYAWWNTBCn+rkg3g/FIaHZH7YP7TcsFgD+MrGHb5pnSpq0PkLcnfcGgqO2XD/Ii25M6Q2X4DCFaFtjlCHHQySj7w+DOMiAYp/k+sL9obWkxC8zdEz4MBDSkmeWUH7ha+Fwb4GI9ZAmP3LQCj/q7oWnGCSRSTLhu54N1VNd4nyiy+1EWUZZhAk9IRJ1ieM3A56IgUXAJrI9TJcerEhRUI9Nh/mAYb97UpAZjQGcQAYx/KjAKFfS8ezQ9ITnuKrY+D4r/bCfOfaU6vg73H2yg2jyhuET7/CEXdLV0HqfjB5vNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNXRVTDKvLfnZuKNjUoCGnTK5mVqBa1kfb8phFXUfqA=;
 b=X0z5C9GN6LQtETsdA7TTGkTwCXAkgCcSpKTy5ykfVu+ejwVBtYAIsQyAtkhWS8nUaU1IQqA5aYoOm8VpEOWkDpSEt347N9zib9WIoLmVY+J8ID6OoT2dO+NnjUK7c9/slzxzpRsce5tkWbt9sbHQEFEZAmmtaS0u5Cfg9bRqU5sqidqC2eLsuaAInBduztZTcB+MFt3qbWI10EuZbWpFbk6zNFbQeo5YcwpltmIc125Uee7LzUMg+KoMwiVAwfJJ9Ktx4Q49EBudDs22yqXNMOy6mRcpVYes0zFrO+QLGdf2OIeXvzlhii+s5OVy/J3a2AnzHCt4L3hXl7t36h3yRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNXRVTDKvLfnZuKNjUoCGnTK5mVqBa1kfb8phFXUfqA=;
 b=Gp44vL/EFjAkpIGW/yktFoWbz5LKHwRV/VxErK4Z6xozRNljZut7cWdeIpWu09KvDega27GDgplQxQm1ue6lxP4CnwEZ3YELI4m6o2y+mcPptQ0Sb7Y/O0/i93IqBRrV8FvcZ1qLdmI8e1to8OKOR+7NqUGlz2CIoJ6brnRBbYNxc6fl9CJNYHvgyP0hzWTwvDgu0xyjitDbGY9i65ZugQWlCrBsv9l4cmt9UCJ1fllATkp+LoXLRLMPFMWrEeLhOm7ynVeBcU6T2eHlCqNlnQ/5QHVR+aeuLMROrxa5uj3b2yHHcTLU/cXZ3U99MnFbo5rmOrcq8NMVzwkBCw+aEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SAVPR12MB999167.namprd12.prod.outlook.com (2603:10b6:806:4e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Fri, 1 May
 2026 00:08:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Fri, 1 May 2026
 00:08:41 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 01/11] net/mlx5: Add IFC structures for CQE and WQE
Date: Thu, 30 Apr 2026 21:08:27 -0300
Message-ID: <1-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0222.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SAVPR12MB999167:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b4cfee-ead7-47cb-a013-08dea715cce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Aptr2UWaxNM4jTJivu8kGkXgkfnwPp2Ml6ryKwQZj6k5Snu8YT95QMPchg71z0rbCNsRQIYHl8b2d+X0I/EC7uITCDYTWPycYTx+Azeh2ngrH26NvS43jQdk6FYdE8UYeO8zwnJZ0pNERk6LC0m7MydHIG5Fht/sYbYqbyg1SeO0mAr5jlZNFw8HUOS8VwqQOHDQelEjpc0WA+Fme5iJujepakx1WP82uoQLOFI9ukE2EH71tUqSlrAEiSHnkFpQTfzQN+WWkAvJtYFAA/U4Hhqa64E9G3aMAoc5FRKKgKHLAE/AYFw3bLYWebJl69czohRqugM2H3bfDb8SKoNOlPAGTdGJlZEoOSBlHK+GgsGUQ/YU+OwJRYqQbBp/619gjnfCPOUynAFmftg4bzCTh6V161O0HrCeisH0r2wi0c4QJtTwgfHVuIbESgQICEm+G+fMkUnPy6Akle8mKvGB0A1LO//2GJm6qWq1UQXDQXLBd1Ozdtfqinw85NOrbZMou/UzdBv9xtVKs05zoJ/7TIxDswSA6L4KWV9XP1WkOiufGC1Dt0n97opqRNLjL6WVTzsTzf2aiKA1EzphSWubGDPOc4qCQUBQoG7tp9oKUtPMtauAyRUot2t47D+pzKWlwjmmJf8EzXQxbO5wKM7nrUMzswwc1yIWobNcjpfgInAEIteUfEs0W0GsQ3OyRH7Al9KCCp9l5hSA8HKxLH99cAjHRGrAV8HJCA3G47SqajA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xL2gCp4lT1/25u7lAE4l/ikPtwZWHhr930gP1Rii8BCQtRHE1qNywnMXsuWY?=
 =?us-ascii?Q?lNCqXgZIfKKapH5MxpiFuIRBojZvKhC5o9/G/YTmTeFRXx0sZH+fbD9DhwNZ?=
 =?us-ascii?Q?SaamRDD5BST5cG7hGPn7VxL9ULQYMwN+Nj8EJQQW9Gr5CO4sTLU208EAyFfB?=
 =?us-ascii?Q?y7VbHkMfdAqYYCbGPAxMmLfHVo9yLAI6x9pVjUI8EmkhvM2HandEZZjVKUDm?=
 =?us-ascii?Q?X1EPGB5FTRMUt8CVi7lTl7FzbrVu55hyPukotVRooRvqcQGvpvjst3b6LOUr?=
 =?us-ascii?Q?Vo51bUK4rK0pNpHYOmzb7dIP7IVIcGFhO2XAH6pFpP/y4eHjoWK447lpR5Tc?=
 =?us-ascii?Q?fzcmi9RDazaK/y6cDAJltKIIO0SRsqIPdrAQNQJ7QfOrVh3ZDWLLlBsr9Hlz?=
 =?us-ascii?Q?HR4lr06Uk8xzQrN/Tbr0DUPp9/Jko3/0/Hgwjq4BPTNdXa2bvsj20FIaJh0d?=
 =?us-ascii?Q?/8K4Q5GVFFZQwXrJfZNuVuQCfUQBAeIsa1QzDtjIJYrsBDlC+iaFyUEDdhkH?=
 =?us-ascii?Q?//GGj3A0Ck46wmqEjhgz5TzZ7YnoGqgA+OOF4tPg4h1EdLV7WzCgJw+rU5+h?=
 =?us-ascii?Q?lbSQYLHJFLt3r2/5PpzRsvLLIk4dVvFrsvlXZhN/Kq2GbOTKWadY/sI4SAd1?=
 =?us-ascii?Q?/e3fMAq+i/zZiQ59bzGaKgNedkciZqcAMEed1wBPnBMnbNnB/JeSGo+L36aX?=
 =?us-ascii?Q?iOmUh3c/I0LCMXn6SunHS9NGmu8QvThT/HGZXjGz694yRSRLRLK/fmb/OXCW?=
 =?us-ascii?Q?7nFjyr4YUVyD4Inm35VTQNSUi7Em3mDRO/3r26nSCxtCBgNtwpmvRs0zYQwn?=
 =?us-ascii?Q?ewOZEyWHybcDKBBrVFEwamlKpOM8Kq0j2kGeYVSg5RibjbQlo0iDnaX5ci7u?=
 =?us-ascii?Q?t26RllZWodNkrhmRQ+qmH8sfIC70Kzhp2z1v5LjiotSWrSogWz8rgXuGYdRt?=
 =?us-ascii?Q?hYuq37w3ikt/vCjJln4mNH1nzuFnMvaiUAt5NxwCp2sObrgPjsVa/QFkOvMX?=
 =?us-ascii?Q?axKzaiSSZo7dT85nSUj/V+UIOc4Avlx7T7lZ86HPJoD3BMg84h4ZVVqu1Jj3?=
 =?us-ascii?Q?Dz4QlBTpwV9sxuS+vP8F7TuIEdd6SZU1B04MNNW3a4s2XPo65/Hg3cUGuJRA?=
 =?us-ascii?Q?Is08ZeeX9fqFbSLgM1TBN+OV+skl39EwyFXZt1z6ST9J76nJg18NPv78j+4c?=
 =?us-ascii?Q?c1jzkn9lO8BpQGaH2iD72xMWpOpd0/yi14Dxy+HcaUTssnhn8gr2kLwCao+1?=
 =?us-ascii?Q?g9fOmIsVzIf+5c5fnDov0q+aZjn3ORVmLfjp4WgIonDQee91iz3GYMSm9fkW?=
 =?us-ascii?Q?ygOdE9Kwkhe6AEZkBGR/qOltPyDgvzkrHb2pDC2WeCBdi3ZxMNNLoLEbcwci?=
 =?us-ascii?Q?EdKV+83jF5OGmVyUMEAcHcOD0NYFadIXPkmtlUjf/ajry2Ykn0L2CagrQf6K?=
 =?us-ascii?Q?OyAzBbDMQCR/oUeUQyEjw/38SS8NwEjoJwzqKoOiUFtWmlNV9TK56TY/yjVW?=
 =?us-ascii?Q?VwMy7jmodrWSUsRqMvzo4DKojs8vLmC1yU7k2YUhQ1Pm+lzdeePmzUieS1hq?=
 =?us-ascii?Q?ijyfh4joSrdpubkWN7GnJErVlDyZUhbo4uZi7TzLBnszN16oVIVT3FhFZ5Nb?=
 =?us-ascii?Q?DyWpDW+D907TvTYfxKNiBzfhmoXTVXXrDQSpo2rUptD9AEPUknCt909+tSfs?=
 =?us-ascii?Q?BPy7nIs0fhJcVFypV7OIJibLf91HxY+V5zTnVd1acyHbeMUK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b4cfee-ead7-47cb-a013-08dea715cce4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 00:08:40.8445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8Lw28ohTOjh4WtMjAKrfi0ZlzXMDkrAy+xG1rDyWITbUFip8rnLgG5AX3/bGImb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999167
X-Rspamd-Queue-Id: 2674E4A92CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19810-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]

Building the WQE and CQE using the IFC system is easier than with a
C layout struct. Add definitions for their layout. Structs for:

  - wqe_ctrl_seg_bits (16B): WQE control segment
  - wqe_raddr_seg_bits (16B): RDMA remote address segment
  - wqe_data_seg_bits (16B): data segment
  - cqe64_bits (64B): 64-byte CQE with error syndrome union

The VFIO mlx5 selftest will use these.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 55 +++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 49f3ad4b1a7c54..80ae6aeaf535b0 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -5971,6 +5971,61 @@ struct mlx5_ifc_cqe_error_syndrome_bits {
 	u8         syndrome[0x8];
 };
 
+struct mlx5_ifc_wqe_ctrl_seg_bits {
+	u8         opmod[0x8];
+	u8         wqe_index[0x10];
+	u8         opcode[0x8];
+
+	u8         qp_or_sq[0x18];
+	u8         reserved_at_38[0x2];
+	u8         ds[0x6];
+
+	u8         signature[0x8];
+	u8         reserved_at_48[0x10];
+	u8         fm[0x3];
+	u8         reserved_at_5b[0x1];
+	u8         ce[0x2];
+	u8         se[0x1];
+	u8         reserved_at_5f[0x1];
+
+	u8         imm[0x20];
+};
+
+struct mlx5_ifc_wqe_raddr_seg_bits {
+	u8         raddr[0x40];
+
+	u8         rkey[0x20];
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_wqe_data_seg_bits {
+	u8         reserved_at_0[0x1];
+	u8         byte_count[0x1f];
+
+	u8         lkey[0x20];
+
+	u8         addr[0x40];
+};
+
+struct mlx5_ifc_cqe64_bits {
+	u8         reserved_at_0[0x1a0];
+
+	union {
+		u8         reserved_at_1a0[0x20];
+		struct mlx5_ifc_cqe_error_syndrome_bits error_syndrome;
+	};
+
+	u8         send_wqe_opcode[0x8];
+	u8         qpn_or_dctn_or_flow_tag[0x18];
+
+	u8         wqe_counter[0x10];
+	u8         signature[0x8];
+	u8         opcode[0x4];
+	u8         cqe_format[0x2];
+	u8         se[0x1];
+	u8         owner[0x1];
+};
+
 struct mlx5_ifc_qp_context_extension_bits {
 	u8         reserved_at_0[0x60];
 
-- 
2.43.0


