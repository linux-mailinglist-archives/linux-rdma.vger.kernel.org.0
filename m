Return-Path: <linux-rdma+bounces-9090-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE48A78075
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 18:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2782318863A0
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 16:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E13920AF89;
	Tue,  1 Apr 2025 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c85NIwhz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CBE1C5F27;
	Tue,  1 Apr 2025 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524921; cv=fail; b=tIcFn7e4J4hAksf2HEM+vetPKxd8fWQO8iBIq0yIvNqna2ZmLPtFajGzrYpWutrdcbO8AtYMVYUZXuO6A5VJ9TjDMglIj4RYvtiizw46PMb9ENxpr8BsahVrYU/sBaLlO72CyWGzMHR8syABj6q2XndOTTR2QQD7bE0j2EZFOGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524921; c=relaxed/simple;
	bh=ydzf3Ja4ctD8Vm8h8UH8PxlQaalu4Tw9biJ3NDUqmdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EW3lTucyIlRy4ItzAMgivNp/GJDtnTIyfPWr6Oz1blcoi+KFhtbJ6J2o1lVV3HsV3mOjCxOkguQ43HzwvV7Ub2TaxmlSmBkCcWBbudxDoHQjfa6JJlpKbvr9nCoeUSn/kOFLtElc3nj0VxJW3SLwPSAfWHfL0WH3hFIlqtVeya4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c85NIwhz; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRQwe29JoNXThlqrPfXGDfqHQ+oskHCrsAB/srl7OcIwrBPkpy/clOy1p1m9RDNMH4a5eBwzF5EOueS9CutFM+r8Z35cOfqjGffG8NA0ne5CXa+7PeD0JNWfIf+c1qc78kiooIJalf22n4qkscZhXQtuCDzLPUwkJejHzWGrQR8ap77cYt12yfcTjxliVsp6JG4wCIHUpE2RnmDHodnPs++hcGLnY/eK4GIce0XdzqqiQoFLbdzgPcQAKVqlmO+dURPSsi+/snu+TehkQjYx9Eo/9D0OEtT2KptsEIB737TMKil8U6ADqXTENAgV2Ybxgh5oj/2Ys5TbumRSKi19lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvQSL0I3RAHfZaIQ7/a+KU+lrtaXA8uKRqj2ZAl3xeA=;
 b=UpO4XmTXAb9xf3cjG8I/NY9ZkOHg9HCi6/PXUOu+yDk0qy+eve3sO0oa8YtzSMs0xysJEmoYxaw+HHvWv714+8XaRJTcC7hTDKtiXq+vV5hK31iNXagPuyONskbNnIb4QeLvHAbfyq0SZNp258zB70XMNrFhK2D3exbfgpvKuy0j49aq/2VkIA6f0BAfi/O0OK7M4fwQY4UZ4NOorLaPhBqy5Og4KFnH464ypFnqfWxnTL+TZuSUfFkTkkM9gQmmyl/88tgY37Syoi9iTuMbOXixgUPi+0j6A26qriCpWyyVY0bWYJTwgoe5fBqRNUTeHIZmVjkAPBCR6Er4DrfNIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvQSL0I3RAHfZaIQ7/a+KU+lrtaXA8uKRqj2ZAl3xeA=;
 b=c85NIwhzKebQRRfIJKCWSZEj8oOEuwzxvx0CHVDTnmZ66zTfRXxqP7o8P/ZSo+s6IqLE5H9pEr4l60p/rldpeGEI3m5b+c+VrNIH3QGDRkyNttuL5+L++yOfE2Pbnx8CRIfRkVV9avMjWs8E3PT3NakkSwVdApYeaKbihF+/R69VOCiEbpdWCqyO9NuE6twmGvr6LIdOOr0GppaeVqQjU+A2lY1KkpdMJqN7BXw1njLeSm61lQy+JeytTmERNBwDJ1NpIv/dT/BOTUmDIaa6J2t8feFI+1EG07CzmlYd90x6ONks55qjJi9OEma3xJ6ewgUXQrOW62B4r3Z4sBv15g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA5PPF8ECEC29A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.53; Tue, 1 Apr
 2025 16:28:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 16:28:37 +0000
