Return-Path: <linux-rdma+bounces-8199-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C616A48D3F
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 01:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5BA1891032
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 00:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7143045C14;
	Fri, 28 Feb 2025 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i+K6shrb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713F61F5E6;
	Fri, 28 Feb 2025 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702410; cv=fail; b=QaBlJMAl/24lECxgExGwKmjTUZZmuDfB+mjcm81VzGn0J70xhvbxdpQl/44cle4Db6C1emJeApIuforpE+eQXuioe6seqOgEdHr/s3ZaNwQzjnhnLWGhx8D7LhIEmzFXwMqWgqUn3vimXA7MsPu25qxh13apKeeRnNxHi4tFGwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702410; c=relaxed/simple;
	bh=N1mplYv8ur9z98xbrpmU+JTlJXCfPyJOxK4ld+xdhk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QZenQ4SdR30vCz/S1mpJeCLSMo0oD1u39XQyNa4k2BZsz8i4jUoqp5nmdhSnf+aS/7kh9EmoWEIsUzmPaCLWtoPWYPQOS2adbAU0OnRXXSrObisvu33c6gYmnv47rudHEH0vaKV9UHAHg1rmL+JePM2BKjTWVU0ZhWTzn5TZ0Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i+K6shrb; arc=fail smtp.client-ip=40.107.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEBipmFIgEyNcCReWAUKDtmoB9GxL53Ga1RX/hjUr/IvwVwU7k5ETjmvz0ustfYnfgZ/L5LxBIfPwTJXFsiLtUwdDX3wqmAJPYt5fRNV0+IvUBbRgFmg4U/G99DaTXowNBkv74P9uO5tosuitCCgEBA/ClmpVZVN7fCALB/dmTs5aB3P66mkkmy0XBGufHerTCk5RFZ8CFK1qd5l7rwmzA72SQRRFIR2Q/4l7PT07oIJc/qm05Vr4IqgfO2D/WzSal/KVk6gLxanyATqbt36XgHcED3vfxE5ExEIeNpYryiasO9gk+5IbdG9UJniGezOkrRCr2PuzuR7vAVHl3/Zaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EvOZ3OnHWSD/sX0F5QEZJ9vN1KjQxs+iP84sn7ra0c=;
 b=OFbbXVKNhbxmvhn7qD7FkvxWwJ4QzwcDZKN3wjysA46GOM5Hv20xB3hEEGGGVCiffyFBrC3n1gc/2zHiV9obNqGOfbYGo630eVLUGm23DqaLT3PN3AoEb3xFrzBTxFItB033hKfEaOjUC+zhzNT6H23n5cToC7ohLwvTXMdxGfdHgIJKm1yHs84AKaKZ5sC1yaL8i1MJ7WWGGQcerjFKex4L/XgVzLhqkmdw+gcT0nnlYCsOD+Pbjwp0XVsJYF3h1FsHXHNcdDIe9mMg8aUlw4/yo2I2owtdiLbqrkzDdit4pMqQBvp/fx8By731ts+3XnCRTW3Ol2Z2mI8zSK7rWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EvOZ3OnHWSD/sX0F5QEZJ9vN1KjQxs+iP84sn7ra0c=;
 b=i+K6shrbMAnNhXezmAfzrhfViSdEi8LlFM+L9AMfym1lD0B8SVcpSw2kkahO0gJFQFbUHwfwNxdi4FI6wISndTCJltMcelW4ZHGhHrWD00PZHaoD9l89SZJSYtPZOFspk/3f253meUamm5Nw0Sy/6QvusHUDYA/ftjD0w/Ds17kDhIXfITpedZlmtyngVHdotOOh7KJYHdXsCDHmrzx0sd07KXQM98hm+DIp4JYrM+AFAXYdgN32VqOrJVU8SbVCs82Lu3VFk96e/KCEDx6U/RXTbbrA7luv4i52OuBlc2ESgRtVkg2WFy4va6mglgJC0TUCvlmdC3xp8xc+h4sL3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 00:26:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 00:26:39 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: [PATCH v5 4/8] taint: Add TAINT_FWCTL
