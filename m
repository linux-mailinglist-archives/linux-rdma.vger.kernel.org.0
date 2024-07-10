Return-Path: <linux-rdma+bounces-3805-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE2392D5B2
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 18:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E531C215A1
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 16:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD368194AC7;
	Wed, 10 Jul 2024 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sUeFMyQ7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F9194A77;
	Wed, 10 Jul 2024 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627485; cv=fail; b=GGZN4OQBNOUkDkDx89zNJ8qOU3g6BU1YqNtWrF2IsRV1i0/lGFtE242KEE+AonloWIrZODCsJZFsnTsdlE4yN6SSN6jz9wXMKvKv4KbXTzqXfL+X0+HKPLEr7We3oooJtaqNZNpRxxqsRzngmsFxIRWjZW6XbwXKsIE3lKR0fGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627485; c=relaxed/simple;
	bh=QYN42wATGl/eGzmF1LurJG+61Y3gmhxbznDc8VhOD8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RU1ESfqXjP2jgKAPsZNfrS1R0Fbn4zhZrnoHKKB75vdCC9Ytl3NuQfdeP4LwVKuavfecI9OpEcjaOyQ1/X0DxwPWb76kgFqfKgACsReKGh0t3cZLwH6i4/IVbWKre5OsvtNPzIc2lfYd6KZYIrXkzG53xRV9S9aKD9b9V5DSeW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sUeFMyQ7; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgY5juKOaV0QmgV2j+SDRva54Yw/HndyELuDPVUmmdpw/DKaKiKmzhPeG2TlrL+xmOqSIw9z6S+ReOUuRiwGpcJTSSKu1o9mGa/NU0/sZWIg6NBnCM+ocCDbmVCgWvaGV6CYZN0YsHCBYjlnDv4kU2inlCGpS7PHeBGjpODiFRzX44FNOBmFREwwFfX5KDce9K4itY3t+d6h7hfQtbkuaSWd4Pc/rki/k8prhwTrBHiDT4L4LKiCi9MDcHPHyQu+sHvOjkDfz2bYqJ2y/EBE3WGqrIyj9FyHbDrkwThrBsbkOrtwF4BE3KqGnfgvLvdlxEA2ulDs0CVRbxnD6dZLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvYcWW9xn6XxgOfFu+1G3E+1tRHOVhY3SMP2299jZpc=;
 b=cTHc7yp7EwmvO7LrjhV0RsBCuAqxVa7ABmCxx/ima3Jp2zg40Me85QzrbmUCXQlvIE/IfHRpdL5ZCDQlFRY7DvsKYEJNvqjQLU6kvAgXhmxmV5Z4JhSesouqnOPG2ovoiECqqEUaujg70FRJihCV9x8NZLpCiv6c/o4Za1StgJqWuHpTurqPtblotMx18e3dXHy7iXVLD8YZoQiE6Q5ahzXOEMpaoHpBWnVWHc03w7bjwvTQG/4YhHHPthTfdZd1t6+Yse2xvnI0T0xyb/ckSMdpZaKsZ6lImNKmKe804mgjXKwt5D0hKxgVOEkY+wdaxZe03wAq0p7WMQTHgJ+A/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvYcWW9xn6XxgOfFu+1G3E+1tRHOVhY3SMP2299jZpc=;
 b=sUeFMyQ7c5WUe/uALjsVjeY/7e+b9lTVwxfeso/ioN08Qo55tvOHu/VkUsvcY9gMMUb/RvSofKqtN8TPk3UuJPLntw6WjsDyLxRW6TQFZckvQzv7T1m1XqGg19pyhZezMBOROUEF/s65iqd+s11AsrN34bXcH+9jBxW2tImpQt2I684WAOXav/S3N+gUnDy0WBl/4cI5Z6cnw/zddM1OkLvj7xzPyWdviqn5iU3n6JEImbfZMsQcsRE4MV5fNZxW81bu8bMQUWpU82qsG01O36AwHYKRxE3+9KvmwIWUey0L8CpQAPj5T92Hbb9lpxgV8UDCzjZzwNK6C4WiXMpykg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 16:04:33 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 16:04:27 +0000
