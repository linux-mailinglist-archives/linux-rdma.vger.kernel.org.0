Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A77D3B9E
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjJWQB3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 12:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjJWQBW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 12:01:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B501722;
        Mon, 23 Oct 2023 09:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwXF6r+nMiNwNVIXTTPKazrpduYhOIa93Jz9FoAsfkdxyddia1e8oqQpegXOs93cc3FBBM5C3UUgVwxSckA9Pph21I75eOlviDIt6DdehdO8D2JIXYgtQ4lM+M7FPheM3J/+KZ9IQVHJSvMMDWZVz0Gy5mY/fUjnOpy/nP2KzaNNvFYFADqdf48XX40Scg7plvLYCns1zL5JivaqrGVTgO5f7T/yJlCyv/IsCO79MhkSPttICAUUjZPl9rrANV+aUGT3gTWhe+Eu4DPH2JdYSNO/hx5TqPq0WWGuKeoYxQnsFW334yIdRtR/ZyywfpUL630aPVRqgkmzVIJ32GNiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTis2q3/lcn436fubBaG0buk64NPTXNBw4MJC/nxed0=;
 b=IwBt7IPehOOmeifpTD8d/0LlOPj47rCNItQvLzXLIhPlpTHgIr2dJ5M0OGRZF18wwwg0aZ+WE0+h3J9H6vMYk5NpuMEHAKwmm7PrrzLNy22x3Nx2ebucZ/zRTHh1xporPprKC+o7RdwTuryItvNOsU21QLjoCPEBy1yHIFLw4vjOh8aanAjxPAVrqSIA3NG0SM8886UWo2FSj6eKjT7enmjvGbHcSERluiGbiAqMnhUxX3M2x12/jqjgl1LNmsRqcf5bfCIIxu+D6c88JLOHLrXtKjS4ceJ3Gsm6eT3KWMFU9mP/OkarAsL4yOuvXde/jdx2HfQ3vteZdlPym9ZNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTis2q3/lcn436fubBaG0buk64NPTXNBw4MJC/nxed0=;
 b=LMwsWQAsUtifepDXtYjMc2JYQvbpzBjN0OfhwAW2VbrMuH/oWRuxkdYHLtDfCzPMtiUSdSl/rBTdmb+al4i0IzbWN4aq3BYLgWmiGl/MXjNs+fyKf6qhFljLwlCqKy0qq7VunrB9MeFKKHp5ugOOpDpby7sxMnKR2dNIQmEqhsO+y3+KjQJQXFHCTsapReXVBpUEnJrzV4TqkIpMwe/zv39iGNtxqvcrYpdSIMl2VL7IpFTQT+cLJazJy/9cj013TGSNuoQ1Q2ycjkfUx1NCXGcbTYs+ofSSfn8wOGG/htRXtpenmDraqmpVKi72yjkMtuy5EUE0cV8r4WfqCMBiLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 16:01:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Mon, 23 Oct 2023
 16:01:12 +0000
Date:   Mon, 23 Oct 2023 13:01:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chengfeng Ye <dg573847474@gmail.com>,
        dennis.dalessandro@cornelisnetworks.com
Cc:     leon@kernel.org, dean.luick@cornelisnetworks.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: Fix potential deadlock on &irq_src_lock and
 &dd->uctxt_lock
