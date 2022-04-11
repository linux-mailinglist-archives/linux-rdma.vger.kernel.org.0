Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0AE4FBB18
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Apr 2022 13:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiDKLky (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Apr 2022 07:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiDKLkx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Apr 2022 07:40:53 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2049.outbound.protection.outlook.com [40.107.101.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2D3457BD;
        Mon, 11 Apr 2022 04:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjeHmeaj68x402b1Nm6FxbI3En9dxftFLgmSr/mQMsmOgeQK0K4PLtwRE7PwyTAL0nQgsbdOhq+mLUnxIvgV/fNeMxgKadlh3t0h4+7J6lEBbAQV/7KVDAtc2DE7MEpbKdIaK6TiEVixh+XwG9VcnQY5jwQrFziyjwk6Gi8Y3M/+9pvBZsc0iC7NZnFKMA1yKF3GHJrSAHF/kBVuBVYmlL+o1NpwACPMSKL9NnCqrGNp9Rjs2qxSYGqhWTGXbwSk+U8hkC8tKe/0hux7aS4gunZ1ah2NivkQ7BKDhUAcv4l4r/0XgMGfJMxmNJDBGAXX9xxhwNVxNl1GP9w87KNTTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NI8eRsAYdvCXzbpqOIS1HUQ3eBNPwq4U6hfD1nlRPw=;
 b=TPYEQXOq6Qy9TXVlLoO56nwCP16NWJCmOZllvZ0BRjYXDhW1oEcmt/oseJTLr9SmDNeGzYOnN+qjSKE98GuKkKTQ+hC4JIPVh7S9RPKZ3EfxJNI3wftKRjGZuanJdC3R403kiPZg2+HG0b/EvSvwEXZsLGd69c7KjMO2cLxjAcWaf7B8SutDcuz3r5ygrquymWKvsjazxA+FLWlMruV7zJhdi9UX95O1x77x/xi05jEDRI2HjJFUsI2mMdlaqwrVvoeAmBBbYGwsiGbdFQo42M+IeMzlgWzWFJo9b5ymvK3VT/tvAYqA87nW/HuaEerSVBvUaFdQ2WiezHO4KfSX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NI8eRsAYdvCXzbpqOIS1HUQ3eBNPwq4U6hfD1nlRPw=;
 b=MXGJlqTLwFAB/hGpI92xiO35IZVeLpaQ6WlA7Ggo3cPrygVAApDaBY61amm4HOvaFtIz7JXgGRudo/ro+KlkznHi/sqk6R6K5zkTd7kLFitf2gB0dBTwa78M0FwuJQUWrCZueiVu6TfwDp6FnVOQMg3Bhovkff5sViv88bFqdiEfCN1sraUppIwwzKZ2Q9CPylaDTjq7/sscY5D6dQujjI8jc51/TyoguoCqb05ipPAXgDk6zrSGYBPyKTTUdANbbPw/6WmuccNH3p0x3IIUYsIXziuQgjL1yzB39zx7+CCinoWRBQ258YHACHV5nzYb0MmWeMUi9r7zqvG79J8BWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB2913.namprd12.prod.outlook.com (2603:10b6:408:9c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 11:38:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 11:38:38 +0000
Date:   Mon, 11 Apr 2022 08:38:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        yi.zhang@redhat.com
Subject: Re: [PATCH for-next] RDMA/rxe: Fix "Replace red-black trees by
 xarrays"
Message-ID: <20220411113836.GD2120790@nvidia.com>
References: <20220410223939.3769-1-rpearsonhpe@gmail.com>
 <ec1de70c-aa84-7c3a-af6c-4a04c5002d1e@acm.org>
 <6296dc52-1298-6a52-a4fb-2c6fe04ab151@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6296dc52-1298-6a52-a4fb-2c6fe04ab151@gmail.com>
X-ClientProxiedBy: BL1PR13CA0426.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::11) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce0b42e8-2c95-447a-c4c1-08da1bafd1c7
X-MS-TrafficTypeDiagnostic: BN8PR12MB2913:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB29136AABE1ADFBF63EAD4B3BC2EA9@BN8PR12MB2913.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZJDB3cW+FqGxn8YDtWCeBVS2HSd10Amm3tgTs0syd19lvyISkL5aNCy5xfr4Rw6Cs3onYJo2coLGzNuOGj34vOnH/ewlbr67/RHiG/JHJbOERnl+Xj/Acr9rHr+RJEpGSHNvwdVij0FLIt/8OqxPIQw3G8+MZzRJkpWQMLI10Nj5tjirMxRrbVvjh6jlR26fzeNoqZcBZd2/UqZ6pp1TLvwnX7RWhLd2WXRmwIHYIjvfGk8AFjPhEu4OV+kKVdhNBKE3Mak10IRnTa8Mx3PskT9j11FqfXj6aCEA+A+oVC+cJtEosWC2ndf2nLS+2m1x9Nt7liJRPjyLTM9utLDMNX6erqRB/evNGQg0Xtg/4zA4qrJw4BQQfASUm6tk+K+SI2q+KLdKsBFBzSA/AONXFEGpk2rPN1fXbOXkViztqLsCyU2+tACj2gNSRcB4GLk5tKyrRIhPXB5zupNBNW5049TvpDeZj791j/6gefnpb1iwCz8kXzwgxRW2dwNUvwd1BaivIiZWH0uPfUGSSNKFFbotG/iUmY3AncmCry59NGl3Ek1gmCufUfBkYFQVrUiLSAB+pQguZRG//e0PTsR4/CFlMNPz+6vP39uk/JYOD3tycbMbTq0Js8ID5NsXpseSNdQ41sFxCfDwzj5VYi07w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(8676002)(66556008)(66476007)(5660300002)(36756003)(4326008)(33656002)(316002)(2906002)(8936002)(38100700002)(6916009)(2616005)(6512007)(1076003)(6506007)(53546011)(26005)(83380400001)(86362001)(186003)(508600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OCt5eWx3ZUhIYmJ1QmF3RWtxVmhSa0JFK0JEeDRacjdiUmQraEVVNmtTK3J5?=
 =?utf-8?B?NnIwVjlhUlZCVkptTnFQQjdsR1BkdlhpSTdTeE9rQW1meEFxNVhXWWpoc05P?=
 =?utf-8?B?K0lQRjNGUG1oaHlPbDk2eHVSSmlzZGN3Rm1ib0JXcW9qVUpQZmQvbFFjdEs2?=
 =?utf-8?B?NWdiTVk1T1pna2FVcm5CS2I4bmdSVXdoTFZWQXo0WmJLNW93QlBrZCtnWEJP?=
 =?utf-8?B?ZnNvUTBYMkZkeVo1eDFNTXFXYjdnRzI4WlU3WDZOdmNVSzZmYUtLRThHYXFE?=
 =?utf-8?B?WVBiMXY2QWdnRHVMRnNEN3NOdjVGMDUxaCsvdUo4Vjc3SEVXMlVQd3kyRWNV?=
 =?utf-8?B?M1VQT281VnVvbHZzTFJQL25PM1RHaSsyVFZwV1ZZZzh3TEpCMUhMY3FDekhT?=
 =?utf-8?B?cjRWMzd0NGN5VDRSZGtiSThvRitHclhsa0xRQ1FKUmswRzFUVzZTVzZtUGlQ?=
 =?utf-8?B?Q3FnSExzTCtYWFUyMzFHVDdDQUVGeU1LL3hwZU9MU09YcHBGV0taaUFTVUhE?=
 =?utf-8?B?OUNpVXdlQlZaQVVDaU4wYU5ka2Q3bXhRSnhEWFYwYjlRK2g1R1JZZGMyYjZH?=
 =?utf-8?B?TkVLTTFZKzZ1MHk1di83cHJtejNVVXhPUHR3cUlVTXJoL2JKS3Z5TmllZkVw?=
 =?utf-8?B?c2FMQmFZTExqd2I2a09wZXhNdzY1c25HdlNqaytYMS93aXpZNzhpMC9FTHFB?=
 =?utf-8?B?dDhGMTAvNWJmQmZhT3ltN2ZHcGxSTGFFbnZlc3RlQnovY3NaVWRVSTVZMmI5?=
 =?utf-8?B?a3IwMjlPMWI5WW1ZbVJtRXltV0xyc1YvZ3gyM25INDFxS2lEenpUSU1tczEy?=
 =?utf-8?B?WGJSQ3ZuS3FML3YrODhLTnJocnkvaC95QWV1aitJZXd5bHpyakorNVhGeXk1?=
 =?utf-8?B?ZFFkTUIzbSthTG85OElTQmVQRm1qRUhwbEVVbHd5eHJOYitGMER6d1JmN1Vk?=
 =?utf-8?B?anBwVmYybGlVT1R3bTVPN0VOai9IcUlmZ1lXRFEvRDk1RmU2T01SYXYyNUdx?=
 =?utf-8?B?OTY3REI5dTRqUjBpTjJRVXhKNThvMzhzSDV5eHRBallFa0ZWRzZ6bG9hbDhi?=
 =?utf-8?B?WjR1Z0liNlU5UDFrcDNubDVUTittdjJyVC9zU2RzT0ZHQ3R5WmxqRDZCZkha?=
 =?utf-8?B?M2lNNnlYUGplSGNtMnoxM1dQRlB5OVV0S2plYW5WTFpvQXhodG9PUEJqR0VY?=
 =?utf-8?B?VzBVZ2N3NWlRZVZsT0NhZnVFTzFGcEtGZHFsTWdEeG1yWmpmSHc4L0YzYUpO?=
 =?utf-8?B?QmZBeTVnVklLa1dWYmt6MjI2VjFwOXRJMDJGTWdTK1pFa1orZG05TzZqWFFE?=
 =?utf-8?B?Ukg0Y0dxb28xSVdpT08xcHdvTDhPZ3NmcDhJbTZ0am82ODRsSHB6ZjZaaWth?=
 =?utf-8?B?T0V1M3dNdFNlZmN2T3NXdjJlMDQweUdpb1hkZTF2QUc3UmNYSlZHTFl3VUFs?=
 =?utf-8?B?cGIybHR0ejdaREpHMVcxd3FzVTlpcGlQbWNJMFdTTmdhNklGbDVaTVRma1ll?=
 =?utf-8?B?Rk5HMUU5VSs4TDJ2RXdPMTV1TmlHMXFpNDlIWVVUTHc0TFBXVVI2WTIyZUlx?=
 =?utf-8?B?dDE3ZnFGNW9wb2x6NUR2a1lpUmZOOUwrSDRLaEh6QUpxeER1WFRJZkF6N1JC?=
 =?utf-8?B?ZmpnZjFyZjYrWkgrSGluZUN2ajZ4OENWMTNac3M1cEtlL2NYQTNSSGhtekp6?=
 =?utf-8?B?L25mWDVidTA2b0lUZldHZFcyZTR6Z2pJTVJUODlITEt4aGVFcTZMb3lIZnQ0?=
 =?utf-8?B?ei85cTdzYkR4TzFkL2pQbWNueDRYTTVjZm9DeXNkMDNTNStZRlY0NGFSK1l2?=
 =?utf-8?B?aUFGUE5ES2RDNU4ycDRCYnB4QklzbFErRTk2ZEIvSnFKd2pjVEpGQlE2Uk5T?=
 =?utf-8?B?TjFRUFRmQW5WN1p6QkdFSjFMWnFVa0VyTk45bTZJejNGOVltZThDbnI2TkpT?=
 =?utf-8?B?VmxGUUhYUkpGd2hLMzNiUC83SGlCTkJMLzZwRFY3M0I1QkNNcXgyZzhidDRL?=
 =?utf-8?B?UDA3aE5VZHlrQkhPWjFYRTYvQ0Z3eWoxOFNSWEJOeGVMbGVHUEJTSnd1UmhJ?=
 =?utf-8?B?OTNyMU4yRlgwVVVWSmVFck8wRHVya0ZwM3ZPY21hRTR6WXJ2dTZQUHA2L05C?=
 =?utf-8?B?MlNxY29qVW9rYmpDQW9kYldNZjFJek1ScFVDbDErOXJhYWYySk1MSnJUR0Fy?=
 =?utf-8?B?YktQbU1YeGpvRHVtYlJxTkZYOSt0OFhRZExCbGNKLzhRYTdaVy9lSVRCUEg2?=
 =?utf-8?B?d1l1KzhTN3E3ekZVVk50cWJxcDdDME96Ymk4ZVJ4ZWIxVGR6TWdFUkc0UUhs?=
 =?utf-8?B?bnYwMlRYNjJDdHlkem9IS01TNVY3aDRPVWYycFFvWE9hOUUraWtOQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0b42e8-2c95-447a-c4c1-08da1bafd1c7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 11:38:38.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTOYjPHGPP116tKfMi1wCs5ctklXopO0XBNR8k9AjXX4wU55wjNc1cVQvI+747/S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2913
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 10, 2022 at 10:13:16PM -0500, Bob Pearson wrote:
> On 4/10/22 22:06, Bart Van Assche wrote:
> > On 4/10/22 15:39, Bob Pearson wrote:
> >> Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by carrays")
> >                                                              ^^^^^^^
> >                                                              xarrays?
> > 
> >> @@ -138,8 +140,10 @@ void *rxe_alloc(struct rxe_pool *pool)
> >>       elem->obj = obj;
> >>       kref_init(&elem->ref_cnt);
> >>   -    err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> >> +    xa_lock_irqsave(xa, flags);
> >> +    err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> >>                     &pool->next, GFP_KERNEL);
> >> +    xa_unlock_irqrestore(xa, flags);
> > 
> > Please take a look at the xas_unlock_type() and xas_lock_type() calls in __xas_nomem(). I think that the above change will trigger a GFP_KERNEL allocation with interrupts disabled. My understanding is that GFP_KERNEL allocations may sleep and hence that the above code may cause __xas_nomem() to sleep with interrupts disabled. I don't think that is allowed.
> > 
> > Thanks,
> > 
> > Bart.
> 
> You're right. I missed that. Zhu wants to write the patch so hopefully he's on top of that.
> For now we could use GFP_ATOMIC.

Yes, you cannot use irq_save varients here. You have to know your
calling context is non-atomic already and use the irq wrapper.

Jason
