Return-Path: <linux-rdma+bounces-21724-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3nT/LObUIGoy8QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21724-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:29:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9DA63C331
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:29:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="luin/KPF";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21724-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21724-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C02C1303C629
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 01:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537B9269CE7;
	Thu,  4 Jun 2026 01:28:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8651261B8A
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 01:28:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536485; cv=fail; b=DuR0ln9MlgmgVjlfJRxGBsFcd9yQeXDxXfhhEVPtoNFbvFH38JTYdy0q/an2JUxskfTuRxNQG1gKRDa2D+rmTX9c4x3u5OMQmaNn2zW5dAvNNIs20O6Q0Iv5jPt5b3qGolvaVaQwyTjzkdogGO9s8+0ompGDsrP045zFCXB16tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536485; c=relaxed/simple;
	bh=0X9MpUq9Md6FnrKXnGhbNQv41xEYJssBUDg5quWYhfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tthJ3eIIQGWhiYYA4zRAgD63wEREA9yS2QdMgZiMkgHEOEh6Anu1lQ9paQdz3WID4nNDApKPt/sbTSxL5K93CbTRfrAarbnI6Z0oEtDInsdqxd13bMzdgS3xaDQ9+Oh8Lieo+7a/4fP55+BKtlCAfv9bDwXeSwmeMViLkC5ehiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=luin/KPF; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdv+YrecjDn26ZavGIry2ILHGmNiZ92RcrjKYrPvmRLHJZ4denAzRqL/frtMf4JgiczFWC6HALaYMV/dW5KnrUfDPonccy+SMbiPK/q4fk1U2+otMjgpQOFsYyPtcJDddK/7oGR/VvYhalO+AmFNTQPJBC8+g0zqLVNF0NDbRqo8+w1Eg8H3/QzggW/6j+u22VSQF8W5HGnz0W/lFFxE9VzsLvYYGOrhMB/mdgowkf0Dv4B/Bcfg8T7dBBwdeTvtDKvp09KfQ8H1dJm0FDOzvrxHvQ7Mmuaff0StyFIwksQRMjwaJM1Oi4pYOKOqzqLWs9dS9ft7YfkbhCq/KU2EiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGBGKYw7oz2M8QxXeKKqe8YxIDPwlFLk2hYzI2WMBGM=;
 b=MTYBFa4DDXWXRXs5tomaIYHJ9Z/zJMfXsD7YolMb4h9Vb3ht37cdb2W5M1BXf8CBqVJ9K25B1yAfMFa/20d88ZVkoAiQdplxUu++FruZQfI7KVPU3B172Gu+fWBt3ZXhCFS3iDkRPT0WzsZ1lwRf5k7mzkVabWEPWtoFoZjOsvLEr5qX0Bcy23YeDz9u+aH4EQjapy1mJBQ3bgz1Nx4f9r6BmGykgu4nD0Wnj8NenkE7XdaJUKf6pT/IXsI5e/I+dAwy7rMqBlVln2Ze+8C58imohXrue3g24k7hMNuhzXtxFAPN+y5UuJ4PilgXk37UPmaqCID8Ka1MnbxX7dCZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGBGKYw7oz2M8QxXeKKqe8YxIDPwlFLk2hYzI2WMBGM=;
 b=luin/KPFgRXE8HkCPUbFlfBf6C2TzXyCbGb9ifZZYae9HKESZCqAxj8DZ/jGKtkhwheal8UeBxPlnfI3hhT4tyTQbQnkNIEmZJGpWV0k83/FcFoLkdtfqmF/w+Jq1hjOk757OUvnfqhzcTPLJwc8sxzpF2Fzxwtk7KTJRZ2gMCrLyeyIGREer0k0UoqCuwv8AAkCYSNrROK88fxco6vTdrneiNr/J7TShxuoh+PneGGSrfG1kMbWPn1pzt5qOCsdrH+wMNhgSq0HyaTaZYJ6jhG9FT5tDjvINF487zfAeAePXfLt3p0z063JcjxoRi/ozj+Q7c6HtVf3jXpoOgsUAQ==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:27:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 01:27:56 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Doug Ledford <dledford@redhat.com>,
	Edward Srouji <edwards@nvidia.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Matan Barak <matanb@mellanox.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Noa Osherovich <noaos@mellanox.com>,
	patches@lists.linux.dev,
	Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 10/10] IB/mlx5: Push pdn above pagefault_dmabuf_mr()