Message-ID: <20231023160110.GA886087@nvidia.com>
References: <20230926101116.2797-1-dg573847474@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926101116.2797-1-dg573847474@gmail.com>
X-ClientProxiedBy: SA1P222CA0142.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4153:EE_
X-MS-Office365-Filtering-Correlation-Id: 01960560-4d2a-4e44-96da-08dbd3e1475b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQE1CwvYUmHpVmqsvfkuZvbOVYVxuChhbguWCKFkXQciGmX5YogpoLa4UTMmO1dr2pV4qAi7A8e8BPHJxC1O4mdJCeyUHWj8sCpdR8lQdMCVaartcf0mKf8RmyH/451LoyLPHxvuUsnBEr6YBjCUet6Q3rLY9dw8Unlq5qoQG1PU4D/GyF8VPGZM0pkJaRnPawBbw6zHuu1IMsNc49rAkbXabMHc2a7yUAS3/M5J/1TQScM187MVgnk+PNcXxNJI1EZHLKD9VAHwWxtiNakVbWlNvWOLYyv5cQ3RgqVRlesavVqxoIir+ugOUGz1EvEUbqhhFI1kcmfCiQDRCnEqhjfJIn+XU6krylFRk8cP5yAKN5s6Z5skgCAIH1UeAKMlzZc1jUmxRSsxIXm8WPt/UxoNNp8Xd5c/3/OX7/XXDgLZRwyGFw2fNc1CTI/qpI3vM9sqI6FQdSeplHk559bjg9AEBzc4gsxrbFx7dK1yBRhDT1+kMPwSaac6TOKEZA0cM4GOGYr4pXeBwNKF87ufHeaS0nHfkHssgHg+3m3qW1usYh2enyR62asvoN2a7vOn33JrBSYGU7xThNwe7WdUqTwBJgF+EqASUKaEnKiP/x0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(36756003)(33656002)(66946007)(66476007)(316002)(66556008)(1076003)(86362001)(38100700002)(83380400001)(26005)(2616005)(6512007)(6506007)(8936002)(2906002)(478600001)(6486002)(8676002)(5660300002)(4326008)(41300700001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pvf7vEy9/bDmreYzBTkqmLIcccsckzEM2LySv/EsHUAl0l8Rr82At9/oFlmw?=
 =?us-ascii?Q?+CMApEAlAL3VJKKA/LoPG2YLKSC9MykbAhKLuxc2ydkFp/6+GVVr+k36IyeZ?=
 =?us-ascii?Q?ydV2geZd7kpbv3YGceh4uRgE75eiZU+qPDP7Yg/uLW0X+rsNzPXaupsUsT9b?=
 =?us-ascii?Q?RajURLyyoXJ/ZbMFK641or8hDO+HY8Hrv3gSztSUVaSF6qpQFdQavoAAp6Q5?=
 =?us-ascii?Q?BJsb4qdyjZRi5usOccF35mjMtUfFBSMOaqSz+zLNHV1ghNg6B1ZP7LtOqfuT?=
 =?us-ascii?Q?hwY14V3EpHq4HIq6nzvTnuKXODPuZMLgqCcWh0TAmD9yE+v9geR8RyJw+8fb?=
 =?us-ascii?Q?dS+uw8WoHnoLukSJm4qo9IEUV9j9Qr2NnbN0/+zPuzgux+a/+GRDU8qZU3fF?=
 =?us-ascii?Q?ZLpamhxp9H1aFwfAZVhTpKywRdII0mm9xZ1dnAzPn0MZzopxmTHp0IdSBVeD?=
 =?us-ascii?Q?xKhb00VU2gEWX+LEV/eWq+DvArgtItlyM6OboB1P/w6flB0VxOEqh+/VpPQq?=
 =?us-ascii?Q?eTRk0KQlVZBlhc3e6k4pPiYEcIaBOa8iB6FxGfkR1s7lSkXpISApPcZ5Gxr5?=
 =?us-ascii?Q?EixYOVO8Oh7lkp/Y7RUBq22OfGrRNh244v/W+y305NYOgxFk/c9aWQ+ZrU0Z?=
 =?us-ascii?Q?XEQgrcFcL1qPTAw54TPxaijHgxw02oNGAkgYy1DbuaWmL8s1LPOyaursxH4G?=
 =?us-ascii?Q?xtrvy31nwOCMLNgVnSV3mWXkIVaYAiNoIK0ssD5ElYQzYZ7S8BCKZ6ceGAzT?=
 =?us-ascii?Q?/f3/OcAuxwrRbl+89uXPRI5r8AGj/YQsqHnNe/iwD+X5+nPqdyKQIDH0egJM?=
 =?us-ascii?Q?lbDgVv4BAR6I1EuNo5625jA8lznMTjPsXqt5NzXKdDqqpAAqvXwvkhtxwmAC?=
 =?us-ascii?Q?xj1a4Jz/J0NH0h6UURS1M2+aCXe5E2vWtj10GgjIr7GBqHuygwoIFN5kg46L?=
 =?us-ascii?Q?0Elmj7Iz0IbBZOeZhgD6lUH3+9qqHwuXCVV9nvhfYCZRxhDeVin9UuUieDZ5?=
 =?us-ascii?Q?zI6UEwXiLDlHA1xjYNYcvpB7cBVy8E6BUDVIf4j+fKxQ53zxbKdCEMkunccK?=
 =?us-ascii?Q?P4QCluvb3VQMJRYSbB1n4j4A/DbcO4UiH+iL+FZ9HpWIIuRhEtKZbExw9HeB?=
 =?us-ascii?Q?hDn1JueUPzNbXOM8jDy0OEs34j9wWybFxaeE4b/S+W5VPGlPHmplLSdRIwJL?=
 =?us-ascii?Q?nHIXwTM4LvfDVwxN6ObTUtiUK7jr89g2S9Da2k+RlfeenyNsdmG75WuGe2BX?=
 =?us-ascii?Q?t+OHLxj8ZVge/taP6ZCJNWQ9QeY4SMqum9IUolYasWy+pd9gsP9bTjSN1cpD?=
 =?us-ascii?Q?t5WP/IXDn2oBKVTE2RX8p9dYyCbSp7QFz+omRlwEf3noqVPlFvwb361WWjae?=
 =?us-ascii?Q?RU3zYVzGDvqxuwkdGk5PsbZDQ8OY9HJeEoTejau2rWtkD+LM2pI9YUbkTypG?=
 =?us-ascii?Q?39/ldBnvZMLs5QR71ans5g3JKtjz+yXjWuwKEV9fSJqlFkSsOmCQTdvl2sZy?=
 =?us-ascii?Q?LpDvY78cg2eUlxhwy0HjRCL0lxBNzUfdokfLqrsxOzk86OYxGXOUltrvzt21?=
 =?us-ascii?Q?pC56bKrFBnJnSdIt2ttgqqyE1rD24VIETxxdf/FO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01960560-4d2a-4e44-96da-08dbd3e1475b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:01:12.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyBpPw1/l+juI8IM97yXoE4sIFv74eANrzCiRrkMOCq5JbifkbIxA+EnvGZV0kWp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 26, 2023 at 10:11:16AM +0000, Chengfeng Ye wrote:
> handle_receive_interrupt_napi_sp() running inside interrupt handler
> could introduce inverse lock ordering between &dd->irq_src_lock
> and &dd->uctxt_lock, if read_mod_write() is preempted by the isr.
> 
>           [CPU0]                                        |          [CPU1]
> hfi1_ipoib_dev_open()                                   |
> --> hfi1_netdev_enable_queues()                         |
> --> enable_queues(rx)                                   |
> --> hfi1_rcvctrl()                                      |
> --> set_intr_bits()                                     |
> --> read_mod_write()                                    |
> --> spin_lock(&dd->irq_src_lock)                        |
>                                                         | hfi1_poll()
>                                                         | --> poll_next()
>                                                         | --> spin_lock_irq(&dd->uctxt_lock)
>                                                         |
>                                                         | --> hfi1_rcvctrl()
>                                                         | --> set_intr_bits()
>                                                         | --> read_mod_write()
>                                                         | --> spin_lock(&dd->irq_src_lock)
> <interrupt>                                             |
>    --> handle_receive_interrupt_napi_sp()               |
>    --> set_all_fastpath()                               |
>    --> hfi1_rcd_get_by_index()                          |
>    --> spin_lock_irqsave(&dd->uctxt_lock)               |
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> To prevent the potential deadlock, the patch use spin_lock_irqsave()
> on &dd->irq_src_lock inside read_mod_write() to prevent the possible
> deadlock scenario.
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>  drivers/infiniband/hw/hfi1/chip.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Dennis? This needs your ack/nack

Thanks,
Jason
