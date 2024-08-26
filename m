Return-Path: <linux-rdma+bounces-4566-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6393B95F298
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 15:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0DB2810A8
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE33F17C9AB;
	Mon, 26 Aug 2024 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uk3tXB7b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3016F31E;
	Mon, 26 Aug 2024 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678201; cv=fail; b=ik3LIOTZPkCnTpEehpadY1YLarfbRXt8SaDlyW+DaKKIjKMGI8KRbgGtLoVF4TbFEJy7MY4X+XQaVF+pMxetyPn2PVxTIYvtfnm2hQ/Z9JZfBJj477kdr8LE5n6qiH8eWMNa7uDLy1irMc0NS//MI3DQANxz6M+hPp8VmlyGTkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678201; c=relaxed/simple;
	bh=LmfwZSoJaJexc+HW468+UUjSwAAKtF/drMJ67p5zgaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m2oBaoX2xbIJAjyXxE/05aloLBRaL7MseDhR0ff4u7GDd0K8Q1Ety6Y2tmRCSELBvlWWuMMHpjFnn/2DHg+aE/NFIJhsrMc9kkQyRUkHOkFM3kFGes2esGvs5D+4JC2BEI5LuomvJuyd7bVmVKrNDxOHw2xP7JX5UC5iTkcTw5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uk3tXB7b; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6uxE42EWcKo972JPkfq9KcbVx8CQLbYq/OkrwakIEO6nhNItHThAlf9IN9IadGCSJqg5dHfHa6k7uu/h48dy3RyKYlpyr7i5ngYpDGQsfHXhjFE6Fz/bmaoCUcyreaI9eJKbo11GLGjKn1LAhtRJ74XaQtSZFljfgmjjmN12Hyqc7A7jLEgG+7dokvFIlyMywYw4Xj/ti/6QUR/to1ZuMsHL17RNQqftqfeOUSHFVIOcC0C4gnTSPVEcxTn/GGGmf3cgg1HIGrdmDcXvrTdefEXco2qQ1aZwWcSWP/af8KWltSUVfLPUHRYBGsYI5sTu9j/Fe20imM4JyvHE94UNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eihdWNSJv/TNB7zn/IyEUzMA13YI25kLXCI46OjptEo=;
 b=RCNdxGzpXio/p5tbA1P7IeDPHHfdYP+uFB2RCB4OOlcV22/wxdRLUsdm0HTH+7LtRoNBeiP8jGg4lrj/WzktpA46DR05fbVXW0cxlpPDATWv1mt6dyDjgFSmv1t41NcfmsPS2iNFofOVe0uNV0BoorMvaPVeXGNPKBWqQ9fSLbPyNOu03vge+l9iibD05EwYAzJLCOH1gCZlFMUe9SYYsyDGjBvuHq+U98MY+E5SdObCplrSa1IapSulYOSkuAR2Nn9FTv/keLOADpEwVAD/61TH159u9veFiJpNVeGQxUBwifbCtv1Fb6+TI7umpSTGsn7uUTHpiZF2cdSEJOpspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eihdWNSJv/TNB7zn/IyEUzMA13YI25kLXCI46OjptEo=;
 b=Uk3tXB7bhidSxqq86ng68DPZG3+W1UcX4Adlcqc+kW0V9HHIJo0bmFG3AtxWTizZvYQ4xO8epuxIfpl0AoC7H3bC+09UV9oGZ6qz/+7qZtJZwtmxRIN1ZvOJp26y0RIm8AElYaZN3QUIkeN0uEBbb3T75IfY/rjIHOd4JbzdKgc9j0CPIsI+xrXVlRzQEmONzmJRQQxfXs/GfkR8cAJEyLJyx6oSkZla7os1djvo8EIOoitb3EQEm4VCYIjX/9Iuz/RFbI7V+6C1CPiUTN+/zB1mW6czK3d8ji1laAAkTta2wnVYyNmrFClKusgiuF/qnBmrXwM8dU4O8yHOv/+lvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB8919.namprd12.prod.outlook.com (2603:10b6:806:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 13:16:36 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 13:16:36 +0000
Date: Mon, 26 Aug 2024 10:16:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for-next 1/3] RDMA/core: Provide
 rdma_user_mmap_disassociate() to disassociate mmap pages
Message-ID: <20240826131635.GJ3773488@nvidia.com>
References: <20240812125640.1003948-1-huangjunxian6@hisilicon.com>
 <20240812125640.1003948-2-huangjunxian6@hisilicon.com>
 <20240823152501.GB2342875@nvidia.com>
 <29b2b4a5-7cdb-4e08-3503-02e4d1123a66@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29b2b4a5-7cdb-4e08-3503-02e4d1123a66@hisilicon.com>
