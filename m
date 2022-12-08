Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1E16465CC
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 01:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLHAXG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 19:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLHAXF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 19:23:05 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1D788B41
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 16:23:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzKUHsvxCZLTDCuDqenJd2iBKXJ/AqTVJ8dUKY6kDJpKobzA7+d8LFehtYSBJ28mPPdy3FguGBYLNQbf8KVu4breUmOC9Kr0W/mxYdpKc1+h/6BCjGb7C6AVwW+yDoDFXUGGQYyJsd8MyctSTkF15wvMBnDFtWG9Ktdx8JESFSF79UhH60lzzH0DRFUKV3cmiIez8ned0nMHFgHptGQhEJIe6xv88dw6NkEYrOZSHx/yDqL5XOeS9L0quKTr8BFtB6Q2CYgrxbYjgNeG/Ui1cY0I+M0Y+sq83Wjalp9UTBZmS3CHB7DWPNnvzmpmAsIHR0cPjd97OvwhLqxrZQiZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvQMqOgVcnIlx/gSH2XBqvkDlK5PJ6qxhbq6FXiWiuw=;
 b=Bvat8uqFDtGXDORzBG33CyPPvuDUYzTtch+WzEMyyCqmvjzfC4pE1hYDHQXDViPECr7gn3OuwmfvK3/jhHqMf9EUFubblba86IS0O5C+udYchO8Td5JDh16igUErzGWQQHP6OlMHVE6QIQzlxSt65+imSGMdmYT/5PyaEP1fSQGc16nNbr022uWLW3ouRAfkvBVXTl7XP8OIOho6OTQgZ/ZcVA9UQCPZl5nmYIqlW/PFExsiJu20Aw1zPH1X9pQ0O2/HGRRdR3mOjwD8pbweGta4XA74FCqhX/IawysARrTbmpQeiLwyb/MQ/D+fib6RJnVwYAI8XK3lRAoRoGwE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvQMqOgVcnIlx/gSH2XBqvkDlK5PJ6qxhbq6FXiWiuw=;
 b=PsQr4HmlqrTSzaXJvH7vTK24TdbFJwvL2c/1N2sMZrSmepOA2SMEpT1qW0hvF/Z4RwLEKIlWGKEzlHvD0do161spxk7iXoZbZG8SEoQxO7GeJfwMuCPkCkdb0I4skqSJOdZkr0NM6b3RyAQ3RLClGbyDLraCieCwmkr9Sl85ZmijwdY09L6Gn4n+a1wl/CVukpK47CT7MEeZEB6SHy10UopDYG41lcsTnbDDzo9cSEykWEcsWDLQlOAVqnZzflAXFqgOgfhsVQyBgxIg/znltPFo3M/AAxFr8yiDxEtq8GfNcML9QDhZIFdapVLS441bU7vQQlgnuEwj5wkYFkv0Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Thu, 8 Dec 2022 00:22:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 00:22:59 +0000
Date:   Wed, 7 Dec 2022 20:22:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Guralnik <michaelgur@nvidia.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org, maorg@nvidia.com,
        Aharon Landau <aharonl@nvidia.com>
Subject: Re: [PATCH v2 rdma-next 2/6] RDMA/mlx5: Remove explicit ODP cache
 entry
Message-ID: <Y5EuYu5HK+CAFGtO@nvidia.com>
References: <20221207085752.82458-1-michaelgur@nvidia.com>
 <20221207085752.82458-3-michaelgur@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207085752.82458-3-michaelgur@nvidia.com>
