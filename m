Return-Path: <linux-rdma+bounces-3649-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823B5927B3B
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 18:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD821F23FA6
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 16:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50F61B3744;
	Thu,  4 Jul 2024 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="IMtTti/Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2103.outbound.protection.outlook.com [40.107.223.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A51B29C2;
	Thu,  4 Jul 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111075; cv=fail; b=HsvTVM+D+Hw7lHBXxBGH7+97G8VXqS3cNBp8CKKzTiPOOfUYqsBN9zdIhNPuf56q8kccEntHjSeqzOdLbRaUWMu/bO6lrxewCVc+VguDaI7Vp+CQEul4M1UQ30nwghfH1HIr3XBHSKcYwDn5dslWCVDKGu7d31f+1sqNeLv4Qoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111075; c=relaxed/simple;
	bh=GE06KucFSBUQ6DohU7LR5l3v/5cc7brxM/fx2G01KVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQUTozeG27Wr9OuhbREdzNd1WLi975OxB4k00bf/Nm2lZwYkzGV95MG1GcZobM6HkAO8ATu0Sd+MVARpU5Z8YlKKOf+NfNhPomJxWD7xFHBXi9eVVZ6EeSlxBUZyCTjF4QqAryGKMEo42HWZWZR1pVkOuwzyxUm+1r/Mc8NPVj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=IMtTti/Y; arc=fail smtp.client-ip=40.107.223.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeH3sL8HcCzwy3oG7rxLA323cVqweH1WXvU26nrl0QhF8VPEZI/kEDqbgwYEsoPKXDX9m/VECYUSXXHRq3E7tByyYvUuOrdh/BvfaQikq5nmzKiLxxYfdJc1utOjMG3fxkGvwWvnq4PzslIi2dq5lg8aOQhss7yBAJdkv0fI9jWmDOVgWNI8Q+5pUkDBUSosQg26hNl7yOt7fZtEnXVuH+dju2r01Al1ioNwuBaR3Hhz0e/yNdBGA2l2jcN74iIJxAWynZzreIQK+mOeZrwnOfCuJDe15EbuaqgEyfqw+nPLSk+VC0KT6jzPjL//HH8ASkoVeVZ9rOrihtUGcbOj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9xpThQSwDqFuSjjUacCMlYFqVz7Hv5d66nL0tsLOEM=;
 b=UMSfxblBFOQNczrUnTON/iLCbVawFCTYInaqNR311rTD07nICPqFBEPUnwgI9q11vt1Urqq//wf6L1QOSW4qQ5z7icpVi8uEfgexCal1y9OJxpXgL6uzUpIzyv9U6H36I2SwocIeWqRZP+ykTD+Y+ZxZPLL6zgdjNbOs4+7sQWRg78vDyvSgQbo2EEFTH17lvSBm4jMXGLYvrtUc164xjP7n73ruL4jHTRtWyMwzlU+hznaYt0jkHSgxdhT8+gJf5dR88pTyPlSdPwpUuG8SJCP4jY8iKudrLFkAX+cylN8JzNGDGR+NC8B5J2nio5pRXeT8aSN8mXzYNUxa0tZPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9xpThQSwDqFuSjjUacCMlYFqVz7Hv5d66nL0tsLOEM=;
 b=IMtTti/Y+8cKQwOWumy3CbRSLFo1b1VI3gUFVdazkZDkm3+8ALaFrLDTepkRvrPA21XYiOYmq8ejcdpmophHyRuSGW3HNJVcoM9maaN19FMbykLErto+dqauWwsw+sVS+XTztD3Waf5f74UMFh3AIJkT9ts+BopNC66riiX43ZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by CH0PR19MB7850.namprd19.prod.outlook.com (2603:10b6:610:189::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Thu, 4 Jul
 2024 16:37:50 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%5]) with mapi id 15.20.7741.029; Thu, 4 Jul 2024
 16:37:50 +0000
