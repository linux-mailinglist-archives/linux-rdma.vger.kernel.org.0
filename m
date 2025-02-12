Return-Path: <linux-rdma+bounces-7683-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15133A328E8
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 15:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC653AA801
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 14:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B319C210F7A;
	Wed, 12 Feb 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Obj6iQeB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A920E314;
	Wed, 12 Feb 2025 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371420; cv=fail; b=T93/t6FL5Wd04N7maK5viKKnB2x5Shb/LlZnALXDeGyuSSZ7epxJj+sJE1Q/BzbWpYqQaEq1gTPhvrCJwuOT7pXTTzrI+iTUJHVAl4OwTZbP4HFECvAIFlNK5KsfHreB3oymtYAmlx7pqTEpDfDQUSsqfs6hbUWei/YmFn9kwLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371420; c=relaxed/simple;
	bh=T0wk86g8c180IwI9tVdYHSJI1ibZQjkFDjBrKe6SLsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TenKHt3L5CcFtS7n8uc3nr/+2feQD1mGV4pw3m4ow0ae3R0wWZPCUCyG87x6hE6Nis0A1wuX7cH/VISztLbleBlq4KvFjrNZun7YbefVsfnnemG4nrlecA/VsYrUDetTSgqqdKpxtuOLpp+t0EQtH3Cywk9gvF1As4z4opUz/+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Obj6iQeB; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvYDm3kpzvruCCVgKVEb/4RYNVTP7yq86Vya2dv7xD7ySbDpGi3/qN9v1WSIEdFUSoA239YrEdt+B+SpI0Wwj4iw6Cvhuy1VnUh425gKsJaPEU73KOB5nKa3gXgE3BENuHnpdmRJgANTx8NWT71qBwme5dGvUIsy5fbHiKcJJcCes5ekcFKUua9EmHhs7pr6V6Tji7MDqARo00Z8GWoXyb2F4u3qu1RsIvX107DehJdqbjVkAzfv4CdA/wEXkBV3/VeHVwpFVEOSDNaRZ0skXYCGwtUQLQ1FV8lQ1/RJDQrykY6/coMnZDPMk5HiRLZkdOG1O+bzfHzr7vFaWeOc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0wk86g8c180IwI9tVdYHSJI1ibZQjkFDjBrKe6SLsI=;
 b=yCaeexxlTorGyf4vmdywMh7osG7rjV9Jwks1KyFFA8o5AsKYCD/+xLTtF7CBeQCApIag8IxMpEWlBX1zgj55t8vxajQCnSkVY44FQ887UqNpB+1DMN1HCwHQbMLRSykaYH1CcpFnxLuIJ3BmMwQ4bvhMsBtpOcdZJKR3pXwPB/9lW/wG41rfse9nCphkhyvtdoyWtHTe2lihUQdJBKPlxx9uotgopPVvLbrnoNQOsOw4n2f05rFPGCGIhR11U9RDTsNTlhGklAuCTaZ6J/4CH4iwKQgjQLMasSLBM2dAagBskPnEQSHBioRBxZAZH2X4Dk5mxwZ7yXA8+S1v3vVK9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0wk86g8c180IwI9tVdYHSJI1ibZQjkFDjBrKe6SLsI=;
 b=Obj6iQeBuFe8QrcKQiDjv5ojcDHuTWzNckrioPrBIl9MAsLHV9yucXdxfRv58l6o5SC5UYX9y3EDs8NqdaRDI1l30yAzEpBOD2cC232fhfy3N2i91E7AtnyO4meImZZ6/IiVbMyz362ooRXkDBIN3N8uLlIVI4/jG0Z8iNcCBokqwjQnuCRZcL60HYjkSwElkoDxZpZDDf5RNoXvhofLvH/i4YgebkwGr7T+A4CcxyS6CJNTihyQTIAvX+5+EVZgJ3CNMcK4llBIKazfzgvu6vi1p1m0PMknCr6eDXy9KKGcgTfD/teDF7qGBMUWsop2m4TrOJPtuq0r2FsmB/HfLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 14:43:31 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 14:43:30 +0000
