Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074AC29DC30
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 01:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388928AbgJ2AWN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 20:22:13 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1419 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388933AbgJ1WiG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Oct 2020 18:38:06 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f99794a0000>; Wed, 28 Oct 2020 06:59:38 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 13:59:32 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 13:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GovEKBBjXEiOeI0/neKi1LePGAHTIDbnirTgmyhYHuhkn4K/a63E1pIpaxiq9MpVQvkIGrTM2cIkMNbb+qA8sNARoJZAec83Tli9eBAFpeAxDwY4x6Dyqckl3dnTFGWOmigJDgVMCAX6pAc0FgdsalWDVQdRtHlTic4VmgsMII8zimNE4O+/pEtWylk+wab+ZlxkG+fcG7hwbl+BejVkHMQmoyd+A+nCFt+lK1KdTB8OcvVV0K+rgS6HKhCc3eO4VVzGSi6HYC2BIOlkVMuK/HP/ckIsdciIkX9teA4jSGI5qCc3L2b3csqdXxaBKZQIre3udDQ7qPMCGKTChqzqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWkj0ZfVHI6TCab2/ebc8RgDzN4GrMNlAzKQ0DI8qMM=;
 b=JTKgWSPWDtylkUUVnVLnngdn/p4bR3UNzAnrNOg4/psXIrQ8oo4WourepKyj1m7Vn5dzsDqqNNrTYGc+6Eyb1NmSOkmNpMHcrXi/+98VPAlmBL/he829HMmXlh7BrSiO5na4FneVMDAKRzh7ZWxEPh419hkTRizl3NzJs5UOJDOUy/FeLka8Rn5Kkr2piypxe7kFrTsTpyrtUQM9p8pea3YVfZ9fIKB6SBrv28waV26NIOKlGd4BwGvYKbTwQca0jayqzhTIgQ7aGitFCafBTg+xditxBKZQG+e+QUTWFvEQLqvklXYhPNo/rulgoo7M0+jSR5faGpJe/LobWMPQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2779.namprd12.prod.outlook.com (2603:10b6:5:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 13:59:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 13:59:31 +0000
Date:   Wed, 28 Oct 2020 10:59:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
CC:     <linux-rdma@vger.kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCH] RDMA/ipoib: distribute cq completion vector better
Message-ID: <20201028135929.GX1523783@nvidia.com>
References: <20201013074342.15867-1-jinpu.wang@cloud.ionos.com>
 <20201028134419.GA2417977@nvidia.com>
 <CAMGffE=Hm7LNTS1iACZDMg77uP3xG=K0yM4qMjgj9A12E9OL=A@mail.gmail.com>
 <20201028135346.GW1523783@nvidia.com>
 <CAMGffE=9j+yWXhWj+X2XVYm018GBwOw4ZZxQ5GYs-rwrW4q3Kg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMGffE=9j+yWXhWj+X2XVYm018GBwOw4ZZxQ5GYs-rwrW4q3Kg@mail.gmail.com>
X-ClientProxiedBy: MN2PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:208:a8::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR12CA0025.namprd12.prod.outlook.com (2603:10b6:208:a8::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 13:59:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXlz7-00AACi-PA; Wed, 28 Oct 2020 10:59:29 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603893578; bh=vWkj0ZfVHI6TCab2/ebc8RgDzN4GrMNlAzKQ0DI8qMM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=lk9EU+YiQ+hLk7RdufOx41kNnBRyEjSIFSTlgX1K0ikR3dRv/NFAw3Sdp1Bg9ysRv
         hfnjni287XgsIPKimkKh57uIJEKCjCVQWGpVPG2eRB7gRJcaltZWr183yG5VcB6Z0Q
         batqpA4UFyq6sm1DnCOdl9Cs8p/arvFm6G8YEgHM87+Ws7uTXJBHGfSsKbBGGWaNFu
         8Rqp35gKOpAdWnuv6GMwl5N1ehEpODVIoJB97nGNdHSnsMcLdin1wcu3i/7TNY+v1Q
         xLG2Jjn6L3hTQvUpyN7z8BG4u7Cx9IuwwB5KRkHrTmyMe99IOHSk8wB54rjEXYbub0
         aqN5McHOaJULQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 28, 2020 at 02:57:57PM +0100, Jinpu Wang wrote:
> On Wed, Oct 28, 2020 at 2:53 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, Oct 28, 2020 at 02:48:01PM +0100, Jinpu Wang wrote:
> > > On Wed, Oct 28, 2020 at 2:44 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > On Tue, Oct 13, 2020 at 09:43:42AM +0200, Jack Wang wrote:
> > > > > Currently ipoib choose cq completion vector based on port number,
> > > > > when HCA only have one port, all the interface recv queue completion
> > > > > are bind to cq completion vector 0.
> > > > >
> > > > > To better distribute the load, use same method as __ib_alloc_cq_any
> > > > > to choose completion vector, with the change, each interface now use
> > > > > different completion vectors.
> > > > >
> > > > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > > Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > > > >  drivers/infiniband/ulp/ipoib/ipoib_verbs.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > If you care about IPoIB performance you should be using the
> > > > accelerated IPoIB stuff, the drivers implementing that all provide
> > > > much better handling of CQ affinity.
> > > >
> > > > What scenario does this patch make a difference?
> > >
> > > AFAIK the enhance mode is only for datagram mode, we are using connected mode.
> >
> > And you are using child interfaces or multiple cards?
> we are using multiple child interfaces on Connect x5 HCA
> (MCX556A-ECAT)

Ok.. Do you think it would be better to change IPoIB to use the new
shared CQ pool API?

Jason
