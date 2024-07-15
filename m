Return-Path: <linux-rdma+bounces-3869-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E609315C2
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B541C216CB
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F0818D4CE;
	Mon, 15 Jul 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TEU3o2dG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029B1850B4;
	Mon, 15 Jul 2024 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050197; cv=fail; b=NCRp9i0MaliLcRR9KZmGreQ+FtpGKFfkY/5ZpHjeRHlbL40hUU6g29Efavr4Y2YiyTMQdprs4iOMjfjvrDFzNlIfwnfZzgRM3DT/M2rTmFopZqkGsiMfFR+MTnGW9xTdsfPhZGEk4agsd1lRvHILiiwM4OCPWENnQV0a4ElV860=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050197; c=relaxed/simple;
	bh=66T4bALrDQQkvTch/NUs8M8aEKZIfeihjwt9L6JxHUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B80Nd1iI/RtYY3iQEXdw0Vs+7fP71b3QLC4svF6tm194tSutyPvI65WsCmoW1vuh1t+ac1a4HB9Wi+hoSjGG9t3UiIMJKpu74UoTNsbFg5wCh8ER/w6Tz1QpKEXLOqVDDERlRSrklrsfusSEtqWNArxALQANvn5eQeXZFeBwN6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TEU3o2dG; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xxw0Yg1ruY6HNijG+6cS46PwyxKzd8ByGFNxQds5BfwNDdH0k5YWHEA5wYLZohg7UBpsYLVAyJ7eGg8pelc9BTMtY528JDG2WPMs2I0e0pRgFW2qg64dY6hMk6NRTPz7gtWoQugc1sormvWr92OVreliMh33nZ5oUHdz1b5kYoCtW2TF5IjyeJLaWmwgYzWsU4HJ7FE6dpd4c0B0TnGFbelTfmcmcEKuhNbtDnQkI/iLHycZ3KV3U3iALAbeIFYVVs0N05D7CThSSHMZznDrtgpb5WEWnEM2ZjXM7i+86EEGS08+89Lz0UW5W8jNzONC99/UJXNvTg2qerUrNg0N2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjXDY5swLkh1WCOXnWzEt9/M50NiozFihmgpTMmr96g=;
 b=HEp5AFUZJn8wBVAjg3r5KTwQUaV2CPS1iGD5m8TEMpKDvSySwdYV4fO8O1ggJ1l+NvSp4kSbt4pAZCW/HQBh7WhNQAaCSxYn/uNULcg9UF309WRF3agMIdxP95vToG8r6NdTjfyhVhGkSriIgQJ/7cCVBgfbJvFyRZIs2zrxx+VrcM/CuV2Lg8poFi9cgqMeUO4gan8L6HSpkBc/e0wHUUTNouUGBK3KY4GdrYUyR+gpGpvaFPZ89ol5+Fmg5Ah/MNCI9JIUnMwcuTaVdBIHJsU813+RMc+LQsrEjpEPHwPpXNC4YphvGbuiJyVr1GXw83ngG0RCVKAdCn48NPw8ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjXDY5swLkh1WCOXnWzEt9/M50NiozFihmgpTMmr96g=;
 b=TEU3o2dG9SRdqjlU0kGHdwgWYd77eTXoWgRwKAZyHhIHONLgkKjoU1aAIcg+K3lIPeQVBnoVsrPonZME4vpa7Rq/BAmHJxptn7BA99Kc5CE0I53qeQ4vuJWI6EEvT2KPlKCdrrPypfw/srGJt2wsKCk1EI+PErUB9OThjuXxUnvUpKWRO1TNjqyY/A3RkSLXyiz7IVIC88u6YfB1xC3JqByy6QHd0bmP4878lpn86kPvqC9q/PbnIkJOcj0XbaqjCeVFiW+rF2nQF2Puh0+PKcy5igiq2x0/rb8gvIxPdo2MXLvvTRBmeUNlPuKohhoPRyE69AS20JBoXTXgO2LxQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 13:29:51 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 13:29:51 +0000
