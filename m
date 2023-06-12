Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A5C72C8D9
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 16:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjFLOmp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 10:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239386AbjFLOkb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 10:40:31 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616D293
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 07:40:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eG2zQujkw3eWlL7YjlCyYRcEsm0cwk7r6b8eWRxsqvf+z+4HHd7Bu2BcbITEH9Jc10md4Z8KJv/3Itqr9+uMjx+qOFEfDutz4ay4jEv1e9wBXU7jGR83qvC1ZULekcJKPiAUrtXg8S2PqdavAKKsA1Ep6zwPNMwsLMIiku8Pm/YOgXAV+5Epm2bCuQmC3DkACo7kUUxBzER/icMijTIpXD5VWgMFo/qBqwl4xlyzhyXdZciJSXP7zugTi4+bXX7CaC0Ebzv+iKu44eSYV7ZsHvNBZ8EXevurzJhqtcXFM8+oq4ChunqpRpS1kthjZ4g5yjjP8Nn+ByUMcLksMLezIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lpGm8hmDil2jjm6ejKRV+5NumebtofwvUfGoXiKhrA=;
 b=DzuQvhyLYIrWUplHOUxcHfrOcqPWviCHqwkG21jyaLps4rUpqEy5Y19Qwf+318X6/4cJoOsQ/G9luUvu8xb+yU6JdvrAD1kTHt9Tv7wHVip0eplPs8Rpv6+s8Cun/e2dMyENMnXLbDTTIwrxBRIzo+vAAVfRtF9UemJsmB7CzTciimLiLWLy9dviygrtSDzLvjmmHD3Aydmv1tpgjQOAAx3Xp4iEL6COcKE6rTdJE+FmbbfZxLkBF/EfUhG4PUNt5TXg35hqFnuQsW9lpUoMiq7apPtD9xqg4FRbRtDotUY+IDpPIESriGpb1VETwK52K+SR6fAH9Y2d7QEs47Znpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lpGm8hmDil2jjm6ejKRV+5NumebtofwvUfGoXiKhrA=;
 b=XTDI5lBRPiX0lm70UF2eRz3BV6tqMBC34MQ5vc8SPIocpHDknQP6eLw8fGbmicgdMljYiM2blmPmdMqz5fWr8z4/F6sk2pje6LIa7YIu+OmF2kLbZd35q8Z+usF5rnjw/RBH8KIeEgQmwyfTuRWyUsMfNoQfFBdcqwwyqYFHCAmdodydnmp+3RT7p5i5TRNnh3kxCK/gLhXxP1QGjIjBRqvcLhuGY1c0DQcgny3XcQ9uXXPEpaxSQQlLIVs2YIfqTO16eOtvxI49VS1RfOGXQwf3283lVXyjBHVB1pDbqaA++7wsyzmfmq4ucv2OtjGBzRZscigoIanzWtFekVlH9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Mon, 12 Jun
 2023 14:40:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 14:40:27 +0000
Date:   Mon, 12 Jun 2023 11:40:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever <cel@kernel.org>
Cc:     BMT@zurich.ibm.com, Chuck Lever <chuck.lever@oracle.com>,
        tom@talpey.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/cma: Handle ARPHRD_NONE devices for iWARP
