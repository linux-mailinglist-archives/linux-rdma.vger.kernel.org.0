Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31CD2962DD
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Oct 2020 18:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897507AbgJVQjr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Oct 2020 12:39:47 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9972 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897388AbgJVQjr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Oct 2020 12:39:47 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f91b5a20008>; Thu, 22 Oct 2020 09:38:58 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Oct
 2020 16:37:48 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 22 Oct 2020 16:37:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lskD0zPXhtpLQ59kuDw9/rUddNFO1HG1D9pQtUx2ZDdIiwhKT4rImIyUMQqT+nqCb55sIa6fl0UaA9bsauPMpqQjpewHD7c3PMsG42ZOOh6P7a1Py6fWtWdzUEBIOQ2Qf2bvO4fiWozpNBULshoj/rOJb3qmqa5YBdckQo7YL59VQGG8m5tqYRp0EY8OlgkHJLlfasOcbxHcaOzUGx3eVYJypkDMdHecizu/bbdNNtVpZVXQOgTabFHqlw+WXIIJEhaFj/HHABVpGBbMlAtoK7NzKPxzmHLdY/YsN3ywclGujYb+pttIQwcXqker1ybJz1RA2hFSRNQ75/faYypixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyyAPhSpMGpa6UVZOkBAKYRnY2rmtiVZlJ5coXqeLWY=;
 b=mNHgCOtWcJRCSUY2hT+LJai8MXyTLJbnuBx1GHfJwJ+tWdznmtG7e8/ljjDXU7vbFHGsQk3WoKmAkrjJlCk4xkf5bZOb/R4Bm1Xgvud9l7McO6spAe9zEXHILYWhP3cBDPkEac+dIv+H1Uq3hS05By2iYwTFa8M2tfUQKdYZOYhxRKJes3X8uWwWnJ23v/XNf91XEivgWdBwAh/QewE7rGOwJlmR8SxQa1OuJBFxeb9OzcIIROcKiml98z3Uw/Mw4ZG7Segn+DSHIDJ/7HeV2WFV7wk5mGNTiZ+euY+6LJ7gB6/t3Np623BdFuMruLxAI35ReEvmivtL6D2FT26pOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Thu, 22 Oct
 2020 16:37:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 16:37:46 +0000
Date:   Thu, 22 Oct 2020 13:37:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leonro@nvidia.com>
CC:     Gal Pressman <galpress@amazon.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        "Leybovich, Yossi" <sleybo@amazon.com>
Subject: Re: New GID query API broke EFA
Message-ID: <20201022163744.GY6219@nvidia.com>
References: <3e956560-3c76-5f4b-b8fa-ad96483cd042@amazon.com>
 <20201022112100.GE2611066@unreal> <20201022121035.GX6219@nvidia.com>
 <20201022122301.GF2611066@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201022122301.GF2611066@unreal>
X-ClientProxiedBy: BL0PR01CA0016.prod.exchangelabs.com (2603:10b6:208:71::29)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR01CA0016.prod.exchangelabs.com (2603:10b6:208:71::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend Transport; Thu, 22 Oct 2020 16:37:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kVday-004Eji-BC; Thu, 22 Oct 2020 13:37:44 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603384738; bh=NyyAPhSpMGpa6UVZOkBAKYRnY2rmtiVZlJ5coXqeLWY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=cJIO1UxvPul0AsDBBu67zk5851BZJXASCjgGcFwz6q/hE8a8YXHJHnkjmEkWeOKcN
         3vhQGaOJTjdHjzCr4/gpboUYebse5FqxJWIA8ysp/vf4+GKGbWQbe1Ure3t1GnFgA3
         WB4bAw6h7Kx+0dj8XYuxPMgEDqqucDRQEORycwa/IYQfwSSj+PwHR4DbSgmC6epwOV
         bOls3LZ3Tiuk/Ie+AH4J/Qoi1NzwkuIsONR39KWa74WSrlLNNZTFIW4cCpxNX66nKf
         IH1De9YYfd2iTyAhlh7S/ohsFNKi3WzI7Bao81TEeRD26+Jq0i2vKWJaQtoHRgTPJI
         MxgednoW+4zYw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 22, 2020 at 03:23:01PM +0300, Leon Romanovsky wrote:
> On Thu, Oct 22, 2020 at 09:10:35AM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 22, 2020 at 02:21:00PM +0300, Leon Romanovsky wrote:
> > > On Thu, Oct 22, 2020 at 01:58:29PM +0300, Gal Pressman wrote:
> > > > Hi all,
> > > >
> > > > The new IOCTL query GID API 9f85cbe50aa0 ("RDMA/uverbs: Expose the new GID query
> > > > API to user space") currently breaks EFA, as ibv_query_gid() no longer works.
> > > >
> > > > The problem is that the IOCTL call checks for:
> > > > 	if (!rdma_ib_or_roce(ib_dev, port_num))
> > > > 		return -EOPNOTSUPP;
> > > >
> > > > EFA is neither of these, but it uses GIDs.
> > > >
> > > > Any objections to remove the check? Any other solutions come to mind?
> > >
> > > We added this check to protect access to rdma_get_gid_attr() for devices
> > > without GID table.
> > >  1234         table = rdma_gid_table(device, port_num);
> > >  1235         if (index < 0 || index >= table->sz)
> > >  1236                 return ERR_PTR(-EINVAL);
> > >
> > > So you can extend that function to return for table == NULL an error and
> > > remove rdma_ib_or_roce()
> >
> > How does table == NULL ever?
> 
> ok, you are right in that regards.
> However, mlx5 IB representors don't support GIDs and sets gid_tbl_len to be zero.
> Do we want to rely on the assumption that table will always exist?

We do already, seems like the rdma_ib_or_roce should just be deleted

Jason
