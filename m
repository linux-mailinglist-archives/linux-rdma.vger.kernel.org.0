Return-Path: <linux-rdma+bounces-4011-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0278F93D3C8
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 15:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A198B22449
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 13:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D49117BB04;
	Fri, 26 Jul 2024 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iLO5ubv2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD823A8;
	Fri, 26 Jul 2024 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999474; cv=fail; b=CqAPJ5STK4YIsw7Cke66+pMFC1KAuiKRsU8x60hd+SwANYGf0T52N5YZDnYg89pl5CjKXPCs5m6Vxkk3ozWgxW+q7wJ8qlOyJNIHDY1LPx7cf2dMd1Clz8jFPnVC0NtFY82ymdrMvuVhx6Z3QLmHgK5q8FS/+HVdASPhlVnDT5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999474; c=relaxed/simple;
	bh=4qhVA1wSAbQnDobbIuxZJQiNGDG4whz4nDaRerFrjBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D3IrQOI8v1Ejl8Z9kPrqdMLlcwiiUAHe8yN0fj4sgjokEMoIcJvBa2wjLHWBe5R6nTeAJSRchHN6BJp86t7rUlejn9mANzFj78CJvYrj5cnSWL0X5qI4MQuJKl0fi8bYXaAg6Ho6NhhLd6g5APvcVevFYW4Dcskb2jYp+cKyZl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iLO5ubv2; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUwaBZIR9K9ItHiHTRvkF0KwuCkU3jSNs9aY+FgNNCCh0OAsnvQyQG4TutZpexx0xe9lfph3f+vHMMJ7laex+POV3veNmDcoO4iwf07li6xowxaRpcNgyN8nOxd2auQ7ov6mLrc/M26ymL+NhJHiy7XcwzNoU1d1yTcD5KDffUaVA/ePmVF41Zw9MrNnZwPySkdZT7oKcsy8IGl6Eil5AkE9RAoDc0Cn48yyi1mcy9JLPpDArSTU+TCZk27BKPVKh66XgOeQMDUlT14NJ5Anx0OeR+DHCeflSNx+PZ3kk9XrBbyMI1JY8l5PcR/1c5hpZo2gC3BgVuCG4uiR1skenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qhVA1wSAbQnDobbIuxZJQiNGDG4whz4nDaRerFrjBY=;
 b=lS4IuM36qFfP5vtUcxIz+xiPvPsCjOLOqEezNmibsR8aPBbbcfC5Yof6C2zQp3iAuLLvm4ueV8XxX16YK0Kw/2nkhpkp/anUlBE16u4N7s2BlmSHbb/06afvmioK08VUQbjraJU4wEC7M5BA2ovxYMoJ+D65XBxHFj4Y4pAYGo8weKaRjTR7FnNgmjtF7B+foTgk3r7E/tEZKvIBgMf38iZyuqbfO1YKLL063SE0rTQr5b77Gly9oW+IUpXUvWqoIUrihnJqmynthDo4N8ZX96H2QtpUJ+aQZW5OAiKp4oa4WA5ikQ3J6GPTVd0OH/N06lNRGb8aCDOfkfPQPKBj9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qhVA1wSAbQnDobbIuxZJQiNGDG4whz4nDaRerFrjBY=;
 b=iLO5ubv21noS2bLdXvTI7kGPxkVFTrzmZ/LQ2ALzGP89Am2j+RSt2qsp3uaNA1LGYodWZ9ySmqqi7fcbBJbywUVuAUkRDhmQ+2mn6qGVwq3nLXMC+tare4/6wgyX1ajW50mXKmC52cIXIuj1PAV2Ny4OczXMgPnFHuWHoEjeLDmJH/PRf9lCAeu7cJCykjh40/WlrEMP3DBUn0nQuF5SK1oaIDovhwbnIir1u8dlYQevpTzvPIY7MD7WyP7LPC3GLfHnxJvZiE4Z8KQFhRLaElDqNKqfLHmTcDNTgkDAhMV5Xbdy5wfMxURIwXi+pJFgPw3/+EOoFGw7lHC6LvUJqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 26 Jul
 2024 13:11:07 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 13:11:07 +0000
