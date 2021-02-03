Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B062030E3B9
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 21:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhBCUCI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 15:02:08 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11872 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhBCUCD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Feb 2021 15:02:03 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601b01120001>; Wed, 03 Feb 2021 12:01:22 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Feb
 2021 20:01:20 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 3 Feb 2021 20:01:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egWls3ZylRdwL3f8zKtblALRvjpiFP1IXrGqjjJGVSu3yKiq+WX5+9afsM79aIi8AeIa+voYDDsj8Ypt0d4Ftybkm9el7BF0NeiVjdxItQc1xHY5TP2e+a8+XKt9GAcn1vJv2pdxlS+k4Km5b5kil6CVQ1xcSB+cBY9E+qiz0EYQK1qYZ5WozluhWBZsx6Q5pRycxi1l7xuwzNstRhLazffNfJoYLQodqV8kvKbfxpv3yJIHLlFsy61a8iWl16GrdaREjLogHu4xi50eW2tCGu5IZEoGHfhbrVP+kthhDGuvoZXwDdRcFE6xd9DMjFPFdnbyg+nVmkGt3hZpCKF/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fGkRFIo/i8HZlwZ318QFExtl1ETCgfMS0jKSzUUtm8=;
 b=EqAjXTUrpaQ5SmGD5Vj7I3WTdakqemqXRuqz6/8TXBaZY7iQvnAcc/P9YwIzdtVVpFnZnLdfrOZK58b72a2tLHX0NpDHHVNzjVB6C/xFDgutqy9GB1f0B4hDRvYJ7utMjleXUabu0fBSpf4fMBzNHiXhxsROki76QmE8/YjAHxeG3GzcpOy9SXH61V7xf2xF0y12DmSYwRGI3ktu72z32+uy5BlDuS0+Rd49dWvqf+ljUdze1FZxQ9FNs5OCimnHChOdqMYndVH8oEAnTF5PB0f7iCgZQsb0uQA3Y94lTM1M6A011O8EjyQymf934Y//AaRIhtS070EvfNaXZIggFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2603.namprd12.prod.outlook.com (2603:10b6:5:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 3 Feb
 2021 20:01:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3805.025; Wed, 3 Feb 2021
 20:01:18 +0000
Date:   Wed, 3 Feb 2021 16:01:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Amit Matityahu <mitm@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1] RDMA/ucma: Fix use-after-free bug in
 ucma_create_uevent
Message-ID: <20210203200116.GA740542@nvidia.com>
References: <20210125121556.838290-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210125121556.838290-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:208:23b::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR11CA0026.namprd11.prod.outlook.com (2603:10b6:208:23b::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Wed, 3 Feb 2021 20:01:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l7OKy-0036md-Hx; Wed, 03 Feb 2021 16:01:16 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612382482; bh=4fGkRFIo/i8HZlwZ318QFExtl1ETCgfMS0jKSzUUtm8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=DxywuNKZc54Hrziei2U937vVGOIwp+dmNExaxdrKSqCUBjAahwZtZH+vOHqrhxanj
         2csPlJIPFBBU9c2vY3qh++XPeOc8Nyj4ybp2/BW/T2WaWR/GcOiY3sKhhc+8xXRRva
         ctkx6AJ21MPlaUbUSYPv2+TxOMlBPLDh+JdYY7xBs081ZZjibnLCjJ1+vzEG/8+xEZ
         okb3p11QuABtu64wqM2PA5b197orTvBm0RS5hIQBATN70EGGsboSm0sVp5i+9SGRnc
         5YACLz2R82Pu5JfjkNatibubX7RQJn1JC0MaM6P96Kdjd/zC5qjzDYV5plBUBPwlFF
         u7MD5s7OigCYQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 25, 2021 at 02:15:56PM +0200, Leon Romanovsky wrote:
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index e17ba841e204..7ce4d9dea826 100644
> +++ b/drivers/infiniband/core/cma.c
> @@ -352,7 +352,13 @@ struct ib_device *cma_get_ib_dev(struct cma_device *cma_dev)
>  
>  struct cma_multicast {
>  	struct rdma_id_private *id_priv;
> -	struct ib_sa_multicast *sa_mc;
> +	union {
> +		struct ib_sa_multicast *sa_mc;
> +		struct {
> +			struct work_struct work;
> +			struct rdma_cm_event event;
> +		} iboe_join;
> +	};
>  	struct list_head	list;
>  	void			*context;
>  	struct sockaddr_storage	addr;
> @@ -1839,6 +1845,12 @@ static void destroy_mc(struct rdma_id_private *id_priv,
>  			cma_igmp_send(ndev, &mgid, false);
>  			dev_put(ndev);
>  		}
> +
> +		if (cancel_work_sync(&mc->iboe_join.work))
> +			/* Compensate for cma_iboe_join_work_handler that
> +			 * didn't run.
> +			 */
> +			cma_id_put(mc->id_priv);

Just get rid of the cma_id_get in cma_iboe_join_multicast() and don't
have this if

>  	}
>  	kfree(mc);
>  }
> @@ -2702,6 +2714,32 @@ static int cma_query_ib_route(struct rdma_id_private *id_priv,
>  	return (id_priv->query_id < 0) ? id_priv->query_id : 0;
>  }
>  
> +static void cma_iboe_join_work_handler(struct work_struct *work)
> +{
> +	struct cma_multicast *mc =
> +		container_of(work, struct cma_multicast, iboe_join.work);
> +	struct rdma_cm_event *event = &mc->iboe_join.event;
> +	struct rdma_id_private *id_priv = mc->id_priv;
> +
> +	mutex_lock(&id_priv->handler_mutex);
> +	if (READ_ONCE(id_priv->state) == RDMA_CM_DESTROYING ||
> +	    READ_ONCE(id_priv->state) == RDMA_CM_DEVICE_REMOVAL)
> +		goto out_unlock;
> +
> +	if (cma_cm_event_handler(id_priv, event)) {
> +		cma_id_put(id_priv);
> +		destroy_id_handler_unlock(id_priv);

This is a problem, destroy_id_handler_unlock eventually will call
destroy_mc() which will deadlock. The IB side has the same bug. Since
multicast isn't use in-kernel and ucma doesn't return anything but 0,
this is all dead code, lets delete it and just leave a WARN_ON(ret)
In the IB side too

> +		goto out;
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&id_priv->handler_mutex);
> +	cma_id_put(id_priv);

and this put too

Jason