X-ClientProxiedBy: MN2PR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:208:23b::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b4bdcf-85f2-40cf-4641-08dad8b25c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71yqKrJVbUom9eTBkD3M7qB1Thks8qs5IDfU27CVz93kLWsFv6D6lcnJz28xd4EHzmi2OGP5j/zeljZZAqLEUI0b8k3iE4KnWlh9fIhG8wF1wcUhXIU8Plt0bfv6K/CNriJ+12sDgMYEtzXzpvHAd0BjjG3luh8oyCR5V3n5hu4IQ514Sc9EaylW0MD36lHHz0JOzw4IXVxB2N6BPHHRnZyNX30ijBjbrjfPdJXbrPjbFRZIZgWexmPc6lL3jkWr7MXu6/EEIZSS+F0qjb6a2lsjncZwQoDRB4ULpsGM3ItsPurPTTOulsrjjq7L+1qJRHFr0J3nrxQqhJkEi+LaPbq8SHDXbm0UefIZFeoyOe6m7OJuCGVRWyOaB5p6GZnKlaH8VQbyfbPtdKIVIAmDwV9aMFHla/GAZ0/ekOAAMMYHFakwBsbs+3Ymd6nxl1aCXGPuHXJ79u8jY2j/xlpnbSdiPOg347hg3Ob98uNICOZirM9lMPoBSUZNGMgHsI3L10gVb4zuUv7ecT6ihkDt7Q3115t952dIoTT55eilHoq+6TsmdzyhLeM1uZ+ETpg4oaCRColKrwuTLwvaYK6SpslkTgyryLt7Zd5j++vj+2vO7jH0vaSAtQKwRuf/TuK1JQ/wuJNDmWycZvfcUUFQrTlc5IhU510k9KnTZ+HbyqbUWnh3fbRlwzVgKsKwEmGq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199015)(186003)(83380400001)(2616005)(86362001)(38100700002)(2906002)(8936002)(6862004)(5660300002)(478600001)(107886003)(26005)(6486002)(6506007)(6512007)(4326008)(66476007)(66946007)(66556008)(41300700001)(316002)(8676002)(37006003)(6636002)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cfAAxdBrBa8JfptTJNzBNecnBVIdwRUFqZR8iIq0XDuu4ypD34uCNBRVoI5/?=
 =?us-ascii?Q?oFqWZIPOOurcdsdsCiQL4gZh21Hllqn/Uo1hAeLzW2PTSzpaeKBFohtcKRxk?=
 =?us-ascii?Q?RSrgxuadBu1o0XbeBK3UZRM/jr6oYVF+g07N7DX4mKB6afR+RB3kaXVonKIT?=
 =?us-ascii?Q?NP0NCDSA+MM58PWMSt1V05gxG6laSgKrsxY6DKXInzM+KqrhOWyUk+15JBZr?=
 =?us-ascii?Q?ysi337CYyNNlitbVvIiZGE3XchJmQ5TRCxR3piQZJXmjq3AzyfkGMH49C1or?=
 =?us-ascii?Q?nf7iiIy7wxA7hWneMPmZC/gfsy15Te26tn8INnREuIdzMA5zlLlYqJfwe7TO?=
 =?us-ascii?Q?KJ7zGcKNuFSM+yk0udNjXnklwv63b7QP6ApBSxQNTtoJsCPkEJNhh3oU1CaJ?=
 =?us-ascii?Q?ZyPf+V2AmWwZpttFYaYLnvUJD5bddQB1x2mXjdtr2vJxSGHNg2w2R6mbH8Ea?=
 =?us-ascii?Q?9iFN4oVaxTmzCl4UdzF6JdCbDCnc2GddjNwuyGDoFCqT8rgrnVtNoERhDfwq?=
 =?us-ascii?Q?ORJtlrmEg/yPJt+RJGblYg+LxDp2iXQzJJb5d7IJfAz9CGShEjneFUPm/0F3?=
 =?us-ascii?Q?vmV2QcIrSv19+2jFexkbbB4Jhnfb6HwPxQGlhzy3h+t1efPxn8DYf1rsw8lG?=
 =?us-ascii?Q?GF92gujL7vuhfAMIhSj/vD4qvXTbuXvXjsvIJKerGUtWoPdvYi2ykCKVOcSD?=
 =?us-ascii?Q?CtZBhfv+Im08acN0LzPhjqrX4KeJX1BUQL66VbONg9C/aeq9SU7DOIe1xCim?=
 =?us-ascii?Q?3QDic/8+/RZ647pgoPt5waykady08Qk/ReeXuJqwg4YbcSH5Vqrlp3xm+FxI?=
 =?us-ascii?Q?AZvAjKdptypNojFg8u3bvDYx7uo964c8QJuOPOW8wjwWSXdVjTAv9anFU6mY?=
 =?us-ascii?Q?P5IN0cMZuj0DeNgx41MkvRmL1y8p6xamkjoSvfbZdtu3u3cSBxsEHtxMuIvD?=
 =?us-ascii?Q?h3kHVYKCyNEow+qHPCR5X79RalkLSZNJHDjgYymjeuwZs38w/2qRXPPXgvJC?=
 =?us-ascii?Q?+wPL2/r/bgyudoeOtly9qDJHCHHevWHQgENWPdZb9v03jhij2BluNTO2viN5?=
 =?us-ascii?Q?RJzE48USqJJ40a5dPsmbboCmaWG7ZMFLHDGKlkfca7mXY85SPzhbxvmq6pyp?=
 =?us-ascii?Q?UFsR/Q9NkW1ElyviqdCtM5+s9a8J7w+zKYGOuSJ0wh5WFbg7w0MqtfcHpDDb?=
 =?us-ascii?Q?ov78Wq9kD2+escvDyglfDTwI7S1klm58a03zqaXjGvYTyC//20pXhFmAJcPD?=
 =?us-ascii?Q?vBrvpK1f2LQv/iy4asphl0eIxmg8F10i9LCBxnOcFp/ZeeL5UGkZXRqNTv0i?=
 =?us-ascii?Q?AQ0W1zknox7SNggE6ePC8KN6tkASFPPUbmi4oGRpl+ElODQrSfFUX6wJ6M/3?=
 =?us-ascii?Q?7JHJH28GN7FM1JkgEN247j3AM2T6JNoOBbIfhYAieEus6d9pFRaJOKSTSZbp?=
 =?us-ascii?Q?+HBUk2hxehl9Btgo+Ekankte75MG0Rl3KOfeAftjcxX4ziR7qIL4MUEIuMX1?=
 =?us-ascii?Q?fX+qIR1fsWU386SpwbMzGeIv0xn7ENUD3OH2IqpoBMW4WStvrduiIxTnwEO9?=
 =?us-ascii?Q?X1jgKfyNnQBgg66GM/E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b4bdcf-85f2-40cf-4641-08dad8b25c49
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 00:22:59.1368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9+kdH2GRzlUynzL7iUh4eMM+XrGeNUhrN5Vqo7ngksHcQjenKCcvmqMCUX5uxdD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 07, 2022 at 10:57:48AM +0200, Michael Guralnik wrote:
> From: Aharon Landau <aharonl@nvidia.com>
> 
> Explicit ODP mkey doesn't have unique properties. There is no need to
> devote to it a special entry. Removing it.
> 
> Signed-off-by: Aharon Landau <aharonl@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/odp.c | 19 ++++---------------
>  include/linux/mlx5/driver.h      |  1 -
>  2 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
> index e9a29adef7dc..71b733fcac37 100644
> --- a/drivers/infiniband/hw/mlx5/odp.c
> +++ b/drivers/infiniband/hw/mlx5/odp.c
> @@ -406,6 +406,7 @@ static void mlx5_ib_page_fault_resume(struct mlx5_ib_dev *dev,
>  static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
>  						unsigned long idx)
>  {
> +	int order = order_base_2(MLX5_IMR_MTT_ENTRIES);

unsigned int

>  	struct mlx5_ib_dev *dev = mr_to_mdev(imr);
>  	struct ib_umem_odp *odp;
>  	struct mlx5_ib_mr *mr;
> @@ -418,7 +419,7 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
>  	if (IS_ERR(odp))
>  		return ERR_CAST(odp);
>  
> -	mr = mlx5_mr_cache_alloc(dev, &dev->cache.ent[MLX5_IMR_MTT_CACHE_ENTRY],
> +	mr = mlx5_mr_cache_alloc(dev, &dev->cache.ent[order],

Okay, I get it now, this is actually just order 18, so it is covered
by the existing order. You should clarify the commit message that it
is the same as the order 18 entry.

Also add a compile time assertion here:

static_assert(order < MKEY_CACHE_LAST_STD_ENTRY);

Jason
