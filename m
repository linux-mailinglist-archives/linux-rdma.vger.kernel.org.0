Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185AE60B59C
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 20:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiJXSdt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 14:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiJXSdZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 14:33:25 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FDCA52C0;
        Mon, 24 Oct 2022 10:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcLDXuRU17BovYCwLP0T/EN7ZHkY51fMcXTs3WyXjI1imQo1zxtETaXnkdoPOuZq0+QU33f/pXLVAPnkFliXVZjsw9rOF60hRDzavG4Y0i3Gcb4EwB8EWxz82c37rNr7k7jlgt8a7E9VbikYxNaHdncu3ADV1oX/mfaZwLKL1QpnPE7hNYKP4xJL+gh5+IkOACTk+udj9SVl0dpfqFLNBAd65bXw4wl7Ld3x+7uU2PJsuDzHUfpTk3o5jeQjRaxtGy6+9Q8Y9K2JkyvsrxlocJ5CChRWiHpwVd6m77hWXe8VBoghy63MSnlUH8fjOWXHlzW65JPHD7Fbrpa2yJJyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bggu4R0XT3OzwZiBag+Jf+uQlOV80jJUPhz5uysP0Ng=;
 b=TuICsoKCupq/4B3wkIkCwKCp8IYxsh2M1eZ9rTVl5g1GkuRTVQjr+UARjGB1irM4PZfOcRlTr+WIPALrX8HwCU06E2TkCYoNEdaLa1QjZMjca4Pe2apQjaA9FRXb7Atn1IgCaFa+g/L41fub3GhzXdjUTXby122uBcy60nlP4oPr3MftV/fQFOzwt5Hz5UlY+fSFRA+vpxvFNPEjP52OnkUea9ip/mzVJw28IEiMOzWhn3Xh0QspA0GymCuxlBEydAd29gRJDBiBspxCesJ3B6W9cxp1ecu5vBCtD86zU7tsdjwHr6bz5mJrUPlfIofeZWknd9rwwYOD44wAbdAGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bggu4R0XT3OzwZiBag+Jf+uQlOV80jJUPhz5uysP0Ng=;
 b=tHBzPjARVk2O28myJuxBv5PC8J3wKxOJ9zBFFtJKV0cM7NLRaxkGpfjN1xyYWlOXCWFlTvM8B08UU8GahGgb+Meb5LwzGpSqccxxOfHCdWrW7bZs0ZazmbVz90GGsYbNFWyzyW0LT3NUQ5Jz0TrfZz0X9v4ebbGJWYTZONsOew/yKElmlQWPyeMBdHwZCXjRkB6QP5Pln5Z1RFrD6yFujQgxsyOjCxJf0uweDiOEQXjCbMuiJR1QeMSbMg+60XP7OMKjO9pLh6kgczu7gHC9GIyjlKDoQ57vbMd1RNyu+jBpuStKS0aNQ0cBQr0KzT4KBVbrBppAdrfONsgmIZ429A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 17:13:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 17:13:47 +0000
