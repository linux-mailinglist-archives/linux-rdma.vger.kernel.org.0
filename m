Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FD76DCDF5
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Apr 2023 01:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjDJXXQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 19:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJXXP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 19:23:15 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9477B1BC7
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 16:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH2SZYJVTFVB0fUuNwJa84IkCqkLOfkhD6eeJ+UaTwascUydkQACNVjK4sJzODFCG3wCrG+fsS/QQhXDeUD/ylq5H/rWJn4Gmg/d3UK/Wjb+XhGb9wMMIp32ufmhBIoR86gCKo2oboP/GcvCSAQQFr+G7UnWR4QNlpn5JTU3EpoeRu/FVSSOiU/FyC1QRY7uWkaKPjtyenBAf2C4uBjJDL8CHYEPsgf2Ey0gGMkm0uUUhS9ZXwNlUO7SgOE6o/1JK4frFKzN1kQPOqtf2TU1B0LfNDXc1Gi2L1CN1foBYz2KB9dj7VfiaCnVDOrgLj1CB2kIPfcl5xeCQrI9li/8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jarEyWFOR/QJaURwmdYwOiRJ090JLdxtIcr/FjPThn4=;
 b=YA3RsXZ1heIrjiIt32kfOGcW+j3YinIuk9Ai26iVXjWTQmmu6gopGqrmKLXltoeXZcDms7XlEQDGTgtyxMPz1n74MhR9KE7IXrBE67LDJtVdN4c7a3U2XQNGBfftBeFUIBSN3r+NSqdWsScNR0L5a4wt+N1irDgm1i0k51wOAV7eb+NDYQW0UY553UXSWncFo/x1PiXiDYssgU5h2xkEk/YDl1vopBw5686B6KGXARX6HIYc9K/64xVcjRosqPvkXozZph3X4zcrxWx4/Ci1xaHx7uU97MJCAbMIinhl6L1e630l/qbfzB9kmZaXDnj64pv0nvLvOM+HELTSqWuEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jarEyWFOR/QJaURwmdYwOiRJ090JLdxtIcr/FjPThn4=;
 b=r5UlmJujISl7x+DrzgaIQ3GkO7nqNyMiWybjTCmbM6F4spuk//SCjWbBl3Zk5Vk7gbFffqmzI25wimJSB2k2WpJEtGb9w4WNzhTwqcGTrrIzDw4aoGCFaeClVdZopaLaY7iKw1fOULoDSQdb6Nc4BlETXjcWioPinFsX9wUth0DtnT6lXthyPR6V1BlmGl7WzAYa7IWQwUuL5NO6B4AZqlP9g7OUwUQewG7WO6TKA1w87Op1cg1cZcy7sCLRMNs5Lrm384lPI58IcjFIWiwutO7IJ4yrk1wT6uqWyypA/AqsF6nI2hKOGa/Uj8a4vQxaue4q8i/wVVUx4N7RbWo9vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5132.namprd12.prod.outlook.com (2603:10b6:408:119::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 23:23:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Mon, 10 Apr 2023
 23:23:10 +0000
Date:   Mon, 10 Apr 2023 20:23:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/2] IB/core: Query IBoE link speed with a new
 driver API
Message-ID: <ZDSaXaFMFFde3agT@nvidia.com>
References: <cover.1681132096.git.leon@kernel.org>
 <67b6ea0621b22b77db4cd637a4f9b48a2f447898.1681132096.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b6ea0621b22b77db4cd637a4f9b48a2f447898.1681132096.git.leon@kernel.org>
