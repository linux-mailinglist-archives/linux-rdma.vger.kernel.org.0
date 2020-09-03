Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B1025C69A
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgICQVx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 12:21:53 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17381 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgICQVw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 12:21:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5118120000>; Thu, 03 Sep 2020 09:21:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 09:21:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 03 Sep 2020 09:21:52 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 16:21:52 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.56) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 16:21:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAw5IcsOvLEM0/F4NNAk9kDTHY5Vo76BGik8maVud4etf6MtZNbT29g71cF5TB88Csh6bhe+YzXxXHv6W8neO2lLPKU57lYlS3mXJ+42gIJsRahxBomGGWcwYOfnvHAJdCA1j890zEdFhgatxTpwnoBOc1jaFDR3i42KOPRY1TJzsKGDbqG/lCL2ZGyG7VWy1xY9QKyVG7HU9G8jshv1AWVtQHior7cjpJGE11+XlDElCBMGnnJD3cTY/yn7a808GHc3vnhPlDNPgYMT7IanWghsI4b6uEfoeL4VNMpGrQU7gQtlBnb1LAzczj2UdSH1GgGTUEcU4SiVYWXSWcNLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqyKhE77ALwlTmos/soluQCTtRFfDKxjCy5bl4GFEfg=;
 b=m3M3cs4bgZ3819g4sN+W1TCbmK8OS+2CfrU8TcPGVnOaoLarOv1/GdQ9wNZRD8YaWhzjlDCX7zkA0hBvYpbTDp2EptHRd8GtTnF7qA2YcY1jTiJulorzXloUrLM0BUx0y79VXM+pjwwO5g9qKzL4uJF+z54WUioplJpaJpeaoVR9NBYEJkkhRcZDP2G3rlSkRnCqbBEWOuzZRjmhWdgArnbYk444cVJmJIIrRcc7xir6IeBxx55+jAodbQ48yonjpPhIKsoiiXsLWSop5nEeyWNe2kyQK9kBUB1namxpVt3AVBYm8FshZPJS3gctvXkRQ9lJwIrRUY3tR1/LlP0Phg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Thu, 3 Sep
 2020 16:21:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 16:21:50 +0000
Date:   Thu, 3 Sep 2020 13:21:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 13/13] RDMA/restrack: Drop valid restrack
 field as source of ambiguity
Message-ID: <20200903162148.GA1552408@nvidia.com>
References: <20200830101436.108487-1-leon@kernel.org>
 <20200830101436.108487-14-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200830101436.108487-14-leon@kernel.org>
