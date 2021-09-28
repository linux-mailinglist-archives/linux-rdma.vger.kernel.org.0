Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A50F41B259
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 16:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbhI1Otz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Sep 2021 10:49:55 -0400
Received: from mail-dm6nam10on2072.outbound.protection.outlook.com ([40.107.93.72]:55137
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241152AbhI1Otw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Sep 2021 10:49:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/nOMNwOA8qUXa6DxaT8XEu2wzX0f6Rx2tMZ9nzcGVpJQ1sIwJUXKbopzAAbKyuoGjz1YPcUz8uw53pkOJi8xp11p6dR5SzDARw4b0C22LcFK4UniKU6yEwG8CPrNxO9QSJ//emSPsu/fGl+ObikZvLbHTTjQADz4yBvfOr9W+0eXRFqXcT5cXVhYvVXO0Vg7aRjJ9qHl09thKUfedmrwsOSgPDTeoWuu02fZmAcDpxW+DKxR5eRLcMmqSk9lyMQgk3m7GK8Yn6vI90q0UtBg5TEsmc8yiA+KJ18Aumm6HyY7xROXJvrQ1kJZJ50ZQPhU1Gt5uDbUQ+dPsWRhDikwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AfMOIShDJA77+lnXskQ9/mMU05r8OzpwdL+jUzp8QKA=;
 b=hMZ7a75lST0h1IKTs34ABgzd55nCMSX1njLdsn6dFtkPvIsZqtEXoxClZuOUt82xxXLtGzyFfUBKY+u/yF+uqCbFqFFkUjuB/77dxgPJwHzz/8t6iXBUv2MBcG8p9RZgLAJ56Qi6er5gqs3QkOBA3KlUszzHrRz8GH3HwLT03zyX5N1Xk3BxDeBh8Erjs4AmxP4VwBcroATTtlX2W9TIls8cI4HeiTWjw3tA2Q6v4mxw7cd77+OlM4+7NHfvJ7kZTyjV1eaVi01l5g8Y6PsthveG3pnaNwhPXEX+VU+VDTQNdNxtxa+7VEA3BZzbebzNx0U6bty373WHYwY3xwpLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfMOIShDJA77+lnXskQ9/mMU05r8OzpwdL+jUzp8QKA=;
 b=l0blJ4iRl9Wn408IhtaFB+5JNZGFLXlxnTR8QcSrdknyw1MFIRd+91+nN1jgVBZBRp6S680eXhhcx2VaslvEu9oglU5NASUIJM2liwyDo19SomsC0pQL60yww6A/+wi5ztieUctHYV0FMaiIE3qDOXSuB0GG4ZcnpY45jeWjXpLTGwxTpbfSI0sD4EKQ/TyOlOZZ9ZVAC8bkiA4ZOty91Xl67AelSj4ELu8KzrSMq/vFP8x/unbRomPE3D5QfBi3pLHRq6HbEuO4LwPc9SG1alWV1PvTc1p1MtM9NudJlDEL5dYo1Zv3pnY9MEgLIZvAE+CqCMS0WLe9GCvuHqrrFw==
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM6PR12MB5535.namprd12.prod.outlook.com (2603:10b6:5:20a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Tue, 28 Sep 2021 14:48:12 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::3817:44ce:52ad:3c0b]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::3817:44ce:52ad:3c0b%5]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 14:48:12 +0000
Date:   Tue, 28 Sep 2021 11:48:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com,
        zyjzyj2000@gmail.com, leon@kernel.org
