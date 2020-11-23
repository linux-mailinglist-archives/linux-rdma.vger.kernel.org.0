Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063222C0CA5
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 15:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgKWN7h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 08:59:37 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:50523 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729111AbgKWN7h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Nov 2020 08:59:37 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbbc0460001>; Mon, 23 Nov 2020 21:59:34 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 13:59:34 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 23 Nov 2020 13:59:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xh8YcIr1SD0TVMktt25cDD+cDIUbYuUi2ipfV8MbPzSZvFHpbYC7dDk7vz4DklS1BER6gmLJYrar8dmnFXfNgdHnXOUsXqOeYaKRS3q/jCNDxFgYoDrjZ6SQcQTZuB7jsvty92WCZ+zS8WNiIIAL3uy1pol6XxgXU/d3VfNIC29HkwfXX5rguCzxuFWg4EZR1IzxBXSAGAY25k4SD9OIEG3AVu6q41EzqX3DypYqcFkwTIGrZy0UM0T274KFYoNSPmeEINBwqN0jHYCyg8M+gZD9jQgfLYhnGe2KcbjoNYlYHhaE5FbEuEpYlmQOyTvIWlbj3ZKswb+2dahskrdH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jSRsG70c6YSqyQdhN7SvbYqT6dpUx8mFtiT9Cw+63Y=;
 b=be9cJEXvl0G5TJoMshZQhn4hWd4X+IYEbiG/mG6m7b7tQzZMhhta5p8a5WTl0Y23CVRy8mCDqgRKswPMUwRArTmyl/dct2RO7za3nbNKiuwKEt/hiKLBdioEESBBJ1pV5S5tF+j/+3w3Xum0ryZEjOzEdhx+A6o7w/gJOgGNEITgWGFDuPte3x2xgdsr0L8/Nfmq2FAgzXYpXb2a2Wlm3Oz3i7rHslYLAhijxfNiyZG76wDPMEdspqIXfhT3Cy9z480dPbYyH9jwS3of+jSTQESEOeQBswh7C2KLKqrlmCLth4u/Ee7RpInA/OWnq1UbBrxyLqS7IPbBYZOxjcNHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Mon, 23 Nov
 2020 13:59:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Mon, 23 Nov 2020
 13:59:32 +0000
Date:   Mon, 23 Nov 2020 09:59:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] IB/mlx5: Use ib_dma APIs instead of open
 access to parent device
Message-ID: <20201123135931.GM917484@nvidia.com>
References: <20201123082400.351371-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201123082400.351371-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR19CA0013.namprd19.prod.outlook.com
 (2603:10b6:208:178::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0013.namprd19.prod.outlook.com (2603:10b6:208:178::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 13:59:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1khCNP-00A2Fq-3K; Mon, 23 Nov 2020 09:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606139974; bh=3jSRsG70c6YSqyQdhN7SvbYqT6dpUx8mFtiT9Cw+63Y=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=VqKOCh6qd6uex0jLPGbfYHsdzL1K9+Fis6gbszH4KzdjRiO59daK2hEwyqDDouxV/
         uckUyDJfuqFie/dTTNOjO4fxQhkFuriVoAzCEDRWyhuqFyY6c76RAvgXlL3HMIHHK0
         wqHQugARchqKdtQNsaxphPlwEyLhoEO2O3ufpXWjvSM1mjGp6OyuS+Z2QWBNB8rWpy
         D3ItieaxBOJiakL7dCthjep9ocPmeY/KOGkliSJyk2Z9c+4tHJd41ZESDWWVQK3oPj
         CZ1NsOJ/UK4yiI2A489vUxZ+SNKRtQYnbJmfV/502N9iad5bdcl0RdsgaOJmwyl302
         z6Zj1NuHqHUhg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 23, 2020 at 10:24:00AM +0200, Leon Romanovsky wrote:
> From: Parav Pandit <parav@nvidia.com>
> 
> DMA operation of the IB device is done using ib_device->dma_device.
> This is well abstracted using ib_dma APIs.
> 
> Hence, instead of doing open access to parent device, use IB core
> provided dma mapping APIs.

Why?

The ib DMA APIs are for people using verbs, they are only needed to
pack things into the ib_sge

If you are inside a driver, not using the verbs API, or not using
ib_sge, then you should not be using the ib_dma API

It is an abberation, we should minimize its use.

>  /*
> - * We can't use an array for xlt_emergency_page because dma_map_single doesn't
> + * We can't use an array for xlt_emergency_page because ib_dma_map_single doesn't
>   * work on kernel modules memory
>   */
>  void *xlt_emergency_page;
> @@ -1081,7 +1081,6 @@ static void *mlx5_ib_create_xlt_wr(struct mlx5_ib_mr *mr,
>  				   unsigned int flags)
>  {
>  	struct mlx5_ib_dev *dev = mr->dev;
> -	struct device *ddev = dev->ib_dev.dev.parent;

Though this looks wrong, it should be dev->mdev->pdev.dev

ie it is always OK to use a PCI device with the normal DMA API

Jason
