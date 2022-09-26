Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9875EAF4C
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Sep 2022 20:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiIZSL0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 14:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiIZSK6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 14:10:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE4A1E732
        for <linux-rdma@vger.kernel.org>; Mon, 26 Sep 2022 10:57:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEtjFJ8JgxVbU0ULK48DhPS8s+S87ivaFBF91S0MIotSf7lhL6T2qLcMFjXqPvNs/qWIYqWztcDqTVfb9sOa6gVZX4h7RiOu3Bcn17gMJQ3yWVAjUk8huQTJ/cD7FWT3lNZPgcMEQKVcHWfHc75N1yQatLEzaXXZ638OKxz3qNGHxdNnTxaXpmHQ3tgEldx3lnVGql9rF4Zp7Q+h4/RMvCPL0Z9WPM3qIHzhu36/Praj6bsBxavhFPFBGNJO19IWYQ4yDcbtMF9VEioQO5/GDrZCSSXbCZCTMpmAe3WD2zVonxf+K2BNsiI8bUgszlDj+c0/BJmGULjUunonVEKU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quuF8KNpCNW9IeIeQCV1BnGVeO2iT4qDbkPqCVpNGXQ=;
 b=LQV8EQvQIqh9lD1hCIM0isTybhE0+qcpV6dwF80Eo5MJ4rTOQyyoSQQUAsPhKDi21hClPdAKbVrbHlkjzLNNUSi9/X1sdFT54k3UiyIW4L3fdzdTA3o9wjxGjpVh6NysViU+htEe16hL/+090WDKB6CnDKvjQ1vGVNrmq0ijoRBjd5xkT+fsTQN2XFEG/mf9SqKyJkgUIYgLGfyp1tzWn/tk7+nKc/+v3HQkn9ggZg8h46wc0rSiJi0lOMztffWVJrchkD1RPosCR7YguIx+yI/5UerppnyKIPj7EiIX/xg3M5nuvqjL+y+QHNL+/iGxhjXIs2QKnwZ9K92ih58AVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quuF8KNpCNW9IeIeQCV1BnGVeO2iT4qDbkPqCVpNGXQ=;
 b=Tc7gpXievtFgywtCkYLQ2TGGtNJC1XJziAvHYq4wpVAe9xunkFkV3Q4s7TmFBNAbf6TtSd297BptAmivAdAXdehdetMNhcDfp2bWs3oVPCrLGqswPl0iGjOGRHhMTf4VgrURJiy3LreAmQBktZvNPJF0/j4W6vgNiBIInFfa0oMaHWD9SIj7kdzTzdzU3vHmZpI4/yNqAZmK+uwFCvlUmK45BKT+rKthHj75RV98Mc8eW5mbiuCf3glJhr5qaxjkWTkBuLxjBKQm4vWm58gLu2hy5Wqe5b2OoUe52ufj/7YlzKLdog7wtPjeKgH4l3deym7yzgHSF04MfFxZg24u6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Mon, 26 Sep
 2022 17:57:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 17:57:26 +0000
