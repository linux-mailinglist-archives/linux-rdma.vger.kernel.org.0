Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE6C2852B3
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 21:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgJFT4A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 15:56:00 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:37676 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgJFT4A (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Oct 2020 15:56:00 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7ccbcd0000>; Wed, 07 Oct 2020 03:55:57 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 6 Oct
 2020 19:55:55 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 6 Oct 2020 19:55:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETWEOsz3E/xKWbWaEFZGjPy/wc8WugGxa2MjvZOC3XAFxNRLThIYoCesDmrz8N6O8NlH+uCiZ8TZsdvogJoBI/akWhqkVQNu5mM1jSzVZ/sd4Zf17S0R+twEfmcSps8dtQd0D5sQ9+9Zix4uo4KO5cGPLrLAp6w8wfH9loyxti4JmN+LjUH6rFjE6aQw+bYRrsRbPudyqvxyXjDcfKevWKX7rvj+pwtY+igVySD6fvq0wKQqRFiVcp2TPrWPmyBvcLY8F+NBrgNOj6AiKDUIw0ISsxBUzBcPY4CUMOgNQ+ousxvaORX1+U+/YYRdf75t6auG2HQS2kgLXLJJFTMuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKRTxqLGJrEYJRI40HZjpf+CSEiVSPxYLvV5hm1ZTt8=;
 b=He0LoiqkLvcPHtVE1p7BdxYYh0q2xrlIes4LrWptBZKb0rxsZwla2q2f7WADRmCW9/rO08YKChO4QIZLbM8KYjuaE+sW81IPm/3pxsSHf3U+WGu8UpK9+iPmng5X1OyjMCvjh9+hnZAxPrlsyoCHlCdsecd8ARaVfwhPgFqLfnFg2+MAA6Hjxgl8K+KtRVJR3+EnxGw74yZJMcGmPKIfsIZIrfO6Rvkb44Mz2pLzusfCwCZ+7c6Wq9xQysWhWj52BcZ9e5lEnn+3c7WuPD0TEk8nxdg3V9gNMl64iZDoMbm2JxWXX+mcdJIpnctsmo4IdXea9/atOXnuUdqmga6DoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Tue, 6 Oct
 2020 19:55:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 19:55:53 +0000
Date:   Tue, 6 Oct 2020 16:55:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 2/3] RDMA/hns: Add new interfaces to
 set/clear/read fields in QPC
Message-ID: <20201006195551.GA161726@nvidia.com>
References: <1601458452-55263-1-git-send-email-liweihang@huawei.com>
 <1601458452-55263-3-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1601458452-55263-3-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:236::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0046.namprd05.prod.outlook.com (2603:10b6:208:236::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.16 via Frontend Transport; Tue, 6 Oct 2020 19:55:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kPt3v-000g5S-6K; Tue, 06 Oct 2020 16:55:51 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602014158; bh=AKRTxqLGJrEYJRI40HZjpf+CSEiVSPxYLvV5hm1ZTt8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=YSADWxr1jpUBQNqsxUizI3zYTyqZlpCIhkDBophO4CatlYvOK6t++zZ5XyB9Nx8o0
         kOEXbTwEPZHXR0aF3rP27O9EFWpPpdBqOr4uI71KVMLeK5La9bL5eanjTWEN39IxKx
         zga2THOC4aUe4+qqKpQ23lZFNiwfKKq+lGqgyNlQ/ZCtSMS+ehNUjgbxke8uet8qOw
         pvN+C6hmmRRzqS7qm/HgrxUoD3t9fpaWc4CeSySygFNp7YnM7RLAwRFYSFkK/gmrB2
         TUwqOXd7X/HkZyI7ZTIAC9nZW/r4r2Odd1WAfxSVHaEObgwt6B8Tax1NT69Eb4TFI6
         H7rEjkuIV5DzQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 30, 2020 at 05:34:11PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> For a field in extended QPC, there are four newly added interfaces:
> - hr_reg_set(arr, field) can set all bits to 1,
> - hr_reg_clear(arr, field) can clear all bits to 0,
> - hr_reg_write(arr, field, val) can write a new value,
> - hr_reg_read(arr, field) can read the value.
> 'arr' is the array name of extended QPC, and 'field' is the global bit
> offset of the whole array.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_common.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
> index f5669ff..ab2386d 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_common.h
> @@ -53,6 +53,32 @@
>  #define roce_set_bit(origin, shift, val) \
>  	roce_set_field((origin), (1ul << (shift)), (shift), (val))
>  
> +#define hr_reg_set(arr, field)                                                 \
> +	((arr)[(field) / 32] |=                                                \
> +	 cpu_to_le32((field##_W) +                                             \
> +		     BUILD_BUG_ON_ZERO((field) / 32 >= ARRAY_SIZE(arr))))
> +
> +#define hr_reg_clear(arr, field)                                               \
> +	((arr)[(field) / 32] &=                                                \
> +	 ~cpu_to_le32((field##_W) +                                            \
> +		      BUILD_BUG_ON_ZERO((field) / 32 >= ARRAY_SIZE(arr))))
> +
> +#define hr_reg_write(arr, field, val)                                          \
> +	do {                                                                   \
> +		BUILD_BUG_ON((field) / 32 >= ARRAY_SIZE(arr));                 \
> +		(arr)[(field) / 32] &= ~cpu_to_le32(field##_W);                \
> +		(arr)[(field) / 32] |= cpu_to_le32(                            \
> +			((u32)(val) << ((field) % 32)) & (field##_W));         \
> +	} while (0)
> +
> +#define hr_reg_read(arr, field)                                                \
> +	(((le32_to_cpu((arr)[(field) / 32]) & (field##_W)) >> (field) % 32) +  \
> +	 BUILD_BUG_ON_ZERO((field) / 32 >= ARRAY_SIZE(arr)))

Why add these functions that are not used?

Jason
