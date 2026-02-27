Return-Path: <linux-rdma+bounces-17266-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DMINUbvoGmOoAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17266-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:11:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 759251B1654
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F27D0301D0F3
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AD9293B75;
	Fri, 27 Feb 2026 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mHIwIrZE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F16280CFC
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154688; cv=fail; b=Yn6qeDXUWYGoU3c369NSH5Tnv8shjaUz9bnfxHn/D376Rpbn42DYuE+HTFVncHuXtv46FGI6DdUrOr5FYsfWUcJcgmRCYA4EjmqfNIY9R7s/aD/delYB6zSSinAzl2ScdKbwL09TuD8885Lulf9HAokBzM9UIBSDq4rGfXsbjDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154688; c=relaxed/simple;
	bh=4uBjGl/LodNIRCPQtgGTsGNf+H6crIuhq+9x4iidqk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l3qEAtmH3sr9ZuQ2HLVJ73XHEANBpPdWt+nFcZGV9wlzNw5s+T/s1ZGg8VcdKNkrvVAq3tOetJeIB/epzi+6eyg6PeH9kSjHzTVQBBJzOpZIbqwJ5Cw9cFzrxu43kekaIWQku0IvaB87a1yO9HlQasmfX7hwmfYdHWZPwyU7rjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mHIwIrZE; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiuTNxSWgKHNR/8ULF53uiXNRfvAq6pA8Hh70FjEDtTo36ffIAYuir5OopNaU3x6Vq4YyuStQxj0wUFpToRXg+T7Z9vgnFONYMZUiFmIqHraN76H8dGaf8+b4EkrXwBURwlTtxO93n5M5PuMBNiR28VqwZBMYe+HcZldN7feKRO3shiGhVjMa00MlkPRHBdxzhSnConk0miEQF2CosVsHs2JrXRi7bdYd72/SL6qyLMBPjHVKmwU83Cvpz8NSI+c8XhtdQO/5A7ocwookJAegBzVu6aQ3oxdvrXuhaYo1G2DtyIip6tn7qVc0GSJweWqqk3IicPKGrHO9Xo9DI2FHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB/UMCvkFtchRBq39pKI7UyFuYS1lcriJZgkIVFUM1A=;
 b=o+8o7XkzocaFYx2Z+MDEFN62yoHelgOOm7M21M65FxkSS0Gb64e2tUMlaB7JqtiMUO+GB2oAJVUOxFoQCNJ39DMT/PYGqcPEj2FQnC7mnDasb5ATqZrgm2XMV0dXVo0gW6jJDyNydXftrpovzna9aJ9Xe0wbyiSHSdM3Lf0UhrB8dJ3IWYXeLa4U2SFuuUN7PbCOsX596F0dwayEbCP/VBt0S5LmytT6wfr+nbhiEjiOD3qNGK7IUomQDyPfa554XNaSACVK27u81ZdnWg2nZiz99g5W5BwBMZ4aImhyXwJ1uaHFOkrSqYyz5fva5lTPsL8nA37okZxN+8FzLL0zLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB/UMCvkFtchRBq39pKI7UyFuYS1lcriJZgkIVFUM1A=;
 b=mHIwIrZEKmBXNQGI2UyQ0Q7tO2dkcdThRK6L+46++BHobEoXk/hwod1fVOin0ncVozKI5Zdu27B6/UerQkw++cIlITX45DFSqDW7ieoGVrrgmOrJg776Xfa8lASKfd+jXARQkEE07AA7PJHE9AzbCIZGTeZxhKFoetMiEq8NGFEopEH9PiThj4y7XxeANTxGrpKGs12lnfjdK0ZGFCXH5l2QHM0Qxh9/02DE6yKbOzpSWy7rBE0l3CxIRpD7mmGBbAhFUJZwgB4RncXErNRp+FCuPLhapJSur2B7Db9Ph6fRZnTGJtJnxQwcsZWa7U8F7Ry59A3atOjIan85NN4iFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:11:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:11:22 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 12/13] RDMA/bnxt_re: Use ib_respond_empty_udata()
