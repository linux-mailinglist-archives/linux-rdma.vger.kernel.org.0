Return-Path: <linux-rdma+bounces-2856-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D1D8FBBE3
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 20:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438A928220C
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 18:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE17614A4FC;
	Tue,  4 Jun 2024 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V0Xjy08c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E64A11;
	Tue,  4 Jun 2024 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527132; cv=fail; b=SlYxUC8OYqTxsxjtUBGoHWaRe4tKBkc0UNzW45sVE/smY71h+JNlAJUOzaRv2kCBw75cECv0QsPIHWiNoAnW2qxnJoDEq7fpiNOa8E3mviIsdnzTPacJeNxBW4gXHBi6mG7kRNHcHVdf+Zr8McqJHJJF5zf1oJ8lB7INZ3RkQ/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527132; c=relaxed/simple;
	bh=F/w/ObrawaO4QNnzEFt/bqWduUnm7U+/nagZ7yOEW60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tLwXTx9NItRseu3XkD5cDXm3+O+Ai1xAZSsDAxoIxL6iHsYZBvYf3pETQqBPAMflv80o27TjzT92Y6O3xjOsJqjMrK02VwghT35kMNAsYUUoN0BkRWcwBdL0ADk+vB+mqyqQ+v6Fw8eCTSxVh37hq2V276IQpq8MkZfAB4IXZeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V0Xjy08c; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggRYmmMEIQJg4sPC/nh2vIj1O8TGSWibBFnmBuYDBNQez2rnoLZ7IR6LzW/rVOeDN+3Q87puu/+7oGslYg+L5RRBwV5X8le4aeu+7ArhrX1lTWOoJ3laLkFnNvQodBBNTbWXZDB93UxIKDXDMPBrVF0ZbPTAhFv4mvePUbCwr0k+8jR6Q08b0WD3HgAnk67vOo3oJBHrDS+qih8nYR89yWLvAWDlUnC3fYGj/chV9JibyHOJIHXXcgIw8KtfvpkjPuYEdEZUgoaGZIbHntnuc9urAOdPAC7Dh+vAW75xAzv7wQ5kV+thajuMx+ImVrT76Oln+xgBVu140cM1anSyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/G6bQwQOifeBXw7D9DXk2vmYYaKP2U5E1cLFTekcAQ=;
 b=UL7M2ziK3s7l2f5IiY17yjmaVywNl4Fv6OfTG9llFVKau/C3Y8Zz/mXQftuASRbtVVL3VHnWyanYYNsm79BnYciz+rbwwWPvdsyMeVie4bEgQM15qSOhzKBSZDi/0GkdxghSF79/bSfFEP6xcpFh7PGfTcWRL/UGfJwZN5ikU4vA3JLMhcqblr1x5bzMg2n7RrW/a/IcjE+g7pkctK/7thjrEcjTuIG04JjCpAlSWyK/IYPpW4jWsecV5OoQ7UVj9O89SLgUsYFOIGqGy638SBTF1SInMV8ZcRJN8XKjfPuF3OBWQCdJwxVZEZWd3kCRG5JiRjqt1ZR6hZXeYmRsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/G6bQwQOifeBXw7D9DXk2vmYYaKP2U5E1cLFTekcAQ=;
 b=V0Xjy08cbFNlu/X/T0Po8KGlR0uOp9vUiuiCxL2FlvZdhes+aVzBDsb/UcwyhfALDLQpsh9UJXzfigCW6e9M2sbtGbibUnxTrnxmT6tE0hfK625emL2FnkirStEiSIwgo84Dr9ZN+NVf5zmjrciUT2xA8IEY6JxaiD2VcsG/9rFGiHWhc/n+si98Doi47KAlvzTxiyOeYOjVsgVi1u6WeJmq+kZbuw8eVGvGbVXYli3KVTvSuK93L9bF52NV3JIzb2Vb+szwQHxzCHeQmvvJRWuT6GP6UeAT2WAgXWg15a5m6RxptjlIWKNG2fIagIJI5DO9OChdJFA7YzDzv3l+EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 18:52:04 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 18:52:01 +0000
