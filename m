Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7EE76A024
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjGaSPV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjGaSPT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:15:19 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB041996
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aO6hflZ7RTXhoTU5kExVsLlLW2R1mD6Q8G8MSfgtYrS+I2TzRiLaOepJHkBxQRcwAXjIOwabDnuOv3Q4oQCDw/A5zKvsI4/5nOsAaMnWlk1NPifgwxXW+k839UlJsoxYQyqVVpuDjDLZj4PPuTNreVp2LGCLdDfiIpISnYbTGa/IseNG6RCcjbJXh/lBiJRXOmEGPY7w1l/SaBR1hP2C9zvhB9n/GFX+cFCKgRIP7GFewBqAI5OP+dB2LlPozCXVjriio7kfD4tUNYfMxBbqymbRpaDWQN4NF/A+FhFfv1lloKm28fk6D927C0JpC/7QiEa8a7ZDbwZl/JwxQPMYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AxCGkM+tJijCb/BbjbfakJdBz2NcXVqeAioGm7hmzg=;
 b=TLPRblI9Aed0VQiTUCLrqby7FP+89ZEUuoPJCroc6L9BuKS0n4346izRPm36HcuINitTeVdrn1R45wRffwRP9wRLj5qh8sT228BYiHn/ZvnQ1gAtInHAJzQFdXOOzW2bD6mbiE1Kvo+PT2n6+/6COe+Wt+sJFmdnJ6uTfFULunJP/sGCCF6V679KoGOiocUJoVlqZatS//g0f5bZpn+YzS7zBqSmd4/SlUz9B/w0i7nwGUPXoOb6+AlFmAtzlZ+m3IjOOCTxomWf5ZeYzQqrHp62LfD02npQPOOMfUScKfACrbN8DeYccVkfYg8LxymWWY6yJ3hAFArYV0yBd9aMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AxCGkM+tJijCb/BbjbfakJdBz2NcXVqeAioGm7hmzg=;
 b=TDU1Gw2IFHnRtcPQpbFNH1hEFYSlFJNawMq0wg+dCDUoO2+Gy6CEXw3oEFp0G6JNh/2wIDJ1NAJePhed6vRpWcy6PxDOtyYxJWJJwPGBKM9lWiew4NjZeLgnZqBxz8GWQNNb89bi6LSQ1ddKi8p6jnwV1toXktnHGYiBoqrY2ijzK1aeDtOC7QjRpGX8+xyyyKDtVC4L/CwhfJxnIUT9pT3psWEGSPrBLjI0Z03lkLQvGYpCbhjsT+uw0w7y5+gUJKC0bCplPKhz+UR3UqWji4nR5qZY0XpX0TKqnsIni6sQ+mHxVIjKhHoTMGadYDUbe53TFVLAlfn7bUHtu9ahkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 18:15:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:15:11 +0000
