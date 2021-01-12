Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635B22F3DC0
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 01:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438040AbhALVhO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jan 2021 16:37:14 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:18299 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436691AbhALUKL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Jan 2021 15:10:11 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffe01fa0000>; Wed, 13 Jan 2021 04:09:30 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Jan
 2021 20:09:30 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.52) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 12 Jan 2021 20:09:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3M7Kn7w7m1lA7Y1Uixqak+6C9V1jkGyjpTcf4MprKLv+Fqc3Kmt7ffyPogkSwAt5FKKEFyh4QxpNWZFKWaqNJ6FuoKO0VwwtAAM+Q5FDqmO9Itq+ZJ6GEm4tV881BrhXcGD+EheYWkyXJliM9xV9TzTy7vBgVY6f/SaouEGrwqMF5CoJrRkfqnUrS/Q4opFYyMR4X4sbOHPY96fqijFptInrkOrM4QJw5TqhKzuwzY0QVJYETPn1QDoHZu5qdYngg8io51HbGDu2LgxrxTTITXJY4MZmL2Q7XcM+JG1rxVQCwRJFygGTh16xvR6TyAJyLSjwHheI7jCyUmPg3hd6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7/ln6lxqH0vAxNc5Kr4gB8dwKVVxMm7KbNVAvdebLg=;
 b=ddGa5lmdSiwLvV4gwDNvpQWa6TqQvSaMlECmY7MQ4deXReuiEtwRuuQa/s86mpiX6tGxWnpgWJrTRUgvngrAhAv61kZ1zT2jhDOSi1IzKR8jACxqwx1J2a1r4aINHTWyMA3/MHlnnLmfGIZdzlx4So9N0wGdkg5eFxi6jjC8mwAEzskHQ5np39diGXjJ+8NzXAfpaXSZaWnRtSR7lPBAF6VMxrU9wISRNrMgsfw76eECzcU0KF1PZ3OVaWqXrP9afOdhIsYoOa1xd2ZjUuYzchv8iayOzBoV6xGgFHLtrMIIM6c5YgypYEP0IDfL9KHgJHGhuUifC+R8vWkNF0nX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 20:09:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 20:09:27 +0000
Date:   Tue, 12 Jan 2021 16:09:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Yishai Hadas <yishaih@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <leon@kernel.org>
Subject: Re: [PATCH 1/2] RDMA/uverbs: Don't set rcq if qp_type is
 IB_QPT_XRC_INI
Message-ID: <20210112200925.GA20208@nvidia.com>
References: <20201216071755.149449-1-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201216071755.149449-1-yangx.jy@cn.fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BL1PR13CA0237.namprd13.prod.outlook.com (2603:10b6:208:2bf::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2 via Frontend Transport; Tue, 12 Jan 2021 20:09:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kzPyn-0005gB-6g; Tue, 12 Jan 2021 16:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610482170; bh=y7/ln6lxqH0vAxNc5Kr4gB8dwKVVxMm7KbNVAvdebLg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=NNHgmtLrY+w1Ye1GbCBfjrtIzHIFtqabbXlZC9VKXPaPVqvOgjls/wX2K/5a/AKOD
         xYHNooDvPanRrY+3pPZ/IYWfhyGt+UlGKxwvEBuWZ5jc6C0tDe5oZ+N1ku15zWhTls
         a43lpxXU+WZu42QVimAvmrpm8KnB+2SW+Jw5axFTLOFRhentEP2mGiq8km2tE4JGHD
         gMMSh63dbckIGR+xt+MMOUrK1HSy+67ztERj9PrkSwPeBTU/uyHyn38K1weXmg9o7N
         /nkCEeOXCdseB5jg1gtDFs8Jt/Xv0vniGPKVXHIe4tiYMSWF+dxXXEkG+3CO11mvy/
         A5FTGJyJHJD0w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 16, 2020 at 03:17:54PM +0800, Xiao Yang wrote:
> INI QP doesn't require receive CQ.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>  drivers/infiniband/core/uverbs_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 418d133a8fb0..d8bc8ea3ad1e 100644
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -1345,7 +1345,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
>  		if (has_sq)
>  			scq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
>  						cmd->send_cq_handle, attrs);
> -		if (!ind_tbl)
> +		if (!ind_tbl && cmd->qp_type != IB_QPT_XRC_INI)
>  			rcq = rcq ?: scq;

Hmm, this does make it consistent with the UVERBS_METHOD_QP_CREATE
flow which does set attr.recv_cq to NULL if the user didn't specify one.

However this has been like this since the beginning - what are you
doing that this detail matters?

Jason
