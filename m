Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3CC306172
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 18:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhA0RAV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 12:00:21 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15834 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbhA0Q6V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jan 2021 11:58:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60119b850000>; Wed, 27 Jan 2021 08:57:41 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Jan
 2021 16:57:40 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Jan
 2021 16:57:38 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 27 Jan 2021 16:57:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsU8mCmO06gjkZGB5ez1gSMsmV3bk6Kf2dzvMBkQoqFcbl00VITTByi5+noxbX13cfbewzdxh/EEui+NYQLxT4t62derbBDZQxRgdtrzkI6uojN3gqLwidL3093B0g+jmC8NpqmhGoOUb9k9f9dIa12N074G32U8nWdM0fXzCnqsA2cWY/5ucWOBwbCJgZJSPNSdv1xYsHx8cJMNM9T8DQDI6dmv9huLe1PybJYcuJjovp413Lfkb3xurHp3xcaFikd+3ysZUA0eMt+j6xU+fexag49m/NVISpWJAEabFT24Ma31cQ8G8cgnPnPLGVArbRst4yfglvUpBXY6P13kAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/fCYCkrrf4q7Q/jy5MYjD7cLEaaYZAcZlGwo51pDe0=;
 b=Y3ged2Jiu4fbJVKdi7lQp9BZOSB91j2+EuRhyvxFkyikzX7aVo4Y5ej0SSYGjhLgE7uAboGzBwoUmWTZrd0O+dnyQ3w/ckab/WQCbPTLcwoqFxDmr+e75UCNafeRolU7vdt93A5zEpszWG58e5nKl4t7NcWPzRiybdFUg5LM79KtZjW0/HSMiuznBd+KWKLx/x+F/O50C5aB0TzcyGNd3rMtfi0EqH4Dw+u2SKC259BUXik957N2kj700tczyPeRGu+e+2undjtB1nMkI8I1csKCYWC3WVpTbHWEhm5m39f8ksqKdOHOWfsCfi+P5c6u9OKqBgH5NKpuQWjFTe37sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.17; Wed, 27 Jan 2021 16:57:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 16:57:35 +0000
Date:   Wed, 27 Jan 2021 12:57:34 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>
Subject: Re: [PATCH for-next 0/2] Host information userspace version
Message-ID: <20210127165734.GQ4147@nvidia.com>
References: <20210105104326.67895-1-galpress@amazon.com>
 <9286e969-09b8-a7d0-ca7e-50b8e3864a11@amazon.com>
 <20210121183512.GC4147@nvidia.com>
 <206d8797-0188-5949-aaaf-57a6901c48d9@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <206d8797-0188-5949-aaaf-57a6901c48d9@amazon.com>
X-ClientProxiedBy: BL1PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:208:256::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:208:256::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8 via Frontend Transport; Wed, 27 Jan 2021 16:57:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l4o8M-007ZCA-8W; Wed, 27 Jan 2021 12:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611766661; bh=p/fCYCkrrf4q7Q/jy5MYjD7cLEaaYZAcZlGwo51pDe0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=TTtcvEbrgjmh5Ttf31GkDMaZ93F3aXpH51FxvUpjiGRVZy7M8+WFgkhGEE1IxEaD1
         YOpEnwDQw7j53zw8wGMx7vAH5hOoKdRdPzXZu9JT28iTdYf4umXTD7MANnvvK7tmhL
         LUTIdh2d8fKRVUPOP4aD4aGB7783CldVdfqEUgjPZRpxaC0EJsNlcIjcVw9Mt5CSlI
         +GBVWH49QXXV0i2+ZPRWk5NZNCVs/f8P9+fzR771YTAyoXOpmotAFYuvfEML6WcbDs
         bRC6ZPTkzq4loybd3iQp7shg1F/UKimQrrdgW2kaBoAtPmmj474s1CodV7IJhFHdQI
         sjIeqrhIsGOXA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 21, 2021 at 09:40:49PM +0200, Gal Pressman wrote:
> On 21/01/2021 20:35, Jason Gunthorpe wrote:
> > On Tue, Jan 19, 2021 at 09:17:14AM +0200, Gal Pressman wrote:
> >> On 05/01/2021 12:43, Gal Pressman wrote:
> >>> The following two patches add the userspace version to the host
> >>> information struct reported to the device, used for debugging and
> >>> troubleshooting purposes.
> >>>
> >>> PR was sent:
> >>> https://github.com/linux-rdma/rdma-core/pull/918
> >>>
> >>> Thanks,
> >>> Gal
> >>
> >> Anything stopping this series from being merged?
> > 
> > Honestly, I'm not very keen on this
> > 
> > Why does this have to go through a kernel driver, can't you collect
> > OS telemetry some other way?
> 
> Hmm, it has to go through rdma-core somehow, what sort of component can
> rdma-core interact with to pass such data? The only one I could think of is the
> RDMA driver :).
> 
> As I said, I get your concern, I was going on and off about this as well, but
> the userspace version is a very useful piece of information in the context of a
> kernel bypass device. It's just as important as the kernel version.
> I agree that this is not the place to pass things like gcc version, but I don't
> think that's the case here :).

Well, if we were to do this for mlx5 we'd want to pass UCX and maybe
other stuff, it seems like it gets quickly out of hand.

I think telemetry is better done as some telemetry subsystem, not
integrated all over the place

Jason
