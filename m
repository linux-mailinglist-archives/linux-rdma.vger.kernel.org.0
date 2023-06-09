Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8115572A0D9
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 19:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjFIRFA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 13:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFIRE7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 13:04:59 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EC01BD
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 10:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlg3uwM256jMdqav4CPgDnzRVjnD7Blb9uwE4eddDxBvjUIDvJazGFEBXQt6hf7yxO04ocZc62H7bChB2uRqDzM60PdbQK5k/84UI0tD7ZXrB2cZNGCZArjxo0/O5G87baLJchI1HjFqkFzmh/faib9orjVl71zGCW8goRAIALpnSs/GnmCO8nGjJsHIHKxoV/PjGBuKNuggXqlXV1EiUrA2GKZR6kZ8tza0XAU5xwOw1iCfY/IIvb5Qyi+vD9uN1lYTcynespPEBhIcXSidqc/7CQke/yz6ZDhJEMFFCqLai1OqXTg3rnYTbicI0uIyyzRYWjoRB+2jXexBFiWg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC3j9wkf1gNdMbw3Mu3OMVoFeHSSOTNpvenwbLvqVDY=;
 b=VQ4fLtujVVLxFCOiFh5xuuoO6qSaCnk6bg9lFPttLvWW3wyLVWu6xK8iPlvEiMFSMBet9waWJll/BwKNpAPn0GA0OvONt4NOHEqSKEoT1TG3EMfFBR952M903jfc7QDjpE/vUCy1fiCwkIJ9PfuOkSB+Acazeh6rq4021APTHyvqn//MBVSNET4g3kob2xHt14mgdarPbgUWkEY2xOqtmmCfmEDsEdxnpD4zaLCrSfcw6Z0dwe4V5welhaKzpiSE8IS/aj4VWCJ1Cthhq1tQvpVamugPMtUWw5sTtg7iE2Eqs64jFLzvwrFwLjTTJhr55Trwv3QNIY1vpUPlNeYcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC3j9wkf1gNdMbw3Mu3OMVoFeHSSOTNpvenwbLvqVDY=;
 b=S2fwXqcpaZ+Yzan/M3QMUJePxdIHhZRkCMatPKEY4qQEVQDYN6o8qSv9ZeTjurq6f3HRy7tKbc+e0j+I1sZRmvKqwxW/3z5nU7oBaRAw+z/uO05QnIjK75hWO7XXbBkSFkP2/ampCOAHT37MPD70jsZ+k4O9fFmuotRTI6QUwfdT0+HY7Qe+uUgdry/EBmXlpjk6yQQtMcP00SksKQqnLrC4jlcvRbM5KMEbm0KNQFfMgS7biXbxfnfD0x+8oz6+u1zSujcksm4FpvVdFsS380VGDPnVKPdDjBkTAGL7Qy+Ci1xoolCvvEqP4hyi9y2y6lHwkUG+azXxxi9lNIrd9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Fri, 9 Jun
 2023 17:04:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 17:04:53 +0000
Date:   Fri, 9 Jun 2023 14:04:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/1] RDMA/rxe: Fix the use-before-initialization error
 of resp_pkts
