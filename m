Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4588D2813C9
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 15:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJBNN1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 09:13:27 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:13112 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBNN0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 2 Oct 2020 09:13:26 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7727740000>; Fri, 02 Oct 2020 21:13:24 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 13:13:23 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 2 Oct 2020 13:13:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjNtZgb2tpb3/NEIrlj1criHvMT2SWS1rYScR06VyPP1D+kI/p/MalxplPAZ1KrwuyQteLNdAedcnQqB7mfjb688IeeOqdE1JoDys5DPe26aDSjHn8ZG6dcBriwnk0dAL30oaT9dDzUAQktPGGdoVcCD1sylrC/1q9dZ8Isc2+0MI4QLI3k1w+WROW8v+0a+cC0jFVYvqrnd3ULuHRNtfWBSfXW0Vf7CesA9pX55ovM3jVWJMiHgTETZzEKMDWDafLKssHYFVobM5jqF/mmP/03CJFg4Z4offBNRDcrbS/DAfCIedXGujoZJa6X/miZ89CiNqHTf5JDp1IEkPd9ixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dK5Ffns5b7sAINooR+R8uIDB32fcJRrP4zl8GlGBx8I=;
 b=Dw/0BckckFOaIpUP8wRrCNLnpHO3TuGqEuu/L1OFHFbgvDnUKUIKbseIxzldekXEEvG7P6SmINIGK27rtiRi/cmtRhwj8kSXGgzaSNNNWEkoruH0fc9kNF6nIycYkQRZXCH7HkVQhhcjPqLuL7y6CQLP0z9BTOD90QDnH/uxpKkXEwwJfN7+ynxhBvoB+y46s20jlR/nXdPaTA3rDXH9wS/ebz5+vayXQnVpqJaDbA+EDEKIe4kq2yIl9WqaxJKNrt2mF0CB1B6HFPmqJ3156FT1zdjXBH3p2G3j3cuJyC4I0yDrzvfNdCLW5VqMCjcjCQuD4TuZJDHs4jPEr8DVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Fri, 2 Oct
 2020 13:13:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Fri, 2 Oct 2020
 13:13:20 +0000
Date:   Fri, 2 Oct 2020 10:13:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Mark Zhang <markz@nvidia.com>
Subject: Re: [PATCH rdma-next v3 6/9] RDMA/restrack: Add error handling while
 adding restrack object
Message-ID: <20201002131318.GA1344650@nvidia.com>
References: <20200926101938.2964394-1-leon@kernel.org>
 <20200926101938.2964394-7-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200926101938.2964394-7-leon@kernel.org>
X-ClientProxiedBy: BL0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:91::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:91::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.15 via Frontend Transport; Fri, 2 Oct 2020 13:13:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOKsA-005eDI-VX; Fri, 02 Oct 2020 10:13:18 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601644404; bh=dK5Ffns5b7sAINooR+R8uIDB32fcJRrP4zl8GlGBx8I=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=HNX9GF2HW62PwyzW4LwIRxcNBNP1ip+Fb7/+WjkbxLFd+znvI3P8r9Mg6PlcTJhY6
         7xkuKeghGkgYJNG7qOwso6WQYkel3MN2xheSoRrzeQCM6l1CuX5CTfix3EMACC+tY5
         9TwbwHrs5JshCH3d+30ElBcFUKQr+NaUDxIuNoWlOx65827WF9OpSBj0YbC4zmhr4K
         tBXzm3HYgKJrh4PPNbFXTUkmr4+cx8CYNhDoIBij3T2awC+OnBb7FwrCKvbH8BZ5pU
         ScUg2azvVaUODBGBqBy/x0eir6V0oyccgwn0YKbTG1jqkJs6IcmS3a2N7OAy7p9PWH
         W7A0Dxpxs0OaQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 26, 2020 at 01:19:35PM +0300, Leon Romanovsky wrote:
> @@ -449,7 +453,10 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
>  	ret = ib_dev->ops.alloc_pd(pd, &attrs->driver_udata);
>  	if (ret)
>  		goto err_alloc;
> -	rdma_restrack_add(&pd->res);
> +
> +	ret = rdma_restrack_add(&pd->res);
> +	if (ret)
> +		goto err_restrack;
>  
>  	uobj->object = pd;
>  	uobj_finalize_uobj_create(uobj, attrs);
> @@ -457,6 +464,9 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
>  	resp.pd_handle = uobj->id;
>  	return uverbs_response(attrs, &resp, sizeof(resp));
>  
> +err_restrack:
> +	ib_dev->ops.dealloc_pd(pd, &attrs->driver_udata);

There can be no failure between allocating the HW object and calling
uobj_finalize_uobj_create(). That was the whole point of that scheme.
It is really important that be kept.

Now that destroys are allowed to fail we aboslutely cannot have any
open coded destroys like this *anywhere* in the uobject system.

I think you need to go back to a model where the xarray allocation can
fail but we can still call del, otherwise the error unwind is a
complete nightmare.

This also has problems like this:

int ib_dereg_mr_user(struct ib_mr *mr, struct ib_udata *udata)
{
	rdma_restrack_del(&mr->res);
	ret = mr->device->ops.dereg_mr(mr, udata);
	if (!ret) {

With the uobject destroy retry scheme restrack_del will be called
multiple times.

I think this is pretty simple to solve, write del as this:

void rdma_restrack_del(struct rdma_restrack_entry *res)
{
	struct ib_device *dev = res_to_dev(res);
	struct rdma_restrack_entry *old;
	struct rdma_restrack_root *rt;

	if (WARN_ON(!dev))
		return

	rt = &dev->res[res->type];
	if (xa_cmpxchg(&rt->xa, res->id, res, NULL, GFP_KERNEL) != res)
		return;
	rdma_restrack_put(res);
	wait_for_completion(&res->comp);
}

There is no need to do the wait_for_completion if we didn't change the
xarray.

Jason
