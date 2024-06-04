Return-Path: <linux-rdma+bounces-2845-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C15C18FB806
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 17:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4BC1F22382
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 15:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97CF14883F;
	Tue,  4 Jun 2024 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H0/JthRU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA51487E7;
	Tue,  4 Jun 2024 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516223; cv=fail; b=WZKvaWuh+9n1NMeYsDH6HHfAjbcMT6VfbnyNrbwnNIiyCF29MV/CwMdq+BPGJpCG7eI89UEL2N5li1bs47f1i9uSh/jvGNREGqYzhrBNTqBbQd08CePD7T5X+TFH0gPsttsuhsEdZH3umEmp+2P9Fj8gwoanV4OC6YvjV2cPTOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516223; c=relaxed/simple;
	bh=P4/J27uVQMz0gcbuLHtyyMIqL5AidUBZsyeKiYM9i4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jRpHpX+tT4p9OfqCo5PEa1FWzoQDdHp5PcjZgGWjenBVmQW+n58NiyJcYjqyujLjQt/GxxIl+qsxNHbK3WILhFK370g4M6lNeVMrNmEPGgTo3Y2Ll4N461cQ3YAnxAY8xuO4coEENumsntvGShadEav++E/U2DaCDQrxFI9TEM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H0/JthRU; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJdVgi9iGCQc/SPpZDjHqsdu7kjBS1WKVniKAQ1ZZM1zF3VeiIygkhv6DhEdvHU3O8Y6Hnfty9mZyN+pmEGnCQ6/ip6XGy+n5jwoLaRe+Y4YykWYP33IYsA96+xQSf3QC2GaBPl01NDzYUTb4BsD78ckTdTxmesLzWgcMqCgiaBEkvN7qd0i/4afUTiyd01rvfdX2gWteydv+TaPNhN0Yn7RWG5UgJxm4IoEQ9C5ppB/YDsZ5xoGjjrykxQdOa86px3OIAfFGMLlNeqAGGmENrN5XugvpiJPhbOvJmXUP0TcqqzY64oUbHgQnJAvXYhX09zTPZZ6Ub9eCUiNQK2bxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHqCcgwQcrzjVMeESMfBl3auqThfpEQsEYCxWo9nu/c=;
 b=Swq9Nms9BQ+HfZJ9oIvLeSAwBhVF06HxZsvFdODGn7tKHHezD6k5hTtB5AXAIUH9Roq4qM5ds+wsdifvRhIgurlVPuF8TDaeoHZxxgDFfoGTYqWptnX9QvOzdxJRI2v4odh95sJbxAbfenUsHsNnxOz04JsNVezounMwaRenqNlt2fsz3FYqUNtvI/xb5BWmgNCWn1dr5KLJJcR8K8TYJeKKZzkyou53qsS8I0vP1j3T3RLGBtkqt1h9cB9KDIdYqfAjpwEwBiaDqY96dNhT//sqF8E9Hp1WFTDthfMpQFeglL17x/ecl581EH/uXaJFfQehSD2POYutDZp09xXXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHqCcgwQcrzjVMeESMfBl3auqThfpEQsEYCxWo9nu/c=;
 b=H0/JthRUwvbaWWp2l5MrnpIdgR89hzUo8mg2NgZ1kj139xy3/OmyV58AczGbODRysVptk3vhZlXrlyaK2INJTWRR67jeesqL4gNZqT8Rva/SyZuD0kveJV3ICBtMDyBL2VnrCS1E+2ISMxhfSt274gRPwoC7nMEQWOeX6YHWQOOhjrjwGo3YFraDL2M4VGusxX5GGxEcXu0gYiGhLkAeMLefPpcNr6Ni9v8OXFOQAzEyVusv27+IWvGrg5SVUKnSM5IBJhNpzdODpu95VHCEoc+wd5lHJgX8XU6Ye0PAMVyws7zaFaElQeplK8wwShjWD3754ehuRLUY43LTfCpAmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 15:50:13 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 15:50:12 +0000
Date: Tue, 4 Jun 2024 12:50:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 1/8] fwctl: Add basic structure for a class subsystem
 with a cdev
