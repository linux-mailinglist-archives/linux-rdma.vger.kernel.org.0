Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383B9648943
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Dec 2022 20:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiLIT46 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Dec 2022 14:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLIT4z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Dec 2022 14:56:55 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70336B9B4
        for <linux-rdma@vger.kernel.org>; Fri,  9 Dec 2022 11:56:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdLmo6Vv2nWmI8Jg3gz3J+svAFPHcJzUb7xpsxMQ9RcFFCP8mZsJ4CGD2ouGj0SU5D564CqDD9iQCSw+9iKUvb0yp9vEUnOF5yHk7glNZwH5PCUxzwm+lhVStbLZxgF5pd69fQFkxKsml+NZIUoNjMZ79Mp0v2Z61FdS31B9yfZEJIKZ/Wz5ac+VOXrrJyynx4+JSBQf+4bh/Sq5u2qjt21jkfkVIxgvw2X1CbptrSu9r/L4h1hCbOuBVJGDQ3PgrQhE0pzjJIbUk/WxCyVa2qr0RukIXEndpDj5j2p0FsIpmEZns+5nZCPt9UH/rvvDlouGDXxsC+OPmlQ1JlFx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFtCqHcu0BOO30BVA1VLptK3Y4jsqjzVnevb4GO0FEI=;
 b=ZmN4VIv5wXL+/TCdcory2agMdGIGcywA7fkVX4RqxseQ0vgMJr7aOzEEAUsKZhuw/tRs8NUBb1UYZ1bh7dABjvzaYr/zotiya7C/Q5Y+c7CSH2/zmqaaCUoVXJZRSwhexSUnbKEiioC/lYfiGzxbIaiuuMXP+DVGmAZ/YrWA4pQFGhlHnUDoVBRrq4QcpWf6da9cI3B22X1eV3v/jO32C1zze1QvzsS2NrxN1NVgf4RMT2P9P2ih3iDNsvWRkewPY8ZzBPGvIRxsNEbaWToBubGbh5w51QZY9Khj4hHeNlYduZay2VV7Pd8mfoUBc62pocDXtkkMy1QRBbW1cpJu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFtCqHcu0BOO30BVA1VLptK3Y4jsqjzVnevb4GO0FEI=;
 b=XQxGRu2f78AbEQZZgn2B0LQPp/XlP06z7BfV/i/+UXDdT/ynF6b0jtzpy2C4zg2joQnKEqDGo6cD0rbMe4jEGn4wXnxxipzrNbRtGDOp0H+IBxJC3UDU7k12EVLVmMcZI8deyufFgRv2ewdBxWUv6uuAwxPt5Qk2Z9EiHSHR24IyXdBQpiZlHPWY76lNr2u46rL8zO1dCu/07CCaUcPrTxACOXm93RdiBQfWzm94z2KXmLL/BIyTMtPLVRD3DAv+IuVkRLXiYH2bmZlkA3cKHTZ/4oXvW8rDz4waoDEz0kBrkdorNHlS+lObCfBpdsZdpAUYqNLCTJlWYq/tdWUd7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 19:56:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 19:56:51 +0000
Date:   Fri, 9 Dec 2022 15:56:50 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        zyjzyj2000@gmail.com, lizhijian@fujitsu.com, rpearsonhpe@gmail.com
Subject: Re: [PATCH for-next v2] Revert "RDMA/rxe: Remove unnecessary mr
 testing"
