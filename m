Return-Path: <linux-rdma+bounces-3145-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FC1907F96
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2024 01:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E1CB20EF2
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 23:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFA614D6FB;
	Thu, 13 Jun 2024 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TPPZdJdw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F2A1849;
	Thu, 13 Jun 2024 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718322008; cv=fail; b=VIKI6WNjqQfZZOhbZpBsg4yU9b3sGijKhcvRFux5FXv2JcJ8RvaUvQ9HZ9sKPw84v74Hq6woT+QIqBTpZiS3t6hdQ7ubXdVy4O2Y4xZCshyA87b2KEai5ZRye55PNAA5fOdZw264NP3JAs/ZG8bBZQx7thUenYTCVupaOpA6s3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718322008; c=relaxed/simple;
	bh=/xCMdHYACpCUPYY+u8EjmHBdER2YnmpyDDryhJtjxng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XVcGU64+hLzsyA5xMsk8r4Dz8CY1BquVRLXi7jDodhyewyzs39eZChKAWi5uRbpUIRI6HswmJIqHFFQsRRr+rshOTDzKmIYcMP4vrYN0uNChlQ9wTE0+6OtmthR8sSzfchLUiixB8zyUTyFmrwHVEBFmeJhUBGMMp29lict0Mqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TPPZdJdw; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHv8XKF7fRp0fED8DXwaZjC8Kwmq7R3061OnC2RjITOuFFMjkvsA4M+ra7WvdK6I/YAB6pvgjabmyjgCFYLfCZakSRqLRh/RBpuBKgxUroAzvmD55VSj9a3nDGEVDijEN7zABbUXzTkMP8N0HY6h2B3M6fjx7o/gmU37cWe5iIf1OdT+51piLe/ruOn07cQvEzUIxguvmuYXDfsyQC20O9RotMChKDhguc+SoFpHbNcnboxuHm/sUTXALwISn/1xZXIk6qmonvFzR+HE2vcUxnOeybFNlXGxr0XP8vllPW5uKardFAnDN5P2onStCGy2WDRDnBJDurL5gsN2xck36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxV9YOW2K2GCQ8tByecgLHv0wOn8ukyOBTZbMd3kzPI=;
 b=A35nQyeBVOEIGlua8mpo7g+XITNT2vH4vupdSDqVOgK9wY7rrvY8bFPpnKFXKCFxIOMx6zzXS27lrNLvVsFtUnxeRUPoFh/AJl7Geb9sA/M1A+t5H86WIkfHBkqZd56SL4UFasx3Ua3XjmwcPqbB9pAvLDN5qFoU/mjfQVPRCnG/MmHeo7ZLNHvV0Ufuq1BFMRy7LJrsol800SVBR+vrX1rOutXY/rUVZKphAx0KyvMRFvyHAwpoLdTSYw6RaS/RkvAqQqj+l45FpYC6WKNUSHiBN7wdetRu/i6AsyjGhyCFYK2/3jenaxArhL/eO0DejnLikWPNdxdFjS+JOPY4lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxV9YOW2K2GCQ8tByecgLHv0wOn8ukyOBTZbMd3kzPI=;
 b=TPPZdJdwBamLpPPLLX+miYkSWcfjadf4amRjY6M8iNCTDXqMmAgfR3oVPvW0BHNWO8yd7Ut7SaQjmMarSI34rVCe3h9OXGo/ky7Ur8NVzNt2tNrivqGDfI+1rI8yPLJh4lPT/IiLPCPH8MiqvGKOdoIyb9JhW1z0kkdugekM3ASiHyALQMF9FmFr0hVtrMgPmeh8NS0dvwKdpVGWkA2ApBGZDOxjjyIhnrFwMd8QmVelFbMGdpWBaqc2vVgidiu89XkYCfZdXVW4TLf8WZGDzZ3TLE2lve5Imw3Bav3pWHVdi9hPah8qkD6lfZcWs7o3i9hsDnk0N0rQMgvlPekIFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH0PR12MB5646.namprd12.prod.outlook.com (2603:10b6:510:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 23:40:03 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 23:40:03 +0000
Date: Thu, 13 Jun 2024 20:40:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
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
Subject: Re: [PATCH 3/8] fwctl: FWCTL_INFO to return basic information about
 the device
Message-ID: <20240613234002.GH19897@nvidia.com>
References: <3-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <358d2e11-59e2-46eb-a7f4-3c69e6befe02@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <358d2e11-59e2-46eb-a7f4-3c69e6befe02@intel.com>
X-ClientProxiedBy: BLAPR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:208:329::15) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH0PR12MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: b35b1080-5be3-42e1-550d-08dc8c0225fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tG83IqpMO/xyp7T5q4vjSfVY+uPf07QWANwwEEZnZgJqUsDneZ89F338p/y3?=
 =?us-ascii?Q?tJuoAiSt/arJ+vPW7uS96gKdQ7HrcIJAIlkT5y2TxqZl8DauKhVMOylp+UJq?=
 =?us-ascii?Q?23F/jIUGRtGRDifi5s2Evee/6H7IP10oMUuFXnlP/L46MhJoqXLN2KZhaL0J?=
 =?us-ascii?Q?+lA5hNLVi15UFCmsmqCZ1YWmpS+6m1GukTPqexrbQej4+5ZGwY8/114XLg/f?=
 =?us-ascii?Q?Mv/UR6z7/wbynmnRiDQ77MfhbkP5coKBonwfwJz0uT4NW6ELCst7atpcVKsp?=
 =?us-ascii?Q?X816k3/gNTtKRsHzSENFYA2gajQ8DjNjn/97xFDSemEpvjqrjkXQ/7sEpjr+?=
 =?us-ascii?Q?4j/SocuoMKhHpRIKucjnkYrurXM54rEwtaGbcnq2b0t4TGok02r+QarQ47R1?=
 =?us-ascii?Q?7/7OxkMDNO/eOHPa4cMlRSgVUsCwkL8c5vKvkF3/ydGju/fRKmzBDG5NOzGF?=
 =?us-ascii?Q?wEGKaLDqJ7YpLSyxoZI4hZyD2yRUZr2YYBnj042kYQLXEbgioKXBCtlpA8hl?=
 =?us-ascii?Q?zaNbx7ULiaNon+s1Q4v9WF6yFAbQEttFuBjVaKu8+ZwbtfcC33Q0nYOGetk+?=
 =?us-ascii?Q?GGMBpC5OM9b+fDFl1RHu4V3pLEQdiCe0Xu3DzE4QPHStDD8Qdi7jzoeEOAOH?=
 =?us-ascii?Q?X636/Tet+Zjy5AiQrrock5CmcFJmfmocAbHSl3FMUJwDQIQrep2ap3V9zGlN?=
 =?us-ascii?Q?DM7mDHrPcrN8JbAGVa1fOgCK7+SUqb+KQB+P31sF1QddzMpifvVHYP/xdWGk?=
 =?us-ascii?Q?Z1YJYvegU8fiWtwUAP42/c6wPXK0kaOii0RU0e2xYbYTpQsP8OB9LHLHqnfw?=
 =?us-ascii?Q?Z7mDCTwTQsrBB189LCb1OOUQ/EYoRvlstzPe4//nkHnr9t8LeOnf5Pn97T4/?=
 =?us-ascii?Q?FlAIAWslT2WUfg+o/ppBhxLiDB0zatI0LY0xoZNG2rKbdOMj/FhwvFjlRArA?=
 =?us-ascii?Q?G3HsTYi4wwKc7XlasmbjRIuSZg/imIZa2RclNbnpEi8GXu29572k33GgnLw+?=
 =?us-ascii?Q?3dZ8Iw4hf64vYw3ahrYKmFksv1wTflbiIqk1oajZvdgQ/7gbZx1rMlS1mYQW?=
 =?us-ascii?Q?jucdqslsGGcjPPdaDZCMpUK/8FzOGZf8iZ1Rq8S87OS1T8NJgBAn/cfUy5uD?=
 =?us-ascii?Q?QT1VzpmqxPujWyDeYJUYy93ghNxyiK+G34cIA8Ky+5fAwohyc99kkWEZZ7D/?=
 =?us-ascii?Q?/axAuVTp178e0OGOGQTZzYeYJKNfuJqxnKEbR1Etxe54fueWFRNiGEoQbXd7?=
 =?us-ascii?Q?8dyPeH390NpKnF/HvfTs6qA6o2bnrLc+NUdS6YyXMwfy0d66tYHg2MQ5Hgyz?=
 =?us-ascii?Q?+lMcYqscK6CZCyoKvz2IfNz4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XZ7t7gLZ8uKAg5XTV+28mt1JY//eHKTYZqqfBUpndMPJtWsKH6K2O+VvhmWc?=
 =?us-ascii?Q?qeeVT7YCcdKXBgBzAtsOXYdzEsxFpCkytJsqqza8MjT1gUB46ofRpFJBeJJ7?=
 =?us-ascii?Q?CTOGpnXP6S5miZQhiYA8J2GaCVrla5yBvSUV/AfgbsLxjOsn2B2jxyFJNoa8?=
 =?us-ascii?Q?vYRCNgQuL6A+Brtjmkgq14ZfD7A30vWjHjmkgL3U4DNbyivOjLd1E0zh2m6B?=
 =?us-ascii?Q?VnvrbFGDwDumDbBb+/V3Y1Jz8LPm4W6joIvsXma47lJM5xnx3662VlX0fgtq?=
 =?us-ascii?Q?cFvTAnrbOIBcZoLlnSZvTOESzS0xv4IKGpwdpRI81M5Gj9TKxkqtIxeaCShH?=
 =?us-ascii?Q?o3FuisDdcN4XEkXNubptaJL1Q2WdwO5pNzMWwQ0GfO/t3R9zOk7/RZLLrAwe?=
 =?us-ascii?Q?q+XviXgN3PBXxuqPh3ouZgF0MjGG09KSNrb62HQMa3CRMRwMMDLnudHhMupL?=
 =?us-ascii?Q?ENhvzuxC+mdHV0ZoOVid/13JyEsMKWzuCHZnIigly5/0+33zd5xHe8sSGWg8?=
 =?us-ascii?Q?Ah/3cp3UZipFYSH7gcJNqcXNXBp1/fR8tBLfs9HeTgeZvWwESrilR6mei5ah?=
 =?us-ascii?Q?v7flbekPldoqHzKOObcMEFutgw1rXdmeiZnhaHDo/pGtFFJ2s6jVJ4CS4ux3?=
 =?us-ascii?Q?ZRWNVWQT0ogwHPSLORRaoPu1OLG/P7gXnQJiZ6SK/7rh5yWRKC8SUDFknm8r?=
 =?us-ascii?Q?lutW0wQzaEw5AI/+U3AWW/eoYnWWuq2EwJS7v3Zg9AnxbW+N/D5/juwMp5SA?=
 =?us-ascii?Q?efDWSi9JSrGTtOGQ8wZBdxJhiVXrXLL+8ysRkBFvRpn6n9toYsaKQETcE1aC?=
 =?us-ascii?Q?CBU5ooZAQ62eMHW4PrIPAkr9U5FDQHHBgtrR9RTRhohY0u8bi8pBMuGyLnAX?=
 =?us-ascii?Q?XB8AglIldm4TQlqDHv2ZRRMCn+ARHQ9QQ9eEnsP94nBL7qJj/HyHTs2L8IZb?=
 =?us-ascii?Q?bqDeORN+AufU2Udak2hopGR56DaQON4M7PVsaOurGuu+QrwS+PuVrQnLgaqn?=
 =?us-ascii?Q?ZQAPSNMWCXyDWeU4ggUCriQqA5DhoOdz4fyuvkSWIQif9kw7lFPB0EY7kBLS?=
 =?us-ascii?Q?HDg0M5gizcQ0XC5mZ+L4MIQo6psIwmK/C1iZcXSECXuOwP7dxgJSdWv/ynGL?=
 =?us-ascii?Q?UiKJa5IILDZNHhZMXSRgUMXpx0sNxS6i8r3G02Rq1cJ/NAueMbsdgD+VL9nH?=
 =?us-ascii?Q?DQdMt7gu7YFpFNvr8IEmYjUQdkCvQp1dyl8Wq0ErICRVrNA/3bBqQKBgmZ44?=
 =?us-ascii?Q?0EcP7GGg6NQzqtx83DzLfB9tD2bnIBhy/fxVScUMpfoREYjUIALHWAyhjosk?=
 =?us-ascii?Q?yS90Q2rNKbkEHdhBbJoH8dQqc4km4AmP/jfz8D+2yOqmVYRfnt4KJqQ51/n8?=
 =?us-ascii?Q?0CmHMLINtyn2RvVGdAnuWVKYxy3/zv7uL5+zadspdKSBYabWHbHHz/huZmcH?=
 =?us-ascii?Q?1ue4umhYgn8WYF5xenxXxLjmVYDmcSojlaMWcAdoz0VPgN6sKVtjDExcB2KP?=
 =?us-ascii?Q?K18zDGSv80bi7TnclwyW6s/VLR10m7qyTUYjZck6Z76xOtFBsyiqjk7EoVth?=
 =?us-ascii?Q?KjpmCjpp17w+irytjEoTW2Je7AH0eOBqaO/MHUT4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35b1080-5be3-42e1-550d-08dc8c0225fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 23:40:03.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnamtJQKjuU0JA2MytgDr9B8FSVavi+RK+07rrPYs/FZdvLJOzRq5wpMaWOhI8a5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5646

On Thu, Jun 13, 2024 at 04:32:44PM -0700, Dave Jiang wrote:

> Are you open to pass in potential user input for the info query? I'm
> working on plumbing fwctl for CXL. 

Neat!

> The current CXL query command [1] takes a number of commands as
> input for its ioctl. For fwctl_cmd_info(), the current
> implementation is when ->info() is called no information about the
> user buffer length or an input buffer is provided. 

Right, the purpose of info is to report information about the fwctl
driver. It is to allow the userspace to connect to the correct
userspace driver. It shouldn't be doing much with the device.

If you want to execute a info command *to the fw* then I'd expect
you'd execute the command through the normal RPC channel? Does
something prevent this?

This is how the mlx5 driver is working where there are many info
(called CAP) commands that return data, and they all run over the rpc
channel.

Thanks,
Jason

