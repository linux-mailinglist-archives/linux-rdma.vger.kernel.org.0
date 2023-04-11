Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8496DD93D
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Apr 2023 13:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDKLUp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Apr 2023 07:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDKLUo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Apr 2023 07:20:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFA2B4
        for <linux-rdma@vger.kernel.org>; Tue, 11 Apr 2023 04:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6SRdn3+9GMpBwUycnJ4+147vC6SaPP2AQXeUE5eqbxb/WTnxZf9iH8LzoFuIS/xKi4404TZoYO3Zr2M9XZOiuIk+vnNWqjVPYDJyQdjmeaXkydjUfWh0zAs+FoyZyMMyGwc6MBALIcluwHjuBUgf0wfqFz5Ekl+MkNBYT1+ZiCaElTFikfHRXHI3avMXGUK+KvitzSE7c5fyLr177yWgf42qRoB5ie5ery4iGvy3XfqqY19HG7BpEfEx7XsKklt0a0LKUnsssLKE0aiWrZbl9hpBUNMH4qww/lsjhAEVOKIQlL+BTwGRrRHSXM0qd4aaeT+YhAi0IKVQ6NjUilYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRVPctiMV+FlEvR2L6V1xnFTIYhYVzHiMRzW1VU3jWE=;
 b=YLtaM7LlrbvE2cD5EOJYW2KQcG6gMjPbe2sLOX7JWMvSBm76dRwdCnej8edgeJO84BhEILB4r3iT3WRZqleztk/n3QiS3DgZmynZ0XSZSENxtGCLLiOXg5t7VWh3v0eTYYl+lUl3nrtmr1Gza9qhHTzr4LMwcyMMpVtP4wyidq64b3pdS62cWzKhIdJYWwleJRBz2defUtUyTP0Xl+Sf6BZbEzfWkaKGPNwMCrU2pb1OJcaCto6R6Gh1nNTA4QQmKczQk8AnYtxVew1OApnjlIoeGvl7TQIFxCtdRRh7wGG0zVxi0mt6NxiuvtBIECyQYS8zeo4J7ISDYaoejm+Byg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRVPctiMV+FlEvR2L6V1xnFTIYhYVzHiMRzW1VU3jWE=;
 b=NRTX8OovdNgDMgsXq0CS2NwtmsCg//MIVlk8tcUE+vjhq3EocWPeAiUPh5/AiM5NnPg21teJGh2JJ+ky3sk2BdF2CayzRSJihWq2kdAxb1eETrU0zQY1HW1xrLgYtmGTYmjMDNn3SbOu1PgAaVCdRJz9klvB9Es0z+sphCKcQb6r/QwCA7dyp8Rm0Go/u8apU1zjDVp4x8lwQd+v0A7AZt0CG5qIJIGwH00k0l/VrgtZDdSsVkAIit5ukcYEVvG/28X+4H0Ds9IgBD8i6cxcUxOPUvc0YSqVfA2dR/2iSIQaQUP+S6EvjdsmBb+Q/Eo9LQlmHbz8Ym1yyqkfZC9asg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 11:20:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 11:20:40 +0000
Date:   Tue, 11 Apr 2023 08:20:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/2] IB/core: Query IBoE link speed with a new
 driver API
Message-ID: <ZDVCh34IIvv8PNCB@nvidia.com>
References: <cover.1681132096.git.leon@kernel.org>
 <67b6ea0621b22b77db4cd637a4f9b48a2f447898.1681132096.git.leon@kernel.org>
 <ZDSaXaFMFFde3agT@nvidia.com>
 <a7be2148-b17b-816e-b28b-1837ebcb11a1@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7be2148-b17b-816e-b28b-1837ebcb11a1@nvidia.com>
