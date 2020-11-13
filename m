Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C713C2B2090
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 17:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgKMQgS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Nov 2020 11:36:18 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17800 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKMQgS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Nov 2020 11:36:18 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5faeb5fb0000>; Fri, 13 Nov 2020 08:36:11 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Nov
 2020 16:36:10 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 13 Nov 2020 16:36:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRyXnCrNJ7zYKFWzqtW7ZxW0mRD3cEmr0qHu9D8cIv/SztLIj2gsb3B47uuEEziHa0+TVbAUBdR8XeuhbD0j4sUTF2vGqX9+H7ZaQRNX2rQ+VAbJDRsYNDtJtuDEDjVe3OkB1/MZvXcwhrBpXFyZzQhSgGm+88IKnboi0mSbyrq2elH6NceE3pimaqUfowl/SMRGf2Bn3Yux0VSW98SAmnQ0gyIf1xfxTqK2WQV6EITqoviLinAw63sYA/6fV/q+amUvyBXjmJjfVfduQp6eRu13c2Zmc2jqviG+wdzGDs+WXklyzaHUE9Ejp/Jxcc1xsX5FFgYfbp9EFNJdT4H4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyoSs12fvO8We5L+wdqjqLJkx8kVqqjX+jnVVSyC6k4=;
 b=MpZrSRYsFQh2UxixyNZ5nyGTr81spKYlU81UQ87dTzYcWe99R/rOnFrx+uvviUwDtk0JuWEAkuLV4FkWe/YgKJotz3MUYQ64WVsFUoa7M0d3nKw6zj9LNNyYk4kHfckiW+CpAixwB+1U1/PTYbBJLzQZTL90mOzoCIwERVlT9R/WcPLFeCB5low23Bvjv8LEXgj74xkoHLampAGNZYTlLkBZJ8ELeEvfwPWJ0s91/mHH9z/x1b881UzNdai27sCd7n5sF/nGx2CEet/8i9iFXWfpQbM9APXT+9ypctGnD3AupOs7gqihek1eZyMTQnk0YsqPu20Qjpxf/E0nI690FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 16:36:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Fri, 13 Nov 2020
 16:36:09 +0000
Date:   Fri, 13 Nov 2020 12:36:06 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhang Changzhong <zhangchangzhong@huawei.com>
CC:     <mike.marciniszyn@cornelisnetworks.com>,
        <dennis.dalessandro@cornelisnetworks.com>, <dledford@redhat.com>,
        <sadanand.warrier@intel.com>, <grzegorz.andrejczuk@intel.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/hfi1: fix error return code in hfi1_init_dd()
Message-ID: <20201113163606.GA1159754@nvidia.com>
References: <1605249747-17942-1-git-send-email-zhangchangzhong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1605249747-17942-1-git-send-email-zhangchangzhong@huawei.com>
X-ClientProxiedBy: MN2PR20CA0037.namprd20.prod.outlook.com
 (2603:10b6:208:235::6) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0037.namprd20.prod.outlook.com (2603:10b6:208:235::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Fri, 13 Nov 2020 16:36:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdc3S-004rpR-ON; Fri, 13 Nov 2020 12:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605285371; bh=cyoSs12fvO8We5L+wdqjqLJkx8kVqqjX+jnVVSyC6k4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=fvBInP7o+EZgP4jg8u4tA0w0tmCo7//Jj8eBfXNdc7HxoGI9dgjWdnu85NDXMH9VM
         eZHjhbeSelkCS5c0UESSl/sQ3J4t7oUMXLgbbSSX6QBSEmVSt4qe1MmJOmVz0WuMcr
         kz9YLG+1u6vaNP9VAshPoocSi22yr43drNjYwXi9PXDIkDxviOxhMZuKR/msc+p9nP
         9QnWssZYshqTYEBewnsij6DYIf8/rETO1fhaW805GELvyAkCNVWtsXHXv/goobLkXu
         pMbOjXzOvhCXiisw2YOty7tTE/RLfWHFZngU9rk8NKk/zB5y+F9EziQbHRDMePmIEc
         dEXRfKuxglLeQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 13, 2020 at 02:42:27PM +0800, Zhang Changzhong wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 4730f4a6c6b2 ("IB/hfi1: Activate the dummy netdev")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
> Acked-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi1/chip.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
