Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB06D525409
	for <lists+linux-rdma@lfdr.de>; Thu, 12 May 2022 19:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355527AbiELRrt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 May 2022 13:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355085AbiELRrr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 May 2022 13:47:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DC76A005
        for <linux-rdma@vger.kernel.org>; Thu, 12 May 2022 10:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9psUkN7H+HHgshdCnVVAua0aTb65tXWNVjARBfQh3FZTFh50XCvyXJAWFcT0zonQxSrofPJgovIlUJWCwYPRnjyyL+Pq6YWEpwUXb1vATL6z7ochsoIxlXwvCwwEgyhxGynpHnnDliEIH0cSgyJOSinaxbc4nFIYE3l7eanBkgGUMatSB4DKNzdAir+0n46O+q/TLwnrz9GQNH5PSxTl7bMYTd1rYg7gOzHIH4tpy9NEHMpGW2xjhkrsp0dZupTVMYH8plVgC7aiMN0Uxvup+LUfB4fxfJilz49ZMhk1s3jpf1aT8w1QT6btwvSgtz/vtymD6U7N+mvLbEtmbydfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjecXgRn6Eb0mSAC75k7WhjTTx21E180P6GPRSFa6RM=;
 b=A9GS2BB+nvzJXZUCCCGTwaAO1B6cJwB/RdaNvYngzyQu7yM6vxipVpD4r3W38J+JG6khF4b9f5c/HgUIjIZiugPeSOykYuGre/Wxi11UaOni/SNoUCIQuFsB6WE+8oxq1U0HdUP/Ir62iCzVDGDOfG4uCm1NZbOUscIt28bpHLjMTzXCn8TIw3gc1oYQECMem4wB6Fm/VWlPtxHRRgSs1FnwcKvnpECsc/GwUOrTkf3boJ1nTKTQ+/kcaMxslig9upU4tkbqbPZCie47SW9izKeJn1G7J+pS4vopolna9jzssoMP17B534exS+GLviOYyYRptDfOHtOje3KfQgrLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjecXgRn6Eb0mSAC75k7WhjTTx21E180P6GPRSFa6RM=;
 b=lK29BvNMe5dZP/QfCSGRRLkx/WFtvwapEdIBH1eYXL+TWfxjaWSesNYEHLWsvvKtJQ4hOaVVf3fpxE2lWEAzIm1CBZVU4FiURnxUogtmg97tEEnC1RJXE8U3/rkj9JgV6BTtBLDeVHe0bKUfU0Dlj4vaegekkngZbEtgtu9OB7R6Vl0BsWFfIRfAhoJNO2DIebh1Vftzu7htlebzAcebeoRl66lNlibYn5vUM6EHAf5TjaqivhyFyUGYmyVDC8o4lUsM85z11M8qwjKj0LjYnrjGgZrmjYZIO2u7SVxbG72XNv5aX8w4XMxvqQ/7VUaY//KozvwQxcFMAWdR1U8cOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 17:47:44 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 17:47:44 +0000
Date:   Thu, 12 May 2022 14:47:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/2] RDMA/hns: Use hr_reg_xxx() instead of
 remaining roce_set_xxx()/roce_get_xxx()
