Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBBC37AFBE
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 21:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhEKT5d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 15:57:33 -0400
Received: from mail-mw2nam10on2087.outbound.protection.outlook.com ([40.107.94.87]:12513
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229925AbhEKT5c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 15:57:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm1ZI9XIi5MAqP/+6zW7WkODVrW3tfL+m8J1NFapDmPPFzA/KxHs7D3y364qAq7pKsiZMPMLjCH5tURkVSv4i7I/TACTzUldfwyTpl3ZcDThbMRkCs03/2OUwZvnQNmRxiofNzv6DDYPGgAd+Dh+LKW3m7fJHH9HFhv0i1ys3oY7OTBLskhYd4NWlG6ZiMwmknvtIEPJAI7Y5PNR7l9j+Vmu5peHSgHSwIin2d4urf9u0KxTuK52AyIluNzGqD1Nsws6ii7ZOrWg7qtCLXajQT+HM4Q9ahkmmv4TOA7SzSrSsRqQOFquywKfyh5x01dc8azTAh5K5rUCFqZnvfYq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh1ah84eahwdQ5DSH4nwv1LdN+0qXNMVu5nmMZ0XrhE=;
 b=QQn7sIohB+oEbBYaD/tMz16NMS3WOwTx12QPtbIVzkU8jTyk4Uf4/OsXZ3+FApwVaygTgMLuwXgWKOKyzstVNlfJ+zaZBWYO8OqvoJxPeMIA9dvNHU1AbA8deWxD7q8Lp6LFbUZZtP5E82+a++FDvqLQ7Q1HqTwcWhZpBOcI0G++vc1X4NozVO4HXj+La2kEXlWZkPlqcwbGU7iOUCaJ8DQQiaVOI5kwEzdwk00iMufXCjH2VDClRd17ObmrYU3Ekxi+6SmAqF8HmWza5DAk6Hvecdk1ivSQSiV0ZdUVv3KOiPsAsyI+yggugnyM5ifGnS70Dckn6lQ6l72umXNyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh1ah84eahwdQ5DSH4nwv1LdN+0qXNMVu5nmMZ0XrhE=;
 b=jyRPiI/rgcbKM0TENVjOBaTScGad4oQFQ3hgR0AWSS+XVgKeSJwr4ru4LBLsW63C01UOxtXq5CXDjvuXfNbebHn3eu7MUv7+wMNvVDSw95g388vH9D/WMRxsODUSlZX65Zafhyh7JSmvEI0s6nnFNl8r62ZKP0tLhBvP4/VGxEtWG8tjh+0INPMG+2CV4ydNpm8jWddv0A5TmX6oPGSAnkE45cgb/yeKJKNaW4HYysSPtcVQ7D0kq10RIjgWEd7qpg64+QgRjrffxE09bg0m5waxX4/hwoQSIEuIqUxOoRVUPa813mYNPrv76oxoIkBK/pzZ1VSFXjXmavqhKZFzxQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1660.namprd12.prod.outlook.com (2603:10b6:4:9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Tue, 11 May 2021 19:56:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 19:56:23 +0000
Date:   Tue, 11 May 2021 16:56:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/1] RDMA/cm: Delete two redundant condition branches
Message-ID: <20210511195621.GA1317703@nvidia.com>
References: <20210510090840.3474-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510090840.3474-1-thunder.leizhen@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0069.namprd13.prod.outlook.com (2603:10b6:208:2b8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend Transport; Tue, 11 May 2021 19:56:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgYUP-005Wpb-Kb; Tue, 11 May 2021 16:56:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8df2e45c-525a-4754-91d0-08d914b6da59
X-MS-TrafficTypeDiagnostic: DM5PR12MB1660:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1660DE0259EA8D0E841FCF57C2539@DM5PR12MB1660.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsjTTrCco18V3Q2Hu8FOWfP3ag8Bu7ZegjRX9bkqapL3OK4X5V+y2CW1hw/g4aCCzHZXqT9AxwSEuTUE8Gpmgf8DdIEmTrFCpxVAf5ejkQRy6ftJqbOPFiJXGfJPBEmXcNf+ioJFn71QliPEXBjNEUoM3qQcsXibKOXSIxa6CX2c+GR9+OVvVzFSVO9s4ZG3veVT3wpjez9qEMtFLh092VkXXuBUh+Gw8Aw4JubtS5iqO0mcFSfU5BguFrDCKWZvN1U97PFSw8lgZstjFrgsZGkr7GBVF7lsCaN6t6uOtppj26Y+sr+eN4NPeiz+TBGgdzT2ItwI2bjNrs37MEOSyq8hzxM5COvtjKnYlCegLAAFL6JaZZWXEyTLdvbyfj90qkXKJ3OGBOKjcmNKRIiQ5OgxeqMFCbYASEXMg6y5uEa3m1u6ndwFob0yFgryvOvo84vnd6cgIP8o5HPQcDlMXkccDYy27l6v/i6AG6CDnhwTsO+8afaIfLA1ssgVerUjPhtMI0YuEjop/HW8ArrdsLh0KA75iLZFEL15G8agdcBsgu1NN3FPH96gPjXPgUZdGMtjdtwObdHBJNDdmsmviRHEwGzEs/SQLx7Cl0IdtLBWj8NJ1+WvyhBpHneGzNmveJvYdHM+5OfGMy5GVZbA6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(186003)(54906003)(9786002)(36756003)(86362001)(5660300002)(33656002)(316002)(478600001)(9746002)(66556008)(2906002)(8936002)(6916009)(426003)(8676002)(38100700002)(66946007)(26005)(2616005)(4326008)(1076003)(83380400001)(66476007)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Js9iBMWDuwZsaObesdUi3TXeh4lJ7THnYp7IZJN8p3/krB3YflavJri5n5Cg?=
 =?us-ascii?Q?rmR8qk4y5lOmNIljQTiHX6LxrHKeruexDeQC4+I7UriRFs8fEgyLlOJBP8mj?=
 =?us-ascii?Q?tA2QpeXH6L7r+x1nhPiUPj5VhO6PI/6oZs8lC7I944qHBYMHVsGVZwtxBpIL?=
 =?us-ascii?Q?AQFaRsuKXJhtrNMBKNPBF0D1rMDix5vaXQ2U/02O538I8AZrJJXrh5nJ0uKu?=
 =?us-ascii?Q?Q3ZGhCb3pHLxY8JLxLm/ybHGvNAGrzLUvpVjsX5oPOf5Boj7+fFi53FWVHxc?=
 =?us-ascii?Q?wT2cR4SA/GlvdVCx2e/pHzC7TTI9lX2Th8c5fQooV8dDw9QrN58alV/Z+pfM?=
 =?us-ascii?Q?YktjWc6vHs9ro87HXNuOo7lEEGrYNPzXrRrvCmy6wqO8HWg+Gs2fc9I7uUEU?=
 =?us-ascii?Q?/gxfVm68WSvKUWUcIDo9/TEAYJgXGbkchCXnYgkzuaz0O0JmA85H0VAaY3Ir?=
 =?us-ascii?Q?skPLfEDBjvAU1t9xiu+N847B8QA0+xDSAhYfpxa/3m6OwDHZ4ehQBL+bORu3?=
 =?us-ascii?Q?oEo5zNExOgCca8h40CaOEvYzhVWpXJXcTtkih12aqlPAOWTYX04XPXRKcIsr?=
 =?us-ascii?Q?CEISYzGLY3fK4BJ2C1ClFkbK2QNx1+lmRZm6RfCckYZEv8iT95rdnhey+a+E?=
 =?us-ascii?Q?dttWvLA3FR801Q08Wa8tSrlsZWXgTrooF6brFAsSBOQgKWXyw3UlLpWo4ePg?=
 =?us-ascii?Q?qc/H1Bff844Bkflc4pb4SsJs1Ul6bED/XtJT4JqWuL6CQXlMaTQlYczBCpgj?=
 =?us-ascii?Q?/+ZgcAmtR+sffM5NosBFangKdiMhcGh6LB3goqKyQ2DUJmCZtRXrCZmI4CcZ?=
 =?us-ascii?Q?fF3pY56gb/Tk+7PUfvkSoH+B/KKqrmLQRLYK5n66rbx9Cd5pQ8W0yzzFkdDA?=
 =?us-ascii?Q?euF7JaDqLKNQ+QbLglZRIHCOXGtR4HXF1ESfDXaxHbOaEg+IavaeZ/VtWYE6?=
 =?us-ascii?Q?FssCtbwb+ocw36x1WV74hfyNQ3ojMKm9T1W9ChPtu5KMpn0HnodcW89fJknD?=
 =?us-ascii?Q?jYq0EVj5CEqX1pepBpkVArrDKMH3T2nElAErHQ0bbgDzmKZlG8Pl5DQj9Nqc?=
 =?us-ascii?Q?xmVpvKUpduO79Ac0d7j/ThQa87OL8AMrCXtndDm9X6rUvxDXfmLiM8pXcM4i?=
 =?us-ascii?Q?Yhq0dIZo9NLzqciESOb3Y88C7IxMPIzczJK82R2kpOIHO3YItQcxsrWL9gef?=
 =?us-ascii?Q?KFkos3llc2yrXlWz+zVplfhMCa9ObHr9XuVRqSY9Hfcs6G0Mb9IAPS/FEdXO?=
 =?us-ascii?Q?p8top7dICxoIuOnoP4JvcD6Od1ta+epZuUa64ZO+f/JWr1GjVXTy651m2AlK?=
 =?us-ascii?Q?6KeWL9ClfgoOmGHWs8a4B4Hx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df2e45c-525a-4754-91d0-08d914b6da59
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 19:56:23.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COt32YZoJWU0rYnXMbYV7k9S3iJiV9fsvBNRB2/j4nJW5bELQ98zPgOrCAML+RSw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1660
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 05:08:40PM +0800, Zhen Lei wrote:
> The statement of the last "if (xxx)" branch is the same as the "else"
> branch. Delete it to simplify code.
> 
> No functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/infiniband/core/cm.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index 0ead0d223154011..510beb25f5b8a0b 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -668,8 +668,6 @@ static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
>  			link = &(*link)->rb_right;
>  		else if (be64_lt(service_id, cur_cm_id_priv->id.service_id))
>  			link = &(*link)->rb_left;
> -		else if (be64_gt(service_id, cur_cm_id_priv->id.service_id))
> -			link = &(*link)->rb_right;
>  		else
>  			link = &(*link)->rb_right;
>  	}
> @@ -700,8 +698,6 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
>  			node = node->rb_right;
>  		else if (be64_lt(service_id, cm_id_priv->id.service_id))
>  			node = node->rb_left;
> -		else if (be64_gt(service_id, cm_id_priv->id.service_id))
> -			node = node->rb_right;
>  		else
>  			node = node->rb_right;
>  	}

I don't like this, if you want to reorganize this function then it
should be written in the normal pattern for this kind of comparision

 if (a < b)
   ..
 else if (a > b)
   ..
 else // a == b
   ..

You can see the a==b clause written explicitly above this if ladder:

		if ((cur_cm_id_priv->id.service_mask & service_id) ==
		    (service_mask & cur_cm_id_priv->id.service_id) &&
		    (cm_id_priv->id.device == cur_cm_id_priv->id.device)) {

Which is why the trailing else is just unexectuable code.

Jason