Date: Wed, 12 Feb 2025 10:43:28 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Shannon Nelson <shannon.nelson@amd.com>, andrew.gospodarek@broadcom.com,
	aron.silverton@oracle.com, dan.j.williams@intel.com,
	daniel.vetter@ffwll.ch, dave.jiang@intel.com, dsahern@kernel.org,
	gospo@broadcom.com, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
	lbloch@nvidia.com, leonro@nvidia.com, saeedm@nvidia.com,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [RFC PATCH fwctl 0/5] pds_fwctl: fwctl for AMD/Pensando core
 devices
Message-ID: <20250212144328.GB3844591@nvidia.com>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <7a9d5e34-4a1c-4e91-9a25-805052ffd73e@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a9d5e34-4a1c-4e91-9a25-805052ffd73e@lunn.ch>
X-ClientProxiedBy: BN9PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:408:f9::6) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: dec04216-7be9-4207-f426-08dd4b739e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lIYlduCUVW7yA04ryTAaIuXtPHQh0bLZc44SJ/n1B9naEaIxjQpuIOBEvTVV?=
 =?us-ascii?Q?Wpxc+kgj1hbQg9a03svQXQ5fqiHdkrvPewp9/pqoa+NFoQP44//RAFF7vYmb?=
 =?us-ascii?Q?mPfUYt6C90NyrGKNzdG+YzGWj/1C5kXDoXZdNEREkoPbWyUJbW8HesOCTOR6?=
 =?us-ascii?Q?pD/hpDqRuG436b20kgunqn9ANy64Yn0v2cCvdRk/qODUT1+w+8BSFGv+haAz?=
 =?us-ascii?Q?PDhjdFMXovRmaY7S2wFAVYsSaq023FOzDkEGEPE6OigjOyuP++NS8yzhszDy?=
 =?us-ascii?Q?V0ZEPFq0SIJhS3WBFPsvJBAjuKQoKp4ZIejJwYsDEJzrFh/DRped1cpkmCik?=
 =?us-ascii?Q?g4831BFuroSdA4IRgfRy9L0KOaHIUEHnxlxeo2jqbd6P7h0RFuumZm3v+aMb?=
 =?us-ascii?Q?/YmhfuHO7XrOAEHm9OX2/szdtYGRzcJUJrkisVQakX+rWWG8clvI/lZHHQ7K?=
 =?us-ascii?Q?fu4044D/U0quC0WfEzAuBWzk19VRXphi5P+rIth2Ue+eC/XhYHjmFwbS+M5c?=
 =?us-ascii?Q?z3pIs08YQ2cZImuMCUUNe/n6UJ0i/poAi09b6kud6FOVu6Kn9hX9YGpzFeI3?=
 =?us-ascii?Q?d9NLBybfUHu4Soi2qjXnOj3jQorYavO7wbhnw5N+S8W5m4OSmGPvB98qOV0I?=
 =?us-ascii?Q?ejAIddGqq0kWUcMC03+aA4AcP6VNjzxiwuxjePlCf4hW1LNs4RjypsDVccCz?=
 =?us-ascii?Q?g3ToinRIy79x71CeMkaoesfiuTREVsp0xF692HvnuFOK2kS8kP4B/qswhwse?=
 =?us-ascii?Q?cBSoxisGCq/ln3uxPHlu8dw5vtxTdpa87jVrtjcnDwutGU23Gl3x3Dh6wSJa?=
 =?us-ascii?Q?bqb3VRWrO5p6/djUA3U/Dd/N156sI0JtBgKfMsWuXOZYZ4Z7NW4IV/EsTJxt?=
 =?us-ascii?Q?VuciOYpsa3AXvhgntk7ob+MDz8cOKttTlW7gn8QjLmN27RYe7ncW7SBgtV7v?=
 =?us-ascii?Q?wJWR62cGd5iQN/iJJrs44UCCJu4/EsYXCZBptX1kstFd+hWGJ9qmGlPiXAdS?=
 =?us-ascii?Q?/LHkHebW0zkSkKfQKd8aeY7ldIjLM6he+jashr1xhNobeGx0+2RzrKNv9YYC?=
 =?us-ascii?Q?hpgDGYicsZkCdS6bdvsF6QsAEy4vM9A8ypjuzs9OK5/8pVojWSKApAFOf5yv?=
 =?us-ascii?Q?oa4NCGmJtbMzqc8kA7t79R792lH3Igt42eLJrJqEEQDEKWd259lL8FVPoxjD?=
 =?us-ascii?Q?xkKGqCUa/z1/l5JyPkjygMvwtPD3MwiAx+kvKPEbhIAlq3utUnos+ncu9E+t?=
 =?us-ascii?Q?+CA2DQoCZFst8t6zmfRUhg7EQZlt9TpOoQtE1Eum5wqxUsMu0fSsDLl/p7Ev?=
 =?us-ascii?Q?iI3Z+RD0IUrKhO+NGE/vr+RVBJsS0AaDj35kAWsjw6BOMTLbA9+qz2bD4VCp?=
 =?us-ascii?Q?1H79hsRmmql7T52CALDPGal7Cz6D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sHYrhzVXIuDuyWD87jIAec948gcg9FFApDkp5zvFBrIuntcbEbnqqWc/eacA?=
 =?us-ascii?Q?C2ykBHFT1mKU5RsRLVT7HP7hYjEa/eo/UpMbDRaPpvCl+VNAWl9g2+sY9xUI?=
 =?us-ascii?Q?86l7gCxJODU6E6SI+2qhfNCi4JV5FqbS24x+EMfG5P/yvIdcw4XcLzZNiIkK?=
 =?us-ascii?Q?X5VZJ7gKm17ajzA7nxshfSXjgQNKccNEK7PLE6RmGtQT+ovD54ltcsjGmsHz?=
 =?us-ascii?Q?oZEyZ8BpEItMBGW5fbWIY4xZniiFNIh+TN4naZ7QIjg8+ksaWebNKZvP+Piw?=
 =?us-ascii?Q?D92oYdIGWu2WA03YUKXtRXRERooPD5OoqF0rncKMFBLSdOVeax9wpn7Bfm/e?=
 =?us-ascii?Q?O8yzrsMuBJt1jKOIFhdjoMm750RNZ2EZ6tp5LxbtXAHUfddv1aixsuoXAGTo?=
 =?us-ascii?Q?xXUzVXBrt8iV7bmRZpT8ZObLoRwyaZ1QsvPJRJbAt+Jijy0IAoWHWVDCwq1P?=
 =?us-ascii?Q?J6NuLE/GnWRSl/FAZHDISiqAQ4QLCeqEj/aoACMDdHDrbLs5BhpBeautqSQU?=
 =?us-ascii?Q?NFXnqrBTpwq0nnR/WSCGdYjsrDDmpKJClvFD/lkLl0OSSCNfjslGhU8IxFEB?=
 =?us-ascii?Q?StW8EnMMkJu/nsx/Xxrw7C1lAWvgoIfvt7Id/K3zzADR6zHhrN39PWwi4slk?=
 =?us-ascii?Q?kGb6AgoHSMq5oKcuOhonerUv1rhoiFM/O66bM7XtmQ7SFM8H3g68NkeMSQ8Q?=
 =?us-ascii?Q?m7xT90pENl4PgKKRUVG9wnIlYceNcPQ4LpzJdMREVZlGEbahIxDsJlUe1ppt?=
 =?us-ascii?Q?Vd2kjeP22JfvPqnu/J0zZjXXscYdzmbWLYgbaockOGBLqgq1ZbZ40d738Szh?=
 =?us-ascii?Q?Y9awRz+/xMaSQWbiXMhE0FTqUdHJI4PhU4Op4L67N1V7sU+9CPe9ZM+hfQ67?=
 =?us-ascii?Q?E56boIdy3X+n9/Sf80gFR5KSg11L5Oq4gZwThbHNoF8H8CkXDV5qNKGZUrGr?=
 =?us-ascii?Q?rP/iM6S+T8k88s+ZSMEeNhrZsiW2t7zXqukcOuoDPSuj8HmynXFo974+8AwQ?=
 =?us-ascii?Q?JeazTI7g5J8FGALpZFqtKy2/d/Stshq+kMeKGw9KKxW4wLQvryTrdbj/aV+l?=
 =?us-ascii?Q?p18cpumPYH3urAOzu2HJl7FBL74ACMzs2sPCwO4FyA8ci6xV0AJgjN1YEW1J?=
 =?us-ascii?Q?4jNqwOB8MZyVIHoy8GdC4pLY/lSAy7a4vZOiJSgZcblCTI35WIjLB8YO6Ehv?=
 =?us-ascii?Q?gwd2dW0SGN4u36kjrhpME5A4ihn22Qg9TkMYTrz3rXKa4TtnlDRPpGJPxxES?=
 =?us-ascii?Q?n4LwD9y9CUAyGIlovTIVzbbZqH8vzW5/Th5UlOZnRnEXWVbMt3ef7IY11Aw+?=
 =?us-ascii?Q?9Yh3nn9VJN1O28kjhX892UF5ji/se3C+kHcsBnBMdh46SU30uSvJkAdVXBof?=
 =?us-ascii?Q?qgxIBI+RFqTeq28/tqLWZzximz4T4btT2INmDawdbTrAEpftVOr7OaBGzMlw?=
 =?us-ascii?Q?4hskN+EWw2hhcL55Hbj3r9X2gvtYZRf3lDAYQ0sfoMy1tSCi9bPtXDPoHgVR?=
 =?us-ascii?Q?mOQQZLXbpCLiCB3MheGyjTE0PjJu19wtR4MsUfpWmVbFGu4W2PJyAPVY8k2o?=
 =?us-ascii?Q?c/dlypQDrj7cob1EDvI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec04216-7be9-4207-f426-08dd4b739e2f
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:43:30.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +t1cVABFyvUAZCXuD8k+sb2nJQAwbKj8yhA3vABu+q7HpP1EFh7HqRhvy7SdpoF5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621

