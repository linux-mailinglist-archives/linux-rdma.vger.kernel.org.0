Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819614838F8
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 00:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiACXEs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 18:04:48 -0500
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com ([40.107.236.46]:24608
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229700AbiACXEs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Jan 2022 18:04:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwpwoL/0qcmxvUYoFAs3+xnTqDuRYSBqxCBVWCir6ox18HX3CkHlbxJpRDs9pBr1YbqkI4YxB3W6/2UV3KJisjk1hY7/SnJbAyzMgIJwtfWNtwYZB02LYZwAjZSs0txq+OAkHzGLWBz6+HwjWolcMv+2wSYgppKBTZhdC95t1i1OdI3AJXFxr2D29HOHto1Ymp01hWc0FAj8hxkknjGK4YEIaiSwjbjEtQlQE1hSl/c4/1wiab8hSp7gyMXFCe5pd6jHMqOTL7bKOuuxi9+SSFgKbY8iRVZu1KZN+Cu62NYLxEdkNnHnTtXu0VbtD0YIyQjyEEyU9MUDbVhLaDtS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kO76akFyYHFqc0zcQ00YZTvKuxj2JgPd+70+sE7aY6s=;
 b=C/HVQTx4qV8F68uSEtamRspgHN4g3vq77T57YLj8TKoFHUpc4k10l0nG9IrtbUa59LSaLkkHgErZvbSOLuVpY83qi+wzAeBgBBS9aNr3RigoKhstri59WPGrgfWWY3x/WXym4tsg7zaLiIBS+FmLzx0EaBfxiHETRdi4pEMHqFL5dAUWhw845R6kRjJSNEkqGuPJxKEzWMIKDog3JEsty20e0WPbYDjQt+bUdWnYB7ssziZ8FNCe8orUbAU01sBrc5o78qPVuZHnnGEE0WHlJhg4yr/XdwYBsUhGVDgPd19blF7xo8sZEX1KwC6o3mCLvvIQOKIaRCsbGykZPjsg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO76akFyYHFqc0zcQ00YZTvKuxj2JgPd+70+sE7aY6s=;
 b=Up9bvEpQ3MFh8XEUGAmEWBPMe3BOljIx2aSKD7ZXIG3851LLIJjHLUSviw7hiYMuTTd0hJnBHMSShiic1l5Xt9lw+ZvzQq/LocTgRlePtjSEGXNBk1hjSSEN5tcafZjRJ6jqQ8aOqUq42FdqeZUqS9+khOVmod4OZbP4sUcDrVOWU8E/MltKKHoCES8l2Huf0BoSvlRdQDXW3lcDPSC1LnfxRU40OwqxTWE8dNKDKdzhY1J4oT0vkrCOJreOWQurSvwDElEi+clpLy/sPApPTv9xSpY4JDBLo2620wK9rXLfbCZy8/BFvgQnG6P1cOWPC2YzWxD09rFKd4SyEpDoKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Mon, 3 Jan
 2022 23:04:46 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 23:04:46 +0000
Date:   Mon, 3 Jan 2022 19:04:45 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-rdma@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH 2/2] IB/rdmavt: modify rdmavt/qp.c for UML
Message-ID: <20220103230445.GA2592848@nvidia.com>
References: <20220102070623.24009-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220102070623.24009-1-rdunlap@infradead.org>
X-ClientProxiedBy: BL0PR01CA0023.prod.exchangelabs.com (2603:10b6:208:71::36)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aca90a1-74fa-4a5a-c288-08d9cf0d6f96
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5045007D09A85318E162D9E0C2499@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ws7vCoJL24geo4XHfU8uvVri5p6NO0QzCuKYwnuR4UhP+mQvDcHXymLoFwVLy/dLcPQWFpj0iJOzUNxjG+E3sv4ZqsDOqul2cMN1kOoAKElPdUoq/8Kos25hQjBGHlEm3bk1Oxsg8yKp9y4Ay0qNvbFyj+5547J9RQ3K7ztqI3WwWr4qhwQdLfOQyISobg0aGfUMndZUgO4DcZ3DNyqdAz/Jra0yQWXPIrc9091szwK1/HPlGnmtH7B7vCOTTEJJ8nU8FQnsEy2nyEv0RBrTqXPI5Q+EHC9bRC2F4nS7jQ3IHW20nDaoeqzwhlq6TIUnjwZFzoHzbYNU+WE6KDCqNAdIpLsJsc+c4Usd70DdX8e2NR+S2fbWNEBzrjDNFlt484xyQI2EekwXRPn1Y+gmaKspXdTI5uA8bhaPpTeEjMhfmKxyut1G3D3c3wyycXRKHyA+fq78+WMU++UgADyz+wZDbp5VY9V4L5VqbP3lI2v13aYqPWFOACZMnKKcQNngJljAGLZlNpGVW+kCfnWoNOo2URBClzkz5tVbuxsI1lJ2mQEX6WRW9AlMgc2rFFmMeVtYRZFDRu9XltJL7GAucER8KsBKCk2bqE0TkDqSox0VOPCTXksF1YAsyouW7H4EIelIzln1zfgyVSDuFXUsqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(8676002)(66946007)(66556008)(8936002)(86362001)(1076003)(5660300002)(26005)(316002)(508600001)(66476007)(4326008)(6486002)(6512007)(6916009)(186003)(36756003)(33656002)(38100700002)(2906002)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEJsNVNIR3VOMWg1VjVSWGZNQ2RrcUVlSSsxVFJPWXhNRVB6d2ltQ0pOUHFO?=
 =?utf-8?B?d2lyZllTdVA2MENyS2NZenlCMkxRRU1COEhPaE5kUWg2QnNxRDFteEJoaWVW?=
 =?utf-8?B?RlR3dXB6TkE3S3htVlZKeEFvSmtwV3NiOTNZTWJnU3VvV1VuSUw4ajQzOTBD?=
 =?utf-8?B?OGlSWEtUaE41VXE4YWZ1ZTIzaU1IWFo2MkJNTlBSdEhNK3NSWVJ0WU9na1VK?=
 =?utf-8?B?Wmh3anJOZ0hGUUtxZEZxLy9IQXpIanY3WG14NWZiK1dKMUdkaW1ucU5PTFEx?=
 =?utf-8?B?SGJmV25vb09DbmdJRUFzNVpIWCtxNnkwMmJOZFJkbFFPQlAzc2M2ZDdVT0s0?=
 =?utf-8?B?ZWNoTm1MckVrZWJncEtqMjZQRmUxNkZ3a0piWWJWUnlaU3NvMnVQL0NLcmtt?=
 =?utf-8?B?Q3VCMjBOZW1FTXJiUjdIRGJZTXltVHZWbzYzT3g4YW9Id1BMbXRDOUdxQSsv?=
 =?utf-8?B?SkMxdm9IZTZVODRneGZGa2QwY0hXSE5nQmJDbUl5TUNrSzZsQ1JlWG56MlpX?=
 =?utf-8?B?NGdHUS9Da1d0eENxRjRPY3l1alUyamRWaGhLTjBOV01lYUVuOXhuNUpmbkJM?=
 =?utf-8?B?WitrZDNDb09aWEhyM3oxNkg5L2Ftcjh5QS9FSXlvbnVjWi9aYUYwaE5wLzRu?=
 =?utf-8?B?M0Z2SXVyQzRvbmhIMTRMWFRmYXIwTlJnWnp2N0Y1Y21pejYvSlJuYTZJMG1J?=
 =?utf-8?B?MXpLN1RFZHlaZjVNNmIram5hTWhzdi9JOVd0ZnBGZHNzdUpHeFZDNXdWZ3B5?=
 =?utf-8?B?UVV4N3RHL09OanFtSDNyNTlOcFNBU0lXY2oyNEYybGVtbXFuczhlbG9wQUlS?=
 =?utf-8?B?bm00S2JSdCtlT2hHNzhuanF5cVZHTzRjY1J3L1d6ZFJXZHV5YlFyeTFyeEQ4?=
 =?utf-8?B?YjFkZVpnRXZ6bmQyR3FGS3hJREU3aStHUjlPSkhqYWtEdUhOOFdaOFlIcDBP?=
 =?utf-8?B?ckZhcGZsK2c1djVXWlA4QzNQOUVhV0xReFMxcnh1T3JVL1F0ZHMxWm1LUjdt?=
 =?utf-8?B?dTRxNTdSUUxVVzVnQzI0ZndzZDhIcVA2OTJlc1dXV09rRHUrYUJtOG9LSEpo?=
 =?utf-8?B?cms0RnJiS2hyTTN2ZU9xdkxwVDRnVVdWcUFNWHN3dVQ5cTQ0anQ5WUZra3p6?=
 =?utf-8?B?aGpEQjdjU0krWHFkS0V4MjMzT3ZkeGlVYVlzajBZc0tSNU5oK1dSMTRjQlhX?=
 =?utf-8?B?YjIveU5xWFNaRjZ0L0FycXNncmtVVGZGNEl2S0xsdHZxZGlSL2IwTkU1VTk5?=
 =?utf-8?B?azhvZExMbDdzY1BUdGJaNFkwMWM0dnVEUnUxRU5RSlBVYXZJRWZ3aXpHbDRj?=
 =?utf-8?B?eURBVzkwY1VDYmhjQlFoZWlFMXJEbWVpNFlLRFYvZ0k3MEVDbmxEaXB0QXQ2?=
 =?utf-8?B?eHVWMVlubHdqQVB1TnZvOUUvVXMyd2phY2FmYjhpTmloSEc5ZzV0Nm9acDBm?=
 =?utf-8?B?cStKK2djcWJYT3Z1NVN1QVNoSFQ5cTEyMjFOcStsUkh4WnJpSXZra1gvOVF0?=
 =?utf-8?B?c0F0M252citDRWZiZ1kyR2t1dFk4QStKM1RwMTFYSHowMU1iSjNjMXR5RW1P?=
 =?utf-8?B?NS9pWVRJOEEwUjNWR0tyUVFBTUJybUZ4cDdaMEFlSC9DRVpCdUdPeVZ6YU5R?=
 =?utf-8?B?a0tMTWRZMWJ4YUhNRlpSRHpLVlR3UWsrejNZYXlJTWh5em4rOTdhRk1LOTJY?=
 =?utf-8?B?bEtGWm01VlZDMVZ4MytvZURma2lXTE82UTN2ZHI3OTR2SlQvY1hSdWFGUlJO?=
 =?utf-8?B?dUdPZnl1KzY2Nm5wWmJqL0dqMWF6dyt6TlN0ODN0bGlYS2FPdUVTeTBwZXJL?=
 =?utf-8?B?eDlwdGduVDZDcjdCKzFXdExqNXl4YTJVWXF6SXIzLzh4OStIWkZzRlZqcmFK?=
 =?utf-8?B?N2RpbGgzS2lhaXlHS2NGWU1LVFpoNm44YVFSUDlaNllPQW9XM2tqci92ZHpE?=
 =?utf-8?B?YW13bUxiZCt1dG4rSDliMHRZSEhrenhTVUx6ZnpMZ2RVRFRldXVjbmd4TmxN?=
 =?utf-8?B?eXZTeFZEZUZDeEhHaGFORG9lTHI1dUtsRC9iWE9GRHlzODNLN0l5TXBwNUVs?=
 =?utf-8?B?V0lZekxPbkZCT1Axb0QyL1dkQ0M2cG9WU0VNWTRjK0h3REd0WlVONzNrQ094?=
 =?utf-8?Q?UIOY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aca90a1-74fa-4a5a-c288-08d9cf0d6f96
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 23:04:46.6592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLstUlaYn7WBwafHTFQ1JrCs55M4E5eozKmsw4/HCfckSviDOqO1CCzc/Ue9KoQt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 01, 2022 at 11:06:23PM -0800, Randy Dunlap wrote:
> When building rdmavt for ARCH=um, qp.c has a build error on a reference
> to the x86-specific cpuinfo field 'x86_cache_size'. This value is then
> used to determine whether to use cacheless_memcpy() or not.
> Provide a fake value to LLC for CONFIG_UML. Then provide a separate
> verison of cacheless_memcpy() for CONFIG_UML that is just a plain
> memcpy(), like the calling code uses.
> 
> Prevents these build errors:
> 
> ../drivers/infiniband/sw/rdmavt/qp.c: In function ‘rvt_wss_llc_size’:
> ../drivers/infiniband/sw/rdmavt/qp.c:88:23: error: ‘struct cpuinfo_um’ has no member named ‘x86_cache_size’; did you mean ‘x86_capability’?
>   return boot_cpu_data.x86_cache_size;
> 
> ../drivers/infiniband/sw/rdmavt/qp.c: In function ‘cacheless_memcpy’:
> ../drivers/infiniband/sw/rdmavt/qp.c:100:2: error: implicit declaration of function ‘__copy_user_nocache’; did you mean ‘copy_user_page’? [-Werror=implicit-function-declaration]
>   __copy_user_nocache(dst, (void __user *)src, n, 0);
> 
> Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>  drivers/infiniband/sw/rdmavt/qp.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> +++ linux-next-20211224/drivers/infiniband/sw/rdmavt/qp.c
> @@ -84,10 +84,15 @@ EXPORT_SYMBOL(ib_rvt_state_ops);
>  /* platform specific: return the last level cache (llc) size, in KiB */
>  static int rvt_wss_llc_size(void)
>  {
> +#if !defined(CONFIG_UML)
>  	/* assume that the boot CPU value is universal for all CPUs */
>  	return boot_cpu_data.x86_cache_size;
> +#else /* CONFIG_UML */
> +	return 1024;	/* fake 1 MB LLC size */
> +#endif
>  }
>  
> +#if !defined(CONFIG_UML)
>  /* platform specific: cacheless copy */
>  static void cacheless_memcpy(void *dst, void *src, size_t n)
>  {
> @@ -99,6 +104,13 @@ static void cacheless_memcpy(void *dst,
>  	 */
>  	__copy_user_nocache(dst, (void __user *)src, n, 0);
>  }
> +#else
> +/* for CONFIG_UML, this is just a plain memcpy() */
> +static void cacheless_memcpy(void *dst, void *src, size_t n)
> +{
> +	memcpy(dst, src, n);
> +}
> +#endif

memcpy is not the same thing as __copy_user - the hint is in the
__user cast..

It should by copy_from_user(), I think, and this is all just somehow
broken to not check the return code.

Why are you trying to make a HW driver compile on UML? Is there any
way to even use a driver like this in a UML environment?

Jason