Date: Wed,  3 Jun 2026 22:27:49 -0300
Message-ID: <10-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
In-Reply-To: <0-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::31) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 340764e1-4d13-43ce-d306-08dec1d87fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	+A0vstcoaVkPjYPJcGsNI3xY435MjxMnUvyLg9FaDayCrn9/fW8Dy+XqejJuZBtj6TsA8iS96ApMdm/5RT/NAlRX7ajVF277dh5mxqwg15ZWK5sztYZ0tcC+Tv5ujM4JPJtlcnCFV0hebWP8boVIEaA++6pzCunORnbn0m6Wy6AOYROXIu0yV8gVlIwT7aYH7F/+fPTTX6Uzlqe8oEb3psHKtzVy6qUfwBebDKIvU/GapbaKP7pXu1gTGNQjka/m0nZ47ADcBoBFBgD992xElk3RcqBL7wFmNzofxkddZfudnKqS6JXzb/x3E0ut2faGQadRtacXQlnvkkeVDibT3Ai4klT7nX4oDWJBXnbmig+XQ6tl30ZokDZAGRk1YoJF0eW0xkCGNASNbKXyQQIVG3gNh7OdKboBavwjZhUNR/h5lWn1hXOnFJmn5pQ2gyX4C5Ro/IIjibqs1fCntEMr8GdLpRX8D4ikug3PDFZR1h8VSykktGNFwz03PPro/UYbtNNPtv1rHBiwlNUT4NJ3MX7b/utl4TIFp/ijdb4GDS9A5Gp5f7KueEX4xOQiUenQuolYx94zGkbGoOkJauMxHEPn6gyJOhnv/h8IEg9sZt5VlNGcINvKOxmbBh8Be5NAtPEHYV5xP10C2WyuhXT5cANzBCceQzlYc/IdzAoI08iM/AyMV+uviN5CHL+vpxJ+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HG4S5VVJkRishujDDIARO7EGQUBth34U8I8+Cr0vFEmVXy/6rzngZMpalCRx?=
 =?us-ascii?Q?oLCuH+L6UUybNOC71bD79H7y5xxG+hBYBwKTAhGIjIy7W9h0ZXatjukH3Rhe?=
 =?us-ascii?Q?MFymFic3FD9f6Ql/vaDgDdD+bpzE9NEQj4irJ7srtWQnF/LBWZVIvRyF+Zbv?=
 =?us-ascii?Q?YbzTBOK46DgWbG3aARwhvWWaphlcbplXR+OehGtdKc6WxSC4lffM2fkpLr6t?=
 =?us-ascii?Q?KgnInmTt11PdDR7yncWRmGemvDcGdnE5yUQRCN5Zr2JH3OVfasYT16SVrprA?=
 =?us-ascii?Q?AreNUcaCFXQUazqKDXrzS0hbe3AM8lBDCsYG+pkE1orAA+V5/WG1JnRoRlCS?=
 =?us-ascii?Q?hfmTIyh/2y17VGJGZhlT/znX2zF8oQVwXmeb1yRc+YZT/98DqWktgks6Pm0o?=
 =?us-ascii?Q?dbAJt1uY/flyDhC1777gaqy+mTYuFyPg5LlYMtO4xolsTKRz+izRn7FuUUBY?=
 =?us-ascii?Q?2irtWNr8pgkfNKHyhAvQojyvaZ9C3Vq6jvinCSjQOyAeZyGkKpSBC0VnKJvo?=
 =?us-ascii?Q?rPlsCE4tXLFzx/ckEgO1L5spfBqWdFNNtkgr5pQuwqaV7nP3HrgQ5z0TBlVF?=
 =?us-ascii?Q?23ky19xnu/IKfuGI0PP1h53XzTEHeAjYfo/W6iLTm22OG1PJgDaSuKsqvJIU?=
 =?us-ascii?Q?srnEnBaBnb8r793cMrLDw1qaXLHh3YgBl7LZ2BZvUk7OiCaeUt0YWgyls7x8?=
 =?us-ascii?Q?qpkzzv9rPsn9iq8iRNwjLVlZNHPkQMyMKe9yhiOBtJRMueN4eKQ6/iH33wFn?=
 =?us-ascii?Q?lcJ+hYk78a4fUuNx4g+aORViqDWy1Od2Q7La+U0qxTdF9ySazBkL12RDuKNV?=
 =?us-ascii?Q?MFMotCUADitXFQnw1TuqCxKFH7KYaTkF51JmuceonHQTvqUp1fVaxiosMI7q?=
 =?us-ascii?Q?O7yvCTSUtXP8ue2i/hnEi1Ch2et9uL1uBsy+GC9V+iygz41EWmSP45zOFGs3?=
 =?us-ascii?Q?GfqA7wgdMsKDLvBmx6LaqkK7dkXDu5gyksDaWfNBMa2TgAIPwmASZ8tGRVw1?=
 =?us-ascii?Q?89e3p8LnldCVRoyk8rSOEEtyMzHQIXE18pncgAF5ynWPABTJ2yCXX/Mb2dTm?=
 =?us-ascii?Q?BR11dLcXZQuikWIZhhYWu56WMZ3K6bMFLhF2G2eqQdrLR/91LaBPLvId2Auu?=
 =?us-ascii?Q?AFsyLHaUHtpKsYFMNqN2Jg3SZoydUsyVX/fpP+vPjrvj51i6xWZ7zpPhnHUb?=
 =?us-ascii?Q?nESlmWYIsExwgYfbUTgnlwMCUPROz55w8eIOsd4m+K99HvpZTwo3eLD/dWzm?=
 =?us-ascii?Q?1l7w4l4VNYFy7Oax9MSyJNExapysqVIZaAibxipGJoQbZxsM2l+pGBq0wvA/?=
 =?us-ascii?Q?lhp6OseVhFE8/GXSiPOXRWj7eVHuJplaWsqjIjdDj37mswfYzpMv1qNMG6qc?=
 =?us-ascii?Q?w1TvJUfte4WIalwoY/zHc47K3hhaht1GVcuyYWgOPfJMUfY71iy4H/GHr/4Z?=
 =?us-ascii?Q?zg+7hbm7HZRCFJHCqiyRgBa804ixbKDjOPeV3VH+z9ckbnjxvTGFtqhEkAtc?=
 =?us-ascii?Q?v46US5CEw3T4mA5sGU+pVWAVQ2DtI3fXrMD8KK79jsw9I4uO3WGkDPGemqZP?=
 =?us-ascii?Q?0HUkHRnaUVtf1xmRUMQN8cP59e70KDDrI6uu+Qnh4hsCARn1AjzuL/1yLcDI?=
 =?us-ascii?Q?GCB9iLeTc58HoMsKTgvdSLH3xQsLOvEJouAd2ml4/kqNIySzp085Vl7rU9B+?=
 =?us-ascii?Q?vHnBYLSGowpfmwM+4aaDudoEZ1PWtC3Gpnyu7qye4U+I2yeB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340764e1-4d13-43ce-d306-08dec1d87fab
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:27:53.5395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoUqHqcwe+b0C8mdB+xcgF3X6/jA9D9wxbFqr+aevSeDJDsL30vNtAwen1rNDDdC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21724-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:dledford@redhat.com,m:edwards@nvidia.com,m:leonro@mellanox.com,m:leonro@nvidia.com,m:matanb@mellanox.com,m:michaelgur@nvidia.com,m:noaos@mellanox.com,m:patches@lists.linux.dev,m:swise@opengridcomputing.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D9DA63C331

