Return-Path: <linux-rdma+bounces-21834-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XbGuFtO4ImricgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21834-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 13:53:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7698D647DF6
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 13:53:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=J2e213du;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21834-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21834-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 546BB300463F
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 11:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058B64D90CC;
	Fri,  5 Jun 2026 11:53:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FA74D2EDA
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 11:53:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660424; cv=fail; b=VXrL3HS+pLgLkIeJQDLJKSPGJ/aAsKiSOj5rhTKStQefVoAHCTFjfgMEQYCi0ImikKezsFuL0mVbALS3MlD4+rXv7p/BzQXsD9czbsSXZjCwxdmaUca1EASkAVQldZpu+gBTDeEakcoEI7ci9pM3KlWt5C1teXQZWlrrTn7rKxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660424; c=relaxed/simple;
	bh=OX/neXOEiFXL0ML8pVClNJc5Msk3U3qzf45viT6gNQc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qkNrLa4jAGLhR5U0FsQyF9+5W0J3e+1GfD9z65FF/QcN7tuAHvgmCo2/mzEB6tjKwGFJKdepNayQxPbI+1Glx1R4rUi3DKu7841UGR7rIDwGazhhluTRmmWx2gU46MI/GdLY3LQaUSNmTxDPigSio4jT7DK0HjLQpwrStFyhn8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J2e213du; arc=fail smtp.client-ip=40.93.198.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgV0soKGt4ltRFvrsQ5ernyQotmC4untQ7LV0psziuQKXGodZvlZRMQJtOH3MZNb8GBMufmY1h6Ib+anrXa7wHDwnGl1oQnJu2eNNcLvYX/D6wQHcWTTbuF+PpjpkOaJ3QF97Qt4zPYky87qIzxHkQS7SkSlKVE1F7gINWo3wC4j8yxM8hqv4x8FU0AvobS+eJNhs2HiatshRb4rftVVVuJcfFQSVaz8+FBMTbWSpv6QAHD127UCAnwjqUuOB+MXlpBYLuajAmN1ZU5oNJfh8nlFHCVtGQusfs9ATfve45TgUJvLXYTkITE7o063ZnpzIt4/TFGUEPSEKRk2i2m9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/irmv3bn3XKTFpeNKSHvlaoTPs4bcCvu82x2MSVwSY=;
 b=dR2R5GanH6zVXJVMqD0+NkAWkGHeE3XI9pXzTCeRCQJaThq+vgX1D/50nbqsuJgEJKgOf5SrhDNdrymSNHGcf8vN70DecdP/J0lzssg3kARmVZ9wrg+ljH59yfhgCnndMH/A+pQ2zozq/55QuBr9CZ88p4gwGiigsv5HUNTVo+Mvms5Ah0EWPsagpJ/QUoTowkVkVFcQm6gIqjHt83Kbqh46kPsrbM8wiI1OJSmYlM1e8CduOJPWRz+y7lQhvQIS5K/3hhb1s4D1EF8B1XlhYHZP7cgGEhERjG0UlMqae/aik+4CUKTcSFjfUpcRby2SBSwJnqt1sQNUbbeF2wBWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/irmv3bn3XKTFpeNKSHvlaoTPs4bcCvu82x2MSVwSY=;
 b=J2e213duaDeafUcS9b5sypmy1+KVAHlPYY+7OcHk+4dsH3kiPRadu2tDWfWhSEok+2oEreNDQotgkB5sS4YRzJbQ8Sl4PUfqMsyI53+NI9rqg7WonuReIXJjNH4slZ1+ddgph91Za1G31aQrbMmT3WBw+E29ktI/StgQoX6K82OpNv80o6jNkv4xGhqkI+oLcpBEyxI4TgjlMvCw/gu+nWCHo0O8Gjo7RYHNpB1ssKLOwP2a7fiPnibp/Os+Hi8GKFWyRUh1aonQShI778FAMmI4qXkzoGh7eA+mYRthSuwz+anr2luh6PgOJeWpsR0ABF4By3G2xCl4fH3oPErHVg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 11:53:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 11:53:40 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Cc: Matan Barak <matanb@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>
