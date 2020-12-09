Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F273A2D4C88
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 22:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgLIVJv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 16:09:51 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15912 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgLIVJv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 16:09:51 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd13cf60000>; Wed, 09 Dec 2020 13:09:10 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 21:09:06 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Dec 2020 21:09:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMfZXJyRofdOYos7ImlNsmCfTWrOuriQ8uKkMN6jxn/TaESRnhEtXT1BuqLAy7vtWPaQsK9N4FWz6HaitKp4Upc1nxzdtY4FYd1PyST03BZbh4nFafmsr7zwUsCRjH8jMMJf25VoKIjeCjOqWkAf89KWkkzs7ci51xYUHgXmn9G/23b2aDD+jtyoHQtfcAePUfQh20akNAJ66onFfcHrfYUUrubJ0d1bvBIAxmqCmnUKEyeRZJh+MO79Me7JZUHyffMgpifnekKHq7FmC4hxIJFMGaBW5zgDYoJ3vpfLfVZdeXFel0mwfHbsRBC4rYXWo+V1i0k2hGpaINgDrHE7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U70Rxu2xz8MpWJK6lf2pOtN2LJJsqRe+6NYqIFhowoQ=;
 b=HGQMOaFZdvk5IDneaAx9UsVjYxAdlZBs0TaKT3DOOt68sDs7pQRCrc6CXMW641qNK7vTcVPRG6VlvBQW56XVargfkhAPctfnsofBUh3q45ARfb0OqZGH+PEh4qA0qFnZZjgaKVgvFkY6KMCOs1RChj1EY0Wd5YMUYjftNXGAakto1+7nGc7Mr6QbYFhgTNaKNsoRuZkmIr+tORW5FlY+Ds8mjKjo7tUyr6qB9WkfTWkS/qdREJNL0YbFGjOGKVZfWjvnqwV/WOlt+FW3vjXGaOAal+7MHTbxf5DzGjzJUK1pRbJiZNkRFc6mdEVVtkxXw8yz1/3CNVTx2qWEAkcjGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 9 Dec
 2020 21:09:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 21:09:05 +0000
Date:   Wed, 9 Dec 2020 17:09:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 05/11] RDMA/hns: WARN_ON if get a reserved sl
 from users
Message-ID: <20201209210902.GA2001139@nvidia.com>
References: <1607078436-26455-1-git-send-email-liweihang@huawei.com>
 <1607078436-26455-6-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1607078436-26455-6-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL0PR0102CA0011.prod.exchangelabs.com
 (2603:10b6:207:18::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR0102CA0011.prod.exchangelabs.com (2603:10b6:207:18::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 21:09:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kn6hq-008Obb-T7; Wed, 09 Dec 2020 17:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607548150; bh=U70Rxu2xz8MpWJK6lf2pOtN2LJJsqRe+6NYqIFhowoQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=d7XQzOBHftCAxZqjjuTEDxcIANUHhunp05/gQGFeyZ5aL2xMD5dEHspF0lke/X/NO
         iTYucyjpkSgeUB83f48BhClmFPTmexVyHbf014uaR7WsadZDq3HOzmOhHC88xTHGyD
         NkmTPCIddHuup+AhGPv0dz+YR+T+zRqXlsZtqFukR5K3vf5dkb/hu3zlK7j6d53MGy
         J1doBhI+SLJms9hYXVR8qV6kW4N8E9pzgHHhrRC+YQx+PUVdPxcxt6w4dfd//s43zE
         rHuviwCsWCwFO+gqkpGstLZ3OvEpdGBvq7XxbsMubmmqgtU+iJv9rPEDg3trqK89gb
         GsRWOc5NiOGQg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 04, 2020 at 06:40:30PM +0800, Weihang Li wrote:
> According to the RoCE v1 specification, the sl (service level) 0-7 are
> mapped directly to priorities 0-7 respectively, sl 8-15 are reserved. The
> driver should verify whether the value of sl is larger than 7, if so, an
> exception should be returned.
> 
> Fixes: 172505cfa3a8 ("RDMA/hns: Add check for the validity of sl configuration")
> Fixes: d6a3627e311c ("RDMA/hns: Optimize wqe buffer set flow for post send")
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 7a0c1ab..15e1313 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -433,6 +433,10 @@ static int fill_ud_av(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
>  		       V2_UD_SEND_WQE_BYTE_36_TCLASS_S, ah->av.tclass);
>  	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_M,
>  		       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_S, ah->av.flowlabel);
> +
> +	if (WARN_ON(ah->av.sl > MAX_SERVICE_LEVEL))
> +		return -EINVAL;
> +
>  	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_SL_M,
>  		       V2_UD_SEND_WQE_BYTE_40_SL_S, ah->av.sl);
>  
> @@ -4609,12 +4613,8 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
>  	memset(qpc_mask->dgid, 0, sizeof(grh->dgid.raw));
>  
>  	hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
> -	if (unlikely(hr_qp->sl > MAX_SERVICE_LEVEL)) {
> -		ibdev_err(ibdev,
> -			  "failed to fill QPC, sl (%d) shouldn't be larger than %d.\n",
> -			  hr_qp->sl, MAX_SERVICE_LEVEL);
> +	if (WARN_ON(hr_qp->sl > MAX_SERVICE_LEVEL))
>  		return -EINVAL;
> -	}
>  
>  	roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
>  		       V2_QPC_BYTE_28_SL_S, hr_qp->sl);

Can any of these warn_on's be triggered by user space? That would not
be OK

Jason