Date: Thu, 27 Feb 2025 20:26:32 -0400
Message-ID: <4-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:208:15e::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: d495568f-5c92-4495-aad2-08dd578e90bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tc2eMGsMTN8HM7m9H6csE2rWn+ZFML+P5ueMmVALt7Vxv9oeSu20O9/GcB9U?=
 =?us-ascii?Q?hnXCv4p0LPA0yPqIX04aqk/TTCrDw7Hx6Xls7WEaArU4d3Uz/CvJE23v5lku?=
 =?us-ascii?Q?uqI1iFnD8lFNJ2NGLONnvGoSTD+TfGMqiE4u/3FKRyrRqFMpFggt93dSVDyI?=
 =?us-ascii?Q?s5H4kr9bXelvEE1NQO/tJnUZX4o7GJEDERtqQSnDTPE7ljYop41dAJXjRHc8?=
 =?us-ascii?Q?T2zIfcZVeUF6MCnXf4E+ugRc9lCLZ7b5aO0AyWgEHAuNeMZqlF8bNaIp40eB?=
 =?us-ascii?Q?ubgCJR/CXT9/pd4Ov1olHs4jhaArhRU/AZMfDhzaXvHLGfEZAoqAa86+4k0b?=
 =?us-ascii?Q?x0RUyf1E5fx0zLn/gusKwRWQNgJo1bPe3xi5nSm4ejhVejNOvAkDb9IXOj0Y?=
 =?us-ascii?Q?6i8cxRJdeJXCmAAI/NtJiG/Q4XbtPyEbO4dxYLSfub/RTmF0Ct9ahrD4SRpz?=
 =?us-ascii?Q?ThyTXKgpjY/ewYUizxJPEnhTBIFUHQPLRDXgTvmtGClc2UvUjzse4F+stRo1?=
 =?us-ascii?Q?/kXjA7WQJ198Gmewj6nYZv25t8XokJ/Xs1DL9OCiEMSF4GZKPbqaqThsNuap?=
 =?us-ascii?Q?AsIqBUVfqVdmVzfD1wZbPo9WqsXH9Ye6QbRlpzqU0IiI8jZmM4JsT6DDNsDx?=
 =?us-ascii?Q?0zWvG1tZvJ4VxckWIKmQdV2oWKnHp7U12oOvL2Q0o8i//qmgUj13RYF6maeG?=
 =?us-ascii?Q?cINrBP0LvEW7YE1zawhrC+Dcz6MGAVghVD9WHqIzkgBz2Iu5HGSSPn4VKNiA?=
 =?us-ascii?Q?j42qv8gu8H2Sb18HkN9xEmCH7WBXZXB7dRPSDrZHvSHpT+qKVW/kooTjJVQw?=
 =?us-ascii?Q?HFCRvK5DuYjenR+mIMdryDXMWROvwpTdY8c7itQfv+xME/IZdzvMwjzbix5Q?=
 =?us-ascii?Q?VsnU0+paAV6bclvY0foQ5Gwlg+XG076TLlpCf8J3b8/fyaZsQdXCq3VV5Lih?=
 =?us-ascii?Q?7Tx5Uqda43XCodIICjvboCG+RavziEEuWQQuf3v3ZqjAxxlPnKbjXd5Z317+?=
 =?us-ascii?Q?u/ygUAZYQVw2Oi+KMtJdRZ0Q57mAiKL42kbJGkYAdagqFhiA2WRqFYQ7hofn?=
 =?us-ascii?Q?x27YKsEJB22dGJnRiHzlAhGBHMB0MrW/ibQW09qEyxEnY2Wt8+rMMumuFicd?=
 =?us-ascii?Q?w3a4brCCv42sVGC3Sgg+Np+1hR73/DMpiuMeCmbDVd0XRM/FgKdZLgSdBtG6?=
 =?us-ascii?Q?xymROI+iQRd2mGpPz6qHa+XD/DGmCC00sJBCt6UQll+q6fRgPKJMXrpJVMKf?=
 =?us-ascii?Q?E25f6jfELjk6sf70v+Lo0pArIEF/fgIZy77QxQP5XfKgur/ZcZC5Q+mQfJEF?=
 =?us-ascii?Q?8G7sTQsYpz6lV2HKGk5xrmPYrzOXx5HZ0USItxR3HESdlnams2IbF0m5aMd6?=
 =?us-ascii?Q?41+eS4xwZonfpPbIwHDJd9kKHkZJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KHxa8TMpiAISi2wVkq0LM1ZqXNirSMBLe6pMk4coRMxXkKdXdOVtI6iHFFCw?=
 =?us-ascii?Q?b8trPhBWVWkWp9Ou7soB/w3AWkxNCge8HBxjpw0G2kWC5rExks+p47Znw26C?=
 =?us-ascii?Q?sXt8eNAcHN6BYzUGfE5BMWQ6Vs7U94AGIT769MDrv+DopQdpNLs+V/aPXYYl?=
 =?us-ascii?Q?X8/t4NINVp3Lr6AriAIT+Mf4ZMzfsNWKnHPtowCsNSk7POhX+xhHizTThU3z?=
 =?us-ascii?Q?pjIMmuHBDAiYYA3DC0K6V1VoPrfzeYnFRcvgjOkeRlM9hbqGafITdtrahZWf?=
 =?us-ascii?Q?kClFgzaVG7PKBieqjd6ozSQ/nK8/hYPYmrWDCS3RefqnW9YHFvQDydMFyXTd?=
 =?us-ascii?Q?x2PNLaTioP9eA3bxA6ec2vu9ry1nnF21CzOsdmiWeA88o3sCbAJJQy8aGN+Y?=
 =?us-ascii?Q?7E/FOFwe76lcQhaXKm4fNQBKXUVVxF0Ey6UqrnIEtjSs73DAiANM5+MAFAgO?=
 =?us-ascii?Q?Aq4h9LdT3clqPhv0x3ErJllJFDr1q381GJ1gVAJucLGeT2mhXHFy9w/gp9BP?=
 =?us-ascii?Q?WkCIyhdODb9kpIlmjz+047l9IYwqA8+dIsbd5SZzx3lOlNXB3tZuyRL7/Xmz?=
 =?us-ascii?Q?jDFYeKZVeFBtV3DhxKJGJueq3uP2kUqkBIibDwykQObWBMF/S/Pr92/SUYDf?=
 =?us-ascii?Q?gJSVxvAVdIz0wNeXVNpr6Sezg64yL/mRnTganH9nPXjmqb+dSuffb5vfm89D?=
 =?us-ascii?Q?u9iVWXIvifaDjI7dPxUs/Fk2E0/Lt0QD6UY9YaB9J6gXcHwEBHlxSYmyGbMy?=
 =?us-ascii?Q?TZWTC8Q0UfBggTwJ0tihzo8hT1917BraYm0qyumPNNVJNuoWa26ucWBW9Bjf?=
 =?us-ascii?Q?QctofMNKwns2Wge/lFniptTVqyckwojD2DKhLUMi8fgKYYzOCY4m/O5RlNK9?=
 =?us-ascii?Q?7aXw3x+E7F1axtfS/NjERZaSFCWc0JA3xR+NzQEItJ3uFbDw5WsasA3tizcW?=
 =?us-ascii?Q?7aruT/l2WyQ122SelLyakrt9fQTXIBHF5m6mpKWwlIGorGsjoUUuxba4kg5j?=
 =?us-ascii?Q?9CK/K0U9e3cLtfYmPFI/5o1+al1q8ekpL1ASLEYOcSmkZuLVKDUJKi8HpHoh?=
 =?us-ascii?Q?u3Mpvb0TsOSjHK7C+Ska4lBfvNNMi5OvKCljf6BVo02bIG/LPcA5xjIFYpus?=
 =?us-ascii?Q?uPsi5lSE4edbShkEn/ncSEbGPsQnrckFKKAt7GIHuUa7oMgY7iJgQ1wPBOcf?=
 =?us-ascii?Q?QQxuYK6ZKggPeLwxAZGL+1MGjGumI64c4ihsM8ml6Ox9Z8oEwpdb51SaONWn?=
 =?us-ascii?Q?qSMaqRIapztpJsmrOdQgTjnw4IqX9rDjM/mA1xldobhea3a0JogO1UtAfONJ?=
 =?us-ascii?Q?ALxCkJc0h5WKyUq/cSAOpREDnuJHLvpBi0RRN+LjitwK1grtlc6ZU18+Fmec?=
 =?us-ascii?Q?zZ+F4IC/sKx+AzK1LrjtLcdk4HD8vLPUDwtZGCJTf689H/7JG0/UmyYRZsKq?=
 =?us-ascii?Q?8t9tTvZDkhUgjJi7n3U1PSY6AvndTk20Lf2Jex0rEAutgPPsBO3KKGL4zK3U?=
 =?us-ascii?Q?MLEkYy5RsW0bZnVy90zCKASxJRzRaYXi6rFWyMtswig2wdQw9wmj4cIwycZh?=
 =?us-ascii?Q?MPZqe1BfodGoJrHnQqCQ6WyDE7m5hsHYXC7k+hzH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d495568f-5c92-4495-aad2-08dd578e90bc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 00:26:38.4602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTjN49PGH+jkzS8RRjvp6etm0nwatsBDiNVZn9HZFFrRx5ObKavu5sDgCXyDVRiJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433