Date:   Mon, 31 Jul 2023 15:15:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 7/9] RDMA/rxe: Add elem->valid field
Message-ID: <ZMf6Leyf17GevsdJ@nvidia.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-8-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721205021.5394-8-rpearsonhpe@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0163.namprd05.prod.outlook.com
 (2603:10b6:a03:339::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: e353174c-4a57-4d96-b0c9-08db91f2149d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1q0C4ayQI9l/1D7F8J1ZfIODRe8yrIQf4LIJWgYGfLgJ8zuY5W0JpE/BALiBz3D5ZXsXfMYl4aFfoNk11xl5YX5eYMn7vpz1uwxNelQl/wxohONnG2YGOU8eqMfQOhn3rDmaY0ZOzLiqVLZMHo412Y8CkspDv3tx7kvT0HJCXqrDs+3Rr+u8A3DTrxijDVEjCOroEqwrZf0WtzSrTepmhM8TdkLqncHu5xoVqZ3vStDK1xcZZm/tmXdVncZCvjKS6JF7jn5rMALlHwVI7hM7kJiMxYmIUORbPOWEVXxqTyIcrD5cLmcTwPD+Zr4m1fJamNQSz8CWKlkZTazEKDlVWxPnnL6uwBn21/ndC5naGKVQrsFQGXpC4gnFqoGCJnShBjXjgj+HOLur5HOD7A7lFVIhCVNd+HBzUPujYm56kDyoIVE4rj6zojMtmgGnqHUuXGJlZpIOAwI22r2Rqk9SZHRGb+WTYN2qHmx5W//09lpiN1F+zxoWfEnlphqlxV4aG86+UiY3IG7ffTZpuMXcJZ8UQzoWr5ySCJGl2Jxh04PmxJWn1apNbdxy55WK16b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(41300700001)(5660300002)(66946007)(6916009)(8676002)(8936002)(478600001)(316002)(66476007)(66556008)(2906002)(4744005)(4326008)(6486002)(6512007)(38100700002)(6506007)(26005)(186003)(83380400001)(36756003)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fC42ZMCOCOdExFHl+ZGIssQLg/seXvfxHxS9urvw/K+yJW4wVrkUjrRs3OYW?=
 =?us-ascii?Q?V+Hm2qTeNSZLJG/drIQVYCr9JxIP0PiYmAW+e4Dm/uzvgBAk5jubrE0IPywX?=
 =?us-ascii?Q?wdVUQGf4dW6+k/Z1+TT8ph3f0mZvCrQcW/Gr8shYA3izt7eiV1uXY+K0hMFg?=
 =?us-ascii?Q?JCxmp5Zl469ZF86gD0LaHJT0+/iXPYkA+hcu9T+sh0mWy2T1u8qH5EMAU7ND?=
 =?us-ascii?Q?V5g1mylOib/ccrAyaJ9sythBTNbVW64yjTFt2dcSifveiG5C0LCxCO2MN7Ev?=
 =?us-ascii?Q?651UO5u1zVWCbt78zctseCPqBy1eDw9lIRjIUPLQ79oYhNzRZxoytiLTvhXP?=
 =?us-ascii?Q?I7QkeyXy/YOciJnec8FUfxhdWNaipJS9h+unLViWn39rpP/qRZcPAAEZRW5G?=
 =?us-ascii?Q?grJIgLKhwRlN0gbAA6ts954VpDFVrjn9zaxppaAye4ZKgRzRk62dQKtwp94N?=
 =?us-ascii?Q?eYNWMDbzhaiegFEDqTKFMcQu6Hz3r7ORsB7I+Icw0lOCz2QpUaTvwSo2IYvY?=
 =?us-ascii?Q?yaiWgT36bym3xdSUYKUd1/pIXg4oTWkkjBAchUh3y/SBrnQA9mqaDZjkAzpS?=
 =?us-ascii?Q?dkv8o2c41c8TtAxnR9feBwQxwFD6fMlYsRs9JdRBP03rpgrJILFnOYcogwQN?=
 =?us-ascii?Q?5z2RiJzkFvjpxgg/ox3djzZlKvPim9XGPh+3m6CIOnTPFw3UZSzJaXMXyRhJ?=
 =?us-ascii?Q?7rBJFLC1A1nt+sxCBXDu2C5O47Q2phEKeDWWp4C1UOlkREAunPi0Wy8f2OVE?=
 =?us-ascii?Q?9f9gVBTvqjyeHFWdi/5pUsL662s3EGImn/4q0AbD6Jl/mrAoxSu4z/c0qkvs?=
 =?us-ascii?Q?jwTudhtatLG5JAFLdJFamIO7K0epFWjW2k4ShVR8NOu+D70Df3snYMoF64SD?=
 =?us-ascii?Q?mDko+124NEUuPJNaiLy1iIxWr7X8mRqsF9dxmwB1NCQjj1zmFGiSJISHRv4p?=
 =?us-ascii?Q?IgMTOJuzqD2TTUgVmsYK3wuJSPceG4Gz0TvivMDids2vRZpmd7l3apRojspr?=
 =?us-ascii?Q?oJpx/ptQuRacjboBNYGbWlDXo7IdrL8Hk8GNFWV0P9i8+3RCQP5gLwaFpTCt?=
 =?us-ascii?Q?TGM+piXIbg5YbKGnXTlvrpQx02/vibRAGRYq8cbvWBU3bAbuW/y+XQl7x0NF?=
 =?us-ascii?Q?TjY4honacnBlRkQI5/sGQRJd0Ca6Ea5w5Eq8+y1Zty4aOQr2hGNOCgCvmr11?=
 =?us-ascii?Q?6gvkFnknRCUVHZ3tY1io2CNYucAvAk3j7N8+ELXDxEGRV9DFrQwp9RpX84MC?=
 =?us-ascii?Q?Oa4rHB1yC847scBHX2WIjQA+4x7fRjyGuLPma5xe1O973wy6tI+kB6vzsUh8?=
 =?us-ascii?Q?H/eJ5QEmIZdg/CuZ9fL5fYIBXHNtv8/uAb4pR9JaH66j1dGQageQfusqD6hS?=
 =?us-ascii?Q?Xu/l864VGJL7AdcXzb9BVkSkUk9oCDSjhxRGPIUSJWgovfRjt5tbJoAQyaz1?=
 =?us-ascii?Q?vT5onWfLX+TC1SJC0mQo/R5nfMKKDsZTBooKUsjtp9lvvBCRr1Ke1k+of9+k?=
 =?us-ascii?Q?NSZMcDEODof01zfKkALPY1XukvNTWFaGTWZ5dIGIOFWSvjvoTrfgogmbqUd8?=
 =?us-ascii?Q?G87rmTqvGzw+yfSgiNC77O5aOc+P9QWyP7qjws+Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e353174c-4a57-4d96-b0c9-08db91f2149d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:15:11.8482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhESHD/RM07wtUEUAn6mZvec9d0jfoHTKUysbJIibMB25EVRwj4ZwPxCe6SAEJnx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 21, 2023 at 03:50:20PM -0500, Bob Pearson wrote:
> Currently the rxe driver stores NULL in the pool xarray to
> indicate that the pool element should not be looked up from its
> index. This prevents looping over pool elements during driver
> cleanup. This patch adds a new valid field to struct rxe_pool_elem
> as an alternative way to accomplish the same thing.

Wah? Why? Yuk.

> @@ -249,13 +252,6 @@ int __rxe_put(struct rxe_pool_elem *elem)
>  
>  void __rxe_finalize(struct rxe_pool_elem *elem, bool sleepable)
>  {
> -	gfp_t gfp_flags = sleepable ? GFP_KERNEL : GFP_ATOMIC;
> -	struct xarray *xa = &elem->pool->xa;
> -	unsigned long flags;
> -	void *xa_ret;
> -
> -	xa_lock_irqsave(xa, flags);
> -	xa_ret = __xa_store(xa, elem->index, elem, gfp_flags);
> -	xa_unlock_irqrestore(xa, flags);
> -	WARN_ON(xa_err(xa_ret));
> +	/* allow looking up element from index */
> +	smp_store_release(&elem->valid, 1);
>  }

That is horrible, why?

Jason
