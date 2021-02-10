Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9286F316772
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 14:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhBJNGF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 08:06:05 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12946 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhBJNEV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Feb 2021 08:04:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6023d99b0000>; Wed, 10 Feb 2021 05:03:23 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 13:03:22 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 13:03:16 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 10 Feb 2021 13:03:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXdrpo82NB/6M6UR38gTNM4AXTMgiN6eQT312acrnc7XSNY0z4XT2AOWDVMqceXm9bWPtn3ZfbZuHOS/0NTxMOPYBdBFc13qZ8HRmXK51EfXXJq5jvsh/d4HrNbh7+JwSjV4v7TovwiOEwqZ0wspcC7lOnQyRM6zb0AxeXyi+4H+0ThentyKpD45meS+YuWnDc/7tRqf/jFwhif44iHhco/e1O2aTkjoXvZ8500MVzD0Il2OLzX92ebPT/9k4a4/JEUoPS0mvRB0iLWvqhEvoNWMohAbAz6kx5dnEbgXWS+xAzrO434XDkvoy1BZkyeQ4JcbW81k+f5+PVHZoHXn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuydNBDBnFVlT9eomevWQcs7k2bGrZRaEySl/b1bMC0=;
 b=EiRojtJcz1MnMPZgqdFA4kiakYmfU5gbfpHXwGTIPTkQsRJ0ac7oTB+dsE44cTAcINBjrFX3QlGxKuZXCQzQdRTNQJGDKBwnEcxOjfW5qZSyeUv/mSHK/YQlPrrpCGzZnnvNSm/OXSo2ZrUjTl2EmFIPOsAuJKguGeBi53PMJf0mvZbvFT75YkDkCE9rOgAsZh8Piov052VXP+IxLAWu1d0B9D0pF+8kjw5B3roSrVN7iSiSrD+htZVyYEHQ2jzYGoATxgZuhIMSOESdvx5qhlnb+kGS9nTH51RTwThrltB+JW8DaxZV1pIo7Rgk2akNZnOogRYACqzPI9CX+qaSBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Wed, 10 Feb
 2021 13:03:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3846.027; Wed, 10 Feb 2021
 13:03:13 +0000
Date:   Wed, 10 Feb 2021 09:03:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Lameter <cl@linux.com>
CC:     <linux-rdma@vger.kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks
Message-ID: <20210210130311.GU4247@nvidia.com>
References: <alpine.DEB.2.22.394.2101281845160.13303@www.lameter.com>
 <20210209191517.GQ4247@nvidia.com>
 <alpine.DEB.2.22.394.2102100925200.172831@www.lameter.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2102100925200.172831@www.lameter.com>
X-ClientProxiedBy: MN2PR18CA0011.namprd18.prod.outlook.com
 (2603:10b6:208:23c::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:208:23c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 13:03:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9p9D-005qgL-Ra; Wed, 10 Feb 2021 09:03:11 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612962203; bh=FuydNBDBnFVlT9eomevWQcs7k2bGrZRaEySl/b1bMC0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=p3ozZMTfMa5zuC1KkREqnU1LRyYAEabwUO+S24IqD7wF8295VdX5eOLplL1xRiDzu
         l3EUYQwEsoECxSPsTNS+BNGjHySv340kjFvqtHcLGtNn181+NKfp6PQvFtALwNwk6E
         IeBcUPW8t9IE0/CA9QVzxajXmobvhMOhFbm64q1xJFf3ryvZkTaA8VwsQtuyeCN5u/
         A/lE4hLfhRwdDlRs5vJ3gPUnu+HKYEHe2aoDvGNk1cSqo5p/Sb4zc0I241yUPWJsov
         z7WJAItV0RpSNSaV7VQHjSQ2qAKbiNuRU00CjJdfFeqvb6+1vtL7kERlZ3leynX/0W
         cVoXmOwY4uP4Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 10, 2021 at 09:31:32AM +0000, Christoph Lameter wrote:
> On Tue, 9 Feb 2021, Jason Gunthorpe wrote:
> 
> > This one got spam filtered and didn't make it to the list:
> >
> > Received-SPF: SoftFail (hqemgatev14.nvidia.com: domain of
> >         cl@linux.com is inclined to not designate 3.19.106.255 as
> >         permitted sender) identity=mailfrom; client-ip=3.19.106.255;
> >         receiver=hqemgatev14.nvidia.com;
> >         envelope-from="cl@linux.com"; x-sender="cl@linux.com";
> >         x-conformance=spf_only; x-record-type="v=spf1"
> >
> > Also the extra From/Date/Subject ended up in the commit message
> 
> Yes the Linux Foundation guys are not willing to address this issue in any
> way. I may have to give up my linux.com email address.

It looks like you have to linux.com emails through their SMTP relay,
just like kernel.org ?

I have an exim config that auto-routes to an authenticated smarthost
based on the From email address if that would help you

> There is also another potentially racy check in there for OPA in regards
> to the support of path records?

Looks like

Jason