X-ClientProxiedBy: MN2PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:208:c0::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b93b0c2-083b-4920-43a1-08db3a1a8c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSCe7MxFX6FhgJ99KtG6AxmkdZHNa+b+UqxkKoPuARvLkFLPs1hBCW8bG5TCiWUcl9CL6I5iaqeY1d4a8AjO8vCHQ/XB4JYclpxQN8IkJOxhqghUlrOBQ1NUeMTvCOjDIj2ucWT1ynH/GEf1CgFtqaYT6SEFK2SOAKA8grZZkKJVqN0MEXQm3gTbfu4z8eYsxSV/p2ASbi5Gs17T8o7xZzCUjIgi1BXMlf9xL6cxPyeSxV8hpk6ho12JC/AueYiuFy+gZ94hE02TxsT8s2u0lBhwPegVDTHvXDLQP2pr5ZGkIpf2DuQ42U8mo9buqFhBPgO1WuBhznPk+G8dqDlsck8m813XUxtIcVTPIkJUn4QsJoMEagbVaFfeXrkjSVtWPGCfxHrb5GQP9ILzKALtKP5u+NLVVHUIryr3u9YtdEuOBdN/JtjKQG6DrXFRboyOiL1RLbXAkZWZqJ1W5zsd24v6eM+F38Q+RrecTXHRWy1a6GhIxznVrbY8dZx2cuLQnSBzMsLDU3nWcq07Lw/C4ADC82UEucdPGvtadQUTjz0OZIpRbWi8kUW9Aa23kjOb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(6486002)(478600001)(66476007)(66556008)(8676002)(4326008)(66946007)(6916009)(41300700001)(316002)(86362001)(36756003)(83380400001)(2616005)(6512007)(6506007)(26005)(8936002)(2906002)(5660300002)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kmmywZFTkuAUR12bs1V1zr1N7NnPyg1G/03ev+7m8ewH4qiwAgysvIL2W4Bo?=
 =?us-ascii?Q?i1Zppfa3pzDbOq5iGZ7Zcw/1UfRu9qbfdFrDPptlcDYlHKXB6bv2qA5S3AbZ?=
 =?us-ascii?Q?apxKpLqqpWqdG9+2FyNIpNdrCotxcFaF5vOUS0ery1e/z2P3ZE4UAapnbtK1?=
 =?us-ascii?Q?FboNWg81htupmGQLaiYenEmXOIvDGn9eQIUXrOKBovNk8B4BA3HFnpwYpxKZ?=
 =?us-ascii?Q?gVrXAaplo++k0TkJBsMd57xF/WASUZz9y5iWVEw6X+uX85UigiZwj0gsf6bd?=
 =?us-ascii?Q?66RMVZtZcRa1ku356n8BDq/wM14zfgZ6WAt2hmsU8s8DhnbWkAFyanSYbA1s?=
 =?us-ascii?Q?D8DGcVyTUKmS6uwZVOZ0ZxWpe/HfZeXSLBjdjdD6fJ4kudHHhytM6VcEhR/N?=
 =?us-ascii?Q?mDld4Wl5GCFfuH403KLlBW5phhrpmnbGDXoY33poZadnSpvZOkGYHygfSIec?=
 =?us-ascii?Q?cXqKwQitWITmecpKnaHeyhFNt+dsvSXKEt0moySsSTB0bCA+jTQVYRfDc8Sr?=
 =?us-ascii?Q?RM+wCzHNvnFeyd5EuUVL1YbpkIzcLZp00DBtJD2IJC+/QYyYky2myfQ31d6S?=
 =?us-ascii?Q?2z3VjwQ+AsQZtNjvBUk7dosPtZM646OEXmMHSSf30sxoZ0S/ZeiaOr8niJHJ?=
 =?us-ascii?Q?qXtAhaVsBd6AgV0Bysb1Z+YzW05UMtfxCBalqBmOgTzpQdFj19GYKelxAxsV?=
 =?us-ascii?Q?eyVLDdHZgCZibHQ+9/zznnHXNal4cURkzbMsgP+/JKd/lomfATqShTiw8dnh?=
 =?us-ascii?Q?gFA5adv9ds2aZOTYyWNlHPgZbmlrpcw7oKo3cMAbWxnK8KL+/96gvkWsXZvv?=
 =?us-ascii?Q?P3pWOKW2OqVAiQWNDVxfb31aVWW9W7ccMQ2EgTlrJUsbXsb3I1evVd5QZdvB?=
 =?us-ascii?Q?La+owOksX2G+KmAEp2uQ0QChw1pS9zR70G1FmpACxDmc3OvyUe3QGh7gS0DC?=
 =?us-ascii?Q?q1wNN59WOci7nPZjIJfzsXZ4YIOlSXML3rWi0+c3w8EA3adaScbI2NFOGlat?=
 =?us-ascii?Q?1bECIZl5qnmpmtyLVUAbk2Ch1Au04pIwOkG3z5RV9jbApPdQjAB1UebUZG2Y?=
 =?us-ascii?Q?JjhXLrlwYOaOZTay12T1sJHCjv4rhUARbRMm8P/Uo3aZdQzS50wbeZ/pGpj1?=
 =?us-ascii?Q?a4gFrhHoe05zQtWD3vJ2jB5vcLB8dNUp6Jfq5YSnQ3+j0I0ucVpZLFfPBFkE?=
 =?us-ascii?Q?pqrnr2f3TctmqhVTOoQCE+Og1F4Q9WDMOkwE5CV+JeHhAGnjrYufAMB5H+x6?=
 =?us-ascii?Q?qKeY1dCZXlmtV8qkswevqF1g5bb5KWnZl2nR8gNsBrS4AtmTxumuI5YsUuCS?=
 =?us-ascii?Q?e2PRCnaeAvBz56VGMqIoHfjad9OQ/KjXtvAGOTdN9t0FDKSre58M1+40c84K?=
 =?us-ascii?Q?9dUFE/4fxOGeCEIugjzU3FedZvSo0RwagBUvYaREssZOAepORV0RaeWsWJy9?=
 =?us-ascii?Q?sWODr2OyGLc1YAkb0f9x9/meYd9YXN0QyIaIcqBI5LdBYaixzp+t35rIS98P?=
 =?us-ascii?Q?C8K+mrHRuuASYHcalbPnUQ8AdtokJSme6vwahyAIxQ6fbK3LYWB2ErEq2H/f?=
 =?us-ascii?Q?O1e6veXYtG/6SylE0fB9cWyrP1KH5FeGTZ5Nb8HV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b93b0c2-083b-4920-43a1-08db3a1a8c33
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 23:23:10.0150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cd95u8FolUD14KwkSSemJJ8vBM2Eh7Us1/AmbBW9QV3ve0TQHuO9E2eyMIKpJP80
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 10, 2023 at 04:12:06PM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> Currently the ethtool API is used to get IBoE link speed, which must be
> protected with the rtnl lock. This becomes a bottleneck when try to setup
> many rdma-cm connections at the same time, especially with multiple
> processes.
> 
> In order to avoid it, a new driver API is introduced to query the IBoE
> rate. It will be used firstly, and back to ethtool way if it fails.
> 
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/cma.c    |  6 ++++--
>  drivers/infiniband/core/device.c |  1 +
>  include/rdma/ib_addr.h           | 31 ++++++++++++++++++++-----------
>  include/rdma/ib_verbs.h          |  3 +++
>  4 files changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 9c7d26a7d243..ff706d2e39c6 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -3296,7 +3296,8 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
>  	route->path_rec->traffic_class = tos;
>  	route->path_rec->mtu = iboe_get_mtu(ndev->mtu);
>  	route->path_rec->rate_selector = IB_SA_EQ;
> -	route->path_rec->rate = iboe_get_rate(ndev);
> +	route->path_rec->rate = iboe_get_rate(ndev, id_priv->id.device,
> +					      id_priv->id.port_num);
>  	dev_put(ndev);
>  	route->path_rec->packet_life_time_selector = IB_SA_EQ;
>  	/* In case ACK timeout is set, use this value to calculate
> @@ -4962,7 +4963,8 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
>  	if (!ndev)
>  		return -ENODEV;
>  
> -	ib.rec.rate = iboe_get_rate(ndev);
> +	ib.rec.rate = iboe_get_rate(ndev, id_priv->id.device,
> +				    id_priv->id.port_num);
>  	ib.rec.hop_limit = 1;
>  	ib.rec.mtu = iboe_get_mtu(ndev->mtu);

What do we even use rate for in roce mode in the first place?

Jason