X-ClientProxiedBy: MN2PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:c0::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:c0::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.9 via Frontend Transport; Thu, 3 Sep 2020 16:21:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDrzg-006cJJ-QL; Thu, 03 Sep 2020 13:21:48 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f3b2bec-44ba-456b-b7b0-08d850257616
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01065A2A09F3876D5F64CA00C22C0@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRV5YUpaMHuxSiGI/j5r3Aa3cKIEISEbVcaKNGXmq47aFaPxyCbhbFRTyjLr0h3Oht9D+mwMhenvtGBAkxoYAIrIgE9k7sC9bOhqppwnrzGRfm9QU1CzLfk6TdnCvPAxaKfKe5rrXLNV+8cRi+o1mraap+zmBmXah9gub7HIplh7ZhpHE7VmnLk1VfUiOxKsRrPjnFPFCe9eaEYV4qfIwl2LWVqNCH5xHTFflgHzCKLb1yBeQr8/Y5Doo+zuQJpDqWB7AO91joaCE9550RE8x4p90UjV7vkVHNMV7VoLZPSDtMY5kcPd5/BZNfBEP7gPLkg5zFSHHHo+Y2SbeL0iig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(66946007)(2616005)(4326008)(66556008)(1076003)(26005)(6916009)(66476007)(5660300002)(83380400001)(186003)(316002)(9786002)(478600001)(2906002)(9746002)(426003)(8936002)(36756003)(33656002)(54906003)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WX0CihlDe+78ChzbSbCNHZXMFycoBVPct9M2ZzyvTM1TyEfX53utF6DL/iewyRj8pGftaBIDMQtOFlBSaOTYrHuk6RCTR2UnkvNG/SUvyFQTDuoJakiveUtWQcSODSKtV6UK0ZToG8qlMykI8lB6NPHnipCEERigh36/eF1XRuR2t+HmZ5li7OSGzYjL0fnIDpmU49w7rIVXIOWjKWqOx8c8bwQPzt9ZjHqvrQ5gk5XjsetqRComjnpvS+HnWOcZ/gqjZDxNaYeh3AxAZK7fpt7wCSr2j1asByXPLgX+wTo6VJiLNcUbxS/uOmlITJM75BtI6RTwZQ0SOB8YnF1Z7RK4hXeeyKEiOGwGOp7Uw//kgMQB65Mdc7S5FR3kxHjKtMYTjnl+ENkYC3Jjj3qm4Sag+co0Qo5oCKDjGb3ZAxGK8jNtnsJf11P9NaAc/q/5bIsR5hK6k8307q7GtXo504stw+2XPcXFEdqJRFMpbimhk+PEtXJfO4zJ9NUFnJcAk5ag/4u7VmGn9SkGctoi1YbA2ha2BhX2npeshm8eogsFFEvnKzbJsLMFP6apbtNUuYxtonzAfKWv4MLmVgzIVgySguOYDsTmn892ifg3hPul1W83YC02/NaqY3WsqjHXZ8Y8v/xYvr2FlHfmlwVgDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3b2bec-44ba-456b-b7b0-08d850257616
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 16:21:50.5113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyQDgZDdfB5Bsb60BB8eJFUf0vZfPYwLeUt+v1NYx08FYaId02hLXHU5RppcEr4B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599150098; bh=IqyKhE77ALwlTmos/soluQCTtRFfDKxjCy5bl4GFEfg=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
        b=XdGrxL/56/TWpH7wRPcInYCBasl05T5u+2/TOQ/rWfIWjf8DWdqXru8lTuRhtOiJe
         6RQK3e1jXlnIfJG7psscKrnm6yZPKHs8HhHhQOvpBvNJTcE8tDP4Qfz1SuoaxQ/Dak
         gob5sWlHaOda5SrVIoJy4UDYdMdbe2aikrZ2pLxj2swopKo5piPI9cOr0ySYrqzB0h
         VUt53Y/B9ikk8KWeEXjSxegnEl382Rzg447as7nT+ucYOPaCCZqMg+N+T5Bfo6gxhR
         8JuWxM7BENQ1ELZ9bOU3eVhsmTHNuiGuHLPYBLCkRnZiIMMrlRJw6f9KFhXVjr3L8B
         q0lUp6gynduvw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 30, 2020 at 01:14:36PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The valid field was needed to distinguish between supported/not
> supported QPs, after the create_qp was changed to support all types,
> that field can be dropped and the code simplified a little bit.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/restrack.c | 29 ++++++++---------------------
>  include/rdma/restrack.h            |  9 ---------
>  2 files changed, 8 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> index 4caaa6312105..fb5345c8bd89 100644
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
>  
>  	if (res->no_track)
> @@ -261,10 +261,7 @@ int __must_check rdma_restrack_add(struct rdma_restrack_entry *res)
>  	}
>  
>  out:
> -	if (ret)
> -		return ret;
> -	res->valid = true;
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL(rdma_restrack_add);
>  
> @@ -323,25 +320,16 @@ EXPORT_SYMBOL(rdma_restrack_put);
>   */
>  void rdma_restrack_del(struct rdma_restrack_entry *res)
>  {
> +	struct ib_device *dev = res_to_dev(res);
>  	struct rdma_restrack_entry *old;
>  	struct rdma_restrack_root *rt;
> -	struct ib_device *dev;
>  
> -	if (!res->valid) {
> -		if (res->task) {
> -			put_task_struct(res->task);
> -			res->task = NULL;
> -		}
> -		return;
> -	}
> -
> -	if (res->no_track)
> +	WARN_ONCE(!dev && res->type != RDMA_RESTRACK_CM_ID,
> +		  "IB device should be set for restrack type %s",
> +		  type2str(res->type));
> +	if (res->no_track || IS_ERR_OR_NULL(dev))
>  		goto out;
>
> -	dev = res_to_dev(res);
> -	if (WARN_ON(!dev))
> -		return;
> -
>  	rt = &dev->res[res->type];
>  	old = xa_erase(&rt->xa, res->id);

How does this work without valid?

xa_alloc is called in rdma_restrack_add() and previously it was safe
to call res_track_del() on unadded things.

Now there are problems, like __ib_alloc_cq_user() does calls
restrack_del without doing restrack_ad()

> @@ -351,7 +339,6 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
>  	WARN_ON(old != res);

So this WARN_ON should trigger?

I don't think this can escape a bit that says that id is in the
xarray.

I'd say no_track is a flag to add to rdma_restrack_add(), not a bit in
the struct. The bit in the struct is 'valid' aka
'added_to_xarray'. The no_track flag simply doesn't set valid.

Jason