Message-ID: <Y5OTAn4KleXZUMea@nvidia.com>
References: <20221209045926.531689-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209045926.531689-1-matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BL0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:2d::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: a3280029-93cd-4cb3-493e-08dada1f83a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGNNGayZQ3/mPmqUghXqEaGit9Pzfhb/7cK7QqXt/VW6HR7HzcJcc1TUEC6w6ZoND7xKDkF9bQWHwPd+QEjvdUJmC73bkj8EtO4bwUV4WOOSyPN+1iHbCeh+EBc9DQQVL48UyVT25bNu9U1+TIJK50wf6S18+HrMIyLny2Hu+LACrBR8PL4VoqUBcvwbcStr78JUHrE7NNjhIkm9bx3QDlp7mFwGYDv7VNsPg9gubJVBpmcIRFVYhAm8+jbZ36A2QZS6f01bM2BqkKrV6aCFVrwEo1W9VI/sD3AF2KQEL1zo4Yn1wS3DMeQNyeyApDnAWb/Qi9NgvFECmxR/Ye36QYF+OQ83F3p7Oc5aRKG+/+Aknp8fm4qkvlANsC6MvKAGiWBw9N3zDshT2tdEMCAJJeDxQQmlv/Vb+q1WWhpqWC/IXKv7TrqGClsmamQH9jLnQvuzRxtAbNqtxE1BQCVK0qdWwduMgwG8FgBxvAtX0+wshTp9sArXJfw/p5TYjjDz1NydcTFdsFmkVk9qV5lqk4yuq+I15WjAlGMh0gfoMddAIBb8gth0dK3QKMPMmJDkTLbVxwPuaL6h5MSPa3bAZI9b0VJv6veU+XVg/C1yVAMmQscf1DrQvvDgmzjjcoUTpIEh2V3yHh7zEq2jMgvUy6GwMLlp+55spLGkMu6QUONqfE2fTv30x13lDachAdqcDC4XmRx5g4PIzX4KCfSWxcJft0cf8A3FpKDk9WUaeB0Ti17MY6Ke0/OGw4xQofJ8N0ZO3OJ2vnT/xoPtrRhbuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(6916009)(41300700001)(5660300002)(6506007)(186003)(6486002)(8936002)(966005)(26005)(316002)(38100700002)(6512007)(83380400001)(478600001)(36756003)(86362001)(66946007)(66476007)(66556008)(2616005)(2906002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NV+OjPXa4uaj/jI1RGn/c/3GhVDIbXirXWli7QJox4h1Y89bbfa1zJEBa55F?=
 =?us-ascii?Q?GdehxmBdrTkpk4i+6sriGt67euT6Mz3RgBjhB8EBuej++MkRG1yO0/V6gcFR?=
 =?us-ascii?Q?h/h7hZFXLITWCsvqGrbl1Ovdms2kh2P/jrh9yyedU1zRSyLUhO2AYJWLVH9L?=
 =?us-ascii?Q?It51pOh+WNJ5hdQy1DdzIBcT3tlitkKqvgAnKC24zlryQRTZ726eH11aQNwv?=
 =?us-ascii?Q?TML7L5YhSXPffoETqbZOXemmMQ05YwCfZPRsmq6/xkbPuZXfhiX+MPST1/DW?=
 =?us-ascii?Q?fRwfdov0ccs2GDpztzLm1N6Cg58aVY8kFEE1Nxz8mMcXyw3jmFy+pj3vrDoZ?=
 =?us-ascii?Q?+jCMGfH3PDUsHfw8e9mtrfs6GzwYzSZA5rrbOK2FqnMrPOOrY5La/iNtpHQH?=
 =?us-ascii?Q?xAVtcWrUZjiImAd+mdmtaNftcRP9Zp5uixC14Koeuit9JXtWXr84c2oXa+pt?=
 =?us-ascii?Q?JSi4n8t75PNegCcuLfBD2WTqyaamOkxpFdMrZbZepJY+x/HUGy7uz9LpuhZp?=
 =?us-ascii?Q?tcdDDoss0iakKBhxWhFVJ1D9fxBzJqGRcAcSda1VmygJWnLK4hTp0lFr+B21?=
 =?us-ascii?Q?rRe2ylbaFzTAe7rH60tyfHoRKyIXbRBfwYQAp7OVmKe0iRAxaq5VpCfMI8SW?=
 =?us-ascii?Q?vZFkX9kQB3FuBwvlZLwpJZq96i4cQiQnK2xpPVjh/KPcAjYwVDIl0Mtkt0MW?=
 =?us-ascii?Q?kY2KmfSB7Lcw6CwQYfupgPNQfzPSIjxzEDpd/uIZYuP01sr1HqaZikdCO+EN?=
 =?us-ascii?Q?zSJtNjd0gKvvNvk+FJru4lH+Jp2I8CG5ERcWkuY3H/dG+3g2c9nGAfFBajbs?=
 =?us-ascii?Q?9NRGa3K8yuWJV3arMZxsydWWQCH4Q89ZczX4mhRhXR+yNMVbf6mLAguw3dQg?=
 =?us-ascii?Q?1AotabAjfi4URstsyai8SAf+dc+1g7hY3xd0fUxC0KdBeoxHROZC1mD75V5T?=
 =?us-ascii?Q?RvD93yJtaZhXSpBwPUZCRzLkAoCQNolr8bp2ENro//fLUUPGoS8aEsFIa+B3?=
 =?us-ascii?Q?uZH6IT7fu6whDTPbiBSSYE7h7Wk3j3x9mpvIdOhk9UM+WmvF+yNbQfxDr/3v?=
 =?us-ascii?Q?nwleXzOsGvXySocy14GZWT2RMzN66O1SRrtJMx7gXxkYIT7TFCMKXJUBLODZ?=
 =?us-ascii?Q?bM2ImHw2qzmXg9Rf9R6cgrkjVokMf8ph1Ux0yrSx/mNEgDtu2xT+E3ghCQw7?=
 =?us-ascii?Q?d1xTWBvZ+K9kMn6hi/BPvfrCvOyAULG1uU3E37wnin/1P6VuAeEe0EcvI0+q?=
 =?us-ascii?Q?WKYW56nui+DAK0i42yEeYYi648GY7RrvMGuWvgVxwK1Z2FWb1Azd2DeSse4+?=
 =?us-ascii?Q?e7cGXOCqRCZJd7IQsMWtPXNzSyQo1yVJj6KVoutdPRcmqJJQM6EHbTougXn4?=
 =?us-ascii?Q?+ZPNZzr/kSheGF4eB8AM2+Bt2n3VjdHnu8FOpTnUwJzpy+gB2IjSXiDAzK6k?=
 =?us-ascii?Q?h2y70U9uMxKiuf+getfpUoCClGA2v965wViR2u91Zdcj9nUNvJnqyDd6C0Z/?=
 =?us-ascii?Q?pH6faF5nwgxdjeepSX3Yq4QAU8F554QxoPLu/asDRjE6J1xQ38c8yyE/qqkx?=
 =?us-ascii?Q?20yK/6VTWvhFWIK+7wQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3280029-93cd-4cb3-493e-08dada1f83a5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 19:56:51.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kK5KuYAFg6XYSOYbM6ECqSFdsoTgB8dp9hAD7EE+7RF/7aDZ357+AAALuOc6rtyW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 09, 2022 at 01:59:26PM +0900, Daisuke Matsuda wrote:
> The commit 686d348476ee ("RDMA/rxe: Remove unnecessary mr testing") causes
> a kernel crash. If responder get a zero-byte RDMA Read request, qp->resp.mr
> is not set in check_rkey() [1]. The mr is NULL in this case, and a NULL
> pointer dereference occurs as shown below.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000010
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0002) - not-present page
>  PGD 0 P4D 0
>  Oops: 0002 [#1] PREEMPT SMP PTI
>  CPU: 2 PID: 3622 Comm: python3 Kdump: loaded Not tainted 6.1.0-rc3+ #34
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>  RIP: 0010:__rxe_put+0xc/0x60 [rdma_rxe]
>  Code: cc cc cc 31 f6 e8 64 36 1b d3 41 b8 01 00 00 00 44 89 c0 c3 cc cc cc cc 41 89 c0 eb c1 90 0f 1f 44 00 00 41 54 b8 ff ff ff ff <f0> 0f c1 47 10 83 f8 01 74 11 45 31 e4 85 c0 7e 20 44 89 e0 41 5c
>  RSP: 0018:ffffb27bc012ce78 EFLAGS: 00010246
>  RAX: 00000000ffffffff RBX: ffff9790857b0580 RCX: 0000000000000000
>  RDX: ffff979080fe145a RSI: 000055560e3e0000 RDI: 0000000000000000
>  RBP: ffff97909c7dd800 R08: 0000000000000001 R09: e7ce43d97f7bed0f
>  R10: ffff97908b29c300 R11: 0000000000000000 R12: 0000000000000000
>  R13: 0000000000000000 R14: ffff97908b29c300 R15: 0000000000000000
>  FS:  00007f276f7bd740(0000) GS:ffff9792b5c80000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000010 CR3: 0000000114230002 CR4: 0000000000060ee0
>  Call Trace:
>   <IRQ>
>   read_reply+0xda/0x310 [rdma_rxe]
>   rxe_responder+0x82d/0xe50 [rdma_rxe]
>   do_task+0x84/0x170 [rdma_rxe]
>   tasklet_action_common.constprop.0+0xa7/0x120
>   __do_softirq+0xcb/0x2ac
>   do_softirq+0x63/0x90
>   </IRQ>
> 
> [1] InfiniBand Architecture Specification Volume 1, Release 1.5, C9-88.
>     Available from https://www.infinibandta.org/
> 
> Link: https://lore.kernel.org/lkml/1666582315-2-1-git-send-email-lizhijian@fujitsu.com/
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> v2:
>   Modified the commit message:
>   - Removed timestamps from the calltrace.
>   - Added a reference to IBA spec [1].

I squished this with the other patch fixing the other error unwind

Thanks,
Jason
