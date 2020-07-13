Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E374121D549
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2020 13:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgGMLxe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jul 2020 07:53:34 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:50067 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgGMLxd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Jul 2020 07:53:33 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0c4b390000>; Mon, 13 Jul 2020 19:53:31 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 04:53:31 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 13 Jul 2020 04:53:31 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 11:53:21 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.51) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 13 Jul 2020 11:53:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bq9eLYa628PoZtacijg/ovurNHnV2KQv2cJtpor07Bta8avmN/HRN/xE8o94wv6/J6wq3GaiTLzmdvuRQLSt7nRxUkmUa3Ps5fyws6KHDownjlzM7c2jq7rWDvS9yrFfVFl5DUCZSsxg5qSj2GrXeL8BlTgh2/oWV/nCu1LWnPtP8uf0u2DBrb435RiUb8OZ+LyAlf4tkj2lVQf3KWVoE010ZTE3Hkf5OEgthHj9H9iXgk9vn5DxfToZ6Tx+nhAQdlfBbdgdNexUMpi5jWZhPboOet4ZVK3rnBRvRNo5LaZuBIzibjkbg5Mrn7azbkPEI31y33l+C/hTPCDBl2YViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4bUokQoCCuSv04XOMPC4vefV1My9jloTHXQ0QD8+tc=;
 b=bWLk+RARMplwUSpmbz7qxnrCt/ZhQEnCjfq7bvk1s4c4iELhRHtcbmYFRRypzazzYcvuk/utPbrmsI3Gs35cw8plRndV7JGnMbjIWtrwayAikQgPrZcfX+4RXQAd94ojmR9ky1jKDzus63zi8bBxdjhgQEVNTMgnZL1bq46iCG3cDsb+8V/G0ys2gH21gX+Fmd1oaC5Nihl4cdpQpNWS5lyZbl3ekpEcOCt4GSQ2h5jkj1l/dd/AJBsH4ZObxpticCbpFZT9HVYy/8ikoGmCBChTI62KHMugvMkqPOwGeKkwSyS34yycLQH6HqM5auNL53y8Yofg5oXO/EF6Zz0JIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Mon, 13 Jul
 2020 11:53:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 11:53:16 +0000
Date:   Mon, 13 Jul 2020 08:53:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Daria Velikovsky <daria@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Init dest_type when create flow
Message-ID: <20200713115313.GA2021234@nvidia.com>
References: <20200707110259.882276-1-leon@kernel.org>
 <20200710194644.GA2130282@nvidia.com> <20200712174016.GC7287@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200712174016.GC7287@unreal>
