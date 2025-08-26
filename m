Return-Path: <linux-rdma+bounces-12936-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F6FB36D40
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 17:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D478E18978C4
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200BB23A9B3;
	Tue, 26 Aug 2025 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LUp9XuX4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012040.outbound.protection.outlook.com [52.101.126.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B921DF75A;
	Tue, 26 Aug 2025 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220774; cv=fail; b=TQHtIKx0+s4qp7ZURPPL9UbpdJ9GlQIQ+kMyP18CBd8jplx46s4MXIs86cXdGQK+fcJc7RTVeIVWGt1ykwy4ahEAFDB8JARbrb5b4Aprivybx2Y6UywAdQMoDScmGy/xSAKYRoom86Uf0iEDGMP1WsN4L9SnELub+D2FkhXxk4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220774; c=relaxed/simple;
	bh=hGinhzbUY1KUurx8xkefpZV+Tw8mPP/3Zp6WeMWjQEY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=d0hvg8cGiTV6O1CRh0uYmq1VHuXjmcisrZAF+YD4Qp062E/5oYvfg/R3Ueo9IYZAce4JHf9utALahjSbU+Ujep/NJNawjZj7Ig56tlfrQ7EX7v+NgVuWAJGGyrJzlxJV0xFVWZUq5m3Xfu/n8eWpJUDdqrTGL0AwDgv/I0ACrDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LUp9XuX4; arc=fail smtp.client-ip=52.101.126.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2dOsED2Ct2Vbe/Bx8y+x2baPGEhUSThY4uhQpawlbaRadxppu80WFpLfS0E9rYeoug/c2+tBW6BWTUrU9WpUEPHNWBGbukQORyFlv4y+rBPhB7iJ8+Llj6ClXWahJZSA0sGlCAMMRUkIuwP1zA3vqQiCOKAy0v1JtXqBMaj6sWe6l6Rhk6+RBep17MytiC35wtt3lG3gOnmrfmlIOz/w0DskqO/jtQ0tj54D0zntQljm/2S8LFrox8TMVsbSfcnwXnBUQ1P83pr+VxKLtfj80eB3JOSl3DiP5ofYK5K6AmNlzU/Z+dUO+6MocRR0R1Z0AIpzAUOs1luY7v+PpVq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xizuh6kl+a7JDK5SZuHJB/wfppPPuLYDLcgIk18o090=;
 b=SCjpI5NYO+VU0fGvuYReVhvkbeKze1rAWBrPQ+mM0w3CNPLZYf6zrDgak2iMl16+s/YxVx9akTEafvvEARoaEcwOw8xSA+76amlFlZTLBbBAnwbsdjAtNoP9pAxUf6HFqhfFu9UwpFF9sKCLwruSBFrX7KB3UZeW8MGSNK7sr+fCjN7DDxzvcAdO+xfWvOsEG814IYNNFpc7jPVsWmDi2nrW53SkC156+ksI+pmJgvXapeFEG3qL99Sj0lMZubvMQjL5ZEXSNdlTSyK14bipVTXdL7ZUDK5vpEez+ecOYkQLrGBfX1BESkuD5AMNgUqyCpyrf7hKK61JQrR9pbPeJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xizuh6kl+a7JDK5SZuHJB/wfppPPuLYDLcgIk18o090=;
 b=LUp9XuX4pARMkBoz5z8E9AZMfTD1P80pWHOmInn1qNtD4bSNNjkxwhHYJ05BrF1jQoC3FuzbIxZPOJy/YbosQnRxWXWfkoSGlmgwTIPo4MuSNpj+bqvgoXvdfIvKKFC2TMuEj4dV/xf5HU4Mi87HoiSs+D6tkhThgzE8asvyeyOsDzTDKX7COTwzWvM+N7WMCE/DZvZ8ksyo3AK/16qp2PrIZTMu2eiWXITydhmLKhB0WTtLtwExSSUAk8uPQS5gEY/jWMlCkSxu4/N+xizAgnaexlsj6TowWzHRCm9ChvID5CS11RI6OaXmhQp5nax7jOpRClJoogECdHC+VE4KJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5128.apcprd06.prod.outlook.com (2603:1096:400:1b3::9)
 by SEYPR06MB6981.apcprd06.prod.outlook.com (2603:1096:101:1d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 15:06:08 +0000
Received: from TY0PR06MB5128.apcprd06.prod.outlook.com
 ([fe80::cbca:4a56:fdcc:7f84]) by TY0PR06MB5128.apcprd06.prod.outlook.com
 ([fe80::cbca:4a56:fdcc:7f84%3]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 15:06:08 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] RDMA/rdmavt: Use int type to store negative error codes
Date: Tue, 26 Aug 2025 23:05:56 +0800
Message-Id: <20250826150556.541440-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To TY0PR06MB5128.apcprd06.prod.outlook.com
 (2603:1096:400:1b3::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5128:EE_|SEYPR06MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9ea4ec-20eb-44c5-7fab-08dde4b21614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o6x1WAI7UvHqxLdqkTF81IYUCnUadWiLMJb8T28xH47pmIE7KN6jpRsBBpNx?=
 =?us-ascii?Q?SIuHIlcc2BqtzzjJ+iIg5+WdWpeCsJRaVlFwbs7+0UUY5XQthK/q41QMgsy2?=
 =?us-ascii?Q?AYl/VjeGMzWAy8rCkbWt4sfClASI3xwTSRtGDWZXQbFONx58wW3kVUdkoBXP?=
 =?us-ascii?Q?kkUgDPXPCGn9Fweyyd50zSI9GSogLxteSoAzNls1oEhF/LIqNEunRHgCcJ7E?=
 =?us-ascii?Q?FqHpL56ULiGNSy5QkF/9ChFS6biwmhhUXXQWa+y0K+eiETjbOByBtMtn9yom?=
 =?us-ascii?Q?nsSupIkksATM1/aVK4iPCxc2PpZF1+eVnhUMNWSytjHKPvda71jUhF20d+Pc?=
 =?us-ascii?Q?1x+lnelImTXu95AmjSB9bCEQsXHlfqwAvdDlLNo2vYTDHVUQMsYiJBq1u//p?=
 =?us-ascii?Q?C4jygGpoGR9rDp2xXVGH3HAXFRPJRZ4ks/Y67IQsWJqSz/i35MsPQF0MNPCT?=
 =?us-ascii?Q?TwnaRAeA7S+FceFyVJver12+GL7hO6JEeBzf5HwblOJEtvqFVTO0U4h59SCi?=
 =?us-ascii?Q?9J/9bK/Tbu0DQptAHtjuiEwY9uxU59fdho2aO05nloVcke+BNIVOBMIdXcUC?=
 =?us-ascii?Q?6pcEjfCklqj8WUhMtSbLZUSu4S+/L+GC9DT2dIZV7+qNoJ3QQd8bmI/ihtIN?=
 =?us-ascii?Q?kpeJhdGdguFCh9nZkO+qosCV5tdhAyWLMBLRKEaaN9B4BBkTpPSXOFH18jdi?=
 =?us-ascii?Q?p25uhTbEKCsudJxAf/FByy3aTj5qGCJG8nyDp/1P76wgYMUXMjeYlsiSt1b6?=
 =?us-ascii?Q?VoIB77QEWZFTZb/92zTsxbO2npw38Gi/MLyVGKbcTjE79e7K5d0uf2dDWfaR?=
 =?us-ascii?Q?hbNMljvfHzHVl6gCHqJ93PYoukmE4rbIsbjvrWcykqaT1so+vxVgBuUUm0Yf?=
 =?us-ascii?Q?ihAIOTnKwVGNhMh3CtgyhQYqpb6bW10WOCfvRSz7cejmnBnnN7EwBykysV8x?=
 =?us-ascii?Q?GpcVLGBV3WLImfP0B4l4uT/DDdrgrWjKIMeMl8GF0Eo82gmljycYLMPtryQ0?=
 =?us-ascii?Q?Ty0B7e80sJnvUKFRLtktqMsUwCpGBM/TOtb2x2Ygf/DYonF7WXA1A4oetVno?=
 =?us-ascii?Q?3HrI0BTo2BkqumelIPOfCH2NUXkAjelxPqeg2upHmRhcvTuBnT3RWiyZxF8n?=
 =?us-ascii?Q?Emju6lS+BrmhjqdpG2HrHWURHF4zTI7XBhoB7pF6qEsZHl44pXYee63aai1j?=
 =?us-ascii?Q?eYp17y7lvHAqm+AF5NC9UrjZtT2kVDy2/nzJfi8mBjGeXTuuCuopofHR+6V0?=
 =?us-ascii?Q?UQKEPYvTS3C/2sD4NrcMWxQqeieJuoVzQJW7zy+7Vyb1znas8KU/dwyco3bn?=
 =?us-ascii?Q?w7DJSyB48xD7fHUcJXqvuxmlBxXadt12GcSED/kwSHv1DradZdxT5A1FdYDz?=
 =?us-ascii?Q?LcG9M3TEyfjQJDtXUGtaWDuE9C6pb48LOB0ygbFAIUsxqksjlFulqi4IK7Hv?=
 =?us-ascii?Q?aPsRBvlcTdkpqbxO9NbTGHQTumPuNbBBOnDeXVJ1WPz5eJSsKL4ezA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5128.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?COqIxBtzmKvJRbVReYYC3rduXA7p4eHn0zJF9mx+NHwcKaW4TWXMAQ9Gcl+f?=
 =?us-ascii?Q?51ddj5IjSYUHrqNz36/5xlj4enVXwRf64mc3up+3cQyDGg0s1D7USjr8GXse?=
 =?us-ascii?Q?/FtMNLSdVuYxllc/StpB9OodZslyrNNuFr531eovKFYm0xi0NRd8nMsuJoUN?=
 =?us-ascii?Q?bjhYzTMTtFnF+p4Ji/ZY55wyIFieCJ2yn93ykNK9+nSWaXQN94x3h7kE+Kc4?=
 =?us-ascii?Q?xcTTyXBNmmxqjPMFGce3W625gF+KL4mDIsuw2z/EDkC6CkMvWez/OukVxgX2?=
 =?us-ascii?Q?1Y2eUZram77o7b4p6MqVXWqFGj7R930TemDH5nJVq1o6R+DqawT4jcq0+Hag?=
 =?us-ascii?Q?wzjy3K33ubk941zQOvcfUAJ/TebhK/697vTb1pbmx1IIUdX/NJXCV6fJyJ5D?=
 =?us-ascii?Q?lytbnyYc5RNJQyFj3K9L/PbmTRHZ+ndtuxJBke7RbhUO2v/Mbe4wQirzrhkX?=
 =?us-ascii?Q?OklviVXIOI24nAmP/fzFmkLQBdi/7SXNyWgJkAp0+het7F1uZ/CgZjPKyAX3?=
 =?us-ascii?Q?FduXbE4I46xDFRpDXubdolWUxG9VysvsLJSeVHodJ169CiwqoeqlZksNpAMK?=
 =?us-ascii?Q?eACToSRav1lohvNaysyzHFLpSftoJcxrkAl/dtEWvmMuo3MSlnxlYu1pjpwI?=
 =?us-ascii?Q?WYpHremvCM78hoCXmktDQBf6q5Uywopi3gH0XSe9aIfEEVnkd5W2k0HXrx6c?=
 =?us-ascii?Q?FWGfzHDk4SzBb2vSU2lNZNlQSHcGcLHaBOTR8A8DKpwhfL/rOU2VwjgPW2am?=
 =?us-ascii?Q?j4wZTgNpM+ZIC6CdA/gNbNmxGq09pKQq+Tqmw/wj7uN3SWTznWBpb6AOeRoD?=
 =?us-ascii?Q?W93EA7RM9fewTqgSiJFpcbz7P7Av/06Ir/wPuNFMMhyt0QM19IFsrkQl1vGs?=
 =?us-ascii?Q?lB2uIt0S7jSbUCAXRAEYOaRZCUJmpFEjKiNHlQY+m150uEQgYGBBDpmKMYY5?=
 =?us-ascii?Q?D7g4FCjpamWjJwzDGp+MHw+pPijDCi2C5WvHMUUj4IMujRwvkmsQ636v8jgT?=
 =?us-ascii?Q?DWykdJNv4+ERDKE1kSCyl8SKZz0hFl8xMcoxe+MQ/HByR5ex7l4zbA9YD8NO?=
 =?us-ascii?Q?ic+XulCEVLVr7a9f/UIcKRfBgK2K9n6sk9A7fEKi78pI9k8QEo9vwIxBmuPc?=
 =?us-ascii?Q?xu4iY3eNP5nkLs+6F8oVRS43i6GhurvxNb3/THb1NiC9d9xOtdreKAqIH5QO?=
 =?us-ascii?Q?m2GQ4FbXd2MON320Sw4rR398eEcuy4izzDWCc/vhDmmLcbnR3sbbRi8ScRJJ?=
 =?us-ascii?Q?fut78qHQBl/9fPBMQ5wFRp829ZMg5B048w94Z4wTDNoU2PPYMJJ4aBd+Pgni?=
 =?us-ascii?Q?RQx5rsbKkGITRB3bYSPm2VM5YetIiHreTZWDaCtp0SyknPsB7u5vW2aeHAIo?=
 =?us-ascii?Q?fqLCe+S8s7yNSGbzy2Y+Z8nc4PLMEK4GWaRCh26QNe6YJ5sweoDI6HyttSxQ?=
 =?us-ascii?Q?zcsRc4S2dHjdZipBxhV4gyRMLYrI6mHaqPcZnXi8d686Zo0ObH0h5/MDehy3?=
 =?us-ascii?Q?Sczwj3yw6cqYX2b7wki81XZE8NMXRFD6vO6OCbk1m9wi7m1RdV3gkxUf8CkS?=
 =?us-ascii?Q?YGMspEMSbjgSNW4Dj1IrwnageRZKQfkBu8AcEVm8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9ea4ec-20eb-44c5-7fab-08dde4b21614
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5128.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:06:08.4126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuVli2u5JhywFayXUnEO5rykTYBLbtG+J6tIWAxPCJ7YzHuz5hItrmkmEefp7ArRZcCO86gcIOTCKaBEDGpbEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6981

Change 'ret' from u32 to int in alloc_qpn() to store -EINVAL, and remove
the 'bail' label as it simply returns 'ret'.

Storing negative error codes in an u32 causes no runtime issues, but it's
ugly as pants,  Change 'ret' from u32 to int type - this change has no
runtime impact.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/infiniband/sw/rdmavt/qp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index e825e2ef7966..134a79eecfcb 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -492,7 +492,7 @@ static int alloc_qpn(struct rvt_dev_info *rdi, struct rvt_qpn_table *qpt,
 {
 	u32 i, offset, max_scan, qpn;
 	struct rvt_qpn_map *map;
-	u32 ret;
+	int ret;
 	u32 max_qpn = exclude_prefix == RVT_AIP_QP_PREFIX ?
 		RVT_AIP_QPN_MAX : RVT_QPN_MAX;
 
@@ -510,7 +510,8 @@ static int alloc_qpn(struct rvt_dev_info *rdi, struct rvt_qpn_table *qpt,
 		else
 			qpt->flags |= n;
 		spin_unlock(&qpt->lock);
-		goto bail;
+
+		return ret;
 	}
 
 	qpn = qpt->last + qpt->incr;
@@ -530,7 +531,8 @@ static int alloc_qpn(struct rvt_dev_info *rdi, struct rvt_qpn_table *qpt,
 			if (!test_and_set_bit(offset, map->page)) {
 				qpt->last = qpn;
 				ret = qpn;
-				goto bail;
+
+				return ret;
 			}
 			offset += qpt->incr;
 			/*
@@ -565,10 +567,7 @@ static int alloc_qpn(struct rvt_dev_info *rdi, struct rvt_qpn_table *qpt,
 		qpn = mk_qpn(qpt, map, offset);
 	}
 
-	ret = -ENOMEM;
-
-bail:
-	return ret;
+	return -ENOMEM;
 }
 
 /**
-- 
2.34.1


