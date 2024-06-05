Return-Path: <linux-rdma+bounces-2915-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 135008FD685
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 21:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F3C7B2524D
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 19:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9294E153819;
	Wed,  5 Jun 2024 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="wf7ytKak"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2119.outbound.protection.outlook.com [40.107.93.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7F1527BA;
	Wed,  5 Jun 2024 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615821; cv=fail; b=YQUqR8yjge6Oi3HZxBLP4ALZyULyb0KncFBy7RtuDdhyy5Fh8yIzsZ62T+yTGpFX0YKDA9+ms9sC9X018/1idYeLgx2rCXGFUr1P+stPqWGmGWjXu13Y/VUpHOYWt3M4gVc3X1mKrWmCbliRoJQLlQ+wFCiPuyyLbPPIT0BJ7bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615821; c=relaxed/simple;
	bh=ZUR69+qGI4LyqW9hJu3wMXvLwblhnzFCaZu6vfjKSfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b3ODlIbkEMxinx2VR/IYBs2BkC9hwjJXkrXn3D/f33WmRHKpRVYUJevSGH1BoMTyoG7ZKAt9+oM+izwF31swDCQ9h2IUsz+74ow78zUJrpPmPW/FGSdtVRofnd4N1M4qNV98b2XRlGXLS3qkT5gvY8fWkhnNO8vP/SeA30DlJpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=wf7ytKak; arc=fail smtp.client-ip=40.107.93.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXzgCpABVuwAna9Jge2elVxLGwFtSqFLfc8XBst3lSbNnbTGR8LAvohBSf17vLG2/Ioy6V+W8Ela0PFnq8+IhEmckkerE69QOtaMdkS3jM32xCzu8GtGMjuHFhB3i5OtxyZIunWjSjVoPAK9gVy9I5izvgj4224NThjbdnlBocJEnSOwEYJqZM7rd/ybd+RHBu2nc4oe5qw4c4n520E1F86HrQkpzu7tL3BkoT6Ci4AzwIiXoMYPzeg7v0Jb3R9LWCZx8Z1cGXrnYnp717s2PYhfO8d7LNXYpNbhIbaeQlItDZTzfvhbUATcBtJYYb3cprhF0/6w2JTJmCXGpQ48bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZhzkCh0YEXOsUBThTVc0p81/UyH9suxkN/Dh0CRO+k=;
 b=lXEoul320sVfnbDXWzUmZgepWBzL7iJ1HVpwzYFHi0Ms6rGHCfKnpqRIIoQob8IHY35joWYerii+MEY8dV3DnzjeuDAuLghytQjV4FN+W+fGj4C8yWwDh+nVp9rEWVvKol4KfzA0Elc5Q9Uy7Us9uiXmTSwOxi0TMzQvOWYcd6fDa6QJmRtcdYTYf2ToFEhE40hhu3feJwT9O4q1puZrvtOlvzPexwHfWBteatyVIMyZ4Y/TovJrHKMovrqr04kEuVjWIz59Zl5VmDRkhdUisnYmoaCU53XXEuU2z+EjOxY5UhccIHPck6rW+Bu//xWxxyF5wY7HX+lgap4HBuVQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZhzkCh0YEXOsUBThTVc0p81/UyH9suxkN/Dh0CRO+k=;
 b=wf7ytKak5P41Cyst9fDP1j86RjdXX/ZpLpulOEZrqQUU0dj6G5yLMPP5PzM/O32blEAGztSJcfgLaz86APaQsfb6ozcGs/G6FDdtcp52ffSOKe7q8EVsIRBYvk9laO1eC6yPAnCb7WM9v9QTGa7mmaaegUkUkhVDkEbA6xKvypY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by PH8PR19MB7093.namprd19.prod.outlook.com (2603:10b6:510:223::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 19:30:09 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%6]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 19:30:09 +0000
From: Martin Oliveira <martin.oliveira@eideticom.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Valentine Sinitsyn <valesini@yandex-team.ru>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 2/6] sysfs: add mmap_allocates parameter to struct bin_attribute
Date: Wed,  5 Jun 2024 13:29:30 -0600
Message-Id: <20240605192934.742369-3-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605192934.742369-1-martin.oliveira@eideticom.com>
References: <20240605192934.742369-1-martin.oliveira@eideticom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To MW3PR19MB4250.namprd19.prod.outlook.com
 (2603:10b6:303:46::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR19MB4250:EE_|PH8PR19MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 542ddc6a-ee66-4ec9-47a3-08dc8595e7ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uEGrR7D7rmRg9eQDAEdPvwX5w4x0zNjNkcfIgrUtrxzJi8cefLPcgoSXuAqM?=
 =?us-ascii?Q?TII0CIMx5SZkKWgtcWmtAiRSHVKej1OWJ//QOlu+dT7e5fyJV+/vWGjFFFud?=
 =?us-ascii?Q?h+Gn0FBKbRk4VJLYqL+D1GpaiHoXOxukZqBR8aKbqlZnv7zDBddy0vNBLinq?=
 =?us-ascii?Q?dP+GuwkQ4iXptm8ZVwHDDJTtwHd4BacSTuU9Fxh/Xrx6ZceUEjQuCjUTwXdG?=
 =?us-ascii?Q?jDF5l7GWpFr6H16liiDA2ekTWwKgrmN96qpzvk80zawuPwSFdAUlBAGAIdDH?=
 =?us-ascii?Q?alBfVR6XbRKr18lvn744drZ0/xOjLn17Tyxcqdjr1XzEYd/yC1jVkO5mKRnN?=
 =?us-ascii?Q?EpNwrFnoPcd6QjrvZj0623pJBdzNf7k1CLrD3aIGMnquaeaAlaIw1Abc8lol?=
 =?us-ascii?Q?9ev5bcECENzGbQOt3UPsctxFeETsc1MqC8x2X8/jFLflgVnDRwqQWo7ISReE?=
 =?us-ascii?Q?MYlhoBJ0GUWis4d17YEREuqEY0diybqBtvGfDcpxUhzX9Uv5SiZ7IDXWwwHD?=
 =?us-ascii?Q?spv88kxGwL0PBnkG6gZSHMgceG4gHtd9EDL3GKynr2IJRs9KUAbEReeZQj6s?=
 =?us-ascii?Q?f+X3NK4gZbscra4cl6ZUKH79tHw91asJg7nnTKBFvvM81/rTTb6HQe33dzky?=
 =?us-ascii?Q?iYEa2KWHw+2WoKzbVkJnw/ki9juU9wztPVS7jvsmXOxITwC49DxCdJREERIp?=
 =?us-ascii?Q?MtvKqLiGBZ3N/wWNnjZSDb6X8ZXiAhGvybtKx1MmCuGyWVZzpC6kOs0i5wO5?=
 =?us-ascii?Q?26wQBSjPnpMcoAoqeFZ7hqhwERe73+srqg97QeUCSrMd0WvjdNNLqJCPd2TK?=
 =?us-ascii?Q?0eD6ysd4OFJo5wBoAqYqbtC9ZgYhBA0p1LfINvDoKpX481ROhFvUk/2IPIFv?=
 =?us-ascii?Q?+yjRtpd1U57FtEWtFc2JdWEmTP7+SdFmdPz2Jjs75gUGoq/BtyzaESJEuarz?=
 =?us-ascii?Q?VNGhV05pVeCufEicE6+PJP30U38ursndFdvAiPOsPZ1UCaPVAQ6ss1vOmQtm?=
 =?us-ascii?Q?m++d6XkqO/qzkJBeykEE89C73atlw+agi+++30UtMpmoaLIsqjIwBRR/f3GF?=
 =?us-ascii?Q?2BHMIis3Cuo0pTFm7ISqGhCzJBKbG9czn06Q6lkMtdWnXG71WLjQJGSAsVii?=
 =?us-ascii?Q?v+K0E1TKr4bMx4UzHPBRkF/Bgs9ZGSfHtI2gu1R6JbPDPC2olIdaogrZZfTD?=
 =?us-ascii?Q?RU8ls18HyYmtQcbchmpxaAmUgpsIl1y6aVx633fFFPg3BmW+9rVx1gT3DCYj?=
 =?us-ascii?Q?NIPKZsumQFQz8RHbveJnI9DbSP0VjZ4fmrENsZ/LoVGNKjhFauU5I03zOVBC?=
 =?us-ascii?Q?RqKPOmzhnUrd1oR429vIUHQ0RYKLM7k8H+CuIVHbx2vMswql7HBCVX1WPxw1?=
 =?us-ascii?Q?3XibuGE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?25lmoksPC/AnTLxDIUIe1owA5WKhvq3G+5/n91gYhOwQWWr1pTu76O4zVE6s?=
 =?us-ascii?Q?ZiVYERu1jVFHgy7gqmadwomIooh6TYpU0UYUCANQ5+u44my4ndb1VXsPk6m1?=
 =?us-ascii?Q?SQShBFlFUS9hPuUbWo7KlUJ0OY2GNWbH5NuZB9zP61wawXWDOPWgPhiYPzeZ?=
 =?us-ascii?Q?JN0neL2iR7L8t6cuPFHMjUNuhIiYruOptRDAOJw8QdV1pDMEjrkM4kmdaIDC?=
 =?us-ascii?Q?t8yYBmkJNrGSo0/DJO9g49IM5kE54jvkHGcbTb86rcjGZsVThvTAi6Ache7j?=
 =?us-ascii?Q?IjSvciQHeiT6erVrNe1r0oIN/TcjKAS6tb3APhktuP1bzssMOQkv242xcU44?=
 =?us-ascii?Q?4xTmTrL/4HAoAA3ViRatyUsRpkmuCh5rdbJoRKs5G927Ek9pnKJvCPZ73UVi?=
 =?us-ascii?Q?Vvq45LKZewcff/O2inToDBesg9311+ZEAA0ZynhveIt9hotV3IH82+rr21SR?=
 =?us-ascii?Q?w+CYEg8Y73FFNrDN3fmG3EdJjdGhPDFzOq0Qrbk67pWj0wUnR71S4mXr0jOd?=
 =?us-ascii?Q?u4XzAkIROJ+iNkwarOKrBjl+NFH1hOV+Gcjuw/czkO570WhRtAEkCihNqAQj?=
 =?us-ascii?Q?EeQC+qpf/WCRvNYZiTaHoG3ze+OcDMEvlzQs59A5fK31YyuL/Tp3bixeBwZ+?=
 =?us-ascii?Q?XIulmuGrBwvigI3z27bmUCnw5Pxsp6yQnv3cc47G/JGOgzjZ6Tdd7dVGE4hd?=
 =?us-ascii?Q?CSIYjtSptYFpgy2kK2yqBzTMIH+bSWbnvg1h+twM72waLhrE6m/QKdSNfPju?=
 =?us-ascii?Q?Htyx/vp2u3fmHCvbHugo6M0OZoneuxy6vQaNx2wKJSToX+c0doW+QO3sV/og?=
 =?us-ascii?Q?3hG0QLeRQW8MYFZhXiTZNS0Y1eImDvXbRwZZQJIT5+xL/eqbj7tAYXvIVQ1/?=
 =?us-ascii?Q?ad0V6vWxouWM0jqUsFhkzvIfBzAIVAGf+xOw/oCiTRNx9zPxDv1dGYclmLSA?=
 =?us-ascii?Q?QWI+pyez/MnNo2/vMPIblH3XQHolohozs2SmgdbSV4qmnC353aXWFQ8wiz2q?=
 =?us-ascii?Q?8QXCzf2Lff8NuH7NXgPILk22LyCw/QIM1jFmmL7QY0nS2V8JBLkupfwAE/c1?=
 =?us-ascii?Q?fBOpmIl1ihPD/xNymOQBA6YqFcBOybV8jRilWMVBIieJFWFEXpp2Cm8R/m8h?=
 =?us-ascii?Q?oKgviCoqKVnNuM1mvVv5GrIlnXj0CNQJ7ZvCWaEYyuRT5nOlomhOTWZczSzh?=
 =?us-ascii?Q?/bh8KG16YkgnnJ5SvhSDLLlI1b9h+0yKkIx2S5iMZCUz7QO7hSSL6gP0pwyl?=
 =?us-ascii?Q?hrWJDoPVaSCGzvnsiO8c49zgolaIIt4aCRm+f2aRQ5bq2DtDidjenD+zIbRo?=
 =?us-ascii?Q?Ki8GDxFZ1ySMd26K3RQVGItbNqv3lLatcDo2Gtr0X+yXiU6d/ErItb6ZPL0k?=
 =?us-ascii?Q?B+F/Wm+Lt57Oe4IhGhn2eTMTzhPNtt0VpRENRA9Fso6LROUdCL89rEgWRRpt?=
 =?us-ascii?Q?Kx/DBi5HIVvUTAeltMOFOC2oz+9PNe+sSdze0M3S7Hz8VnjUzCpMmqQFo24w?=
 =?us-ascii?Q?VeVScBkrYAuz3NYuIVjNXRDiDO4/D8psNihVr+7fFGS1LhdivVbRixNt5Cqq?=
 =?us-ascii?Q?TduhtmZWxLegVUfuxpzNBc7EVgjy4G71MACP6JZuDXyRwe+KEEAOHNAbp881?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542ddc6a-ee66-4ec9-47a3-08dc8595e7ce
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 19:30:06.6899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3f+77+UO1EGX1JN+1QoG7pMYrqZSayMlV0Ae3NDDaY8Skp9PRiq5y7AlwCi5QxGa2uf/9pIbse3/1grg/zRBT/DhtCQGDgje48v7F0rfkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7093

Now that a struct kernfs_ops can have an "mmap_allocates" parameter to
avoid the page_mkwrite() operator, the struct bin_attribute needs a way
to choose the appropriate kernfs_ops.

Introduce a "mmap_allocates" boolean on struct bin_attribute to achieve
that.

Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
---
 fs/sysfs/file.c       | 25 +++++++++++++++++++------
 include/linux/sysfs.h |  1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index d1995e2d6c94..77c21009ceee 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -264,6 +264,15 @@ static const struct kernfs_ops sysfs_bin_kfops_mmap = {
 	.llseek		= sysfs_kf_bin_llseek,
 };
 
+static const struct kernfs_ops sysfs_bin_kfops_mmap_allocates = {
+	.read		= sysfs_kf_bin_read,
+	.write		= sysfs_kf_bin_write,
+	.mmap		= sysfs_kf_bin_mmap,
+	.open		= sysfs_kf_bin_open,
+	.llseek		= sysfs_kf_bin_llseek,
+	.mmap_allocates = true,
+};
+
 int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 		const struct attribute *attr, umode_t mode, kuid_t uid,
 		kgid_t gid, const void *ns)
@@ -323,16 +332,20 @@ int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
 	const struct kernfs_ops *ops;
 	struct kernfs_node *kn;
 
-	if (battr->mmap)
-		ops = &sysfs_bin_kfops_mmap;
-	else if (battr->read && battr->write)
+	if (battr->mmap) {
+		if (battr->mmap_allocates)
+			ops = &sysfs_bin_kfops_mmap_allocates;
+		else
+			ops = &sysfs_bin_kfops_mmap;
+	} else if (battr->read && battr->write) {
 		ops = &sysfs_bin_kfops_rw;
-	else if (battr->read)
+	} else if (battr->read) {
 		ops = &sysfs_bin_kfops_ro;
-	else if (battr->write)
+	} else if (battr->write) {
 		ops = &sysfs_bin_kfops_wo;
-	else
+	} else {
 		ops = &sysfs_file_kfops_empty;
+	}
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	if (!attr->ignore_lockdep)
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index a7d725fbf739..190b4b9355df 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -294,6 +294,7 @@ struct bin_attribute {
 	struct attribute	attr;
 	size_t			size;
 	void			*private;
+	bool			mmap_allocates;
 	struct address_space *(*f_mapping)(void);
 	ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
 			char *, loff_t, size_t);
-- 
2.34.1