Requesting a fwctl scope of access that includes mutating device debug
data will cause the kernel to be tainted. Changing the device operation
through things in the debug scope may cause the device to malfunction in
undefined ways. This should be reflected in the TAINT flags to help any
debuggers understand that something has been done.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/admin-guide/tainted-kernels.rst | 5 +++++
 include/linux/panic.h                         | 3 ++-
 kernel/panic.c                                | 1 +
 tools/debugging/kernel-chktaint               | 8 ++++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 700aa72eecb169..a0cc017e44246f 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -101,6 +101,7 @@ Bit  Log  Number  Reason that got the kernel tainted
  16  _/X   65536  auxiliary taint, defined for and used by distros
  17  _/T  131072  kernel was built with the struct randomization plugin
  18  _/N  262144  an in-kernel test has been run
+ 19  _/J  524288  userspace used a mutating debug operation in fwctl
 ===  ===  ======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
@@ -184,3 +185,7 @@ More detailed explanation for tainting
      build time.
 
  18) ``N`` if an in-kernel test, such as a KUnit test, has been run.
+
+ 19) ``J`` if userpace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
+     to use the devices debugging features. Device debugging features could
+     cause the device to malfunction in undefined ways.
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 54d90b6c5f47bd..2494d51707ef42 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -74,7 +74,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
 #define TAINT_TEST			18
-#define TAINT_FLAGS_COUNT		19
+#define TAINT_FWCTL			19
+#define TAINT_FLAGS_COUNT		20
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/kernel/panic.c b/kernel/panic.c
index d8635d5cecb250..0c55eec9e8744a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -511,6 +511,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(AUX,				'X', ' ', true),
 	TAINT_FLAG(RANDSTRUCT,			'T', ' ', true),
 	TAINT_FLAG(TEST,			'N', ' ', true),
+	TAINT_FLAG(FWCTL,			'J', ' ', true),
 };
 
 #undef TAINT_FLAG
diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index 279be06332be99..e7da0909d09707 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -204,6 +204,14 @@ else
 	echo " * an in-kernel test (such as a KUnit test) has been run (#18)"
 fi
 
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "J"
+	echo " * fwctl's mutating debug interface was used (#19)"
+fi
+
 echo "For a more detailed explanation of the various taint flags see"
 echo " Documentation/admin-guide/tainted-kernels.rst in the Linux kernel sources"
 echo " or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"
-- 
2.43.0


