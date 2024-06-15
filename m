Return-Path: <linux-rdma+bounces-3157-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29BF9095AF
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2024 04:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95C31C21428
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2024 02:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F5333C8;
	Sat, 15 Jun 2024 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J7gAohJD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4DA8825;
	Sat, 15 Jun 2024 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718418781; cv=fail; b=RdfrB/8CuWt0t9IAaH6Ib+3E13VsmB2Tz+vn56QUFeuFyQ2++LEpn3Rnm86J8u48cdfiR1jgS08ZxsWvP9ztvGxjqXnEdDQacfdMkqiy74teLEoGKqeHYZerC8pk9GPTvVLrDpEaNyHGTtdBzQ9+4mIXByWWTD39l1FSLiTFmlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718418781; c=relaxed/simple;
	bh=/LpqZfXZEeAmG1ofaQk3wN7pyxrfqmcmyGNE8NNf4v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mcIZicmbx0fctkdAx89eGOxRUJcJuAaCyWa5Ne10nT9bS7R1Tek8CPz0OVEL17JjGqEJn0b6sgE/g+ZjxcjgnMh5aHRS7OK+FkDgPIODbFFKuwd43F93J2C7ix9KM/nacK+LfwouwEVC6XxN60aUVzSH/cyEjh5a7keqozxUCfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J7gAohJD; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxuNBnSG0lCcJMpgtfu9sbd8EnLpjku9OzLz0xWP+6mda8wsfQCsdlFMx+v+N5F0ErXdSyzHfQGR3b+8rqSXQJxZ8uW+E+oZLkYRCkjdtj1NVW5VxGvwrY3fz0BPbsmepLrbmD7RCFNNiQa0sObYPLTgi9/+QWWLaJk1Ond8u37K6yyq8vyHfjQRfsBzBIXtqEOWQWHAJSm857Slxde+legCQrGn3h4mwwP0qpmkwhsye1hP/dEvlx3Q1iNGF9bfTM6ZPwQQLmwKVO9evmpXU+IjQ4NqNcwimWAK252bVfW0XC/kAxkkf2RrJRJi++zYWl65blYsaqXIozZ7q0R+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvtpIu2m9nDqssa6QDlAySdU+440GQjdA4h6ARFEISw=;
 b=G3pRFWGWPsM5MiDxN3as4OUljZi32Qbr3vvLVKcgKonppbg1i/SZ3pDubNYOU8JhbjmynRCNhRKfnDYs2qPJFkv9wtFNXPg4sFg6LdDrnDSnAs213jWDMq6QjZghY0EqMnRUazR8HSx2Ey1gT9GbwwVeIMuhdSMQgzlN1Y3UVqK6HmuyDgFZDG3c0J0xj00rzqzp9TIbrKbEL2EeBRXfZJINz3BXvaUWT1mc4B3SGYwWL3qpIv1RGsZCxFUK3A3d9dva3y4ZgjMMv995itUF+aWsTFH7heEvKKSuZ63UYhsaAZDJ9YuQmmxEb1tFmtffriIBY3ccUzEF9y5I1T7cDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=eideticom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvtpIu2m9nDqssa6QDlAySdU+440GQjdA4h6ARFEISw=;
 b=J7gAohJDNFAdCi3RJ1Tu1jDK2q28jXf5AYtemi+Kz7WDYRDg3Vq8IDVbRaluaGrEwt2bR2MMR6CFqcbKN7/wFTXg+KSaR1tpxKm40ljCKmj6uAMZ8xI0FY/QXhEncz9V88uCP6nCX2T8s9sHhbv/n5+Bs6R4d1jnI2vFMy0caH9pTzB9uCDhuKjan6byK7DryWqIK49gPFDcDKZAHaygqM9125pQoKrk4UOarGIK/oDpESuFPApQLI2zH0mqoNcOd6V+wXSRY/vz/32W4wIuGYJjQ7U7Od+YuSkELA2+yNN37Lv5QuyXraSO/QHN36yzeWFyIUx101+Gmr23Cta3xQ==
Received: from BLAPR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:36e::17)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Sat, 15 Jun
 2024 02:32:56 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:36e:cafe::84) by BLAPR05CA0021.outlook.office365.com
 (2603:10b6:208:36e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Sat, 15 Jun 2024 02:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Sat, 15 Jun 2024 02:32:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 19:32:47 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 19:32:46 -0700
Message-ID: <0a4cd7bd-86c1-46af-9d15-1fa0e0dbfb47@nvidia.com>
Date: Fri, 14 Jun 2024 19:32:45 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] kernfs: remove page_mkwrite() from
 vm_operations_struct