X-ClientProxiedBy: YT1PR01CA0073.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6c969d-65b1-4c57-821d-08db3a7ec84b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: we2ieby6Ow2+OKDbdPOXq2vKA6XS1oiKZDBT+nb2zvwWUBo7m36V1dqvscetHYyBu0M14CjClVDD6rzeO33pxpaMYejxRRy2UBjOfs8wAxQoqrxRs+tQwD1VJJku3qzYLtg74L46FMC6dwTVgy3g5E0RjiZ0K4nzv70MIbzzOoEnM5zRMXPbkjEnVAE4C0TQkbZ3gPCbPQcKcGATxM1hFkJbD0snCinqJhYC0B4Ca0GCzh0VhqsZ//Gy1NelORHtUkZyp/xys15smSjY1Y5/3i3Do0OSoOr//Sn+bXxcODdz4DD6D0ClGBa9SNBSAjc6XuvIIcsKhYMdZHYZMmTSoV2e2uGJcnB6W6X2zPGD+lYCRQgHxJNaiX2VxIl1uLehVqlzBiDdhihJvHQ4crsZKxPviRXEiqOOmURGjcgGC0IesJ8mddYjsgElkIm8B48qHtIaib9GS2b5hEVEv5vX/T+JMXz1lOCH8mgfh9h4ehMbI7Jyhzk1H8zFqEBi8G0lctFMLmkuLQvvUkSi2aiQDCYPbTfV8odmZ4/9/Jf25Q8wt+ooO2caOLcI3gystOCn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199021)(41300700001)(478600001)(86362001)(316002)(6636002)(66476007)(8676002)(66946007)(66556008)(4326008)(37006003)(6862004)(8936002)(6486002)(5660300002)(2616005)(186003)(36756003)(38100700002)(26005)(53546011)(6512007)(6506007)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dChYMJxur2hft32ksN1hdF1C98x3LkhqlouvenlhXjskut7gIup5tAE48iFR?=
 =?us-ascii?Q?hnVr6z7U35iyjOjqM4cFRbT+zZuTQVr4qLYIbIApnV1TAKpxI5+S5tNqGv/2?=
 =?us-ascii?Q?pyF7oXXPMtkX5ZSoNxaWJQ87zi5TkF4cW/AVBjeHy7HxOyU9IYURyhjBw0/0?=
 =?us-ascii?Q?5sb1vR5ySazxBk2TyStFkONoXuM1M+48KCVRthe8JQr5O1ZkyQ9CCbyXm2pd?=
 =?us-ascii?Q?ra/rw1F28xO2vd/hD+8bWoQbyY7sHu6Miy+mYsXrrrP6hI5kRtavDn07ojk1?=
 =?us-ascii?Q?+rZpNHUk6pC5tc5fZhoQfUHwHQ7saYUJTXHBxztkRuTpmEz6Z2qkgnJSd0V0?=
 =?us-ascii?Q?SOt1yXzT39bSKoxgYCr4Gf5zMZ7hTapwN9jL6PdUaw+i1ZwwA2Dgq7EXtxsn?=
 =?us-ascii?Q?HDyWGsmoY0+W7lkwtbWpU244mxuSiBTXNmont1kz3YpGPuVjcZc2CfiZzlWu?=
 =?us-ascii?Q?VN5OmGzBxK/VjlONacNvVOeEPJDvcFV1eGT2s+LZ/SytpohSpo0j9CRcl+TD?=
 =?us-ascii?Q?3mqMHVwMAJDxcy1VOg9V7UcFKcmJTShMKbQmbIXx83GCRbTkN05FFrbVWdq2?=
 =?us-ascii?Q?SMHjWgHJGzHlXxqIpPvgJi1u6jy501YwfHHMRCVTLyxNN2VtUI4A/T95y4V9?=
 =?us-ascii?Q?WFA/4Cq+ssqKNdVN8nfxcLUW4khJBZFdKToZg5UMYvnuEGorZw7AREWb7DHC?=
 =?us-ascii?Q?ZSvbYhaxWc49T3y7fiokOyiFmJwkAI4KhyjcGuU5RnXZvTszbivnlIJjUSE/?=
 =?us-ascii?Q?WE5/BkklOKnnh0ajsk4rWpFiHVyew95W6dPQsEsXppBQek/FN9Nv+P4868+u?=
 =?us-ascii?Q?ezmfJx/FPY71H/yRLBfjL1ulUKLzjYWgR/PFrKF3v5y1Votabken46BOVjH7?=
 =?us-ascii?Q?/6TMAij4l5gQY+9yadnyXagEtL7Ta+OJk48PLFzn5hO2WyIa5bxQCRM85KXF?=
 =?us-ascii?Q?DWpHdSW41AjOEZpLVLG/hu5QWQwJfAFMUyV1+50m2Q+eV7vV6aoQGH1EHatF?=
 =?us-ascii?Q?iPY+1eKvXY0MNBvcCr19SVLU2tr9iaIQQ1Rtu2Qb4TnW5eeOvBPuBLrxzP6F?=
 =?us-ascii?Q?m0SK0/ow6jGiyIuqh8tUMXJQHatFEQ+InIXfHsMZtVwOm6fxGV36vW8hh9td?=
 =?us-ascii?Q?Iy/EOLVRIKYcjoRcEX1F9ad1KLbhLZkA+T0VwjyzdpRs1XkEfJKdwab7x9V/?=
 =?us-ascii?Q?sfBtA3qaW3FLI1DXcQ3a/LEuD/2bCUE0c2cOFNZBW4ryBX9MQbiYnj/7bH1c?=
 =?us-ascii?Q?PYTp2JXq+e7cAXWyItLvFcRzbX/66hHSj2IXOijkdlLdFQRld2UK4MXs3pSp?=
 =?us-ascii?Q?1qv/K7WQq5NNGvFTeavt5l42EoD5EImYUDj7bLbzTfgJ0GULamFBgl44ARgC?=
 =?us-ascii?Q?LYIv0rCdvAMU1QCwj5nC6eiTSyKe09Ej4tSXENSUicrFTP8y9ut9MT5ngCmd?=
 =?us-ascii?Q?u8rdXRRXBH62hCIwXmkhbnXmmmVhrzaExZ6hIHHFBAcfD3xN+35qWu6lsZln?=
 =?us-ascii?Q?BnG+OG6zsfN7GhnAGH81u1j+xF8zSABoX1nVIYRJ1wC9aQ9Dywdx/AT025Rh?=
 =?us-ascii?Q?MjRH47Irx0FiLAmNLIe6S7M9v2Zm1o4aStJsO+tx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6c969d-65b1-4c57-821d-08db3a7ec84b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 11:20:40.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1GWNMrkRsG6wH8879aiJLHWUNQ+3RK7uFRkzXcGQ4Xxh8UIseVvr/wZHTBrRGJz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 11, 2023 at 07:42:37AM +0800, Mark Zhang wrote:
