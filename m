Return-Path: <linux-rdma+bounces-21726-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YgjtCq/UIGol8QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21726-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:28:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0287463C313
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:28:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="YwtB/O9H";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21726-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21726-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F4E43021C9A
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 01:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F1825B098;
	Thu,  4 Jun 2026 01:28:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD7B26A08A
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 01:28:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536486; cv=fail; b=vDb0nMeRBN59IkrLNn74P5ZVWkXbQij9MhBOB3w+hw9CXgk15jTnQ5b9qAN5NJphkh9x1t6tXys5s/zHTrFgJxZ2PPb7oS0zw1Xtv6ovrhWwVYEUFJfyJLXTaGU//YH/sOIRn6lP3nsyxLhDN7STcNapdUmApVShlMSNg5d0mF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536486; c=relaxed/simple;
	bh=18wXYNYLYZRGXuHxBbETSIcE9uPEQ/XMwMHIriihvfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gD4rp4yAshX5uZ/294mhXhiZbj1akc4bHpwMt3mYX2+5rTcoEQXAtE9z7krYPlhe+Hm3q5HEArz7da5iYUMWnV6lE7Fud3YUi4c0yhMvmqMuwWtn3nYlYM+u6Hm903ctqFCJrFKBicXHO2qOEIKkWVVf7UQN0vAt9z3COLwK8QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YwtB/O9H; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpsqcSS+25qbhwvnzWFOnqwvALZnVKiuKFqnUCzuXloC1mEy6dB96O9lfoMJQIQL6sigGD9KxU9d4D5IBsUMLORgedlscMHq/fJ34Aq7j689lNyjey82Ts2j+XQGmAVtyItMkjn1BCj8PUChS7b5dnbVZUb78zgIZwrWDPo3s9/NBhxTQVQtKAhT1/KsY2QA8gc63bzHD09GJAyKh7RaLnemMCyRSOLBQgtV7G8x/CapG97v8nn5/mK3WFZd1M4dOU8rvSE7ybD3T28kIu62OeI5W4TCVJJ6xG5hoAJ/8u9sXkn/ZY/3UK6rB/cFUSdtBad1XmLa+GRx/Ko4oM7qtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6FZAP8rWY3QJogBB2ljZlTA+sJosAhCyzGGPUVItSY=;
 b=Ct9yX3GqqLE5C5mqyzVefGMJeGhR+sy8NUUf50kO/VxXpeuVlfOi/Tjw1J+uKo9pswyOTTcPKPK5wjFjW8FDVbFiEjhQ7+93lQN6cRkEZxMzOfu8N1aH/9gKnc5xwioqwm6Ocb2MzkIK4Q1PA62l++ux1HR1bjrbHnkX/YJ6AkeyMvYApMO9AcgbBzgsb0uqSb48yhV2LFBfiiJy15vTGb7n8Q+/1qtL2++JBvbDzE3Hflg/VVOXVF4//bO5VmZJACNLM5tmdzYpGZAosxCm1pP3NMJuCklB+GvHO8fPemL9rT8966FBxbKBFuMNL+z4KdEVzXYy370OJ6EB7k24qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6FZAP8rWY3QJogBB2ljZlTA+sJosAhCyzGGPUVItSY=;
 b=YwtB/O9HxKACkZnD5MdhvE5f0OC4bWYFTSBm/8sosI41g8TDl3KQRBup44Gtnd7iczCvjw1zp5jU+aJt22WbGgsO6HFJsn427Vicbi0tGuBFo4z7sizBalGud+TpwTxO0NjP+zr6OpvdCpnqKyzdvU6LBZRt0q8G7RGvqcAAxgGfL53WzcWXakF8XQikAm6f27c0lEM1G9xWmNcGuitDtcqOZ7jKNKH2m9SEt2qx4kmYwUaoUWKqcQpIRIXIhq1KMwmVhzFU9Z5haL4b6itf4dokQV5BfHqRWUVMjRJhDih+ec2OV7an+tSGA5l9CZx1VK+i+JORhP2z84fVTyhYOQ==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:27:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 01:27:55 +0000
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
Subject: [PATCH 05/10] IB/mlx5: Remove unused mkc bits in mlx5r_umr_update_mr_page_shift()
Date: Wed,  3 Jun 2026 22:27:44 -0300
Message-ID: <5-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
In-Reply-To: <0-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0352.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f282f4a-06a0-4cd3-c7ab-08dec1d87f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Bk0RXakED3e7iagbyZ39TnA7mIauqXvJx0DSPUR9f2ZIjOiLBB6vyInQYjS0hClgt3AeRI0B4zFU8SeExXfAj/0IWPXaE/04Go5Hm5y61Yd9iFBWqjosCfM2xks+36ENX6H3w8Nb7PaOV+mR9YrMZXk78xYAMXxDDSL5JIGu3QB0zdiGVv+cMuJNIzIzb2e9+yo9R/+KVUIb27SQo/MN+0qMrk1uspgLr1M1JGBzyNSv1wYc9YTPVXofsbzmhQvUMumCEiujU284A4eHZUV5ASv8rlFQ7G+IrwOJnkp4UZruUZmbnMRw8M37JcToMtYvP7hrMRm7MIgZ+jUIgxTwT97CfdML6oBckUPc9+rk5umipHEQshYBhMu1CA1K5qUnYSPPXUzWwqCbm1VC/o/WB4k3mTjmgoKw90pSqredYagUKncWM4Zn0gxInra5gKbaHJD77yJmeQs1aJuTHh1XhdBl69dq+Xb/qPYdcSOgkJ8eIJbbPhf8JidqhSOY4RjMAqDyIF15TtwYjkzbuzeGrl+hdcu39z2WfX1tVq1w8d1JTTJmU8Aw2T2leG1JLXWnKjgpRGUKZprOKNTUay/8BL4hloCX0BqPgiQAyn9XAzqdBG6A8swl9bOkEwZlNVxQGkDaCNUnizcgBGQVZ+IiBTLygIC/Pb5AL/Ghpd1iejLUocCIaPod3B4cpZePSLSa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5xa4HtJNaUgtHonKV36bCF7N4n1LbZoyNxaBep8O/s1XuaCQruqlNudKa+Jg?=
 =?us-ascii?Q?/unV/PDc/Q0uLWXgtZ3K8RVV7dUU5cNPmczStr3SQIwnoGgR6vTwJ6X/Y2uk?=
 =?us-ascii?Q?bkX58W/tK8gCaaYVAxsa4kieK43xw8wnrBVqpl+/cm5vExwpd1IE1+7yXINE?=
 =?us-ascii?Q?Pd3gwz05TvcIwb5e8u/sWZtTBHYeXK1A44bupipbWOL5EliFCbpyhmPrt4Rp?=
 =?us-ascii?Q?7g14RnROiGPHtrV4kwiPbkVxWTjU7AZIvJAg8nMAT9glonfoocuCwcH4/fLY?=
 =?us-ascii?Q?TB3kbTWwoV1aXGELY89LJOszYmSIdUmbRtJ/ko6Pap3uho/oKg9+MwOPW+Wm?=
 =?us-ascii?Q?RLrZBGJU7UV1N5nXBDZFOwvAYhDmDKRLyV6oFexPL0qOfAg27v118wN4bIGT?=
 =?us-ascii?Q?0jYTg/FllVI3r4FWiCRaHJQp0iEhP9+kS+7yJPFb4yzjHamO2y2d5bL3cK7d?=
 =?us-ascii?Q?fYpf0QWKwOXSQXlE0vT6MDRPtXlEz8KjFMPsUHbcIatUTwxrBK5YLZP1n7PL?=
 =?us-ascii?Q?yjcndCszcBDtAAVV6EEj1ud5niET6HLLkeSUPtuQfLjxSRjjFkR5NBX3+GvH?=
 =?us-ascii?Q?GTcnjYwQt28F12gY0L0LqUWevzXfoNDReXdNafdd2NOszREGzzSBXs/kSBjc?=
 =?us-ascii?Q?55UjWD72rZjiKDA31L7Xx4czo2NDeF/J8Brr2CnwcjOiaAYywxPq8oA5uPc2?=
 =?us-ascii?Q?XWRoqO+qRANHvLH2bSdi82zlsg++jtpFodOFr4mtcqK/yfyAprGXdcZN0gWX?=
 =?us-ascii?Q?RhEts+7DcP8OgttdoOmq2A6E6WN5QcYgDWO9GFyffurV5P/EuH7VrKJ9/GiE?=
 =?us-ascii?Q?gnxmPKREQEWOeFLyz6scm9QZAX9QPqYSwZc50MQkbY35HTF4boGOcp4+KChb?=
 =?us-ascii?Q?gkOmEDf8rqyU8UqwgsW05KCv2wowVU9gsDrypjbGhQPK84BfIKTht1ODalQj?=
 =?us-ascii?Q?6TxiOjwPJgDiNe6mFQpd7x8fxakgSa5+weiuJORFr1KMk0diV8DSeqv55Ubc?=
 =?us-ascii?Q?ULYtRiGqYQh/pPi8uTZhMsiirH9xxHSoclobjFP7hDhA+J82tQHjFzAfpebf?=
 =?us-ascii?Q?h/Wo1ofT+RLUGdPEZ8KsnYh+Yla8OG4jDHKuCYJSPS8/OXaBBSonuWlwYg3j?=
 =?us-ascii?Q?12OghrUXnvszmI5E9u4eAuwIOfSl5Whbddgqeh5zN4izWG5q60+1MV28sDgh?=
 =?us-ascii?Q?XAlB9RLcGCj4IWbYghV6JZSg4En22mwt1W5j4cUgLDpmKrCUo32n6VF3GV7h?=
 =?us-ascii?Q?B9OrefP1TDYgA5Q9Iz8v7NcodYwtuovZkkm/ZhPrZ8nqa013dWE820KbTymM?=
 =?us-ascii?Q?HiO2xlDIAH6fE5kftJg/ZQ+fBpWZcWQiqBUTfwj0EO+d9iQTuACJjPSepZ2O?=
 =?us-ascii?Q?bCU2ZVi2FgdcLtYWWJjxD9gbFnvOpYkROkfE5c82tqJM+LbizIpFEajMjybN?=
 =?us-ascii?Q?vJD5HllNqJsaYkSvRwXyXrFgh0amShi9wxxi6/IkyBCTnVkplwCufS/MLdZw?=
 =?us-ascii?Q?HsR9eBBmoSgyEDl1B1/8ixiG343iiKvxa09obO06Ju5+99PeunwM5Tb9L4Pm?=
 =?us-ascii?Q?Ik53mZKvZpZtYwZmAMncMPj3wS4YhQoTKDpS5zKVYJ9/TtBdg/q91BNcmxJV?=
 =?us-ascii?Q?Eht23omWlSL/1F6sXCywWh8tSc0jmNR9xv8BBnarH2euOuc+55gIewOZdP8H?=
 =?us-ascii?Q?PMN8c7bz1xTqwXePzpo/S6XxEW9FWLojly19Gk3pLXwrYScY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f282f4a-06a0-4cd3-c7ab-08dec1d87f92
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:27:53.3001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bk35BLA12RGXGMZB1C06J6I03CVZVcRgiIuXmGGXlio/SADiOD6RIMGodHykFMe0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21726-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0287463C313

