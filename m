Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD64927E7D1
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 13:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgI3Lpi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 07:45:38 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:30782 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3Lpi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Sep 2020 07:45:38 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f746fdf0000>; Wed, 30 Sep 2020 19:45:35 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 11:45:32 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 30 Sep 2020 11:45:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5JS6ycCLA+ey6H6PEDfYh0txtdHz1oW146Y0mf0jzryp4nGgcAAzq6i+vm6IOOu9G2TiRIawxsTcsZkXQphwz1PgNABiNPK7FkgIRATEahh48D06/anI4mupMYpbXOB0RG5EkcMLsWuzGuO0QZlU3Sp7DfOxDx5ArO7Z7Q0wuVgdOC7BIyyRZ73BLu8pWR2ddQklAC+NTXHIuAmoHBZ3Kjd342DpPybvl8VSdCxZRqnFZUo/ZJNy71fUZUOoP30ClTYACic6jbffswZumEWl4Hw7Em6EX82bbREtzYec4k54ADalU29dnB51mu2Zk9vACrt9yR7CMRKvhwpCi/rcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAsU320K5FEsVsUsGTXFF4o1tMt7feAUQkBKN7F74EI=;
 b=Tf2u7n+4WPnZfJ4WHFScskEDaGF8K2Y5X685UCE/zLGMPYqAjil3nfl+fPXzGLb1u4EioztX5cVOjUo/VZU7/agUbS5ctxYwDUwPR4RBR+D0/cC6jfdxBjPj7z0iWLB65ieFG68hWEZVTA5nZrBa0X55J37MjLZ2WnqgSQCNVpPSv1ELtwPLM/ZLIKE3QmpRnQotx2WzLZ7UWEHlnqTlD8Al8Q07XInHWpNSMFdY6P9xbaoCjouzrhGu/3oZ/mS5iwntNPfU16osOfAnhVXVaEDaSolaeelrcpnZzRvUfZ/mLZfIkhXlBqYfVcKRqIZ5PPI2GsTurLEgkJAduN7Lbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 30 Sep
 2020 11:45:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 11:45:29 +0000
Date:   Wed, 30 Sep 2020 08:45:27 -0300
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
Message-ID: <20200930114527.GE816047@nvidia.com>
References: <20200927064647.3106737-1-leon@kernel.org>
 <20200927064647.3106737-5-leon@kernel.org>
 <20200929195929.GA803555@nvidia.com> <20200930095321.GL3094@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200930095321.GL3094@unreal>
X-ClientProxiedBy: MN2PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:208:15e::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0014.namprd17.prod.outlook.com (2603:10b6:208:15e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Wed, 30 Sep 2020 11:45:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNaY3-003vHg-7m; Wed, 30 Sep 2020 08:45:27 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601466335; bh=oAsU320K5FEsVsUsGTXFF4o1tMt7feAUQkBKN7F74EI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=C5kPdi9eRgMFb4rKx1OLDZtww0KV3jP/th3Ur0di8JyINjwi6q9IQ9iNfp4OFzsgy
         TEXE36ZTXxnZVASfO3dw1c6V7wCGp4W9CBQKjn6uDBLTz1egDFRfrDCZVcgaxumwgD
         8+1W5RW0jj6YZ4ysoCcgfjAb50yuKFbwZGGZvH0x9hCodxZJWHjlqwLLj7Io4BFNoE
         lpwPTwfkPZY7VatebKiU9bWBZeulYcXADWHx6OR5ABSvuD3eYoKvPVIza6lMRVX/AE
         MsboprGFPIkmoYB7FqeBjsZbS+mK2FkTJTZfAXcqN6DG7E/8k09O8Xdj76LCToJCwp
         Ud51rEIkwm7aw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 30, 2020 at 12:53:21PM +0300, Leon Romanovsky wrote:
> On Tue, Sep 29, 2020 at 04:59:29PM -0300, Jason Gunthorpe wrote:
> > On Sun, Sep 27, 2020 at 09:46:47AM +0300, Leon Romanovsky wrote:
> > > @@ -296,11 +223,17 @@ static struct ib_umem *__ib_umem_get(struct ib_device *device,
> > >  			goto umem_release;
> > >
> > >  		cur_base += ret * PAGE_SIZE;
> > > -		npages   -= ret;
> > > -
> > > -		sg = ib_umem_add_sg_table(sg, page_list, ret,
> > > -			dma_get_max_seg_size(device->dma_device),
> > > -			&umem->sg_nents);
> > > +		npages -= ret;
> > > +		sg = __sg_alloc_table_from_pages(
> > > +			&umem->sg_head, page_list, ret, 0, ret << PAGE_SHIFT,
> > > +			dma_get_max_seg_size(device->dma_device), sg, npages,
> > > +			GFP_KERNEL);
> > > +		umem->sg_nents = umem->sg_head.nents;
> > > +		if (IS_ERR(sg)) {
> > > +			unpin_user_pages_dirty_lock(page_list, ret, 0);
> > > +			ret = PTR_ERR(sg);
> > > +			goto umem_release;
> > > +		}
> > >  	}
> > >
> > >  	sg_mark_end(sg);
> >
> > Does it still need the sg_mark_end?
> 
> It is preserved here for correctness, the release logic doesn't rely on
> this marker, but it is better to leave it.

I mean, my read of __sg_alloc_table_from_pages() is that it already
placed it, the final __alloc_table() does it?

Jason
