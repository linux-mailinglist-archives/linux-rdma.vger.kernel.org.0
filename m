Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976447DD069
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Oct 2023 16:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344396AbjJaPVr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Oct 2023 11:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344717AbjJaPVq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Oct 2023 11:21:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2D51FEE;
        Tue, 31 Oct 2023 08:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mURESrwhrGRQK4UtY7Vc1HjK3qUW8jzhhP9/r1G8fxGKJmmm9J4lno09AGMTv9UAZv6gAKMYHTphKN+4h413dvLwOAoPQ9p9DRF/C59jP1fYeppBymhcZlnnapo9FWnyh2HwsiBslnudBmZXXvhg7FEZ/19fl93Xmm6EKat0D7N2EG1SuS6AuEswz8uO9X7cRxk7ndCm/WoToichfubRnrTovJ5gIS2+iGZHWl4XwV9hUq237/KS9hbf01Xbg9N1W6yqZUYVfZubRVnkNSZu2RdtyjrZUKPOCfMl3G8oOj/2Lz6VGneSdXXaU8f4nTFJQFxAdQRuZLw8I35H3Zi4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8bpcT7iMXcPZxilQeyqxw+Vfi7N3wcdf4r9oHu+8Gw=;
 b=K7ygF1TL//rF8SgLGigN0cgSEIfHpN0tU5+h8q48OFItxTFQ1wCO7mkBZj/678Fb58NxJuoDQckaN8g0vjYBiVdzadDFKL3GNXegk8AVyGVBTyRpXYFVgrBD8MbgxfTQw97bAbalXCl57ZfE8Ygb0OfrUDwNwdFgHXv6LAvpkz6EE8tBII5N5zchttoXwRwZtI7KWLV6y2YYXK/FjMD16p5LKmw86Ot3yZ68IoTseWKZ1MZI6uFhhw+Od1W3arYN4+ofEScuqM8UFAn+qqV1yk64XW1MlTe0sdgQuR2+3ape71EQqK7aOgtfEpxEajzzlzlpxFky0XKh+GjRfb76Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8bpcT7iMXcPZxilQeyqxw+Vfi7N3wcdf4r9oHu+8Gw=;
 b=iS2gfuJiYFdoD/ZxJ1qBTmMqOcQgBiknumPuIM5UDP+F+koSO5n8o9BGYLh1kxSs3iQ9PGGAYk3vP3uxCsWHeWjonlBJ55ERjFLhQcobbrulntL6peMTcplEUzWQjmHd0jZtzHTETLtgox8onI3ebAWquEA4oLpIWFXQtBrPSRnscIjEYk4ZGNBOEgXtLstZLNF9OEY8zPMIedAEbky6cI6x7BUPLxXVhhh++G7X+nGDIyuNi2dJuNe5giioMdta2ugNT8RvEz/KuJXB6wOgWFEwyWN5jHhNMYJL4GTo7PSR1T8b3RYbw8oAJy2Xmt+l7KyiVoRWVCLb6SyXbW8F8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 15:19:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 15:19:28 +0000
Date:   Tue, 31 Oct 2023 12:19:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     leon@kernel.org, sd@queasysnail.net, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        tom.hromatka@oracle.com, harshit.m.mogalapalli@oracle.com
Subject: Re: [PATCH v2] mlx5: fix init stage error handling to avoid double
 free of same QP and UAF