X-ClientProxiedBy: MN2PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:208:134::46) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0033.namprd16.prod.outlook.com (2603:10b6:208:134::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Mon, 13 Jul 2020 11:53:15 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jux1F-009fxZ-TP; Mon, 13 Jul 2020 08:53:13 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eb4167a-2a10-4c8b-e232-08d827235375
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-Microsoft-Antispam-PRVS: <DM5PR12MB11488C5C8F029A6A787C52F5C2600@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IswCqaFt+IB/5K+dxise7E1BcPzzTXQ32ZKe6a6VNptLvXhcqrmLSy2a2Gi91w5PweAUmRgixxFCDk8mCGi3P+/tBRyGJfFAEWwY9DofCwRO1dzHuOC+8TCUKD7qmXAFfyrGm/xrZDZRA1GkxRSP9nybXlevZhzvnvSAGslzn8QYxglf6Rm7fzdUbMCRjJq/wX85YUqsud6BV/HkImYfGpvlvW/8aKpaYfIES2Pi9Ewl71BjqxGel87tA6w166h/LfTWh1iHdrDdZ6L6RKyJhEj3jVV06EPhC1F0QUu7lRSBOdOsPLKTmdGcXziQDrf0ghap4ZX3UrE2DwyffdhU39QgJM2ONNlIeNcA7yiOWN0cVqBt+FKET0kOQp1uTP7Vps4Np981WTh+yvT2GipfKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(86362001)(83380400001)(26005)(5660300002)(186003)(6916009)(2616005)(2906002)(426003)(33656002)(66946007)(54906003)(478600001)(66476007)(8936002)(66556008)(8676002)(9786002)(1076003)(316002)(9746002)(966005)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: p/bUcweGDLuFJM0P8WxlIqcw7wIZ1mXd269gNf8RFXYpCY9OrhLSvWAX3jH58EDkXqZY4Un7Bwps9QKOllFBT/i8ZretaQd8V8XhsuarMSZ/ZBjDwrZWWyUzpcz3YbW9ZKwH3/UWfjquC9GYiKMSEqMSNlO+iGtcpgPg2qQKeOX4AziL7+GVz43rpAODNh6/C3zLhIye5Z8F/w3piMAcu+de5dMeYbsrX1bFlT63MvZZPe/YEb5GVpsrO23f2Z456R0KTxuQs7Gei/+1deQM/n8QJlcErNNZGWHab6VoXi3fJAxHwBCxa69BxE7S1gSlKwlZL7VyJlMbEXghc4dqc+IVtv/s7G8OgmzyeSJEA4PMPkJU+OFyAe+Ksn09scQ7HwN9Vd5zK/iBi2J1pa1TRWEQ9Fw6gpWUrr4VCI/Af57NnRepvaV4Zp0IKTwB4o8/KPrwcCVXn7uje+JTrQRBvwVWyT4QU24+z4nnQ8JSrHA=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb4167a-2a10-4c8b-e232-08d827235375
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 11:53:16.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWPIZo+D+U8MBCaBDL5AstrHawzhP4GvzH9xs3Ax5m6Wv1tw3k06wZSQEEcS+QdB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594641211; bh=c4bUokQoCCuSv04XOMPC4vefV1My9jloTHXQ0QD8+tc=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=jNRD2OmaN8WRkvE0cHdbN/gFOJvatHCme+9659sZVu03g4f5iZ9+ODbp7UZ3VlWzf
         kN/TVRfAuT3Kojo3740/jwYc0uGnyVjujwG955INV9XOKlh0Wozn5T8aolNZLcGuVv
         A8Yv8EVO1b0ODivkCbGXK7/kO7s9W5KGeeKOfbc98/TEJZ+R24Pl2Ycpd0sd865omw
         Nm3wEGkAufpTv/ifwXpOWc1ljstNuuucXKlcX8OhEHlkIIC14EaB8o189f7cfSBIjD
         HUyAy2DEo+0tTp1STHRN357svkZcMS3C3edqESTt9r/j9zdsLMb0yrHIM+1Ig/d4dZ
         E9wFf+OHr0f/g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 12, 2020 at 08:40:16PM +0300, Leon Romanovsky wrote:
> On Fri, Jul 10, 2020 at 04:46:44PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 07, 2020 at 02:02:59PM +0300, Leon Romanovsky wrote:
> > > From: Daria Velikovsky <daria@mellanox.com>
> > >
> > > When using action drop dest_type was never assigned to any value.
> > > Add initialization of dest_type to -1 since 0 is valid.
> > >
> > > Fixes: f29de9eee782 ("RDMA/mlx5: Add support for drop action in DV steering")
> > > Signed-off-by: Daria Velikovsky <daria@mellanox.com>
> > > Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >  Based on
> > > https://lore.kernel.org/lkml/20200702081809.423482-1-leon@kernel.org
> > >  drivers/infiniband/hw/mlx5/fs.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
> > > index 0d8abb7c3cdf..1a7e6226f11a 100644
> > > +++ b/drivers/infiniband/hw/mlx5/fs.c
> > > @@ -1903,7 +1903,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
> > >  	struct mlx5_flow_context flow_context = {.flow_tag =
> > >  		MLX5_FS_DEFAULT_FLOW_TAG};
> > >  	u32 *offset_attr, offset = 0, counter_id = 0;
> > > -	int dest_id, dest_type, inlen, len, ret, i;
> > > +	int dest_id, dest_type = -1, inlen, len, ret, i;
> >
> > I think this should be done inside get_dests() - it is pretty ugly to
> > have an function with an output pointer that is only filled sometimes
> > on success.
> 
> This was original patch which I rewrote because don't like the approach
> when function changes fields when it doesn't need to change. I prefer
> the current approach where caller has explicitly decided which default
> value he wants.

How is it a "default value" ? The function's job is to fill dest_type,
it should fill it correctly or fail

Jason