Subject: [PATCH] IB/mlx4: Fill in the access_flags if IB_MR_REREG_ACCESS is not specified
Date: Fri,  5 Jun 2026 08:53:35 -0300
Message-ID: <0-v1-29ca7a402625+ddd6-mlx4_rereg_flags_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e6cfdf-8b17-4e6e-4447-08dec2f913ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099006|11063799006|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	yOTVna2F967O88uiBOHPmE5ErPUvxisvdMCb8I/oN1UBqP+TCE43zaE8W06Ary7dwXME49d/OlUyQsMMxPyKi9Gq7NouZbGHeoG+Qj4VU1/haTDDn0/Dl3Yuq4yfroA2o1NoyF464Z1CMI6p/TmHVPaMLbV1B411gU/2bn3p8e/dRAeg9dQL2mRkUCp5YBeziB7a7bboxW+8zxVV7tLH19nX8ulNoiZ6gc862z2GuYN483wYltZYQcQaIxX19O4emzoTYjcmTukb/DFJ4y8Cea/uTwDCAkXU3iCMolKyEzm/INl0twsCSwhh4duL86jQBFt1Q723SD+ZV5wFKdVb5gwU1YXGcQjG8ij1goD1Du2husNymUBkr2I2yKovFQen1/MXJmMgm4CBwXuEQcv/GuCYXUmDHTRUWdc3YwjBgjkOMm3Fy9xUTCCLpa+kK9/FHC6Ew/qUVaVM5tsTDrKXdM/d2l9bzl6TDnbkpAQq6t71ikqUOs+FdqRJd8Siw5sa15SdDu7MKM1uIb5gQpXGbRf0xDBBwQp/DZXXsXROBCukPPiT/bI1A+mX4epGzyCDMy95/2vM6Uq1czTkbtnIJ4m2xFTDMGpocDN7F34YFIiSeO+kCGDBZM4iKLqrGw+sXQQ3aeRbl7jfdyvLWU5H2SgZ0eUZU51PV9bIYjEOjy2Nv+cBZU4TzGqDx1Z7pd1M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(11063799006)(18002099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FPbO7+Y+/FODTJKVRqP6fhS1UyqBGJLm48z0Ywm20bSkdjzuzS0SBzKoVezU?=
 =?us-ascii?Q?n3O2DOQTa9bqEhIsMjW07tY5JjVWY3q7eXwfRWZOJ5hVWaO82v3DWgW9kAdH?=
 =?us-ascii?Q?GF9VWojXtAkqhkGADMyX3OE41c+ZwUI4G/dQ0c3W+hB/T6cS+EzXlyYTvppS?=
 =?us-ascii?Q?SGPbEbPTdkxy8rJ0pY71o6tTvIuEmq7ha3TWj/Wgxx+jmU6ra+yfvbzxF9ds?=
 =?us-ascii?Q?TZEMYCW0KR6IVl+zsIIUlMePGXT0IPzJKefyNuW7w/wP/ReGurA6Ehce2KyQ?=
 =?us-ascii?Q?R84ha94kTgn934tn/DF5Tsr5WOS3iS3ccNCjRPG7LZ8w8az4Qdu5iI1fV5Rs?=
 =?us-ascii?Q?6Ycpu+yQ084XpElUQbif4/1k5H0KQMZjnaSBZi/NpU9WnNaTYjd5xTpyDPaD?=
 =?us-ascii?Q?HLn4W3fZB9QRwSAJBPWKHBE4osb/CXojr3yX8Hme08PbZb7psixNJA6lqX3A?=
 =?us-ascii?Q?GEAtWnHvHHzVadEQFVgbh4i3k1ANKut4kI31eudqXTvrpYUs5hK+raUT5O5J?=
 =?us-ascii?Q?RAbluGUOfNS4x/csyCUF1zBlM0UqYLe0bes4kfvdpjQ3qU8PIdh9w1wnJ+Zv?=
 =?us-ascii?Q?ggz/2vc9f2gGd5uAqJ/8To0SKVaHp0n4YeXhq43HhE2KZonNZaq7QlxC4j4B?=
 =?us-ascii?Q?lNfSSr6Zo+lTxmn4iUYrO4aOCGai8Geo06FCXO+4XlTd3d+8eyQsv5ykI5Hr?=
 =?us-ascii?Q?uN35NNwxI21wxODNXiVYHSThzy+kGcxPl+HgE8Wy0zg582oTYycq4NXJVaST?=
 =?us-ascii?Q?YP/mRZRSpPBrv5Z7c9blXHbtx+uO+ce2jBV7QuRudh2N0LbyunNdBffzw0Bv?=
 =?us-ascii?Q?Ubh2Uwzm/9gvv7O/l7wDISVNtEEyd2HS/ugl3Br+sCmdb23S0J3my6Slyk2q?=
 =?us-ascii?Q?VNdAbGhjDRCimL9h6yu6fcR5USvSMAEsrv4jbo8sJpc3dI/qo7EjPPVYxIUp?=
 =?us-ascii?Q?5MR0FrDlLViPtjAwMUkfqdKehJv2wuRzF/i4Nh3jOCauJoOUiHaUuCXtpTfv?=
 =?us-ascii?Q?yghKCZiBFxWm/doxH6/COu2zg2AJ+SrZFHik5OCavF/qOoXsarAgWT27iX+i?=
 =?us-ascii?Q?V5QsCd5s5h4WWf6A+QKRE6qHMaiYhVYs6ZjVkC0ol/SXSACEs0ckEoleivr+?=
 =?us-ascii?Q?WI0WqL993WQsHoLGNLSd3otBpcBcUFym2ADiWoQURm+42ZpnqGTYgV5acfrl?=
 =?us-ascii?Q?U0RVKXqeewQv0w0XE0RCsB4Z6toFJAACBt6g3JcAJlmwVQ/gtfSW+W8s5m9a?=
 =?us-ascii?Q?YEOGrm9oCCmxXxjdt84nacWAwZoPO7/XJf1Kvo7+Oo7ekw/Y5RhjB9inSIbo?=
 =?us-ascii?Q?NTRzQLEtwwZp8Y6zBRyXfy51nN9K7EJRoeJpMZtaFEK3ZSDNYcroNfh3bkFL?=
 =?us-ascii?Q?tUsJ+kkm0BrTaCEYsp0rhS2L/iUk6uNZr+gWbzQsKtLS2Brj7sM2mE1bwZgG?=
 =?us-ascii?Q?0O4sX9t6jDvT5Y7GdJ8V8Q+tQZpoikG2pi0EGxmupM/nzlGp68LFztU9HWE6?=
 =?us-ascii?Q?iVLjWpWFaLkh3AzAQ+oTR5Aif9OQHCcGomPTX24MBVPSCvKRk6mFkKqcxrwD?=
 =?us-ascii?Q?RTRrOPgu9MXuhNev/ht16Uvd96srsXJMQIrzTNCNIdehAJZQlrpHiunwUg7Q?=
 =?us-ascii?Q?vvvL4RuAmxOLW53r7pcQiESlhCMaJQQsZKeetsqee1AsQwGyc+DolSktnrFL?=
 =?us-ascii?Q?w5mY5gtOYAWJopDZs+tWjbTPV7fjV9QDDBYid9lAdI+TXJ2I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e6cfdf-8b17-4e6e-4447-08dec2f913ee
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 11:53:37.1526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDb6Z+3bR+raBa0SExWCaDWPZcPLRJ7VAzy2+Gf1EQnSISCDOU3JGmONmknDhEdU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21834-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:yishaih@nvidia.com,m:matanb@mellanox.com,m:ogerlitz@mellanox.com,m:patches@lists.linux.dev,m:roland@purestorage.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7698D647DF6

Sashiko noticed mlx4 was using whatever random access flags were provided
when IB_MR_REREG_ACCESS is not used. Since IB_MR_REREG_TRANS needs
access_flags it used the random ones which means it doesn't work sensibly
if userspace provides only IB_MR_REREG_TRANS.

Keep track of the current access_flag of the MR and use it if the user
does not specify one.

Also fixup a little confusion around mmr.access, it is the HW access flags
so the convert_access() was missing. But nothing reads this by the time
rereg_mr can happen.

Fixes: 9376932d0c26 ("IB/mlx4_ib: Add support for user MR re-registration")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx4/mlx4_ib.h | 1 +
 drivers/infiniband/hw/mlx4/mr.c      | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

Sashiko also noticed the error unwinds are broken too, but properly fixing
that that requires switching to use the new mr replacement rereg flow which is
not worth doing for this ancient driver.

diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 5a799d6df93ebc..898c8363422abb 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -135,6 +135,7 @@ struct mlx4_ib_mr {
 	dma_addr_t		page_map;
 	u32			npages;
 	u32			max_pages;
+	int			access_flags;
 	struct mlx4_mr		mmr;
 	struct ib_umem	       *umem;
 	size_t			page_map_size;
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 306704f54325cf..de076b176b0ec8 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -181,6 +181,7 @@ struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (err)
 		goto err_mr;
 
+	mr->access_flags = access_flags;
 	mr->ibmr.rkey = mr->ibmr.lkey = mr->mmr.key;
 	mr->ibmr.page_size = 1U << shift;
 
@@ -235,6 +236,8 @@ struct ib_mr *mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags, u64 start,
 
 		if (err)
 			goto release_mpt_entry;
+	} else {
+		mr_access_flags = mmr->access_flags;
 	}
 
 	if (flags & IB_MR_REREG_TRANS) {
@@ -276,8 +279,10 @@ struct ib_mr *mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags, u64 start,
 	 * return a failure. But dereg_mr will free the resources.
 	 */
 	err = mlx4_mr_hw_write_mpt(dev->dev, &mmr->mmr, pmpt_entry);
-	if (!err && flags & IB_MR_REREG_ACCESS)
-		mmr->mmr.access = mr_access_flags;
+	if (!err && flags & IB_MR_REREG_ACCESS) {
+		mmr->access_flags = mr_access_flags;
+		mmr->mmr.access = convert_access(mr_access_flags);
+	}
 
 release_mpt_entry:
 	mlx4_mr_hw_put_mpt(dev->dev, pmpt_entry);

base-commit: 8f064f2e2bd23f84dbfba26b83e08d5de7311d44
-- 
2.43.0


