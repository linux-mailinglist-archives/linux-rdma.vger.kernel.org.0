Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F3453ECD9
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiFFRQ7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 13:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiFFRQQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 13:16:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2212F14B2DD
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 10:10:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4hWDRIws7VQjXu1p8jfQYaqr2clK5YFuidn8hRkOGRHRaJfkGtYp18Zr+S5fEdnWpbyyrml611XUo/pxZ90/9YGnNUOfIRlAbYF7ofiB2WYipBvNBXsBtMfjSb2NbUa+wtrx0sReEuo5PF1kNZl/sf4KAD/xBI3xq9QwrS+5IGNYrXuBEmRZsFb10O2a7DUM20B9atJBdu3WUwg+3QQx3ht9RPiYBdimmh/g6gc/jH+6ibEUqm2OENcPELb2tyn1FIPBzQYcjWWcs8Ydbnyu+8JC3qvmvPgFyOqEzDYyKU5ZM4xuFngByt47YxF3HNMDGNEQuUT4IEckjaCmDHDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbmwqGYEyGVRXVl8sALq3Z4q5O7O2ZDjsGIizy/L0H8=;
 b=KvxDZC/djSW/g769gozxMu0jAP7Oc8WqOgIQ5ptwMmTiwCByMan7ZTvB1D7AEBQkRD7qVPlEiDMgYLQv4ZMmH9SlD5y39h/LlF7HiiXgabmSZrt5VNvpnpAAELGH+w2N+jUSrDjmrBOElEbyriETV3NdGQFDCSjYf9G5YZPG5QMy9JFvuqrmkpDmxE92Pa5tW3xQseECmR6G0oZVb3kQwEedTSygMSB1WsSum7n2DbLjh7fzyspRCV/qoePDE9cd7jK7HRPSnhy3TS1oYXowJ3iiaUnDr8a60RS0OddkkRflOlEhOmZuCEEpr5He4+SMTh3Cldoxp/t6R1/I024LLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbmwqGYEyGVRXVl8sALq3Z4q5O7O2ZDjsGIizy/L0H8=;
 b=gMDcto7h+ka8TSu4EDn7zLSwFCQwpNy6yD8opIGQLiljgALMYbDSLnh4xEt7hR1obJsahnwi2nEVFgYQZm4/Q89X2wzn2a+qX0VWheFK7uONTrdPrLBkHPpxgDGHjcNuA2g4Fcv7nVX4XPrV4ORSN+WBe2zgocvD/yWG3SX+2DZGhEPQxtEmbP8ulvcBvB1w/UsVEHRGAL5YYqCwOKbipaYdlOl1De01VAJhYhxZAmjhhSwDtUNYsVztps082+Z+F+cgYbaRWIdbxfnvGzxdnLK9tfE37LqaBdprFhubApICP0b+QA8Ln72MZhff/BM3Azzyxujo8wjYBaANMmjVYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3783.namprd12.prod.outlook.com (2603:10b6:610:2f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 17:10:23 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 17:10:23 +0000
Date:   Mon, 6 Jun 2022 14:10:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, frank.zago@hpe.com, jhack@hpe.com
Subject: Re: [PATCH for-next v15 1/2] RDMA/rxe: Stop lookup of partially
 built objects
Message-ID: <20220606171021.GD1343366@nvidia.com>
References: <20220606141804.4040-1-rpearsonhpe@gmail.com>
 <20220606141804.4040-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606141804.4040-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAPR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:208:329::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 403cb05a-706a-42f1-a093-08da47df7150
X-MS-TrafficTypeDiagnostic: CH2PR12MB3783:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3783E8741F67DDB853A6EF22C2A29@CH2PR12MB3783.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fk47yujuk/MmFjAFWDIPabNS6W0C7Xn8M2OYmmJtvN9M4+SyK+ZwvbcVx8+l8gSD8XqYTSwqbFsaXtQ51arVZ4dORYsHw4CELVurwNSBDmUqQttkNeAt5sFSJATTAjOhLGbFZhEU54Kq0o785BrBnNZeaTzSi8P9FsW/9Claiws4zWy7/sSMzoEqxFFtw1APi/PgHJ2f3vPcx8V8jibxIVYKstPxmVfJKmZqZgkcG59e9oEJRvg0EBtPmObcFwsigV1C+8h/sOoloHxlOSA2Hk8Ua7tAQf2qUMbBmlqL26rRuFnzdvoPU3vzUYVQ9RBdgr1XyUag3lNf8w736/IAUEhMCscZonMAeaUCZkUwhME2hwJL4Tg+bowo8kaodisf7Bjpis1xwvJIglSHsazitcDTr6CjiI8tkJ5Rkk3tijzRplOMrEWrUH4S0Wrsn3SoqiLK9MOExRUDi/rfUREdUFuWx0GJyGXdQF5fkRzkhLkLFqkNBULD5eD/9EtIfoblKi7Q+O072/F4LKwrkQXERMv4QZWt1PlGyT9MIewWmzwg7EaJybkZ6eZlN6Kz4PZiP8W3CIwOzZt9uoSqR62I8Q5xMqAgbTocCwNHuVS66Bn9PX/qNnNPJVSGIZ20BRRIuOwh+9MpVKEulncnt66Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(2616005)(8936002)(316002)(1076003)(6486002)(6916009)(26005)(6512007)(186003)(86362001)(6506007)(83380400001)(36756003)(66946007)(8676002)(66556008)(66476007)(38100700002)(4326008)(5660300002)(508600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sOtlSm/XOnSLb7ksirMVAraKahhQ8lvTaGLls5J2EMrxn08ZMmYXlntw61As?=
 =?us-ascii?Q?ZmMA1tTqSv/EYKDma/OhYdIrROZlb0w6BdqzpCwnV4ijL6GYmFeomcleEcFe?=
 =?us-ascii?Q?7jkQVXDh2qeVbjSFtUTw1ldfRUowlaydQVlhcDxw3vkq55UIeY5PucAXcDim?=
 =?us-ascii?Q?K2DeHwpKA0EeUEt2Rc3YBI1MPVck3j6Xm+xl04HspBM2qqCVbTireJxv2lVS?=
 =?us-ascii?Q?ix8QlXJWzINipZh5n9xXWqjZH16gW5Ts2zrnbkoWAm9cnIa4A4+z9fPKoNaC?=
 =?us-ascii?Q?NVOYYwpq1uJdIznCZH/mV0j4FuQw0rcbt6w36NVh2dbZeVMlWATvQtKM4tWN?=
 =?us-ascii?Q?TQiGpnOj4aZO6XhkVbZKjKEzyWV0oQ4lkas6B9DdQ65JVTLG+KtBG+ko+Dqy?=
 =?us-ascii?Q?ggIf3TewXeF1jeSn/ePqFPtExfZJB0FtFIfkzChhEsJR6XtXWRAW1qI8545c?=
 =?us-ascii?Q?IBgSL2R/aOQQZjwpsGoyNG6zIYuwvYVXL3yzTrghv8ByI5Raw7CxXXaFroGl?=
 =?us-ascii?Q?VJ+fwY/uYPXIXeHy1H+aAwOmxc5l+0L/mgMDsmT+ycASormgoIOdX5Q+Jz9l?=
 =?us-ascii?Q?3gBOgUlfb8wEY1jrKxonYwG6yNWDe6XBu0xn3RX6md0x6jdaYTzIEcuHoDDI?=
 =?us-ascii?Q?oM50p5tlDQgFQo3FfejXao6oio9o7C0qlp0wZBdtklVLl9rkHsrKnm8C6pa8?=
 =?us-ascii?Q?iFV7tIkuRUhFw6vL50YFjQJzpAIjfT15K/JJnfsOyLbHq7WB1LusO2dT1Ypn?=
 =?us-ascii?Q?XEAoNV1bI6pCisNqXgIwboPiksb3j8gtLwD2afJ5OMvD5FWK+5VbYUPFlvDb?=
 =?us-ascii?Q?PB0FcJlp9YW30hWfi8thPH8+YagjpqZPSMpcMMkzIwuNNdNP01+ZWFoACrrc?=
 =?us-ascii?Q?kU36AqHa3BGt4edO4e8cytPa2m/U5drS24mhdPaWCjXcWKtVtSKT78DhPFiE?=
 =?us-ascii?Q?sJVJhjoAYEsdAi4G6sSMW2ethZdMYkEuxN8PPLCHR6dr1PTidwHEgciUcXE7?=
 =?us-ascii?Q?OyPzTK81xkLZr00AR+bjLStIq3zAIoXFqbAaMLLbqobiFL3N0T9v58b2ZANV?=
 =?us-ascii?Q?yKVnotqgJY4dYZ74JtYgWDenweVKU9YldpPjh+smx2m8L0BtpKYHksW4lneD?=
 =?us-ascii?Q?XFvmlG5/ydekYTf07BPVeVt0cE3rYtIFEEsuyjok9WdTn7kog0aenCbfz3Lj?=
 =?us-ascii?Q?yPPEK28jMyL8pDKv2OiFEHWGoHt5Rw/PZHfXSRMcNrmNKwk3u3Go52DO0Pmt?=
 =?us-ascii?Q?ajwZcIgB/EB4AnWoYHdwzeJA8Olap1FFBN5yPXaHXdIR7ON0jYw8uX7ETkTm?=
 =?us-ascii?Q?JgPl1LmpXPKTQYKgvY95kMbAHpy4yWeWpX3tH1U1aT1t3qfc+inGA1ukiSBm?=
 =?us-ascii?Q?vtgKzRlwr00ZIxWTuIyyYXPcbgILPXLwULRYSS+ioOXspz15endxx8K6nfpI?=
 =?us-ascii?Q?JaJ4yuJOEbj3YYw6iWG2s9pezWnEy73TF+gkTyk3m9M7NDZhIUf64jPf6S6S?=
 =?us-ascii?Q?YICdAjJMs7JYJrP3Kd4ZBkYg7Y8LRfjp1+uSk14hJZ0iKDL4mn3szEbs2QJy?=
 =?us-ascii?Q?BGWzXvrSrqQ3We+u2io+A3rMEUWgCHmpUT8/bK7/vlrqKGVGTO/iykE6pqCn?=
 =?us-ascii?Q?z2LzEv9yRvyFRBLq3A7MYoLUDb6X0FXbPLDFrqztGkCJmrvlhWlCi7pfEGP1?=
 =?us-ascii?Q?FbC98i1iWESBxEwXaG3eVY1C82mQowtxaOg4eu71JfO3SDGJtf1cCZsn9MhP?=
 =?us-ascii?Q?S086dRDiPg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403cb05a-706a-42f1-a093-08da47df7150
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 17:10:23.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1IjS0gRgrxe13+KuMYGR8KCEWotlPhHPZsWp1Kz8FYF20EW3h1//nfZNaj9vThi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3783
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 06, 2022 at 09:18:03AM -0500, Bob Pearson wrote:
> @@ -164,9 +171,16 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>  	elem->pool = pool;
>  	elem->obj = (u8 *)elem - pool->elem_offset;
>  	kref_init(&elem->ref_cnt);
> +	init_completion(&elem->complete);
>  
> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> -			      &pool->next, GFP_KERNEL);
> +	/* AH objects are unique in that the create_ah verb
> +	 * can be called in atomic context. If the create_ah
> +	 * call is not sleepable use GFP_ATOMIC.
> +	 */
> +	gfp_flags = sleepable ? GFP_KERNEL : GFP_ATOMIC;

I would add a 'if (sleepable) might_sleep()' here too

> +	} else {
> +		unsigned long until = jiffies + timeout;
> +
> +		/* AH objects are unique in that the destroy_ah verb
> +		 * can be called in atomic context. This delay
> +		 * replaces the wait_for_completion call above
> +		 * when the destroy_ah call is not sleepable
> +		 */
> +		while (!completion_done(&elem->complete) &&
> +				time_before(jiffies, until))
> +			mdelay(1);

Is it even possible that a transient AH reference can exist?

> +/**
> + * rxe_wqe_is_fenced - check if next wqe is fenced
> + * @qp: the queue pair
> + * @wqe: the next wqe
> + *
> + * Returns: 1 if wqe needs to wait
> + *	    0 if wqe is ready to go
> + */
> +static int rxe_wqe_is_fenced(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
> +{
> +	/* Local invalidate fence (LIF) see IBA 10.6.5.1
> +	 * Requires ALL previous operations on the send queue
> +	 * are complete. Make mandatory for the rxe driver.
> +	 */
> +	if (wqe->wr.opcode == IB_WR_LOCAL_INV)
> +		return qp->req.wqe_index != queue_get_consumer(qp->sq.queue,
> +						QUEUE_TYPE_FROM_CLIENT);
> +
> +	/* Fence see IBA 10.8.3.3
> +	 * Requires that all previous read and atomic operations
> +	 * are complete.
> +	 */
> +	return (wqe->wr.send_flags & IB_SEND_FENCE) &&
> +		atomic_read(&qp->req.rd_atomic) != qp->attr.max_rd_atomic;
> +}

Does this belong in this patch?

Jason
