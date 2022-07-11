Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B62956D487
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jul 2022 08:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiGKGOF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jul 2022 02:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKGOE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jul 2022 02:14:04 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDAC13D31
        for <linux-rdma@vger.kernel.org>; Sun, 10 Jul 2022 23:14:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OflXelcQFQ8m/Jn1bPAETVYQfvfbhb9gxGxFNZariibUEzaU46JopwL6Wxl586pxDaoKjREm5looYLljYTyKapEgIvKoXD2B3jsoTSiQcdT/VtD0blHpnFKoOv9IoRLkuGU5td/TIYSgI33Qu8aX6l+9AhhzfhMzpBxS9MSu7VvhCuSHxq8r7Y7+nSDLPaG7Ccp0Lo+En8hN1jS/ouVS78k1hI/gBE5LRlw9swwfGFxKLwzJ7xSpOB70KMBAmVn/W62L4p7uB0yW6skFgCxw+bnDNGnPbNOYoFvlXctj5TMH3zOV7yI1pWxnx4aucRaDGjH06Tj1Ax5zWEcyz2UTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqDpvTiSJL2UX6f73g7CZtBod6KL4ZsY0smCz7NbxbI=;
 b=eOkrH8Ou4iUQDnFXq+XoDUg96vD9LzlfIvYVqGUhmqYU/3EfpFigwVFKK0JudLEhXTGUUgex4jX7Rq/BUlNLzM23nSWM5fZvv05HVeeLH00GgWqk4lUZEyZnJ1KFYKQWROTF3JPDfZlsmF5pKKNxQgh0i7v+vCZGiiLdX9lU2XWWeSZfpI4ZZNM7X155ZB0qBxTlby10ery2ftD99qWEJ2a+bG0dg0GZ7++/ydSR+79W1wl4uNrnSOO6wuHcGE0RxMVb2mUC5C4ppMX+p4iBr+vuBAEsbbD4IhylOk2vUx9oX+VwvY+KqJ5aDNUckFTzEhjC46Zqt1rfBzT6cgcp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqDpvTiSJL2UX6f73g7CZtBod6KL4ZsY0smCz7NbxbI=;
 b=BDrEhBpNPeHhEjem/bDZA+xAYNzsEhlwPrlj0NNkR2OxKrTbafUh8XvhFcpli6IgI1R5qFG6XFpBKH0h/yilT7T7HUl8uzYZ0V5VJnxflnPku+gxOuAlqKU6hArunBgtmrkGLIt0t0eYW9kNF+p3ug+A5L0DsV3BjFASCdYTpfNxzqjqxpEKUjKnmG6FDetdR22sG39RxhlHSzAAVnJTvHarOHLxUOx9XdALzrBzwRGe2CjRFWR6SatIMjMzKBb7WakmXtgf4x6tWpGdbSqFLaTlInTa+c0yGbqmg0gRfa6iHsl5YhYpsuwcyp0Fi7HRSorWbuDrKRAlcd1aIfIMFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3442.namprd12.prod.outlook.com (2603:10b6:408:43::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 06:14:02 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 06:14:02 +0000
Date:   Mon, 11 Jul 2022 03:13:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>
Subject: Re: [PATCH for-rc] RDMA/irdma: Fix sleep from invalid context BUG
Message-ID: <20220711061358.GB56430@nvidia.com>
References: <20220705230837.294-1-shiraz.saleem@intel.com>
 <20220705230837.294-2-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705230837.294-2-shiraz.saleem@intel.com>
X-ClientProxiedBy: LO4P123CA0654.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::12) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fd53e11-95fb-45ff-b4a5-08da63048d29
X-MS-TrafficTypeDiagnostic: BN8PR12MB3442:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xj7zmIVecl/TV+btY/l8SkAbe/UwKvIdcH8gwHi8v1QSCZVAfVTbmujLagqX5ftfoe0yfJ53M7xJIhgqfdI86pgaqy0/MO95CjdV1IkayV+YTGFtjGr0C0OaA1SFwcnrmiVPn+6R0gRwkiRo6PNwHGJl2LEnPtHZgqg+fO8gu8V0PfYJXfFN8ntI/2ZXjc5yf7aGHOyJa2aama3BsSw0Xr7YEReegoIzxslK7QDwCFTlWMSkC1CD8ZwKIpf3e/9mAK0KtyVjSRDm0RyMToiG7U+LZAE0SsTA/bXDtNM6WjKQtSp6LnDWzEMN0MvtMEFlE+OLlH7nk71ldcke8wh2KyELvCybxBKBQ3UvW3f88/Vrujk3oZQ8udjKlqRyrHj/x3g+o2MUcrgc9GV/cpNJVaHKpY/BITqvOWPC869kH7BN8NVvh2sMiTjBw/0/riG+9kZHZZB6LFRLosDpXi2+NJA4TRMTRGKCKiYUZYcfdnf22lh2bt2oE3/zs/a9Rcq7O3Fvp1TxCwgoVjPwVCPbDTvH2g9oiPYQKfDO0GdC5lfUU/6gxHd4IMAFuFYgiltKt7NkrWdBbHuTnzVHJS8FQrV5XOkcosdUbV0vkzsc9qPjHk0EKY0ZCn3l6eNPWvFiL1ozMycIUrW3CKstSFicrVdQVprvBFRAyRtmul6EJYeEpkwnITVbJzqZ724m3vhXq4f5wTYGF9wweEMPgwIzO88e+B5L62TWx4kWFRZlLTtClOSxVGmoOR6Mg7SldSzr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(36756003)(38100700002)(2906002)(316002)(33656002)(83380400001)(5660300002)(8936002)(8676002)(66946007)(186003)(66556008)(4326008)(66476007)(6512007)(1076003)(86362001)(6506007)(2616005)(6916009)(26005)(478600001)(41300700001)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kNnpzMI3lf7nsylnlFku9BACerazTFMOua9FJ+NUY50yqHhhU6z8SJrh4OxN?=
 =?us-ascii?Q?XL8j4un5c6NGcXiAsC+JIPQAtabpWAqFzZFwxhml6s2b6VJ56G8lAMMPkdBV?=
 =?us-ascii?Q?43og4cXYor/BDV8AUs00rdaqru6srRH9kZII1pvpw/bNUjKoyZC/zIUBBqcC?=
 =?us-ascii?Q?wlS8lb2nJakh+/FtLHtheNAiUMiqzGNkwsOelfJhVxSTCICIRuj5NXCzjH2u?=
 =?us-ascii?Q?8h0vhgSPZklYx4XalF/1Kxm2pz8dl55hNiETFB0q5FqJKpqsPW5M7MQif/1j?=
 =?us-ascii?Q?UEeOaKABFiKhinMQvBV7edcKWXk+xfrwYiz17vCOIA7tg9aUyTvC/6u/DBew?=
 =?us-ascii?Q?hB1hmZcKoevmbWEkBZz6AxOOaE0BrqwLUOQnoUZhMAGGuBAgJbRMdGm9v6UV?=
 =?us-ascii?Q?Unly02i64McxDB+gU96ESldsBxnpFfu12cgU8sE7yNXHetHpljvv2HXdrVz1?=
 =?us-ascii?Q?oiAZ9WNIEELHgSNVfqzsfTg8ByixqD8SPnndCV/azJc07/WR7/MMqQzEYf0J?=
 =?us-ascii?Q?PLt3tilcVxI9a+2CV+lO9rZjlgbJvvqe1PkKfunzGl6mPeuCPUm+7wejPis4?=
 =?us-ascii?Q?RUfHW9DLxvey2nqqxHrx1xvLFYx9e/adztfe3nYyVZv/tU6GerSSsomff8kG?=
 =?us-ascii?Q?iPFml4kV3spzyZf2ifvtTSY/MnPliFGaKmK2BzA/5DN9k4HfZe1TLqn7A2Ge?=
 =?us-ascii?Q?iqTU1N1EK2IH2TblAXFHU13Wjdjj6dyiNni1omnT0bjz+eCU1KPAxeiruciq?=
 =?us-ascii?Q?dDRNDx3nEHuD7TygLVvEaueRQIRIoiNJxX+y/6sJI6h0d4/IjJRnQU8O3/+r?=
 =?us-ascii?Q?rzHzdBrmM47XgHEHK2ww3H1dwz+dpcwIDkjD4qbSmOv8N73QNgajH3zHKiKB?=
 =?us-ascii?Q?HM8Far17Wz8CcZvlv8jJ5sh+Ys0W72eQkdokfNdy9bMvIcDNVBHmtP1mLy60?=
 =?us-ascii?Q?PhIC2rR6wjvI8bvDzjH6B1Z+cn2vp8tXYEEelpt0VFaIrK0poI0LlUEoRheb?=
 =?us-ascii?Q?5scrChP7nDyl383UYyHimwY9cSXruSQQIio3Kx0q/YmXhiSSNHiSn9pd7Suf?=
 =?us-ascii?Q?po3CGmXtoDQTe97+jRwAR8/Agv2IjdIiLTtAQ/TvJgblw5fOkw8pYRq+4UEp?=
 =?us-ascii?Q?0ACs0tIvZb6qQgqolQuG2wiV44TTULeQL6UJOyaWq5cZGU2q5YOvpOZ9CwzX?=
 =?us-ascii?Q?asFgArZz3GaBQExQ+ya41LeirG0Nkx9NsJZR1DeJbgA5y56hNi8YKbAIil75?=
 =?us-ascii?Q?eASA3PdqZ/BioT68ZGWnxP3Rtpz+cWfXY9p7Gzi9GN2OXJLXfa1PTRHMT1Pb?=
 =?us-ascii?Q?jDSRIgwHPwFsba2KhBjv/2USpCz8oxI7gOxqN1fHYLtpQH2UTy19sU5U9gfD?=
 =?us-ascii?Q?9CiEfowf8LcugVPzNge3X+/WluU0KT8h7+r/AobRpmfVbC7ab+XGgIyeE17w?=
 =?us-ascii?Q?TaouwJaq7P1pRgT7McWWIFk91TYZtq77w/UpC6b/4wTODDJahJB/5hWwcz2y?=
 =?us-ascii?Q?877j0Ih44h3HLrlLZf/5jRdnVnlHcj4dJLaiy+VNGILmd7GQhuJ1A29AGTpb?=
 =?us-ascii?Q?z2D6sbq7q0r3HceYv+1zANUBY/zcAVsqqXSNSCPH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd53e11-95fb-45ff-b4a5-08da63048d29
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 06:14:02.6622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p40lmT4VR0AepKiiMvWt4SSVEBrWlzwGUj9o6nY4f/W1POJ4dEbpfKYHBFqnyxlA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3442
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 05, 2022 at 06:08:37PM -0500, Shiraz Saleem wrote:
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Taking the qos_mutex to process RoCEv2 QP's on netdev events causes a
> kernel splat.
> 
> Fix this by removing the handling for RoCEv2 in
> irdma_cm_teardown_connections that uses the mutex. This handling is only
> needed for iWARP to avoid having connections established while the link
> is down or having connections remain functional after the IP address is
> removed.
> 
> BUG: sleeping function called from invalid context at kernel/locking/mutex.
> Call Trace:
> kernel: dump_stack+0x66/0x90
> kernel: ___might_sleep.cold.92+0x8d/0x9a
> kernel: mutex_lock+0x1c/0x40
> kernel: irdma_cm_teardown_connections+0x28e/0x4d0 [irdma]
> kernel: ? check_preempt_curr+0x7a/0x90
> kernel: ? select_idle_sibling+0x22/0x3c0
> kernel: ? select_task_rq_fair+0x94c/0xc90
> kernel: ? irdma_exec_cqp_cmd+0xc27/0x17c0 [irdma]
> kernel: ? __wake_up_common+0x7a/0x190
> kernel: irdma_if_notify+0x3cc/0x450 [irdma]
> kernel: ? sched_clock_cpu+0xc/0xb0
> kernel: irdma_inet6addr_event+0xc6/0x150 [irdma]
> 
> Fixes: 146b9756f14c ("RDMA/irdma: Add connection manager")
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/cm.c | 50 ----------------------------------------
>  1 file changed, 50 deletions(-)

Applied to for-rc, thanks

Jason