Message-ID: <ZINbszg48aMRrbFP@nvidia.com>
References: <20230602035408.741534-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602035408.741534-1-yanjun.zhu@intel.com>
X-ClientProxiedBy: CH2PR14CA0045.namprd14.prod.outlook.com
 (2603:10b6:610:56::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: a901f778-7324-4cb9-d344-08db690ba4b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZlI3U6FxwzFVHER9KU2ymeARJDElwjJUJ1IJfub5SB7QNR7wD3z+hli7XBKupwyCjbn6vBRkyrjc3rAvEbuvC4GKMCjdiqCxJ64OtSJXSiV+xG0TM2n6ZHUiD0+EceKrXl110GYim4GRQkCFEVdzSlmMYzBVUGmIi9tefMpxP5xzmOOMjyfKqK4HvcCgJIXciUv7IhqAE+u/O0uDSk3G+Y17UF7i0PeR1CUtEkmTdodApKlKkzjYgYLIb4KcJFXYrP05vfHQvVJNLUBUw6MkBzqWbYYc0Da39letc9L546qO6v8wkwX+Gpw5nUrLZrismMGBIvo8KY9t/MpVmp0htKA0XiKeU/UbU9yaD3Psw8Zd4GIS3nHUfz9fIpgo7a0fXOH3hwPfSeuvA30GuvMi4O8nmFcT8MsZCG1AbTTfd68MkCfBXkzaKfd1HKNfd7vmuV03f3p8UgGJ8o2CIGZCl3nURlvYGJxcnM57L04dPv7hdpE9JUox3Zg/Pqwro4fp5iFpdwEXnSSo9ExRoKC8Luiz4DZfUnFPMNQzyq6OktNWWv/uirIrbO5tZKbHNW7xF7jyDAdeQAgeo3tqyA97VWQ3OIQPPfT1rLRdFx/MWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199021)(478600001)(41300700001)(2616005)(6486002)(316002)(966005)(5660300002)(66946007)(66476007)(4326008)(66556008)(6916009)(8936002)(8676002)(26005)(6512007)(6506007)(186003)(2906002)(83380400001)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZOLAdQBQTV6/oODNNRNXzDRzibMtM318pjyzDAlPCYKeaq5poBBKIGJ/EdXg?=
 =?us-ascii?Q?H3FwPbvYcHlEq2Luekdv84SAxGSBjh7J+O9lC/gOIG9fbtBE577v0hFhTcrF?=
 =?us-ascii?Q?YmI9c8g6g98uVE+siELQnU3ivfm0jIHjD3u8zoQjaIPNNm4e/scfqJnJZkQe?=
 =?us-ascii?Q?OhBYhXH2Mmic7xRDm407hLWvLxs6iQomyCv8Wytk30Rl85YYaOH94hVD0WJE?=
 =?us-ascii?Q?KZaeL41d+CXr549/vf4iizSWUmN0qUMeiZjyZtYInpbOb1YJf36woRn3AvA/?=
 =?us-ascii?Q?uH/XuVfl5md+6Gog798nI4I8dq+uyYtaYM3CHLGoFaOd8siJvjWhoSKMuRDx?=
 =?us-ascii?Q?4Uz9s7VfV27aUuHTJLtm7XIBPHFrGPSqC6xpSSxBCsDT0cyFdDHBiPO/wsUJ?=
 =?us-ascii?Q?Nv6SimUSVUxUY/OGsKxjzUjK0vNbqlN6HEFNkgyo5jAT2+GTzq+aVLuMaixH?=
 =?us-ascii?Q?uTyNcvKqje/Cca5vmhBt/PESh/QX1thQ26HmZnCLjdNAO3DVuxKRDGqua9Gq?=
 =?us-ascii?Q?zU9ZigDZKCo+d2Q247qa8sVfS/+3bS/b6ab1+afQFmZUdhrpUDAxQiq1Qoiq?=
 =?us-ascii?Q?yklEM8tgkdEXPxgKNM/k75ad/2SeOCnoD9KKWCCEwRzqcVDWQpXpRoTFIZ2G?=
 =?us-ascii?Q?RPLbZS6xoVM/eGdps11vZ6WdbBUiquXVKwCTecPibY1fjpDEPpUknwt6IhmK?=
 =?us-ascii?Q?E0no6CBCkJhXqKLUWoq2aNBp2d6hnDC+zdJevSQqFLF3MXpKYR2EQXiQ6V0T?=
 =?us-ascii?Q?U/v1pLFsb6uHAX0bop9YYcRDQo01tjcK5TXE6Zj17iERjpLitlXM8UEEu1IK?=
 =?us-ascii?Q?Nmcj9TYwEza+lgf587Kvl7QQLgFSogX/NzgEiCjH3y2UyuNuAZjp4qoOpjzY?=
 =?us-ascii?Q?qT8zWArTs9vhlo6WEGEJ7rbOTDbHqqmwkGWW/hD1a4ihQ5yGmZvEJRkt+SqQ?=
 =?us-ascii?Q?ktmrKnX7IuXhUIHXM3yoHvESum2MtEU3ONv1f1PJVL+MiIwR+J2oX3cc8KiM?=
 =?us-ascii?Q?pCB27D8QLBIxPAHj5SpOlLJTblT3xijf34MGOGXkIchsVKQsV5jHpoQQvL6m?=
 =?us-ascii?Q?C8lHAgFJDyeIXmRks6kwLSK7JpUvb1avhisWBEPNTm2HmMVIe0Oha5rt4KL6?=
 =?us-ascii?Q?yH94s7+Hz7jy5REFwpf4s7dWHvFCNhkC9b3D1uvDfAfLHHEUkB+3Jkhw//Tv?=
 =?us-ascii?Q?JtGA7LPd3/WwkHBplulplUiYmY1azh0DU9r4qShNMinN1j40GK4qPYuiAnkb?=
 =?us-ascii?Q?rT4M/Fbmn/huQKDC4JatEOaIqUtUXpCa359y/DIBAfTJYoNr6fZEPR3TmMVS?=
 =?us-ascii?Q?gMsfgouInXdn2QImpWfbFhTNPCCAOhe9sVFfPWGKe8YdYyh6P93QKxkg4QTJ?=
 =?us-ascii?Q?TDIllT8obVMNb5ZZhWXVjzpiqW7CTZHDsDll7Yz07VvXUmsocSh+REV+w7N0?=
 =?us-ascii?Q?yZiuEvQ/qFWO600j8MH2NyTkLAH46htzhX3Zv3ZLpq+Dj+KElzRIpZJpPTtc?=
 =?us-ascii?Q?4lso3EkJedf8hFTchDbHmnUyV3BugTgWaGW3SZqlNQc5oaf8h29ZSAZ++2iU?=
 =?us-ascii?Q?xn7XXvn7But8DcsUP7HU0GYOd74yjSlpp8LbcPfS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a901f778-7324-4cb9-d344-08db690ba4b1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 17:04:53.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1GloV/m1hlvq8FO6Y5PfXUaSy75jbM62LizOiEZwwCjXuNUQ9aIWEpOFHhd2IDT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 02, 2023 at 11:54:08AM +0800, Zhu Yanjun wrote:
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
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Reported-by: syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/lkml/000000000000235bce05fac5f850@google.com/T/
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> V1->V2: Add Fixes and Link.
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Applied to for-rc, thanks

Jason