Date: Thu, 26 Feb 2026 21:11:15 -0400
Message-ID: <12-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0024.namprd14.prod.outlook.com
 (2603:10b6:208:23e::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fdc60b-540c-4dc3-5941-08de759d1cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	jL8nWWm/o7mKyzWIZHBvamuxCEkMUmgf/XoDfvl/LNA9DE6OvRXHxZneiuSCZEch2lf5zVU64G5ZBDg7QUUB+WuV4vVSaL9pDDzb5ixTg76+OGt8+xQ8MUjGK7yOt1QnOZJiHI0aV1qnGcSgSoBD+9etng+fjTFr80LVAs/mnXLZmGrOAbDBeYYKlNbv4nJEsPJH6MBSvLCv/z+YyO2X4/a6Engtn9Jw3ubsz4wGi5wKDWBv/tkZWD20eehWLrqdPBWykxVDO8I08B49onphCKaPQupzUUshR+Xrf6vNshgRJW+XNre5D77sgXda06QRhCTvKcYl6jckRUZjLa0z4qaJz3zFre75VYQ5dLZfN2gN0njt3D7wh/6xhtqkhwOI+IgjJyh03p8CY44Kl+IPdWqu6EBxUUw/L6wsVV/oCai+JqVqJ4V0DBQk9BjfBWPBi3v0a+T71FchEYtz+CM4a6ybVFc2aE1s7HRsbf05X0f470Ov8jDmaPG3PDEqRLlHureqOPvTgCZQ7oX17PLxdXsmIUqlQBXLzA6Pa3G1Qtc28DMmI8D/Jg0lm9HESCJS9UIwEQnOwSPS0UVJoTB1ufPokKsb7sGoLmO9SjAcT4PVhGvMskPZRcNJTuuaSvWFT5tBdk/2OzB0UcItk453gZDywcdZTHkQ3IMvKN4TOB3bCcvngPfABnWRnj44a+Y7tzs3mL1Gt0kG+7HPAIuhIY/6m4OaFa1/wGnQSRzrhVg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9nVJ71M+5M6KjrSqAoWNWqUX0SxSQKn9lwUY28/lqL9stYXLNd7pjNcfctHh?=
 =?us-ascii?Q?YUqrUp7FZGyg2b27YY8Lw7zxdRO9NtmhJ3k89BW/P/q+TRHW7EOt/RRBaIVy?=
 =?us-ascii?Q?vgagazuD8GZl6LfIacGSyN61h25cvhVzkQ39kvECEGykm+OLrMhYtMuqmjPd?=
 =?us-ascii?Q?kRu+ghtLZKwzssiNiBmdenVhJNQQ6xFtslVbPKpoa3REFhernZOusHgihrZM?=
 =?us-ascii?Q?sew1DLnSgG3PAXwLkR8kZ7fV6cwmM3R7JwBJEpbW+dn2qwIXlOVzlQzBsykw?=
 =?us-ascii?Q?+3fhSVmcWYMS5BXUfOf+C3OIiL045V8PO2OF9RvCiejgloP8/BAtFtuv9QCh?=
 =?us-ascii?Q?uepWojLW7GXXt09uMQUleGIgdtRJWIHhuq80FGJx1GsH4mvDOzO50agRVqAK?=
 =?us-ascii?Q?lVK0KvtVssjNyJF/3qyACqkcmlVs9IuQWpgk8NHg1bssfyAo3bJ8WWgOp+m5?=
 =?us-ascii?Q?uDK2oSSiLNBd1ER3yUirMEO+1n5fWGIm8uBPQ5Fd/JK99XB7cQUlM3X4Y58U?=
 =?us-ascii?Q?CxuKCBd+NBCh/hwOmd9cI/dkx2QGsdbjPfTeuM6Tikb8y9JVk8Y2EXt+b4vu?=
 =?us-ascii?Q?NVagNVS4sOsNndpQ9JC05nAv53uVUMVJgzy1swBYDAsBVQOavLXubnBEbyQf?=
 =?us-ascii?Q?IXkT7MtKatPlbat0am+kr3nTEFxyouLf6U5ZJfidKqD63U7lUeywFj6kHJ+8?=
 =?us-ascii?Q?p8IUqLV1a5lACOScQhM7580efprhqozmXviv917yq+jv0MRxW23p8O/hr6zh?=
 =?us-ascii?Q?PEziNbbuLZgbY0BoR7yLxSSfT6I8sHt8O2E5IRmYaEY+yt29gVUgCcHlYQq1?=
 =?us-ascii?Q?2jsvCCcgsqOr3Y34lCuE8kGizT3bLLqHVhsNRcVVTaBiCfWwUyqOUrAR3usM?=
 =?us-ascii?Q?GqtuAS74243mDi0/hNNywZdSSSZaVwenjy+VrPNCrtljbo8VlGHkYTJx0pkG?=
 =?us-ascii?Q?L254vCie1JYQkzjs4VgOoRctdjdL92BkbbcJbDgFSJZcanJ1IgtMXau8o6BB?=
 =?us-ascii?Q?y8S5CG+7ZEen850NJY4od5dj3D5zCKIizyaKpExZTqXhuOSEMBZ3kDYhTXr4?=
 =?us-ascii?Q?mCRZ9oVzh3eGsKlHEaGNUGygZyRQHRFvAH6e3iiBAoAAH6sk7eKNzuV8aB9d?=
 =?us-ascii?Q?4XTQv3sVi48GDamlvmuRluBLtx6+KYZswlA1wz5YCL7Z7ucXK7NHGhzpHCDs?=
 =?us-ascii?Q?gVL9fXUl3zv6XGoEyD/LMsgBCVJsfutGKWGQHLFfPLUdXtpj8OMyWworYDOh?=
 =?us-ascii?Q?gyJsPjzVTM3Sf+5coeg3vUJbFhBVf7yU1Vv7hEmAvQFpygMp42X6x4SLbPc1?=
 =?us-ascii?Q?23R7HOIbx9tQ/5OwBCSt4p8rdYFKHxeEUzzP+y8J7dBwg3XejP3o/sJk6xCq?=
 =?us-ascii?Q?RmWSSYi6CcUJzEQTD+Du3rdYHGyMSHYbos8IxaCpBVatzOz+Q1NyEX7K3T0k?=
 =?us-ascii?Q?aqFDJoewP9QZvbdQ6i7//PDn8lMw+MpJbjtb6dWSdDpaD2sysz7gYwifzNQZ?=
 =?us-ascii?Q?wof0ZaJ1cKTJA/LMPC35VztVHv/2ydPjANUNnf4GrNFnotM2lqNN66sCAHZh?=
 =?us-ascii?Q?rnysC+CrFQQDqAmaKkuwBUv5D1fyX8M04FNI066AiikndyGWYIhmyjxZ7ePC?=
 =?us-ascii?Q?/uhqpbMu2WtKtABOmzcC3h8UA4KmxDBr7OuYPxJd8wPG1+nFP9josA2HV2zv?=
 =?us-ascii?Q?TH1xzpiMEAWcbLR0h/fq8oyVXZD5YtZEhGlVwoH52aaHRjoASXcXMdrTOLI1?=
 =?us-ascii?Q?zKyRIh/Xcw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fdc60b-540c-4dc3-5941-08de759d1cf2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:11:19.1363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3tswtE+TNiI4lJNezeoXrhUpZG3JYskA66YEccRNgVZHOTCP12DMbijXxKeT5Bf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17266-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 759251B1654
X-Rspamd-Action: no action

Like ib_is_udata_in_empty() for the request side ib_respond_empty_udata()
is called on the response side if there no response struct.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 25 ++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 663f452946c782..62286a06db8168 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -709,7 +709,7 @@ int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_udata *udata)
 					   &pd->qplib_pd))
 			atomic_dec(&rdev->stats.res.pd_count);
 	}
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
@@ -898,7 +898,7 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_init_attr *init_attr,
 	if (active_ahs > rdev->stats.res.ah_watermark)
 		rdev->stats.res.ah_watermark = active_ahs;
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 int bnxt_re_query_ah(struct ib_ah *ib_ah, struct rdma_ah_attr *ah_attr)
@@ -1053,7 +1053,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	if (scq_nq != rcq_nq)
 		bnxt_re_synchronize_nq(rcq_nq);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 static u8 __from_ib_qp_type(enum ib_qp_type type)
