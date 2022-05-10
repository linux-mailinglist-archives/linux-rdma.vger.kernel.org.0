Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D727F521769
	for <lists+linux-rdma@lfdr.de>; Tue, 10 May 2022 15:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243040AbiEJNZ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 May 2022 09:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242652AbiEJNYR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 May 2022 09:24:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E9C1D4A37
        for <linux-rdma@vger.kernel.org>; Tue, 10 May 2022 06:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M44aZLsvCtHQeJUgX1xUivYope8aHKNx+7VLhTqHLsJLbLXNq0+3otD+82CFDkgZbCQ0TpZy6EN+38OBJ43tdLu+NKea69vxCPZ+4nzJdBxtr1gr1G0syBXsing0qwO2ssowetavSlNCXVRFjq4/qVDIVDBUfT6rTRRP0KlvvEfkTVryBHxm+zmH5XGJlvR2D0WJVDVUjUOWKK37mqqwr0zHb2dK3ZBBn2S5gS33B/Mwki95WaV03oYdQCAvqPhBY3kURPCLGiFuy5NvhwhK4xGpbt1n81sSLgXp0txK/OWaTVFUDUA1f3ybI35wCLVk89S9j4jVi4x0Psy/6sHZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0h+aHqGJ/KZ7pAIcMGUUskJOfxVwX5mii/hJ2PHa7bI=;
 b=fL+9VW4bYURd89d7hIr9U89j3KR4PgB06WMX3CXZI37WgMYhmOxP5ReTY+VZVX2GLMizGWBFB6br1M0l6+TGN4MDI+UG+JkIPfXUkwzFY3y74+cSGZBYdiBkWd9zauaaDQCxm6OJkLPb84hM0YFkJyxEXOv/oMzny2ZHb5NjshB+nDAxDYNx8ocuBfkIA9+bkeovjyTb1NZmfvrpMEcp5nPC8kpkBN3SmDSwS8Zm/kd7I+3q8g05H4v4ydAZTzvQrXJlwq/jvBS4waamrhbrw4I6nPyDMXMu3+0751/jiY9ivMyTzouG3GDyA5jG0SouhetfRziK0GGitghqawUdtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0h+aHqGJ/KZ7pAIcMGUUskJOfxVwX5mii/hJ2PHa7bI=;
 b=Tl9G1kw1uNFQqTmUyec0R8MWxpEpbiQgrM2OxnTG1+fFiwJiHUxswid0yzZuJgoiCFq1GoBrOpxamlhkbzOEA88Z2dvWuO4jI7Sv75ZReNlHp1BpA67r4LWnUhRH3l0LEIqzD0KK+9rI87VEQODYD8nVqdERBENZfo69nm9/dYDj6pKWT5tS2whXGjBMrxbDjzocYqQqtCOIJ411YyEQVzuWXg/cabzD3+sdvzVQTr4NnH3hdg9laZPdkEtVL+CS/90w1r18gsy9jRsilAypKtzLnn3yiSlXR9VnqunsTcFdcCSJAp8qBOlfkcDf9c6Js6ZEK6SCeNyT3ShqYnAymQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 13:17:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 13:17:25 +0000