Message-ID: <20220512174742.GA1377017@nvidia.com>
References: <20220512080012.38728-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512080012.38728-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL1PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::7) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bb4ff34-31a8-4e67-2b86-08da343f84a7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3930:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3930532F0CF79A02FE899E60C2CB9@DM6PR12MB3930.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/r7W69B5jHATXlzQa7KOFJJ+E3+09m0fMICamas3cGjpTgU+QL8fGsSrhYTXiF1x328vMWJ6C6MT+EEHkh4rebEj02+huY0T761Y9QsKTEXuQlxkOZcFybZS5hH7gR9qyIo2slOcmNWSHaJiCYu3wB5STehrtZfhSUnZTJjz3+zd+Rnl+y/CCgdCUVzi48Wie/6ULDF7p1LPCyicjx+ANoAj42tPUuuX/tBJTeK2J3cM9658xalJzDCvJR6Lon6CtzJ/aJ45ziYfp0tU0S+9gp7VjHdp68ZtmUL2B/mWtf1dRCzBM2iNaysFY+9RSzNfKG+D7wEOuJrUfatBuQDLsJ259TuE8px6cCpM0mUG1hSHt4trJwmOhIZQXaHsVD//heH23A5x530jOQkN1VjQqgWPl7ESqXFdHrd4mwuXY+xYSz/e3N8k8MF6tJLOkQjaj3wZOxJ3I5OEAJJoerEWlh/Lpj39mRXNO1J2styEgNK+yEqGNUWW/8zI+tvkr9DLoCaSdieGVBtLewKUUrubzLIfkvPxyiRhi7kJKdoFr35TnUEGEjcYEJH9/+ytRFXv7l+/Hzmo3e6P/bswVB0ctmQYv3gLTQ+IV2T+w3+oMxP9NTDITyuRCpb1GQNkefWGIHZPRjgr2vDMxGqqMO0i1hJ7D9Z/1gV6OQMHoFSP5ngIV9LZxu+fF+cvyuLF/vR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(66556008)(4744005)(6512007)(5660300002)(26005)(4326008)(1076003)(66476007)(66946007)(186003)(8676002)(36756003)(33656002)(6916009)(8936002)(86362001)(316002)(508600001)(2906002)(6506007)(6486002)(38100700002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qSbN+tFuwlxjM9267kzxA98eEqyizOcmr+EhttU61uxcP0ggebSeAQJjAWYQ?=
 =?us-ascii?Q?U5Y8jF9RdS4AGmP5r2eQAUaxFlvg+oHxOMBfjcJAU5cMAjuK4SZ+wFeEezm8?=
 =?us-ascii?Q?tgnl/Ic1ES/v5foVQzIzMk4BStlLO5MPzrcGE1M2+auVwcIoKUptUptSSbCp?=
 =?us-ascii?Q?L+BN4UxWsiIzyfDeE3gwi9kK3FE1aoe9W5+oBPhwiFsCsg65fw7gjkHBF+wn?=
 =?us-ascii?Q?o3FbzHHyMmEppWmlgHYwL8TrGwo0rS9vbTujkqdMXPZ+jvSQg5eJmJ2OtMAm?=
 =?us-ascii?Q?vJWosspdTAr7Picyjqk8MeZnZT/Yu+pOjk7PzleCjU4HLhtJbixi+RYuxBIg?=
 =?us-ascii?Q?lKjt9NtRLPt4zcOD3s93YGtq5qZrvOBLoLha9Oa9mRVwv2F4NEGrFxNrtqCY?=
 =?us-ascii?Q?wYjH7pEgo5Te/qAqn8xIGRUaRialhFshEZIN15vgW83TakkTORk0sSTxroBo?=
 =?us-ascii?Q?Ke4Zhv3IlQEQgrxxtu/LrbKVcCFau5CPRRbsFWLiX78HrHIj1BR6slc6Nob0?=
 =?us-ascii?Q?FzgfOaTBALIs+eFSesWmjnuFTXMPHgZ8SXTP8jZpIurXpF2ja1dqpiVAdzxt?=
 =?us-ascii?Q?0WAGJha7x0tsD3dKRpxdhDEx4WyXf94w4I0rz91d7YH8VQVwAhiq7s4Hjwcl?=
 =?us-ascii?Q?KAn9fguVhSH7RUiOiZ13qB0arJs8b7WFush8tPDdkfQ0aXZusXsiGQZ5jLrK?=
 =?us-ascii?Q?Nv9HIr/EdYVahe4eTrw29DP4TJAap2d5igZHPk1OEXRzXM4wRKWuEoRtI7zS?=
 =?us-ascii?Q?5vVYC1G5NZB5ugs39CuM0Heu4jccIPgrBKe+40K3zR1d7VIghweUVOwuRgva?=
 =?us-ascii?Q?zk2X5ld3TwH7jrl5bp8kyQnOMj9BNZECgqOYT7D8K6y1RMRNjgRarb8oRlut?=
 =?us-ascii?Q?ciAQ1HwdpRPUGO3byZPOAqSarLOZTG8+UL8PFFDM4u6NkfG6Wjmd7IxL1IaS?=
 =?us-ascii?Q?cT78E4ZWUES/q3FgY1uXkLBPnPXUNeOtzVtaDV3M8rAMz2AtzMAg7EG0EMNl?=
 =?us-ascii?Q?BPGC0hW1rzwxjAlbHkeYgULZDdmuKbvWtpSPQ//u9JaK4jkIqDhdaZ1cHfZ5?=
 =?us-ascii?Q?+ZNrQXaa9ML+h1JUL4iKYAANOjwcJ7XTe+9i7RRDfQTyA79+VN+PXpuKQCf3?=
 =?us-ascii?Q?/PDsR/Ppg/NktxxYGjWwhOhwT5Z8xuUCVVbT5QrAUQmGmCe+xGyUBdilo88b?=
 =?us-ascii?Q?8ANIcTdePDcrIJor4xY+OUdvqoW7h9q1pFc3YnqRljyEExQIQmxg86PSH60m?=
 =?us-ascii?Q?9kUBayFTzA1B5eWG2ku1mB5yZ+fwTW71BcoFjt1PyRhJiW++GC/NRenCacXE?=
 =?us-ascii?Q?Fsa5C2+NYvthQhfnjYPSzMZ5gJzUeiLqUhPFs2WdLuAWbh2QZ5pjZsMZF0Jl?=
 =?us-ascii?Q?05ii+0DSDQ0ji4pVtZCGWN4YxcvOltnoSWWTo2iZ0xX7G8vewEr5Xp/wyhwh?=
 =?us-ascii?Q?yQ898DhyzodWD6/Fxa2+Nnc9Bu0oNSFByMHbt6SbxZXLatvrod1+QexBFFwv?=
 =?us-ascii?Q?dkCiAt2PJgIVUaW19dWvTAClyFLOE0ht45LoU5LIsONGYGVDFw5ubOiKAfC2?=
 =?us-ascii?Q?49HEk2332pmdYlnxYXcFvy/753EsPFqdxvPlhJr5eWPWPeNaniXLYpGiLwev?=
 =?us-ascii?Q?IHeIbPTVg92/aD2qlF4/37FCzP8QuKzk4ET2V2Ja3ijHez+RSmxwsAd2DfyP?=
 =?us-ascii?Q?dDbw7YLnILTDQI2dzzNeZ9jGw3XgEsK04+esykj43HhZ7Z6iv5lHBIA/15lt?=
 =?us-ascii?Q?14vivyQIpQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb4ff34-31a8-4e67-2b86-08da343f84a7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 17:47:44.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpUq+spdVvcsmUA+VB9LprzPOhOT6u31wmGro09nnG5R/MkevFD+eDfENDRmLywn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3930
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 12, 2022 at 04:00:10PM +0800, Wenpeng Liang wrote:
> The current hns driver still partially uses roce_set_xxx()/roce_get_xxx()
> to write and read data fields. To make the code clearer, replace all
> roce_set_xxx()/roce_get_xxx() with hr_reg_xxx().
> 
> Wenpeng Liang (2):
>   RDMA/hns: Use hr_reg_xxx() instead of remaining roce_set_xxx()
>   RDMA/hns: Use hr_reg_read() instead of remaining roce_get_xxx()

Applied to for-next, thanks

Jason