Date: Fri, 26 Jul 2024 10:11:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240726131106.GW3371438@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
 <20240725193125.GD14252@pendragon.ideasonboard.com>
 <20240725194314.GS3371438@nvidia.com>
 <20240725200703.GG14252@pendragon.ideasonboard.com>
 <CAPybu_0C44q+d33LN8yKGSyv6HKBMPNy0AG4LkCOqxc87w3WrQ@mail.gmail.com>
 <20240726124949.GI32300@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726124949.GI32300@pendragon.ideasonboard.com>
X-ClientProxiedBy: MN2PR22CA0010.namprd22.prod.outlook.com
 (2603:10b6:208:238::15) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f23bdb-85b3-47c1-1cfb-08dcad74691c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DkMN/R3SDbbE1wO8fRdsTHyFcAt2VGYRd4aI/EHdEjTwucPs4IPlAyNZ6kJ3?=
 =?us-ascii?Q?dStxXXuGp5sK6AoSeA9AWm5HYx1Dr4hEfmELiW+gRNHRJcP6mlU0VRVp8sPx?=
 =?us-ascii?Q?jSx03kmXiC7Ers0KTKB+5xZhW0GVN4/VpCysL6c0q1xXUtxrGakV9UaYgBz+?=
 =?us-ascii?Q?yuc7+tJmEqLDKAhmhLhW8a4zwpOUCHkWB0esrlkymkR2oQySmKVyqfWfE0YJ?=
 =?us-ascii?Q?MMmPR5igx4Tt3GmqTLMycJZ/NvxpUiTEP4KCBT7QgByjgZ1CwZntWZdm8jrq?=
 =?us-ascii?Q?Ywoojic5rSkLslRgo7YKWbBQVVfTkDCxHJO+9YYbP/xuiqRr5dERIXZhQ89K?=
 =?us-ascii?Q?oz/EfY5lBKMY308CtAwPCqz+y9KzQCV9rTB52oxY2VW+xGx4ltzbgns7xmQ6?=
 =?us-ascii?Q?Au7ymg9nG9i0i9W76VVzwo74JwR6H49NLORhO8s2J8EF7Ue5LQAU8iOSlHdZ?=
 =?us-ascii?Q?iVQAsupmSzEZKf3R1xL+X44zcLQyu5qRA0b/QfB2frYDNFeGL18iFxTp1xxk?=
 =?us-ascii?Q?Zl3VsldIeXySB9RQeFXPJ2HNWY1lNiTh2dw2yUeGz5jqJo9ZhE3HIMRauLFy?=
 =?us-ascii?Q?5v6nTxUkMLi1si/c8I4O+rtAqvpPqVh2Qxh8iAr2UIOT25VLGCm3wBAL+LKL?=
 =?us-ascii?Q?Yy9IQ02oRRWLlaEb96H6Xx2jFUrEwGaoM4fStrj33gu+r1Sx8hAU/hNYADu/?=
 =?us-ascii?Q?L6RdxQSOL/zXplSmF/2j4/vXfwdqY9xDKPNL0tRxoy9zZlIOXmgCnChOMGfM?=
 =?us-ascii?Q?ZMrMaSq6ZfTY/Ey44OGrAxN9e/FvCD0Kqah+iiD4bbsRTowagZ62humYRpLV?=
 =?us-ascii?Q?Moij6Gp/nNtAYIwZ6QZOjRvTaFRWfEoq+fMI0UX2kPAbgUll3aWoqv3B4jli?=
 =?us-ascii?Q?ueiVB6HRlD+P7s7w27B2yCNHzBFOp9oa4EGZh+pO/rhbMNtgzTfQn8GSq/ge?=
 =?us-ascii?Q?WaefTNecAwRukmY+AhAUiYVdZhLKWkRyYZCX9DnV54LvLCKQCPs+7fueWfJZ?=
 =?us-ascii?Q?WBmjv+I+HS26uIjKZtsFkIyAhwR9HskfazXbqHBPya/kcSvgR6s/Z1lya0XQ?=
 =?us-ascii?Q?KFb7vW0UY4tKGDeW3QG6cBn91q4Cm+tDd8DdZkbuoLHySw2M2fgSlbXXdaM+?=
 =?us-ascii?Q?GbAesu6CIY9kJP57HbrTO4Nq8ItcnbEWQY6n72+G8/2WTkegCsKwbLGjQPTp?=
 =?us-ascii?Q?VS2MyHClOetC2bC+Ze+PEK5pgY2QS2FHEHz0PVqyVdKT86YedbaeU4cuXSQv?=
 =?us-ascii?Q?mqSLoA0RoNo/KAuDO009FcAaCFUJaGbw/PLx0HsBryAZ6GlhFFw1xmTdZonM?=
 =?us-ascii?Q?egVioO80O/4/6fkx1NGQ6Kxf/uBhYgm+uKgTqh+xl1JGdzYMsmx6EAV9BB+I?=
 =?us-ascii?Q?GY/YspM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pcn9XZJ12E4nZoDiaI2EmDwM5TtQvlxIkHxMYjld53QvGQRU+kgUkfL4nRhT?=
 =?us-ascii?Q?CVIBIpvRe1xA5EQeRKBHgAyAzJxP1PtswgQrNxKZC+ZApih3c4P9g2eb92kz?=
 =?us-ascii?Q?6v3zlVta11qOQmAI3h6Ib12traMvNxQ/sOXixQmk5hJ2UJPe+0h05EPrPxKq?=
 =?us-ascii?Q?boRfpy25MENF3JvWc9SA0Sc1SX3lDRBpdOrGowo9tMjbo20H2F4hyeQmbFIR?=
 =?us-ascii?Q?AF3zCNACOnwPfO6RhE+X9dILlOYxypOtVJ0JZKUQctcZir1HMEwfA8mKtEco?=
 =?us-ascii?Q?gcGTt2s+EzwJ2Uvlb66EJFIrDczTUUdDsSA55OFs/PZeqw+QqeFASkRoEAmb?=
 =?us-ascii?Q?5Omgog8PamEWJj+IBqv7GiJ2frZC6OmoFE6TIDibiUmIfv/e1+dZtZEYQRUf?=
 =?us-ascii?Q?e+2d/xYhJUxx4L5KpFoBGrxJbeb5kvHdq1a65ZFpp2/YZnydGzVD6PGJoKii?=
 =?us-ascii?Q?5UrIpEodZyVIuAw0hJeyw23CHm4vPni44fyUU0LDkkjirOYYthfRo+tDNgcn?=
 =?us-ascii?Q?nM3hmJnJhKK6xXyJCDsvqf/tuQXU0juaBVhF3+EZMIy+pkViANH+SjXNNx4b?=
 =?us-ascii?Q?YQSsnRCiVYT+gyIrqJxQlinp4iZOabrCA6aeOgRG959dF7OpyQB00MgXEAVq?=
 =?us-ascii?Q?BRm67I7LSXcvO+KeF4jtVETjlkWhdntJTsBiSHTj9MVUghwiV9m4jIpW6Amu?=
 =?us-ascii?Q?CifCsQu1aIzEpRwMBoZQTyDtegeCnMI/1XMhoRT+1kCciijA2FSnQwfx0/vU?=
 =?us-ascii?Q?oKu1VA5Itaj2/0v45FI50+Q4Pu10nN69fx2BRqecuonVN/H5wjsYnbseqVai?=
 =?us-ascii?Q?wBX13wq8wdTzkobq74nvZ7StPIPw4K8yEqYLQb5tlFdcYcR6CBasWNewMulh?=
 =?us-ascii?Q?KNlDjCV2BGs8FXmASH7Kfoluib1pksG15N0pjSdL2peb5Q1TFhgg86cV1+mp?=
 =?us-ascii?Q?SSegnUkeMeZ5jLLYRASxbShKAIz/V7UF7jOf2p541d5+mOxXUvKByUnS2YbI?=
 =?us-ascii?Q?qoD5YB1jbX6+NAOb5Lg7Gzf6UO1zaukSKwT1wWhu3ODH9aAo3GBck1a/EjXG?=
 =?us-ascii?Q?4iwixGXuPXHGmNDMXAENUIbaamYI8x1MwbNDwusUYbde8Yg8Wu7iLfJETPnf?=
 =?us-ascii?Q?38e+pB8iB4bKtLSzFne9VWxXx8G16tiL9ueH6evIBio0BS+T7wEQFAnlGoxn?=
 =?us-ascii?Q?clLT6TVw0/zlOjW5wsxfa53GZNcxKFpSBYPqEBxQx1KR+CA9bhsOzc5owhib?=
 =?us-ascii?Q?bhSLB8vnM0FChtzzQuw7pVQ1JDYZ4RycZbQgpHnxjtAK/el/37WoiEN99+OE?=
 =?us-ascii?Q?DkppPy4lI1fn+K4R2KCD+SeBelJ5d1/C3Qs3ZkksyaAYZwAev2LmDvaga/q1?=
 =?us-ascii?Q?pCthQQZtgqdk225y2BwScZUgk1F6/DYOR1Y0Fd7s0UZXOLArEriX658pa87Y?=
 =?us-ascii?Q?lPMiwPiudBVyXRFOvYgBTKl7iJ094KpFpun0nGnS4I48WXmsa7M+ik/pPgM9?=
 =?us-ascii?Q?8jXMkBYFGuqzutc6qbPneeQMk1eCfXSpxpOEdU8DbDGPUhdFxIQrH0Xnvlw+?=
 =?us-ascii?Q?RyP23c/K0CQ0xsWyQbE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f23bdb-85b3-47c1-1cfb-08dcad74691c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 13:11:07.2884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsRGfsr91lMbDFM1SoQQuVuyCyA0XJ6XEu53/nfJEv29p6Tcdai/bj8L440LdKWX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039