Date:   Mon, 24 Oct 2022 14:13:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH for-next v3 2/2] RDMA/rxe: Fix mr leak in RESPST_ERR_RNR
Message-ID: <Y1bHygLEu6VjXIzI@nvidia.com>
References: <1666582315-2-1-git-send-email-lizhijian@fujitsu.com>
 <20221024052049.20577-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024052049.20577-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: MN2PR20CA0058.namprd20.prod.outlook.com
 (2603:10b6:208:235::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe18a34-fdc4-4053-43c5-08dab5e31ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UBj+NivwzgP0Xiu7hWn28lHRLe3po/bmjiObve1Uanfn6FWBQaxUtGeGiQhErg1ruA/QS/AnP5NuSwAaPxOh/CjfLUo9sudEyTneqL6mQjMFDPFhefAdc8bPRUcwwbLY6mI94pnjaZoO/lkHiu65qpooSSs5TSzBdQ1an22hvhZ0uJ9VG2pKgg+mMoP8CrFDYaBOHq2bYoPB8MM5SIs/bG+UP348mgcFVDB5IeaBu+D0PBHJlEiA/8VmkCbNsUtxFVUBX68+xZvrwalH5G9ncLJD3DEL0ZafJIB8yD6Ac2xIgcmXdnWpmSKUskWJ/ZJeK6glfudJqBUCCAPZBIoCj1CMHaW8elce6+9+LfF3b8SR7LwT06UR5igny+k4UybiswLvom4+CPOXmzs7Fs6eZFUKMN4fhvMIc3tIiVqFAFr/+ktVHT0P+lHQ73LZvn34JW1COImp9BYbZm/QvQS86Af5aDrV4Ye7dd+OiMd8BlxIfaoGvTPJRve58AX+5tbq5+FBgEWfz4WbfyzQP4fzh22Nb6WQlM87Xvdooxjw4Hcii4qLrMYOanU7wWO7kaNPNcN6Ev6ka5vH9Iqe/uQxjx0GhwZV6qvakfiYI3NSRXSdxEQ33ZlgGyZbmlyAwooNtP+UkJaqqy5uHEemqAVnqmHIt1SJMOsnsZbjnxQGxbxrc2TBV1i00ubeKGhjaKR9+kuPG1M2nVH765Y5B4fogg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199015)(86362001)(8676002)(38100700002)(36756003)(316002)(66556008)(66476007)(66946007)(4326008)(6916009)(26005)(2906002)(8936002)(41300700001)(5660300002)(83380400001)(2616005)(478600001)(6486002)(6512007)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zAky8FD8uUADEQkmkzw2MkcnuP5enU4tm5+0CDhTJnl7MFqUz7S3zrXzolqD?=
 =?us-ascii?Q?mVaywS6yDj3qsKzIVF9ErxUXHn2/oYGgZoEk/Pr6Jt/ZbYQSsWXMywO5K3LL?=
 =?us-ascii?Q?ob/h9fZKNE61AtdtBEunRd7rG9u/jmOiMbA0qvxCgmEUyj15M9fqj93IRQxI?=
 =?us-ascii?Q?JBCR2QHhoZ5qK3N6FqKaIwHk3WuJhHnC9aIztPsC5j4HHMk2a4DQsKHD7rb1?=
 =?us-ascii?Q?o/xFdLsF5itKVnl5AAmLljZ9PT/8Ek28MJU+kq/KmtzC0l5vK+AjAI7YZdfz?=
 =?us-ascii?Q?ib/8ljrtDGC/8VvHt03ymglDkMd9ZqIcVwoTtTvJyHqXJ8aV4vgC18Yl6pPD?=
 =?us-ascii?Q?UXTOI/9/zpiHLcUqIgNpwa91g3hIPcKqnFc++PWPLmpUA07W2DLDkkZadwMz?=
 =?us-ascii?Q?So828rdEQL5WPb4rVba0dqpy019NZ5Tg1DCdBOUxbw+t7z55516omB43R+D3?=
 =?us-ascii?Q?Xr5WOL2bYFS+Bz8xf+rJ45D2ZtLLuq1bO8xYWAiJ5E8x7iogGad7Udzw66O3?=
 =?us-ascii?Q?/ViGY5c/SZqmIj9PHtKIWZzBPV6d3c/DXb1JckAMQ6C7vbTo7RuwE83MmLJU?=
 =?us-ascii?Q?M6Bq21V26v/EXH2M1puq2d/8jUjHYpiAi3OGATjqX6+A/uW+TBfGDgpj1ELO?=
 =?us-ascii?Q?9KXIZVfZFX2dkmCxaWPVzg7fNTJQ9mzBq3FANA+ZNEC24Ntsea6yln1E72WG?=
 =?us-ascii?Q?6CQmv0K4yvo+mkHdCMjLBJ3wky3z4lTcRBrSFU9GDZfgG0w2sZe5b50/9sur?=
 =?us-ascii?Q?kacILCnvbxcXq8ffvN1/wT+9UXIj4N/i+AUTD5UbtRnUtKag9S2V7iHNWiZk?=
 =?us-ascii?Q?X0nkrifGddQBx1fNjomJxk1vv0356fLL7ldRRvQxbdlt1s2GktqQZdUbHFQ2?=
 =?us-ascii?Q?IHBDkLmNGbStH4PsbYNmnXENR8LCeXKJQ2psYkS54wpvTEoftVMcWpzFeUjA?=
 =?us-ascii?Q?IXwITXO2qbomSlHzPypMml4IBIcequE0gpHpTGdLjGCpHAQ3FNxjXb9dbFaY?=
 =?us-ascii?Q?iZrNsHxsPIWfjl08bjfcyuVT9w+KxNR5WqF78lfSWrY/jEgEN1ScpTPrGPM+?=
 =?us-ascii?Q?HNZc2IyNacjeytW0aQmgC2dsAvFsNwwVtx+EARhXrya22VHYKd8UsTLgBvJo?=
 =?us-ascii?Q?VAqlp9QEI4Z8ix6E7576feyjRxWJAbuKTG3WrGz8iZeZPjbkTKErPtYKxcLj?=
 =?us-ascii?Q?rGFM16rR10V6PAl77JSjdi8IU3Q5msclpLTIARRRhupQmct1KYwwPznHU35y?=
 =?us-ascii?Q?6fgwiRgR8HmUyNFqwfO8z3tG6uVwZsG5xI5Ppr03tisbVKxOl8XxXzVCs/WG?=
 =?us-ascii?Q?a2yoWUeofUI1gT3kBok247OIvsv/AeIsowZfYD5JaXKLyKCfm3rt2hoJ8jza?=
 =?us-ascii?Q?sjqXJMcjbN7PZ6SAlSCmae9nmfp/zxfJXmLmbZ19/9zTk9vBygPhufNJBbFI?=
 =?us-ascii?Q?b3+T5nvDWhj5gL52l1LsOWRwzjrJap/VT3JQKURnDvOOPNPTymsI7quKmIIK?=
 =?us-ascii?Q?/apCwmTyG56ANz4KqCYBrHBELU+DKESqr3LDeeSJ6ZQSzSN7DiF+P2FoSgGL?=
 =?us-ascii?Q?s4GHpyUeoS4/4OOvMZQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe18a34-fdc4-4053-43c5-08dab5e31ca2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 17:13:47.0977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l19OP6L073+4M5WF1/yNpyaXmV0FNADaU9MNhDaJYtnPWZ8TBmH/tKFWF+CHOpda
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 24, 2022 at 01:20:49PM +0800, Li Zhijian wrote:
> rxe_recheck_mr() will increase mr's ref_cnt, so we should call rxe_put(mr)
> to drop mr's ref_cnt in RESPST_ERR_RNR to avoid below warning:
> [  633.447883] WARNING: CPU: 0 PID: 4156 at drivers/infiniband/sw/rxe/rxe_pool.c:259 __rxe_cleanup+0x1df/0x240 [rdma_rxe]
> ...
> [  633.509482] Call Trace:
> [  633.510246]  <TASK>
> [  633.510962]  rxe_dereg_mr+0x4c/0x60 [rdma_rxe]
> [  633.512123]  ib_dereg_mr_user+0xa8/0x200 [ib_core]
> [  633.513444]  ib_mr_pool_destroy+0x77/0xb0 [ib_core]
> [  633.514763]  nvme_rdma_destroy_queue_ib+0x89/0x240 [nvme_rdma]
> [  633.516230]  nvme_rdma_free_queue+0x40/0x50 [nvme_rdma]
> [  633.517577]  nvme_rdma_teardown_io_queues.part.0+0xc3/0x120 [nvme_rdma]
> [  633.519204]  nvme_rdma_error_recovery_work+0x4d/0xf0 [nvme_rdma]
> [  633.520695]  process_one_work+0x582/0xa40
> [  633.522987]  ? pwq_dec_nr_in_flight+0x100/0x100
> [  633.524227]  ? rwlock_bug.part.0+0x60/0x60
> [  633.525372]  worker_thread+0x2a9/0x700
> [  633.526437]  ? process_one_work+0xa40/0xa40
> [  633.527589]  kthread+0x168/0x1a0
> [  633.528518]  ? kthread_complete_and_exit+0x20/0x20
> [  633.529792]  ret_from_fork+0x22/0x30
> 
> CC: Bob Pearson <rpearsonhpe@gmail.com>
> Fixes: 8a1a0be894da ("RDMA/rxe: Replace mr by rkey in responder resources")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> V2: remove mr testing
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Sigh, please try to avoid sending patches in a way that causes
patchworks to become confused. I updated things to remove the if as in
this v2.

Jason