Date: Tue, 4 Jun 2024 15:52:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
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
Message-ID: <20240604185200.GN19897@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <1-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240604093219.GN3884@unreal>
 <20240604155009.GJ19897@nvidia.com>
 <20240604180555.000063c2@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604180555.000063c2@Huawei.com>
X-ClientProxiedBy: MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34)
 To DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: cccd38e8-0ff8-49d8-c70a-08dc84c76b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0csmZ1QPjXnlCKS/OsiMWWulvY0fypTs5IQ/t1O94b2aAGfrM+q/f/jEHcBV?=
 =?us-ascii?Q?/E7xoeIUe456Lugac6FJ//zDijvD43R866o9sW1XV3RtO7JGNeYrYGmrN42L?=
 =?us-ascii?Q?5h0vWDnmDRMfNu2Y2ykU9GupXgEuPevcVXHDvERwUR1KhHSqC5PEFrgj0UX8?=
 =?us-ascii?Q?VkDTQXPs3brN59BaG6yHTiyMwrYElzWQGK7MMv5y9kHzVGXdce09nMAmGMHs?=
 =?us-ascii?Q?+5y0UL7pHID2pthvTcja71rjw7cxm78iJOMZDj+n4QXrHrdi+96tu+GNNbqg?=
 =?us-ascii?Q?KzTMlgL7kyVziXByrCKJesZKZSctlBXyCO/D1uLbuEEPfFrr9W+idYAHolpb?=
 =?us-ascii?Q?twfwaW0wwZsafSi6/3jsROCm6ztXfIYuyxOf3gFJ+UJWkAQgyzptPrJYcPpC?=
 =?us-ascii?Q?H4QsUVT5wTHo+Ab33rlecqFoUhQScjdf6r9XSlYXqTSqjjHfZy/aELK5K604?=
 =?us-ascii?Q?Y19EhI5bqWuSLcqdhg7O5DaMU9vXZWxQyjzQQ5/OM/LQixGxA8RPvfC5N7e4?=
 =?us-ascii?Q?ymUIGlIBudEaRn0+XmdjZoUzYgGAflp4OATXE6Kb7ZBpzFkr05OfKDCLxpPp?=
 =?us-ascii?Q?wyOW6EyJRw5R+vo7ycs1+wsCSsk/a8AhDKFiRe0wqa98cosPXd9SG0I3zX9x?=
 =?us-ascii?Q?Ke3YQeB7KpK/N+4GvK0oLgFt7eIy/3Eq0EFNuPlg+MnFxKn55wt1o23SpuIB?=
 =?us-ascii?Q?/wmrgA6vraXVqitKd9XQvkiyJeFv/1uV6gJF7O4RhTtnqQ98y87r5p0d9Xsf?=
 =?us-ascii?Q?98WXT1TkW7Vksr3L5kDPXFWvm8HtNwbIoZ95lJMqJLvpoUi149EQ1VGjjMa7?=
 =?us-ascii?Q?o1is+JQIFlRIj0r2sT45/wDQB5MCdnc6iaXOnSOP9tHAG1EcEoIC/cHyIzI9?=
 =?us-ascii?Q?yNmu4OyJ0KJ46D5hLTDCdMOww+sLS9uTCgvMC3LQij2o2Qi78YdVafgmwGOY?=
 =?us-ascii?Q?WuM3TKmnwZsg5qYeyaDtDmsdcuG8xqa3UMQtxrxCs6Y/io/eG50HnpTaWKcz?=
 =?us-ascii?Q?ByDPVUZqUeniQ07YAopeklHaJOO1xzn9zDpJ3BetAFjHbz8xBzb3zdtegclf?=
 =?us-ascii?Q?jxbmZMW+4PFw/SuEIUbPZ3mxebLZVtLxcMnw+8G+TvfgDgh3XIX7Mw7VXEN2?=
 =?us-ascii?Q?Latw4Prv5NlaZjhvhiIXrjNquPVMqt1bQh8V9In2MargOc7Fz61potmIK1Km?=
 =?us-ascii?Q?DH6+zw7oBUxOqrgUHkrg+7J/NqeZv67IHLS/ub9lXCoBCXvGOe9I0E7Vj2jB?=
 =?us-ascii?Q?4wSXTt01Ha9XBuxsrN9rI0cEEFuXI+gLPL3I64195g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HddBzTAR/ZrDdDmqlvNf1quDcN5W6kQRbSTxXNzCJWP3GsrVr4szlAEExjqb?=
 =?us-ascii?Q?DiTtuDl23dZiZNxCs6ORjpXwDuTGtmtuuoPZer8R1Snl+JD8NxaHSH3qSx6l?=
 =?us-ascii?Q?mRnx/FVbr7w6cQdE35csKPSKrWXGtcjnaoHR9+Tu6/8nFVWb0gNw0lTBtSn2?=
 =?us-ascii?Q?SH+cl7hOAQvRmMgH0qSbqEzCbWrfGcz3s6w3i6twQJT5EaNgJzxIINhD8Im1?=
 =?us-ascii?Q?Bx89uoS+dwT6Qt4qYaNDJNroVobV9CDRbFM6/hKfFwJ+oTkkxYvtzNOiaLLQ?=
 =?us-ascii?Q?yDWZwzKqrlH2BBgep3ohYCsZsbrNW/Vdq6o8eSpscwvJdI4egpjpnikI2JC7?=
 =?us-ascii?Q?Mode8rOpVrzLZwqp5y9RgGVuLOTRSQmXiwE9aMDqreoGjJ3oCxyPqTC74iBo?=
 =?us-ascii?Q?r1qcmX2zQbJVCRtIfFc7xfVFAie+ocycWR361mboxvoBvkVyEOEFEbYDF8Sd?=
 =?us-ascii?Q?HUABuLsKNx40oRxba9x1Yp3J48/jBO71LhDwv/mGlGixIknBNL3XjekmmbNK?=
 =?us-ascii?Q?zboLCwwHZ/uke9R/3uPTBzlqTYSk51hHg9e7CLTSA+wQo/WzPVhknRJET+yQ?=
 =?us-ascii?Q?cq/WKfBLZvgYbGy1K9bByMitIvRhQYGSR+7roqt1UFwOWK6KrPefcQBxs4jP?=
 =?us-ascii?Q?CsQ8pwRdQlQjlfjSMtKL1FtxRdxHP8o6M8YCB/4zNse1H2uaMolFmPBi0e0q?=
 =?us-ascii?Q?GCkcIKa010htuX6DdRVDeh6NKFdXorRpwKtxy+mXuINHDua2eibAVEVSyVvn?=
 =?us-ascii?Q?TDg1WEbgHa9fWNJJXRTr7oHIF+qREzLkqkoLE0aaPETAQKxyw/yXDyxOTnPl?=
 =?us-ascii?Q?f8xlpHhEwHjY9ksYsPlzVyQ4/Wqf0flraJz4VS8NqweqP68vG4tdSSDNHj2l?=
 =?us-ascii?Q?6mrpHFhflzxMz/30vBYm/gHl5h0+7aRiBctFMAiSd1v0SMimpFl+Fqw/5j3p?=
 =?us-ascii?Q?b4wDqjcGMU5GeHy4KCNzM8CSBT4je2vZ4xoIxRTkI9g6TsVCZDVG+qHCofXD?=
 =?us-ascii?Q?9ofDtdqJC2zZo61WxbvAUazIS7oIV/filv5Qi/mMOf+Uwr2JwM2jScW8YopK?=
 =?us-ascii?Q?bUnNldwG9kLvLbpk0LN2Bq7Ed5+UoHqFGFGpPY+1OnQiopALtVKTjbU2OEVr?=
 =?us-ascii?Q?WMtsVYh7Vqw87sgNAplB0vsiiwMAzlBb2FcuIjaEfnU6ezy31KDukv185IrO?=
 =?us-ascii?Q?0ytpgH75MVRa3chvBT6KNrx2/cN00+V3PTrjxY95Oh7EvT1gch30DuYTylyw?=
 =?us-ascii?Q?rqNCLs8RcA01aI7xWpgK9OUmJ3yNYgI+D9QeIHKPID4PEIjTpEA4aBfnJ5Qt?=
 =?us-ascii?Q?D6w2ntjdYOAyY+ta5sPjQhpbdgxb1s8g1JsXfQ3Uetop2ynvlUjPiZ7fE9MJ?=
 =?us-ascii?Q?ZUMBTnNkvsHTp66/3BaphVDZNq4jen2ZEWCDe2C7NfhM8qsBMHwoDr/YJ2l4?=
 =?us-ascii?Q?V3HNpPTY5fZVlQqq+M+wzM1f4GlP0faanPE7fGjOH9mgspnijJ5JMV60QJ7q?=
 =?us-ascii?Q?P0JaxDYpwLSxHYKG5CMe3MaXT9Jo7UxkQ2DJ0E1XZD/dkzO61fIqmzBW/cm/?=
 =?us-ascii?Q?Hf18KHJaKa0C3Mw60rKQr2pEjWfH+4BnRUSSCMGE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccd38e8-0ff8-49d8-c70a-08dc84c76b60
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 18:52:01.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eBT/zrkjDdRFc5niGA988ZAaa+npt/Sxi39RyMswwjQ5ApSefvEIOrXV3iPBZXt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742

