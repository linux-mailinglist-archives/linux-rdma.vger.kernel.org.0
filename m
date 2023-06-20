Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4BF7370D8
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjFTPrG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 11:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjFTPrF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 11:47:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74065120
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 08:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFovQ8gq9a+eCyZSlqIiuAim19itRDBMvJM0D60rJSSA7q0ra9VeoBj6GKfiR9SbCroBleKq/VDA5UPhM7mNjAxnhCGz1yfRlhd17FT9JQCX5g1T0hu5OKLhAjfcXo05p/VgCKDFQLoLezZncy41Ae1HtTAhiuVfxIC4bFwpdjQBc0z6Q/Dr40j5RG8R9En4YO+JRaOASj6fvLQozYkohHT3Gio24M+sRnBDos3X2t98qgo/oYxNYAUQ91Ap8yULp/jG0LG8CBHh3bwcfuYKPxhDDVACegd+4cu3+wt+2iDsaI0aLrD0dp2daWv6Vtac9lHjntgQH2rbKdpiyVLK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yChhEJz64Yi/AWJVRyWOldm7P34042KUgnkhb5s/j4o=;
 b=Rk/uQKZXY1evs9tvuMdI4OxCzudzNaGBP8qvCPOgqM4jBOfsQpaVVHuOIaurPj9mS+qvtYFZYd+PVbIIZRWCFzJAj48Mjl125atVchzK3xD8rZ6aw2SSyYiDYvho703kF/FRg4UMQf+MrZ++RCpfAJYGXLoujti0aWiULzzLQjyhYSGsuR09ang+puCoNsm62yTAxPe9186xQbsdqQ8KDc6jIi3ZkwfFympWWmcnUlbeswNYayF8HrLEVmjgcTQSivBwTXbYi+PDWLIflQ/U7+v/906Sz2CPAWjh9RtLZ4uPJEh1WUdBdQVjfjy+vpPwlZqTWj/fR/i/+4Dv1Z4Iwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yChhEJz64Yi/AWJVRyWOldm7P34042KUgnkhb5s/j4o=;
 b=lMvRgkuY7Vw6kcvNrZE8dNGq0bzgjocIAgtocgby1zmA/ZdI8octBzTxxj+vfHXrjv9xG+BzmZHLxfxqnsQNkuBKmFluXkbtNeACuQQe4ZvuN5niRsYNoGLCFpWIgquA6i8U5QeJ71hgI1OBlT57vD4j3OHnBbVkJM/Mw4TcdL2Vsq6xRnGh6cYSi89JNuRIvbNs5TvpTuNkjZsY4Q+AstOsQzAS/fjM8EApLrBUXfur2axiVDvGfuziz1okpyvzliQXDTvpqvts0yyMxsGyODBl4/xQryiUcMt6mkExhFEfRuNfgYaLwla1ZliFgXkgs7xHsrpOEVxYWQI2jLTfBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 15:47:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Tue, 20 Jun 2023
 15:47:02 +0000