> On 4/11/2023 7:23 AM, Jason Gunthorpe wrote:
> > On Mon, Apr 10, 2023 at 04:12:06PM +0300, Leon Romanovsky wrote:
> > > From: Mark Zhang <markzhang@nvidia.com>
> > > 
> > > Currently the ethtool API is used to get IBoE link speed, which must be
> > > protected with the rtnl lock. This becomes a bottleneck when try to setup
> > > many rdma-cm connections at the same time, especially with multiple
> > > processes.
> > > 
> > > In order to avoid it, a new driver API is introduced to query the IBoE
> > > rate. It will be used firstly, and back to ethtool way if it fails.
> > > 
> > > Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >   drivers/infiniband/core/cma.c    |  6 ++++--
> > >   drivers/infiniband/core/device.c |  1 +
> > >   include/rdma/ib_addr.h           | 31 ++++++++++++++++++++-----------
> > >   include/rdma/ib_verbs.h          |  3 +++
> > >   4 files changed, 28 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > index 9c7d26a7d243..ff706d2e39c6 100644
> > > --- a/drivers/infiniband/core/cma.c
> > > +++ b/drivers/infiniband/core/cma.c
> > > @@ -3296,7 +3296,8 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
> > >   	route->path_rec->traffic_class = tos;
> > >   	route->path_rec->mtu = iboe_get_mtu(ndev->mtu);
> > >   	route->path_rec->rate_selector = IB_SA_EQ;
> > > -	route->path_rec->rate = iboe_get_rate(ndev);
> > > +	route->path_rec->rate = iboe_get_rate(ndev, id_priv->id.device,
> > > +					      id_priv->id.port_num);
> > >   	dev_put(ndev);
> > >   	route->path_rec->packet_life_time_selector = IB_SA_EQ;
> > >   	/* In case ACK timeout is set, use this value to calculate
> > > @@ -4962,7 +4963,8 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
> > >   	if (!ndev)
> > >   		return -ENODEV;
> > > -	ib.rec.rate = iboe_get_rate(ndev);
> > > +	ib.rec.rate = iboe_get_rate(ndev, id_priv->id.device,
> > > +				    id_priv->id.port_num);
> > >   	ib.rec.hop_limit = 1;
> > >   	ib.rec.mtu = iboe_get_mtu(ndev->mtu);
> > 
> > What do we even use rate for in roce mode in the first place?
> > 
> In mlx5 it is set to "address_path.stat_rate", but I believe we always set 0
> for roce actually. Not sure about other devices?

"rate" is to reduce the packet rate of connections, it should always
be 0 for roce, AFAIK.

Maybe we should look into making that the case instead of this?

Jason
