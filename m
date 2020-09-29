Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A12E27D76C
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 21:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgI2T7e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 15:59:34 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1204 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2T7e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 15:59:34 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7391c00000>; Tue, 29 Sep 2020 12:57:52 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 19:59:32 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 29 Sep 2020 19:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpQE0xXT6R29dDNNYmU5LuVUlx8pz4e3aWmZ9nOvpzFwhmgEcsCw859SIedWOJdmXXSQqny47/pOOyVMp8+Cb86Aot6oDc/QD+62YVggk/rshDd9AHksNWemqqo0mZsPeYJIJNfjOR349YlV9utM2yMCr+baszsluLE8/UE81zy7VqdN7DRV5W8qDp9hGhUKnjlTfYbGBWy3KWER53gGf5ozbf4BuNiZZnu7jw64sQJdpLC6Xc5pv+g9Eq+yh0Qp7MbXmw4RnrW65Dk7aZcpty6g0FTPgQNqiKNu/dbZD6siwQZh0lk4FWoODN8eFQph6PIvFVbArEyfMHsMBU7pfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbTynvgPyPjA+95ZRshJ0r2pHgwVG61L3zu9wlQdKUY=;
 b=lROk2rtY9LlIV0VV+uyXYH0pK6gOM7W91Fh/acYxP218J6NnSZoo6rAVTD9u14rXzulc+APDClUQK7fa+SdPW5f+zK9cxHbTBtYorxgr3SEqEwKfUy+KxkCnsCZEV0u2GE8inr0h/yIeuRX4W9prkDg00J7bLQNA6HglpRlCig5ZqE+KF62W3cIOPTCVZlg+0UmifqxAXPWc/UGqSn5wEN54ytvgcW8nnEcNTKHLhS7MxZCjThmh9NBhJH+FzLClwVWEwDO+k2cx5kVJ+QMHPHagUBdtjbcyzYmiegC0hC2qMFJoY4W8h18fju5wMn9KbqJdSR049ZVG8qcVAHUvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3209.namprd12.prod.outlook.com (2603:10b6:5:184::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Tue, 29 Sep
 2020 19:59:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 19:59:31 +0000
Date:   Tue, 29 Sep 2020 16:59:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        "Tvrtko Ursulin" <tvrtko.ursulin@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>
Subject: Re: [PATCH rdma-next v4 4/4] RDMA/umem: Move to allocate SG table
 from pages
Message-ID: <20200929195929.GA803555@nvidia.com>
References: <20200927064647.3106737-1-leon@kernel.org>
 <20200927064647.3106737-5-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200927064647.3106737-5-leon@kernel.org>
X-ClientProxiedBy: MN2PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:23a::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:23a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 19:59:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNLmb-003NQ0-Io; Tue, 29 Sep 2020 16:59:29 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601409472; bh=LbTynvgPyPjA+95ZRshJ0r2pHgwVG61L3zu9wlQdKUY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=iSmska3JZTIwY67fbkfO3gQL7hZD6bfd47hENqfwiNTYSB5LY6cGsQm+jZ+sYMRHO
         JxfHosdNev+wqVzoOV7t82t96iLfcRbDLNiG58sA6X/waxJSkvzcPVNAAbEQUBmhke
         ebZaoB456MkvM9RITmUnZsTIfajHih+nZR4gFs4CUf8HXgxLLovMa5gBAHDSH8Rbxn
         2fGaMrhaoPm6HuEg32KEe/0Q9InmJ/zntpZsX4yR/uaBat9HN27tHmSEJisHHzdz62
         LwXQPFrR0z8urAf4OB8SCh0m8DWleuVmmwGiBl5M42mABlUwgq4Q3Gt2elJadwLkLF
         NayfjPM/0geOw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 27, 2020 at 09:46:47AM +0300, Leon Romanovsky wrote:
> @@ -296,11 +223,17 @@ static struct ib_umem *__ib_umem_get(struct ib_device *device,
>  			goto umem_release;
> 
>  		cur_base += ret * PAGE_SIZE;
> -		npages   -= ret;
> -
> -		sg = ib_umem_add_sg_table(sg, page_list, ret,
> -			dma_get_max_seg_size(device->dma_device),
> -			&umem->sg_nents);
> +		npages -= ret;
> +		sg = __sg_alloc_table_from_pages(
> +			&umem->sg_head, page_list, ret, 0, ret << PAGE_SHIFT,
> +			dma_get_max_seg_size(device->dma_device), sg, npages,
> +			GFP_KERNEL);
> +		umem->sg_nents = umem->sg_head.nents;
> +		if (IS_ERR(sg)) {
> +			unpin_user_pages_dirty_lock(page_list, ret, 0);
> +			ret = PTR_ERR(sg);
> +			goto umem_release;
> +		}
>  	}
> 
>  	sg_mark_end(sg);

Does it still need the sg_mark_end?

Jason
