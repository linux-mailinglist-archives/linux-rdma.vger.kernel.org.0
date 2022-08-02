Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE14588113
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Aug 2022 19:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiHBRdR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Aug 2022 13:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiHBRdQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Aug 2022 13:33:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2196413D46
        for <linux-rdma@vger.kernel.org>; Tue,  2 Aug 2022 10:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KK7pMtfaas9plEtn++tZ4ToEKP5SWoA3sapiRoUE5C+YdsoLeoecLfkGtj9kv/zYD32HlOV1KSPuwMdvvC4zqRB3C610SjqiNVp2SMG70k1Vbkh57GUuJOagQmeXwosUO/AG5HZmfzDgrKOfPucNWhcP/3Ff+wvSAfB4yX6eyn45/ROBL7tzsn6rypJXpkyllGLK8ieTDKJSiZq/STy81Ek4tcbSTdiOSzB5iUyQgBlJxR96Ub2gYEjzuu6M1TfAkDwaZHkhwDM1KvL8m5I0KX90KtP/ycNOUyXX7lZk+N4IjiJI2D3VV10V/tDTqKNct26GA8x8Ej+RETPpr1nG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VM+p41ioAkzmIr1zPXw6u9w5BO5mkfQVmQ7i+Op9opw=;
 b=Vaxyeeo/pMJeNBTvsoWukH/PlQNNqQWIewQ3NmD+iWHF3FCciZnYu9XVRqSIn+MQ8qHfyxHc95Fmn5/aXO8HooigKkNPKtGxGpXNGeRfhtUD17D536ZutVnaoCvU8RU5U26uTP5mu+I5RC1Mft0jEW70Chd18pj6LUb4+eYZiGy6SxaYvxJfEXxS7nZlsf8HsL2OKXPgXMF4oxVMde7HiHbO0gEoKaHP5FlWTH3GLr9iC6viusPgJHQw0cv8Omc5RnGSH9pFcQrqUF7s7cqKLoyC0EeYJ66v9lLIcyaxQhAa4SaSJdTzl7b/QnZTRQLLm1HSlNtDQSfHIiUL8CBMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VM+p41ioAkzmIr1zPXw6u9w5BO5mkfQVmQ7i+Op9opw=;
 b=GpfvcP3gUFjHSW0n1rD1WEUMrcPP2zXmWbizXIUjqJSImCgIXu8Hb4J6+cl+6ZY/997JQrGncioc3751jDh7wbrkoIEyhC22gkmn7pWCpze5C0ZvUHHJWQKF9edE1J8ks+xtRflcHLZa8NJ7JeS3TdrmH+t4gJ9Qg+nm8N7opWLjVHxZNE9d3fm3W/ObF8tiLdIrR0XxTOFojfui5j9P8+aA7NGcSXs/RNpPSTAiELXNtIjEkBdzPv4gXlUP1cEw38z3CTSKtCRnIS+iN1/Gdq/iiI4VoU/SSIn8hBx0GjxLc6rRV1+uwYSII4qdDKH8L9GIUuAwci2hrNhEJmix8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB2861.namprd12.prod.outlook.com (2603:10b6:208:af::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Tue, 2 Aug
 2022 17:33:12 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 17:33:12 +0000
Date:   Tue, 2 Aug 2022 14:33:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
Subject: Re: [PATCHv4 1/1] RDMA/rxe: Fix qp error handler
Message-ID: <Yulf1+Q40jj5IfGY@nvidia.com>
References: <20220731063621.298405-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220731063621.298405-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: MN2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00425aeb-21fe-4260-decd-08da74ad12a4
X-MS-TrafficTypeDiagnostic: MN2PR12MB2861:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wnvlbl4rHeqaMtV9xYzi3lukJKeNL0Ir4MEdm5lpAdDW5TP5OxACtUx/BHaqN61KUwuqL2C9yRVtlqlhq+4IQ5Jdda1uWO/yMPRTSu+KdwI11mEzYScCdrmF541QCRKi1o8wxVH2KO/of/MAZKKTMq3ePODOkDCGlErBvPGNvUXLzCKMaV8D9876A6wxzF3H4VglEou0zevTq9fZcc/OTot5qQs/Fex1ROCzBsY5ZUmer/QNF33Eg6uFqgUclxqTKZBI/qplYu0oA17j/A+XURTPcs9TLKHTVO0ATsTbuWbJ0WIDyZXs8ZNX5nUMyvIx3qpUOQyN/+nWGfRoDZCBOhQaxXV7M/bahmqWqNKx6Abl5tdI2nbn7Lad1Wf3ylmHJ2JsqDtHOJbAvGJqh4LsjStcHToHF1ZHccwAVMIzME/sZmIEaeAYEGEM7eU+++YKXkSu3FZsAYw3aMuw3pxOGQZ/ceysTDseznyUn/zgF6Z/oiqLpuZ1acffjASbqJTh0Ua7/78sA9Zlsam55PBIeON2fn6z3AzObIpzYgq1pE0mq4BggBsd3BMBVIW7a+xpbb15GUEmAGQ/cjVbzvxFI2peZpcxSYHYczQJRV/nyegvWJK2cUxno/YRwmk2ffIwbJ+dDhzsnL/oJlA14/y8F0J9eI4cQkjn25zPuN2dki+JMGMHnpm1L0v3YAIpvU4tNK1fr42jmHKZOMAkrtuln7pBAG4qILA+LNwfGk8edtxe5ger55AoA8EiplaXY04E1JOzllCvPuhPgnAaBZUx3aHpVM3qYErNT7EW4KG+l5ug36XSqrMnBO5XHl0BDVfenvRoQEj0xTezWySR8CJdqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(316002)(83380400001)(41300700001)(6916009)(38100700002)(26005)(2906002)(8936002)(2616005)(66476007)(66556008)(4326008)(6512007)(8676002)(86362001)(36756003)(186003)(6486002)(6506007)(5660300002)(66946007)(478600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AVve3J7chK23Hh2elZweae9AuGl8NXwco1ucUcoPcMi4nK1nYk6+6szQ2XKf?=
 =?us-ascii?Q?Wo3TyL1Lkg3pHug1MONRN+tqtSRO8V8/aftXLcx8MW/QIhBxu2rarOEuqTf4?=
 =?us-ascii?Q?GcRClTVlhAJ1Js8JJ57fKhrftAs0jKYBQhuOc6+Fk2lNXOPQN0HBGMQDFkjF?=
 =?us-ascii?Q?3LbJu1mQLPaAXzr9g+xR80yKL7s606uiT9KKzBeTf/ulEPLGDiyi6s7QQFyf?=
 =?us-ascii?Q?6+kGkfhXuHXBvYx/ZUi5LkkQSq1OfDwavNf+oNJZPgKVrvUE1CrzePuTT28b?=
 =?us-ascii?Q?3tyGFvc/czD7c4qmDmTYeciPQWxQJg+UVO8yLqpj8U3KceDBpjih64+VrhMb?=
 =?us-ascii?Q?IVEI7ah5tfgHpKw/Rd4Cx6+zqmTkWq4s+g3J9vmf2gOSWqwNgmOA4RFyr0g2?=
 =?us-ascii?Q?3hNM97ebiRB6yXLNgw3+WCQjSlZyooYC5cweQuTztzTyN+rrpd4+jmTZbKVn?=
 =?us-ascii?Q?+ut8Hp460QSdYfFp6w9WB3Hxmy6BaDhcYxc7z3kIqhuh9AFjpugvR7Hw3IFw?=
 =?us-ascii?Q?f+ldnCKzGMXs4B9o6x1j42IV+F+qLqJrhqhuS0sm8YS5GgffnDVkxRi3/hZl?=
 =?us-ascii?Q?vHrAm/DFW7rlrf5ADquO4S92gEaKF6OI6Gg5AgPIk/kLCWgMffd79gW27Nq2?=
 =?us-ascii?Q?TCGc9J9ww5CnwHuUthL3+YezJPEPb9qEps8OarjzJDJypXJFkjBtpHRKxHf+?=
 =?us-ascii?Q?d0QwXk9Q2SHOQkvxPQenBlsVocxrI8FzPwjaQkOZyYUvhSGNSA50jAILXI1n?=
 =?us-ascii?Q?skmjn41gDJHN5AA+/LZRMjMnO4N+rcPJSz2fi1DZ4RzmjfUaF+1k0OrqUFSc?=
 =?us-ascii?Q?eDq6SOnqPqeHtNFYBupVupZZwmj+JXcluiW7y0kEpR8GCIUM9u0bEM3QsM+f?=
 =?us-ascii?Q?x+4snt75ljAGD0CIh/GudnJKEdk+A9qSBkjYiWBnCt49FQZabYM5A54hB7YS?=
 =?us-ascii?Q?ZSxjo61JuomPFuQzgEnSxmYyoF4bD6+8bGdS3WWbDFmogWNqDfgeam+ApLiT?=
 =?us-ascii?Q?EtLxHhkM2OKVfccsbbyGykfXAH3QHOvPltE+wjhJ51JmufS5X7ucGkSAnD/4?=
 =?us-ascii?Q?2Hsmd4dYStxQO4X4vYIqd7IdjzwABtlFzuIv5zyzki1pMlvffB/LDYpK/A8a?=
 =?us-ascii?Q?St5AYSHyrS4/YcBY+gWfoH71gse8Zx/3F7zy5itnzPim6F0WWqdlO2Kb/dOJ?=
 =?us-ascii?Q?rWCWF8HbmpEYeAWPSTT5nlqzLYr/VXMladTmc/i1KxVQv3LX8D749uKjdtSJ?=
 =?us-ascii?Q?9uZ9w4STFPHPPCe2oVemRxBS41rxKcUnmOLD5dpG024LK7FPJYyW7Ex+bshV?=
 =?us-ascii?Q?b5U9k31k2YhrOSiAg92cPH88MgS3/NEpwfIc7EhlZkDPfxHGDUt42rZi6oJy?=
 =?us-ascii?Q?y6mU68a2cdfDAybPpY1YucWGuMLfb8NqMx7pHzw/mgeBieB5w0ftE/ftxVlz?=
 =?us-ascii?Q?pagSgVSMyjaVmvgk1+xiUOUBlWI0qnC/z9Tr1SvVZV8sZjF0mHMxwkBfdLdR?=
 =?us-ascii?Q?1VHIvdIdRNVdzzj3BtVp5olKXwJE7l6B3eULksNCs6fISgjGUgN3E4h9EeeY?=
 =?us-ascii?Q?rfhilQnPAQc1rzjurW7dQtu+5YvXq8peGaG5GL6l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00425aeb-21fe-4260-decd-08da74ad12a4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 17:33:12.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAO9txaPAfIJWNmVlAnqpkJBA2MDfKtZAWdbeR8s0UFq9sJgnDvYw3Us8ka0bx1v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2861
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 31, 2022 at 02:36:21AM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> This problem is in this link:
> news://nntp.lore.kernel.org:119/0000000000006ed46805dfaded18@google.com
> 
> this is an error unwind problem.
> 
> In the function rxe_create_qp, rxe_qp_from_init is called to initialize qp.
> rxe_qp_init_req is called by rxe_qp_from_init. If an error occurs before
> spin_lock_init in rxe_qp_init_req, several spin locks are not initialized.
> Then rxe_create_qp finally calls rxe_cleanup(qp) to handle errors.
> 
> In the end, rxe_qp_do_cleanup is called. In this function, rxe_cleanup_task
> will call spin_lock_bh. But task->state_lock is not initialized.
> 
> As such, an uninitialized spin lock is called by spin_lock_bh.
> 
> rxe_create_qp {
>         ...
>         err = rxe_qp_from_init(rxe, qp, pd, init, uresp, ibqp->pd, udata);
>         if (err)
>                 goto qp_init;
>         ...
>         return 0;
> 
> qp_init:
>         rxe_cleanup(qp);
>         return err;
> }
> 
> rxe_qp_do_cleanup {
>   ...
>   rxe_cleanup_task {
>     ...
>     spin_lock_bh(&task->state_lock);
>     ...
>   }
> }
> 
> rxe_qp_from_init {
> ...
>         rxe_qp_init_misc(rxe, qp, init);
> 
>         err = rxe_qp_init_req{
>                 ...
>                 spin_lock_init(&qp->sq.sq_lock);
>                 ...
>                 rxe_init_task{
>                   ...
>                   spin_lock_init(&task->state_lock);
>                   ...
>                 }
>               }
>         if (err)
>                 goto err1;
> 
>         err = rxe_qp_init_resp {
>                 ...
>                 spin_lock_init(&qp->rq.producer_lock);
>                 spin_lock_init(&qp->rq.consumer_lock);
>                 ...
>                 rxe_init_task {
>                   ...
>                   spin_lock_init(&task->state_lock);
>                   ...
>                 }
>               }
> 
>         if (err)
>                 goto err2;
> ...
>         return 0;
> 
> err2:
>         ...
> err1:
>         ...
>         return err;
> }
> 
> About 7 spin locks in qp creation needs to be initialized. Now these
> spin locks are initialized in the function rxe_qp_init_misc. This
> will avoid the error "initialize spin locks before use".
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Reported-by: syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
