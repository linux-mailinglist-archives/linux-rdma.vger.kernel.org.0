Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA830779A
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 15:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhA1OEV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 09:04:21 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16932 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhA1OET (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 09:04:19 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6012c43b0002>; Thu, 28 Jan 2021 06:03:39 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 14:03:38 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 28 Jan 2021 14:03:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zr2Q5qCkUWBUDLZLA057SHzQNk4a6Vth85jd0SOd6bWAHBCNzn/GzG0bwC26euEBEL8OK0mHZO9IZTnVo0xI693F76i24YqtDdbNRx7jbAoaTLiFyeSWFRqOM0g0voCcTiiSu6jkCwqJwapmEIl7LnaVxxfMtAQMFdL3VuBHGo6qp8oL2sqLT14nfx6C7rugWtLfC0uy6fT/Z+9N0qD9bf/Yj/D3lXDeJj+Aqqx2MD/mNZ1braKuY0EY5CMf1J0aIDznr6FYu6qWnVOyVne4ARlMY5t2i6eQzyqq+0AnRg0/VE6ePfUdbH+yJjK90kj8fxkuN5AYOvTm4Fq1VnDvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0rPBMeR8sinPoQu/ysCNaPOiwt9CTkOXbDLf7fz4mY=;
 b=Dn825dVzZksx5+INGVivhc00zsq+7jP+oHxPK1JNQVU/p0S6b7m6u1uMk3QP/j80oxTxd3YE29Fp9LfgbBvwxK8J03/Kc4wwJeAkiBFSUcE3w20bAOpjFC9uOevSTTzFEy7USrFcHmHkwaEWc6GkPknsYa0owMM09RfNVqBaqRRQ+AmGOZOb3S3b6unraEufiyJ8D+the9hD6G/O9ZRnaJiJ0njbWV3alqlQiqbk1X+kJSNFawGKt+6cKWSoxM1zvbvihb3gBd4+KyhIN6x8en64FtycI/WCsLQ8bgG1QNuRyWy1ua4W0zMwMQHIQJj22cve0XpOglV2p2xaI/TS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Thu, 28 Jan
 2021 14:03:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 14:03:37 +0000
Date:   Thu, 28 Jan 2021 10:03:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Lameter <cl@linux.com>
CC:     Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks
Message-ID: <20210128140335.GA13699@nvidia.com>
References: <alpine.DEB.2.22.394.2101251126090.344695@www.lameter.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2101251126090.344695@www.lameter.com>
X-ClientProxiedBy: BLAPR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:208:32c::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0152.namprd03.prod.outlook.com (2603:10b6:208:32c::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 14:03:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l57tX-0003bt-65; Thu, 28 Jan 2021 10:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611842619; bh=H0rPBMeR8sinPoQu/ysCNaPOiwt9CTkOXbDLf7fz4mY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=UcSt48i8yJgFdENWWYSjWZ0f7IQG6Je7EG5W5Z6kG7pFqWY9v4HWuSiUg6fQMS8Xe
         CMzr2dnQLSc5zXT4SzWWTuT7LHqdVSVrD5ET43i7mag0lxTQt41H2vkUkl6nmCpDGN
         8JytT63iQhZQNsO6HO6v4+5NDFpvmQaJyID3oxMyHshPkCQOfJpm0dJGwQufemfbsb
         e2/cDaynVSSkrbm48sAgzwUiBNyhk8BjimTqjkq1Yjgyu9T3j0iFJtXH/YFRAd3MkL
         pJgaABiR97rpig0ae6tOJTagxpbU5aBdDfhZa728lliuF5JiVFndm734QxkEPAyQ3k
         FTHJBytRQMsRQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 25, 2021 at 11:28:57AM +0000, Christoph Lameter wrote:
> On Sun, 24 Jan 2021, Leon Romanovsky wrote:
> 
> > > Since all SMs out there have had support for sendonly join for years now
> > > we could just remove the check entirely. If there is an old grizzly SM out
> > > there then it would not process that join request and would return an
> > > error.
> >
> > I have no idea if it possible, if yes, this will be the best solution.
> 
> Ok hier ist ein neuer Patch:
> 
> From: Christoph Lameter <cl@linux.com>
> Subject: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks

I need patches to be sent in a way that shows in patchworks to be
applied:

https://patchwork.kernel.org/project/linux-rdma/list/

> Index: linux/drivers/infiniband/core/cma.c
> ===================================================================
> +++ linux/drivers/infiniband/core/cma.c	2021-01-25 09:39:29.191032891 +0000
> @@ -4542,17 +4542,6 @@ static int cma_join_ib_multicast(struct

Also if patches aren't generated with 'git diff' then I won't fix any
minor conflicts :(

Thanks,
Jason
