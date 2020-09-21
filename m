Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC212726E7
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 16:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgIUOZw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 10:25:52 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:1762 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgIUOZw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Sep 2020 10:25:52 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f68b7ec0001>; Mon, 21 Sep 2020 22:25:48 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Sep
 2020 14:25:48 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 21 Sep 2020 14:25:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDMxqzX7HhIXoXhcKMWdCGkX/QkYjHkIGSn1+L0pEBcuG7ujl7UNOuHVMBSjurd0758V1jiy6UxyPBrXr26ckSCj3VBV+XnbI4kpVCSs3T62IfHXuC9nht2UiL23o09bANiL6lIoZUygZ8g8/jtNIey2lNKgOG8JAL/S2MMHzrkO4QwZgwoxNQopC+8H8++BaBumr91GteiKBdxI0MWouxvfUnjEj6nFLiGDYlzGi6yfalFnB8kisTKi1TjdkkRU+H/C+N9Ht/cN6WwWoWtWCkznb0O9Lsx4FWwzK+wtpd8PB4Ywl0i6Pk6AI+Eg4C7IrwzHzgvN8NyB17tw8ixKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NOlBnpTKh6QVbntJCkEq93FF/6BbUXa7Snw9zM9llE=;
 b=UaGCLwgqNOzHlbPqwXVaaDL1unkW67XXY/6Qe9VlhL0scYJyus9mwbPTSI4ALULAuP7Yuks7AahC3P+1bxwAX4IEJH+o0lPZ5tPFCxeYaMHXTKBPeQFSjGz4L7zxXxdnu8epbKVv2bnArEItoHEArwvby7BqnTrejdhcBGsMiKMYg1mrCNohyLFGKxTJgM2IEhIz7FQhLtvUJyxau72sCCnhcSinJb/No66TCQWoAyW3fWMJD3/qqA033NP/o4DfT03Y+MYqmMLa5/XjB8zyNHefOQU5d5uzB7XOjJGhDQT0v6FM/3VNvnAyZ6UugwuKRN63QMjCHSxjcecl1SJIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 21 Sep
 2020 14:25:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Mon, 21 Sep 2020
 14:25:45 +0000
Date:   Mon, 21 Sep 2020 11:25:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Yishai Hadas <yishaih@nvida.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH rdma-next v1 4/4] RDMA/mlx5: Sync device with CPU pages
 upon ODP MR registration
Message-ID: <20200921142543.GU3699@nvidia.com>
References: <20200917112152.1075974-1-leon@kernel.org>
 <20200917112152.1075974-5-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200917112152.1075974-5-leon@kernel.org>