@@ -1869,7 +1869,7 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 	bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq);
 	ib_umem_release(srq->umem);
 	atomic_dec(&rdev->stats.res.srq_count);
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
@@ -2030,7 +2030,7 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 		/* On success, update the shadow */
 		srq->srq_limit = srq_attr->srq_limit;
 		/* No need to Build and send response back to udata */
-		return 0;
+		return ib_respond_empty_udata(udata);
 	default:
 		ibdev_err(&rdev->ibdev,
 			  "Unsupported srq_attr_mask 0x%x", srq_attr_mask);
@@ -2375,9 +2375,12 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		ibdev_err(&rdev->ibdev, "Failed to modify HW QP");
 		return rc;
 	}
-	if (ib_qp->qp_type == IB_QPT_GSI && rdev->gsi_ctx.gsi_sqp)
+	if (ib_qp->qp_type == IB_QPT_GSI && rdev->gsi_ctx.gsi_sqp) {
 		rc = bnxt_re_modify_shadow_qp(rdev, qp, qp_attr_mask);
-	return rc;
+		if (rc)
+			return rc;
+	}
+	return ib_respond_empty_udata(udata);
 }
 
 int bnxt_re_query_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
@@ -3174,7 +3177,7 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 
 	atomic_dec(&rdev->stats.res.cq_count);
 	kfree(cq->cql);
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
@@ -3376,7 +3379,7 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	cq->ib_cq.cqe = cq->resize_cqe;
 	atomic_inc(&rdev->stats.res.resize_count);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 
 fail:
 	if (cq->resize_umem) {
@@ -4129,7 +4132,9 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 
 	kfree(mr);
 	atomic_dec(&rdev->stats.res.mr_count);
-	return rc;
+	if (rc)
+		return rc;
+	return ib_respond_empty_udata(udata);
 }
 
 static int bnxt_re_set_page(struct ib_mr *ib_mr, u64 addr)
-- 
2.43.0


