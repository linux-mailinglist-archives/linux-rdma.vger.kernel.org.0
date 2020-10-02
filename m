Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028DF281337
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 14:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJBMzn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 08:55:43 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:54812 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBMzn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 2 Oct 2020 08:55:43 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f77234d0000>; Fri, 02 Oct 2020 20:55:41 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 12:55:40 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 2 Oct 2020 12:55:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoJoC4OdsjXM9jLYzKI8TDH2264auwV4kcqb4dg4SjNwJRfzSl5lQmYxc12+LFiHSMJgZ9vp5IAYH5CII7mkPPv3Xd2SgpfGAB+kF9a+rwSYcDCIs3+LZRJA8dogEACoRQT6vYfscKUQonS/0l+KJSBZ7xe1xvznBg0PgD830nhGqcq5S85jGvBTv29vPAMjfqzAeW+fNiTVi4PWL+BlLyBMBOXwopS+UW4BpxksIAZI0TV7Y5kN75uKVIAsjVbIHV1wf1CnO0PDejbRtGOOK1PLWlY9Zg4DAC+vPw5qKZfsNvEbtZyZj/3JDNtLrYTWmcpjCVpyDtZktWrBBI471g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfpCIshFa94Q79MEn0hsNor1oTr3qwsgLN8XXAJv4gQ=;
 b=JuLS9cGnYe27BShYyrRBsyO7lNk2aSUBzy4eoFTK6yK0ud8qswnD+jNG2Uq4y7Ner/f2GgO3HXqyJ1md6GnXwT+PGMUUQOYNvnz3gj3oMgFNLCKex5leqj3WRSfbJ21V2L1b4oU7btL0PirtQR0XrUACTrPTYEbczLLfAC8FeILFny8OIr4i+ud7eChA6jMvNo26xCw7DqQWacMT53zdDDR7Sf1wW106/NBKit4ilGdaCWbPLQjiAwGbWV5VYsDjR/zXNkQROsKSJ73LJz9WinFSGFNtsN/JUsaSGFMRwXpO3bhagXx6DTKwpk5cyNLQhhsu5FHuhA4erS+OYzBgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Fri, 2 Oct
 2020 12:55:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Fri, 2 Oct 2020
 12:55:37 +0000
Date:   Fri, 2 Oct 2020 09:55:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v3 9/9] RDMA/restrack: Drop valid restrack
 field as source of ambiguity
Message-ID: <20201002125535.GA1344115@nvidia.com>
References: <20200926101938.2964394-1-leon@kernel.org>
 <20200926101938.2964394-10-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200926101938.2964394-10-leon@kernel.org>
X-ClientProxiedBy: MN2PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:208:234::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0059.namprd16.prod.outlook.com (2603:10b6:208:234::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Fri, 2 Oct 2020 12:55:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOKb1-005dld-P4; Fri, 02 Oct 2020 09:55:35 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601643341; bh=AfpCIshFa94Q79MEn0hsNor1oTr3qwsgLN8XXAJv4gQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=idIXAaqDscsqsjR590WjqgRSE4V7fat0h5YDo7qrk2o/Ab3xZ++kK6mgMvNZkntIG
         anZVm4359SNuwJ/zn3zLkr32MmMj7t8t9pDK6gugY30nqaII8OOpJNGE9CCGoF6Yqr
         8shEXXVkaAkzn1pYWvLqo38mKfIoqBBnWtq0vaszb51at9jVwIN1Qmc+hfPAUIaKN5
         hCeZM5MeG1/W5aNTMbfuyFeZeTuQW+KE7Y8DrA7znBlgzL4Qe+L+FphCavB6rL7keV
         DY1gztMzr+l25VqxGRfkIlPaqHo8b2fP/OMq5z3jHqX8drTz8enysUt8c7WCb9/FYT
         Nj/wWuOtnFbxQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 26, 2020 at 01:19:38PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The valid field was needed to distinguish between supported/not
> supported QPs, after the create_qp was changed to support all types,
> that field can be dropped in a favor of no_track field.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/restrack.c | 29 ++++++++---------------------
>  include/rdma/restrack.h            |  9 ---------
>  2 files changed, 8 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> index 593af32d86a0..6ca3e6f3adb5 100644
> +++ b/drivers/infiniband/core/restrack.c
> @@ -143,7 +143,7 @@ static struct ib_device *res_to_dev(struct rdma_restrack_entry *res)
>  		return container_of(res, struct rdma_counter, res)->device;
>  	default:
>  		WARN_ONCE(true, "Wrong resource tracking type %u\n", res->type);
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  }
>  
> @@ -223,7 +223,7 @@ int __must_check rdma_restrack_add(struct rdma_restrack_entry *res)
>  	struct rdma_restrack_root *rt;
>  	int ret = 0;
>  
> -	if (!dev)
> +	if (IS_ERR_OR_NULL(dev))
>  		return -ENODEV;

dev can't be NULL

Not sure why this was changed? The error code is always thrown away,
what was wrong with keeping it as NULL? 

Now that all callers check the return code this should be a WARN_ON as
calling restrack_add in a way that is guarenteed to fail us a ULP
error.

> +	WARN_ONCE(!dev && res->type != RDMA_RESTRACK_CM_ID,
> +		  "IB device should be set for restrack type %s",
> +		  type2str(res->type));
> +	if (res->no_track || IS_ERR_OR_NULL(dev))
>  		goto out;

dev is never NULL so that WARN_ONCE doesn't work

Why does this exclude CM_ID? I thought all the fixing in the cm was so
restrack_add and _del were prefectly paired and a device must be
present?

Jason
