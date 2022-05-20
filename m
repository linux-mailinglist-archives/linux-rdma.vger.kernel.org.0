Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1000252ED92
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 15:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349592AbiETNyP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 09:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348706AbiETNyN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 09:54:13 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6A25E745;
        Fri, 20 May 2022 06:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHYiwOxpptFAu90yWEKdT53nvLK5gHf5fkHBoT+fxUt+OuR7m+HdhDZTLMpteF7GPeOnW9Vy6vzKlEWKln59E6wVX9ACKuvHnCosd0kUx8906RjwR1WK8Luyj3zEMRV+s2vKN2gPi9ChuiENOFmHEQVb1AIfvAh0udPR7PgLVQmY/+u6vTAmjP2s5/9jhyKMIBTAzi3dMeTWv2tvB3Smq5mGVbcBHpo8WyXFythOX/Bl2fr5wRaQtB0B4EG1y9jgP2Q/rScUGv8q+5Omk4XvRwyGDqkodL4CN6iUlrCvqjcViWTJK7Z8/tOYwk1LTl3lFiHxh7jjvYdtkYhztbas6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+ogsC7OpnGkFCGnv/Phx+/hrjI9FpDlVqaJF4nn2CU=;
 b=XdxvcOlbLlGIu8mecj80+0nPGPjJre7oELby0WZZIMLVIiw4we1vczj3X+KvI034SwzFFyX9cTPQSlSFTPRMkFqtckeUar3qN97Illi6UCJD4+Y8lVx+QH7sZalpXIdTduzG26h1TeUXSs8W4/acDhNVf73baUuBNlphnF2PGibR3FBpYCS2aTUAYLCx3G5G1j2J7zQ0mVpfzECuCIsPgQ88bl6/zZ+kRAmj834i0JfnMTDtOxPYNa0j8nPhEJo6TdO+F3Mf6rrwPODOLtBv0bZDZO2IajfW0QKpr03VSE+n3nNv1oW3VUR4PGgxJbD1vR9xi/MkRVQ7TVuOrj+rlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+ogsC7OpnGkFCGnv/Phx+/hrjI9FpDlVqaJF4nn2CU=;
 b=UfxxJlxZwoHN8XUJDbt34wg13rGccqO+a6l17Crk+gyD2ult2DATRA6ZXl6H3fUdTLRQynCLJBRVPG/wVtXhXStz6Vpq8BUUwwXZRHne+RjdCSTSNCEOZCa2AjBy93zPkgyizAhjxmhJa+rezcWoz3NjlXXxbu5kk5uz38OF2MNUJFR6UAWpc9+d6oBWQYXkGhIFUMSc7ArzU3yHS7Nh6niT4pjl4LcR2gFZe1BS817Kr1jhQ9KyugEOLe6DGL91ApuXA9U6vYgaiHpbs338AgVBVzPkURpzX+nMiGgNXCHVx9b/kNv/oOX494yu8kTARAUzAaYtaEIZf25APwq7qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR12MB1299.namprd12.prod.outlook.com (2603:10b6:404:1d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 13:54:10 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 13:54:10 +0000
Date:   Fri, 20 May 2022 10:54:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     leonro@nvidia.com, aharonl@nvidia.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Remove duplicate pointer assignment in
 mlx5_ib_alloc_implicit_mr()
Message-ID: <20220520135409.GA2291159@nvidia.com>
References: <20220518044914.1903125-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518044914.1903125-1-matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BL1P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::10) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cce8289c-30cb-4e35-ccff-08da3a68374c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1299:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB129926066356A8CEC7206C5DC2D39@BN6PR12MB1299.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1pURChNarfQP/wECbU8kN1FDpjuUSwqNS6y2PeWrpWics9IxZYGlG6HyoHkyq9VnGxpxXc+AKdB7ygptuhPVSro/9jQCCBUEXxJZZnw+0E5+r91VpxmuXVFYbOBUiCNF28fBtHrjN/iOr6nSaRTrdpF8EirxTze7Q1rOaAnZNqZ08aAGKLmc9LnRO3hJgFKCJ2+N82Wr2PkUprlZjJVzbOO8bvvWzInl/tc6McgTT+gCei8yamhD0+P8IXJ0pm3CW3rWTFmS0d9sxl5L2BnRoNiAS0uompcX9rv2M7QoujjL0pwiZqdeMy7UF7Zn/m9kuTQYjdgNGERvNXr9dvC5YlR2YoayyIaWj9ffdtl9TAGK6jGauEhBu5QYpl3RrxnTWmSq3s5WLBKEQ2JuMr7/jiVjjc6nJIfeZQZFlayA81o7sem0wf2uYKk+J03PZ0c+6LAFGbnAkA0unuLnzscWDkGz8DY/ZlCVI2nm8lg6L8slEvgtxMr5n8jov0eWnTuHSVDnwVpfSmR5NDfwFdWRFyjR38wi7o6sDPcQmMaMGB6bw8UJCgAxKL/aCuMyavkBNuCrVj8RTeUl3w0NtUj75YIBkAKv9NqNPANzVZgQn6BDf1w6b75t+WQEzhBirdWlVJexusMT6ircpBpNVcxog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(186003)(1076003)(86362001)(2616005)(83380400001)(6512007)(8936002)(6486002)(33656002)(4744005)(4326008)(66946007)(66556008)(66476007)(8676002)(5660300002)(36756003)(2906002)(508600001)(6506007)(26005)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T+JqSjIXHBxY/pynW7OAtCv2lVYgwOclmAD7dLvF6U4uYL7/Nloo2+WSzYgi?=
 =?us-ascii?Q?nVmHqiehfRgjrjUC2RylIEkAQH9jNBlLJOIxHo76w7yAHsFKswTeDUp6Jqwp?=
 =?us-ascii?Q?xKsNYl7raynTZgY2qks16Y+iPV0KzUvl+y204jgp4Oyb9XV5raWr9Ko4f8iC?=
 =?us-ascii?Q?51qDM1wtVwXuRobK8S3PE0u+bJH4ExtqSAmdtGe6ndb4A/4AiedStebP9i17?=
 =?us-ascii?Q?OFPZbX/XmjHWx2dgi7ZPwIVFmtejQFrJY6FzaT/ZZtrKjB33KOLeOYIB9r7J?=
 =?us-ascii?Q?IjL6aW/Qan2YP9wRLKOSbd2HYwEFEPYB5+DplVPU3U5LxeEGtrmYTA3WmXu1?=
 =?us-ascii?Q?KpVc9rTBd9ngJfnA+nFrF0+LmfAXwgDT+KJToJ75Cm6GjOfikEOCwnDK4W7l?=
 =?us-ascii?Q?qxngIkStSkWmhlm3P9S63ultf2n0ui3kfpGu5WXWOXdBA+cb7gEC+ALYL9+e?=
 =?us-ascii?Q?Emou+FHfpsfkKW0mWxamETHoFAZBtKcKQ/Sw/U6VgE6QLQSe416U1gOZzq/p?=
 =?us-ascii?Q?59kmBnbEd/eMBFihKVi8DV9jkbnMLCKi+uwTPlzCYMA36Z7l4hDUYiYTKLC1?=
 =?us-ascii?Q?Ift8jMYoAq9/4SISVSHVhEGzc8HyCOjKzDZ9ULlshDdn9DdkF5Y5iwlmB1AS?=
 =?us-ascii?Q?R2VA5THgLLvoIad91rb1d0aHGzTp4c7iApXOnWL/x4q7F6zGYjSi1auWy8Pb?=
 =?us-ascii?Q?QfUQOM/IVI3egMZwU33MNTcYExGrTcNjJyuAbOaL9YU6WfUuqGVoUYZSKqcW?=
 =?us-ascii?Q?AsE02B3g7uAYOqv81h3QZLR1aByfxH7+g4qRXaR8otM2/dVSbb3+P4zvrJpV?=
 =?us-ascii?Q?U62KsA45rMakRrjultqH6XDcTiqmg6clJOA7EJPQ91Y90i7HddvRuhU99lWF?=
 =?us-ascii?Q?ZwOFuR0xp48gZG+TdD6lIKNzRh22MQbhMKddcqUIDYKzJc+ci47PAWq5I/f1?=
 =?us-ascii?Q?J+I1KowcRS0hgULS16uxplF3I6rHG2sAQPt53AgaLCruIDR3ldOIS75v7J1k?=
 =?us-ascii?Q?NNNdgIULKlxiv9uT4Acl0YOWgtkVVX/hgRDXWJqutVKWjtRX2Pb1NuC1ek/d?=
 =?us-ascii?Q?VbHjPoLXDU04MAcKpDf7iouj4GmKKCkeOms7hWT9EujMMAowLf3RL9UKN80Z?=
 =?us-ascii?Q?qJ+1M36up97WOGNP45Rq6amt9EPKhcq22WTnvjfv64ciOnmV48z0OEX+H9QK?=
 =?us-ascii?Q?NAegKRU1kp9Mp1y0twrRC7ODRc7aTjV4thE5LTLlIahbm3mrvlXwkIMfyZ9m?=
 =?us-ascii?Q?hCj10KoNOIKVW726TQOR3kZ6oJyHwHPxCbfyj0oB0Gp1d/Ny/hsiFRrvjBeC?=
 =?us-ascii?Q?NfKX3picpz80CSeeaTXltaP428u7XYpIZPTj3LsGa1Fed/rVlxdl9gt9+7UJ?=
 =?us-ascii?Q?9baFXRMsLKtT0v/60kg+5eg+jvXqN0cUHTAiF1+1RV9LlUCv/X53fKRYKCbG?=
 =?us-ascii?Q?/e7FoiLybs8U1IAGMMfOji+UTDidMDghCPRI2nmtc90hXWQidEvnbyib/Mvu?=
 =?us-ascii?Q?6M37OM7Z9bFh7WQ9zTigTU7PmDL3wrsqTOgVsKaywEy/hFmJ8OdbVulRcN45?=
 =?us-ascii?Q?JJvhEljjhHVp6jQAzzPTPAOHtXnroZzPPF2psq5PdqowAF2jEgnk3/fYrytJ?=
 =?us-ascii?Q?iNrOCVmbgXG0BDVdn1y/nuQHCcSE4Jil6I2m8gh+FmUbGf/f5825zXvIf4rY?=
 =?us-ascii?Q?yOul7xLPLAE7rsdEMl4A+MQYKRjO8p+Z5nltAFDg167M2QpCBV2rFRTXc133?=
 =?us-ascii?Q?AvCiDqnDQA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce8289c-30cb-4e35-ccff-08da3a68374c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 13:54:10.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M088r+t/Bm+JuEB3GAoVPSyIMVOO8X1ex668U9BURPONYouI9qIz12dYiUmiePWk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1299
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 18, 2022 at 04:49:14AM +0000, Daisuke Matsuda wrote:
> The pointer imr->umem is assigned twice. Fix this by removing the
> redundant one.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/hw/mlx5/odp.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
