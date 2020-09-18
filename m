Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887D4270923
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 01:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgIRX0Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 19:26:24 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13415 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRX0Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 19:26:24 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6542120000>; Fri, 18 Sep 2020 16:26:10 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 23:26:22 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 23:26:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkjbuAHv+EXyFdOhiJhsExmubS1YWzyMct9rRTgw6Tw9RYcoyULqrSNBRlL/+JAoh0WNxA7hTMI9EfqRueKmMvjocZbQ+KpgxKjYXoKu+ormkO6Q/+URfktqdQrzanwsmOvbp51Vf7+cvXQaEVWc4ZQBwREDUmvPC/jMYIyodGGQy+YNbXAPiuY+gJ23J2Tnpv5BQYZMABFAmCvj5r0amKmjmcN/rzg2QPeY65gkGTdBuWz1jssFrBzQGEg5KwrJUs8yAGitqXz2lMYTlxafr4WP6awKQ2R3We0X8sscCrHg7ksjE3ecjBaYeJobMa5igeREz4ap2YhyNBOnGozyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfWk42SGsdgP4dssF8jEGY+BBj1IlrhlXzpTqAVYmF8=;
 b=RWcRD6L4rWYs/Vz8/MZ+bphDuCWSxDBiJo+s0GKekc/SLyetv250mgO2ieQUFpI+coYDFAEnbbHk0NciTzdorhrkQMa+uhT6vfYMfEhjfCbS42c6mdMo180iZVA2svvaaY5qpc8sZMEAKhxt4AwiEsfCGRVLbttqU13tez4NHVg9ueVZ/v1n0LG90QNxram3uagpWpQnqKHT66p3xSAteG9c9MRiLl3i1P24jdyBkJ1tjrITWhwnlzb0RkFcgLDYLyVf2vjmrUko/eNZ2dUa3/NiaZ5oYUqPWKsTU8d1uNyO2pdZAEboWHuNarUtdzEYyp+P/UlrMzq7t5HVjp8/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 23:26:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 23:26:21 +0000
Date:   Fri, 18 Sep 2020 20:26:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 07/14] RDMA/cma: Be strict with attaching to
 CMA device