On Fri, Jul 26, 2024 at 03:49:49PM +0300, Laurent Pinchart wrote:

> What is not an option exactly in my description above ? We have multiple
> V4L2 drivers for ISPs. They receive ISP parameters from userspace
> through a data buffer. It's not allowed to be opaque, but it doesn't
> prevent vendor closed-source userspace implementations with additional
> *camera* features, as long as the *hardware* features are available to
> everybody.

How far do you take opaque?

In mlx5 we pass command buffers from user to kernel to HW and the
kernel does only a little checking.

There is a 12kloc file describing the layout of alot of commands:
include/linux/mlx5/mlx5_ifc.h

There is an open PDF describing in detail some subset of this:
https://network.nvidia.com/files/doc-2020/ethernet-adapters-programming-manual.pdf

There are in-kernel implementations driving most of those commands.

Other commands are only issued by userspace, and we have open source
DPDK, rdma-core and UCX implementations driving them.

ie, this is really quite good as far as a device providing open source
solutions goes.

However, no doubt there is more FW capability and commands than even
this vast amount documents - so lets guess that propritary code is
using this interface with unknown commands too.

From a camera perspective would you be OK with that? Let's guess that
90% of use cases are covered with fully open code. Do we also need to
forcefully close the door to an imagined 10% of proprietary cases just
to be sure open always wins?

Does closing the door have to come at the cost of a technically clean
solution? Doing validation in the kernel to enforce an ideological
position would severely degrade mlx5, and would probably never really
be robust.

Jason

