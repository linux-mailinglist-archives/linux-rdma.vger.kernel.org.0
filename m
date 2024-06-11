Return-Path: <linux-rdma+bounces-3067-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F22904390
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 20:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20D928563B
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 18:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C515218C;
	Tue, 11 Jun 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="sKhC/y/y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2103.outbound.protection.outlook.com [40.107.94.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90814F132;
	Tue, 11 Jun 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130488; cv=fail; b=YkopSyTHqkkcdA2wMjBKxL5XIUYe3VWgoQ8snj72CCsTfRYRWNaa6bwi0rnAVcuYCaD1Sta5Nb4XvG65Zgp0aCwkEjMmSDIPbZelFqnSrSIvVadCQ/Fatb0hkWOxemWdN58Lo8jwxOkJhHsC7Bl5JL1iGdiA+cmJsDiLrLDHWoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130488; c=relaxed/simple;
	bh=WoNHH5duUhzgG0Stfsj480woqqSsl+cFqhXTFMZm/5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nkwNwOwsmIfiFPrOKkL54hrj0d309YlOhz4aPcMCyjSqENKOlbpQrrx6Wm+Xt3Ukq3/jTe/lwlBFYHm6mcy3Wninz/Ttyh+SMEu4wJYFaU+fzRzrN7jkxHhbHvOrotpkwtQ6bjdU1T+9/t6LnTZ8z7+v+VpvxBkfd2MsqISv5oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=sKhC/y/y; arc=fail smtp.client-ip=40.107.94.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEM2l2idObSV7aTl8dFjanVABjMsQRPxvuM0XM3oLFRp80eZSood5FAABcZ+BuTNcIugdVlj5tTl0hPEr+bUIOp6s2+fF8sxFKsKcFnLYKHscOlPcHFVM8LUfHuP6pSVaumfu7mbiAGzHe4laqQBA22ZGOqgzcw7QEM/+HivMy5yVZ3K9m15Xer6eeZtqhRg9E6BoQwDSRSJ52HSRCojr49G8sWahCFaku7VgH17QVvu+eRRdeg7E2IK+L7rxh/f5jvV3iu7s/AvPjEwUKiET0pmlCINRVjPXbzaHHZPYIIHyMrQv9HjSV2g4AH4LQfyHzIbHgegsxfDDs57dF8mGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egpQP0BDXYyrYjOSywdL1sJt7M8DqRDf4NFqGyAHqgw=;
 b=fOrHqNHaP6h1juK8bd8cG3ceOGDwScuDnp0x2MhCdssxN69+fBViqrQ7EbT/fJM1Z6RVna6P2KkAv68omX2iy4qtDiJ7frsbtZO8dvgGtBsCYHOPyX356ygfyi+zZY4UZxK/MzDVHCZFla7HCBaoCpB74vn5wQHZ79Qz8SObZT1WOUuwFJF5rx4x4pWgtrnjipR7AF0fJCv/+tVwCAGuvw+WEzWGq5CREelEU1npIcR03aMSuxPfX74b5QLijDHzboCe+Y3ztCd4d+OvkFWOxVlzQtbXLHzdESU7BM1ioL39crrKXcrpUoPb83D4iwDm81I1qiA7p1Z2Zobt3nto3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egpQP0BDXYyrYjOSywdL1sJt7M8DqRDf4NFqGyAHqgw=;
 b=sKhC/y/yl1oMmZVZbF0L6LFSZstZS3C3NsRYboja29e7YYprCvucDqv7SeyJk2GZAJ4XLeZTB45P9pWU/i1e34kF3AyeapLusl3gq8G8mRUCGuPUiKi1lhnpG7E5Q9L5J19IM3Xf0fAKTnVj9cWP+Ns85qApwKXLc3qL77YawdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by BL1PR19MB6105.namprd19.prod.outlook.com (2603:10b6:208:39c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 18:27:59 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%6]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 18:27:59 +0000