Subject: Re: [PATCH v3 0/5] RDMA/rxe: Do some cleanup
Message-ID: <20210928144810.GA1674100@nvidia.com>
References: <20210916124652.1304649-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916124652.1304649-1-yangx.jy@fujitsu.com>
X-ClientProxiedBy: MN2PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:208:c0::29) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:c0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend Transport; Tue, 28 Sep 2021 14:48:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mVEOw-0071WN-RI; Tue, 28 Sep 2021 11:48:10 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5065d9a-c7b2-4187-56bf-08d9828efecc
X-MS-TrafficTypeDiagnostic: DM6PR12MB5535:
X-Microsoft-Antispam-PRVS: <DM6PR12MB5535212E3E1051C09010229EC2A89@DM6PR12MB5535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzBbjIAfcS/ojoj4SnBhInY4aC57t1UYFoFVYYeZ0i40ZqsfIHsQlR4eLjaTm8YQS+4HSsNVawbPq6vvsQcJ6x/K4WUvA37TV1lK/kgoGZY13il5lyz5mX+O4fEHrL9Hi2q+HJg1iPZ5KcW+sjKq43AcYHPlS/t/qCXafexw83HMCManpxkmAS3D4eDgJktf+ydhDEtRTgt4MJauEGjCKFPvx9nu/h29kSI5OYtk0tCIrApJ5yG7zF8wN1I1CTJuoudGjhE52tRTGFVsMf74TQHLhjBokCVFQ9y/AoSVKHHceOY4zJyFgcn6e35B+tPbif0ocw8NIazp0/obgfGN0iSccQKIS461bCdNLm3rV3a/DYLDcrz6FYK+pDfg45gdEP5CWKzYeryGB8tKE8kQIei7PuFVYQciP3d+YRU0OdLtMUwEOAi7DGvs8gqrYo44wZnoZRVjITjf7Z7UVZignwJQdFRXyL3G0Ty5XEgp4t2qEbwHfrhZMpnuhA1mq8doq/NNfDJnmkDOwegFglVdO0NIDCg/CJpKcWl/ujzrVzaolsE6Q5iKfzUXaWSHg/lMWF7lrHp6wdIEeZeIQIK1qzvhdNETLfgNAY3IW+TisxOQ9Wbda0Mw3go/XE/JBkLXpoGqqYPFSfpIdAr9mhNYdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(66556008)(2616005)(316002)(66476007)(9746002)(5660300002)(4326008)(186003)(9786002)(66946007)(2906002)(36756003)(26005)(8676002)(38100700002)(83380400001)(508600001)(33656002)(86362001)(426003)(8936002)(1076003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TR6SeVhaFMH1bk565rvRrXILAanzQ6MfL6JiAZyp+Q5GN7x9oOaXikj97J5V?=
 =?us-ascii?Q?6ORarB9CMLOJQY4G6YpBaNeSixfXZBU31dehlQQtvQD2kFx0vOi08IlaUQev?=
 =?us-ascii?Q?1G5PxEiDrJVDttndUzfj9piQ/B5tP/LE7yomWoKNzP6xSdQSnvphIKMv2Jft?=
 =?us-ascii?Q?GUK3xY+3nAsOw0bggGt8PJk9rChH7qdjZAwhBC/W0jlHCRpQskJuYQA/l919?=
 =?us-ascii?Q?IyF3bfNlTdarZiRUrwlweoyiKNZlNdfoUCWGVP79N0BEQqFlyQu7Beir9DSe?=
 =?us-ascii?Q?FpjOAIRN+9IVfKYKalYJJqgRuwU8uD6QBrHQybe8Qlich8agJL7FUCtohQD+?=
 =?us-ascii?Q?sI8VB+ll+S0yeFrag1iU14kueF2r334cL8NSA6UYCqPGN3YkXS9l3aGayXhQ?=
 =?us-ascii?Q?5hfhf+Q0CVgAHjQS773pIqyrYBI6P3dhquHb1Yrw0YZSwkRptOiSRSEB4DMQ?=
 =?us-ascii?Q?x0QHAiCrQeZLwwQK2M/vMGI6LOTFbwNpgUKrCs2HQOeSiHd8ASCIFvTqAtM2?=
 =?us-ascii?Q?AyWcptPWk+Ysey6DDRp08ZDqJyjaWu7i5yFTe52EeDzPaGX3isrTJrTe5MRy?=
 =?us-ascii?Q?GtAdrd7avrUTm2NLyu8SEBeZDj0MnrMIF0zWXBZArCq2a2pAVKV9nQhDGdol?=
 =?us-ascii?Q?FNd1DDlxGb17d6zn1CUCqrLfrbZV+cIIkgLEob8yZK0BQXOftzarc7RTq4bs?=
 =?us-ascii?Q?ePUVilVVB0lhtpJI0Ivt6/N1GZMzmRDz+UW96HCrhanWytBezjH+zH3wmTNx?=
 =?us-ascii?Q?1aRr88xhVap2hS5+L6/6wSPbAK6x7CvjFjfeiDKUpwV0VXsANJswcGgZm5mO?=
 =?us-ascii?Q?z86IOBshQlxppJ7CRKvfrpZobROTIRWQBGmJolZgwf/zaS018JIkeyF/5Sy4?=
 =?us-ascii?Q?rlH9ETKFl+R/7bJTdICjW6nJjJPcqslSWOTMAUWDyEqefI79hEw2ImfXKA2o?=
 =?us-ascii?Q?Z0VmIABvnTNWz2lgdHUKZQgF94lvy5nnPqHna3J8YUsiVl0CMPzaq/jP1NS2?=
 =?us-ascii?Q?K/2bLgl+UlVmsVIzh8Y+tT/Z2za8T0m8zIKDrNSGz/QDSi+aBi2S4h/7gAWB?=
 =?us-ascii?Q?AIeegma0VGIrZ1gItrPRltT4uvZ1HnKMMgfE7dsIOh2BR5/WTpiYGkY39mBI?=
 =?us-ascii?Q?C31Yl9qUDEm/sEyQwcLu5nhvb74FlP2fdUng40H3iJ/J0RyJoz1sEQcUYfAb?=
 =?us-ascii?Q?QAGe6U38In+6YNSuJenW45rUAzcV5E/2++le2pdFM1TmFittltgyRqP+w2JM?=
 =?us-ascii?Q?fRrY+cg9+OOYE4stGYZrs3HkHYg1v08HpuI/arr8fTcgI+kSmThHE9U2tMnD?=
 =?us-ascii?Q?e2tfgaUptsruDS3BTDAho1Ie?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5065d9a-c7b2-4187-56bf-08d9828efecc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 14:48:12.3189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N91yO6q3xp50uOUa71R9dWbTFlUo1DWX2bD4ssafBcCNohrQzDBzDLNcGY/eG/dA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5535
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 16, 2021 at 08:46:47PM +0800, Xiao Yang wrote:
> V2->V3:
> 1) Rebase on the latest kernel
> 2) Drop the ternary expression
> 
> Xiao Yang (5):
>   RDMA/rxe: Remove unnecessary check for qp->is_user/cq->is_user
>   RDMA/rxe: Remove the common is_user member of struct rxe_qp
>   RDMA/rxe: Change the is_user member of struct rxe_cq to bool
>   RDMA/rxe: Set partial attributes when completion status !=
>     IBV_WC_SUCCESS
>   RDMA/rxe: Remove duplicate settings
> 
>  drivers/infiniband/sw/rxe/rxe_comp.c  | 51 +++++++++++++++------------
>  drivers/infiniband/sw/rxe/rxe_cq.c    |  3 +-
>  drivers/infiniband/sw/rxe/rxe_qp.c    |  5 +--
>  drivers/infiniband/sw/rxe/rxe_req.c   |  4 +--
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 14 +++-----
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 41 +++++----------------
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  3 +-
>  7 files changed, 49 insertions(+), 72 deletions(-)

This doesn't apply, can you rebase and resend please

Jason