The HW only processes mkc fields selected by mkey_mask.
pd, qpn and mkey_7_0 are never selected so they can be left as zero.

This removes a racy read of mr->pd.

Fixes: e73242aa14d2 ("RDMA/mlx5: Optimize DMABUF mkey page size")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/umr.c | 16 +++-------------
 drivers/infiniband/hw/mlx5/umr.h |  3 +--
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index f2139474be3751..062a47d0c991b7 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -937,8 +937,7 @@ int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
  * pinned and the HW can switch from 4K to huge-page alignment).
  */
 int mlx5r_umr_update_mr_page_shift(struct mlx5_ib_mr *mr,
-				   unsigned int page_shift,
-				   bool dd)
+				   unsigned int page_shift)
 {
 	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
 	struct mlx5r_umr_wqe wqe = {};
@@ -953,16 +952,8 @@ int mlx5r_umr_update_mr_page_shift(struct mlx5_ib_mr *mr,
 	/* Fill mkey segment with the new page size, keep the rest unchanged */
 	MLX5_SET(mkc, &wqe.mkey_seg, log_page_size, page_shift);
 
-	if (dd)
-		MLX5_SET(mkc, &wqe.mkey_seg, pd, dev->ddr.pdn);
-	else
-		MLX5_SET(mkc, &wqe.mkey_seg, pd, to_mpd(mr->ibmr.pd)->pdn);
-
 	MLX5_SET64(mkc, &wqe.mkey_seg, start_addr, mr->ibmr.iova);
 	MLX5_SET64(mkc, &wqe.mkey_seg, len, mr->ibmr.length);
-	MLX5_SET(mkc, &wqe.mkey_seg, qpn, 0xffffff);
-	MLX5_SET(mkc, &wqe.mkey_seg, mkey_7_0,
-		 mlx5_mkey_variant(mr->mmkey.key));
 
 	err = mlx5r_umr_post_send_wait(dev, mr->mmkey.key, &wqe, false);
 	if (!err)
@@ -1049,7 +1040,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
 	 * non-present.
 	 */
 	if (*nblocks) {
-		err = mlx5r_umr_update_mr_page_shift(mr, max_page_shift, dd);
+		err = mlx5r_umr_update_mr_page_shift(mr, max_page_shift);
 		if (err) {
 			mr->page_shift = old_page_shift;
 			return err;
@@ -1114,8 +1105,7 @@ int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags,
 			goto err;
 	}
 
-	err = mlx5r_umr_update_mr_page_shift(mr, mr->page_shift,
-					     mr->data_direct);
+	err = mlx5r_umr_update_mr_page_shift(mr, mr->page_shift);
 	if (err)
 		goto err;
 	err = _mlx5r_dmabuf_umr_update_pas(mr, xlt_flags, 0, zapped_blocks,
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
index 7eeaf6a94c9743..59809d4d7d7297 100644
--- a/drivers/infiniband/hw/mlx5/umr.h
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -106,8 +106,7 @@ int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags);
 int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 			 int page_shift, int flags);
 int mlx5r_umr_update_mr_page_shift(struct mlx5_ib_mr *mr,
-				   unsigned int page_shift,
-				   bool dd);
+				   unsigned int page_shift);
 int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags,
 				 unsigned int page_shift);
 
-- 
2.43.0