Message-ID: <20231031151926.GA1849146@nvidia.com>
References: <1698170518-4006-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698170518-4006-1-git-send-email-george.kennedy@oracle.com>
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac5c792-d062-42d2-336a-08dbda24c5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awji/jgqwKoK0hqFcwb1jp9XHmy6F9kA/NE9N67SARB4L54YTy90QtgDJeN75/k52vjmvB5BS70ixs5Z43182qOL0VofIPDoQy2DlrwzEVnT7OqFXt4fXaJ27H3l04E1MX5bvTj9v/ZViLIc8kcSo6gDvHJY9gXgx+Cw7t0yZrBAUewikkA/pfj/Jm7s/DlF5bvqS4qLHdaOSGSuhGVD1P9KCMGDJAJOc9voDKfVhKFWp2Saep2SJp8bukGmHJW/gwb41Y4CeqziToAZvjd7evS7ZUIn/yD8LaaVoIOLKMsnt7hz70KMdkQSB1w9PTt7wLDNC605Cxy3G7RQ9/bz1QAjj6HUoim3eDI3WWjfEggj7Kgr+KbnOK0YyORTxafwJhQYCmW7Utl3n44L7TRcF5+yAFpmT+A/YzqG7JnkLskJ5a3Mx4N9n4vkd17uJWR/wZBRpVU7LUc2GnoTUtBp8W9CgnEY4e4hJxmEUC1hL0HjJESxtcTZpA65ppDoEkAIStwb1Tmu4bwJHp95aYlzRV5aOuzCdjML4hUpSNCSSbKTPqf+PpF1JN6c3NRRqokd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(1076003)(6512007)(478600001)(6506007)(83380400001)(2906002)(41300700001)(5660300002)(66556008)(66946007)(66476007)(6486002)(8676002)(8936002)(2616005)(4326008)(6916009)(316002)(33656002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JWiqcMPHoBq5f0sumxT1ISQmfwNDLeZdr6b4PsHCYBpBgx5YBln0Z3006dFX?=
 =?us-ascii?Q?XPS3q1UUzLNVhfvRBCwZhC0ebA3nPmiYVnnciAaEpBBcJ/J94MrEGIW1mgza?=
 =?us-ascii?Q?8qUd3pWy/cnAwD6muTuLUyuNpaBP6LX/cDeD2p4rqi7cWw/yEqEwwQuupRPp?=
 =?us-ascii?Q?oZX52WWJ8W2U6N8rt1JgUKEfg3m46hUU2Ld4Hhu938ydxsB8oGWrVZkyRsLR?=
 =?us-ascii?Q?dwp4DKDd8rTx3Yl6d0CaZwROwvEp6dHvwOwUZ9h965nj42lRsBRuIzl5OSnN?=
 =?us-ascii?Q?ou4vjJI1+JOWQVaoLYBaiU3XTdFRsA7qaAg+U6gD81xfK4tWt7tH+ejFB/bN?=
 =?us-ascii?Q?wY0bvKYluENDJFOjt2u3sfP1O9B/Tz/mh3E1vU8zwhH5ADg2c0nEEctOxza7?=
 =?us-ascii?Q?6i++VMco/Af4FxfMvRki52dUznEDB/4Z4quM10AeKN6f+BeSLdw4s4RyM4kO?=
 =?us-ascii?Q?uD1p4751QXlJlywLW0/nnT1l+7PzO0HYw3s7du0zwaKtjDuVdzgBABIH/xXJ?=
 =?us-ascii?Q?v9QxIz74JkDw5X0aFYJZEMUUCFNeMyx+EHgnxPYxLgqLhcrYtf7be3QHhVBN?=
 =?us-ascii?Q?woPZt9IK1v3zrjvJolthm9LpBpnDxhrWq89k6xEQLQCPVOpMq9Xwvuq0omPO?=
 =?us-ascii?Q?6xjFD9BWzFKbxh8O58tiRO3wJrRLmBW2i/ia9OJokBxoelA/pyi61y11lZLi?=
 =?us-ascii?Q?7RyiI35asdtNTZgdtAQNVa7Gaz0b170ae0Ikk3MA+kArRecQaCMv2fXGxkz9?=
 =?us-ascii?Q?xlRQs8LHnXwp/qdx7w+vT/YiBB0HQtXZ4+cR6CSCedWBIjMW/IXWbjlS1O2E?=
 =?us-ascii?Q?wgW7peFpsZIAgNinRnzzyn27nWCKgrZ0aL4Ie+LjGahg9V8gHX1RCOIDLGhP?=
 =?us-ascii?Q?kAZ0gGUzuuqz46HrK3FtAf2SObvR1aHmBc8yALzftZD0MqWNsemybzYQADgn?=
 =?us-ascii?Q?P91qTtmjvfKDWddjLOIdIkGwcjZpiXL3gDpa4eR4My0D4YCUDL2F4DrIiycL?=
 =?us-ascii?Q?xbSp+3vuIYhAdTAn8iNHGtrdnCFyD7NnXDVcPqrArW1xD7j3vPeJBko0k7AX?=
 =?us-ascii?Q?mvXwW14az8789bcBXMexmgrLNIWWZfqRp+R07ZaFr11nKChtophJJTYg0G6R?=
 =?us-ascii?Q?2ArlzvDEYxLnm6W6f7ArgsXuxVFzt8zbDVOMhwBBOjvsIPMLqPpR6oiGwqMi?=
 =?us-ascii?Q?Pydl4+zljEvMT8jeT4NG5jjxZlwNoe3U9SoY/AZQj295w+yj12xNCudRugRo?=
 =?us-ascii?Q?+NGZSpw5GiqTkYtT/WocJpYQv5p8sqHZGiSsJfOOBv1KoQROFbvjf60hbF6T?=
 =?us-ascii?Q?7eyJDlXAtcmH/b2c6VjFvQ/7pIl1S0cQ4bNHdofQFfS4FkOaIk2D0DVG41Wj?=
 =?us-ascii?Q?lrxM6gHiDfkDMhhd/706p5bwjw97v3juAbcP7x/NeamKunxQTSw6IsoHJBpD?=
 =?us-ascii?Q?mGvkdxGgqkoBT++g4bkiGnMmpl1h8ZxFaDxsvWKVwggzAycDfJdV6O8jGDYz?=
 =?us-ascii?Q?q7WyDRyst3RqgcyvRdLRVSmYBMr5qPhGJI/ciDW+l4zTVFNLiYFnGQlj6uWA?=
 =?us-ascii?Q?31ahSDirNCa3p7nzF1z4vqfdlFlktxusr3848yff?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac5c792-d062-42d2-336a-08dbda24c5cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 15:19:28.5498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1aQx0ocCUtpfxmeJ0GrYoDTN5Ult3rNG+NilfqmCuqMfmmZIfrHgyjLpTXqjYZ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 24, 2023 at 01:01:58PM -0500, George Kennedy wrote:
> In the unlikely event that workqueue allocation fails and returns
> NULL in mlx5_mkey_cache_init(), delete the call to
> mlx5r_umr_resource_cleanup() (which frees the QP) in
> mlx5_ib_stage_post_ib_reg_umr_init().  This will avoid attempted
> double free of the same QP when __mlx5_ib_add() does its cleanup.
> 
> Syzkaller reported a UAF in ib_destroy_qp_user
> 
> workqueue: Failed to create a rescuer kthread for wq "mkey_cache": -EINTR
> infiniband mlx5_0: mlx5_mkey_cache_init:981:(pid 1642):
> failed to create work queue
> infiniband mlx5_0: mlx5_ib_stage_post_ib_reg_umr_init:4075:(pid 1642):
> mr cache init failed -12
> ==================================================================
> BUG: KASAN: slab-use-after-free in ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2073)
> Read of size 8 at addr ffff88810da310a8 by task repro_upstream/1642
> 
> Call Trace:
> <TASK>
> kasan_report (mm/kasan/report.c:590)
> ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2073)
> mlx5r_umr_resource_cleanup (drivers/infiniband/hw/mlx5/umr.c:198)
> __mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4178)
> mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
> ...
> </TASK>
> 
> Allocated by task 1642:
> __kmalloc (./include/linux/kasan.h:198 mm/slab_common.c:1026
> mm/slab_common.c:1039)
> create_qp (./include/linux/slab.h:603 ./include/linux/slab.h:720
> ./include/rdma/ib_verbs.h:2795 drivers/infiniband/core/verbs.c:1209)
> ib_create_qp_kernel (drivers/infiniband/core/verbs.c:1347)
> mlx5r_umr_resource_init (drivers/infiniband/hw/mlx5/umr.c:164)
> mlx5_ib_stage_post_ib_reg_umr_init (drivers/infiniband/hw/mlx5/main.c:4070)
> __mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4168)
> mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
> ...
> 
> Freed by task 1642:
> __kmem_cache_free (mm/slub.c:1826 mm/slub.c:3809 mm/slub.c:3822)
> ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2112)
> mlx5r_umr_resource_cleanup (drivers/infiniband/hw/mlx5/umr.c:198)
> mlx5_ib_stage_post_ib_reg_umr_init (drivers/infiniband/hw/mlx5/main.c:4076
> drivers/infiniband/hw/mlx5/main.c:4065)
> __mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4168)
> mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
> ...
> 
> The buggy address belongs to the object at ffff88810da31000
> which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 168 bytes inside of
> freed 2048-byte region [ffff88810da31000, ffff88810da31800)
> 
> The buggy address belongs to the physical page:
> page:000000003b5e469d refcount:1 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x10da30
> head:000000003b5e469d order:3 entire_mapcount:0 nr_pages_mapped:0
> pincount:0
> flags: 0x17ffffc0000840(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> page_type: 0xffffffff()
> raw: 0017ffffc0000840 ffff888100042f00 ffffea0004180800 dead000000000002
> raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
> ffff88810da30f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff88810da31000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff88810da31080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> 			      ^
> ffff88810da31100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88810da31180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> Disabling lock debugging due to kernel taint
> 
> Fixes: 04876c12c19e ("RDMA/mlx5: Move init and cleanup of UMR to umr.c")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> ---
> v2: went with fix suggested by: Leon Romanovsky <leon@kernel.org>

Applied to for-next

Thanks,
Jason
