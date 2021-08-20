Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5833F32AF
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 20:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhHTSEX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 14:04:23 -0400
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:21758
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229491AbhHTSEW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 14:04:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHb3WJQDUZQUVXkppj1YeqWZi4HNDIzF9/8F+Bb9pfW6o3fJ7ZdoVOM4f/96OLhT5m0YPmdQQgYhJczE2JWRIlV+8ZbYbmxCY4KAb/IKmnKdsL3IoVJ7gfdrG/VSjlarIzIv5cJA87mDdJeYWrzXFYYzUT9ZG1YkwFTVXrHt+YNGZyPbgX1dzb6q3iE6fxgm1PhLnL+iPBy3UptnXYHDKjkxG3z1ZsPDRE74tgEQNzWAr1a7XZhQhIj0T3Hqzp2Ur2fBKmjtQsttz9Q9DP4H1JnGAvUaBOaauJEsgppeaYWeyG4Smp+3my90fiwM8mnSzNA+dvxAwnEVbBuTYRRriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9T7Szg1tkpHaclR0id63CLSyYpeBa61AqC+5d7PfVM=;
 b=U7BSu1gsFN58rZMSa7FlHrHaXZgxLLJ2+z1WSk4QAiHZ5BwjPAVy4LrtlEjWe83uq79YbyvLOZDefC+DfQ7wmMTNkINfSKtcZ1MXG2cbg/1ns8FTrzN73TsHtizy79sxtmKXzcTsOlguAG3dBM3Gv6K+g51AwjTeyeQHta5J1zHTWKwEq8FtModohzpflpp2XHP8h6/R7N1BudeK5AGPCOfxLR0vRHO0tU7cmiFRjkEr6m2PGjolSga5xh9uC94nAxknHacUAjANx/UyRWMoRC2agDiKhLFan0HrUePqlajzXJ1jOCqpk2DFxbtIyNfbnb0gc7eU/KY0F501n+CUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9T7Szg1tkpHaclR0id63CLSyYpeBa61AqC+5d7PfVM=;
 b=U0HWjjNSCLM6/xoZDvV7dlAcryosB1WLFO3t1J2yhHZQuJVtqyQ8UfHHZbDEqIhe2lOlqxfkNhJv4ZB2pkDmKnSV5+gsp9ycexLqEuLrpwVaCSqge32ci0hiQ6jVU14qFUv6xI0UjxXZ9j/5UcJrLTOECcWbvUHLnAOWAyWTHj+RWc7mCvivc3ixZBVupUsxh0KgiwqlWTdcymMfAr8dZpyPchmlkDv6rpuRmFeNRZQaYZCT2nH3jq3o7uIez0EUL7L9v1r/Hr1lGQARAQiXaHUxzLpAOLLxkjVAraHnT1b1K5XhZNFYqCpklhuK6RHINfxJT4SCtGoUuHoMqZL0zw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 18:03:43 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 18:03:43 +0000
Date:   Fri, 20 Aug 2021 15:03:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Shai Malin <smalin@marvell.com>, linux-rdma@vger.kernel.org,
        dledford@redhat.com, mkalderon@marvell.com, davem@davemloft.net,
        aelior@marvell.com, pkushwaha@marvell.com,
        prabhakar.pkin@gmail.com, malin1024@gmail.com
Subject: Re: [PATCH for-next 0/3][v2] qedr: consider dscp prio for vlan tag
 and update tos