Message-ID: <20200918232619.GA450933@nvidia.com>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-8-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907122156.478360-8-leon@kernel.org>
X-ClientProxiedBy: MN2PR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:208:178::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0023.namprd19.prod.outlook.com (2603:10b6:208:178::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Fri, 18 Sep 2020 23:26:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJPlj-001tP3-VE; Fri, 18 Sep 2020 20:26:19 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b85e4ac3-0cc0-47e5-f11d-08d85c2a4089
X-MS-TrafficTypeDiagnostic: DM6PR12MB4499:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44997599A561CD8F85ACC76BC23F0@DM6PR12MB4499.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SxDSGGXXmWdQ3NA34TCOscXPe3IYbKtZLAwSS0+4sUhjJlwFq/0LoCIKsSDDhEuVtVJVIWhFTO5meTtZWixEGMdyUD3vY7yQE+H/bPvYpPlWTw+09HwThSqM+pAW84myZA9jG0Qy32BVqvR3kMKI5p6Gds/1mx/kfQJk3t8DwSiIjunSnsmOSUWw/+3G9xFhAxpIrdB4xRzXXwVHU57Ukn6vZNOMPW7vSeLPBla07ULbeeAQHOK322bdAw/x0CyBjpPo+GH5W/KDmAqs5mYUEW5NovqSqe9cyOda5GpK9X/1oMLVt/5dlkKkLpUzYSnuxl/1ws7MND9yI14XvlvJcxZHuZFHcj6/FVFMeSZO7pqykBI1Z/yTlPNRVCUOdLW/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(86362001)(54906003)(426003)(66556008)(66476007)(83380400001)(5660300002)(36756003)(4326008)(478600001)(1076003)(8676002)(316002)(186003)(26005)(2906002)(8936002)(9786002)(66946007)(33656002)(9746002)(6916009)(2616005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: x22xAsUq3g/rdI3e/LxMIVTdXhsjBnI5UQzTmGainQa2iyV9BXgmYf8PSLJADcrWHAymw0PPHuXZ4mRG7GvYqEsdx/zDjiQaU2AHTJucLBxHCf2tBS9Phbm8B2Mfd/paMKcGVFFxTHC01laVnEaNj2zSxRWfAGpruodqXsyaz/q4VIdlCzvDaXdA/Lw8prsfdFaU2TmEXc9IIPMZCq8hoi+QGWgi7MYdlQ6ZuH9pXzS99UJDd0GrbyIKYt9ls9afYMVGubaADk5l1fIGNMEGZYPZCfnVMUqsDgJ/MjFZmsuS112TzbjjJ6JJf7nd/ELR+TVUuhVW6xAxcCgWKbS8RapAOTGU/xpKDkKQW/G2WxcLXK0XAJBkfPPI1Rv4B3OFNAQNCScabmYG+oM8U2qTPLHootxQp30UQy6ScdomMB1uGZF1m/KwqkIj0FDOiw/jkSeCUkeQL4EZ/KItWuHJlVMPMvkx/uFKoni/J+IIsYM5JMaTi+HBNhJQWvgBb1OYRDbNXSXtk9LSwMt27DU4nipNLsfXM6ttjX0SEFUaeIl+sA3/6tiwtJ6syRp9GPPGrG4yz5/l/Ho+NK4JlyAsu9ODFhVEzVcKVUYUcy5NHsEhd8bBKDE8jr8q9WjqUijBnFBFjRpsiu3B5s4i1BrxWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b85e4ac3-0cc0-47e5-f11d-08d85c2a4089
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 23:26:21.6587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1CI/whlpVioXwtu3V8Fdy+kC91iN7GNwiJB+sLvetKhvEPduUfT0+ZBD19dSfO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600471570; bh=cfWk42SGsdgP4dssF8jEGY+BBj1IlrhlXzpTqAVYmF8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=NQK+A1pn7d+juL5UHSUSpXcrj029O3SYAFJhAW74PAZ5ZCxA0NzdpZq2lDflts6aP
         mXp4pzPnuytz7zKyCHPR6EEZ7ZEk7cJnRuSca64Aofdxf9/ySsvigi4lAdT72ODecJ
         eEuP9PsXndeC/HjY6UKeAPrQLChySHqpTxBs6g/9NFOtVo/oLzlyQqG13a9aszppuz
         ihz7qbE68PrvPCUzgqr/6iGEySQ8uqpTK6YjUZlBNqW9awB+NjzOH0KNT5e64Nq3nj
         8Jy/zJKX6BUpyao3zhGOSNkOkZ6khoYH4cjbCtaJbKGhhtrpbeuimpd9sVevIfEosM
         k6PKqW9FQxA9w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 03:21:49PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The RDMA-CM code wasn't consistent in flows that attached to cma_dev,
> this caused to situations where failure during attach to listen on such
> device leave RDMA-CM in non-consistent state.
> 
> Update the listen/attach flow to correctly deal with failures.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/cma.c | 197 ++++++++++++++++++++--------------
>  1 file changed, 114 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 3fc3c821743d..ab1f8b707a5b 100644
> +++ b/drivers/infiniband/core/cma.c
> @@ -458,8 +458,8 @@ static int cma_igmp_send(struct net_device *ndev, union ib_gid *mgid, bool join)
>  	return (in_dev) ? 0 : -ENODEV;
>  }
>  
> -static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
> -			       struct cma_device *cma_dev)
> +static int _cma_attach_to_dev(struct rdma_id_private *id_priv,
> +			      struct cma_device *cma_dev)
>  {
>  	cma_dev_get(cma_dev);
>  	id_priv->cma_dev = cma_dev;
> @@ -475,15 +475,22 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
>  	rdma_restrack_add(&id_priv->res);
>  
>  	trace_cm_id_attach(id_priv, cma_dev->device);
> +	return 0;
>  }

This commit message doesn't explain this patch at all. This is adding
a return code to _cma_attach_to_dev because some later patch needs
it. This should also be ordered directly before the later patch

> -static void cma_listen_on_dev(struct rdma_id_private *id_priv,
> -			      struct cma_device *cma_dev)
> +static int cma_listen_on_dev(struct rdma_id_private *id_priv,
> +			     struct cma_device *cma_dev)
>  {
>  	struct rdma_id_private *dev_id_priv;
>  	struct rdma_cm_id *id;
> @@ -2491,12 +2500,12 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
>  	lockdep_assert_held(&lock);
>  
>  	if (cma_family(id_priv) == AF_IB && !rdma_cap_ib_cm(cma_dev->device, 1))
> -		return;
> +		return 0;
>  
>  	id = __rdma_create_id(net, cma_listen_handler, id_priv, id_priv->id.ps,
>  			      id_priv->id.qp_type, id_priv->res.kern_name);
>  	if (IS_ERR(id))
> -		return;
> +		return PTR_ERR(id);

And there here it is fixing already missing error handling, seems like
it could be two patches

Jason
