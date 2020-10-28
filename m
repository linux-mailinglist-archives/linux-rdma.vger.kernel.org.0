Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5D829D5C9
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Oct 2020 23:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgJ1WIl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 18:08:41 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:56402 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730249AbgJ1WI1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Oct 2020 18:08:27 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9977ef0001>; Wed, 28 Oct 2020 21:53:51 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 13:53:51 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 13:53:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB/nllvY1FsIkhLc78H0W20Y8wJp+SqhI/YS5riGP5KoV2oPuBI4jCT3y0zyKUzECIxYoKQUgPte1ZPlYsB1SMI48R63FhqJmX/RnTXpxNix080l13+OTXPHO4ZXPEHUGakldDpuLXVzNCzPChP8YDT2+dWivgfxx8kqJAnqapbGD2RtaR7cgy4h4xOJY9BGTp3V2Vh7Wxy2AlCh4zFlN6wXsnUjuXcPzwEG87fMMtYXowcVhKf34nXAlWEIdL3YOdKLxxEsyHdE20D1fxOu7J1+lkKot92gSHYFXSZRkTfuaWkp+K85xO06u87ayWXXpCXNYcRWnsytxCwZu5XeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qH8whS5HriTeMT1LPRknBf7kTTDsFep+DpGhB9ciLJ4=;
 b=i6AWDhNxCUoEr8N0K/tHVg8S7YklahQszT/9QM9pVFeE+AyoIqSPOMMr3mNyDM4WNiMUp45B67a/cIwvddt67oc7klgTyIQYmxfaPPMOKQh+HJRTusKKKdy8TdlesajfkVcSp1e7MqB7JgDSTrjCxXlSdAOziN3eA2x63MQ81H2/zNAikL2F2LeAT0xuUYXNbq6rM+IHsDcXhe4IV4WLKtFpgNF/mhgyIrq9dt0WS61A0aSqJ/SP8t+gwC2LeCiGztj8cuW0MQLC6fQgu6w1X+0v7nv3mw82CZKOY0jz3U441V8Q2ykmoBdSIbWJceZWh+vPqmWJLGd9WYlV5Xcjxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 28 Oct
 2020 13:53:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 13:53:48 +0000
Date:   Wed, 28 Oct 2020 10:53:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
CC:     <linux-rdma@vger.kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCH] RDMA/ipoib: distribute cq completion vector better
Message-ID: <20201028135346.GW1523783@nvidia.com>
References: <20201013074342.15867-1-jinpu.wang@cloud.ionos.com>
 <20201028134419.GA2417977@nvidia.com>
 <CAMGffE=Hm7LNTS1iACZDMg77uP3xG=K0yM4qMjgj9A12E9OL=A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMGffE=Hm7LNTS1iACZDMg77uP3xG=K0yM4qMjgj9A12E9OL=A@mail.gmail.com>
X-ClientProxiedBy: BL0PR0102CA0065.prod.exchangelabs.com
 (2603:10b6:208:25::42) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0065.prod.exchangelabs.com (2603:10b6:208:25::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 13:53:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXltb-00A9Jr-0M; Wed, 28 Oct 2020 10:53:47 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603893231; bh=qH8whS5HriTeMT1LPRknBf7kTTDsFep+DpGhB9ciLJ4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=KdD0asjfscqS6/HBqJfp0E5AbQjX9fQg9jZtC5JLVDX21Is9l4l1jwy18Um7kOt5r
         lfz2BNbnBnKnGUh1Og5l2n1xu/tB9rBifDmrQOOQkljra2oYui3n3jym6myA6B84gu
         2vcQwfqUlj9tkio35p8HD7rKJx3Wjfq5AHJEpuE3OA+JF4K+hRIgBG2h0vzAGxwPji
         I8ZQhOKN5cj+0abwKQOQbo7+dzAz1VxzpM1m7fQPeCLEN0+nsUZE8qHAv7VAY5ACLX
         Vcw0pHqFtbfSQELyF+wgPHUCBlmH2MBzm04l87mKRtjgQcKJn4dXNGInJO+idzr9iG
         zuRULx+aEVGQg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 28, 2020 at 02:48:01PM +0100, Jinpu Wang wrote:
> On Wed, Oct 28, 2020 at 2:44 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Oct 13, 2020 at 09:43:42AM +0200, Jack Wang wrote:
> > > Currently ipoib choose cq completion vector based on port number,
> > > when HCA only have one port, all the interface recv queue completion
> > > are bind to cq completion vector 0.
> > >
> > > To better distribute the load, use same method as __ib_alloc_cq_any
> > > to choose completion vector, with the change, each interface now use
> > > different completion vectors.
> > >
> > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > >  drivers/infiniband/ulp/ipoib/ipoib_verbs.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > If you care about IPoIB performance you should be using the
> > accelerated IPoIB stuff, the drivers implementing that all provide
> > much better handling of CQ affinity.
> >
> > What scenario does this patch make a difference?
> 
> AFAIK the enhance mode is only for datagram mode, we are using connected mode.

And you are using child interfaces or multiple cards?

Jason