Date: Mon, 15 Jul 2024 10:29:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: Constify struct flag_table
Message-ID: <20240715132950.GA673219@nvidia.com>
References: <782b6a648bfbbf2bb83f81a73c0460b5bb7642a1.1720959310.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <782b6a648bfbbf2bb83f81a73c0460b5bb7642a1.1720959310.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BLAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:32b::14) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d18ead-73ba-4864-a055-08dca4d234ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WOv45bGfK8yt1fUkzBxnYcJGvqYfsLI3h8URJs+LDlwphKDegL00c+rVivot?=
 =?us-ascii?Q?H0i3ooRulijaIBHNt8JSrv8qVX8fIGkAMUlCb8h3x3kcEpnuvX4sd5hz/e6/?=
 =?us-ascii?Q?C0K3bMe+2tTi5jilZ3+D+Q1MG1ICn0V/niJ/H0SJC9aAvNEZFyuGGOD5wTVS?=
 =?us-ascii?Q?7fHkFP9XX3lz4yGQLjsp1OxdZvGVFtny1IuIvmUzhH5CggrnII+7C8QCOrA+?=
 =?us-ascii?Q?pOpc52127YyJhiLYYvadXEH1JYorMBNz0NFMCNb2QfaNiVVysnrVMuGVwKvH?=
 =?us-ascii?Q?mGN7SkOk7ktmCBYdccR0Yg3Yd6OO/dnX46atpr4AXNXLwNSxkPb0+Akxu5R8?=
 =?us-ascii?Q?YJ/Pa93dL/v022xoobM2YBcUaObHmtG8LCG7cSOr1oLa/xZt67OW11mzh80y?=
 =?us-ascii?Q?D5NBTDVSrTcgk50oiQXyCjm4eCTRERlxiT2x0L+ItGSbOQ32efyPB1k2eNDM?=
 =?us-ascii?Q?QEz9GcoUNyCxAgUH9oK3ggNmT0KCJTm01n/UVxs3TxA4H9e9ENqAb7Pzo6vA?=
 =?us-ascii?Q?Fa0FjUuEduJLRumDaCQ+X9n+UkCTv3tTISJ1XuNii031tapdG3Tfg52xqdKi?=
 =?us-ascii?Q?oirDOmeV157f1spf0uC76z1GIBd0SVcPZ7efF9PNvPun3MyUETlYKVBff9UE?=
 =?us-ascii?Q?7R9yMCtueu7hLh5CIySpYlwqB3HDnUVWoA8kpig+qkn2gigT4p56u1fMQ5u4?=
 =?us-ascii?Q?oKMRAazMcbq+bkGTKwKjZXfh73dT3rcYEXAm2awObyrdDNY36hP04dxwJ8W5?=
 =?us-ascii?Q?fJ4muzOVcCeJ1+zsAcuDQlI14hzaQS1szSsa4Uj0Eo+qgyX+KMyStHCgopfl?=
 =?us-ascii?Q?dHlfknKhxuYT5sxQ1WDO7kc+DFPcPUP4M0hXpzPunOWUsNuIERxpalrfSabI?=
 =?us-ascii?Q?Myn6pG127ppuhbqPhXeo0vYlgfNuQNpD5Vzp6/T8JKEjTp+Tb5X5on6qPYjI?=
 =?us-ascii?Q?cA55v7IQwqsmOdo1Q+1RgEZRgzRBBxrxO+O4k5TvNXlGKZyRaNHA45eWtASR?=
 =?us-ascii?Q?fONUgrzGVHcXFxcRT+oHX9a7if7+4fZhXMV8s04TarCrNE+8Cq/bgrLGHrPx?=
 =?us-ascii?Q?qW3J7+OUs6SoQw/8xdFg+mB+1XFX7YvkR3GVJn3qBqgXsFRL1k8DJEFpLnEx?=
 =?us-ascii?Q?kgKLHp5A1BhjqzS8gRKmxjaeBh5yzOYfLkun+VhdHbzrwngzWZRiarj4+zTq?=
 =?us-ascii?Q?UvmRmsAGhix/9Z41hojNuW3fN1sRvnZNze3hMjMAq/qhhwKyYsld+NP4ac5V?=
 =?us-ascii?Q?tNZxa1NKpPifQck4giDYQA4y9C4uBMRtrded5KuHK0vJqMCt61PxqGu3DhVH?=
 =?us-ascii?Q?f0ZM8uPtNaLe3AwFH5RyI1bgkyYl5klHoXLZS7z9if5yCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AcUy5vLcLT2+mQ48kIVowl/iYaYusvz1wuTWNy9pqeHvGk/eHr0CQ37dsrVU?=
 =?us-ascii?Q?naXeqhmzwTBb1gfFFXB8OphiziFU12npd7yOmxTbxKVHjgF+P1G4UdiiUwsj?=
 =?us-ascii?Q?LzMeGBtpE3DefzXywICgK0BkCRYq27eIsjs/OTA9CO137pCsJC87NGuqYocW?=
 =?us-ascii?Q?v66tSdh2NcbDvqkwr6Juf5HmSt6bf67bg87YYrj7QQTSLHd8x98ieKeHpjst?=
 =?us-ascii?Q?Jcc+gcgJE/4u4cJKBb0W697OZKj63XSVbNP6W/eFt1LkjwJ7ZCCysDOkQBGl?=
 =?us-ascii?Q?obsuPmwUoj3XyrFsah4nYcNoBrww933ujsMRokqtM+Jl45wjkDHuZLgdwLc/?=
 =?us-ascii?Q?yjcoIKfJ7L8X6qAK9OcfwI/9DKuJxhC85XrUf5zMzwnb5eaNLD8ZZhSzyLpd?=
 =?us-ascii?Q?LRXUo8CJo1lBSqlxqnf8pspIIv0fCDcdrvQHvvPlbIVmQVi0n2hKjufhUAiK?=
 =?us-ascii?Q?+2ZgsKxHq0OBKxj5xjj5OMiE4wjecLSTQFNIIBTO2+EAnnRQ3BqI559aLlzb?=
 =?us-ascii?Q?uWROAdb102nNvPg8Qs6hw9dtLm2SCAb5RZhLtUjGYjA800DPOc1zzqgQA1iN?=
 =?us-ascii?Q?kgrNinDjbU0hkq5A4g+b1I67OfmT6HiIyMIU+bvTSH2THycXaxidlQVIJDhg?=
 =?us-ascii?Q?LghEDx+/UT/fUTMe6rK9JC5WzChdkEOrMUAgIe6JUCzPZ/HYI2DPKu3i+aKJ?=
 =?us-ascii?Q?JMu+U0F/X+j8FVFaqcDNTRASo4+GJutwFJpvpcnu1QNOdfg8VxBtu3446P72?=
 =?us-ascii?Q?cXaNFN1RyYdxEtTwqH2d44i9jTkDH+rwn5klt9C9bEuAe5LHZy3uzK+zrLn8?=
 =?us-ascii?Q?rtJWfWXn/YgUxwBGcfC67o3LRopu5iF5UP9ub7CdSRDzGs5TewCv5fHy3nmy?=
 =?us-ascii?Q?MEDtHfecT7u88rFiNItSh1C0wrZeXf8FL5FDzRzF0kJlM4AkEw3cVoMDfIOI?=
 =?us-ascii?Q?aiASXFDWdVQqUimg619Px2obbErX+D8rOC3bJIsnpcumMvc+ub4H+asf16QR?=
 =?us-ascii?Q?wqLns2ElD62/sjnpg8Of1wKhprs2CI7xz1nqe5e70II4bfFCdbjjhYJaZx4w?=
 =?us-ascii?Q?jH+uwaf3rm48EFFtF/nogkSSQUe6hKKQIFeVehTr0rGfHCvykcRin3B1XFwr?=
 =?us-ascii?Q?3+i+FFLyvdWLAUm02Yfez3TEslfFuXaC0MHUNpbLy81j4N5Aeym4sxm8Z+BT?=
 =?us-ascii?Q?4J6wh+87sCy385sin3xQXW2rVGftf0i1Yc5aa68tz1MkYoZeSNEajNY2NgwI?=
 =?us-ascii?Q?MuYVCO+MKTJzMujQyEN9Eyx2Szq8PtQ4uqo0N7yFo+aogA4AWnQxycDkoT3F?=
 =?us-ascii?Q?OACocjBGRt4oQuudUM+pz2LMFdaKOqrWMspPHRBaAfwI+amvxxunrPjfumH2?=
 =?us-ascii?Q?vm3ANFYf8flvDF40HyoyBqJ0LoaPWteW8HsOkfdbiNUnLpO9M8pAcHrUOOhV?=
 =?us-ascii?Q?6gyhunSPAlhO/6WSV+EBMBvLSKr+V0YLUx+WdF2SZdFmMj+IpvgC40Th5lAY?=
 =?us-ascii?Q?Dv5X2mz2ycP4b3Vw204wWK+6qU6x9mN47e+AHCPn1PgA0ktzQvGFG3H9CTtI?=
 =?us-ascii?Q?bE2eod3iMoUmhfEmOG9MdBFLMs6dK/TFt8VvWP6P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d18ead-73ba-4864-a055-08dca4d234ab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 13:29:51.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uc4bveEN6JcaIq5Ece+Rgps1RoGpFRAyW1e0j3WyWeN6rRVc619Paiz92zOMkpi4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

On Sun, Jul 14, 2024 at 02:15:25PM +0200, Christophe JAILLET wrote:
> 'struct flag_table' are not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>  302932	  40271	    112	 343315	  53d13	drivers/infiniband/hw/hfi1/chip.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>  311636	  31567	    112	 343315	  53d13	drivers/infiniband/hw/hfi1/chip.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only.
> ---
>  drivers/infiniband/hw/hfi1/chip.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Applied to for-next

Thanks,
Jason