Date:   Tue, 10 May 2022 10:17:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Message-ID: <20220510131724.GA1093822@nvidia.com>
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220421071747.1892-11-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421071747.1892-11-chengyou@linux.alibaba.com>
X-ClientProxiedBy: BL1PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af125d9e-0325-4359-c8ca-08da32876cd8
X-MS-TrafficTypeDiagnostic: BY5PR12MB5015:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB5015F04B79953937FFBD9E10C2C99@BY5PR12MB5015.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/OhuFkryIQnRLivHyXVI4Ym6I0fc3cHYtTAfB6/hctZAZVvY+OJmqrfhysizvCE31VielqJcxI5EA0cp2krRVmWTljRMLyAURjgwd/C7fcYWXkq6hKotSUDh0s8DiG+TtE5NTnGezD/5CiOTZJL9B8gPkwcz5yrtICL3pJGpDrkgCnjRxjy8tchotf1zFohWBRdUlb0ELws+3sd6otXVAYS42gcKxdgTUPe3/2g+4QWSWlXFCzWW09bS1xZv0BkaXgzXW4JRbFs923PUapBCTbt7zssUE57LEq3PGXZKFpbSIqFruCZBRY0BEH1AGkiyB2LFE1HcaPXJXUwTjibfFt8fJKb6xS93FUxOQwUl98QoZ3zA1EkdMhvzC4RGUY0v7NPvKkmwJmtEmSY14WiwuKjhco0SPFi8KrEJx/6PFFldCUyRo8sGFgvsM4H5bXLFpxM9SIU2IUf18JFWV74/uyEJyOHKde1ikz7J7uosbrb/sq4dpUpDJHxRUoar3mVxMymByxfwgImzKcCfOlBhop1d4wLABZ/WahWSOMNUPfuptKdkaYJJHp8YNG5QPF9SlGqKGvakAsujcw056LX0s3cPK580RKyvRMZ1HSFvMrq1RT+3gOWYsqVFEaFQSVOzliK7fjUQ0mMlq9BjkFrlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6512007)(6506007)(508600001)(558084003)(6916009)(6486002)(38100700002)(86362001)(2616005)(33656002)(1076003)(5660300002)(8936002)(36756003)(66476007)(66946007)(316002)(66556008)(2906002)(4326008)(186003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J+HI2QdtFDwPrr5esoIXQ0FTYwiuxj1F2vFnl+Ap5rdsdPeaBMLiGfvOSAGF?=
 =?us-ascii?Q?C7dsqT7TFdup1SUnl8gPRoHgNHz9vEG3k08zH7fY1TTS6T+8K6LXB9QnVbjk?=
 =?us-ascii?Q?/1eFuRNitUcKtIR2GVbb9ySSvtZC8Vj8eyqwn6YMj+h7pWTMuMbRu9J1t3YH?=
 =?us-ascii?Q?CyVlewjT1TXO7p+kbsQ+d/bFEO8PQX5QoItjwL16ReXa+5bEzETrGR/HZwQG?=
 =?us-ascii?Q?+f1Lg4DBSQmq7BWSUzAsDSYRZCL0BAlxw05iG5QeeQybc9xwfN/9COQbNypQ?=
 =?us-ascii?Q?69Nu2QgwgpXbeyChvmTxMmgQ/bpCbho2HEUn591OCSHOr7LF/YtnZPpSVpXv?=
 =?us-ascii?Q?s/etWaoPt7EBPp7XR1tQYfKU42rYJCKv/+QZ4+TbEJMJR5x9915BGVAcxIal?=
 =?us-ascii?Q?2p9BkG+Wh8Wlek+qNeqW2RZM5tyaRAfrNeyRjXxM/fL3xPYVJo5Kf6CCefUW?=
 =?us-ascii?Q?DvO9/petWq0Ai1yJ1dmBqVEb/E2D8f+S21u8wRYfuVeax2LhuzqVmpSmm5OB?=
 =?us-ascii?Q?TGUJOOTQeBG/uELg0TzbwNKcgLjkb9MxEMhsaBtfnyTWQaiIa4dchhww8YeA?=
 =?us-ascii?Q?IcAjcmHIejWW2P97gYn4KZQusH36fkBF+O+5FgSZmAFkwL2uFBLSPdqI3J+p?=
 =?us-ascii?Q?UdhZohhhTbexhof+6rWkbDqvHV410e4zt1mxDWDx3WVssPtcQDyzwh85p6fj?=
 =?us-ascii?Q?RXVM9oY3nb6DPydHjJYWY35ctGS0Ly6EQHNNt70EygH/C1sV4P3wo1evgyzv?=
 =?us-ascii?Q?qOZWKvqpRBlToynywa13G/w1trnPpqo3I0DgH9XwdyiFLn+Kiug05p2/E7xz?=
 =?us-ascii?Q?2Cztka0k27dQOn2S4X38x3TTzvF0oHFIoEGTLc9Rue+0UPdFQMQlCyw1YeW9?=
 =?us-ascii?Q?rb929mJb/FWoE+RaF+E2xTh+vpChVyjsERKrcTgu8kob2TXk2p3HOUEeBXQy?=
 =?us-ascii?Q?fz0CwDEp2H58oKvkMTcbQFe7D8yXIzI1i2UkxGirIkuK5BqPRVRfZzaFRW+A?=
 =?us-ascii?Q?snFZOohHq7Yt6EBljXutzFN+97BNCcrEzLFHoXIKAW8z9HUi+CtqFlRHQWGl?=
 =?us-ascii?Q?9sStO8uqMYH4HSE7xY5SN7fKpRS4FLq7DwAe2OVmiPhAnXw6Qq1PgDSfxThH?=
 =?us-ascii?Q?XfF9jQG6A8fdFZImE+f/TTzpKzRBKCh0+wvRwtgapQwgD/mHIzm44QWTF6vn?=
 =?us-ascii?Q?7z+0ZIEbggI00IHkovbXpvS5V9PKOV7+R/8iiyrRlSP3k42caq/fMK2PQnAQ?=
 =?us-ascii?Q?QyuK8ZbEf3LHYdt26V8fHlP3Q1JXBf4gjiSmPfRbqgpA0WWycTDtS1XivDQn?=
 =?us-ascii?Q?Z9ChcI38COgpY6CIsocEBHDQGFpwJErvLU6GY2ttCr9hq2i2NC6aLH92YdZr?=
 =?us-ascii?Q?U3xqC5ZXNSStVEQftuSnszHIi6sYVqqK/aVpigdyFjtyDD+d7ih6RKINEco2?=
 =?us-ascii?Q?V1Jz4zuv7DlhWEsZCVT1OOYsZsLE/V5Vywf2SzvOEa8fMApPh8cakyM1p4vQ?=
 =?us-ascii?Q?FNh8Q0d0entwv/U61zodgYMHMapD0Swi0mCvYB0H+wAxClWZvwbWCqrOnYEJ?=
 =?us-ascii?Q?K3vi+oa08cPoljM5LRb3oPGBfMXG78MvFM3Vw+jMEiU7FAqqnx0u5Nu+vr+C?=
 =?us-ascii?Q?SV7fsOn7p6vuqdqAMZKJaYiQ9YTRKwoHcG+7UT8fzn2KBLDaAKsWfFnM8fun?=
 =?us-ascii?Q?Lu1vdNF0v5poD9EquZby7Rold5apnnvR9dxAf9WT+PL52sU7BycIhnvomkHl?=
 =?us-ascii?Q?5t7lT8g1Pg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af125d9e-0325-4359-c8ca-08da32876cd8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 13:17:25.8541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApEFh+f+1KtzEgU6Fwe7wYEA39pzcwbCdulaKxunN0PnCr3F/uR+lbqk37JVamOr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 21, 2022 at 03:17:45PM +0800, Cheng Xu wrote:

> +static struct rdma_link_ops erdma_link_ops = {
> +	.type = "erdma",
> +	.newlink = erdma_newlink,
> +};

Why is there still a newlink?

Jason
