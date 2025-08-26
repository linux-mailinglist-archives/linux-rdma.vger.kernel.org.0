Return-Path: <linux-rdma+bounces-12938-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B77B36F3F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 18:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF5B560969
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD2A362983;
	Tue, 26 Aug 2025 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pRuFC8tf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37736C06E;
	Tue, 26 Aug 2025 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223552; cv=fail; b=Z1OrVXdGRNWrQY5Aa+5hg4+f5Xo23prOYYzYtjzqK4gnR43IjzVJ/LsGov1edEO6elAHaP0ABKI1ZCDEF5nLwvnQdOUO2SI1llURFmPLXksDTlaUfz2TH92lxyzjKQDbqfrrtrIKY2EAxeM8v5aVClAscZj0ES8TrlsGpI5G/O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223552; c=relaxed/simple;
	bh=z0oNy//uvzmQoe0BH8jRt6tVMAMQ2E/VchDKYzC639w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZUln25dXGsFNGZIZs+RAvl2B72JZyI0i0SPuCYQVVfnuGjE14zyvYkSbCbgtmgKDcxgOhTZwreSbwpQlfiJMwvjwtpZEsuObtYdoO7WAfMhzsRC1Vg+ZJlly2lw1pgZEY3r8ng8eWOJ4/HuEa4T+EquVAyqZ46NN6BZQ56XJFTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pRuFC8tf; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPGTEyi3qE0mqQXVf898BIhaTeyxDAjNWPAFYRwtfiekOSv6CPZf4Q1DnDdup4Rnn+48I5/mA+FZMLOrM/1AEm6LhdPyH/QJT1Ze2INIW6pPjcDisswxQdxcrR0u2Aq08s/SvPYQ3qPCNfuVN4qWWvORamqqv4Sz1WS5sd7SnRORqmdq/h39dLd/iGwyXADPOGTjZS/A1Vm7metJaU8vIVnA6EXQVrUj5CH+HLDa8cFXgpQ2HleA6U/HgduYtsBuVamcbYKqAxmqDZ4p4bjlCj/+h3Ka3tCyksKqfqumCRDBylNIjlZdvzn5EVjcLfT6OGsQOqcSz1RyTNzrfNA53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTT5UdJ86ok6l0QUjMojUN7iQ7XYcE3XH20VxHSJ9b4=;
 b=CWMaQhetKGy02FhnhUs4eaESAYwU5paespKU0tKqGsy+8wsHf9h0qC9ASpoxLVfGSH7S1hdWBEc6jp3RPD5+jMYTx1Yb5Tf6XVIpcMih8MO8u7VJzrQZRCbxiMkvTwXkri4kugFeevrM3g49vozTMwXrZqtJCQ7Jgk3VeEZm+qvDXWjcjcsUBbu+WpWMvNDDdBwBq7hTpsnVUWZSyfDGlbRuQFabOGkq0N+3GbIloWiku5SXtPIJAkYqURpQ4XYKHK4C6swpdmmWQn+FCnYvVpDrO3DbMNe2+vjcSEGOnNxe/JprhQQVpkseo8TaKKQhEKRv6h5s3ay5uKw8pBTFCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTT5UdJ86ok6l0QUjMojUN7iQ7XYcE3XH20VxHSJ9b4=;
 b=pRuFC8tfUL1xbO5jjZ27V8lKQLfJkMdQa2XZeuMacUzGntCtY3QjPob8JbXRqrM4A1tqCfvq7KEvPoXPi1+dPHQWRdutIJi7ULIVkP9eJax0IJ9OSp4gg8gDlDJB6ORizelhjtMtk8TzVuhqPuRfwl32vG7vC+mrO4hqw1GGHKG7FgtsD+RHjkb5PmOdVaH+loKmrUyGws8oQL35bbTiWUaoScbbvlsTjIpLMjpIuw/lhAN5cz83PKwEL625bwW39ckl7hwF+EB3JCDclpYM+/OZeMnHTh4/psqfhJILhcNpS3a+5uHMWWuaq5c4UQd0c9np2CRQtoPZgH791QMqLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 15:52:28 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 15:52:28 +0000
Date: Tue, 26 Aug 2025 12:52:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, leon@kernel.org,
	andrew+netdev@lunn.ch, sln@onemain.com, allen.hubbe@amd.com,
	nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/14] Introduce AMD Pensando RDMA driver