Remove the mlx5_mr_pdn() inside pagefault_dmabuf_mr(), the only user of
the pdn is the init path which is inside an ioctl.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  9 ++-------
 drivers/infiniband/hw/mlx5/mr.c      |  2 +-
 drivers/infiniband/hw/mlx5/odp.c     | 21 +++++++++++----------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 1c88a11f8dfc93..74613f53483384 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1213,11 +1213,6 @@ static inline struct mlx5_ib_pd *to_mpd(struct ib_pd *ibpd)
 	return container_of(ibpd, struct mlx5_ib_pd, ibpd);
 }
 
-static inline u32 mlx5_mr_pdn(struct mlx5_ib_mr *mr)
-{
-	return to_mpd(mr->ibmr.pd)->pdn;
-}
-
 static inline struct mlx5_ib_srq *to_msrq(struct ib_srq *ibsrq)
 {
 	return container_of(ibsrq, struct mlx5_ib_srq, ibsrq);
@@ -1423,7 +1418,7 @@ int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 			       enum ib_uverbs_advise_mr_advice advice,
 			       u32 flags, struct ib_sge *sg_list, u32 num_sge);
 int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr, struct ib_pd *pd);
-int mlx5_ib_init_dmabuf_mr(struct mlx5_ib_mr *mr);
+int mlx5_ib_init_dmabuf_mr(struct mlx5_ib_mr *mr, struct ib_pd *pd);
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline int mlx5_ib_odp_init_one(struct mlx5_ib_dev *ibdev) { return 0; }
 static inline int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev,
