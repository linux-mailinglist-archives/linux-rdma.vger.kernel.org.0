Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AEC71A37F
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 17:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjFAP7F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 11:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjFAP7B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 11:59:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15291A6
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 08:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfvmzozlSMbqtxVDjnN29G4Wrc1KFo6mFPZajvVespHf7J7+n/lRer5qYyIe54TyspYzG37TgnIcF4pM/AjnwYN4Poa77cv7KRmQIRqrn4tkPeHP/zTqYc9ccmZb151vNuX0PAMchpjiAwvNCmzOeScPVC+DLgbYjB8ZTp0DBTKWBDjuzO5DC5Hkdm/6m8JddDOr5LZEaG/bSH1j8x+Fdt+oqkaSHmq21+cCoHWFD7Wp1cTUQwKDiyauEGkFe+HBKA8AQu9FfgwwoNrAurdxB5Z6mUzTDJIn+wtM6qGwiKwjZkaVITEGMdugPa3Kt8w933oOfzv0+axGCluzgKPVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IeivUmUIhw8jd2JDWsaDGHjqRXz13PvXuFS8P43UU4=;
 b=ECjC0KECyUIwTYFO/QZlNvI7SX3vlZiOqi+o7tMCWNnXqD0deBB+UrKTVS6qf5/C0pz2ystJ99S494hzbJDLWlrh8j1jtBKAHA5rJEKSddxhwMkWrxpgFlez1W3y+5LBC3Lw7iWltyyJICX+Vn9coFdtL9XxfME/INPhrNqHYZgBOXZCIo/pbqgGX6AWMQP9l9TyOHMccKnv4ndkZxynkldHinT845M/jYA41mujwuAvtv+rk/DwdDAB8TLofHAQZKPobGlEexXDDFI+sMLZzX6rRr2j2GRsjQzRLS/iHFWRgh+HPYk5yuWKgAdl1dq09KZbGBpTX4qchaMsZpcGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IeivUmUIhw8jd2JDWsaDGHjqRXz13PvXuFS8P43UU4=;
 b=VtIX93TiiWc1WHaLceKUnvCAD0gBILNZxLT6I+KDIFqmudJ+tg94JR+70USd1o6Q0FTpn1hz7VCjlRABfisphu8+Hv6JnSIIsEdHwA6LO6WoU3RvmWaxtvIVVdTk914xEYbg3lDLhpO9JrMVs+r3eV75BveH5PIgFXhxsQTg8chqvm4s8pQkqfH1ysSbXdJaqNGWoJ9z546/ss6IG/b99w+fpYH0b6u1Y68eU8+C4s7LmWOgtomHSXHv6s1u+3m9llleiU0PMXkdu9/n0v3Z1a7buAMIHee305Jhbqp4xPBH9e8VcJqg9Af9pNxjMtJiAZJunzVm8+3Kg4JxvGZDNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 15:58:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 15:58:57 +0000
Date:   Thu, 1 Jun 2023 12:58:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     00000000000063657005fbf44fb2@google.com
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix the use-before-initialization error of
 resp_pkts
