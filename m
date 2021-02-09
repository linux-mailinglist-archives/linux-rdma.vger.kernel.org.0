Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65C931571C
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 20:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhBITq2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Feb 2021 14:46:28 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16046 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbhBITkJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Feb 2021 14:40:09 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6022df680002>; Tue, 09 Feb 2021 11:15:52 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 19:15:45 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 19:15:21 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 19:15:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zn6bAlTqOvdXTOSq+t6N0hLgQ8Erz8wd03TGhOZ8xqbZ6oXjjdtiRUz3a97HoL/WHEy9VqYeAGcvFJAAJ9Iac2XKCQzKHqO15DbXKsgKnsRIC02eiWIp+7jOBL0tyG8N85MFxNBmSEcR9uUO52XiwBCAxP+lb0q+8TTkRTehvXuheKtguwl4S9tlp1+mem/ONJl+uv/cyeIXERwmO+huG+E50NSSb20eyzL3TSXfc4i6SOOimCj863QiMVs+BZY5Nixjx0flL52tflBiw8D8jDUSufiVxO5+Bg3atFzce9XoHVnChvCrecE8s6qOctjkTCj2ob1UpwB2nam5hr4Zew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DduRABcZAFWpd9QhqW2UfphcHGj2rNCUWCmTmo5tegQ=;
 b=BnZRFkiKK+GE/7cLSsTf//pg+USkF3JPQ3nEyJ7o7Yqu3nvzzsRWBWu9m5FQRZEvH2S//Ejcl7aUxSl2rUQDXqaeiqIU3AukRn91r/G/dlTj5C6YAEJBrj/S3zufXuDEf3etEoQk+Y4M1KQWMoOnre5Zv1fU1+Ba+pjt1wmY3H/cdacH4Pv4ye60pO2dK2kGdhIdpBEUYQSZIP04MtUd4gmKfz3coUtyZdpa16v21OcdH4AGpW1gUtyCLorQkyU6hSANH1M3Dy2dl2rWHJ+QT9gU66nGEplG4Lf990UPJ9mtoG/D9DSPq/0nVqJlqkap7nWPsxSjbX6pZwLT7l2jiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Tue, 9 Feb
 2021 19:15:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 19:15:18 +0000
Date:   Tue, 9 Feb 2021 15:15:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Lameter <cl@linux.com>
CC:     <linux-rdma@vger.kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks
Message-ID: <20210209191517.GQ4247@nvidia.com>
References: <alpine.DEB.2.22.394.2101281845160.13303@www.lameter.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2101281845160.13303@www.lameter.com>
X-ClientProxiedBy: MN2PR20CA0064.namprd20.prod.outlook.com
 (2603:10b6:208:235::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0064.namprd20.prod.outlook.com (2603:10b6:208:235::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 19:15:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9YTl-005axQ-0e; Tue, 09 Feb 2021 15:15:17 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612898152; bh=DduRABcZAFWpd9QhqW2UfphcHGj2rNCUWCmTmo5tegQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=qqEXf0b4WYF9aAYavbOMHKC6ycnD0btX3nd7ExR7wcIftJlA5FGKeAzAxuh8qKxsI
         x8lsVNUg2HU6nIkwLsqCFTCA4xSno6hrfXZwxvur8RXnagLeh+VJkHVyO0SAVh74W8
         kWv7SqboE5XTBY22AdkryhPXUJTOixGEd6eBJEHKVgZnrFlQl+Ob/3O+aIKoSqKzXm
         g4QziJgTZpVugdOAivjY4DrS71IKqOwzd3uuMnLrn4ElauI1vbP0AGVOHrs0F+85iM
         Q+XYnHilmq7d5xL1beQNYVNbEhV6sBGcBACFQWZfrKmATl8BqTwO/ag/HVQzJydb0l
         5EgZqA+xIqOew==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 28, 2021 at 06:46:47PM +0000, Christoph Lameter wrote:
> From 64e734c38f509d591073fc1e1db3caa42be3b874 Mon Sep 17 00:00:00 2001
> From: Christoph Lameter <cl@linux.com>
> Date: Thu, 28 Jan 2021 14:55:36 +0000
> Subject: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks
> 
> When a system receives a REREG event from the SM, then the SM information in
> the kernel is marked as invalid and a request is sent to the SM to update
> the information. The SM information is invalid in that time period.
> 
> However, receiving a REREG also occurs simultaneously in user space
> applications that are now trying to rejoin the multicast groups. Some of those
> may be sendonly multicast groups which are then failing.
> 
> If the SM information is invalid then ib_sa_sendonly_fullmem_support()
> returns false. That is wrong because it just means that we do not know
> yet if the potentially new SM supports sendonly joins.
> 
> Sendonly join was introduced in 2015 and all the Subnet managers have
> supported it ever since. So there is no point in checking if a subnet
> manager supports it.
> 
> Should an old opensm get a request for a sendonly join then the request
> will fail. The code that is removed here accomodated that situation
> and fell back to a full join.
> 
> Falling back to a full join is problematic in itself. The reason to
> use the sendonly join was to reduce the traffic on the Infiniband
> fabric otherwise one could have just stayed with the regular join.
> So this patch may cause users of very old opensms to discover that
> lots of traffic needlessly crosses their IB fabrics.
> 
> Signed-off-by: Christoph Lameter <cl@linux.com>
> ---
>  drivers/infiniband/core/cma.c                 | 11 ---------
>  drivers/infiniband/core/sa_query.c            | 24 -------------------
>  drivers/infiniband/ulp/ipoib/ipoib.h          |  1 -
>  drivers/infiniband/ulp/ipoib/ipoib_main.c     |  2 --
>  .../infiniband/ulp/ipoib/ipoib_multicast.c    | 13 +---------
>  5 files changed, 1 insertion(+), 50 deletions(-)

This one got spam filtered and didn't make it to the list:

Received-SPF: SoftFail (hqemgatev14.nvidia.com: domain of
        cl@linux.com is inclined to not designate 3.19.106.255 as
        permitted sender) identity=mailfrom; client-ip=3.19.106.255;
        receiver=hqemgatev14.nvidia.com;
        envelope-from="cl@linux.com"; x-sender="cl@linux.com";
        x-conformance=spf_only; x-record-type="v=spf1"

Also the extra From/Date/Subject ended up in the commit message

I fixed it all up, applied to for-next

It looks like OPA will also suffer this race (opa_pr_query_possible),
maybe it is a little less likely since it will be driven by PR queries
not broadcast joins.

But the same logic is likely true there, I'd be surprised if OPA
fabrics are not running a capable OPA SM at this point.

Jason
