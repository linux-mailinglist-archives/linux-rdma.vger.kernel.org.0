Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C4B2B0962
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 17:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgKLQBR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 11:01:17 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19311 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbgKLQBL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 11:01:11 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad5c410001>; Thu, 12 Nov 2020 08:01:05 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 16:01:08 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 16:01:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rf8L+1fNQ+JJfG9akRDuJkNmKFoKwdgT6alFxPJrj+fb49IqPTYMYIBxLsMYCm8ka+ZV6Xet21tiv5gx+zQSj6l7+JzbPRzP/wA6WgS8txRwEAGXl8m1ekW6WX392TalwDqzkv7wZ3y0sLh4eQSP20va/m48V6B8S6GQ0D3txO6XZxS9Vbwg/vMwSAmhJutIrNuZJ2rhkbvo1kNS1PAZoYF0D9PgSLwwF2l+4rJNZo4TXamvItfIJmaYXPWlu9Mh1K9FcF2mzQo2XtxqsNnCFYsaa8T7OgaJVF3E0UkhZn2TrkhAIozkXLEv/QzNj4aIhbwfm4Zl3PYOqga+wEoctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzF1Ycih6Lh6sayhmO1SDE/pXiri9J6xyjYpHBC8Udo=;
 b=KI9oUVwZVzV72e7GFzJDo+anMFnNkDaEN2KwiTUT/sw6slOgWS40ka5hkkqltIFYyGnCgNwIwBI2qmiMDRkfTMnbbYxVSwiYC7BIdJPvPsl0YnAzxSsQZVfgZdtX56H1Dg1KIMFmXcbnC2sdDudw9g8Q/obu7DABJRcv1PsoN88qIjV2jYSym1loEk4S/K53ltmfAuCW1hKx96XmIdDspv54od7EDKh3kFVLkJpfOA5wrnaMLxpn/N1AFwjrKYtoLeRF6Pfx5/pgutpgbnggVv7GyPalx7PiOqwP5Q+QDjTKyv2GzOq25O/MZQRrHgheGW7ePjtw93RpKKQBFE/ljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 16:01:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 16:01:08 +0000
Date:   Thu, 12 Nov 2020 12:01:06 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Refactor the hns_roce_buf allocation
 flow
Message-ID: <20201112160106.GA894521@nvidia.com>
References: <1603967462-18124-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1603967462-18124-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:208:23a::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:23a::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Thu, 12 Nov 2020 16:01:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdF22-003klG-JB; Thu, 12 Nov 2020 12:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605196865; bh=SzF1Ycih6Lh6sayhmO1SDE/pXiri9J6xyjYpHBC8Udo=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=DjTAXr05l/vTbw/85pPDT/jkiBby7mNhmkwD9iyllVEhc91fTJKhooOzdYpTx7LwI
         G0K+17ouFImRL1Skxiu700kv7XFY1diF2IQ46vLEP/QsCAvekz8SSkaJCCiPtpr8KX
         mY8SvKrEUeJnBzPOvJTE+b+K231HKAM7hksxsqFvM7N3U1VaehmRO1bQ0+VpJIsTTT
         qVcisEOTNom0emrRPEU11nQq8i8xyyZPd6tFzLQLpC8ewkTJqjKNUbnyQeWnf/ek2+
         0q6U/9Zgs0kxFLnxrmK8i4x3E5alQOkOYsY4Jtf8fVgRWpA0Aa2OkROLDpcDrpoBs8
         8hD6iGjNlUllQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 29, 2020 at 06:31:02PM +0800, Weihang Li wrote:
>  	/* The minimum shift of the page accessed by hw is HNS_HW_PAGE_SHIFT */
> -	buf->page_shift = max_t(int, HNS_HW_PAGE_SHIFT, page_shift);
> +	WARN_ON(page_shift < HNS_HW_PAGE_SHIFT);

Stuff like this should be written as

  if (WARN_ON(page_shift < HNS_HW_PAGE_SHIFT))
    return ERR_PTR(-EINVAL);

Rather than wrongly continuing on

> @@ -780,19 +769,16 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
>  		ret = 0;
>  	} else {
>  		mtr->umem = NULL;
> -		mtr->kmem = kzalloc(sizeof(*mtr->kmem), GFP_KERNEL);
> -		if (!mtr->kmem) {
> -			ibdev_err(ibdev, "Failed to alloc kmem\n");
> +		mtr->kmem =
> +			hns_roce_buf_alloc(hr_dev, total_size,
> +					   buf_attr->page_shift,
> +					   is_direct ? HNS_ROCE_BUF_DIRECT : 0);
> +		if (IS_ERR_OR_NULL(mtr->kmem)) {

Please do not use IS_ERR_OR_NULL

Routines should not return NULL and an error pointer, one or the other
- or NULL needs to have special meaning and is not an error.

> +			ibdev_err(ibdev, "failed to alloc kmem, ret = %ld.\n",
> +				  PTR_ERR(mtr->kmem));
>  			return -ENOMEM;

Here you should return PTR_ERR((mtr->kmem)

In other places in this driver too, please check all the
IS_ERR_OR_NULL's

Jason
