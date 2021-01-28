Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BC5307D8F
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 19:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhA1SOH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 13:14:07 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14237 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhA1SMC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 13:12:02 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6012fe490000>; Thu, 28 Jan 2021 10:11:21 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 18:11:20 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 28 Jan 2021 18:11:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCvAtJYXPrquRc05gzGms8V7HgizhHG++N44LtLVk7dlAyF3h0UUgCttbwmocg6Lb4DZZxnNgbPHbdfONii4CVxUSZDOzeEN5iiAOUDu/N/sL49tCUa3uJ+QMWmkPv54YlIpQfaAaYUs27wc3H2m2fh699/ENyEMIuoaNWzZTWFQHdR7Kw2PAyjUUVgnoYbtMkKYzRI4N3DyYDridbDk/N8ESoC6RF1x/YsHH9EXXlwFsMj3PIGX7LppiirKmbU+Tp2aEbz8ErSjvEqRAUjH3v6YVV8mDIh+9CtF6ACRIdeuJD4+stHUqcL+LiqV8zJXa1Rg+AWNb4lULHEJZGOEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hxc42iobs33fFGQNJN9aQighz9Of1lQIqeqSHhZaw8E=;
 b=MBa3yybcMoRr6m4ZS6eZgYSgrdOeUuyA4d9zR8tNdb3RTDxG2HnWBKRQUDWUFvogOJ0GicOXhemqJqGE1FIo8BcLU9EryK+AjwNf0LCUwAbqFjxi0NQsH8ARthc04UapAGaE7I3DEQaA2tbhVamVpZvQ3zX4nnNCgqXE2qpjXBuXDrgldY+n7sybxsITHoLowSN37oMrmKjHNRFqapn2MW0WPQPtIjlb3blVvFebJ3UP2gts4uBjiJygaxtiouS/wjihfmhs1tNMGRNRQTSZQiM8P6G8+2xrOQqazn6sYiXg7Jup3n1Olqdx9uzhdv/rpTtG9Yl1oF5cKNitdDEh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14; Thu, 28 Jan
 2021 18:11:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 18:11:20 +0000
Date:   Thu, 28 Jan 2021 14:11:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Lameter <cl@linux.com>
CC:     Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks
Message-ID: <20210128181118.GH4247@nvidia.com>
References: <alpine.DEB.2.22.394.2101251126090.344695@www.lameter.com>
 <20210128140335.GA13699@nvidia.com>
 <alpine.DEB.2.22.394.2101281433270.10563@www.lameter.com>
 <20210128144435.GG4247@nvidia.com>
 <alpine.DEB.2.22.394.2101281453230.11029@www.lameter.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2101281453230.11029@www.lameter.com>
X-ClientProxiedBy: BL0PR02CA0122.namprd02.prod.outlook.com
 (2603:10b6:208:35::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0122.namprd02.prod.outlook.com (2603:10b6:208:35::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 18:11:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l5BlG-000Qvb-Ee; Thu, 28 Jan 2021 14:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611857481; bh=Hxc42iobs33fFGQNJN9aQighz9Of1lQIqeqSHhZaw8E=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=DFi75dQk2uQB2wqFyLLQuPpr88GPbxZkc78yFuG1JQw9ZLiwZViHAM8Zp5qSa0QJS
         7JmS/HD2a3739Kcdi146V+6rpzSVfzYtlWc+Hwrjhv2JUbNEbYbp5IdiqTWj0kUGC1
         iSUTKS7AyG6qj3GOFS2Kh5oYYvPp/Lqon3rilI+YjcasqmL6V8MUzU78GJ13FN3xWR
         EbVXQOHAkXTtiFW5/4xOn7ZGVFVuAL8RMedOH6l3lwIq624vVVmGJKY7vI0lM05X1l
         fMuy3U+JFw07UDOVXAJadGQseIhQyaPCRr6p4DiSpQ/FaNIGHJXs8ZfN3S/EQAlmrP
         OY2q/EkpL9RAw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 28, 2021 at 02:58:01PM +0000, Christoph Lameter wrote:
> On Thu, 28 Jan 2021, Jason Gunthorpe wrote:
> 
> > > Well it was quilt ...... Do I need to put it into a git tree somewhere?
> >
> > If you are doing this a lot get a quilt that can generate git diff
> > format output.
> >
> > https://lists.gnu.org/archive/html/quilt-dev/2015-06/msg00002.html
> 
> Sadly that patch was never merged.
> 
> Will this do it?

Patchworks ingored it

> 
> commit 64e734c38f509d591073fc1e1db3caa42be3b874
> Author: Christoph Lameter <cl@linux.com>
> Date:   Thu Jan 28 14:55:36 2021 +0000
> 
>     Fix: Remove racy Subnet Manager sendonly join checks
> 
>     When a system receives a REREG event from the SM, then the SM information in
>     the kernel is marked as invalid and a request is sent to the SM to update
>     the information. The SM information is invalid in that time period.
> 
>     However, receiving a REREG also occurs simultaneously in user space
>     applications that are now trying to rejoin the multicast groups. Some of those
>     may be sendonly multicast groups which are then failing.
> 
>     If the SM information is invalid then ib_sa_sendonly_fullmem_support()
>     returns false. That is wrong because it just means that we do not know
>     yet if the potentially new SM supports sendonly joins.
> 
>     Sendonly join was introduced in 2015 and all the Subnet managers have
>     supported it ever since. So there is no point in checking if a subnet
>     manager supports it.
> 
>     Should an old opensm get a request for a sendonly join then the request
>     will fail. The code that is removed here accomodated that situation
>     and fell back to a full join.
> 
>     Falling back to a full join is problematic in itself. The reason to
>     use the sendonly join was to reduce the traffic on the Infiniband
>     fabric otherwise one could have just stayed with the regular join.
>     So this patch may cause users of very old opensms to discover that
>     lots of traffic needlessly crosses their IB fabrics.
> 
>     Signed-off-by: Christoph Lameter <cl@linux.com>

This is 'git show', not 'git format-patch', tooling requires 'git
format-patch' output. Preferably in a clean new email to get reliably
captured by patchworks

> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index c51b84b2d2f3..58ee7004c8d8 100644
> +++ b/drivers/infiniband/core/cma.c

But this is all OK now, the index line is what allows easy resolving
conflicts

Jason
