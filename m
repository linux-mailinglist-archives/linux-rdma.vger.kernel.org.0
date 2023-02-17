Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5130C69B414
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Feb 2023 21:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBQUlT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Feb 2023 15:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBQUlS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Feb 2023 15:41:18 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE6E3431E
        for <linux-rdma@vger.kernel.org>; Fri, 17 Feb 2023 12:41:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0Gp3CN2BNosJQSev1pptL7lIr6ItOpPZL0rdOTOTV4E6n7mCWNtS1jZ2NZc5lhD5ElO54rhQUC3HgqagVBbj75b7iGI5ggyMMfHQQmd9rd91JLpmmSKLkYatbT9fNt3fsPCjva09Ui2edT2ny6Lq1xF5IowJRaI1zxoONVrujLKQ8GidukfWdsQOIWQ9nMUGwbM9E39kH1aBS9pfo5EMB1db43slz2pzY37UNLTsI12uWiYKaqaAdiZ10yWWFcRT/w7k4fqso2ppz6Nz9xm5TqB6jWPxB4NJ21735FbsKVEXCcaQ5S6gbTd7orjxJEcPwfAW0eihqAc2Sx6ccGwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CmFo54CD529qogGRHZSoshfF1EvxKKQEwG60jtCTjc=;
 b=DyAL/B3gCVgEPPKdn4sLihvN96UjklX27lnHblPYrsw2+B6XfXfteI2SBtxc7BO3DVT+3JPtNADHD+XaQzdkhD0q1dnVIBr/UKTHuTUCv8fie+JD9s3aBzGqJqNpp8TZlhm6Db65bQjTyi3CgBbdQWC360b2E7MckQWsfDnkNSSFQYxNts+Wr9YFnYhgLGI3xJjwnltCisTlNgA6mBXtQQuP1c1ZfqA5AkjwCK0J77ctSoU2fnPvR90mQIp96o1pTdMh7bbmUYBt9y2tC+FPNRe4p4IcxTjRPAWOXNYKJrJPcsC/IDvhwmlhHtiSzlG7tcdJQ8zAIhza3ZNcPNYo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CmFo54CD529qogGRHZSoshfF1EvxKKQEwG60jtCTjc=;
 b=abRuHB2+TmdKCW0D36ac9L1KBAKzy2nn6wIr/GavDF2bYouFvHMEX1XHpqdYA+kTQqBH0StGxg8tsR3x9TNyzJYvhg0IHQ/lQXCQbbslTgRyDYUodPhXB7XHCB+lakHOvmpPbpzGA47ndTbiE4iW6HSGnz2aZzWg0MDBxMvXuHET5PNYLJWz4flXFoHAIiTAY1s4zBfv41qMp/Sf8P2upfkQ+94FJU8BcjnP2/j1B7Jyu4m8gXQ+xsxdHgRVehB4pPapbDBeUfLpO8EMjduebOolRRVbOhkvslas5huI/DKjZE90Tq6wW2HmPsvdlrjRiv1u+irDB6IPMjdRwKR/jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 20:41:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 20:41:13 +0000
