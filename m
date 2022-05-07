Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DB651E305
	for <lists+linux-rdma@lfdr.de>; Sat,  7 May 2022 03:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445181AbiEGBdl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 May 2022 21:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiEGBdl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 May 2022 21:33:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2057.outbound.protection.outlook.com [40.107.95.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB8F70929
        for <linux-rdma@vger.kernel.org>; Fri,  6 May 2022 18:29:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLWp1TZvmGJ2qCMVxzjNGMm1Tjb8odawcy2wCkdhD5nR6LfCuNOWKhYK+YoS1WQyQ3O/zA9Q1RQNVfbfltrqaRLxt+ITTY8x5iWhjpKX6HQXAuSTdHzpdv4f9H/rMJVkeggVqRZUrsfFsaeXFDD1Qcd7CrxdcVddUsl2ZiOvNVJw+f5VAtUgC0A+aJIfZjF2cJMx2bhjRJQk7jj9c/Z/NCgr6waFVD1X5a8ffjogllLdob1dmKTEdZBwONSORlGdnJ2TI60PGcxTNatreKlL1vdR1YfsfcUAZilosA/eK3pDFzU4h/LGH12IDQGKZHVfiJp9FD3Rq3H51Ofu63ujSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBumQ9uThaz5AkEJlZnAxd1JG/0548KpGH1xj+u/m40=;
 b=EjYFksoCeLbnJJrduXUXhy52/JNplh85guZd7xfuUN64dLVUAsopjsfiinVPX8Wg4Q3mhn6V1xsezw7q07vdbp58CHLQrVntutJS8wXd3WZypXhazH2LjpRZ3KNcCj99OwOZjHci7WWZeDlgrGcjHxs+jb9qtrfFutTXZgQ7iNJi4yHMNtHmduqXRq5+Uz7PTpx9VnzOY08pu9Z2LQfbkldH8LWGyrt6yVX5r0vy+SQJBXoWnpvt+Kpm/JHWbcjJ2AQBmmrZMFARTKlSH56U61usWA16sINs9JDsMqtkxkAnNuIePMFNgN/miQa9rIuyEwSg2KygiKbypY3mo/1FQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBumQ9uThaz5AkEJlZnAxd1JG/0548KpGH1xj+u/m40=;
 b=On27+EDiglyEtBu07wm26ZCRp21bE7U/kEv8yjh/jlu9Wdf/YV118oQUqx/wonBWimAFRGjPAnHteUi/8laTaUZsHwycRQPEPwAEK16CcK599RYat/0Xepu27VMLLwW39Cz4FLa3O4jGulrw2w5UzXbA+9+Nm0n/PXWTdPKKqqRcKzj0Fn/pyXI+T6YZoCAhH4PG22PMP6HxH08TOCKfDbpe7VfEBL+WXs4zY5k+qp3qbXDE3/p/rRd5pYormmk4+6hTod5tCnWYo5Im3/OaDZxv/KdV9ExQDbnoGAT+4h+fOazQNkAkBpkS8CR7qVED3OyVP79A8HtDfGl9R7XPdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR12MB1747.namprd12.prod.outlook.com (2603:10b6:404:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Sat, 7 May
 2022 01:29:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.028; Sat, 7 May 2022
 01:29:53 +0000
Date:   Fri, 6 May 2022 22:29:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: Apparent regression in blktests since 5.18-rc1+
Message-ID: <20220507012952.GH49344@nvidia.com>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
 <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org>
 <4b0153c7-a8e9-98de-26ae-d421434a116d@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b0153c7-a8e9-98de-26ae-d421434a116d@linux.dev>
X-ClientProxiedBy: BLAPR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:208:32a::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebcdb19b-32c1-48fb-2edc-08da2fc91655
X-MS-TrafficTypeDiagnostic: BN6PR12MB1747:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB17477C109B48687209592322C2C49@BN6PR12MB1747.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZqKYIj4hON8VocBdcAkKFbhsy0vnkJQdTS+iZKs5B8IgjciG/jx5R8F0x7fL8D+KHfb7GkYteoHG4BE/zD8Dz0klB5ep1/YC/ya1vfKrv9tJHejTSsV6ypA0ROG7CZEhcRzm9KeNBqEgl1aV4a/o2YHkhOUE289dEKkahd4ArQQkrJVzFA1XZR22Szzj+UbMUivtHksHLVU0Oh26Y0KQm8BA/l4zvkHrnfow9X7L9sv3qSHl5UswKqDIdA1oE2asM7aOKOmixskgdmt8/W7yAVhrAZmUkOXh+Nj6bwEqf2Q20yhmdeB8Kdd5f8EKMWzHnN1Hh/BuDDr9fHz98e5yfFYCAk0xICDVfC/lBt5nx1A6PNdwCtDPD49hDlHvAOpPPgb6W8Ys6OgIpXow/N0R1EEz6WZyedG1Dt1oqHahYJtQ/pQoDeDFIrSCmXnDZ3RisYlwxVe2Gw6g0aZgXusphQ8+zY2AGbCUJ+fHMV0ztBKVKCjX0wJAUk5+qQvKmwok+2p1PRIC02dQceyxT2avfxwMyEktej8rRcUZGrq0gWJvRqqXWMLBwCTcO/Lg8Tq/0vDjOlHjqtiGxqR7iZsmS0lic4BoJI2vQGGPawz6E2lM3zpG5cPH4wZkokat97n87qv8W8/WMcoUmKg9Ox2xWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6486002)(5660300002)(8936002)(186003)(2906002)(33656002)(26005)(6506007)(6916009)(54906003)(508600001)(6512007)(2616005)(86362001)(83380400001)(1076003)(38100700002)(4326008)(36756003)(8676002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3BZS3E4VmNkaXZ3Q0JFeGUwd0VUakk2dTcyeG9UU3VXRTJHYkx1ODlBeFcz?=
 =?utf-8?B?NGRGYVo2NHNOVlNheTN5ZHN4VjRTRXA4aC9GcDlaV3AvSUhhQlZCWVFnOFR4?=
 =?utf-8?B?RXdFZStKaHJ6U0xRci9TL29DRVdJbi9aT1Q0WUpnV1FBWFZxQ1Q2RzFJaUYw?=
 =?utf-8?B?L3ovWVQ2ekdBNGwwZTNGaWpPSVp3MWJLZ21ZMVFFODVjTTBPbXNJSVJVTWgw?=
 =?utf-8?B?c1BHRng2d2RKWEZwVG5IUjExT3ZWY0h6TEU3ZDVOK243SU11ek12Q3paWEtO?=
 =?utf-8?B?SlNmeVlRcjBncnVreno2REU4bDVjc0hSZG5RdCt0eERremJHak5lMnlpWHJG?=
 =?utf-8?B?WnM5UldXVTBQQ2pjMnlXNE5vN25IdGVoMTVVRHFrdGY0R3gweStyM2FqMkxG?=
 =?utf-8?B?cXJtZTM2ZmQwWityTGV4UmE3OTJWdWtwUzM5ZC9lVCtlTG9FbUlWS0lEMlJh?=
 =?utf-8?B?Y0d6QzlWUFNyQU1jN3FQenZscHlzK0pNaFJQeU1MWEQrVG05Y0pkN0pYbTFx?=
 =?utf-8?B?Qk1VZSsvcmZPb0lsVGlWMEI3WUg5USs3QmpSQmphd3RtWTgzYWYrdXFUbUR0?=
 =?utf-8?B?bGNLL1dVQURaT0g3N2tNVUxVWnZlcmtLdUZXd2pUYU50cXBkaDJxRUsrSkcx?=
 =?utf-8?B?R0VQdWkwT0N5Rlh0UnNwQUFzckU5dU5LVWxmMC9XZUlXNm9zTXZVM3QwUXZr?=
 =?utf-8?B?M2YwNkp4ek16N1NWYTNmQVBYSFVGd2RTNnFGUVY5ZEQ4ZTZHeFVFeXpOblhU?=
 =?utf-8?B?MHZZckRiZGg0cklqKzlkc1RZenNEbDJyNTd4SXlPaHd3TTZScFJCV29GWjZk?=
 =?utf-8?B?eWJpQUllNU50bWkzeTJHdU44WHhVWVYwaUdiTEFtRyt4Q0ppYW40d1owb2h4?=
 =?utf-8?B?UWpTOWYxdmdjNnZFaFd5YXkzS3ZxS3Q0N2pqSXptRHVSd1ZjZkN6WEhIVWJ4?=
 =?utf-8?B?M2ZLQ1NOWWdUOXNNTXhFcFBrMTFDWWxaRVI2aEY0eERGeGRBaEpEdVBqSUpR?=
 =?utf-8?B?QVhRUy9zQzc0cFRrOVBHM3drSlRGOTZvdE9TVnppeG5nYWVuTEwzUUZjYWlV?=
 =?utf-8?B?elg4WlZYSFRLQmNNalZEUURWSC84d3QvYng1eWIxbFBpVVMva3ozUTd6bnRB?=
 =?utf-8?B?UjN6UTNPbExBa2ZhVVVKeitnNUV3bjBFVnpZTG15Mk0zRCtTOWlvd2EvOHJm?=
 =?utf-8?B?RThsTjZvZ1p3L2RMU0tKV0tkS1JkWTF1SVh2eXVENytwQis3UUJLekVWU2RC?=
 =?utf-8?B?RlhmbGoxa2F2a1hkVVF2Rk8vN3E0dzV5bjhHZEdvWlpnSmdneHZ4T2x4REtI?=
 =?utf-8?B?SVJGSkFYS2tHRllQOEIvaWhoMmIwMk1LcWpPQmp5ZWdrMHNkQ3pGQ0psN09x?=
 =?utf-8?B?cVBCY2dVTjVBSWt2ZExrV0pERHl0UzVRZkphcWtDanNnZ3ZneGs0QzhaeTNj?=
 =?utf-8?B?dGhuY05DeHAwVjlrR2o1bHVhQUZyTG5XL05TWC95RFhBL2VMVWE2TnlDY0Zy?=
 =?utf-8?B?Z3QyeFhnOEU1cVBqdHZoNTBSUS9QOHFJRGpIT3JoMi9pTFc5T2VYMXcwTWs1?=
 =?utf-8?B?T3NBeEhJZi9oNkVDODVrbGNnK1hwK2xWYjdnRWF4QlJuZUh0czhncngzVkwy?=
 =?utf-8?B?SnZ2elc1NkpGa0pPZmtyZnNPNWlqM2ljL25jTXJVUGQ3QnZrcmhDeVJlZ3ZX?=
 =?utf-8?B?aWh2S3I1bW1KaDJXV0tYbFZ0azkrRlBWTHBqWjVmUWQ2Zzh1SlZGWUNXZWMz?=
 =?utf-8?B?eDJSTzdtcnV6eG85MVc4SUR2ZlB0bGZFWGUya2tYUjJlS2U1akdlSEdZQVBV?=
 =?utf-8?B?R3J3Q3RWMkJwUTVkKzZhY2Qvb3B2VUV2TkVkL0Y3R3hVdVFPaFZYcVlUWlUv?=
 =?utf-8?B?Y2ZUS3E4Ti9vQVhvbnZVNVU2Q3lqcitoTmJaTkd5OTYyVGxJQVNoK2VWYmxl?=
 =?utf-8?B?LzYwVkJmcTdrSzAyNFBSeWpvVlVOQUpQNTR6bVRTY055ckZZOHRLaG9XeXFw?=
 =?utf-8?B?UVNWMVVsOEtUQmhOOWRSMkszRzI0d0NyL2luUEh6ZzlWZGcvYWVaTHhsbVVo?=
 =?utf-8?B?T29uT3BLWUdMM1RFaUFzYXBKbnhRanJOcGVWUm04ZVJtdmIwb3crejcrQy94?=
 =?utf-8?B?clpnSnNDRi9nU2hMbjBLQlhPbzN5emptMHR5dUM5ZlNyakV5UmE0eTFqeDNN?=
 =?utf-8?B?d0F6UGUwZHovL3E5OWkvOWNPUENWVUxoOVFiaDQ4TDI4Nzc5TTV5UGh4TXBU?=
 =?utf-8?B?SzUraENHV0RmTHg1RGVUOG5FSVZXL1A1VmlYNnNSU2gxM1lnSll0TXpVekF4?=
 =?utf-8?B?aERaUHlGa205dkd4V0JsM21yT3FwRW43Ti9Dbk4yZmZCZ3hndFNpdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcdb19b-32c1-48fb-2edc-08da2fc91655
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 01:29:53.7209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOOD+BJK/IPNfjTtFUGHPKF+xMH0s0z8m+g3Tw0loujngcpkYlWi9sqh3TZr7FRd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1747
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 07, 2022 at 08:29:31AM +0800, Yanjun Zhu wrote:

> > If I try to run the SRP test 002 with the soft-RoCE driver, the
> > following appears:
> > 
> > [  749.901966] ================================
> > [  749.903638] WARNING: inconsistent lock state
> > [  749.905376] 5.18.0-rc5-dbg+ #1 Not tainted
> > [  749.907039] --------------------------------
> > [  749.908699] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> > [  749.910646] ksoftirqd/5/40 [HC0[0]:SC1[1]:HE0:SE0] takes:
> > [  749.912499] ffff88818244d350 (&xa->xa_lock#14){+.?.}-{2:2}, at:
> > rxe_pool_get_index+0x73/0x170 [rdma_rxe]
> > [  749.914691] {SOFTIRQ-ON-W} state was registered at:
> > [  749.916648]   __lock_acquire+0x45b/0xce0
> > [  749.918599]   lock_acquire+0x18a/0x450
> > [  749.920480]   _raw_spin_lock+0x34/0x50
> > [  749.922580]   __rxe_add_to_pool+0xcc/0x140 [rdma_rxe]
> > [  749.924583]   rxe_alloc_pd+0x2d/0x40 [rdma_rxe]
> > [  749.926394]   __ib_alloc_pd+0xa3/0x270 [ib_core]
> > [  749.928579]   ib_mad_port_open+0x44a/0x790 [ib_core]
> > [  749.930640]   ib_mad_init_device+0x8e/0x110 [ib_core]
> > [  749.932495]   add_client_context+0x26a/0x330 [ib_core]
> > [  749.934302]   enable_device_and_get+0x169/0x2b0 [ib_core]
> > [  749.936217]   ib_register_device+0x26f/0x330 [ib_core]
> > [  749.938020]   rxe_register_device+0x1b4/0x1d0 [rdma_rxe]
> > [  749.939794]   rxe_add+0x8c/0xc0 [rdma_rxe]
> > [  749.941552]   rxe_net_add+0x5b/0x90 [rdma_rxe]
> > [  749.943356]   rxe_newlink+0x71/0x80 [rdma_rxe]
> > [  749.945182]   nldev_newlink+0x21e/0x370 [ib_core]
> > [  749.946917]   rdma_nl_rcv_msg+0x200/0x410 [ib_core]
> > [  749.948657]   rdma_nl_rcv+0x140/0x220 [ib_core]
> > [  749.950373]   netlink_unicast+0x307/0x460
> > [  749.952063]   netlink_sendmsg+0x422/0x750
> > [  749.953672]   __sys_sendto+0x1c2/0x250
> > [  749.955281]   __x64_sys_sendto+0x7f/0x90
> > [  749.956849]   do_syscall_64+0x35/0x80
> > [  749.958353]   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [  749.959942] irq event stamp: 1411849
> > [  749.961517] hardirqs last  enabled at (1411848): [<ffffffff810cdb28>]
> > __local_bh_enable_ip+0x88/0xf0
> > [  749.963338] hardirqs last disabled at (1411849): [<ffffffff81ebf24d>]
> > _raw_spin_lock_irqsave+0x5d/0x60
> > [  749.965214] softirqs last  enabled at (1411838): [<ffffffff82200467>]
> > __do_softirq+0x467/0x6e1
> > [  749.967027] softirqs last disabled at (1411843): [<ffffffff810cd947>]
> > run_ksoftirqd+0x37/0x60
> To this, Please use this patch series
> news://nntp.lore.kernel.org:119/20220422194416.983549-1-yanjun.zhu@linux.dev

No, that is the wrong fix for this. This is mismatched lock modes with
the lookup path in the BH, the fix is to consistently use BH locking
with the xarray everwhere or to use RCU. I'm expecting to go with
Bob's RCU patch.

We still need a proper patch for the AH problem.

Jason