X-ClientProxiedBy: BN9PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:408:fb::16) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3816c2-d15f-487b-4141-08dcc5d15015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pj6vElOsyUtMLAcIVh5CGX19TodDEXjsffBRa1GSIFn6IsIv0LMmCApQeStl?=
 =?us-ascii?Q?9Yz9SxZxUoLm9TugQhyeitq8T9p2BJaDgByTcWvY2Pw8fg8E/2ecqzlbQu1A?=
 =?us-ascii?Q?rjEtVzCI2pfqVoymgHqSeWyCRVm9wa4O75NAZ0zT5+/lS0biFi7JFW3GClz4?=
 =?us-ascii?Q?mCqUSfYhNLCa5r3UwRvSCkXLIA8NyxiT/X0RpIu/Uw75S7IdkV6klF0c7NGn?=
 =?us-ascii?Q?bLNBZfN42lbEJtXGLbsGDAFWp5DZixhdxgwxglM9hKRDVqJbO/dUM1kSXZ7/?=
 =?us-ascii?Q?zsyisjvNYWR6uMZprBuso0WSWeVqcJk9PQdyF5AC8E3ihXvHK0DpuAt0HX8S?=
 =?us-ascii?Q?lLVL/UPHZ4uJz+YDyJyrp44vi1EjM+tua581lUnqk0PROaJy0Fq1knHdJR3T?=
 =?us-ascii?Q?PIfBbTV+qFmOdrpHbQKq77F/B/ypNZH98fAEK0JU2tOmV+7Vls9q3xkn3ph4?=
 =?us-ascii?Q?wRMErgVkEpuUe9xQOotkUERF+z0PHvw8qyiUa07NSfhcYjMVJsavPnWt56OJ?=
 =?us-ascii?Q?LBC0Xam72erDSpRZ1HJi4HrDOBYAh6eiMPD+rFMxjY8tKDBaFn281TuEFzSy?=
 =?us-ascii?Q?Ps2RDhw59bUkiYO+tsP9LFn+Zr/R60grIIdJLTnD2Jd7m6g2wkhZSsmudz47?=
 =?us-ascii?Q?gJ30Ut+HWir81ouNOnp/BRFMW+2o6rF6jkgmFwHuqzGJFTRCDR/wdrzlLVdg?=
 =?us-ascii?Q?iPjC1X65BCdMAruFb91NXaC3yzasTtQYHy22uRs9oovPZUt1gPDRXVpIK10S?=
 =?us-ascii?Q?KhGcvTrYjlBlDq31Jsf1qJ1xUbhF0S2LnNkhGFogAnTGu6TgIYq+PVwTvxmq?=
 =?us-ascii?Q?+wZxAMWnRDCfE/99OqFdarRTm64vTFo51e/FzI07OXKmbAYv063Sj/OwUsoN?=
 =?us-ascii?Q?fpuNW+GBD0PjMxh54IXkBqjm5wMI40oBVJO86l6icAKcCkDU3Tu/R7Irv0Uq?=
 =?us-ascii?Q?w7ja/NTSSmZBv3m55wW+QPaxYo086MUC3AOSqq2Qnf+yk50iGzt4EgkSo9db?=
 =?us-ascii?Q?A4hoVghJQnnppBjbINe75/G6yQwKvMdPss3Qi365DlNbqsVm8b2ygtKb0Mp5?=
 =?us-ascii?Q?iIg7GKjd7SKGEwmjkl6HZdpOBSW5OtXhDzFjALsX+1LKITiGEAinWgv9yP1L?=
 =?us-ascii?Q?H2qcd8wC6+PSo41iZZ1G25eat7xyp6DkwFOvFjkcwwc1uKaxZLPDWZXLPzuz?=
 =?us-ascii?Q?P4vwSNgNNmamobFIUI7KyrxRaRwjzx2JJsQcxlmWo3hxpyRIM4IrUxjr0yVq?=
 =?us-ascii?Q?NI92O951u8mEpty82AI+/oHmfoJ6SKdThFrHBtNnbmlNbnECXBdj4xjhGQJS?=
 =?us-ascii?Q?0fKgG0eRS9BaPTlq0YOAu0fpG/XeICNrkEXa315S1qYEZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bfT5oELBNN+4JLtJWNI/MLrVH9iSPbaPgjPGZc6Iin0K9/bUSmV9wRDsyj4c?=
 =?us-ascii?Q?jbGS7ut6cggBzWoO/sfzNVLpVLBHsm5A72PwBfWa4yNSERy57sX3MZTFZktP?=
 =?us-ascii?Q?Ozetpyf+kT9fB4mHbpg2f1PsPgMGRoqY/WUDz7TRJVwptK5X1+0vT10OYB9A?=
 =?us-ascii?Q?NPTxYk3ObbMAIPcOPCHRuWx7zbtKPczFVSfVLK9gI/53lHe5/MqZc882Kotf?=
 =?us-ascii?Q?RBrM6AspaXWrI+sr3VVRuXSBIn/vfWZkGNKrusOu1vs3IMv4CrYgSkFbVRI2?=
 =?us-ascii?Q?K4Izvz+L+4cdfOtGnz2W9+eNgOEbf/dJkpWbjaL0SeO6/vLgNC/78iEbA3TD?=
 =?us-ascii?Q?odWBh09JrEOckrqJ2kvXwitNxUqUiev0Xj2ZJ1R9IGfPyAcIk/VzvPn4x2vO?=
 =?us-ascii?Q?Y8lw6TsaxLzb1RZE7gV/Jyz7sRJoL+/dru/3AOOFg4nazHdv8a372IhVSImi?=
 =?us-ascii?Q?jzvVfhlFVv5+OSi5eH5S6EnhI8ARf8llFHhHEiGh1fjQUqfsy3w3NXdSybSO?=
 =?us-ascii?Q?gDXFDNAA2k+e1LhpfOsW0JZgZxnDDfkAt265i4SQjJcwrP2sxQ+7T4iWcN/V?=
 =?us-ascii?Q?eBZOINym9MjZjS0rMBYpt7JgLrAOuBN+jmFmqeDABN8giSD/An8R//8PEIu2?=
 =?us-ascii?Q?QuagjxVmw5hFPQesDYGGdWGW4Rx8Lcysl1NxLw8gavej/KZky038HlJt/5hx?=
 =?us-ascii?Q?nk6/8Wbv6+728Die2TIMgIhDDzIGP+FMoxqDkeovGPfyN9Hb2W1dcWLPqv82?=
 =?us-ascii?Q?RPnJACZ2e8vDbBrq2PgTTK9hkqsp/gQPNctfxXxY9AsZqTO80RDXGMtWBOzF?=
 =?us-ascii?Q?7o72aEOaSlUWJrURYa/wBL+6SdTo0+NKs7YtNemNPsPYaXMssUpI0ZqKzFFm?=
 =?us-ascii?Q?bz+Gx8ZVR/9N1jg3pVp2dGSfKWOFCofdgvIQ/7WzePTSl2qzu9DBNQzFZ1vm?=
 =?us-ascii?Q?I5/wpa5/ZXiYAxJChBqbeWJ3m6RQ4eHJi5nmYguMfsD9E2WMoBxzKUt5e+na?=
 =?us-ascii?Q?vz8QQPHDn77a+WFb5jffokqtkQFuy/uh3CrkUDtnynFcpbYrNMPkIBIsfuVa?=
 =?us-ascii?Q?uNxwdF4bB1DvszWzwveB0yCfiHokJqroS7H9lRusB/k7fpEduDxwcYXBLyuT?=
 =?us-ascii?Q?Z6a8FVCGkt990jjGZ+UGz//CTrp6Ji0EXuP/Dxj1KL26c/QATTby7A2SP4Ll?=
 =?us-ascii?Q?W8bZ+7GOMQdJdt/WHKwcZPcyjSGbUlsYhL83VZMRrgOLHX+u6PMtRH7Ae5jo?=
 =?us-ascii?Q?yMAtUSf4SStgN9d4VD6ImhbrKZvKxX5NjKwZwsIs5iv4inI56m0LYahUDdov?=
 =?us-ascii?Q?NyCIJCFh85EpB9/KWwg+9Kq8SzlkOP7hDxvQv228j0u3Z5ToMmLbsEYd/QYM?=
 =?us-ascii?Q?vntzmK72GuZAzFajOL9IH4JLTZKrrG5HcY5uXR/q/eu65pFDoe4u11URKNU9?=
 =?us-ascii?Q?WpGN7SMRVJa0VDOmIFgeW0xGh9qhVTHXdhG9e94CUr8gY7M6Xqz/bjweqO3e?=
 =?us-ascii?Q?TyBkh936+QUc3t2mmOzkEylyTWB7bADRu3qxHUfmH7Q5U14Nh12/FvQ9vNsY?=
 =?us-ascii?Q?kg7mERJxPsxsT8QS2nOXNVAVbkLngGb0gjfEKLar?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3816c2-d15f-487b-4141-08dcc5d15015
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 13:16:36.4289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfPjK5MPxu/xIFyZJRhRcIqL2k/OlhZpZh8DtdwhNeR1aVQXhN+AQsTPRN+Kr61a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8919

On Mon, Aug 26, 2024 at 09:12:33PM +0800, Junxian Huang wrote:
 
> diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
> index 821d93c8f712..05b589aad5ef 100644
> --- a/drivers/infiniband/core/uverbs.h
> +++ b/drivers/infiniband/core/uverbs.h
> @@ -160,6 +160,9 @@ struct ib_uverbs_file {
>         struct page *disassociate_page;
> 
>         struct xarray           idr;
> +
> +       struct mutex disassociation_lock;
> +       bool disassociated;
>  };
> 
>  struct ib_uverbs_event {
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 6b4d5a660a2f..6503f9a23211 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -722,12 +722,12 @@ static void rdma_umap_open(struct vm_area_struct *vma)
>                 return;
> 
>         /* We are racing with disassociation */
> -       if (!down_read_trylock(&ufile->hw_destroy_rwsem))
> +       if (!mutex_trylock(&ufile->disassociation_lock))
>                 goto out_zap;

Nonon, don't touch this stuff! It is fine as is

The extra lock should be in the mmap zap functions only

Jason

