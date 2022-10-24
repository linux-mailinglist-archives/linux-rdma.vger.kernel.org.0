Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A5460B574
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 20:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiJXS1s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 14:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiJXS1d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 14:27:33 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD210A47D;
        Mon, 24 Oct 2022 10:09:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nk5YcLl1dpUm1rECDJNn/SG00gXFavjs1EZa2RRy+vp2BfklX/zO2K4aAWUqEcHq1o/qqvOMZe8UNx/EWOweEFbxAUTzC6ZTs6D4VT78SuNp73jvjlWVWx0RDW8nSWZrb9lihdyr70obDZubhw76Yu+Xx46HRJUcf3i9X1M2xwH9PIPPbj9qnoCF9DWdPGNc13Wdtj7E/OxDuYsdTUfZNdQ3yOu8wHhUPoWpOIblEh64ATGk8UuP2QHXIaesqB+TbtQ89FuMFQJcAqRMI6d6N6meerCElJapMFUhq5SGYthh6g8R89b4WFDLJl1j5Ov4cghDFBSV3oNntp+7y1gwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMfOtIoNYFx3chhM75KrjYl729PIJ3xogRyhROocmxg=;
 b=GRG2e5DZV1v+QNeW5kuD6DR05mogmJcc5dWwvvNMnPKyK/wDElfMQWpx1Q1s3uHR33FjMXAeF9U8iD2rf6FxexzR8EIp2iY/8c3PYs7Pr/l94Z4bC3/rOwUEM2ob08dbr46FzLp5w8ERgUGxD0oK9PI63Yj9be+a/oSrjX/LUFxKZRvO2kCH0cecadg2Mycgz3vH++D7ju41sfzlELT9F+NsYXkXXa49dSdMI2lTZsSM+ul8DWeCxrEJYf5oy14g0mrgHmaL9FyKUBUTSIhWcySY8bhF9gTArnZmWlnpytrL0cR6ev/vUI7abY+GqTLh1e1g2i84zdYa2clIsFOKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMfOtIoNYFx3chhM75KrjYl729PIJ3xogRyhROocmxg=;
 b=rhKSTdRp6UkpqaeoYm5QGylnUEVa3IGcBPL303jNkTGyeTS9+jD2635ket3auraVTiSCxozjWpP7OqQ0TiopxRLnxbE1+ixARaT3rvstJhCfho2+W+0WSTlG4J4h9HB5uJxN2xR9k9oHonRkQky4i5RfYcJ+QKEDmFnGyLDz9sM8r6CDq+4DGzVaCovvKKxOozcXzBLfxUVkaxWSu6wITWYcIUsnG2jU++1u/X+/oj5JLAqyqCEVX7X2QI3mLRim10C57BmXTtwdRQtLHjlvrVXthfts0VL2jiZMTgI+8EJRk2Wv0GaoblxGft8+rXkcAu0cQBSK7EPJ/KYWu2TuoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 24 Oct
 2022 17:06:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 17:06:35 +0000