To: Martin Oliveira <martin.oliveira@eideticom.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Logan Gunthorpe
	<logang@deltatee.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, Shiraz
 Saleem <shiraz.saleem@intel.com>, Michael Guralnik <michaelgur@nvidia.com>,
	"Artemy Kovalyov" <artemyko@nvidia.com>
References: <20240611182732.360317-1-martin.oliveira@eideticom.com>
 <20240611182732.360317-2-martin.oliveira@eideticom.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240611182732.360317-2-martin.oliveira@eideticom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a2ebd2-d688-4427-3a7e-08dc8ce376f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGlOU21FN21nU1ljMVZkTGx4TnBFSXRoTWVWamVoWEl6aXVyRk44UW1zcFps?=
 =?utf-8?B?d2ZaTVBjcW5oVWpCejlTMHMyL2hxRnZLTm15dHhsNDZ6cS9uVTEyRysrcndw?=
 =?utf-8?B?MUZTL2lqUUJlbGJ6ZzlBOWZNWWh0QmxtUnZodHh4UDIySTFBNXFiT2xuOUJr?=
 =?utf-8?B?aTJNbE1zQmdPNlRTTncxdjBzY3N5VUs2NTRMQnp2a0xUeVI5NERPRnZWeFBS?=
 =?utf-8?B?alBnMjBqRXhtajMxNUxMZ3kySGg5eGNqUk9CeTRZekZiRDVrbnZiS05XVWNr?=
 =?utf-8?B?bmhQYm5jaFM3VVk3OUVKUWhKeTFSYi9sS3BLODlSZjgzQkgvN3p5WW9aR0Np?=
 =?utf-8?B?alZ2Ymhvell5R05SLzE3RWJYOUEyRkZXZ1YyZ1cxQWo2bUM5Y1ZvUmFYTDd0?=
 =?utf-8?B?T1FHZmFrZnYxeno1bE11cE93ZStoSUx0TUFNeEhqSTFUUzAxWjFiRDJ4SXZ2?=
 =?utf-8?B?RWt2d0lWRDN1SDFsYUhuVU43Ui9KWW1Fb1FZUTQ5d096UFhNbk5QbDlIZjFo?=
 =?utf-8?B?Zy94ekRWbU9NbDBpYTVBSHEwVE55akpwcnhBazc4ZG02WVE1ZytIOFlyS01W?=
 =?utf-8?B?NTZQeTl4K2pEYzN1Tjhqc1pTV1JsQXRWMzlxbWhXVmc2dlBFTlRVNUdSWC95?=
 =?utf-8?B?dFdtSGkwVm1Ga3B5WVFzd3hHT3ZMcWsyTTN1VWxhdGtJb0xNSXdBVVRwR0Ev?=
 =?utf-8?B?WnZjWDhVbEptRENMSnpxQ2diSXBXdlRBL3gzaHhMRmRnZ0R0NVpSamVFaVBs?=
 =?utf-8?B?RlJwUEo2bWdaRzhKSTFYT2FLTW5BbWQ2ekorUXRyeHlzUHc4ZXRnUm40RHIw?=
 =?utf-8?B?U2ZwOWJ4MXh3ckRueFRZelZQNVNtcGFBSmlCMXJ0aTg1L1d3Zk1Ya2d4TGxX?=
 =?utf-8?B?SzJxNWt6V2M2S09KQkpVNm9jczlrcitEZzZWai9IY1krZDA1azdPOGpENEZF?=
 =?utf-8?B?VFdtdGVNeWVnVXpTYjlSK1NYV29UR2puWDY5WGQ1dmZsL0Y3QTg5Tzh4MndN?=
 =?utf-8?B?ZkJrMTg5cmNHL3N4Y3IyVzBUY3FlZGVFV2ZDelhVdmpUQVdyWFVRZWNxWXFP?=
 =?utf-8?B?V1RxMlVMY1Q4R2VFNmVQZkorcjNHbG9DeW9IMmJlVlhTalF2NDl1QUJmck5s?=
 =?utf-8?B?d1JaVFpHVzhuMThlbU5RaUNHZCtVaEp1b2l4RXRsOFJJeEd5UW1nSEZsbWo5?=
 =?utf-8?B?bWNYYlFxL0x0UFQ0VmZCdUhHMStMeERKNEU1RjRSYlRlNnhRRDhCdG50SG1B?=
 =?utf-8?B?VWJzdWJXSVBpOU9PUWttaG9hUnFGUTVJYUQzNlZ0cHFpMEE0ZXdiRm9VNjZT?=
 =?utf-8?B?c3BqM3NYVm9xNmYzT2c0aGRZVGVvVWgwTERzbEU2c3BKMmVxZW1TN280S1Nk?=
 =?utf-8?B?cU5ZMTlBdG1vQU04bGluZkt6WE5FSS9sOXNzSzJ0SUlzUXVmcWdVTTUwSEY2?=
 =?utf-8?B?dzE2Z09FWHZPTmt0dmVVamMxUUhrTXFFYkdxRDdtQ1BTUHp1YmNUSVBqcks3?=
 =?utf-8?B?RDJPQktDK0toV3lhYmdiWVU4VnZPVGc2eTZtb24xUlcxWXJYQjlxUUpsdDRO?=
 =?utf-8?B?WHJycHNHbXVnK1BPcVhQQ3pXU1RaOG5PTEpHR1RQVnR5WGhXRTNlSjIrVkhW?=
 =?utf-8?B?WFoxcjJYRHVpQXZZR0ZLa0w5MlI0QWpnb3pIaFROMUJXclU1M3hMdk55V1Fy?=
 =?utf-8?B?S3lTRVY1Q05PYUxHcmpTcHpEMUsyV056K2dJQ3Rpd0swU2RSZXRTdVpmTldO?=
 =?utf-8?B?MGZVZ1JibjN0cnVmMStBOEV5ZFR0TDkwb2I4TytHREpYenpvOE1aTjVUSk5I?=
 =?utf-8?B?U2dQaGJCeElSUGhxNUdTUUt2S2xFcCtaTlRMN1lWUCtpMDFRQytRZjhPR1B3?=
 =?utf-8?B?YlFXTmIvUUthYU1zVzAyRDhDL1lMWHFPRWZCSytCdFVCM3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 02:32:55.8984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a2ebd2-d688-4427-3a7e-08dc8ce376f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110