Message-ID: <20210820180341.GG1721383@nvidia.com>
References: <20210730065001.805-1-smalin@marvell.com>
 <20210820174944.GA539584@nvidia.com>
 <20210820110251.5058362a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820110251.5058362a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-ClientProxiedBy: YT3PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT3PR01CA0107.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 18:03:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mH8rl-002Igg-5Q; Fri, 20 Aug 2021 15:03:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f717c0e-4f91-4101-45b0-08d96404d8c7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5317E78A60BB9C831E8C9D94C2C19@BL1PR12MB5317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: suX9ySqkOhUNZW8PhgMS6b1kAN/LpCQqmN47YNTOXqCqHAiDOCfxrlfLJDS/p15MmeOj8vkOJO9Rd8VhuJ5YQ+xU5Ub1I8zh2D2VqCXmHhzRlVlQ75vj0VBN6Wx3Elo5x7RYBoxsevxrhacXuDM6JlDxeCWQRbrXoj9R0sEm2O/V/37CcBl2PK/k2vKacGyK+2/CyxWGAQbRzYgY++cx0TTzhQcOnph4N2u8om7nl1IfpANpQ5GHoHazFwLgcUlfxE29DUfxvjQtMcipzT3VxUq/mQjAa5R/X0DTRHk0v1GASq5pJKRJyIf80rF9tjI/kDz+qcuxxHQEn0B9DwmobcWi/t6K7PMpPUx+PHlxOdoYdyrXyR0/l4Sd+yX7kklvqoug1V6DtmmFJPSJhd0sFyglXnFs/cGZR2pq2/0Le/LKnk4AjCz3ahu6KBSFOYeSpfO41kQvsLtCe1O9HLmHlZti/48QNBn1tM8ypXhGPEWIf3VSin/axp5FZ9B7mARvGARoXkULSbalf+lv2iwBObHLGQz/fS1TrOwTcXoC6XkoV/bQ1bahDGke2eGECkKe8M2WAF9nL5GUvWvqjCQgiZZnU6B3cKv4nUTTT6IfMXZxKn5/CzXL4ZJQwdX+wJ3EZO67LeFHMKxEP/Wog4fUGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(426003)(9786002)(66556008)(9746002)(5660300002)(8936002)(8676002)(66946007)(26005)(6916009)(66476007)(86362001)(186003)(36756003)(33656002)(4326008)(7416002)(478600001)(316002)(2616005)(2906002)(38100700002)(4744005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mr18BIyTxfzdIyoQxlOoEMB9uFmQfFZwSJZGHxlC6HxHLUJwa8t6HGDqxiCm?=
 =?us-ascii?Q?oBO+5e3fZLHvCoAozQ7bYXeOOQGLzXFAfPsCee/f239BYBxa2oAAE8dQXurQ?=
 =?us-ascii?Q?vtV3VYYeuj1o5sM7uxNtLRMChgnRhrN0PrvqhCu7MMPBaKhZt4O6HL8fqSWQ?=
 =?us-ascii?Q?0PFB00l+snWn/NjrWVq0k3eLF5PxO9MlEmTal1P8Fvk6Mc5oBKxIFDO3pihd?=
 =?us-ascii?Q?DKjgSxfAKe+yEzStB4kiWKyyvcmetus/P2Zx+A7Bpf0zYiHfkNhs6Q/DkEU3?=
 =?us-ascii?Q?bBWPTFvH7SdhB8S2vZXzlLVyN9TU6eqZ6WvnXtCkhdIZUyUGsf5roZNTeVnE?=
 =?us-ascii?Q?pcug7mtdUq250MuiwAwtl+66C5p9BKXDgD1vUYl0QIQnXmyNZI8t5kVkh+KG?=
 =?us-ascii?Q?S/tzphLd1kySjG7LJyWNguZeCb56jxX4pWFZtjovIfOWcrdF7bkyTmtGAwUl?=
 =?us-ascii?Q?FsbHgk0CfjUp/Q783Ldp1L6nzRUxc/0HuERVATH0hB8/r2M3Vuv9ZbRsLrTu?=
 =?us-ascii?Q?rmDm+uj5H1gqxwubjIUrGbOaURWsm/WZ+7Zo5yrpzwZTbZSjzpNFOsV/upie?=
 =?us-ascii?Q?iEvfOUd31p+WGwStxch421QGW7xG+ZRQF3YtyeB/oMu/R48hW1RdjFYCsLVc?=
 =?us-ascii?Q?EDglPcNXH8VqaNa9RT5XhcJDsau7ehKOZUy/tzqsf25q5FYwWTiIIMecYood?=
 =?us-ascii?Q?B5J7U4uS58mCQBscGYN/rkfhI2NKaSnDGhKj+7rEgTs+MzGsOA1epglWoM6w?=
 =?us-ascii?Q?tuuovtl3IRHRhRUvH6NbF36RFnITgxEI7f1wYHPvdQEm262urcqMHAq1RMS8?=
 =?us-ascii?Q?AjB2spoDdSFcGK6sKCL1vz1TgltKr1nLxLpTE2I/lgZzMt1MR25xFn1jzHT6?=
 =?us-ascii?Q?AQ8nKfe1v4SATE2joMUnLpoFg6W3XPTjyxBXn1Rmp4M6ByvWhsonaXjM3+pl?=
 =?us-ascii?Q?GB1ARg6jYbKC61E3SFNDGrtf1PEWkWbiYUa32plX6Hxb3hBs4sls2dDKbLxo?=
 =?us-ascii?Q?m/1Nx0SZMJNRgSz68qE0q+AebIUCPtwneAqJijNfeWLPylBlQZkrS5YwkNMH?=
 =?us-ascii?Q?9VwBb8fecRH00RzvBvnkSTUf2sLmYDFby7QOYsKJ5P+oJSFZXHtW5yAbg+ZX?=
 =?us-ascii?Q?XEE4q3a4AIpbggKah5Mn+rGWuKMVI6g7ar5649wj8RnBg24W80qcoeBgV3iC?=
 =?us-ascii?Q?rUamiuwq3paLh91dpWPjQLsE7iHFLG291w4xh1CS15YwHFxVhz3U2xptnCWi?=
 =?us-ascii?Q?7rLWxCjCOJ7M8rgd9HkQqUCwb1mzsdSbgUSZMK5z4OxSX9LLNjKeIZODTYEO?=
 =?us-ascii?Q?7a92jfZsmPYbCExaafQA8Qtr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f717c0e-4f91-4101-45b0-08d96404d8c7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 18:03:43.0714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OM/ewFAuRbxS0UJKphSTjD902AA2tVdnV2lpQhZuYLm/vyYE826iO1QblKUCnWl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 20, 2021 at 11:02:51AM -0700, Jakub Kicinski wrote:
> On Fri, 20 Aug 2021 14:49:44 -0300 Jason Gunthorpe wrote:
> > Since this is mostly netdev stuff can someone from netdev ack this if
> > you want it to go through the rdma tree?
> 
> It'd be great to get it CCed to netdev@ for that.

Indeed, Shai please respost it.

Jason
