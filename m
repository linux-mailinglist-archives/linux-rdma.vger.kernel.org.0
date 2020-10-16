Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBC0290CC6
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 22:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395513AbgJPUdU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 16:33:20 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9006 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395502AbgJPUdU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 16:33:20 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8a03630000>; Fri, 16 Oct 2020 13:32:35 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 20:33:20 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 16 Oct 2020 20:33:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+8Jt7ijWr/90Pu2qRSVjlJjY6VjL63Ui7ipyMVAG17q2sAXDVuvhIqogQ4rEOgITF6bklVjJrc5rgrmjiBidlsVeuF2QNGQhK+B8DyB2D+rBPfUNGukrlHFVykX8khuGXr23XPoACWWVa629xTTE4s0OrWWr7JO/0ueTVo4/6FZciMpbGghB6Q5xTjWsf9r34u3TiN7czryMtJDerLqu0AYaiIC+1WghqytCx7tzmYFU1okvVCOKkBf8GrmVAiIFooiOdFD+o2ZbZ3zmKdNk1wjbkwfkm4bHsELXJzS0Ul1gA62geQBItg+SPaMDHr4CUbqsn1d5MMEstpR7nt14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpXmCNSDXZz+4tyJXA5AZk1yqS2U56Nu/0YLGdL56aQ=;
 b=EjFeNIltlM7ZjR3voJiXJJWPvRuU17Znbv8ZsPD5edS7F8LP5p3qfS1mnTvoz5swp8h2+13IRW01hPrSM8bfSpHXlCAogVIsA4n804KEp5HTX76vKmS9gzLXUwsZlkjX0xiQ3PGBxGD9Dm5RcIS4HNeS2IZLhm52o3JLgc660wkGnfhQ7mdt3z6zW+De9DAD37R1yq6Ui3CMUFjeco7QcJvCoKIXPAGr2yU20WtsZxon/S7IWpspEdTfNY7OJiWrWbSEeFmp/zuJu00fT4ToSALETocVn+9Pj4j2iuJ19YyIu3dIJmx1fyWY4m5FetoS+/VDvjHOFVh0Bcqa6i2niA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Fri, 16 Oct
 2020 20:33:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.020; Fri, 16 Oct 2020
 20:33:19 +0000
Date:   Fri, 16 Oct 2020 17:33:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for next] RDMA/rxe: Fix small problem in network_type
 patch
Message-ID: <20201016203317.GS6219@nvidia.com>
References: <20201016202645.17819-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201016202645.17819-1-rpearson@hpe.com>
X-ClientProxiedBy: BL0PR02CA0121.namprd02.prod.outlook.com
 (2603:10b6:208:35::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0121.namprd02.prod.outlook.com (2603:10b6:208:35::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 20:33:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kTWPd-00109w-Lr; Fri, 16 Oct 2020 17:33:17 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602880355; bh=RpXmCNSDXZz+4tyJXA5AZk1yqS2U56Nu/0YLGdL56aQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=ezjtCaiUxaXLvebJpZLKzkVSCN8GS8OAS0xt7fjNIhg3X2DzNQ7DOlskc5iJfv3HZ
         dSnEQCGTnTkEFLS6bb+TXoIz1Hg+cDFQldj3ldnJ2gy7hYvpmQkRAMJKW++7u2+Jzf
         IOlXHbKRiSZBKTkr/Gkmwd3oBESCziFxytw1bicnCoaMjwoTTVwJ2N3fgSEUO8tVn1
         X0XDGH0XGTRRCOoYp0zNm68XVIow8d+3EohIh38hkQ2BA9rSKwWE8ZDTWkRvTuRUNZ
         OwBlhhodinJDLqmSrcPPffBBu8vCnOuy6Kc3zTa0BwkqHpyiL2ZxN5Q2c1+2/I4pLq
         jArs5yG1s3jPQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 16, 2020 at 03:26:46PM -0500, Bob Pearson wrote:
> The patch referenced below has a typo that results in using the wrong
> L2 header size for outbound traffic. (V4 <-> V6).
> 
> It also breaks RC traffic because they use AVs that use RDMA_NETWORK_XXX
> enums instead of RXE_NETWORK_TYPE_XXX enums. Fis this by making the
> encodings the same between these different types.
> 
> Fixes: e0d696d201dd ("RDMA/rxe: Move the definitions for rxe_av.network_type to
> 		       uAPI")

Don't word wrap these

> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>  drivers/infiniband/sw/rxe/rxe_net.c | 2 +-
>  include/uapi/rdma/rdma_user_rxe.h   | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 575e1a4ec821..34bef7d8e6b4 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -442,7 +442,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>  	if (IS_ERR(attr))
>  		return NULL;
>  
> -	if (av->network_type == RXE_NETWORK_TYPE_IPV6)
> +	if (av->network_type == RXE_NETWORK_TYPE_IPV4)
>  		hdr_len = ETH_HLEN + sizeof(struct udphdr) +
>  			sizeof(struct iphdr);
>  	else
> diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
> index e591d8c1f3cf..ce430d3dceaf 100644
> +++ b/include/uapi/rdma/rdma_user_rxe.h
> @@ -40,8 +40,9 @@
>  #include <linux/in6.h>
>  
>  enum {
> -	RXE_NETWORK_TYPE_IPV4 = 1,
> -	RXE_NETWORK_TYPE_IPV6 = 2,
> +	/* good reasons to make same as RDMA_NETWORK_XXX */
> +	RXE_NETWORK_TYPE_IPV4 = 2,
> +	RXE_NETWORK_TYPE_IPV6 = 3,
>  };

No just transcode them in the only place that matters, we still can't
break userspace

Jason