Message-ID: <20240604155009.GJ19897@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <1-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240604093219.GN3884@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604093219.GN3884@unreal>
X-ClientProxiedBy: MN2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f81bbd-19dc-4ec5-1ebb-08dc84ae04fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8VZpJo5IoiP+zcrYFv0UPj34p7JMgOD31Ocqzg/GT0VcyRVMAVXmPBMyeoMJ?=
 =?us-ascii?Q?TBz6O+YNtp5NltlgtFwl4tS4hnrRIB1Y9b4ZsTsKuwq0airXW+fxXdgbmVOX?=
 =?us-ascii?Q?3Ytj5njgRPJkTWQHBVH0RjuQDl415aw9lYLOaECTs0f36guSEKqoM6ms1qgX?=
 =?us-ascii?Q?T86UQ2vXUS8znCI6sSMzXxwwHNvmaexYP4wJRYIaMaNT+3xKy/PrC/jVVNGJ?=
 =?us-ascii?Q?Ea7Bg9X4Sh8eQTibP7cYVIPJo6u9nWzjXUg8h6xsV86r6ZzFi7Lp0kxcnELI?=
 =?us-ascii?Q?EbjHJkyJNDMfQ/sxN1Oj6J99nHf0nq4U2hoj6kCJSF4psh2ojlMvFy92KUDi?=
 =?us-ascii?Q?R1v6aCBSPgv0XbZxZkoyrOH30vEcMkqDIevI1gIOCyE2c2hiunzR1DeTXeo8?=
 =?us-ascii?Q?2Twzu2sR3yxLvMCSyi+Tydqq3uMYh3IQUxgHByrlEYj19Qy/+BA4UfOuR201?=
 =?us-ascii?Q?uWeznmgq1YuaVwtcT0yG4Z3mN9oFBnoU2+s1BIAu4yKPUfFvozTJ1KWOY6e3?=
 =?us-ascii?Q?1oAC3h9XcAVtlg2Oyg+rYSPxKK7fKffCWYYjnyALIRuUovMObizsO2ZUj9PX?=
 =?us-ascii?Q?sY4r/URs8UGOqSSeV43YYyweUBCL2sc9tpoaBpdWqhbWKxfo3OrQXzODftkp?=
 =?us-ascii?Q?n72ADhGaWmqqCzc0S4ai7cn298Vyj94RxVCy3PX43FwzLjl4ASJe7+UEaofr?=
 =?us-ascii?Q?JNDjQmn//F9I/gppdzeArgDcxM1o5ycJ+g+3Ol6FcyfG/7dXU/ZE1fzrmumy?=
 =?us-ascii?Q?m6FT1OHnG+NjK5+1ZzPcrLPRltImeHGdfntkeGvXLGDDmYkveKEGOMUDpxDI?=
 =?us-ascii?Q?7bkisAL/BQN0oyfXI9kLVqKVmuZMIyMDesTiUAnR1rE0z3SB+vEtg/3ThLKX?=
 =?us-ascii?Q?fds+ekuKDJQ6aocxEyv1nI9F1TPVtey/w74xpYWSWV8qZFMRXpRuCgVYWYiZ?=
 =?us-ascii?Q?vg5EG8jrv5Ya1/00UAgnJo6mapRDhskRB1CTqr9pZYTuZRKb0yL1s8Qoot0Z?=
 =?us-ascii?Q?+Bb8/ldO+fflL92hiUkfVPTKgsGCHpx84/0al8UyC9bRvihZyTc3gAIxedlG?=
 =?us-ascii?Q?ggAa7GNvqgCTdtXZLXYwYRSemtms5HaPyxXsQsTXIvqkYhQevSsta26381WC?=
 =?us-ascii?Q?4cy+WA0fFn0lakiuAWrJ26/HI6pbg4Z2oRZeTEm80khsWCqbXvu4cohj+QQF?=
 =?us-ascii?Q?hHW1yAS9dz1iHGETabEt5DGpCLpCYxZJYAQJBlv3yKPlK7/hUlduPDVjnS7w?=
 =?us-ascii?Q?CD18IzIovWRhnYW13ZoOovMr1tad6WRDje/STI+fgQEtBvdJKW2wDIg2jqYs?=
 =?us-ascii?Q?ydYKrWOZfbDa44h97MCjzOV7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+8dyNJUM3Snf+96Lw/EuuSpPsdykXnyw4PGOEPrFUZsoxPO256Gq6OJuV8j3?=
 =?us-ascii?Q?A5Pnukhvy7Kh8emDgdWIXDA4F9bXgs7TGPaWGtFQ+yylyEMUiKxL45jD99rZ?=
 =?us-ascii?Q?g1EmbSme14y7fwodJSLR2nDDenunu4eiKLxrDmnGnr062dICPsYd4OkvEDW6?=
 =?us-ascii?Q?eK5hnBhCa0dtbPSiR3dUIuTdyq+Kt3gWEa6Jdnieb2QC8cTRxw/RYZ66N9pB?=
 =?us-ascii?Q?+mY+CWLL2vsH/LYWDOpB9wTp4MGvpOn3n0z0xoXzcloB1A1JGex7i5jyE5xg?=
 =?us-ascii?Q?fJJIieHjj0iIDbVKYvBmZQGJmjnLC+BjgxIjaSdj6Da0wOTPAVA99olH8DdK?=
 =?us-ascii?Q?FrCcwbofa55KqGx+tZavNxCDPHaaycDzUxOpY24YT0HtgWW2Qfr8MBUhIYkC?=
 =?us-ascii?Q?R8cSDxn5yTRslyhL5BQCkrdEKUCmz7u/vWRz9p7Jm13GLqpBwGbOBYuPxE6c?=
 =?us-ascii?Q?AP9E9/h4IP/izwdjf9kWGwVGw3B7/Uwp7TiGOgo5QNXMQ/Kgr510aBQ7mJig?=
 =?us-ascii?Q?vzFTZOSw/J6Cjdkx4faL7g+5J+7aiCicVV6f1d9qOGyqvMEc0P6mvLTjl3vs?=
 =?us-ascii?Q?taTBMSmV8AfiroJnmn5BWE2Sn442Uvq7SI4o2kDYVrpWYUu73zILbxh1fapa?=
 =?us-ascii?Q?c2XiF2J3GLs2elyuEnWi8q7D6XjwcAYOpjWOs1nS/6s479YmvuHaw0a5WDqw?=
 =?us-ascii?Q?hT2JKOUG5fRqmcjhush5QoTjS5IyY3rlmkGFJykNPptWeFZdyYTzq8HJdxmq?=
 =?us-ascii?Q?PIsHyMWHd9e2Ya4QSf1OPncdp7jxD7phvfuqBSQt3zRWpgVD/fZlwtYQOPLm?=
 =?us-ascii?Q?RY/p6mrz66MzeroEQuChoKL8EIF+3ZqBT0/dlLANH/yfXHdXYKnFkq1YAflA?=
 =?us-ascii?Q?4Q9QBcxndufqW/2fbQBiy6hDWDH++c2hLbN+GzVZ7iQiS4ENpwDGTl5QKysd?=
 =?us-ascii?Q?aSD/qkU389s2masJFLOTjaeRAUMWeNx0njLNGLZgsmbSKPIv3Z19W61UIMLL?=
 =?us-ascii?Q?2X6ksat/ZoiyfndIxCDn5q+Ln+A3F17i8EAVVcCJmJxkE47wCAIiI6WNyr5K?=
 =?us-ascii?Q?HnN4Aj9m8kEtwITv12LRh/nnOToI1AWmFw+hQKjqOM2C1m773F2XMU/zxzTx?=
 =?us-ascii?Q?6M6xyA8mjStWl6U87CzvxBk9LqELyT9ztgHCcItblyw+Hl7cbwTEkfmD3+61?=
 =?us-ascii?Q?emPDZhUZoUhlOArWE5VH2tTbK9vAZFVbCleZvUMgqLdj9pMYAW5YrDaclCQK?=
 =?us-ascii?Q?Q2Tedcsq+FiWjn3EFM2QdOgi8No6seAfoDRdkiQKEwHPJkGQfmj0GWS5uFEo?=
 =?us-ascii?Q?ulVXzVaoYPjOA0zxEQQt5ctrR8dG6lummVDR+xS/p/vHnBQRovoo1D06Ubkr?=
 =?us-ascii?Q?9IJEL/lCqMWZKNlZ4frGN8nLITjTnTHzO1TOBMC9g4F4O4sxQ+/FWOsCjD2+?=
 =?us-ascii?Q?5IodjRjSTfdlLPMfgk4LAe1QeNqtt1Wl49vGiBzt0P8BSH5c/y0tNfyvA3Bg?=
 =?us-ascii?Q?Em71nZWx69Z7JkB6W/JRvaSpkUt5LvlQv8BufodflXjYhL9XJICoZoBiN/8g?=
 =?us-ascii?Q?zJQEk/I6Wv1jRxTLPww=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f81bbd-19dc-4ec5-1ebb-08dc84ae04fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 15:50:12.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6K4q7RKBL8GzSLO9o3dvWstqoAR1YOATeMxniEz+nb7sR8GF3YtScpJpSKAf1oz0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043

