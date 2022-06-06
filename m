Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545D553ECD6
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiFFRQk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 13:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiFFROx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 13:14:53 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1C017599
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 10:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMiTIVj8k3MzGy1CcJjmvsvsC3zvEaGnDBB5ZH4eMmHL52t9AAWGXu7pxPoOdQOw5dQn8VS3FHXXZ8yI2Ty42JyNY3fGf86j5Nigo9vI3kb+iEcvND7goTJqoTPRzXvYMS3kImKnqeRc1lUO8hGLn3xVgdC8cNq8JAk+PONHSLs/7KMDo/16lmYDcd+O5P3OkhyrLJjAbr3QPbbAFP5I7rBUyqSCKMENrsfcW9baDch5YmP0OT8inKZaZoTuHCp6qHh0ydZn58xk4y474HKkbei7BDQ87LHfvqS8dLwsHjAkglrSw4YHEjcK0ewkS0aoMAkW6tlz0X94jFGLW5EUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ck9v0P8XXk3pGBIAWhqG+sEVfdwIWc8PkNfNxbywvww=;
 b=YjqKkJ15K3R/2hJP4BUS1YycnKqgCn0pu+ftBRWP/1YpoXAlf+epJ4pWB+Z4g92ATs1B7pNNBDkFhubDPwX0uAv3jVGThEYxNoVrT26hyJ8nZD77/0TeWcOhV53u43vq0IBGhJ5eBh1SPcuBkd40y2HAo12OJmVl4aDxOGkZL0Xw4DVGlJn34E5D7sTGf26JTbAgcpKajEy5HaA9W44UvGQFWwVe/0TpTJiNZHV2DOnZxg9i5gBRJjv+khMol7Hb0NYHpQZCxAO+mk9OH1f9+J6g4Sw0vI4VACf8+QL07eCvqm3UHYaERMO0P0hjYKCYhZZyz+C2QoxoCi93bTFTig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ck9v0P8XXk3pGBIAWhqG+sEVfdwIWc8PkNfNxbywvww=;
 b=J3RKYP075sqfHpXnjV0FYUfL8Hr273x+FUo2C22fOx614dRgkSufrCTlMlmks0Q2au78HNNyGMxXLiNOAZmkv2anfHvBhF26fWniwHiEi2o5CY+RpiK6SbtLv6DOx04rssUml9me8/a8vX4wHyG5Uh06jaVsqaqpxcyjoCQRyg6cyi8oUw7WFD9r2rH2aQ+34EyFtJ5jB9ZSXRqdFoRuo0Q/oGMdBzsJV2rSQsad8tiU4KI+NJw+ZN2rcIbBpcMcwuZMglfvF8WpglCaV/LS9025FlR6m1w6uPLRTJPiw4EdSJWQ5WXIbb7o74TTfdPvu+uWnFK8gvl0fEgOWcNcdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB4629.namprd12.prod.outlook.com (2603:10b6:a03:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Mon, 6 Jun
 2022 17:07:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 17:07:29 +0000
Date:   Mon, 6 Jun 2022 14:07:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, frank.zago@hpe.com, jhack@hpe.com
Subject: Re: [PATCH for-next v15 2/2] RDMA/rxe: Convert read side locking to
 rcu
Message-ID: <20220606170728.GC1343366@nvidia.com>
References: <20220606141804.4040-1-rpearsonhpe@gmail.com>
 <20220606141804.4040-3-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606141804.4040-3-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAPR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:208:32d::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3960eff4-9800-47c8-24be-08da47df09d3
X-MS-TrafficTypeDiagnostic: BYAPR12MB4629:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4629B6D05065FDF96ECC5F73C2A29@BYAPR12MB4629.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cIXVqa6P8Z6o/17r/JXl8dqADX0RPw95nVyFqFfyHRtT1h5+EQNYxSebpjRZx2474vmaG8VMbwHvDE62bJAg+fIvqoxVDOvxGV1Vel6SW2tqMtkVyh5U0AcomMz82jt7PVnI9bsIQbAPxaR/dSEilkFS/MbR9WTioM0O1DKU1FX32UO2yq53uZt9v3cR0ywA6cM4AC23+4e52m9mPXZb82cTasU3ry2rjdgv7Hn+H3juZvTEq6+3Tc2T1qcrtzM5kTN9g+dTdlS/XEjBgQnX87rn3UVHA5KXn4+vCz7fun4gth4+aNJY+DAJ1DceqatzZfylCPdshaz6oE+6kPINkeRwYPlD8PJzITi7vaJNhGwgseqocONgdAcH5JoUSic8H1JNHWpQTI50pZBq/G0tf0P5Y5T1Mu9OjW0J0oH0XQNfyFCMjxPm6BFGWry0roC1D+gRd9ON8fIVToSsIt0Z5UbJ2sW4iGxNxDCKVMvD77NadyKqMyR0JOw+gD4OHnch3K2IR5CySyBuyIHNktVwvdsT+CYBgwLMf/ZfpyAU1iIAX/xVkGVLNK4Vjd9oR7CcleXx5F6elF/JqTB+No63VdHdFC3L6ziHJRFd5+OEso/RdKhWRyDeb3/PdgbEckk11QDhbUOPzFjLFaVh5q6X7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(2906002)(6512007)(26005)(86362001)(33656002)(508600001)(6486002)(316002)(38100700002)(6916009)(36756003)(66946007)(66556008)(66476007)(186003)(8936002)(83380400001)(2616005)(1076003)(8676002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d8+z500ymWvAp7KQebJyvQKp6bR4VBQHIOWUqI4ujtVfc9AJ8xStN+wivP2q?=
 =?us-ascii?Q?NGruAvUCw4MbowfNgE+P4kgMcmMdCn09uomShXo6xKNQbLSLOB9cHmoTSwmT?=
 =?us-ascii?Q?KZJ08zy0yudAiGG62PdPnQZVYrf3kDWyV+GA7x7MSrxmNkUK/thug7pMhdGY?=
 =?us-ascii?Q?3L7ur47v8aRBxI7z9lZU1t/au1a2EZxXBbBPRYJSTeRpWYIgW8NojX/z1DNX?=
 =?us-ascii?Q?jodw5iDv39hXCQFLGmsb8q05bEfIPUAlR5d7VQ21mGRXYMl7GUyerNSjVCZl?=
 =?us-ascii?Q?bImfnXskp8l6i7KMaDZ1L/5uvrdbrtAVcjg7byTnXd3PJZU1uwE5UDP9FFWT?=
 =?us-ascii?Q?dxtszOeaGNnO8bhBOX0k3dtINMh2Bkh59lPGJ3t97wCkim0/M7sW9FcK9Iba?=
 =?us-ascii?Q?u2nwzQ8Fa5CVIbSUQOkJlgwWolojU51TcFXjlsLx5t3fRNz2Sw0WzKRwphpl?=
 =?us-ascii?Q?fP7pi4Tu9YDiHvwrhetechOTKC6+liBwqPW8xhokthP52Ki5WbgkXk+nQo5P?=
 =?us-ascii?Q?Qc+3DE8kwRKI86VwTIPrp28OAQFnyjrS04dGnagD0Pj6YQH7V76x5axGRGOx?=
 =?us-ascii?Q?Atp0Zv61LIbRdRy8gWH4IuthSxAqen+mpg9V04MYaeYAlYLryY+3+nZK2oAz?=
 =?us-ascii?Q?H7oquakQHQtwtUhSL6w2mals1fDu8NrPs86lyBwSaccbNnBV7UjfEOdYsi1c?=
 =?us-ascii?Q?2L7WxG3qtNqLYYySRcTiBgJ+6A72Loe4QAQLv9liJ0vlfqALrK7e0Ud41lAo?=
 =?us-ascii?Q?5wOqq///+MKLpM4rAEdqtes6vs5I8JaqByynQRacZ9JGdZT9UCZepolHnENB?=
 =?us-ascii?Q?ziKRA2rRh0C7OoJKMXt1jHprKD853DYxe7Ue/R7Vn5kxPxciIhygFaJV1fM+?=
 =?us-ascii?Q?/NPO/h3fGU1Jtmv+r/IRrB6eSH4SfqeOQzHc3HTeaJlnx+Twwfga/zNf7bvy?=
 =?us-ascii?Q?vZCZgLeqgdbg2ZfocAt2LSPJVMmHmElbNqBPuL2TKV0mc6A7mliYbrdWruxQ?=
 =?us-ascii?Q?YsywWmPUTDEKtiFfoC64WW73err082vq0a7gRL0IU/r8EcpG3uPBoZ9EYat/?=
 =?us-ascii?Q?rEa1d2xKV07tDwDpJvVg090AhZU7fme0MxB89nm6PPvRA1uaGRbUKUYxAOij?=
 =?us-ascii?Q?eT/LcYqQ44zrX5sgKy1k1OiaLZbwbe8UYLNvCWXwzTBqsNTt+usUqLvRx8k3?=
 =?us-ascii?Q?jc2OhttcSMlXZXD7Wxw6ojM+ShOSBmyN6eh868U0iWj6o/q30xc03Xw9bmmh?=
 =?us-ascii?Q?Vbv4m66XIgX2s24Ttcz2fm0Z5msoPcyI6efjdIkcU65ETrQtivz7fjRHjkoI?=
 =?us-ascii?Q?6Ex6AMMLMkouTfjgwpKjdRviVGhcnKcjlpgVLLgLdU/9x45TpS6rn+g9K20c?=
 =?us-ascii?Q?qFicu4PeKxiQPHY8zJnrsQ82rJypqsMZNUFA2wxlAgIW+7z1AKNVY2tAnX8f?=
 =?us-ascii?Q?Ljw/bLvj5Ea/GlNWVo0A8i56hUwq4Ehh54HE5li5i3xpugurUmFhSy/Zo9DJ?=
 =?us-ascii?Q?3YHlfz9k1nIYj3/yjuhdWakE/146THMRDSkKBw5BmZXGh6ZGHmSSVbBNhEJy?=
 =?us-ascii?Q?EUNkD1OIhBCja91195LxxB2j+2qlwxW9OnPzE7vdjDvJI34117nK9SggOCgN?=
 =?us-ascii?Q?EDILYNBcOAAE5z8PV2EYYPvptSzJQtq1ClN8hlgNKXU7vtQO05S/iF9jBjoQ?=
 =?us-ascii?Q?P94NSHDgU7n3hKPlT1w9VuHV5h20w6YzHI1Qv+0z5cwxa8D+q0KbYIumY7CP?=
 =?us-ascii?Q?ARyE99YjhA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3960eff4-9800-47c8-24be-08da47df09d3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 17:07:29.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qsmonh5wz+HsI2VpTNQ2uIsK8NShQHh548z0193aOlVtf6/Xnz9pLwGpCkPs8gRy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4629
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 06, 2022 at 09:18:04AM -0500, Bob Pearson wrote:
> Use rcu_read_lock() for protecting read side operations in rxe_pool.c.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>  drivers/infiniband/sw/rxe/rxe_pool.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 7a5685f0713e..103bf0c03441 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -195,16 +195,15 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
>  {
>  	struct rxe_pool_elem *elem;
>  	struct xarray *xa = &pool->xa;
> -	unsigned long flags;
>  	void *obj;
>  
> -	xa_lock_irqsave(xa, flags);
> +	rcu_read_lock();
>  	elem = xa_load(xa, index);
>  	if (elem && kref_get_unless_zero(&elem->ref_cnt))
>  		obj = elem->obj;
>  	else
>  		obj = NULL;
> -	xa_unlock_irqrestore(xa, flags);
> +	rcu_read_unlock();
>  
>  	return obj;
>  }
> @@ -221,16 +220,15 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
>  	struct rxe_pool *pool = elem->pool;
>  	struct xarray *xa = &pool->xa;
>  	static int timeout = RXE_POOL_TIMEOUT;
> -	unsigned long flags;
>  	int ret, err = 0;
>  	void *xa_ret;
>  
> +	WARN_ON(!in_task());

I think this should just be

if (sleepable)
    might_sleep();


?

It all seems OK, any chance the AH bit can be split to its own patch
or is it all interconnected? It would be easier for rc this way.

Jason