Date: Tue, 1 Apr 2025 13:28:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Chiara Meiohas <cmeiohas@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inifiniband: ucaps: avoid format-security warning
Message-ID: <20250401162836.GA324820@nvidia.com>
References: <20250314155721.264083-1-arnd@kernel.org>
 <20250317115000.GS1322339@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317115000.GS1322339@unreal>
X-ClientProxiedBy: BN9PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:408:fc::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA5PPF8ECEC29A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e100fb-0024-415a-2540-08dd713a411c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VmzNlGRAzqUDKGQjXasWICUzx4FaRRxgjg0fojz1xbU5zuqhNPS/uyZ1ofcI?=
 =?us-ascii?Q?HeFOUQ37T0vfTaE7dJAJonW3zf9YlJLzU2lYleYVNBItS0U8LqmtdmY1zWcq?=
 =?us-ascii?Q?Cx16PDYvmXxQTPqvXtMY5lfXCpzEzTv2Vh1sj2IuQI0+eJm9o0WrcdK8QHcr?=
 =?us-ascii?Q?dQp+5wMsQxLC0xkxlWrMbQwZBrSEbk7KoC+KWeTFJI3c7OIvGrH9fXrnTGq0?=
 =?us-ascii?Q?2GG0czige6oDiojJxTA0JzEqd/4hOY3olW8HInxoE8UcHuptUUH/MIyX0+pQ?=
 =?us-ascii?Q?JHEuTHzI7zgFxSWBE40V816I4aJlLVMzLPV5cjdXv25TC9BX48HEVQ4ZpY1W?=
 =?us-ascii?Q?7z2nB8PrVs26/H3b9Ml16+jxyhhh6q1rIu/bhjA4Ejp36tMHBanjBlTY6/EK?=
 =?us-ascii?Q?iT9z7+Zab0PXTphN97eYYj+NjCizS7bICQWPAQWuw/Cg3b2XnX7oI/tEdZex?=
 =?us-ascii?Q?R22kzDimoIvdni95iyHecDBRMIDIE6QsF2CMYMkKMGTTiJqOmN3s6ByXp5gV?=
 =?us-ascii?Q?qsSo5D00yGvbFypEz3aUuN+P/N++ygafzALvtFvpenrstj05VGhWzlG+I6fs?=
 =?us-ascii?Q?ZmQwR9qexJV1Uib2wkBoZoVgVF6rHAIM6De5AYiNP76JkSsI5tukwwQ3KY3+?=
 =?us-ascii?Q?W3sThhUNyyJTHlvpl1sdwgeBciGXu1fQFrYhzK1WQvJ/95cVEJvxczlYGdAw?=
 =?us-ascii?Q?G2OCPD0TFD6iSLqoQw0wyCnmap2+WO0qSNKPShfDwgeCtv79S9FAvtxdyfpM?=
 =?us-ascii?Q?jpPo3NjBpzUCx7CbdByScrfwOJOJ8cXQOWUfjbz3DAmdkE/erx1EAPxtSJWS?=
 =?us-ascii?Q?zJ8ePc9jyc08v8/iTHfhWxHTgf9y41/AY58oFGbNd9VLtG76ttBcpRe41JJh?=
 =?us-ascii?Q?Ko6GXr7o97nJo6K2xgBVtbB00XKFcveWV24iyWQtuD0lUXfEoEMZ8enUEhk4?=
 =?us-ascii?Q?05VIYrKlm1cDnw3Pt5RFaY7+2w7SYo4i6tyAKlyU87fRxYB63E5ZX7t/UyZb?=
 =?us-ascii?Q?IE6oXwwrjK+HwGTreBw7UGCyPD6r9RC7H3KcYYnJ+clXBkUULaNtZRFNLNsY?=
 =?us-ascii?Q?zVcCN9J2PsfraDlRh1+W/5q/+isFD3mScDZwRNYOLVnx54BeCNqnQup17q5G?=
 =?us-ascii?Q?XiyJt6/k9IMa+2xlos+ZF46+zpbcvnZDXQIzive0q7zb6w9iyKguITW3cV01?=
 =?us-ascii?Q?zYpgFAqXNH9afF2Nv36e7cEPIKbtgcxde7yp4nDOB57djeCzLxFee4U0f5Vn?=
 =?us-ascii?Q?iaADXzXqwCphR8uJOLraDDO5Lrzsr0D6bZ0rn361NpSdXnad0ROKGFQWFnYv?=
 =?us-ascii?Q?d2JhaOEhGU3/oF3X5vqG9scA6FZmuTX8cz3MrMR3hslVaMSchpDDw+qiF92E?=
 =?us-ascii?Q?iXnERG6Yzk7cyIyRepxbGMHdYgCt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LhaJnAT9V71RjUFOz/82fibdsktzlCpdYeVS37Pi02E8/ZYn4tte3u9y8Y+W?=
 =?us-ascii?Q?PqunHAjt/5N753f1NEPMIztLAsC4bQsPaE8vhnI6He7W1gEulQZXKmvd2628?=
 =?us-ascii?Q?tN1GKxDtsicI1wjCPV1bfc40vt/+6NcypW+Sh6FGy50Wte+Ef7o0lPnCkDUV?=
 =?us-ascii?Q?HrOg0kczmmeI8fKJ4w7Wj8mwrC9cNb8upjH4WkdaVdGfOGYF/gGrta7zxzqZ?=
 =?us-ascii?Q?5Fcz6WEDwCcanf7HWqew3jG4xIlZMUkAkyy+I5CteG8llCgeMwgMJireUVBQ?=
 =?us-ascii?Q?lJ+PCBb3aoSN/k32MOO/EMbBZRO9o+VB07nV56vtj4yzgs25703EkwmvgrpM?=
 =?us-ascii?Q?hAEy3EygFtiwj/iljkIObDiurON2k2okM8OkIriJxPCcdPYvohPy2QR61PQz?=
 =?us-ascii?Q?ctuBCzOVi5T3QmEfoMcRxoXTIre6+oYG3gySLDGeXzfJZQ1mb/S0ztlGpmg5?=
 =?us-ascii?Q?z8gEt1XzdZ2mRWGisrmtNZiviBcAJceUjH+3If5d4/h8IT3oDIWyL58/C0DX?=
 =?us-ascii?Q?57VisJDz9/It9C6KXtGHc4zPjmKK+FfMVk3IRIcQVhuOPbRTtfOkRrhJeINt?=
 =?us-ascii?Q?JiSdDKLJbWIesqAOMXxuY+hkpSoL9qLEgnz27IknSl65REpsDMjgrdUWFCro?=
 =?us-ascii?Q?/fyyI9aHasSFF+HCvtDKL1D3tux/Vd7aM2yY5A4ZIN3obEPKSKf5ujWmJ7MU?=
 =?us-ascii?Q?VYbpAwGGIZULRKso2DugSxVlWVRFwFDGpEZahuBQP21ECmzUvUeBWYeWFO3d?=
 =?us-ascii?Q?ZihIQhtris8GUe+wmDkD2mPY0jZNAYC4tSFcPwsAIo6PXLqmtJrRERkFCrqd?=
 =?us-ascii?Q?9N+kPSmFZwfTFn++x0yTxgEub4G3USskj+n3V/tiF4+lMja3CZoDHTUJXNok?=
 =?us-ascii?Q?Xe2c2Pa6+oxDwAWkxYjOlL6jpdhU4ya47oquxSXdV+CvGeX3iDPR70NdSMhZ?=
 =?us-ascii?Q?TxxM5aZHTfpZIWbGATIGj71vGBqOKH/Ou5ZBViA2YU2Wv173/8pM2Ejp4Bf9?=
 =?us-ascii?Q?YreybC6mCrF6bMzgbp/lUIUDJf6H53h8+2JkMpBMadNrpwHsYjc9OOX3S9wh?=
 =?us-ascii?Q?QhN8XjAkRI9LKPvSeWT82/I+sWXz9g6NYLZVd32zS2gkOEcrYekweIYq+sQE?=
 =?us-ascii?Q?QJIBQxR3eyZskbwAKFynq+0UI63+J/U6alOMJKWj/ViZCMG8Qa1DFiDAHrhi?=
 =?us-ascii?Q?BnjjozXBk/ANWbwS/2J6Sj6ON96/PeG7NACHTYg8Ztt5ZCW2nfikQw+drJMq?=
 =?us-ascii?Q?ip798TVeJ4EAqbPfQnmYVIYG/z0X+qoj0X8xIMtAOjnh0lwpBzk+enj9F9pA?=
 =?us-ascii?Q?cmWRcqKLeJkmcUScNFrGL25g7rzlAz/XvvV85xu/drg9Z83aWXm2IWosWBq3?=
 =?us-ascii?Q?Tpx2lDiT9LutfmUHUdnqqVLPzIvTT7gtTEiaYx4WrIEUwxLN/QrW09mAQXV6?=
 =?us-ascii?Q?GCLPXddrP48NQy6GWVQoQldsc6MEZN/T9bB7CR52vbATDpzHYhHZMZLtByU8?=
 =?us-ascii?Q?/nNBNJs32UyjR1dN+JVjFpJ1qPUdRNzzcL1SivPV6cGMOnKRSEKlswl0AGJz?=
 =?us-ascii?Q?KdPDUckvSvgLg1IgItDpO4MkwP5knvu0eBDojg1x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e100fb-0024-415a-2540-08dd713a411c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 16:28:37.2889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZnfPAOh1pNRQ2wUjAkOYetzTdYALKuXH0BNofG1plgEvBA5FzcI6FdV7gg0NM2W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8ECEC29A9