Date:   Fri, 17 Feb 2023 16:41:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] Respin: Rework system pinning
Message-ID: <Y+/maP/69VMafscx@nvidia.com>
References: <167656602090.2223096.15523567129751109800.stgit@awfm-02.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167656602090.2223096.15523567129751109800.stgit@awfm-02.cornelisnetworks.com>
X-ClientProxiedBy: BL1PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: c386408f-525c-40de-5348-08db11274f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5olwpBcPr5gmEvM5puOgjAmtvo2BwaJr05LbvKmiYIdCFLD4MzM98uOlfLS9iZssYTsB63N2kWYk+CuQeBTJE5kSBk1Ic18LeSChJfI6tMp6eAQj9vLjFEZlTFVsnlT/iSuNcv44TevvmHjWruXaQGsFdCoGKmfhpjpjVwbLrQSBonQlo0Uepsgg79VJIbtfKoPEtnkULM24DEANrIi0AL11zWvPzPqFKcq66jWqlYjL4BazN77mqeyLly0DzmX3yT89YqdQERsyMSVBO7Iy87YqFMIfRrH6qbdixVEBHUDeFeJencti++FJpI6TTWXdTyr8C0TQgfbOQvMeyyv06mfemvpzjSd4DDqMMpR9Vo1y1FxHswm/ffFAb4FK8StMz+7HoSVwx2HsZmZxLUg/y6qNgybJvmsLlOtkvLxyyINyhL8VkGbRh+PPYD3eQ1XnIhYopTfN025Xh+i78x2vW7r2UvNmVrwh3LDp0Q7Q/uWPMLgu9eU1N59JMj4zZPT/kowjwGe7j+HMb2pnNPKDO2ZNjQ3KR5qDOWdzpB3y1gXuLxW2PlgEzIpMopCyGAJ2poFbMh+x2bH+hgExQ1mRSLsWOCRc4jJokFjgoSg8Jnwaa/5orSRBNAuT92KO3BcAkHAUXxJMJwFu5dE2WFwpDRzyS/7GTenKhvKwOqdjyU5jWNjRzCjbDREsu9oijWn1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199018)(966005)(2906002)(2616005)(86362001)(36756003)(6486002)(6506007)(26005)(6512007)(186003)(478600001)(38100700002)(66946007)(4744005)(5660300002)(6916009)(8936002)(41300700001)(4326008)(66476007)(8676002)(66556008)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HSXq7yEmwIBMOWJVod7RFjA7adAkxzbwUB6IXUitnma+bWjQgQGp+FJ0OYw/?=
 =?us-ascii?Q?tbZZmss5RJ7mpGRUm9pGH3T6v2Bd7ldnovGkUSau0pDLnqydpZ/9COixIMZm?=
 =?us-ascii?Q?a+MVoDCesEdIpWXLUgEUTrYTGeypw7HgmPUGJtYo3AWh8fjC36o2cdlj4zXe?=
 =?us-ascii?Q?Q+6Hh+0gNErlu0kHCoiQBo+gb9abHWCJfgSe16evFMolvrOYPBwv6aoI+cZ7?=
 =?us-ascii?Q?ZQq0RMmmELULVBtgJe/ef4l0dfFImJfAlftzo5Z/3mwJi5wdBaPjlvr4iggj?=
 =?us-ascii?Q?a8bbW1ig6Dl/W9nFV5jnoztRkk3w2hGgl8kIrEGTBZCdJH2BCDSnfcKaF9+8?=
 =?us-ascii?Q?SVTO5vcR6kFDTkt2VNJclyk2lQWuBPUcyGWOyt1hfrDULJ3WQ34/dtf/lIkz?=
 =?us-ascii?Q?lXkkRoiyoCtny6uMVUmIF8eo/PEmpauAClqzSd/rUi+9ci25ubaZnP83UXlz?=
 =?us-ascii?Q?+DwG9rHheHrsPJo4YJhImR2LiKVELTJLB9nKpnmynoO8jq5CEzXpzsTwhMjl?=
 =?us-ascii?Q?plWaHGyEztw9ACGlr5ZBykq6aUXpFi+0cKZK5WgWz3w5TvYaHFQERy9zyLNi?=
 =?us-ascii?Q?A2P5WUzzR35z47cD/r5qI6tC8A+CblMx6qVx9VdLS0CvsVC4G+3fFkdqGbhp?=
 =?us-ascii?Q?IP7qFEfq/6jsY54thnGZXlmitv7rw2Na0JuEiFhJ4NOCXyRAgrIZGxxfHulA?=
 =?us-ascii?Q?GjZ9oCazC0CBcVnwCY8HXmuf2MFua4D9SijW7PxHj5gZKmU7YbEmkfv9aNZy?=
 =?us-ascii?Q?gmjxTBReMF7LGjqHXtAsu5gVgWjXNx9ZJG6hxeraM6iuTVGe26qr1+XgTf88?=
 =?us-ascii?Q?U290a1aFNX4R/S0aM37GclBruQixXcv2tEP2YMWDXNzIy7/ReGwJ0hNVPJ7/?=
 =?us-ascii?Q?l8cThhpHTwsaDCxWwHV1t3GKZPBI54E3A08svcIgXMqppsgRd9ScFGk/dcCo?=
 =?us-ascii?Q?/OQiZoNDZkDLU3arCnaNoVUDJ9t133QPjL8L/aXHO5//8wWrEu8PFzBnLzKG?=
 =?us-ascii?Q?dg4BuQ9vUK1dvHVM6Iy7WZtAy/ESqYOBkmGU/gsMlkrM+U0s/CPYcEdyiHeS?=
 =?us-ascii?Q?PTq5u/9QwZqSr0UZD6sMYU0YZUepx8rdqcRGUWStP8PftpbZ/HixTTckhseV?=
 =?us-ascii?Q?eYqUimwUYEUoLVZqtJs7RgiTaIcNYJa665O2hEVEnyva/sT7snCHcqpBTbK7?=
 =?us-ascii?Q?65bZEyU/Yu7Js5jzxtJsEZWVgfoRk7fTpvxFnx8gUT+tkZ+hAuLfvboe97FS?=
 =?us-ascii?Q?5z6GIB1STm1iLRJugAx51XOSvas9/hcrs8zs2oYNigTs8SqkWYBklrDv5jxJ?=
 =?us-ascii?Q?gKAdwXakOqWvyCml2rumal5bCuo9ii3phU5d1ymKbJPZn44ZrFUvtsK4SZt9?=
 =?us-ascii?Q?XEvKnfFLguk2Dhvnqi5NLcDLeh8fbbDKBy4is6aqnd0WnotJCrkQ9wRXwfbN?=
 =?us-ascii?Q?mC+8dMFQGlP2T/vo304QA4o0OnfcOhcCKqhF9WCb5xEEpeC87UPrxw3BIy0j?=
 =?us-ascii?Q?vrz0pTC78NEzoF7GOiO6gL7T19rhUoUiiAxidI62pTaMtFwKaNcDc1zMAeIz?=
 =?us-ascii?Q?6JSilLtO6Zy2odoJOpldVZG7t7WrIS6TlZyuR2vP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c386408f-525c-40de-5348-08db11274f71
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 20:41:13.9155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yIMyBNpk0Ty2+aOUYOC4itUDYGUWFzKE5U2gpWXI+mel6jdPB1Zs7ezgYSajZjs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 16, 2023 at 11:56:18AM -0500, Dennis Dalessandro wrote:
> This is a respin on top of the latest rdma/for-next branch
> of the series being discussed on the list here:
> https://lore.kernel.org/linux-rdma/Y+EbyU4HkGyzPoFO@nvidia.com/T/#ma3d153151adf1dbe2b9800000fa9a01f95a80c1f
> 
> We have added fixes lines, and Brendan has discovered a couple code hunks that
> do not need to be here in this submission. We have also removed the stats stuff
> until the user side code is readily available.
> 
> ---
> 
> Patrick Kelsey (3):
>       IB/hfi1: Fix math bugs in hfi1_can_pin_pages()
>       IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors

I took these two

>       IB/hfi1: Do SDMA memory-pinning through hfi1's pinning interface

But really? This is almost a thousand lines in just one patch, is that
really justified? Can you break it up?

Jason