From: Martin Oliveira <martin.oliveira@eideticom.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rdma@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>
Subject: [PATCH v3 1/3] kernfs: remove page_mkwrite() from vm_operations_struct
Date: Thu,  4 Jul 2024 10:37:22 -0600
Message-Id: <20240704163724.2462161-2-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704163724.2462161-1-martin.oliveira@eideticom.com>
References: <20240704163724.2462161-1-martin.oliveira@eideticom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:303:b6::23) To MW3PR19MB4250.namprd19.prod.outlook.com
 (2603:10b6:303:46::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR19MB4250:EE_|CH0PR19MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1941cb-f20c-4244-6de9-08dc9c47a4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9rAnHPmSAkso4hCx28EN/Hx1gNvOBuM0trrl5Y+AK7ldriGdsa2ZZ0gh5efh?=
 =?us-ascii?Q?YhYRX663DSrSinDajt0dtykDd+l6wgbx0gLduq0I01Ye3kRYmCnVtMyA7qFa?=
 =?us-ascii?Q?zUVcmSbUk3bauF4/KwT7VROpANM3/HXLjoAYKep/4Q09TkIG6oawpCcKEtAG?=
 =?us-ascii?Q?U5GJtRLgBa5LCLdfDCq51tsLDmL0CfNRsWLAGlDRHMQPLT5u3uH3PEt8QJTF?=
 =?us-ascii?Q?6HUHQymqssd47dkMAv+iQxzXrUKtpfT2fAo4XJXhT59BCTXt3YUpW6zuLRQ0?=
 =?us-ascii?Q?YpxKnQdjKwcURXyCA0wL9OlnjlukfuOimmd4kUNraLYNAJwqkm8vIwm5MGvk?=
 =?us-ascii?Q?n9diX29QPdI5aJ3/W04oliHTkyLJow/cAtWnBFVl68158ZJS4o/Vokr3MQkJ?=
 =?us-ascii?Q?VEPnWE6Okkr3ntmAO4GEwBWhpjY+M4HAFip14vBq+397q/PPnheQ+vajcroo?=
 =?us-ascii?Q?1pC0W6by5AJw5u8mOC6zRI9YIShDBmsZm5M/kPxl9xfJ6e/uGE3aIOCi8S3Q?=
 =?us-ascii?Q?mxp+K2EDP1bwnlBY8znuut/UMOoF8f6FjbCHWQozLHcqs5REVrsZiVRs2zuU?=
 =?us-ascii?Q?yYolWdDn4sBLT2y1OUyt6PmYDK5+wMyKikwhRz0rQEp1+5MXoq48DpuQCI+/?=
 =?us-ascii?Q?nOZJNzhefxqT1lgCjMEDzQ+c1JSCziFZsIL9joLiO1IdQj+wSIzHi0mlU7Nl?=
 =?us-ascii?Q?qMhSaGQj0MjuWQ9wKhOR4Xl9SXToD1a3pZwIRlr1YN5xKQjBERFT5uidZ7LF?=
 =?us-ascii?Q?G3PU6gAIVaXdFX2HM//saJ1Mgy+vzgBV5WBKacqsTg45O1gWw5qt/PznESQc?=
 =?us-ascii?Q?m9s+rvVAylf9wLkRJBbfy1JJ4m7K/6oRilJovNdlMUfZV+sOcJaV8RPK2ll+?=
 =?us-ascii?Q?fdyA8rTQE3a6HZpq+1a6ZLpueXYzsZQRPEZtbQNGLQHHI4pFpDOoJWyckmsk?=
 =?us-ascii?Q?/KZzwuU/dMLooL+1WdsJ/HZSr6eUjYpalb7ZfAYyflDgNjK9xwyW0C2e45T2?=
 =?us-ascii?Q?f8xopdvB6QfFKuZzBVScHIJeeAkpNpX6qAQqLcDVQ6cNA+365J3Xn9MRiicd?=
 =?us-ascii?Q?5OLUGkcp+HK9HVt9svVt/OkxN2UJNC7jGuxgIPW4SixoXM4UxfNd4K/HA+Py?=
 =?us-ascii?Q?eQrKLRmrGjl4SnOlQHteD+vcbcb9H3HmS2eUSDfyPhxCCc2xg/yhd7/RBeM1?=
 =?us-ascii?Q?4LGQViKqPTKGpjzr3Iq7LQnHa/QENCVTYUcTLIxTO5rN7piQJuTbnyXfFAI/?=
 =?us-ascii?Q?pTcE4SP/kgwtsCdwPIlZIixUoxzviOo53hEXDspxhgOAdDl8kKvoSYSTA0K+?=
 =?us-ascii?Q?SO2TR/PbCmlg5jha6UHj3D5jHqz8ozaqRyLC9mPmLi5NJ13qyfOOAAj2QX/A?=
 =?us-ascii?Q?4c8inQh/RD/KOGm0p99TAZvEQBBjD9KKD/iN1ZFgbW2TxtZu2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WbIwduU3K4nMudLaU7AXM37nBdEo1iSfo74SW9DvXzr6djZS6tXi5b8ddwxc?=
 =?us-ascii?Q?hfhnvqZ1KZIcjzKbmhYQ9UwPf8aGeSWm/f7ap1BaXrc49NUjPl7DbbFwIO81?=
 =?us-ascii?Q?NmQe+++XX74IpRyI8mBE+jLgjgM99oJ+7cFj6p/aeVUIifWfPxbsOQnFyP4/?=
 =?us-ascii?Q?+jihjOiI4ziLVYv1eLk18Ee8grgGnET1zlzvrUcMTPnOp48TLNANFE3DlLpj?=
 =?us-ascii?Q?pdPcA1zEgv8aNsHZILNIw758dLX33yd3NAcIzk4mgUvy77w9NJnKLpV/MLqb?=
 =?us-ascii?Q?bCO1cCPhG/Urbte/yVOL7iQn17GiICBseukY/+zeygk8dOVEohSYVUAit3Lr?=
 =?us-ascii?Q?aBeyfeLFhnnS3hyNeKwpMA6VhARkFznL/8icUXJ0qjTUExdoCLyPTWTyCTdI?=
 =?us-ascii?Q?0o8EgvypeuIZ9JzN9BFKDtyFO1v17pbFEzYrQ7y0M0VyPC7mUOmALKE5FQaz?=
 =?us-ascii?Q?fEpeD+tHOUT0lHGL2W7UcEp30r46wQaG+9W100be90MjA35uIUzj9sCqRZbH?=
 =?us-ascii?Q?9RONsJ6TtCGHq031ZmTIiTrnYZnHCjXLcy/kbZcE6LFVyMXc7cePS70uxowQ?=
 =?us-ascii?Q?apPwF66s23FTG9NqM5Pfy6xBWuMCxauFN0f9zzTFnzkoUHdJsWhGP9UwW992?=
 =?us-ascii?Q?SarFh6ydXjnuD1t0PxDcjGIqyLewjfKETYKhCEOANm6eMaH4Kj7chOu11Pj1?=
 =?us-ascii?Q?RBqoqExs4qQSkZm12fRMGD8Ypek6KtzHO5ye7rANSkT9I8hWDTGix19B1f1L?=
 =?us-ascii?Q?92f0BxkIYfuzS7RxMN+o/LIY5wHaFtyNGYlhcbtI/0rBDQZz55GnVr0nvtcI?=
 =?us-ascii?Q?XdNbrBl2W14dg/uUulZ9xo7zrKQiNBoqvZHdrMlZVetolNcflefwQOkapsYe?=
 =?us-ascii?Q?XKAi0ojvekyQbic86YoYEGIv5Q8haGkm5OLVMbBwihtEcSnJth2x4XiWo2aM?=
 =?us-ascii?Q?NQJT2CyAg19aK7Cjka86hApVCGVdftt+8+55EoszozTd9LE4hJ02sVXviyyX?=
 =?us-ascii?Q?6rB1MuF8iqvlzbaCp5cTGVV3xOIIx4Mbka16ObXLUlK6ESmAJRdqD1h+0UGI?=
 =?us-ascii?Q?1qvcMkzDQ8rT4oUD+z3riKycsG2srE//qhzi90NpOU3hhK+h5WtgYk1qElLL?=
 =?us-ascii?Q?klO40qvo5jivy9D1wtlGHlUulCJMQoYPxcGbvvvJh5m9Fc+3jLdeaRltj/lE?=
 =?us-ascii?Q?C/M4u2P+qetDLHqicgFTSj59nn1AkPRCBuLgIHIjeAKoIoxmQQe7hfvh6iD6?=
 =?us-ascii?Q?FJLucBZ5+knOy/kQ/6mIrNQ6zWTsnUOOlqR9ASHEsOJu1Fp4kuc0fBAt08JO?=
 =?us-ascii?Q?kIYARaDYcAQus9KdhZRBiF87442MYTf1RCOKRJVwh2a2kSxUwDFj3cbxzqc1?=
 =?us-ascii?Q?LGrnYlsLvmHmaAzEt06t7xk066K5g/xjY1cmUnnAlHSYxq0ASRb7nY9jHQSU?=
 =?us-ascii?Q?p6SA9efhB4t03O0pGFTrXZPJGksxzwFatVOB6ipMyzySMsaEqTrtVxoT628N?=
 =?us-ascii?Q?ZjpvdRaO1WzsUOUXB/mxr8IXWwCjvmwgbm/7Wstm/ay5sG7sZU4faxEgwXM8?=
 =?us-ascii?Q?zr7GnZz4kvOU/ozjAtRHxe5EgnVlQJLBUO344MsLYBgXScNy/xBHoAwS3fzm?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1941cb-f20c-4244-6de9-08dc9c47a4e8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 16:37:50.4367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBHSmtUXiIhMZbKA7esjKytTNhJro+xd4W9ZeP8ibduQCAZ0x/iXadR+5O+YBGgqHKQt6iMmYjbeoMqhJuBAzhw95y3+iv/hMmRFgyCSJ8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR19MB7850

The .page_mkwrite operator of kernfs just calls file_update_time().
This is the same behaviour that the fault code does if .page_mkwrite is
not set.

Furthermore, having the page_mkwrite() operator causes
writable_file_mapping_allowed() to fail due to
vma_needs_dirty_tracking() on the gup flow, which is a pre-requisite for
enabling P2PDMA over RDMA.

There are no users of .page_mkwrite and no known valid use cases, so
just remove the .page_mkwrite from kernfs_ops and WARN_ON() if an mmap()
implementation sets .page_mkwrite.

Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
---
 fs/kernfs/file.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8502ef68459b..90603664de7f 100644
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
 
@@ -482,6 +459,8 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma->vm_ops && vma->vm_ops->close)
 		goto out_put;
 
+	WARN_ON(vma->vm_ops && vma->vm_ops->page_mkwrite);
+
 	rc = 0;
 	if (!of->mmapped) {
 		of->mmapped = true;
-- 
2.34.1