On Mon, Mar 17, 2025 at 01:50:00PM +0200, Leon Romanovsky wrote:
> On Fri, Mar 14, 2025 at 04:57:15PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Passing a non-constant format string to dev_set_name causes a warning:
> > 
> > drivers/infiniband/core/ucaps.c:173:33: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
> >   173 |         ret = dev_set_name(&ucap->dev, ucap_names[type]);
> >       |                                        ^~~~~~~~~~~~~~~~
> > drivers/infiniband/core/ucaps.c:173:33: note: treat the string as an argument to avoid this
> >   173 |         ret = dev_set_name(&ucap->dev, ucap_names[type]);
> >       |                                        ^
> >       |                                        "%s",
> > 
> > Turn the name into thet %s argument as suggested by gcc.
> > 
> > Fixes: 61e51682816d ("RDMA/uverbs: Introduce UCAP (User CAPabilities) API")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/infiniband/core/ucaps.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Why don't you change ucap_names[] declaration instead?
> 
> diff --git a/drivers/infiniband/core/ucaps.c b/drivers/infiniband/core/ucaps.c
> index 6853c6d078f9..90ac41bc0f07 100644
> --- a/drivers/infiniband/core/ucaps.c
> +++ b/drivers/infiniband/core/ucaps.c
> @@ -23,7 +23,7 @@ struct ib_ucap {
>         struct kref ref;
>  };
> 
> -static const char *ucap_names[RDMA_UCAP_MAX] = {
> +static const char *const ucap_names[RDMA_UCAP_MAX] = {
>         [RDMA_UCAP_MLX5_CTRL_LOCAL] = "mlx5_perm_ctrl_local",
>         [RDMA_UCAP_MLX5_CTRL_OTHER_VHCA] = "mlx5_perm_ctrl_other_vhca"
>  };

This should be done anyone, but it won't fix the warning. gcc is
worried that the format string could have an embedded "%XXX" or
something that would cause stack corruption. It is a security error to
push user controlled data into the format string. This isn't happening
here, but silencing gcc will need the %s.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

For both

Jason