@@ -1455,7 +1450,7 @@ static inline int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr, struct ib_pd *pd)
 {
 	return -EOPNOTSUPP;
 }
-static inline int mlx5_ib_init_dmabuf_mr(struct mlx5_ib_mr *mr)
+static inline int mlx5_ib_init_dmabuf_mr(struct mlx5_ib_mr *mr, struct ib_pd *pd)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 46847054491f50..193f874482edf1 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -969,7 +969,7 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 		mr->data_direct = true;
 	}
 
-	err = mlx5_ib_init_dmabuf_mr(mr);
+	err = mlx5_ib_init_dmabuf_mr(mr, pd);
 	if (err)
 		goto err_dereg_mr;
 	return &mr->ibmr;
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 2dcc4f5339f9d3..1badec9bf52708 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -836,17 +836,15 @@ static int pagefault_implicit_mr(struct mlx5_ib_mr *imr,
 }
 
 static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
-			       u32 *bytes_mapped, u32 flags)
+			       u32 *bytes_mapped, u32 flags, u32 pdn)
 {
 	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(mr->umem);
-	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
 	int access_mode = mr->data_direct ? MLX5_MKC_ACCESS_MODE_KSM :
 					    MLX5_MKC_ACCESS_MODE_MTT;
 	unsigned int old_page_shift = mr->page_shift;
 	unsigned int page_shift;
 	unsigned long page_size;
 	u32 xlt_flags = 0;
-	u32 pdn = 0;
 	int err;
 
 	if (flags & MLX5_PF_FLAGS_ENABLE)
@@ -865,10 +863,6 @@ static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
 		err = -EINVAL;
 	} else {
 		page_shift = order_base_2(page_size);
-		if (mr->data_direct)
-			pdn = dev->ddr.pdn;
-		else
-			pdn = mlx5_mr_pdn(mr);
 		if (page_shift != mr->page_shift && mr->dmabuf_faulted) {
 			err = mlx5r_umr_dmabuf_update_pgsz(mr, xlt_flags, pdn,
 							   page_shift);
@@ -915,7 +909,7 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
 		return -EFAULT;
 
 	if (mr->umem->is_dmabuf)
-		return pagefault_dmabuf_mr(mr, bcnt, bytes_mapped, flags);
+		return pagefault_dmabuf_mr(mr, bcnt, bytes_mapped, flags, 0);
 
 	if (!odp->is_implicit_odp) {
 		u64 offset = io_virt < mr->ibmr.iova ? 0 : io_virt - mr->ibmr.iova;
@@ -951,12 +945,19 @@ int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr, struct ib_pd *pd)
 	return ret >= 0 ? 0 : ret;
 }
 
-int mlx5_ib_init_dmabuf_mr(struct mlx5_ib_mr *mr)
+int mlx5_ib_init_dmabuf_mr(struct mlx5_ib_mr *mr, struct ib_pd *pd)
 {
+	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
+	u32 pdn;
 	int ret;
 
+	if (mr->data_direct)
+		pdn = dev->ddr.pdn;
+	else
+		pdn = to_mpd(pd)->pdn;
+
 	ret = pagefault_dmabuf_mr(mr, mr->umem->length, NULL,
-				  MLX5_PF_FLAGS_ENABLE);
+				  MLX5_PF_FLAGS_ENABLE, pdn);
 
 	return ret >= 0 ? 0 : ret;
 }
-- 
2.43.0


