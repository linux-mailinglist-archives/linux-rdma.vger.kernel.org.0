Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042A627D3F9
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 18:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgI2QyG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 12:54:06 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15431 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgI2QyG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 12:54:06 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7366490001>; Tue, 29 Sep 2020 09:52:25 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 16:54:01 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.57) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 29 Sep 2020 16:54:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmBpVj7c6+g5vFvbne6n0XgteuC9ZklzmTrgDLzYtnfAOmcMWS2tBhrWnQhnUyhxWbQB4Ca45V+PhgzE5baavuU9Dw2IKKCmKcgT1gI5AavmCfHA8Q+b8zCczjcAtJb4FiaS68dOpfAUkdfGVmuvD3NGRlU6662l2b/F2Hyw4kbiR6DyGcp4vSJYZt12VtSey5Uch4dOdZdBLwghB9WqgA1ZRSKhi8qsixE8Q9/hFtQ7Xtge5cVpdWa+/OZ0GC+4TSMdjh8ifCxsiDjL8+DcNR+q4uzPZdXifshOaD7SZ1GbTZgJawJbJcZ2tjlo1ObMQWmFAG57S7pBpr4rOgcrBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VQNJjSVw6mIVWITMYDpj6lx8KKKRQWHuBetgYsameQ=;
 b=EFcfRMB1iVGIJDXU1lbqODBjGUPuQfXAwhYV5yl+zWShoe3hsbTVmJKHgUty7P8j0McoHEkX8hK4NWOYDd/d2l7Tp3y5vj+ufznEFitx8YGDc2kOtdbRlvR4IYS9Job3QY/SHGWoH1+F1Oaz0ENNaiqpMkrFT0Tl9Il4x7dZz1sC2U8Q9qJPg14qG8nrw31a/tJad/FGY+ldYokSJkHOFFlDynVJ+Xuob4GB4UczOLpykC59/CbCtDh6cfTYEboSHBDmxt9Xl4+ER/kWrQT2sYeW3BsZvJ5UK79uzv9Hp1QwSDxF39dUu97Gqy7gnwq0vUotNHm6swPvXgq357cB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Tue, 29 Sep
 2020 16:53:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 16:53:58 +0000
Date:   Tue, 29 Sep 2020 13:53:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Support owner mode doorbell
Message-ID: <20200929165356.GA757147@nvidia.com>
References: <1601199901-41677-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1601199901-41677-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL0PR0102CA0066.prod.exchangelabs.com
 (2603:10b6:208:25::43) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0066.prod.exchangelabs.com (2603:10b6:208:25::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 29 Sep 2020 16:53:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNIt2-003B1V-RP; Tue, 29 Sep 2020 13:53:56 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601398345; bh=9VQNJjSVw6mIVWITMYDpj6lx8KKKRQWHuBetgYsameQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=mVok5INXqZB3P4kHnzqT7c0Wz1ZrtItiEq2zPOFjv0tuOD5y9IQjlKDYn2UVhq+zR
         6bzQXgtkiLXuYk/Y+2B9m3LOauNdSa+wgXebXSKK/wnZg1lW/aNkAol5xUxv3nu/9q
         0s68HKEhWfXtz2YSZWGSAbORf8kH9NxvNqiyyaN8BzLP7UazSzznVXl4xGNC5CzYaV
         Gej4vzq1VLkBb9NefoG0vZ/eLNjC0n5MaY2zb5TZjuOM1mAjuOMxTZKD7HMifO3YNY
         TvFHJ1WjCg9kX1KWtJU3AwHFly9YnuZbnzgK67WUTiT/EIqUcMn6hKJb6f4wN8oCH2
         kZtTlMNbavAgQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 27, 2020 at 05:45:01PM +0800, Weihang Li wrote:
> @@ -517,7 +514,18 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
>  
>  	set_extend_sge(qp, wr, &curr_idx, valid_num_sge);
>  
> +	/*
> +	 * The pipeline can sequentially post all valid WQEs into WQ buffer,
> +	 * including new WQEs waiting for the doorbell to update the PI again.
> +	 * Therefore, the owner bit of WQE MUST be updated after all fields
> +	 * and extSGEs have been written into DDR instead of cache.
> +	 */
> +	if (qp->en_flags & HNS_ROCE_QP_CAP_OWNER_DB)
> +		wmb();

Should this be dma_wmb() ?

Jason