From: Martin Oliveira <martin.oliveira@eideticom.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Artemy Kovalyov <artemyko@nvidia.com>
Subject: [PATCH v2 1/4] kernfs: remove page_mkwrite() from vm_operations_struct
Date: Tue, 11 Jun 2024 12:27:29 -0600
Message-ID: <20240611182732.360317-2-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611182732.360317-1-martin.oliveira@eideticom.com>
References: <20240611182732.360317-1-martin.oliveira@eideticom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:303:83::28) To MW3PR19MB4250.namprd19.prod.outlook.com
 (2603:10b6:303:46::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR19MB4250:EE_|BL1PR19MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a4b7ca-b8aa-44c5-03a7-08dc8a4438d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|7416006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YCJajgWDQyWZTP3DQAv+qUaoNx9aV5drFpQgU4ZY3CfIVtlB24s2JlsIyUBs?=
 =?us-ascii?Q?Ebnnj6EzeKJVXHSKqSU8CdbnGIPZvI/hdV+Nh8akksywCbjYxYrlXyxzEnJ2?=
 =?us-ascii?Q?JQgRSJBmx6lMbRYYTGHZbwuU9/1HcSdgSvnk5R82wF8kKpxZlgwz8iB8MYfd?=
 =?us-ascii?Q?nJfSWI2b52WFH6sm5JH99/zi42IKfZ7qhJjSrSHSe13dnNGmVJ48fdMb3syt?=
 =?us-ascii?Q?yTvRmqKN6o1RCoa8KvLcx8TUkJeaBlrxXFSwMqIEfb8JwwaSsDStdTLTd4RF?=
 =?us-ascii?Q?8G3WcTTLvZtIWPkRYB+1CSDiEnqijxvRDXfpl44SpxwzAEkRt61kVVQUJ5JF?=
 =?us-ascii?Q?/WHjJeVWOiGD3lNKzyStlb5DZJgQ0uEpanROcGWqaBvCcBHYkQEc53G+n2SR?=
 =?us-ascii?Q?Tlh2bmvH9dIMp7amTsx4a0oYazHcmW0r2NJ+8vQ+I18jtSMfSLDPkaYvkLli?=
 =?us-ascii?Q?uKHte4IklPi0/GOso+Bi1F0GEs0kzs5F0X5JlkQJiUkz+IVm6jJKbu2U4ThL?=
 =?us-ascii?Q?RTU7tEp3UsHWgJEEKHTRYFiNmbaL3f1RNv9xT/y+77t5ebVrfUKhWYvq5LMC?=
 =?us-ascii?Q?dp7wKCyijBFzSppZ1DxaxxDuXq7tY1ZXEQXkjfF+fgNBW0qtgUe/c+VbIxN4?=
 =?us-ascii?Q?g43zj8XLuVHLXBCRptYG5lVmLhselqhv75c4hB6k6h9rXGMf/nYxrY93Fmtj?=
 =?us-ascii?Q?M7rTvl5MFV2HnzY6p+Cjz/ZgZ+RTp67ykjPKNTD99t35lUYfXNtp4Zs/oGMO?=
 =?us-ascii?Q?pu3n9GrkKpQncgyd4MxySkZc7gC9YIXpJOWEpb3jjl1fcosT+JSkxL99kfwa?=
 =?us-ascii?Q?zKA4PI0TrB0ys0gYbsdXHMcFJmMC68TiEXUdZkTt5TBdmdVw1oR2qcfRlYQe?=
 =?us-ascii?Q?Nf6TpLZ5jB6e5f6yCGvm/gVQjDuACdgZ194+1B4nB7QmgoZSeGD3BhfVmfzP?=
 =?us-ascii?Q?Et2tJRGkLposZFxbnhfP4OlqkkOlnDHrtTZZo2FMQCOaq0pPCv5lK8HbhNQ5?=
 =?us-ascii?Q?48oRcuAYEPl8uwIc/3uUkqEhx5cmzTvqdZ+05x3GZm1cRHxbnqLS/lUlQ8Zi?=
 =?us-ascii?Q?8hDkSA8AMjl0drOM/cnxqy5Z74IvM0w7NfJ3dcIxgAsxOdszt17WbHbtc38t?=
 =?us-ascii?Q?rpVt91Bck6SdbQBO3RDD5e9bckPV8W09B3fllmcdOggqr4CeVH7ibtvsI9HZ?=
 =?us-ascii?Q?qmUc0lbwNzRQFjo4JGmnBLm5DpXi61eEbdLBLwIgd30oUMzLk24oAPkhTWLv?=
 =?us-ascii?Q?wpYVOEUVHW/UfBTPKH5PKk32FZa4TEBjfyBPbB1gIOT7UnZxH5/IMr0mnqcS?=
 =?us-ascii?Q?BtkkEF+uvEsGeG/pH89sZm0brTLaXESGyylCQ4YA1TNRRrC2WY/NubodmUaU?=
 =?us-ascii?Q?u8RmsWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(7416006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kxDb86xEIu6gBK+xTW9UQeEoACkzP+L5RU2ItoycO5rkrLoaHfJ/cFLdu2Pj?=
 =?us-ascii?Q?icQz05WM/T89bY2LA2xRxqOW3UpqLSQsAiQGyAd42IOBw1laCCDQW4ciLTLk?=
 =?us-ascii?Q?7qTbkjcVhIYVez9Fxcz99hE5WOlRVAtuJzA5sTjVVw+fPohjDdjMfAYu4X1D?=
 =?us-ascii?Q?RTN3QEpDIPgDl5IqvfueTccOvUusGWpOswrjAvjmM4Ot2RfCXKav6NzAFYxv?=
 =?us-ascii?Q?pYxmxCoyEBDWphH2zoF9kSLDGI3kfrnyq5bpxFWi1zouI0TE0cDqT/y5jrFb?=
 =?us-ascii?Q?Q3XH6+8zBoyQnSrRsH4v5XU+JA/aAlqUPY8dmJwqmfQuO4MVRcSt4aXwRVfu?=
 =?us-ascii?Q?0gKLrtBwDjUaFgbCN2/C/NvQUwwSosWB1sFuDYfjZwgOiGRaospBOF2zLV+2?=
 =?us-ascii?Q?Udzz4zp+KieGjKjwUj0/+S2uoQMUQJbsueMP7hYojdR6asS2hYaaB6EQppRD?=
 =?us-ascii?Q?HmHlm9cmQy0LzmAWkjKeCL66ndJT2u6RCwu521COrQobbYZp0wHlb3dzc5Do?=
 =?us-ascii?Q?MUo1K1HSz4WRdvdLXWra7J0rSLiI7VbM/y/k4Opf+47oGzLYD+2Db+eNeTKv?=
 =?us-ascii?Q?d0vF4De5RZPzRI39PRpmusIvqgrFSxI6BMf3vZALpIOeXWrsEz2yfCFlp3Dt?=
 =?us-ascii?Q?HvGQfH06dUrkV8HyvZnYfrwYNQlNhEKBi1BwbI+/rhXKULwddzCqyzFcm4bx?=
 =?us-ascii?Q?j5lktifhKzGK5RtXXFEPjG820E3Dv4Cxj3w/ldsWP6ACVbhu8pjI3N4LQ6Xl?=
 =?us-ascii?Q?EoMPA+4VcdBlcmOyt3K0w8Uu4ZmeP+zWKfGQGNoAOgrGwysnglbdiM0j71y3?=
 =?us-ascii?Q?u7FPe1rAJO35s0uOO+P97RGSCx1nNPn9/SIYNLKsMH2QOt1yVmfOkhY1fP8C?=
 =?us-ascii?Q?vA0XSRlkzzGoUC7Fhqt4/3g+/ec+mmWHicCXBx/KFKLTLliNQzE3tNDlLwhn?=
 =?us-ascii?Q?93p/mcffGoHrKrA9/J3+JXwiIuCKfWrD64ceBSbrIrM6fhstQatIDZJD9jL3?=
 =?us-ascii?Q?2HqV7lFGaQolxTN8QPEnAOk6eiC3x5kpkVFuX0grY9rEGtjmePSRlvVueSOV?=
 =?us-ascii?Q?4rs4h6YJkcHi2eq6o59yEdPp3BqOyoNCxD7JT0XqUgv+esO/xs+xkL4jZRX+?=
 =?us-ascii?Q?uVrHS6B9w70/pyOeP2CsXJHrW1J0qy28/tHmsZEDegE8gFGVgzKHpne0uWch?=
 =?us-ascii?Q?i7dl3Ssjkj5A556/enKcGIhZuOEQen/qZR+dppwpYDpJh5gDZ/TvnemYS6FX?=
 =?us-ascii?Q?Hnh9QJL6QUIByka59POHkJOS1/vkUiYiouH8rn/pUDzt1KpdD2pWOVQXMGEr?=
 =?us-ascii?Q?YLKGNfrOevFgCMCSx98Dfi8JaaNpxDv9euNIvJj37+8K7N6IIhQOhTXERdMc?=
 =?us-ascii?Q?To+MA6v9ut2AWRZSmZP8Iewjn9oP734mBwaa5DCZbG59G4FdOpoC/dRODA14?=
 =?us-ascii?Q?vrEI4o2VV/QsDvSTVlPIES+0sIV9U6KdMstpVBLWJGsxT+L8b0n92+CU6pxg?=
 =?us-ascii?Q?DE1gSaS71t7P56q5//JTIEVDUM/IRCmkM4DZVzkWpzgLrhlkDvxJe1VldeNS?=
 =?us-ascii?Q?R65DZPebILySktodKBI5WTDezb5b1VleFwfAogwNyTBHczQTt08WrqYumOi7?=
 =?us-ascii?Q?76YSqWX6+rctC42gpRw95gs=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a4b7ca-b8aa-44c5-03a7-08dc8a4438d5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:27:59.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnirLeYvlppbgpUVSXko/D+lRAutQq/Zf8NzJpbZTnDh4YryJzpTnYiR2icHv0LL3PvEftfMb4bt43wJUrXcu/fIvfDHXohJtP40drGiHXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB6105

The .page_mkwrite operator of kernfs just calls file_update_time().
This is the same behaviour that the fault code does if .page_mkwrite is
not set.

Furthermore, having the page_mkwrite() operator causes
writable_file_mapping_allowed() to fail due to
vma_needs_dirty_tracking() on the gup flow, which is a pre-requisite for
enabling P2PDMA over RDMA.

There are no users of .page_mkwrite and no known valid use cases, so
just remove the .page_mkwrite from kernfs_ops and return -EINVAL if an
mmap() implementation sets .page_mkwrite.

Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
---
 fs/kernfs/file.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8502ef68459b9..a198cb0718772 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -386,28 +386,6 @@ static vm_fault_t kernfs_vma_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-static vm_fault_t kernfs_vma_page_mkwrite(struct vm_fault *vmf)
-{
-	struct file *file = vmf->vma->vm_file;
-	struct kernfs_open_file *of = kernfs_of(file);
-	vm_fault_t ret;
-
-	if (!of->vm_ops)
-		return VM_FAULT_SIGBUS;
-
-	if (!kernfs_get_active(of->kn))
-		return VM_FAULT_SIGBUS;
-
-	ret = 0;
-	if (of->vm_ops->page_mkwrite)
-		ret = of->vm_ops->page_mkwrite(vmf);
-	else
-		file_update_time(file);
-
-	kernfs_put_active(of->kn);
-	return ret;
-}
-
 static int kernfs_vma_access(struct vm_area_struct *vma, unsigned long addr,
 			     void *buf, int len, int write)
 {
@@ -432,7 +410,6 @@ static int kernfs_vma_access(struct vm_area_struct *vma, unsigned long addr,
 static const struct vm_operations_struct kernfs_vm_ops = {
 	.open		= kernfs_vma_open,
 	.fault		= kernfs_vma_fault,
-	.page_mkwrite	= kernfs_vma_page_mkwrite,
 	.access		= kernfs_vma_access,
 };
 
@@ -482,6 +459,9 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma->vm_ops && vma->vm_ops->close)
 		goto out_put;
 
+	if (vma->vm_ops->page_mkwrite)
+		goto out_put;
+
 	rc = 0;
 	if (!of->mmapped) {
 		of->mmapped = true;
-- 
2.43.0


