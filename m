Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5D2782AAE
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 15:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjHUNjO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 09:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjHUNjN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 09:39:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDCFB1;
        Mon, 21 Aug 2023 06:39:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8yNoh1YKC6YXofQs2IdcppC4bRB4dbgDPvVvsTPRojBy7W3LK/tCWhgv689UBD6LG1tLwmVUXXM1GhMYvyoctrTLXdf1WOdp+8WGqsOu5KjZ2eH2A6Ne9FDrIhpLW0M8Bre3Yk35g5GKvMtpPTa3FDT7leLvosBSTxrHI+qkS39w6UyKSho+IKaBC6zsbR8h2MlGXOoyYVPDIHzPFts46Y66YCAt5Wk/ByfmvzHvzirCub5rK1PeuS9qGwxkcAw5HFmEE5GMqQzqPuSpkH3yg/O39Q0OqNbRBdRvRvOSd3XTln1oqH2jpxSEdJEA+ctTEC/QSssF1WZ7/lvwawfyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQx0UQ3eY5ucAggPOsYodfDn3dkfyzK7yh69niKV1qE=;
 b=HGZM/KfpoxHb536ROkQIRcOlZYBSifzTcmtDGElrY8JyxFMP13xYKvoY0w+gClt9QyudhKWnPAQEC0kLro/X2lXyWI43M7O29dQlH5OwqRhQOUfp73VSZfC5m50rROFStMENu3uXTR0MG0i5xEI9YFg+3qp4tpCeAYrbY351fCmie7eSDb3xbeA0kleydi/5tyZsnPTajC7qHJYxycrDzIri/ACQzvfB65R9rlNblZG4uBz/Gc968aMHiUl6MUBQe0NLWEGeihn2mjwDRbUDK+joC1kAWv4tFSgMdBdXfiGmXuXkTVXHu6CgT4FhtHIrKBrFv34BPsVFp2Kt3LYgKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQx0UQ3eY5ucAggPOsYodfDn3dkfyzK7yh69niKV1qE=;
 b=Li5h1P0bkBjZgz8zWi/j+YUCMjf5x3eZSopaQFbGF5mnoweFvItEMtGt7Yu01FPgIfJ6JT5y6oRACsVJ4pnU1OcW0w/lMF1RaxFam6jD+lOoaMQAeUhZwM6KLB1NIMv28lhxCIAOf7svaAtV9xDfP6bvkK2sj8VscMB86Q7Ca1IOkTbz/fhNicU571GmyNK26AlMEb5r2FbL+/iwec0rF0o1glLKU52/gjQ1KYQvbGC/EbkIrsqHdwQ0m+7hb/NdpiIqqTn7DS8zNopszaQMXmpp5gYiAw+WOQENNVqlBzL4JKvDTXOBPZCXwcRecxp6OctBX+Ln7bkaNjSGdv8X3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 13:39:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 13:39:09 +0000
Date:   Mon, 21 Aug 2023 10:39:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mark Bloch <mbloch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/mlx5: Get upper device only if device
 is lagged
Message-ID: <ZONo++BgYux82Wjo@nvidia.com>
References: <cover.1692168533.git.leon@kernel.org>
 <117b591f5e6e130aeccc871888084fb92fb43b5a.1692168533.git.leon@kernel.org>
 <ZN+dX1hkUbEIHid4@nvidia.com>
 <ZN+fdgo4givpj12R@nvidia.com>
 <20230820095926.GE1562474@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820095926.GE1562474@unreal>