Message-ID: <ZHjAPwKB/si3qJSb@nvidia.com>
References: <20230523054739.594384-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523054739.594384-1-yanjun.zhu@intel.com>
X-ClientProxiedBy: SJ0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:a03:333::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0fa6fc-46de-48b2-e258-08db62b91ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUY+pO8DgDatzNIsiYDwPspk5bOkLOE0OhWv+1Oh94vKD/bSUob4BgV5OJ/fMDyxjhV9mAMVxGDZUsaD4t5nJn+XG/h+wOfNUJYhqIJf9VWdqrANUioO6NOwW2/ykihwh59D/1krfpU1QJey4llaGc8nuN+O67IAsxtCY0++RHnL37yuoJ6491imAwmu/+gPBC+lSqzZUcpI+s3FbRguV3cWU5WM/kfbyWPbQgnsG5vou0wTBOuBISsEugji1pXT+tW2DIfmHcHoxriaVu2r57Yh0cSMNS93HKO6v2B9s2dpa17jfD4zoqnkzpmyEXLWMan5hqsM/BrU99AIdXA1cJwJk5QRwlhXwn+w/v4qKKcIFHz3d2IlXU71ZpywWvnuRKIwINPx2AiuAwU36Qfi2BkfrNuJAwUv3vgZScpgJdWKOdY/R6NNtAneEfGLK12vyi2CXJt6ehrm0WdzQtLlgNu9MeqmdPDHqS81YH1o9+fHDcwbcGLHKIhyBz7Nsb8SfIyyIKTeJQhfCqzw8f/q5brUF8NqPWfQlMuwyza53lOPoocK2csutqrym3azWqEo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(8936002)(83380400001)(186003)(2906002)(2616005)(4326008)(6916009)(66556008)(66946007)(6486002)(66476007)(316002)(478600001)(6506007)(5660300002)(26005)(6512007)(41300700001)(8676002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TExJ+Mm69hVtwoh2Zutjj0edXjloP8CO3mB1yC3f70hG7oyKj1GBPGKGygqw?=
 =?us-ascii?Q?PgVaHvWAR/CZ5dq99wo9VVvxtjmFoJtme8mU11sqwGIxHRRiD/r8U3M6qTcb?=
 =?us-ascii?Q?AheEawyjEiNbxal+q+y3F80S4o48aypOHYcvMb4AeXFgWZm9Btm1RyFDfso2?=
 =?us-ascii?Q?ux4FHk1LcAOewa2SU4UtzyJZFVbTF7JtmBHa03mxF1TEPLwsRZmEOOrba4Qd?=
 =?us-ascii?Q?1eh149m66aWjjNFZvP86gVO0DjD3W8mwW2dKPIaS2oCq+uddG0A3hg7NYd0X?=
 =?us-ascii?Q?cYMbl4wQzBHNxpvoHONTRRwSKXJI6J8pveXKrEpXh4sCWSV6jdIiNg/qosBe?=
 =?us-ascii?Q?hVrxseqaANGscvZFViUWhNfc4ei86aIait3kHRtzhaCh2diWGEe2o2Rgw2qr?=
 =?us-ascii?Q?IUFyQEbr2VIleHamDbp+zEFBBdhyPG+X+IGdZp/xhEHf85dkg11ol5nUHcjw?=
 =?us-ascii?Q?X5Cdhr2mW80T+7c+vM4z8prSk9FnG3suWCjoMdXEPkXilzWlpnY2Q7nrYR++?=
 =?us-ascii?Q?TIiJjMaW2iTyt1bagdcmfptBxI0gMUlQOooACRTrhfUydnYUkV/Io8n+4Dbl?=
 =?us-ascii?Q?BsD0go0DiPNrNLSZxcf/Z0o4eMbjNMsmkfUka52NGdQApEppDfCSYAzE5bgd?=
 =?us-ascii?Q?ZlpYyUbDacdWtYF2lJcOl9M1cwvgGIRkoiCJQd6KAcNULaO2aDQIVU6T9svB?=
 =?us-ascii?Q?/6Mq6gs1cTdiL1UOxUIa7L9+mBTEEsv6e/CRdctkezLOzTsJNnVfANEk6EPv?=
 =?us-ascii?Q?HxmJWVvY4Na52lmDNT2vlBMr1u2nDFkL/fqVEnRbftIxLJkXzJYT2v+5ezlM?=
 =?us-ascii?Q?I1/6nwLwty1pfclQoSwfv5CTUzIe8rPaVE1F0ZoeYAiLdfLzBcNLn/m5uuno?=
 =?us-ascii?Q?MrtBY09/oxW+7jopA+BNDw1I+aEnvavPrnKyTJYl/pb5XYlruM6S48Krpy3x?=
 =?us-ascii?Q?TU0jRZ39aaBwYD31+E2z0pCj5c4Y0KYlvZuNur+0hm/K4BdYdoXWKCDSN7Yj?=
 =?us-ascii?Q?KmgobsvFSJsCAX6yv1wsr95auz52w4ZN3fqLSnza11E7TG+RTV43H7UBQldx?=
 =?us-ascii?Q?txtpYcpyye/xVPsnkDCiCxwj1upxHrB7lVpCa1nRG/MUHwzQllkHXCPnb1Ip?=
 =?us-ascii?Q?ibE7pyTFLqCM5dfYjy9TyEX4iILJkHPccbA4g8HT49a9sL0MxXmVwzDohKvc?=
 =?us-ascii?Q?ybiCP13Rw7p5oT8pNmynwtUW7M/VLyV2xWpO8pElM7ajggwSlDAPRnPU3D0q?=
 =?us-ascii?Q?8duna1YbaSuiGNR4GjaEzJ9aTnBJB9zuxEO5h+NUfB20M4DRfxUQbleL0F7a?=
 =?us-ascii?Q?RmWD3lol1SJTB6oKbs81n9sts2V+hfgdljrPubjI8yunp+Bho2W5G4ek5wFl?=
 =?us-ascii?Q?rCf1Coc6KMhOQosQzy1b4zQtF2OAkuf3HaQsg4C5FZjOtytlpuRrbLzINcXG?=
 =?us-ascii?Q?EH9jtJG41rSq8hlHXr1wE/nQWekBBbc9pFs7OrabXOLBvkaPCWLHkXOnrIh/?=
 =?us-ascii?Q?OIFn6Na/zfKxK3s1yo7ekV8Q4EjE4xR2mJFPte+RK5/xksnqK4y/W/a4Nfp9?=
 =?us-ascii?Q?H9qVfC7MkwqkZxKztKKYw8EPQzJhzTtJAwmsectS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0fa6fc-46de-48b2-e258-08db62b91ba7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 15:58:57.7797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N7scg/0t7prddBiRwttLsr9tyg8I49TkeMqH/oiecsUE1uualAqTUahpqjDSDOv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 23, 2023 at 01:47:39PM +0800, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> In the following:
> "
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  assign_lock_key kernel/locking/lockdep.c:982 [inline]
>  register_lock_class+0xdb6/0x1120 kernel/locking/lockdep.c:1295
>  __lock_acquire+0x10a/0x5df0 kernel/locking/lockdep.c:4951
>  lock_acquire kernel/locking/lockdep.c:5691 [inline]
>  lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
>  skb_dequeue+0x20/0x180 net/core/skbuff.c:3639
>  drain_resp_pkts drivers/infiniband/sw/rxe/rxe_comp.c:555 [inline]
>  rxe_completer+0x250d/0x3cc0 drivers/infiniband/sw/rxe/rxe_comp.c:652
>  rxe_qp_do_cleanup+0x1be/0x820 drivers/infiniband/sw/rxe/rxe_qp.c:761
>  execute_in_process_context+0x3b/0x150 kernel/workqueue.c:3473
>  __rxe_cleanup+0x21e/0x370 drivers/infiniband/sw/rxe/rxe_pool.c:233
>  rxe_create_qp+0x3f6/0x5f0 drivers/infiniband/sw/rxe/rxe_verbs.c:583
> ...
> "
> This is a use-before-initialization problem.
> 
> In the following function
> "
> 291 /* called by the create qp verb */
> 292 int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp,
> struct rxe_pd *pd,
> 297 {
>             ...
> 317         rxe_qp_init_misc(rxe, qp, init);
>             ...
> 322
> 323         err = rxe_qp_init_resp(rxe, qp, init, udata, uresp);
> 324         if (err)
> 325                 goto err2;   <--- error
> 
>             ...
> 
> 334 err2:
> 335         rxe_queue_cleanup(qp->sq.queue); <--- Goto here
> 336         qp->sq.queue = NULL;
> "
> In rxe_qp_init_resp, the error occurs before skb_queue_head_init.
> So this call trace appeared.
> 
> Reported-by: syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>

This needs a fixes line and a link line to the syzkaller report email

Jason
