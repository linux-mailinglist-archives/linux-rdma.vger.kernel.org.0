Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDECF57CDE3
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 16:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiGUOkO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 10:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGUOkM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 10:40:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576EB5F7C
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 07:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeJshEwMjtAMXJMowaJXK2u+GdN/ElhFK06qs0GpSuzlwqRbQM9upaxHKNxZuB5RCZ4o/iX4SI+lwQAKRHafoaMXfiUfOp9dE7+zXSggmpFi9e+CEcBDoKdSzg92TQap0nDpLgTnyx7eZ3/VEChqjzqb80gyloFe85bXDYA8REbVtke+C8zqdNL/6mEUv5zztcsdGx2xo7556ijieoSN7DSms/ggn2aNaEoXgdjabmv08vcVWngBdzCkx9xMJl4y5GyKVdt5AYknodBDgRHYwj+9zss3TsthUMpLjsF5RGLWTZHZiwh0p9FNRn05K+0PWqRJLT4xkmqDHLKL4QOq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8q0vAZj0niIBWF2Es5tdYCd0B54iMf26i963xGL9MM=;
 b=I8bGfYi3MbE+UBON4gdynoWU4S6gMNF6jyAuBRV6l+M9E2mUT9mIo/IpccvqokpPTyV89FjDqHVVoF1Gz/GZXxRmDDdXPyaxx1hEehjQXXef0ovjvq4eg5nNACHmKMmL19ZnQV3DvIFZlkrnSmnOJkZOzO+ITRNdGaIG18ABcCVKZJHkH0021nHo9z5q3PFmhoXhzhofuOud7S7ovX2hokebh368qDvv4JO3GAuiFfquC7swWIli/V3U2KdFX4AayEERJTOph9cHVF/0cYK6SNdHu62AvwXLe8Rjk8GcOAapR5fGqN3VTuawbjNMPmXw3Zm/ayTywXTMIkr1FAJWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8q0vAZj0niIBWF2Es5tdYCd0B54iMf26i963xGL9MM=;
 b=QawjnaOQ9k1NBze9Q6sT+M2TM6I6rn9jDgmutMkE7L9xlPRT4319IoHBY5BZElCdbhqGM09pfb53Db68VkSfvW/KpBNd71vU6CWIGJju8644oP+7UQxUu0JA/tajJIBUu8kIDXdT2twukaNYUIvCnPKY8YY9scI9eGZu59dEV91xtL/KIJiwA51m6JAYS7zjg0Ci+QDlOzEv/Z+g0AJyz3l6xMtrPTHtEVUS2qnSkARtDT9sdnZyYIycID65BTW5zYghJmG9k4SqvdRhkmoehIsJAbR/fFDPYeuZ9hb3jE0MqMH1J6Hu4E7I6SoCGk2IAuVbZLgvxyBVL60x7dlQMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW2PR12MB2556.namprd12.prod.outlook.com (2603:10b6:907:a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Thu, 21 Jul
 2022 14:40:08 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 14:40:08 +0000
Date:   Thu, 21 Jul 2022 11:40:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix mw bind to allow any consumer key
 portion
Message-ID: <20220721144006.GA464626@nvidia.com>
References: <20220714204619.13396-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714204619.13396-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR10CA0031.namprd10.prod.outlook.com
 (2603:10b6:208:120::44) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e26e68d8-4f3c-4e28-ccf5-08da6b26e87d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2556:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKnxlYdvHexdijBDWN1DDkR9lTCA7JwvwkLGYPpw5uYdc7IBaSVoPv4SjvWoX8pYaHYyZuxcEsUHxa05eVpxVfegvLpN2xv9t3cpkipZmiZhBwQ0E7W+0EyCmWIGl0ATb/0kH2BJJ+cluuEYvKMg6SvaOfx3pMfaZc3wHNNKA1OqPEk3XmxF9AS42gfPm1nFWt8p2ELsIpWejiizLRm1MfhFuTT6pHG5sSSTHTyr7WqB6yxQJdhZyrp7cY8xnR1PLMX4jUfmyGHHtxxYxOGnUtXSDPMiRt4ZJWACsVqCpRB3S7vsgZuldRCR55bnFzA66/ZT95j7hyfL/qOXQJ8lXq75TXLwLWo4ubKq6j7cxXzzSwVaVx0yjQ26UIkOUS6zO0SVMhxWt2PLoLlWQtjrm5LPVNZwvIgIUdqr9KDp6BjRCU4VGJsXiuWew67PhcwgVu56bV9MyBUKGyd9vUc+7RJCo5NN9J9ODLSVwbayTgjjp36GnILcGkdDtkxMOfxvH7iFLTxbjVxCiz0cOwA1WIh63ARDQ2ELhG9zT0dOmqJzVCX23jkIz9QTi9DDiQ35AkHG0jm+i7z8/ih/iH4oI4oT60sfAlpGkF5geIcclB2tZcw0wBolB4NRn1Qgd6CDKn/+CxVYIVKJlyj23fqM9bmOcTlafllYw/MxgwYu8DtmVfUCZOXQembXmRefnwKTWNGydoIMvRllDc9EMvnE3VSeOJfix/SoylblngiJkYXJNVU/mzkkLfEiIjz8AMh6tZRkI8LD+joTmtBTrZpwe/TRXTszPv73r0oMghZZcfLsMY5z7SDwuhe5gilnCn1zdgPw32N+HvT1QOuSxBKgxMr7DCiooeW3bWd8P2gideTLE9k7In1+9mE+1TjqDu94
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(8936002)(66946007)(4326008)(26005)(6916009)(5660300002)(66556008)(2906002)(316002)(8676002)(83380400001)(66476007)(6512007)(86362001)(41300700001)(4744005)(38100700002)(36756003)(33656002)(6486002)(966005)(6506007)(2616005)(1076003)(478600001)(186003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kzvfSXIQvkDQRibkLDvQlynB6wjzJTGB2RMzGtKCatOsn9CRZhDSYLIl7EcO?=
 =?us-ascii?Q?+/FPjx1COF5/M9N664YOwn6kJxVCkVbTzY+UZmqjcTwFC7Eyvcof8oRUaqjG?=
 =?us-ascii?Q?/x11Fs+h6sGCOs6NVrJiSImm+o5kYU4BEzszlKYW2pD7veEJk4CSE1P51737?=
 =?us-ascii?Q?4Pm9VdClTBYBn4+BVGxkJNkx/oPodd1E3VP/95w6Hoet61aegqC89aj+QikJ?=
 =?us-ascii?Q?Dl7faXpSFTq09p2DG4iWgp37fCuZIrunYLSY0QEneabOwWRqM+l5cIWlnVep?=
 =?us-ascii?Q?P5IJkThLCjfQGRd5YVYN7nHYRj1IDxipSYWeBkVu9ir6W70H6GRQLMSauO3A?=
 =?us-ascii?Q?d32v2AeMpr6QO/TUVmWv5xlNPXUEMPRAyta91bxbx7ue6dNb23NXW6KaAqD0?=
 =?us-ascii?Q?qsOwbkswQZdVvHiZTiyRFompC4dbmNmChZOv/lVaIfhcDR0d+kdeSTs2seGp?=
 =?us-ascii?Q?36WPvt8jwrrPgH5lmNxn8muAuO44YJSL4VaifbIxKfruh01wT4KzDeyadQSc?=
 =?us-ascii?Q?J1NYThwKQ+WK0Fri0FwNe3llpXpAPBvwXFCWceIvS3vGJ9n3Hd/z318xaO+E?=
 =?us-ascii?Q?oLjjdyR2PJ/3o3daaOSPzQzH6cttg7ixiNCrZJ3ObYZM+ylxJDm8LUcbli/j?=
 =?us-ascii?Q?J9fPB5RnL26saoCKariFrEFHG+AZC7coCsvVqYMzbixN7gJ3A9RF0YLgv9RW?=
 =?us-ascii?Q?wY4awkzWxT3OcUHRbnGr8PS8XhCP8magmZbH3SgXIw1lCjG0Pf69F9dKjvNa?=
 =?us-ascii?Q?b/gsI5lrVe7uzwR2UM1K39AIuIfJRruMOPUSUhWZJmQJGsb1CdtXzLnQ7TnH?=
 =?us-ascii?Q?pSeup72ZhEispjtaRblywJzwXAdO0bi0tiAslD4tV2wodYGTf4LD35sZMNkC?=
 =?us-ascii?Q?9nEGNWJZiOKHoAjhLnQ9dnuBgDkAdT6cuc/olJVTW8uCCU7AXOcUQh1MwYV/?=
 =?us-ascii?Q?4TsZWw3dN2NgOEQPwt9NnYEvi5Fnk+hnkdjPw8jSyoZBBA8gWQ5KBRoa/mSx?=
 =?us-ascii?Q?iN9tCg+YhPn7vr1zXFdmg2TCj/X4CPjPBAKrnaskACIWnz1Lmp6Z3yKxmgsn?=
 =?us-ascii?Q?lsX2nOYk/c/XRURczShoct8hytsLroHPQN6UbWAS6bB+Xb29oCP+93mkomoi?=
 =?us-ascii?Q?9onqXSt1N4h8T0HEodfQUBOoVStCHZsT5YrbBrb0BFMJfy8ucNFTuqRJl4H/?=
 =?us-ascii?Q?QLKr5sOLRtNn0UGi+t7Fs+2UJ0RjgDB3aP1QcPidf25FVIWz266+4NS23Ech?=
 =?us-ascii?Q?u2EDObLiHBQFCfROrUxLLR3TB8yjc+aEcVD59I4KyEg7Rnh3cmUVXY3VATke?=
 =?us-ascii?Q?rmz9hYGBC8WDVJp4QC47SbfWkSNWVUyr8GawF7yEfC4ybNq9aDVRVn0kRYn5?=
 =?us-ascii?Q?Y+1gebo6zKzramP+rmpcQoM1bh1+XOx17bJhAlxkznSftuW6uwBbE8lm05c1?=
 =?us-ascii?Q?qYmcmgoh+LeyHkjMnqyLlpLwKxGKkqkuJBTNE5Q/X2cwYLvbejSnvyVDihhO?=
 =?us-ascii?Q?l9GSXNJGZ97ZKr617qlD9IsfZ+GpVe921bKv+YcdIfD2HWXguePfiUXTMrYB?=
 =?us-ascii?Q?wT0iiQkWE7uPCOJiPB+tm9YWQM2UfpxevEsC+07x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26e68d8-4f3c-4e28-ccf5-08da6b26e87d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:40:08.1386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQ62BcMesYmqKm1kg/jNOLkmxNzTJaH5Gupe4OoWTi8VFy27qjjCWLtyor55yIGW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2556
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 14, 2022 at 03:46:20PM -0500, Bob Pearson wrote:
> The current implementation of rxe_check_bind_mw() in rxe_mw.c
> is incorrect since it requires the new key portion provided by
> the mw consumer to be different than the previous key portion.
> This is not required by the IBA. This patch removes that test.
> 
> Link: https://lore.kernel.org/linux-rdma/fb4614e7-4cac-0dc7-3ef7-766dfd10e8f2@gmail.com/
> Fixes: 32a577b4c3a9 ("Add support for bind MW work requests")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mw.c | 7 -------
>  1 file changed, 7 deletions(-)

Applied to for-next, thanks

Jason