On 6/11/24 11:27 AM, Martin Oliveira wrote:
> The .page_mkwrite operator of kernfs just calls file_update_time().
> This is the same behaviour that the fault code does if .page_mkwrite is
> not set.
> 
> Furthermore, having the page_mkwrite() operator causes
> writable_file_mapping_allowed() to fail due to
> vma_needs_dirty_tracking() on the gup flow, which is a pre-requisite for
> enabling P2PDMA over RDMA.
> 
> There are no users of .page_mkwrite and no known valid use cases, so
> just remove the .page_mkwrite from kernfs_ops and return -EINVAL if an
> mmap() implementation sets .page_mkwrite.

Hi Martin and Logan!

First of all, I admire this approach to solving one of the gup+filesystem
interaction problems, by coming in from the other direction. Neat. :)


> 
> Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
> ---
>   fs/kernfs/file.c | 26 +++-----------------------
>   1 file changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 8502ef68459b9..a198cb0718772 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -386,28 +386,6 @@ static vm_fault_t kernfs_vma_fault(struct vm_fault *vmf)
>   	return ret;
>   }
>   
> -static vm_fault_t kernfs_vma_page_mkwrite(struct vm_fault *vmf)
> -{
> -	struct file *file = vmf->vma->vm_file;
> -	struct kernfs_open_file *of = kernfs_of(file);
> -	vm_fault_t ret;
> -
> -	if (!of->vm_ops)
> -		return VM_FAULT_SIGBUS;
> -
> -	if (!kernfs_get_active(of->kn))
> -		return VM_FAULT_SIGBUS;
> -
> -	ret = 0;
> -	if (of->vm_ops->page_mkwrite)
> -		ret = of->vm_ops->page_mkwrite(vmf);
> -	else
> -		file_update_time(file);
> -
> -	kernfs_put_active(of->kn);
> -	return ret;
> -}
> -
>   static int kernfs_vma_access(struct vm_area_struct *vma, unsigned long addr,
>   			     void *buf, int len, int write)
>   {
> @@ -432,7 +410,6 @@ static int kernfs_vma_access(struct vm_area_struct *vma, unsigned long addr,
>   static const struct vm_operations_struct kernfs_vm_ops = {
>   	.open		= kernfs_vma_open,
>   	.fault		= kernfs_vma_fault,
> -	.page_mkwrite	= kernfs_vma_page_mkwrite,
>   	.access		= kernfs_vma_access,
>   };
>   
> @@ -482,6 +459,9 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
>   	if (vma->vm_ops && vma->vm_ops->close)
>   		goto out_put;
>   
> +	if (vma->vm_ops->page_mkwrite)

As the kernel test bot results imply, you probably want to do it like this:

    	if (vma->vm_ops && vma->vm_ops->page_mkwrite)


> +		goto out_put;
> +
>   	rc = 0;
>   	if (!of->mmapped) {
>   		of->mmapped = true;

thanks,
-- 
John Hubbard
NVIDIA