Date:   Mon, 24 Oct 2022 14:06:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix mr leak in RESPST_ERR_RNR
Message-ID: <Y1bGGurUBxm4YOJS@nvidia.com>
References: <20221013040333.21097-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013040333.21097-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0330.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: 798ff933-23ab-43f0-0a4f-08dab5e21b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apBrEdKeqhYWabRJxMoWGvl4x7fmiKxsGfvuOTCtwvg4wujPiIsySdy8hKkSTPAYrWzBenK7M+jD4SB8m7tvTN0VPvA5JQeGSuTPpASNe02RVogNBJvwJbm75T38jqbXuqjuPnJ2Elj6V6ZVXBzsWTI3sbDuo4/tmTWGuMfB+8uepy4EyOjku9wSv5yICLKhJRszVwVyEwnO0Md1XPsjaxeJErazlCqyskf21TU22EXBd5A1r+8hXLFwTFjqKxwE1JEmGROmhC6nzKZgAd5c8Jr/OTX3jkipk1Inrl6U80nruHIY6spglctFBUYAA+nYkGIeYQLeqVsGNp6bdCZqSm2nOqvcAASshs0QZ+eqyqM/jzWNO2iJ/er42CKpq+vmTyzY9lMd7k0avWX/b3+E6ZWpf+dnNZl/eLjnyah6EXqLM+3hbO2OPKklDFLiyJXFgRff8E/zZly952AKIvAmYaNAZdwvDYERulkgSVpjdUHTPmMf3Z7nSLkjGFotEDZil25qudkG4wn0mwzwQWooVJFfuYDZJ8AeqxTS0wl58IExmpmvyQcLFbb392u9z7JKVSJbQrlLSVepxDJAWJNk4SO3EWlAXsV74il9qc1owyEg2L45IPUP9Dfp5lZhdc+CxJpBZ8jRSjlxgah7kf8T7bmjd03uNzevDFOW1HL07xbjwIbW5FNrFFq7qsP0hMB83LlHG09b7nLb2R9eWWa6qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(6916009)(36756003)(2906002)(5660300002)(8936002)(66946007)(66476007)(8676002)(4326008)(41300700001)(86362001)(66556008)(316002)(6506007)(6512007)(26005)(83380400001)(186003)(2616005)(38100700002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ivpW3ReQvJUJ4wVjpCD1ahyJOtB9uW8VVtL4y7HbOMGCjR3S8m0hLo1Y+cAs?=
 =?us-ascii?Q?UeSmh8PoeSC5fTJtimGOBaiW35pIPHlOKMCpxh7+U/FaElBsinNAY6k4xvyI?=
 =?us-ascii?Q?dPp/qMALt00wBoYd1YoYQCYx73ytS8ZNsDthfpbVWMIsRROy8L1V5+6K5ikw?=
 =?us-ascii?Q?STgyrB7vA49x/veC+3kl5mqfGFyxZd6kWkNzT5rtWi2RfTmlTPNBH1HCUMpk?=
 =?us-ascii?Q?jwXQ52RRmdntn+YUCD1lbL0YtWaSJ5FVM9M+3yvH/T30NBUqtlUR8HVbAt6H?=
 =?us-ascii?Q?0xWsLMxWOEi+fI+d3AmxcF1tEQ4xaNf4Y9VH6t5oDqbhnVcsfaWLwHtML24y?=
 =?us-ascii?Q?Uax88C7EM4ju4sXI/V/4r/NjYz+Zrj9yQ9jX88/eAfwKesCTvmfRi0Kfacj2?=
 =?us-ascii?Q?iGVgCd4SW3GY/UZ9dAVxAzgjKQ3FFTWy2ESWqrcbCaojiQpnZu9xwwffHJnF?=
 =?us-ascii?Q?ScEqP5Mrmqk7CjoDOvFGqjvzQSCaSyhVk0o6qeSFkwEi31ndSAPjnyaED5Xd?=
 =?us-ascii?Q?jptYBI44GYI90BggGhdFIfnr3TpF+Haawc3jBzXvxipyPbCy92B8vN6T4ULo?=
 =?us-ascii?Q?diGkKb5F9Px+NX4R93UYiPJpnCYj0DolSfXurOJUqLyYz584zwtHJtQPN/aA?=
 =?us-ascii?Q?2ZysdOSLepPRX+85LGtCCDtkof47qVlxJz10iZa9fr7MUvmUuu71kWyd7Wjw?=
 =?us-ascii?Q?kOaQmlQrHjzGKetLTUWMa9bk5Bnms/NvXTOZRHjJ19i8CPJpRiye6pxO5xN7?=
 =?us-ascii?Q?wRa3KoPnjsz7sDKqxF9xMB+N3JS2/zqM5M6FJ/V7xAw7erarSWQ7YAG6qiVV?=
 =?us-ascii?Q?BPVSdYofhpMNd82dr5pdaK1lEIqreGdt5SExgh/bWlRxqXjTU1FTMnewOF3m?=
 =?us-ascii?Q?QnAIqB2D37l99JupaoEzTKXgfzy2OMfyDgdaEsz3SXvaXd9fdM87/wE5QPhV?=
 =?us-ascii?Q?HwdsOW/9fOl+2qf//bibq4WGizMD7PmmcfXPTNgBRb2rSrEMmvrKOCbScP9p?=
 =?us-ascii?Q?56M5aNQakbUNf8WwvTVk70B3wrVgE5o6NSAKeDrwWUMSbMZ/YuOaIqF00cQK?=
 =?us-ascii?Q?DbB1I6FH5GwqkWwt6FCLKUmRdc/nv4vAtH0NBHoZGKAKh6aA3KHU21chxFA0?=
 =?us-ascii?Q?8v9ySHNoV+bnEJddyD8ubPvigUNlwuNISPP44o6dXIH7WIdhFlzzZPiwTlQJ?=
 =?us-ascii?Q?IdGLDPDEhDcb9z/uaV5lDCVcwB9aMQPXrnZUpZMCI3/660xVIeUCuIoNSNlr?=
 =?us-ascii?Q?hbvBHBEx0+l/KRvwm/KIKogtMzu6KLR1ca0HjXTPHTTWSqtyeM4U1uNCr5vH?=
 =?us-ascii?Q?flLZFE7n6wigsjXSvpC58v7pmwYC7W4FxPLcoHjidi9foUWPvkO9fIf3YwxS?=
 =?us-ascii?Q?RuMYZvSv709mOUhTu8Tt/zMD01fls6MSXkI9jGKuuPJYcqwPY/lZybBuhWwe?=
 =?us-ascii?Q?c7wgHqgDghOBc5qI2Y08jWxQLjl581XvRBMlCywlnkkXOgKmXzMg7zE4Lhta?=
 =?us-ascii?Q?gtRHU+xcBUCugIQ+eztxraUB5zyAYhX0vsLKbA5A+Bk+uikyoJfDZc6yLpYG?=
 =?us-ascii?Q?ytShJ2lHonuVz5UjYs8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798ff933-23ab-43f0-0a4f-08dab5e21b5c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 17:06:35.5411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S45o96ro2k1SWShIYy6ttC1XyHfhyRAPiJRrkkrUVHq84K/ot4bpaj4PaxtvkS1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 13, 2022 at 12:03:33PM +0800, Li Zhijian wrote:
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
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