Date:   Tue, 20 Jun 2023 12:46:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Simplify cq->notify code
Message-ID: <ZJHJ88dfRADoMP3b@nvidia.com>
References: <20230612162244.20038-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612162244.20038-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: SJ2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a03:505::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cac6c5b-0e1d-442e-a151-08db71a596ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzcwwFAB0MrXBzXRcpsrZ3ot2vO717FFdGGUiHTzfsbuURtIlE/DSGRIDuXMKAi7Up3Co+dREKOpF9hKIyepge8mGFVBG330syjF1lIHbv3Am2vAo2rsLSqB446bshXnmAX9BIP/87WA+N5Ht6Lk38yjblbAcod0ulrTyg1nAU8NuJk0ZEfnecCH8DLbE2b9hvsFPcrl+hKaw6d1Bz10iyWM6H7cofJrn6exG4+a4UKYpCn5a1/+R4cC+i+5iZsTiwbzbJc9KX7wfGVAQyQU6KMNcUEyY3ISVuGh9S4HjN52uuu2khbrXp3zba1YBP1GbbaANebfsQnohScTIijVlD99VfYsR79CDc8Cy2dZNle83hhwp8xkKOq4I4qu0jYJ4n/cehymhUc9cexD+kCd+ZjzOyDd5gvtUm+zNkBP+bA2MLISJ+fNzTEudkN+2T6xcVZaaB6+7LZlbAOCEdqNmwshg7McFnuWNb2G7Yp7lsZB7WWL+089gcZkRmVRFte/oiCVc3oIkarwQoqe0ULheXzRU0vWtZIvimDFPq/LlHYa2urXFoDnoBOXltfSZAg2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(5660300002)(4744005)(2906002)(8676002)(8936002)(83380400001)(36756003)(86362001)(38100700002)(6666004)(6916009)(66476007)(66556008)(4326008)(6486002)(66946007)(478600001)(6512007)(186003)(26005)(41300700001)(316002)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OJEd7+0o4FjaXvSAoSvqUsFwZce7oPwcABPFqppt0tdc/snnz0opBSskFA0g?=
 =?us-ascii?Q?BJQXRO5RyazIggSWHJkamqjBT6KbagOT3bXFEY+G3/i0QOb4idLOEbZNUW7g?=
 =?us-ascii?Q?E4VbbxgFmKU4DIsK8AGvshggTPyLe3THwDguhHTsnX2C2Mp6IyDXxRRrrTx7?=
 =?us-ascii?Q?m9vfcanc+PJu/FD8r4qFNMb5bt7X+cXpzX6K70PX7FzXVkCIcK6C8IuXvgwA?=
 =?us-ascii?Q?ckflbA87S/qek5Q+8QPSJXJsyv89b095by2+JCsSOKWlPXovYjw0l2o5w+s4?=
 =?us-ascii?Q?vLAE40hb95VnmUP6sKfYj0YJjtCa/3SYFc7o8HOKe4aPSdGMqGtqy1lJweQj?=
 =?us-ascii?Q?GEVbXMevYQB/DuK4zxQSRWn75TzFUV3R7gcpmM2N0Aw4P75XEvPy9gjgv24f?=
 =?us-ascii?Q?oRVhrzv1J97e2inbIciHNmNJZmhbULlzw1Kd70c7BHPAMugrkJO6bCuGP9AB?=
 =?us-ascii?Q?TByIh4iXKFr6o+4U60IEC1n3ufv1NTA2IdFjmSTZHyrnh1EukDM4I7S3eGQ8?=
 =?us-ascii?Q?hQS/hqqovv5j7A0MLCtjpLKzzB0PoTJ71xAS80S7Wmx2BJT27eKZz2IkAtDd?=
 =?us-ascii?Q?otHUY7NevPJXfmZcxFpzEuInP6qg2Zz16fLm25fSS2d6lOMHlFUNR9CwSLFV?=
 =?us-ascii?Q?Yz4uS2ssbp3fJItms2FNbqVz0GaiOUGkpqoijh6CLa9pv86DNQYoKS4zqP20?=
 =?us-ascii?Q?jvHZv5HzWTdx2VYrDKuj7kZXnfuJM3r/3Gc34dcVm1R/kXHzNMEoFBOscdQq?=
 =?us-ascii?Q?ZZPhkcux8maLRkdSNAZfhCDwHhnJETXWx2kaCZwymeSHBq6xiqvXWC/iu/pb?=
 =?us-ascii?Q?2yVcp6VUL9+8Y2UFXd4rmget+sWVyQWA1T3LQ67MDx/3PST5Nm0veyurp9Mh?=
 =?us-ascii?Q?F8YXLT3Ud+Bp0xB1ALK+S5PsVV/Fa0guG8cKlcrcoaHrUKVzVXRhkzNC368a?=
 =?us-ascii?Q?QKATOphPmYHDd3CvK22JPQ39B21Ag2rhqsUi5GPIu3PU6p5Ump1/GoPYtyHg?=
 =?us-ascii?Q?IwzLiWwVOVXixRf5CS7xhhWH8YSMPrhmY2cBjYosB7IWP7RW+OKRY1+2sgL/?=
 =?us-ascii?Q?KTY77Rtws84KNbVknAK6WgReSITO17sfTdQDYQoJf4LS3vMbqDEoDaWKMUlY?=
 =?us-ascii?Q?5tSKslB4gSSzosFaCHjtSKYopTz41cJqTEnAk1b/jEpLXbRovwdftug2Sjba?=
 =?us-ascii?Q?PG3wsoWjjARCEc+innq3Z1kNgu8/5PQ5gjPgHfsKRNlJau7KqXms81uVVnGp?=
 =?us-ascii?Q?f6M69gWQyhX6W5bCZAtepWxKWVOlMrfAb674/ODHXwkBtf55LZH7YxVgQ43D?=
 =?us-ascii?Q?bZIkATim1hV4emmfmfh1fUEfAU40Elbl0HXEXR1lxkHTdTFpbS8BW1p1yYy/?=
 =?us-ascii?Q?5dlQhSr5EZ53rgh2957mhwD3wr9HR1plXuUwvLMOahStVr0QcAkhEY5E2Sty?=
 =?us-ascii?Q?cFEw0a4yS7x1nkdBFRRU92uy48WNIJOjJ2YRQwoGzuD1JUJ3lm15xouvljaa?=
 =?us-ascii?Q?IUHzlTFij5bheUun9rw0T5zLZxklkbJ16t2Tpjwqniwtta5C/z7RoZvYARg4?=
 =?us-ascii?Q?7KzLlfFoeh5d85Kcqv7XQHsqw+FnEZ4C6E7Ljviy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cac6c5b-0e1d-442e-a151-08db71a596ec
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:47:01.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdznhjQRgXgSgmudLpriduZG63/6d7Svgk8HNr8JzLNjfubvNoXMj+WqHlOubmGV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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

On Mon, Jun 12, 2023 at 11:22:45AM -0500, Bob Pearson wrote:
> The flags parameter to the request notify verb is a bitmask. But,
> rxe driver treats cq->notify as an int. If someone ever set both
> the IB_CQ_SOLICITED and the IB_CQ_NEXT_COMP bits rxe_cq_post
> could fail to generate a completion event. This patch treats
> the notify flags as a bit mask consistently and can handle the
> above case correctly.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_cq.c    | 5 ++---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 5 +----
>  2 files changed, 3 insertions(+), 7 deletions(-)

Applied to for-next, thanks

Jason
