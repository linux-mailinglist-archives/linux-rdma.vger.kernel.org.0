Return-Path: <linux-rdma+bounces-20777-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBIIAEZZB2orzwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20777-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:35:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE47E5553F5
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1A32300FAA5
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 17:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898CC3DB635;
	Fri, 15 May 2026 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EGI2v1+5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC943FF1BB;
	Fri, 15 May 2026 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866220; cv=fail; b=GHyMv/XOL0UogyLiqFusGu0G6wvb8Xsln/MPQ4fTVSnsWckEPSBmN6y5djl7PnfpdDozL0QYCHdQK+sLeXwkxXu5ahuUzi2Po3IwP9Jh6djW21HcOlUtBHXmBQfqbbLswklLbAQY08eOMx3Avtp80usTIlvxOSa9CPX4rhiOaJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866220; c=relaxed/simple;
	bh=7Z4Y0vv6JhEzBtCLq8fko1Y/oLVEBC/zm+eVlFgypds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DHdmJ0AQ8AbYzK53TGTIx4iAX6psT0+wEdP1y4yG4P6ZifOsnkjvoVhapvn3sTFA3/2RTfxMzi37S/SBMo6xwMxUl6U+Ip7LJRw8JCx7K93I79//WxYjWWTj+iMRoB30XlnYsOF+dLDGOpXVDKRopDCzkEAkxp5ILOLuJ2bG3ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EGI2v1+5; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0KSyul4pELcByLQ/2Pp+ZyJtDPaRk1DIgSe/bTUuGaOocWUZQJpi0U7bwz3BvsKmQXR6KqZPIcc1YCHyh5tiWEbe7lggOMZNMKnTvpoa9QKBcQCIbp1IS3m/dIxFHt/iD+aImxfHiSfNCNer04fDqZVMN24oetryP+ShuISx8/NdYHFw/bCuH1nK6/2vxEmSQ5ZOgUi9PLxWMtSNoMio1p8LyTpcC76/ZhO7lhwsmOYDNdj70A5wgn/HtVOOHZp/FRdJX3Prtgeok6+Mt3gcXUrhvCJyIn/KwpvW+l0tUPCqxfdd+dMOSAHfRgyjxC+MbrDxE9qiZYf6lFeEbsgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNXRVTDKvLfnZuKNjUoCGnTK5mVqBa1kfb8phFXUfqA=;
 b=QIbWJpG+hBhNm1wQFgptR9kpy0uD8itIn/kAK7QPjW0R7pdC4axaQ7RGW9S7KW8WBoEBoRXgykepbp5rRhM5JFolzZhG7sfNvHgimpb3aoXT9dYClhnLXyCi6ThZQA4esHe0voQeiF3dYw+uajDeKmVbR+qsrCswCdIxAH+Y7HjuAwgUhMwnkmLrlEudT/wvbZLEarDTo4B5ZTt/88TCltfZL4QoByAAohyO8UhM37ayQD0PAPuKgftcCBCR7Mh9+u0WRaGQyE+BrRcE/sYHD4ERCTuHQBN5mxFrGy4vICKq3rThSoZiHl2kwKjeLZQEjhd+UoqtdcYeXaaqtGoVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNXRVTDKvLfnZuKNjUoCGnTK5mVqBa1kfb8phFXUfqA=;
 b=EGI2v1+5lqzhNibRUlJIkGqOryUsUfkmkUc3Q2s1DIUV8Y9nevKVvmNJhGQfDjfnn64R9PGWzq7u3NEtzy+KuwxTLs40iBjmxvASKx8hiD2kA08W0gf0ygojeMbwoTvX06EhF2gUYsT85DsrimSrc9zj/0FdHI4Ir3JcSE+L2sp3qPBsSXiEDWjK+Wq2Wx9oh1ybJ7Wc8/Yz9yKIYypxecTDr1IVtG/UAEkG7gGjWGfHPffox23BAUjUkjwdn8YfeBtlskZxuDtxIb4hT4/4Mti1PLYKrRFAqULqqtz8bE79bwSZSeGGSj/ZAT3xdH9kgo3yH4LGon3TkojuynK7ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 17:30:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 17:30:10 +0000
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
Subject: [PATCH v2 01/11] net/mlx5: Add IFC structures for CQE and WQE
Date: Fri, 15 May 2026 14:29:58 -0300
Message-ID: <1-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: e502d594-68fe-4d61-0386-08deb2a79c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	fb/HdrO/QMBa8cOKZ4dwtzmbPpCr8fZMS1dRFAvMInEGpdjvNGLedWkEmoLQeKdCl6xU+bpdwRC0PDNv7fJj5IWrVOLdvBYcUnF0XgU6alJMiyKnsBqvumgMutwVLCvskOsYzqCZzPtJtuayMPMHRGqKxeap6LqBLqxtPVTk77eeGV6GVFh9CoXJ61utY8MGncrFNUCMDjSNGU+qvbLXF/TQO/+C+TMscbBSyYn85+vU6V7G7L0A2Bd7gWbS/M4ulOBzyWAnayCaGJOjS/4y6oaXxVzg9BzLVae7/aHKMR3rtB1fx09zLMzMlq+v0cMqHyxRq29LD28WCw0tEo0VSebSLzbNSseKU1HJ02vO/P1fW6SAW3QUjqCMM4NCduV4/e3zgXb85Wgd9AxunIWGTebIex0azPVJ0AIJViFyliW1ZdRrlKXnTLK+44SbH+J13RWDu0Dt17kawh72Wxv+aPBoA3i5pVMVlXfw5aK42AKmKYxHWHoBQQsH/Gvwn5wubXxXp+Bklp7SFoLHO6BaunmNOfYt0uM8RQmyof8auKkn+sCzD8ulaugcyxmsCB6+wKPP3cnh621o7XYBX/Nwjq5+A7sYIsKYjDjEnlO1MZQkg+AFCFVuTQUA4fa78d2/0ctD2O7j7I5dk1cLjhbPg5mE3xMYoqRh8+tzZ5xrVVLp2HyT03tphCD9JHEnX2dUexD4aA84eO0hM92dLhz9/tOWdWceJgBeV08xFDJz+1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kIjpDX4fE0hgO8xtipA5s9qFwa70zg566+FYUmgK4n/gINgV9zXsbKpJcIPh?=
 =?us-ascii?Q?e+PIdmrNrAoskD5n+Rx309K5l2IuDXzv7xpJs2ECdAwMUMTB78G4FqpMba4V?=
 =?us-ascii?Q?oZ1eOJEpKl1ACobsNA+TJSM2SNO+Oc7o9UjLZvF8eS4JKISUqtId3A6jh9K+?=
 =?us-ascii?Q?ed8y57eapHbtRXUoT3e6lpnTIXSi+jluzJ9CHn8Mp3kJ5OHghUmThi2cwk8E?=
 =?us-ascii?Q?7pTD6ZzNB+2168/x6yUZifrsIpqc2AAI7W5MFoTYvYfRvZ5Mnavidw/xhvWc?=
 =?us-ascii?Q?IPBMOWRRCMrUNx/asrWO2phzXIJxf6QehFMYq4P5ENSUywlL/h6X5eHRYI1k?=
 =?us-ascii?Q?5myvJwELvHK3mebR4KVt45cx/bc70Sk13d8ay+foy87Il4tqltQMLeF0eo+M?=
 =?us-ascii?Q?r+W/1KOgpZE758V7HoWDVzK1W4xoArHC1JiZfvY5k7IkdIyRI0/PGAyRgd4j?=
 =?us-ascii?Q?uboCLg7z08j1PhHV9U9T1LeIsT58p1piWszg+QF/50S1QncKMM6ppl+MFLQS?=
 =?us-ascii?Q?0voXOtdSjMAMjzjrYvIt90SqwvPQGlKMQ2QJ7ZkUov4mTc/iL17ZSQiub3ff?=
 =?us-ascii?Q?X6BXG9hF5VVqLfwTI9mitmX+37UMlJsFUDU863vrj1MW1uN9+KcpifO3SL5m?=
 =?us-ascii?Q?JACJUNJ0Z2uXjC1Xed/KbFqfpNEUfQF+1Y7ueBZyRiufGcdFfvUDhoqyE9ZZ?=
 =?us-ascii?Q?NIx6cY3E6OuOLJaQAaIBQBjXrXNEiBRKZqXJHq+fSA15b198ymgesmRlTZLK?=
 =?us-ascii?Q?VdTH1arpZ6WRT5gVDqO63aJgIwhLhYUPwFaqPL4G3uHBGTaWxIWp1iSOZfp6?=
 =?us-ascii?Q?LmrY9w/N4R/CvS4i0a0tNCM/kQK0l0NgyzfUnF15HoofVK/wSv2q/dIcn3E4?=
 =?us-ascii?Q?Rv1ZxsR4grxr6EupiwHRDXDcJdayYErguSWeszKtRdCfTU3Z13BsLkWGkMGa?=
 =?us-ascii?Q?btP1Di5gwA1clpTAILnln3VqIBy+uFN8yn+fdbQEEerwsBqTwrFt99+vLbsO?=
 =?us-ascii?Q?RWFGCH8fQOZcmvTx+uPWfvVP7GQHpwUmv+xjI1z3garXTbD1UaZWW3ppmocA?=
 =?us-ascii?Q?9bVuIgpwr/aTdtYWGTCZD2Awp5RjslUqza4fbfbOpfSCtK/Pqkgn12LDqLIa?=
 =?us-ascii?Q?Jacu7W/6WzXuVp1FvrOR5Wvtzef1dw9zahLftbmRF55cf0kE8sA194vmbDEl?=
 =?us-ascii?Q?c3Bdnpf1I3JNbT12cYTdTqCPEdqmzNGXLfdYAu/b6SELHu+09V4Gz752dvVo?=
 =?us-ascii?Q?k2sPKpa3Be9pm9Q1TLsaE871qtMBP7n6/oKyF6uoCNzwIO2rV5E5xcIzyVio?=
 =?us-ascii?Q?o57sTDMeRAepjzwg60FeuAYlnQkLgzqcBLpgA+TzdEWJG6+gqmHQ+9wVdedv?=
 =?us-ascii?Q?MaQktjjKRpGpnPjOTi1x7MPmiWuvLNQVLnN4/gi894yy7gFf0igYz2BEwQMZ?=
 =?us-ascii?Q?+06GeNOl0/F4YTqHOwqpM1UyNUz0l2k9Oj1iq7RLvXfAHUf7K3fz7AIRnMkK?=
 =?us-ascii?Q?+EHjiaxQEqXK1TyJGlqUBGI+9TO4WRzqGfC5J8NGPJyo+w2fDZhVIGfWcorM?=
 =?us-ascii?Q?rip6hpU7OHYw7pMvRyqwEnzgHJlCiVcYr/Kq1rLU1QyVklRL72RQkC1qyagB?=
 =?us-ascii?Q?ZVkSvdRNUwref/Qc9lhJKHU0C4YLfXVvqbZJdldk2ECZvNWiwTmNBQJkPPH5?=
 =?us-ascii?Q?ib2bUCO8NujbP5XLcZ3gdJz1kr1kAJisSwhSybbWAIVIp+77?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e502d594-68fe-4d61-0386-08deb2a79c9f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 17:30:09.4399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hqXOy+5N1ZIQGct8TprEZIr99fnnUm6GREEK7PbH0GZ0+q1CZfImFWrh5uSI5sF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
X-Rspamd-Queue-Id: DE47E5553F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20777-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Action: no action

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


