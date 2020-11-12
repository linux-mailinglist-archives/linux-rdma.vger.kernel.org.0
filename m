Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479502B0734
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 15:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgKLODW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 09:03:22 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14954 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLODV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 09:03:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad40ad0004>; Thu, 12 Nov 2020 06:03:25 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 14:03:21 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 14:03:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6OjS2mJThgVp1DOAEmTsDGb7SDaraJZRc2eu13nlaBupxIuwiZd6ZIrHs94RNdIXSYrcsQxzCzPHDcaDrHXqAOdVpIb6p9NKuLuDuXyH4g+OPKZDK83eU/mhqBv+YcpELL02TLtJmy1Ag9jxdUOl96IuWbkabrwxCMIzrlkcKcvCcVsFNZgcLoMg4f6jg4tjpo3HfrtT41ZsXzFvC8F06eGbvgfnZrTWvt0XasklMQrKqIHylpSXVlhiGvsKDorc2v5BLLfD0L2qbP8ozmrDHM3iVKOUrXFV9K/LLBrbCvVQCxDHUoPGe9+gHrntW4LQ5sFEDj1xUpb7h4AQpFGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdyQ2DHtt7ZdqSq6v18MuKmJ0vqiIFGFLjtEYx6nrL0=;
 b=XIH4+FjcMvi72ukRtLLtpv0XWMeTXk0emiWFCkKpuJVRd3YH8667G7s+EqBEBOr1XdbugjEXLHYHy/XLv7UQvVDvixANBzJpTk7uhNuv8I/1owjpyC0VFpVONyXrWuseSDMXKOHbLLlIGPjmtIe7y/bgjJmr6ByrwKDUbvaKoZcci+7Icv+1jyV3fbdN7vqT7wdJcS6o3uILrAMidPjYZKzEGs74Htv4LU2HCZHnbgUnH8mBWSUCRNKTP0PfdiW0oNGrt4qdGW9710xRrA/RjDSTYy1iPuZaFaiPDdQtlGjY2yF2m/xbb9xIAM/9PV+kAUkSRKYWgJgmsCXnHs79sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4842.namprd12.prod.outlook.com (2603:10b6:5:1fe::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Thu, 12 Nov
 2020 14:03:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 14:03:20 +0000
Date:   Thu, 12 Nov 2020 10:03:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH 3/4] Providers/rxe: Implement ibv_create_cq_ex verb
Message-ID: <20201112140318.GH2620339@nvidia.com>
References: <20201106230122.17411-1-rpearson@hpe.com>
 <20201106230122.17411-4-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201106230122.17411-4-rpearson@hpe.com>
X-ClientProxiedBy: BL1PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:208:256::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0014.namprd13.prod.outlook.com (2603:10b6:208:256::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21 via Frontend Transport; Thu, 12 Nov 2020 14:03:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdDC2-003h2g-JW; Thu, 12 Nov 2020 10:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605189805; bh=SdyQ2DHtt7ZdqSq6v18MuKmJ0vqiIFGFLjtEYx6nrL0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=JraR9jz4zQPoZS3U/DEd4XFXWzQu5+VjxQMSysaPVCJt0KKx0WNIDXDdxoGmx/UZG
         91TvuGlnc7H2+F1Lm23U1ygG3xBy++o3WRXrB1hBhEd9olsN7qi/fMK+nQQKsW9TNw
         +uFVIpnfxNpec68fKRo11Ni+Hx9sXcHenC/dgnraFRgxqb334svjMBSHnHOTXyqi4i
         dr+E7ZJhi3DTEd2IKKtd9qMBayFn8BrzxFqbYhjWD3aTRZi/cJbvB+yntkrOgS7W1z
         uty2JUT0CcaLfmTFHpgz+4fDQOVgw8b+Ya/+v5prljDcxyBrZeUhVpuIFyGkn8L2qQ
         1gLfHA5Nd+s0A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 06, 2020 at 05:01:21PM -0600, Bob Pearson wrote:
> @@ -171,6 +197,10 @@ struct rxe_alloc_context_resp {
>  	__aligned_u64		driver_cap;
>  };
>  
> +struct rxe_create_cq_cmd {
> +	__aligned_u64 is_ex;
> +};

would be cleaer to call this 'wc_format' or something more specific;

u8 wc_format
u8 reserved[7]

Is fine

> @@ -210,15 +352,129 @@ static struct ibv_cq *rxe_create_cq(struct ibv_context *context, int cqe,
>  	cq->queue = mmap(NULL, resp.mi.size, PROT_READ | PROT_WRITE, MAP_SHARED,
>  			 context->cmd_fd, resp.mi.offset);
>  	if ((void *)cq->queue == MAP_FAILED) {
> -		ibv_cmd_destroy_cq(&cq->ibv_cq);
> +		ibv_cmd_destroy_cq(&cq->vcq.cq);
> +		free(cq);
> +		return NULL;
> +	}
> +
> +	cq->wc_size = 1ULL << cq->queue->log2_elem_size;
> +
> +	if (cq->wc_size < sizeof(struct ib_uverbs_wc)) {
> +		fprintf(stderr, "cq wc size too small %ld need %ld\n",
> +			cq->wc_size, sizeof(struct ib_uverbs_wc));

No prints like this in libraries

Seems reasonable other wise

Jason
