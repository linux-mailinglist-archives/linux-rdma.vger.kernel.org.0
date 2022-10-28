Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252C3611A01
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 20:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJ1SRw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 14:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiJ1SRw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 14:17:52 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2040.outbound.protection.outlook.com [40.107.96.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBA3242CAE
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 11:17:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0/9I4Xh7eXuXQvPdUAoNOf+XnuTiG93vfYDQKcdWmApQYaEIxhgetCe7RSYKhXJMmoVPeiFHJCgFiYmGIDEuaUpQK3MRwH7/Yyb1zfsdq5llbi1i1TDryLODg717Mp9w/L+M6SlQVfiBz7hyCnjEaA7nBBWkbDdbLfi3w+owuVkwjl2DJ3FGKbimkKRPa4kUFXWXJgzWJi50KeMTnHXAHRrWHizhpZplRwZxinOme2pBm1cIiyBdy4YsSUHOutqUYnoLwrtdIpblEceyjuUCzyvxfrRFwesVDIYg2B2AlQklhPs1zasPLAnfMT2cXvX1TA5WNAPD/penP0YksleIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0U23DUs3lLr9T/zgu3HBDzHwTbb/2UgqIDdh/XJOPw=;
 b=iaTQ/4LWmai7JMg1Cbdp+TY5tvR3kScYyI8oiNjGxbfetQ9eYD8cpPjs9BtmiXcDvENlwzQKf2WzZ0AIVaZg/Y2BEhafQlzufiVfkApjVWa7RJTQ3cR4X8C+7Ezwm0ZiHWb8qDZRezbpxkMMGntMxI8EWvfxmhxmzp2xYsPkASUd5RjyR6svoN6kT9WsIVRGVdPObQOh6q5S0MribrF3/Zw+Mz78whcMJ1a5n1NmHq+MLUkd2fSv7XvVKSotPhDZdJKUEgBMULit5wRKEF9KjUyhq9eFDtnG1Mea/2GwK0c4q3iiUXHs8N3eIXPuWi/0duovu5Ll2V0EVr87/Ks4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0U23DUs3lLr9T/zgu3HBDzHwTbb/2UgqIDdh/XJOPw=;
 b=l+A7cqBjjL9KFBDKrqxa9YDolDaKZAl/gzPOFE4bmFI7Byujp0taHS5Il2CEOqMVXA6BYlzeemBiWC3ucb1/XseDOkTkxr5CfJrqSs66aQ+BMGdi4WeNtj1rmv5eCxkADUlsdjjar5kCgq6hGBTPZWLUggGlZOEtD9ENCsabBwQcCbeqacTfJSlVKdhuEsp5kJHD5jOAuqOIfCocqVAfqra6x75oGKTATd1f0KDKd3oseXVSNeIp9FACxFdQwjDzFQjCJk/mMP8y+mZJRbmJRstnilGKM6ofC6jabHSpI9siuqTx4bEy6M41K13uO1GFvjN1ejgOy81x9cm1YTdHHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 18:17:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 18:17:48 +0000
Date:   Fri, 28 Oct 2022 15:17:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, jhack@hpe.com,
        ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Implement work queues for rdma_rxe
Message-ID: <Y1wcyzvH5gMNxpaZ@nvidia.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
 <Y1wLi5lFAGeeS9T3@nvidia.com>
 <6696eff3-2558-6aba-2d62-47b9d4b73fc6@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6696eff3-2558-6aba-2d62-47b9d4b73fc6@gmail.com>
X-ClientProxiedBy: BL0PR0102CA0050.prod.exchangelabs.com
 (2603:10b6:208:25::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 966c5b41-54d1-46ee-5439-08dab910b812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tRlsIkA15RH55M51t9EEdM1azfzQefoqpyaFAcXULQCThRMRQD9DdXgIN5vCbOv7JM/mIUKX2/aH9dw5yyPNOXE/YXxm5FTM001XlkeQRZydkE+m7W61l9fMm0wXRl9hjvu4zwUDCWktfYwMRAfqX1Dcc6lSpSUxQL7o27LwE0EKaakr40mgqpVFez/UEoH91qPqdxXdz6Jyzu9k91oTEls8CQStbPrD56LZJ1t+SiTZFFdWJN1kOEmKofv8lGcOXkNcfrcZXXen2LtrsqtZ865sRKWhnTly9MpynkiEag9Q8GtR/gr3umkV3aq+a6wUPRBQtlSCmJVEJsa+Ra+R+m8KCdaWPxHB4MWFmV7Qg7Lc0eQKFu2i4q0g//ZpgyYolsGr1XQXLNZAULsGjCjfqKX1bhaRv7JN5MDC4t8P4e+h7MXQCytmsDtJipaTVXJ8HDZQAmlgwSRJ4IaDPSZfTR0SUDNd8B1RGdc68IVDHuUTOh7fJ44OPWAEidU4Db43DeXWBuUA72e9Be+pnXw8vrYnsZF0pHp6KeBHMoi01mHvKUbBe3fYton8m1aaJiFx+Ud0AoqNF1XF/gGIDuUqJH3fWRQfeYAZUSOvXTThC+hsqX+o/fiJjW1fapv/QzUMAwuBa2NfQicsiYkphCM1UZhp6LCtrfuhGeu2LT0blgH1UkSIz8RmT0R4F4RpQlPGUe/TQtb9XYpIQMCmKyP3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199015)(2616005)(6512007)(478600001)(53546011)(26005)(6506007)(186003)(83380400001)(2906002)(316002)(6916009)(6486002)(8936002)(4326008)(66476007)(66556008)(66946007)(8676002)(41300700001)(5660300002)(4744005)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z0+s+e8YG0DPLgSrqZLFm8vUaF6ChhSWEsXcnSTAZQtL+jNKqn05VuD2wQSr?=
 =?us-ascii?Q?u46EgoNFBZRDR+qG7h5prGvKx7cyKlNzMdUxcjgSsXdSM26pR1WCFNowYS4y?=
 =?us-ascii?Q?uFEzzTc7K+HgWsWNngQ6kLYhctXPI3Jd4VJTEKMUY/XD8qESCxvzVD4FR8iK?=
 =?us-ascii?Q?8lSxnJz8aYKmFrV0NseaoPw9saxtybUUfZ0UEruUyvS+ack3sirdbIDlI1j9?=
 =?us-ascii?Q?eWLAHeVA6E9CS/Ehl2yrt8wLjwPp4sMYopFjFvX+G/rT0oL1h5St8kspEdbY?=
 =?us-ascii?Q?mWfJGnb1FstVrZh9G5Mr2zTsZHY/snWYYTZbQzeJnWRJRpIFLY3ztE0W6814?=
 =?us-ascii?Q?IAYyMaJJeqIiqD2b0pFB44r+x7QEz9tC2htc+mGUh98+iJMvK51lREzi171e?=
 =?us-ascii?Q?LyTDgcflatWuejHi3OT72VbiELtQC8/HCTEduQIT6QCB9lzMO/wrLgM97O5o?=
 =?us-ascii?Q?RfExUkNUoiK5ttXd3GsEeQUTE5dWz5VcZgk2nftcbhTSNA7n8tTETGQGgogf?=
 =?us-ascii?Q?ZLgtVPKc8t9siDcep8ZcACgEW0UWufAL7IfS2K+ZEhcOgPk/vbbJ4dU8iLCU?=
 =?us-ascii?Q?0+chCZ0AbaDTOIAiUFFT21LA6/rHOup2sKX0D87qoI5tGjh9Pz+tYKy7qrSr?=
 =?us-ascii?Q?il+Vn2xaj7WlKv1Jtsjw51e7uoPJKKPf3zetAEx7QD/+aYwBDCRTYMJ0k5Td?=
 =?us-ascii?Q?A9V7Ch+LEjMKYsVXOZfssp68s27lLto5brVOQ96osm9K/Sa91ksVoI7VSj0M?=
 =?us-ascii?Q?/nZ7mUFm/ccUjcacAzZhEIM0j8K60xhs3Kni23kiIvKzhEN7KO1WMsMpuhUI?=
 =?us-ascii?Q?C33migOmqvKGurItjq1I0fE/Kb2kI598Wr8aPHr+OqIHcv+eEMzu0KipIc6X?=
 =?us-ascii?Q?SMlFH2/zDRnatUlta62Yaw4JPdw4z7JN1/liuqNJ6le8OgZo/jaIYrmXhPgf?=
 =?us-ascii?Q?mSmGE+ccwwqQjZ42BKXBMkkhC2PNYXCROk5gaLxRUd6g+WswZtvTJxAY0ISH?=
 =?us-ascii?Q?knkrInm34/CP0imMDLfvhW+aV7lEo9KAVNJgJ+K6KHLvX9uTD1Ptx25cej/3?=
 =?us-ascii?Q?SoC5fDwIkxTK8RA80KGbua7KwEptdhd6sT3E3huVicHOy0AE0kHJ/9agk/gJ?=
 =?us-ascii?Q?8OOoY9H7jI0fb8pOfoGFu22poZAE2+TnPbSCiM3YCw8gr43aDYoNki+LNu41?=
 =?us-ascii?Q?t5qaxJ1NKuhWs8MxZsUO3WtdLO1EmTztzO8EVFga/YIQvOHZVFpK3jBeoDvM?=
 =?us-ascii?Q?UyuHgPvrsNk2Vk2KkKubIqOKaLZ0OsjNlji9Igq4krqwDKivUV2hzTfjr7xt?=
 =?us-ascii?Q?+dZnZmd7P4KLSljKfXWjprb6HeskClbOa8U8xl6nJRGOpHNZ7S1qmG4tx9Iw?=
 =?us-ascii?Q?V8Z2RIBnWUnNF9Xpj1yP1FsM2RW38gqNiumY5ByQnlVPud4MwFYD/KOIBYjN?=
 =?us-ascii?Q?SuWs1QXhPwpzd2o0yoCCfQnwzqgba1Zhu1MfviCo1UcKvqz+Rdphq5lEAjZI?=
 =?us-ascii?Q?dyH6jt1ONde01SyJnvZDpfLiWfbuel0oKgliVfKioQbu9i+p0RvJ/Mw/82z3?=
 =?us-ascii?Q?+QP/tbIl8WCCOl0mg6M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966c5b41-54d1-46ee-5439-08dab910b812
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 18:17:48.5951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dV6v05S3S/Ml1a15MZogKqxsrdwe3MF4fNZ1N8Qk+BydfMIbDhZ6M1ZkFjlRvap6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 28, 2022 at 01:16:11PM -0500, Bob Pearson wrote:
> On 10/28/22 12:04, Jason Gunthorpe wrote:
> >> Bob Pearson (18):
> >>   RDMA/rxe: Remove redundant header files
> >>   RDMA/rxe: Remove init of task locks from rxe_qp.c
> >>   RDMA/rxe: Removed unused name from rxe_task struct
> >>   RDMA/rxe: Split rxe_run_task() into two subroutines
> >>   RDMA/rxe: Make rxe_do_task static
> > 
> > I took these patches into for-next, the rest will need reposting to
> > address the 0-day and decide if we should strip out the work queue
> > entirely
> > 
> > Jason
> 
> I'm guessing you meant tasklet??

yes

Jason