Date:   Mon, 26 Sep 2022 14:57:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Remove redundant num_sge fields
Message-ID: <YzHoBAtbcchLD+N2@nvidia.com>
References: <20220913222716.18335-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913222716.18335-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAPR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:208:32e::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aeacf15-c4ae-4bd6-25ce-08da9fe89200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0apeQ0O8hfJCzKC/xxd+VopkQ5yMUIs+ZW1FjlkBH8L5cAjJ3SQ854Oy8gKIaZgn1PWHEVIjmwPVP4Nn/VFq6bcuVbZ7p1fYXJ5Iug5ujuo0AXgJEPhj9urPvh/WJiuqY07TGrsbccZHyCeKFwErd7uYx7fhgsFEiJC7MZx0EM6s3YmLzFBX1weC3TS/WNWqxNhHkulm6NUHzEzkB7SK270H0XE5RqnhmHNLQ3BsF0pWdcnShA3qWmdiA4M+YpCie9ezrLA2w7HtrwrnONajNcSm/dsdd3mTdeqgr9j0Dg0FSXRsau1+gOA22P3XG9vWfeCz/lZzPShgLul9uKmIFq2lKAFCnNS38/G7t336b0AKFk7N2YAd5roJtadK67O8X801v5AjNyxzHmh4n2vzyjEGi547qMNuE9mqVCavwwOsmfqmH9Ltn2EbU1YciydWSF9O2WBFKxkCbJ1McDzfH1KgxOMs+X/OpmHLBNGVuZQz0XCDLhfL0D0osHz/74Sks4rbU74eZVpeccJXVbijgoQx+6x5uejAUT7ThYbuDJdzFb0RYhMd32Jdh69C/La5LXCiHgJ6uKm+d/+qCYfeJOWVTS4wmxC5UlmWlCr0utsmLae4uIH4fsn6dv9Ekg83Quw+mCvm5eiFIwxQ80XAXqM1sfZxPRcPg5UVGUX/b3J2yw4gDFmfhj0CAxtF4DtlTyApNsU2F5KhPOiwYqQUTKqqOyHTw4W/yHguE/xW0NMS7/P1ylyJQls+3J/gPhWB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(41300700001)(83380400001)(4744005)(316002)(6512007)(66556008)(2906002)(66476007)(2616005)(26005)(66946007)(5660300002)(38100700002)(36756003)(186003)(4326008)(8936002)(8676002)(86362001)(478600001)(6486002)(6506007)(6916009)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lT5F8TLT4Oa++6pMp7uB4q/qqZYS9V0PkGmpSizbk2/UmM+ZKn7GiCjrR62q?=
 =?us-ascii?Q?9xdkAvfFYmU1KV/vmx9WfBskwAfy5DT2s970MmIVveL7iWgfOkLJRwihl2U1?=
 =?us-ascii?Q?3/a+C8tpiDVwa7iCNpuNYe9+YjNSL+3NpmlCSwSGD2sbWg895lMVZmQfxAe7?=
 =?us-ascii?Q?DxoH6riSrh++k37is9knSm/n1y1Fqkg2Xs8gZjUSm/gQevktXsaP8Z4yByy9?=
 =?us-ascii?Q?/4OvdsEupxoeBj7x1AmJyREysOHx5Gvex4Ks4ePSP7CCIqIcj+0bMiZkTvsp?=
 =?us-ascii?Q?jvRlmEDnkfrUQiFRwOpAiHGhlTqIR9vMbd+Glq4/xnONtcPJgnnHlEufaPPP?=
 =?us-ascii?Q?+8Ch2as5VIWZaXBSkAMm33mZBXFWGQG7XEOEtAVyQ8T5s9qVpAYsgwxWoP0O?=
 =?us-ascii?Q?PjFYgS4vK/Iuwezf88gwm+LBgJXURMxGRX2+C340BPZS5qMhpRf8H28J8Xbj?=
 =?us-ascii?Q?uSxU55WhaZFfYcVkD9FIAkW9AqsnlN62sO3bk6wu3258Q2yELer0kVmZv9ks?=
 =?us-ascii?Q?T2M7GZ4G+60+4U8kYBmqThHWal0/9wOTXQgf1AQjN6/ocgJTsb1AOyKLw3eB?=
 =?us-ascii?Q?eB3TlWm0pFAUm9zu2cMnZo04O+r7iZOZF0LXJ22cC12yKscr+qesiWuOvlny?=
 =?us-ascii?Q?GtZsfMAaJbEqK5wV5zUvGYvc/7dQUb+7bPRARkMgs8Q0lvn8wInPW4mTKOOg?=
 =?us-ascii?Q?/6XPLHhhIaU8K7S5D+N0kwYANGlarsNksR+jvjAusS3VcsEyyT/6vIAQFcAE?=
 =?us-ascii?Q?XaxczSGDE3vI/PXMMZ8mnNRguY7FyVD9O0MaDOvB3y/QQ+OmninLjHWukE7S?=
 =?us-ascii?Q?IjBShTZL2n37ZXDkBIfUtLaNOmGp5jbxhVHeGmfDdUOfmjg6bzQJnWtBnO/Z?=
 =?us-ascii?Q?mjVft1ahgWz5OA41iBX6mD664Wb35eDJqh6s2vkVgMvhfHYn/wgg9r5IN5yE?=
 =?us-ascii?Q?7cu/4TdTdwQBlSrlhOcPucpEMveO88QqIgJz8X1rnqlK4HjIpem/gVD21q4Z?=
 =?us-ascii?Q?3PrJrx8cKiZcgpzyVO7oTVqKzAgDL2vWnfIsv+EUV8aWS4MsR8fl4ynpwzqi?=
 =?us-ascii?Q?cBHFWQcDBAuJVNNyerHBN9nK1hoDtSQPmvxqojjC2Xx778z08brwU0JNqY4z?=
 =?us-ascii?Q?N4zyCf0CcfwQdm+Bds0ln8ULmtXgWe/9DbLCIPBwdCNEj0rD0o5tm9Epp86s?=
 =?us-ascii?Q?vkRgygk1IkFOSfoJUlvSpPgftO0F+GHf+cFq3zE1L4DyRi/hhzQ6iI4yEHUP?=
 =?us-ascii?Q?Yub+AhrXqlI33PJH+u/6znM2AsTgFRz1UZGiAYvQgPd4nuJVdUfos2UIZz2Q?=
 =?us-ascii?Q?qPi/BZ0SnSAyUkkFEooVzN319LQFjUSZ2Rjn9RVJLYvQA4No8Ty6YB0LxgTh?=
 =?us-ascii?Q?H1RtexOo5A5BRQ3G7xHw+TOoVJTDrTNvB4ZVYXptKHu2wVBgLJVt2sQT+kIN?=
 =?us-ascii?Q?5XPJ8xXQaELWotSkmnPVRSpR7gV7ijHPqmPB6oIc4cvwwNdHvXoWm/CbKk/6?=
 =?us-ascii?Q?49Iqfv8VPvH9XVP72vOdFSNnOlYZSZHFMwjwTEAeIvQKg3J0JQhRBKCLH9mA?=
 =?us-ascii?Q?8KfIpxVXQlN2g3HFj1U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aeacf15-c4ae-4bd6-25ce-08da9fe89200
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 17:57:25.9089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kgLnXAGZvqACyYfJpSJLEO8x1xtiAOMCJGHuOVIBsJSkOrnOglk1dSXa66URXeO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 13, 2022 at 05:27:17PM -0500, Bob Pearson wrote:
> In include/uapi/rdma/rdma_user_rxe.h there are redundant copies of
> num_sge in the rxe_send_wr, rxe_recv_wqe, and rxe_dma_info. Only the
> ones in rxe_dma_info are actually used by the rxe driver. This patch
> replaces the ones in rxe_send_wr and rxe_recv_wqe by reserved. This
> patch matches a user space change to the rxe provider driver in
> rdma-core. This change has no affect on the current ABI and new or old
> versions of rdma-core operate correctly with new or old versions of
> the kernel rxe driver.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 2 --
>  include/uapi/rdma/rdma_user_rxe.h     | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