X-ClientProxiedBy: MN2PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:208:239::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 42147b77-fa29-471f-a978-08dba24bff08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+f1q4CPQOxUr8v9UyAcNMSqqPxjFB8QLlORAFDizxuJVNxla0ieb1f7BACkhYQxZDjun8lb4mDWsKTk2rzG8TDQAqfwZuO70LxWRogvr2KaD4xgm0tQEatg8wSxDYx6zoB2LF9N4Qe0rpUT/DzzbzBBC1EagkxFwM53XEwGasHmkI36SxRjM+cCpPROihtwoB5xmBmgvcMPuo7q+CcxeQiSqC83D3JqCZnAqPpI+4bQCPOsDN6HtemOP8SI5bdjZbTvNSbf/laNvJahtNr+gtU3p/EE1oNQNIeINweiKcEuPkDLxbwwisMDkZggt9L9UpJ69RmSK7+4BniNvAud2Mng6+2efkrxonw6UUNFhVKegNSa1GWbquvtOaTM6jVn/JrH+8fRgAgbEnkZ5sVDpwTQ3Y9x9DUmDc2KpPfeHyoHvLAlqBJdqNQ4HPZ9bxcqmE7aFmFhtEW8C29qTBt15WwTZbq3gZbXGQhBfEwkI93vreG54UtJtFwhpIqw4iiAc8xZdiJ7gaeTHMkYYsYZADMAMtcAZEHsmrdsv/12TtWdv6bU9klWb5jmmtc0mMRl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(107886003)(4326008)(316002)(66946007)(6512007)(54906003)(6916009)(66556008)(66476007)(478600001)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MfDY55UO6kC/5RHkNTq3sh2qzOj9eqMbZe2EJFqsxyJBZJ307z1tw3WENtsA?=
 =?us-ascii?Q?dYzC5DTKN1a7ABAhmrfP9Ni+59cWcYPyLchozDFGykWsQ1Kra1h8XpzlhSXD?=
 =?us-ascii?Q?WNBItDsmVHBkiwNsPM4CWVMGs6Wouf1+0+q0bil9lWHM8bb0vMajO0Fj3DnW?=
 =?us-ascii?Q?5BsxjOVrSwPdwioU+C/Kxjvynj009NKZ0dyRUqlnT5aCc/sFtLCPl/Z0wlg5?=
 =?us-ascii?Q?lvOvRQ2DKl6gWKs/t/cPHLCH7gu3/Ymp+T/gkkNxOlAbiqPjGdvZtd8NfYSK?=
 =?us-ascii?Q?NX09rCDRFMUMk5jLaeyBKkNROewu1cPMQnortFB63PZOOOIvcSfleDuslpff?=
 =?us-ascii?Q?qeW7deg1yQWSoERmJlo6eT1fzYbyl/DXN/K4lavq+nLmgekqm3+v8ebFnw2J?=
 =?us-ascii?Q?iUwqtWopBDjX1C5YIUL1JeJJvguH1Wj4DQ1mcefNaSa+UTtN/YX1Q9qzEr32?=
 =?us-ascii?Q?238eF/Zj6r49kR0qwAoIAHYS1pTwx4URD3LF8TW6zn3vsnBJrZFZ7FHDZpnS?=
 =?us-ascii?Q?4u9Z0q89GMIy3QlosQfpH6GXA3fg24wnsgiFL8PqiXdQCuRyjNf0XHp3EcmN?=
 =?us-ascii?Q?s8BsN78uKL6OcHiQKszA4usXk8T8Z4bNk71X1hFlH6+a3LiTwcvRejvrPgUb?=
 =?us-ascii?Q?6a6IGO4y9hGUVOuZc0LPsmcrac7/dLuqxZaNUjY/egDS9xgS61LVVNA4wIZf?=
 =?us-ascii?Q?PUfuhaJMPFKP9GGOMDMh0j99hUFx8cVEiSzWJi1m+1qCtYi2y4m8NUuJh5nX?=
 =?us-ascii?Q?kjewnY41gTpUP9QRd1zNehz4lWFYpQG3lFBECZvP47uCLuGYT+XKL18/xvGM?=
 =?us-ascii?Q?jMTt4gVq3QV6316wsBG9NorH8YLECfMjc7Ihvl0sVosqv9VZKMBczYvXmJF8?=
 =?us-ascii?Q?fGwIdyggfeBF5F9M6iY0k79M6WFpsINs4YYXm239FCpq797b58e7uZzRdEvi?=
 =?us-ascii?Q?ZcFvqe/rnLAhMdBY1v2iaviNKEx5n8/4W4oF3MWp+maqHkf6pio8fj+jCyZk?=
 =?us-ascii?Q?jCpDpYRCZLopKErm8BtRDqKn46Pexhg/fz9TpLEdUJ0yUQcn1QhlHZ5IoIb4?=
 =?us-ascii?Q?LO9asc1aOteQycfoo3XgBqR/sl8JZ4mC8RkYtGP2ki4BUaCQstf/20DKSNeB?=
 =?us-ascii?Q?V+hc+oI8Fd1bir5QGOlNJgtCb8ML6fwVdtz2Unv4ecTIo5ieINyGa+Q2jll3?=
 =?us-ascii?Q?AXnd0jjAxtp3Jml8kjoIidusEd1CFZev6hv/xckXb2x5fcEUEYV+fA8NSrOu?=
 =?us-ascii?Q?8np6hS2WvXhZFcew+P17YFVgYN6j0EtRM3twuYWz/CywTvwnEN/MV4njOqFk?=
 =?us-ascii?Q?qjXu47adDk+FNT2TFHHOEVNgJUQGimWwBlTLbpxCmno82G1bxhFUi7jLkFSV?=
 =?us-ascii?Q?mT45JWspAMpjp5ZNEOUlaIpJfB4UtAdX3jeNqQ5XWwVFNlsT/5n99xgQylmh?=
 =?us-ascii?Q?XE9FMSc51rAJKp1vifjCYgCKNfmZOW94xdI0wOrvtUAEV024K0MRQ+IU0+6R?=
 =?us-ascii?Q?O4VSGVpZvwcni2qdN+cfHZ8ezTnqEzVXKoVaHrJPp6ULPrsKyCKL8QTn4JWQ?=
 =?us-ascii?Q?wI0zrjae/T+0Q2+iFcbPUNWvQ5S09ju+uNzHRYcm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42147b77-fa29-471f-a978-08dba24bff08
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 13:39:09.0041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4oIsBXm57r3Vjp6pY2dlcJQnLjpgavoppxVLYoSNFjJK7cjw5/M0CpaBRc9dCdm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 20, 2023 at 12:59:26PM +0300, Leon Romanovsky wrote:
> On Fri, Aug 18, 2023 at 01:42:30PM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 18, 2023 at 01:33:35PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 16, 2023 at 09:52:23AM +0300, Leon Romanovsky wrote:
> > > > From: Mark Bloch <mbloch@nvidia.com>
> > > > 
> > > > If the RDMA device isn't in LAG mode there is no need
> > > > to try to get the upper device.
> > > > 
> > > > Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > ---
> > > >  drivers/infiniband/hw/mlx5/main.c | 22 +++++++++++++++-------
> > > >  1 file changed, 15 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > > > index f0b394ed7452..215d7b0add8f 100644
> > > > --- a/drivers/infiniband/hw/mlx5/main.c
> > > > +++ b/drivers/infiniband/hw/mlx5/main.c
> > > > @@ -195,12 +195,18 @@ static int mlx5_netdev_event(struct notifier_block *this,
> > > >  	case NETDEV_CHANGE:
> > > >  	case NETDEV_UP:
> > > >  	case NETDEV_DOWN: {
> > > > -		struct net_device *lag_ndev = mlx5_lag_get_roce_netdev(mdev);
> > > >  		struct net_device *upper = NULL;
> > > >  
> > > > -		if (lag_ndev) {
> > > > -			upper = netdev_master_upper_dev_get(lag_ndev);
> > > > -			dev_put(lag_ndev);
> > > > +		if (ibdev->lag_active) {
> > > 
> > > Needs locking to read lag_active
> > 
> > Specifically the use of the bitfield looks messed up.. If lag_active
> > and some others were set only during probe it could be OK.
> 
> All fields except ib_active are static and set during probe.
> 
> > 
> > But mixing other stuff that is being written concurrently is not OK to
> > do like this. (eg ib_active via a mlx5 notifier)
> 
> What you are looking is the following change, did I get you right?
> 
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index 9d0c56b59ed2..ee73113717b2 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -1094,7 +1094,7 @@ struct mlx5_ib_dev {
>         /* serialize update of capability mask
>          */
>         struct mutex                    cap_mask_mutex;
> -       u8                              ib_active:1;
> +       bool                            ib_active;
>         u8                              is_rep:1;
>         u8                              lag_active:1;
>         u8                              wc_support:1;

That helps, but it still needs some kind of concurrency management for
ib_active

Jason
