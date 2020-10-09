Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1F1288F8D
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 19:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbgJIREK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 13:04:10 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10602 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389529AbgJIREK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 13:04:10 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8097fd0000>; Fri, 09 Oct 2020 10:03:57 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Oct
 2020 17:04:10 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 9 Oct 2020 17:04:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxAXcBSmruFrzx3ycc4LmJauRHBjaaW1CgvpiHS9yzBi9r1bo1hpjBQ6ERsGYSz/3OIai3U2uG5nuZY+HYpqNK149PnNgVG7/04HhJtqFX7/DMkcS0O6AgIfOFAfzrwWBLDAqCLNWYHbzfMVZiRwtuxJwTdkF5BpDn8ksC4V8WPSX3H18Z1dh5aD+jCuNfbsuzUWAFZwkQq5VhoEyxhc5/6S/ww0w8zR6vl1+pGxHXddSxjqRsuoAtL/a7BpFVgy8wpflnStWGVbHTAT8ApNgRasgxSFrvftPIhp1LQxLbeiQr90GWGNxY018u1nanhRG8GWsyS/LNAlvyyWR2P+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq/jl6CqmcQjrojZEToVOYvb9Yxs4ZEeJNDiCSoPgCY=;
 b=evhaSlFCLIeBJ0QrFVH9CVnYROKVurl2dV425WOwW+gOhIktxevFpnpJ8VtJHQ4x3MNN+XVmSJbHH+SWLvK+/R7OYk5c/DyBiORPSkQAeJkXu2pJ94EtzKDdm8AWuOlKBuhpz989xwtgZKzfrLw+a8jR6WwpFxr/4Zl7Tg/kDI/V/VaIU5ybTRCJCAoGIBQ5iIeSg77Hvv4veG7pgz48sghIxdfzjTeTat5pYZ/k5as/DWo2tpkq1FOT729pkrk7sAu28ScOuGdp76/eYupRL/oZ0FBZZBD4GFHZUmFfMVqrcpiNqDIdX3pp1I8NFuqoQcthvkc5GoIFRD6AI3byGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Fri, 9 Oct
 2020 17:04:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3455.026; Fri, 9 Oct 2020
 17:04:08 +0000
Date:   Fri, 9 Oct 2020 14:04:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH 4/4] rdma_rxe: remove duplicate entries in struct rxe_mr
Message-ID: <20201009170407.GO4734@nvidia.com>
References: <20201008212818.265303-1-rpearson@hpe.com>
 <20201008231642.GA417448@nvidia.com>
 <60104d8d-04b7-d4cf-5aa3-7d2ff5d424cf@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <60104d8d-04b7-d4cf-5aa3-7d2ff5d424cf@gmail.com>
X-ClientProxiedBy: MN2PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:208:134::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0021.namprd16.prod.outlook.com (2603:10b6:208:134::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Fri, 9 Oct 2020 17:04:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kQvoN-002SbR-9l; Fri, 09 Oct 2020 14:04:07 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602263037; bh=Uq/jl6CqmcQjrojZEToVOYvb9Yxs4ZEeJNDiCSoPgCY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=ICq5cWu/0c2gwQM+LuCgKsBqkwFjzqgfgP5TvHjXkYnOP0bWhbYGiRoui7j7Tn/da
         eRIIs6jhuJIv08XRRrNQlTK//4Bd+DbDbGcToau3ztwpTjrftes9B0p4tOSdV3K9yx
         Tg4uJfXGDuzWJw708YY9k5ZhiiKurhXXNawUw4+OEYYFD2f5im/Lf/cHuPW87DwWIF
         GwT/uOb3+lGRViFOl5LQQe1WMQSfYXsKELeNNZxvYH4zMwMWFTlHCz9mgHxcDvZAzD
         +JPoX3UzMGnUYQ0erOdF1yYvH3v9PibjNqsxZJlPdTsNNJ16euVZU6HnMg5Hr6YVHQ
         t+H97U6zLoRaA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 09, 2020 at 12:02:24PM -0500, Bob Pearson wrote:
> On 10/8/20 6:16 PM, Jason Gunthorpe wrote:
> > On Thu, Oct 08, 2020 at 04:28:18PM -0500, Bob Pearson wrote:
> > 
> > Subject should be of the form
> > 
> > RDMA/rxe: Some subject
> > 
> > RDMA convention is to capitalize the first letter ie 'Some'
> > 
> >> - Struct rxe_mem had pd, lkey and rkey values both in itself
> >>     and in the struct ib_mr which is also included in rxe_mem.
> >>   - Delete these entries and replace references with ones in ibmr.
> >>   - Add mr_lkey and mr_rkey macros which extract these values from mr.
> >>   - Added mr_pd macro which extracts pd from mr.
> > 
> > Commit body text should be paragraphs not point form
> > 
> >> @@ -333,6 +329,10 @@ struct rxe_mc_grp {
> >>  	u16			pkey;
> >>  };
> >>  
> >> +#define mr_pd(mr) to_rpd((mr)->ibmr.pd)
> >> +#define mr_lkey(mr) ((mr)->ibmr.lkey)
> >> +#define mr_rkey(mr) ((mr)->ibmr.rkey)
> > 
> > Try to avoid macros for implementing functions, I changed this to:
> > 
> > +static inline struct rxe_pd *mr_pd(struct rxe_mem *mr)
> > +{
> > +       return to_rpd(mr->ibmr.pd);
> > +}
> > +
> > +static inline u32 mr_lkey(struct rxe_mem *mr)
> > +{
> > +       return mr->ibmr.lkey;
> > +}
> > +
> > +static inline u32 mr_rkey(struct rxe_mem *mr)
> > +{
> > +       return mr->ibmr.rkey;
> > +}
> > +
> > 
> > and fixed the other stuff, applied to for-next
> > 
> > Thanks,
> > Jason
> > 
> Thanks for the style hints and applying the patch. Just guessing but
> I assume that in RDMA/somthing RDMA refers to the entire
> drivers/infiniband tree. The equivalent for user space is RDMA-CORE
> or rdma-core ??

Userspace is usualy something like providers/rxe:

Jason