On Wed, Feb 12, 2025 at 02:40:45PM +0100, Andrew Lunn wrote:

> Isn't this even generic for any sort of SR-IOV? Wouldn't you need the
> same sort of operation for a GPU, or anything with a pool of resources
> which can be mapped to VFs?

We've been calling this device profiling in the vfio discussions,
generally yes the general idea of profiling is common, but the actual
detail of the profile is very device specific.

In vfio land we think fwctl is a good choice here. We already have
things like libvirt and Kubernetes that have generic userspace plugin
mechanims and an existing mature ecosystem for device profiling built
up around that. All sophisticated devices have their own plugins
because they have unique capabilities. It seems to be working well in
that world.

From a kernel perspective fwctl is alot better than some of what has
been tried so far, ie various vfio drivers having questionable
device-specific sysfs, and then a libvirt/k8s plugin anyhow.

Even the better stuff like mlx5's devlink is only partially capable
and the existing mlx plugins still has to do stuff beyond that.

The kernel isn't the only point, or necessarily the most appropriate
point, to insert a consolidation layer in the stack. We don't want to
move chunks of existing k8s operator code into the kernel, for
instance.

Again, this isn't an exclusive thing, that fwctl can profile a PCI
function doesn't in any way exclude other kernel options, like
devlink, from doing that too.

Jason