Date: Wed, 10 Jul 2024 13:04:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 4/8] taint: Add TAINT_FWCTL
Message-ID: <20240710160424.GB1482543@nvidia.com>
References: <4-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <0120d73a-0d15-440f-99bd-4c3e0a925183@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0120d73a-0d15-440f-99bd-4c3e0a925183@infradead.org>
X-ClientProxiedBy: MN2PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::35) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ0PR12MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 6706e759-bf75-403c-f11d-08dca0f9f944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uF2j2hQlNZK8BDFDDGhfok4Q1bOKy3lFLQnQFCX9u6U47AQU0hJXPtlaIbDd?=
 =?us-ascii?Q?zFVOs+JY0V3bSOyoRjRa+OEMtEAygYbcwdLEEHRJmDB3W2nb/L5wn4B2VDIh?=
 =?us-ascii?Q?nNdR7IX3FTqrwaXioP0jsR1v4ab1jJx0ChTYK3H0N5z2A0yp5WuUJhiqu2lh?=
 =?us-ascii?Q?v2nfiiQR2S23O8eV6RUkzZ+LQN8oYEkwROfnI/pdYCbsI8hv2v3fbioc0b8m?=
 =?us-ascii?Q?/Tnw3YLNh9TPxtuxFnl+qj6GZgNrang0uoNZS6azBieu7BbNrLodbqpcXFNB?=
 =?us-ascii?Q?MSX30voaWap1o5529Tn/4znyFMvSf+j9IKKqqfNwqqKwA83TXL/yLmKeI1fb?=
 =?us-ascii?Q?4om5SSwLz9D9j7P7ZWgeMsLqIK97H4foi1RODFtJh4r7pdOBChuF5SIXaNps?=
 =?us-ascii?Q?uqSCaOYQrBYa66a26zhphkpEusN48gw4f9BgkDb4QpDrbQ8YptZ427s/1s3l?=
 =?us-ascii?Q?k4TMHX6KLsdhrMSiajbLGWUJprqDtfTNTtX5jZej+G/DqQ+Rw34FqDzLLFxf?=
 =?us-ascii?Q?5srnoMD9dQuzxJ1jUXXAH7ep5yxivwRBfyjBXUhOIEKLTeuE0jkT42TBmG4g?=
 =?us-ascii?Q?QQrQF756AMSRiCgqpfCvTBZPwP16j/LKcJaQ+WXP4/EZQQjHvXqY5ivFoiLE?=
 =?us-ascii?Q?8cgY/BWdTXlyzKhDEtXHx7XhDzTaVLAyRZDm88P85EYYP/e9Khhm5SC/fg4O?=
 =?us-ascii?Q?p7bQeRRL24NNwlPolukQGcxMqUCk3uLT6K6YX03Pg6CHFViKQLjS/HTHMkKB?=
 =?us-ascii?Q?YDKNyzqqYbKYHWHpEiygozGO0rcu/WtlrQhOdXG/JrgxeCvyGB1yQ7leMlDx?=
 =?us-ascii?Q?9K9YVCkQShC/VTX6rzLHbz1bbVNOyc/R6POe4KSv+ITcljLG4ZD7DaQ+Db6c?=
 =?us-ascii?Q?D337K0DNJYZH4lRpOk654w5Lwli6dqGYWCkz7Ma8rA6IdG8vG2lsQInUiOus?=
 =?us-ascii?Q?xk4v7fwguWIIMw5gj/yWyWoGBuUw0xfs7N9fpI3oP0+aSZKc5pl5SSeKpVq+?=
 =?us-ascii?Q?QtXwMFJC5EZh9EpGmpIZ/7HL/Bqwq+LJrq+eWMMkPp4oDeYs9geGufPrpLJj?=
 =?us-ascii?Q?yiXcHGLj6EbwFicLSV4/w6vKQxYb1smmMl3N4AteJw8rV3+16dYJdeOeGN1H?=
 =?us-ascii?Q?4jA5+NAmkJ5ofYWxWJI0cJCckepppO4qWIzK2k+QVGxr7uhQvrO8aw/TiXXh?=
 =?us-ascii?Q?Jd7XSqFFR680PHzTfAyRi6SCRYpJVG7rQOkDYdynxsx7J8H/f/1AASAcJJYx?=
 =?us-ascii?Q?W9ie5y3F5bbLpBvW5gE8CiTBkd+KsyHKy+IMpStM5RpyFuPJmKaBx5eJXajU?=
 =?us-ascii?Q?WTCoZNyHTok2cH8wPjwLiQlTe2ZIGb7YaOZGuwP54/+aLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VzuU8qN5dJz91eS/RVnzXpAnTqS/n/UXhKPcVEk/Ctbr/avGOT28oAJ7kwIU?=
 =?us-ascii?Q?NC/XC8XBrvIU0BFo+sI5FKKUtYv3jDgLIsDx4HSoJ5Y0fjAVPfmBBsNENOi8?=
 =?us-ascii?Q?4cDpPulEb1qwN3BatuYGuR21V3Amc0DVUvwvST4JCHrb0dUN1ZjoTZhTiHJS?=
 =?us-ascii?Q?J1CVYQjXLATZCZAdMNKSTxmnznNTCn4GikU8gO1h/mpmU6fhC24BkNMcOWqk?=
 =?us-ascii?Q?HiWXJFH3cuRJbGN4cNiAEItkH7QDgRZ/oghq5ZdkF3uDTDuVzac6T8JUfM0P?=
 =?us-ascii?Q?qMXcK0GWHNm70o++a/PjWw4MVTNewuNZqFfpFlIQeFx7p6KwNY97DQZSEJ9M?=
 =?us-ascii?Q?4dBj7vpSyIq25I67EgG6ydwxEm0JusrNO6PFzytVxBPs5QI49jYLneGyEKzZ?=
 =?us-ascii?Q?N68uC4ilDaqHonkd/Lc/9ExkmIIkEMGr5JlUFsJxwVLoqtXjxqdE4Y5yQX5r?=
 =?us-ascii?Q?W90iEFjNwTkeNncjwxAz17WZ+6LVVkf9483RlnU3YPn+euTDGZa+52j+3/WF?=
 =?us-ascii?Q?7H7dxcDuVE2mAtU+0j3pO4WK6RZanYQj2xLPwK/+J2MZK29oXjZIYfxrpXbi?=
 =?us-ascii?Q?quOQB4qUbQbvjv69Ri099SRvt4UcDjO2nWYJsydsqQmNGubMVd80nPWfUun7?=
 =?us-ascii?Q?VKeKjxAIl0fO61JcX2OvNbltF4NSESS8RWAcn1FnEgAE8rOXKeX5/BKRPl3v?=
 =?us-ascii?Q?Y4QFNBYHdTkYQR9oDVsWT+7l4B8gTjNSJXTBYaTuDTeRkXKWTx+1Ay8rwLst?=
 =?us-ascii?Q?eB3F0jzPEA/NKDdGuRvIkWFKWl2SXrxhqFttV1yPJcBFm/+QipgbSZPVZTlW?=
 =?us-ascii?Q?eln2e4KS+qPbITvD5qJy1JXybIm9GL5M5E+eWC3ojfHRX0ZQr2x2kBqLxwNW?=
 =?us-ascii?Q?2LN0nDFmzqgk8cFmlzh/b1Iahn17sgTPCGbTPT8F1aB9ZU5FrZG4WOu1dmXP?=
 =?us-ascii?Q?FkNWcoO0PXOsb9xdz3OztaX64t636A5awWHYf2G2YMbil4zmAT5bIh5yWMXA?=
 =?us-ascii?Q?bvriGNdtD6LhN8S9iCvlq948fmSGHW25QhdJ0Aj6Z0JXaS1RGDsRWpjC7qkF?=
 =?us-ascii?Q?ANHohIrkwLb38zIxW4OBw7+mxx+6jwnizW4fabdI4TqxaeNXQWTvAp1uGxdd?=
 =?us-ascii?Q?n9f1uxx6FdbCCncBuDDfC0SsxE+DQZbbblFTW7c26jeb4dwYQcrk9z73psP7?=
 =?us-ascii?Q?a3ojd+1eUwsGhysZBceyFGQKpbPUtGjtGa1YUSORcIUPPMBNffnWTEkOuJUi?=
 =?us-ascii?Q?cwwRF5jTpKKFpua3xzsCU/xoIzW1f+zcg3YtX/0L4zem09ateeZtR9lVuWD2?=
 =?us-ascii?Q?CwgODyGFk1apghqvoW3tC/yQeROXoHFuZSWSNEJMJobFrMLeOUo64JltCMso?=
 =?us-ascii?Q?VfvC4gt3JPwoon4d9dY8rc+tXYXWMh7vo8N7/epz3CwGwDcZF6KAG45eqiRb?=
 =?us-ascii?Q?iTW65EDRdPNyqH03Ma+8W0gTI/9Kaakg6pKDX4qbjJPuJ6aPT2tLLLIkHWud?=
 =?us-ascii?Q?XLV3tMz2Nui6rTE+D5PLOev6321T3Dw8d+jTyZtHB+AuIgJDLejXZ5MkI5Yw?=
 =?us-ascii?Q?nyK6afnWHEGKoTrSKSQCyB3l7tbcexA5hLPdT/Hb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6706e759-bf75-403c-f11d-08dca0f9f944
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 16:04:27.0660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWJwpZksjP33Yqk/ecQivEz2U72ir3zQg5CM7T7vCyuDHYdaoNjBw5vo/WaOBpdX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7082

On Tue, Jun 25, 2024 at 12:03:35PM -0700, Randy Dunlap wrote:
> 
> 
> On 6/24/24 3:47 PM, Jason Gunthorpe wrote:
> > Requesting a fwctl scope of access that includes mutating device debug
> > data will cause the kernel to be tainted. Changing the device operation
> > through things in the debug scope may cause the device to malfunction in
> > undefined ways. This should be reflected in the TAINT flags to help any
> > debuggers understand that something has been done.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Please also update tools/debugging/kernel-chktaint.

Got it, thanks

Jason

