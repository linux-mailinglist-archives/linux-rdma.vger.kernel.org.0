Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8FF2F3DC5
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 01:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436792AbhALVhS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jan 2021 16:37:18 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:64191 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436777AbhALUQO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Jan 2021 15:16:14 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffe03650000>; Wed, 13 Jan 2021 04:15:33 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Jan
 2021 20:15:32 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 12 Jan 2021 20:15:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFgrGq8YCNb9FV7MG7KSXKyFV8Unx9CZ65nNX4Lh7KAt5v8VxUo152BsoLtkCxlFrnAXwsFAP0sbkl3UWxoM9SlU93WrnNkpsuZFvNwIr0X683x7gOUPqIB/H+qv0Eow2qPqrdMdfg3DpmTude6qKPcRdRzGhvHqgg8GEOMG+s/xscNKeg7od+tx689GOAXnjMAiginbRXxQcF5SBIwnPLQrUe98COD3UygM/m+R6AytsNsVIMLXFB4RFqJaMxdDnL9xNEosU5UsdgNDnaPli7qYhXP0Lb5CFpqFZLpDVAMFAXiQ235T3OzkNx5b7MjvGQ1DOr2ve8HGx3TUfSDU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u81GuTi4/btSz6Y538l7Ido/zkGDb4CnL5yb/sqTLEs=;
 b=gaztmE3x59jkYSTwqIOao/Fma+APpkZVibYmBuQ2+25NQrGv7K4Co5A3VpL3VCE/dSZFDyRVwIkyFe4PagZfFXPkD5DjfLGk6+H2F4R6pPTxfFFzieh0LzAOHs1tJCJqtpe6ZUIadt+x9KX4mF06UpthivPDYv/bFpRbylhv0JCm55BEGcVqd4nEVBPe6OBNe8TiLdnRU4equSgyttwlzyKpHfkDbNv1pLnesNYcr7svnSwbqxgGXhxXhURAwxovVXgxg1e73IoM0pqx97RiJViemUjnuheq/KmgpjykjqBmRxaFYnoVWD6RCihZE75X9O7jf3jOMK49xeOyrDqMFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 12 Jan
 2021 20:15:30 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 20:15:30 +0000
Date:   Tue, 12 Jan 2021 16:15:28 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
CC:     <linux-rdma@vger.kernel.org>, <leon@kernel.org>
Subject: Re: [PATCH 2/2] RDMA/rxe: Add check for supported QP types
Message-ID: <20210112201528.GA21931@nvidia.com>
References: <20201216071755.149449-1-yangx.jy@cn.fujitsu.com>
 <20201216071755.149449-2-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201216071755.149449-2-yangx.jy@cn.fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:208:2be::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BL1PR13CA0192.namprd13.prod.outlook.com (2603:10b6:208:2be::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.6 via Frontend Transport; Tue, 12 Jan 2021 20:15:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kzQ4e-0005uG-5c; Tue, 12 Jan 2021 16:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610482533; bh=u81GuTi4/btSz6Y538l7Ido/zkGDb4CnL5yb/sqTLEs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=hbidRWooXsaMOjqE+sOAYjjw5yXznXEo4LsKMZFBAlVXM/rbhn6M658IdnlK56FWA
         jelv3bTH5gfVHgkCGZldN7WcXP0bpvStvWZqzNCXeQYCK5nACOIPv6OKUqerPzcBl2
         RBuNQ6u2aGfaaCTYgG+l4kOFj7f3fPRTrHuIdqWuf2DgH8b13eSy5KPotVU9mIaAvL
         /WbUn0EgivzOLk+7kQwSxridVBM1Pim6kgtvOyhXEibvh6ptKwuUDLvovwFG36Wrj5
         wEfFniqWNts+poZb3YbwqM0G/ndx7TXob4FT/YXtL9Xa3WEH4H2+RZZYNOZ1YNCTbt
         SPnoBfvTxWn5g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 16, 2020 at 03:17:55PM +0800, Xiao Yang wrote:
> 1) Current rdma_rxe only supports five QP types which always sets recv_cq.
> 2) INI QP doesn't set recv_cq(NULL) so creating INI QP over softroce
>    triggers 'missing cq' warning.
> 
> Avoid the warning by checking supported QP type.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>  drivers/infiniband/sw/rxe/rxe_qp.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 656a5b4be847..65c8df812aeb 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -62,6 +62,17 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
>  	struct rxe_port *port;
>  	int port_num = init->port_num;
>  
> +	switch(init->qp_type) {
> +	case IB_QPT_SMI:
> +	case IB_QPT_GSI:
> +	case IB_QPT_RC:
> +	case IB_QPT_UC:
> +	case IB_QPT_UD:
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}

This does make sense, but not really because of recv_cq - rxe doesn't
support other QP types at all and should return an error when making
an XRC anything

So applied to for-next

Thanks,
Jason