On Tue, Jun 04, 2024 at 12:32:19PM +0300, Leon Romanovsky wrote:
> > +static struct fwctl_device *
> > +_alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
> > +{
> > +	struct fwctl_device *fwctl __free(kfree) = kzalloc(size, GFP_KERNEL);
> > +
> > +	if (!fwctl)
> > +		return NULL;
> 
> <...>
> 
> > +/* Drivers use the fwctl_alloc_device() wrapper */
> > +struct fwctl_device *_fwctl_alloc_device(struct device *parent,
> > +					 const struct fwctl_ops *ops,
> > +					 size_t size)
> > +{
> > +	struct fwctl_device *fwctl __free(fwctl) =
> > +		_alloc_device(parent, ops, size);
> 
> I'm not a big fan of cleanup.h pattern as it hides important to me
> information about memory object lifetime and by "solving" one class of
> problems it creates another one.

I'm trying it here. One of the most common bugs I end up fixing is
error unwind and cleanup.h has successfully removed all of it. Let's
find out, others thought it was a good idea to add the infrastructure.

One thing that seems clear in my work here is that you should not use
cleanup.h if you don't have simple memory lifetime, like the above
case where the memory is freed if the function fails.

> You didn't check if fwctl is NULL before using it.

Oops, yes

> > +	int devnum;
> > +
> > +	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
> > +	if (devnum < 0)
> > +		return NULL;
> > +	fwctl->dev.devt = fwctl_dev + devnum;
> > +
> > +	cdev_init(&fwctl->cdev, &fwctl_fops);
> > +	fwctl->cdev.owner = THIS_MODULE;
> > +
> > +	if (dev_set_name(&fwctl->dev, "fwctl%d", fwctl->dev.devt - fwctl_dev))
> 
> Did you miss ida_free() here?

No, the put_device() does it in the release function. The __free
always calls fwctl_put()/put_device() on failure, and within all
functions except _alloc_device() the put_device() is the correct way
to free this memory.

Thanks,
Jason