Message-ID: <ZIcuWT/Ap0YnbsX1@nvidia.com>
References: <168625464167.6526.1226449785871036437.stgit@oracle-102.nfsv4bat.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168625464167.6526.1226449785871036437.stgit@oracle-102.nfsv4bat.org>
X-ClientProxiedBy: MN2PR20CA0040.namprd20.prod.outlook.com
 (2603:10b6:208:235::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: d0aff437-33f9-4e2e-6b42-08db6b52f67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ZinH8Oi+I6fl0anrmwB8X6kvd4B5paXSnWLPVFAb8xgfl4BZl6Ye+Yen9QpRy/RbQIzaJ/9jBBhbSyDND50cz10HN3cnl+nc/APJEgNppj6XJvgjqHMhyuUE8qmlLWYZTlbF4aiEQyMJUO/O/FzrIB2eUz8KA+cX3jF+9uz7+o26Frf4CnpOMk/FXmjZqK9Q5PO4ah1jw7VrCUAsVpduvayT8lt94sO8fADfXcerM49AX0ITy70eP7BukHLIDCqJK7lTTlWzXvBxuZofec6To7F/ZrQDD5c8TRBeFZ24duZukvBsg9Qri0L9Xh9UzIxeZaIDIHVvBPwYfs2Yn0O1orzA0U977ZAZPAMDMRgHUSwn50VFCGgbxTlGyvbh0pddRWSIxqquRnxW3OE76PZUgOp6A47kUhzDbQt9Rt2JBZVyAlYBRzILz79WhCF2lpx+Ucymrd0Al7KSFXC7lGe92FmGyQyN99Rf6rLEXg8PvLknpGdxJ5dYlZbSAkvrgBe8egT17N26+dxguaXzShU6eEma9B0h5IpUmWgtXycRgADCRgMAMfFj2USDO/24ye6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(5660300002)(83380400001)(2616005)(316002)(4326008)(66556008)(36756003)(66476007)(6916009)(38100700002)(66946007)(86362001)(6512007)(478600001)(6506007)(26005)(8936002)(8676002)(41300700001)(6486002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tFwWQO47KfjqNOtT6r1QBIutt9OmuryRC95E8HxzN27aGK8MNXiYw0RI6OgV?=
 =?us-ascii?Q?/D7WGuePItL9F9VFoTuqw/DF24P6WHNX57XrUhLgk3HRDpujMR+vXh/WPAmr?=
 =?us-ascii?Q?nb3KVCwrz5ito8MhU3Y/TQuO9j1EmUvtkIvXqYzNQasRLOj3uLuvyy7deWGl?=
 =?us-ascii?Q?8zOClon6P0iqcFFl6UB8xIVrrPtNsKiBehOVO/y9+MPP7EigVdho4RN/7hjT?=
 =?us-ascii?Q?qQmj1EH4CjOqqaX9f2mXCzm64li/JTJmCv8eullv+v7RjYU/q6FaUA1GHyJP?=
 =?us-ascii?Q?gXEjDauujXgzObCkYjBj26HhN+fbtjFXFFyfVKGAi54HMTFpTDgaUw9Ec4Yv?=
 =?us-ascii?Q?Su4eISzZmv3w8MDw70N7RxXaTgIucAN+Pidkd27mSGZ6qanMR0ML+Eaxk7KN?=
 =?us-ascii?Q?5MutIRxdWpXPCyMMrIDQ6JkcWDznBMKTalUQKUQN6QOLIiRbtvNVRYPZUOUE?=
 =?us-ascii?Q?euTm2piUY9CMr5Bdw7SSsOExDswOxihyNpFdAPrnGvW7GXrSDqwKt2trdNNr?=
 =?us-ascii?Q?PyIh6Xwv7UMV6UKaOsP1mJkw+XfqU7GNXJQqK8HAedifGzg6tLRGIJ2J2Vpv?=
 =?us-ascii?Q?ycfU3eYJbIur4CCqbxcsWfYt2qBJUUnM81dr1hNF9nl42eEE/2eOQKexB1VX?=
 =?us-ascii?Q?2/L/Kfd9XyJTnvZMh7Ow9YsFR6EJldxsBkKNpXRHnUcs7gjGtW/HM6Kla/fy?=
 =?us-ascii?Q?YqGIwxYIHTMiF7fIig8W7UGDHeuvYPIDPO0ZwvvNpW8J6fP3Dp3KL8MIfmEK?=
 =?us-ascii?Q?YXtW281DoABO1looh9e/7AeyoyKVkFFC68761DiAUs96vUjjeOC8Qt+clBa9?=
 =?us-ascii?Q?2Sy3+zHg5BiBOQXZvlgI+Txr9hSbjDRKLujvq+z8BxEJ+ngXSH+qMnaPP4JB?=
 =?us-ascii?Q?IR5jicGa/zj0ZC6JZsl5Va4yA6zGE39ShqaoRDdEb26uQ5UPTScywXfgVvwh?=
 =?us-ascii?Q?zLe1mrGtL9GQL46BaZa5ZS1xXjlp+g3Y24OzxkV2sxaofGzLah0B+yDjKxO0?=
 =?us-ascii?Q?y5/mr6Hs7yVvYpGd8YDXPkKczMTlutyYXvuYGzf3H9D+HtDh1f7+eFOjFYfT?=
 =?us-ascii?Q?FZaCtByNSzEifEMnLQd891is9k7vs8MHm9zbCBneI+/T5dGtWQd1vyB/vCjL?=
 =?us-ascii?Q?ckzhJTJwjCRrN4OuRLCDguI1Vr58gyDTRoilMnjW2xeVKwNRKTffiz5WnSrQ?=
 =?us-ascii?Q?URmK+XJeyIhtkqeuclzgn3Xcqv2vDQbHFWeEu/w5uOCQjXmeBMcEpoZxM65v?=
 =?us-ascii?Q?caqwYqubc3Wt7vXEDD+9AYb0T26j6WRlQ6AEyxZZX8BRC3JGvVShyaYF5QZY?=
 =?us-ascii?Q?cpBw6ENLAW4isQY8NKYM6QjbsE6xmaAuAQr5iCgqgwu2K5uEkSEk1ybaDmIm?=
 =?us-ascii?Q?6Um4lwKtAItZma3hbgotMjVpauRZz5a0jf1zs1o6ZJsVUO6TtW2RGwFNjoUy?=
 =?us-ascii?Q?UPw4jjLfN/VA8CUwHNp67VAvEQiYMllSuqMtZvRkKfucP1T541bEWud/1Vz/?=
 =?us-ascii?Q?0H1bwgWf9bWwycpjD8uHfnOQDyG0E1ttwHcqN4C8OBtl8YQ2hyNQzP3pFgqX?=
 =?us-ascii?Q?qex09T4mVd6D9P0BWHosf3K8LZcYfqEm0c7AzeeZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0aff437-33f9-4e2e-6b42-08db6b52f67d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 14:40:27.0993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWzA67+o2YNDGS/fQn+FeHibNX1M3G5JF8Xay3Rv/UVgXREZq9hHtauvaWMUshdU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 08, 2023 at 04:05:54PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> We would like to enable the use of siw on top of a VPN that is
> constructed and managed via a tun device. That hasn't worked up
> until now because ARPHRD_NONE devices (such as tun devices) have
> no GID for the RDMA/core to look up.
> 
> But it turns out that the egress device has already been picked for
> us -- no GID is necessary. addr_handler() just has to do the right
> thing with it.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  drivers/infiniband/core/cma.c |   27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> Further testing convinced me of the necessity of confirming that
> the ndev and ib_device are properly related. This version works
> on systems with multiple RDMA devices present.
> 
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 56e568fcd32b..44ef0539957a 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -686,30 +686,47 @@ cma_validate_port(struct ib_device *device, u32 port,
>  		  struct rdma_id_private *id_priv)
>  {
>  	struct rdma_dev_addr *dev_addr = &id_priv->id.route.addr.dev_addr;
> +	const struct ib_gid_attr *sgid_attr = ERR_PTR(-ENODEV);
>  	int bound_if_index = dev_addr->bound_dev_if;
> -	const struct ib_gid_attr *sgid_attr;
>  	int dev_type = dev_addr->dev_type;
>  	struct net_device *ndev = NULL;
>  
>  	if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
> -		return ERR_PTR(-ENODEV);
> +		goto out;
> +
> +	if (rdma_protocol_iwarp(device, port)) {
> +		struct ib_device *base_dev;
> +
> +		ndev = dev_get_by_index(dev_addr->net, bound_if_index);
> +		if (!ndev)
> +			goto out;
> +		base_dev = ib_device_get_by_netdev(ndev, RDMA_DRIVER_UNKNOWN);
> +		if (base_dev)
> +			ib_device_put(base_dev);
> +		dev_put(ndev);
> +
> +		if (device == base_dev)
> +			sgid_attr = rdma_get_gid_attr(device, port, 0);
> +		goto out;
> +	}

Oy, this is kind of ugly - did you look at having the iwarp side
properly set the ndev in the sgid_attrs instead?

Then you can just check the sgid_attrs->ndev->'net && bound_if_indx' == dev_addr

Jason