X-ClientProxiedBy: BL0PR0102CA0056.prod.exchangelabs.com
 (2603:10b6:208:25::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0056.prod.exchangelabs.com (2603:10b6:208:25::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Mon, 21 Sep 2020 14:25:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kKMlD-002dbP-TP; Mon, 21 Sep 2020 11:25:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c469c02f-b094-4282-0313-08d85e3a3a54
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2438CF83CE398B576E156456C23A0@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XW+SOUduyAY+SLRsWOap6DqxMF1VsN7ETqpXnFPysJABxJy/PT729mDcAO2vF+ERRvYaepr+A8B9JZCiEvrz+nht/w/gU/THvtGABYGovOTqtmzRY21Vx91uRk87HCQDb2BTVi9lfO15SMKCVcVgzzd7IQ1hGOxeV9/ChSc6/V2o1hUP9fhyXIrVVJkJIZTXicI5M/Qnv4b/Rcx8P7gUzz3d+1L/CbxPKFlar6gQDsfyihCynaLYMOaf1u/WiWOQYQXYbTtM0by8UlQvKfdhqjwlikXy/wpZYodCMyLW5HjGz9mmK++Uy69PYpHsn8wNtQzSIp6jVo1YDLBhtMKl+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(316002)(66556008)(66476007)(66946007)(9786002)(9746002)(8936002)(8676002)(1076003)(478600001)(186003)(426003)(2616005)(4326008)(36756003)(6916009)(54906003)(2906002)(26005)(33656002)(83380400001)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ghKf3TUspp9l6X4rBs/G5IjZ0uOc0Myn8iAbB44D26nLEfTYQNo5OhalPKXqGsGueL2u2ER9f+f+K0lQNnnxwT3b3vgDnUWQ0rIPPuRK5ZtlUDOEBzM3jK8jzIMjdkAUiqa1J8K7kJJ4gXqaqjJ7aTyykaM91Pei4UitmhlDyAWYp2i5rntlBWlXhXn5X7tHVNbMSSi7ibRNRM1sVmuLJYksEI5glvuLOVJ13V1mTMQQbGWcHDCnl0z9tQhWsm96W/7yxNdu5FVAdq6qkZyGjeo2GguDZABIaF7tg/JSfLuo2+clK+sLz4dMrPhBxfrrOy1kIqOIR7ALRkOIDIojTEXgqaoQJROX9nmsu1BEOTp0/53BEWSirMfULbEHPAudSd0PE9dE3YMN67pN+xLAvEBiOZ6bH1PTAfoFTEvrzNir23vkI3mypR35VE4atNipGodMZY3XLtKV/INyUPrqyxB9cT5N6akcia6m9Iwyr2DMS1Y2GG2/TAWPLAHEuuzHjDvD/kKdjpKodGcVjyBM8+91kC/p+7oxyl/oR8Q/yzDMSElhEJl+4dIg7SH1MBqOI9+D1tL9arQta4Rcv0aGVf1LOs4a6a73SDZ7t51Jlt88H8dJx8GGSWzQ0Z0yBfYjmSOW/IbPSOE1Ya3CyzPQKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c469c02f-b094-4282-0313-08d85e3a3a54
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 14:25:45.4012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sFXnhhKjs+OazhxZnI0/wWo8oMfJZAZbKdPzvEOGTx3fl+7hWGi99k+h/7iRSRe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600698348; bh=3NOlBnpTKh6QVbntJCkEq93FF/6BbUXa7Snw9zM9llE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=HlCvRSU+UX39+GIJKjagLMzEtkHAfR9wYUHdpNvdN2pwtl1Ldg19pMwGL7jRXsUMD
         apYa6JPfB+slxy1OMn35pvTrSFG4KsHRnA/dcwiLLTSACAPqJ1pM/ZluLxuxbqjzr+
         NjkWvF4e25Q9GF8CIkW/H1fIBnaU03D8RyYYHYeIz+84fuhwlyFvjofJNYnggTCag0
         KPSpi5JkxqlSJsUxFLyOwa4bMjO/F5EeuyaCzoLzBcwMSoBbzc0gUsFJi+4+aWbIY9
         AODCiEeX5WYju91XF0p/AE6Q5oMCRsYSXwWgeGmuxzpLRAbUeuf3BzFDMVdFmkMHjc
         D7WgzzF4GU8Zg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 17, 2020 at 02:21:52PM +0300, Leon Romanovsky wrote:

> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index dea65e511a3e..234a5d25a072 100644
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1431,7 +1431,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>  	mr->umem = umem;
>  	set_mr_fields(dev, mr, npages, length, access_flags);
> 
> -	if (xlt_with_umr) {
> +	if (xlt_with_umr && !(access_flags & IB_ACCESS_ON_DEMAND)) {
>  		/*
>  		 * If the MR was created with reg_create then it will be
>  		 * configured properly but left disabled. It is safe to go ahead
> @@ -1439,9 +1439,6 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>  		 */
>  		int update_xlt_flags = MLX5_IB_UPD_XLT_ENABLE;
> 
> -		if (access_flags & IB_ACCESS_ON_DEMAND)
> -			update_xlt_flags |= MLX5_IB_UPD_XLT_ZAP;
> -
>  		err = mlx5_ib_update_xlt(mr, 0, ncont, page_shift,
>  					 update_xlt_flags);
>  		if (err) {
> @@ -1467,6 +1464,12 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>  			dereg_mr(dev, mr);
>  			return ERR_PTR(err);
>  		}
> +
> +		err = mlx5_ib_init_odp_mr(mr, start, length, xlt_with_umr);

No reason to pass start/length, that is already in the mr

Jason