On Tue, Jun 04, 2024 at 06:05:55PM +0100, Jonathan Cameron wrote:

> Trick for this is often to define a small function that allocates both the
> ida and the device. With in that micro function handle the one error path
> or if you only have two things to do, you can use __free() for the allocation.

This style is already followed here, the _alloc_device() is the
function that does everything before starting reference counting (IMHO
it is the best pattern to use). If we move the ida allocation to that
function then the if inside release is not needed.

Like this:

diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index d25b5eb3aee73c..a26697326e6ced 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -267,8 +267,7 @@ static void fwctl_device_release(struct device *device)
 	struct fwctl_device *fwctl =
 		container_of(device, struct fwctl_device, dev);
 
-	if (fwctl->dev.devt)
-		ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
+	ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
 	mutex_destroy(&fwctl->uctx_list_lock);
 	kfree(fwctl);
 }
@@ -288,6 +287,7 @@ static struct fwctl_device *
 _alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
 {
 	struct fwctl_device *fwctl __free(kfree) = kzalloc(size, GFP_KERNEL);
+	int devnum;
 
 	if (!fwctl)
 		return NULL;
@@ -296,6 +296,12 @@ _alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
 	init_rwsem(&fwctl->registration_lock);
 	mutex_init(&fwctl->uctx_list_lock);
 	INIT_LIST_HEAD(&fwctl->uctx_list);
+
+	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
+	if (devnum < 0)
+		return NULL;
+	fwctl->dev.devt = fwctl_dev + devnum;
+
 	device_initialize(&fwctl->dev);
 	return_ptr(fwctl);
 }
@@ -307,16 +313,10 @@ struct fwctl_device *_fwctl_alloc_device(struct device *parent,
 {
 	struct fwctl_device *fwctl __free(fwctl) =
 		_alloc_device(parent, ops, size);
-	int devnum;
 
 	if (!fwctl)
 		return NULL;
 
-	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
-	if (devnum < 0)
-		return NULL;
-	fwctl->dev.devt = fwctl_dev + devnum;
-
 	cdev_init(&fwctl->cdev, &fwctl_fops);
 	fwctl->cdev.owner = THIS_MODULE;
 
Jason