Message-ID: <20250826155226.GB2134666@nvidia.com>
References: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
X-ClientProxiedBy: SA1P222CA0186.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::18) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cbd997-916d-4756-76a9-08dde4b88ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qx5HCalpGqrg4T+C5J0D8YJBLPCdokPQioz7IfQt5iNTT+Sw75ddoOz95kmH?=
 =?us-ascii?Q?8T6nvkOjkoyz6Pch0Z6+vSdtP0g7y7GM3q6KcIgkQvGQuXx2CE1QPrwX5NLc?=
 =?us-ascii?Q?s+N+BSbunqpY0z/dFp3Q8wCMLdLy/h/9/NZgeVrflX3wul5ey7TOhrvwuVZw?=
 =?us-ascii?Q?AtFImtMeaOqnf5ULqtJc4y+vuVsKmWxoGeoPXq475NbReV4dYQxKeYvjv9MF?=
 =?us-ascii?Q?AtkG8oFE6a/B6Og5yvAnshRK1VD9imjl2qnvj4VDQ0Vc8rk7BROwjO8d4cIO?=
 =?us-ascii?Q?4TnSCd/83/psylO+4tcs4PqV5iAZu6ca7ZM2Vzr16dDoUj4Lwxo4VuAA6irS?=
 =?us-ascii?Q?yehCJhKog6De7qdwGSumcoZkgsudnwMKWJADwQlg+l90wpM68rJHQBONUrPx?=
 =?us-ascii?Q?pIpbD+VXyEBj4NscaN1uhuKevg0fP3fUWYfZkU3WrSnQvdXYu0s4id9bzJMt?=
 =?us-ascii?Q?ITZARbfgp8hNfYgRUinE+jiSTJ49cNgs9TMRv5J6sKdvqh6HzR0z/GHQk4i4?=
 =?us-ascii?Q?zWlF7lIT1AwcrIczsgP7EIcum1WU7/98SeS+7W03ct4cwxoeHIVd0pVei85O?=
 =?us-ascii?Q?znHFd6cP/MZVDh65q2Kae53rDtPCFwuKjGY+rRVjStMAdFO/9Gbza4aBHzuS?=
 =?us-ascii?Q?zfpIu41rETqr39XtDo/tTEz3Z9ACkk4XP5AochqbdYtyQFEBPmNxu2Le8YPy?=
 =?us-ascii?Q?/Oih/7YZkMB2LGkHs4zecCc88MFi94oxeFH5IDVEeh2XDss7BtYSUAHe8qzE?=
 =?us-ascii?Q?GikWe2KDC9csRCn18JhzQlVQJtRq7JlQNuHLBcqVpiZEJVhAl2VdmLeGyAcS?=
 =?us-ascii?Q?Pf0MjJnC49keTJm4KkXRCH02ceAg1+2aRGZTbWrTsqWnDeQFZXRmP+GbJxKT?=
 =?us-ascii?Q?Eb5phBU2RnF1rG8uhq86JEfp6ZS7l5lNyi9k4mvRSRW9jsSSqDl9j8a618Mj?=
 =?us-ascii?Q?ZuS9BofGAISBZ+O5HIUUr28YYZ8+OFo9vablLbe44cTMbNtrZVJBd97dlbSm?=
 =?us-ascii?Q?XV/9RamVHLGFmz8Y6xpg8V3cK12x/41BDN4CALrcbyXlks6dnUNSWvejbQN4?=
 =?us-ascii?Q?NSJm8S3WfG5YAdfOZwt7a+5dIW/y3EnDwR4PkuNqjQnh5iCuT/bVHFwbv63q?=
 =?us-ascii?Q?LnnvKZvxFppxw/qzvatcHeBf9EVFpiHT17ueW5sLUwyYsiVNJiSDEH7jlTuX?=
 =?us-ascii?Q?5uvSlRW0fe37yjvzTDYDtZnGTj/n91IKEpQXwPRkz9IZHQtegZqVwgfqS1Zd?=
 =?us-ascii?Q?HrFpsW/2TPy6HeiCSzGdid8qq7peP1Uh131exnJNQXeMHqIENsvAphlVZ4+e?=
 =?us-ascii?Q?vHbO37BJnhxTwK09MRjIDAUx5TSLFh9lHxWpazkTsnzi5mpxjOzavSLivVek?=
 =?us-ascii?Q?fvpek9quuG2QIJKRpdfALszZFOWQGKNn5/YKvY57aGKOUXWlDxNYyUoAfK0Q?=
 =?us-ascii?Q?G1j1XPMAWdk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MKZf/NfEnFNozWA5roBgRz64fJRrtdcMYOAaFvFVktZKSgrLQEoyCx9cFuNk?=
 =?us-ascii?Q?fOls/bVKakFj0dmKfp8Vp0NKnM/hwtlhTVubjWKeiWy54f+Y1kMVGre62Q3p?=
 =?us-ascii?Q?1QlnlGeT0AgrZLjRFa7wFQdwUzGTuwa/kr0vWx5sM9dDObNhFIAoAy28pXdE?=
 =?us-ascii?Q?PUNH0Zs1siolw9ZdLWQep+z18g6seW54DHZzXDr9oLpZy5W26V1lY6Zh4Lnx?=
 =?us-ascii?Q?6zFFGQAD9xRJVWWdNVvYvD/J4EHXCDJUO84MSlb79NSLyeO3LcrSKVDFGVZe?=
 =?us-ascii?Q?zq+KCMyUzAEqRo4SYgfMbOuv6vzJHzMbfl7T/YenENo+fPQZCa26sP/kvS2M?=
 =?us-ascii?Q?i4Lp2SZl9k8Uqj/1pnRAwDbKhQA+QOo12njmoTXzB/V4IUuGfuBrVFSE9cdQ?=
 =?us-ascii?Q?i014upHLodN0bV8DingYHOs4ZGe8QQEa1OlK37tB4nwT4udlnB8l1web1Vkk?=
 =?us-ascii?Q?Ax/YfkOs/U0REXSMcXOUY+2sCMR86xEXPiJC0DVO2t/kyPD2d5/UpM2nZ0mF?=
 =?us-ascii?Q?jQOLp5ABAdyTKSMHmUGPNibSxBRTWnoUyKDmYejWKbzAucbSoNfXUHsq2M+E?=
 =?us-ascii?Q?Cxm/D6uJo5Kk/+bejT7BRo0bIHyCQqci7K54M7O9K/k+Nyr7YIE0xFf2ZMql?=
 =?us-ascii?Q?2mkp8g7kdAMezZmyAH/KOKEzbUjkn45nJMHkp6cLM+zxL2JI2SJ9sPZI7TWv?=
 =?us-ascii?Q?XuDFmgWX0fuO0iNV1MVXWtYurb1fzRfkfUpj5foBWjpPGYUbWWnqxQSeduQu?=
 =?us-ascii?Q?GVkkKXjoAfCBTr3Pf4LrZ3yZdo1lSI23tkeSFAO8HO264jCrar/nSVr4lI0k?=
 =?us-ascii?Q?ZCyjck6SJSQginA3RGoL394l5oW5mnXVBy7MkRzp1wtZIVSIDa5FJ3066UUX?=
 =?us-ascii?Q?C+K++ND4lm3aEFJR4FWP2cpeP1Lp5IFOYFveb2qMS+3n/a9ZSvxLY7w/ljPs?=
 =?us-ascii?Q?2DsmIHlrZIi2VxvNckXMzmwLaa5Jk6tq86YNzK0lJOkBLYjk3OGra9GMgEfY?=
 =?us-ascii?Q?RNLdEEqI4YoMor4nkLpHRjfEvJ1ZnrONtzGUbRyuzGzTFr+8B4HnGyxUB7J/?=
 =?us-ascii?Q?c0ZlGT/eJscOsUv26P3fHMDROKzS5o81QJmFrTTPK95aLNG9OSGdWx9I+1z0?=
 =?us-ascii?Q?ooJalKxbqjAQvQ5eenDky3uLYN5jioO7j7v9kXVoef3sOXy1mTvDAURbAGIh?=
 =?us-ascii?Q?haj6yltOrInU3jRFvFruYdcJQmQ3QEfWr7f17FBYcHD+UnOiZFwkXvdDJ2u6?=
 =?us-ascii?Q?F4ayjhNtlyjugz4JHpi9j+gDqCrHQGdm/piJyimSVWPFZqU4dkiOLOIqnBMA?=
 =?us-ascii?Q?25OFjkW0L8qM/8W6sDlW4o2BZFTkZ8KIFUSP31zSDTRM/MLOV7QyJucFiCfi?=
 =?us-ascii?Q?d9khTh2IiKSgDgy2dTHm7UdiK2ZxbQZ8iko7WcemiMdNu6TMcgB0YHuYFj2E?=
 =?us-ascii?Q?Hv3eoY8gTm7fddBjwi94YCgPONQKydN62HAvbCJRitVn8GvgQAjVrjhQ+Jex?=
 =?us-ascii?Q?5Jdl4ICR46dP9PaqrqMaHkt/o47zkNHKWbIkssNub9lV2fIj1uanW97ceSzA?=
 =?us-ascii?Q?g+xzNosvD+8j4jP91KlHojEbTvV4urhyGptuJfaT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cbd997-916d-4756-76a9-08dde4b88ec7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:52:28.0608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWr9b4AW+YR89clQ6YtObaoROS2CxFlN0Lor1bSptB+/hUn7g94qzHLj8f906tGx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045

On Thu, Aug 14, 2025 at 11:08:46AM +0530, Abhijit Gangurde wrote:
> This patchset introduces an RDMA driver for the AMD Pensando adapter.
> An AMD Pensando Ethernet device with RDMA capabilities extends its
> functionality through an auxiliary device.

It looks in pretty good enough shape now, what is your plan for
merging this?  Will you do a shared branch or do you just want to have
it all go through rdma? Is the netdev side ack'd?

Jason

