Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462D97464CA
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jul 2023 23:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGCVT6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jul 2023 17:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGCVT6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jul 2023 17:19:58 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE92E59;
        Mon,  3 Jul 2023 14:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGsPl3tXfIp4FrcECsUFf5PTM08XTVkiOaX+nn+gPpVOAilmJAlj5sgFUq5cvI1C3OACZLz0JnhrHp3WJiAKuNY3ie11la4dNPXCHpy25MDkU6YSy3rAx1Hgloa8Hdrxg1Fd2tD6NXErxzUyLmvplqCr6YCBsiy/3ZQejPD/n+yK2jZkvHiQNN5+ICdTWcv8cyNsjd7WGKaNLonqdvNdt4fp0cFgTRH0Wer78/e3htJ7Xq0VZikzqzKmH5Ln13KrsZSQN05hQXIZvz9NMzwRZHMNbkDU8dNdctZJKfcegZy5ciTdgchukUJkgrYYdxUDOlCCL4RLeHx/r0EX9ScduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHrvsg6mQIKnSQt5M8kc88n6Lav13CJ6+csjWnJs9/U=;
 b=EWYYqRJ0NXn2/S+ly0GRtGa3oppMJxAQMnME0OIZVyeqHlXu1Sxq5j+PuTIQ3ZpEIvBxB9pXcQrEd8RX92Q/J76gC8apNeTAmW1Tkq8bPs+0jjDn5U55NgvSZgd1K7Ndtybcx4Ua9f0wWqIxOnVGkZmcUSwB4MAs4FGN2iMH9tRrIaNPgspW7/lE8rQQg1plqEkhlsZZgj6m9wP5zHhesoc6AyZAtNatuympjUYsI3ItM/lA5m6Vtu3nzenJbA+vd3eSc4mJIzpfK6q/u8e9NQ1eDMeJpA1aJOt+IXVMYCXlJKG0K94ItWEgC39L/8b/R9dEa1y/MwsBJqi4wzl0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHrvsg6mQIKnSQt5M8kc88n6Lav13CJ6+csjWnJs9/U=;
 b=Am0BjOugld3Qs19joUuKYdoxRL6jp+EqGi9gpTqc16u4CUgkLnwQEDemw2N9AHXDA2PRkPT7ItK3LNezjxY7PHRZDkQ9geWBQo1rwoD07FahLP595K0IPmV8MYp2pJ0Af+1LhmypjTuxjxOO260cEZ/WOIu/o1kG28G0jQhDQmDXCGPAXuJIi+PWs+Eizg8mCFmYG03AhNpNBnqDrTR1eoy00WcH+U2tsKfdNBzVJ2QJieMY7Gz1l0QpmZL+tESm/bsQWjv/Aqzdi4/K6bUwFkyXEG8jX6xT6gOQepCwlxUevZW/XeFwcTukOF7aitj8baHMvK9CjDFzI557QdsbAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Mon, 3 Jul
 2023 21:19:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b26d:72b8:be41:2f0c]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b26d:72b8:be41:2f0c%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 21:19:53 +0000
Date:   Mon, 3 Jul 2023 18:19:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <ZKM7d/01mrbNO77V@nvidia.com>
References: <ZJzUeFT7lLqEjMJn@nvidia.com>
 <CAHk-=wjiSW52tf=xaBe0LrFJrRbSnA=E1ziKBEioMT9cMJPM1A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjiSW52tf=xaBe0LrFJrRbSnA=E1ziKBEioMT9cMJPM1A@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: f47f1c08-ab6a-48ac-86a3-08db7c0b3e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XxUXs4hoj8I5w34HdMdUgylwfvni99pcpAnRMD1dQSmys8N7f7sXS/qCLUNBJ5UFYOo05Ue4F0BjcIBLA1qWGRqR1Ujf4LWUhV9uz/XrrZnDx0NyWXyX8N6gf4evHj5DcFEAFfd1NmHk0khlGWHPLQDKaN5FTQZnK47pWGIb+umoqQwLpVtRoExJs4LLQgEBaHLxbEoMlzD0cdRdk/oMBBtEZfsGB36O1oUp/T9rcN9hjAE1048BWzyMgb39rCmEFWYMEzPNvlCu82uFySjveSSkX6XGohxetZkPBnXjlrY0Sxl8RPKVh8wEelrcyh9y3jNF0SPHcQe5LcVfGVKTN7aliI0z08vgvt/0mxRDdA/4WDIJVjbEHtah36FNcihfzwYwMTQZBnz6IaYjIM7ie6M3qSzZHLQrkpDY9IdW5woCwl1/yT/Lnfhn83oeBThkhOhyEp0KX8qDaLJxk9Q5C0Hu9lU75Wfn1in0Xf+Wx/OLzFK9VSISmAUt3UV1oyGhJU88MuCSjjauKkpu7qy5meDRTwy/Kq7Soj+mXp+uiUWsPJpeBS8TxaJ6hW4P+83K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(86362001)(107886003)(8676002)(8936002)(5660300002)(66476007)(26005)(6506007)(478600001)(66556008)(6486002)(66946007)(6916009)(41300700001)(4326008)(316002)(186003)(6512007)(2616005)(2906002)(83380400001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lupdH0GbQy4/9Dm/0FITGxiiZXFvDjqwv1eDUkSjzVaoU1/jkuIfc/jfmsEy?=
 =?us-ascii?Q?UZPSt74WHpkZORF312XO/XUcNKdwypRJySeDJGt1X8n2rXnYhEW2v8RYe8lA?=
 =?us-ascii?Q?7AT62fgdK4jBJUnTMXmox4H4l6vKFkA6n35rlUp1YiAH67HXm+m/Gp1bN+Bi?=
 =?us-ascii?Q?50LuBpBZbw06YuTsZEd6m1pyWzVGAD2qHS82CXozE7WIgVI3yIZ5NjMvO75H?=
 =?us-ascii?Q?7AGsngrD8u0L1lfpU3BBucbpKvqG728XDhiOcZXjddPJVI0FTVLCOd4vShuY?=
 =?us-ascii?Q?45ovMB3fhekvJnoclxOuOhHHjqCGdvU8A6HF/A9c4XlMu6YGvFP07QMOpO8W?=
 =?us-ascii?Q?6jORr/aQ6+mCjmU0G3SBBAL2hBRQ+xhLxxlyr3nWivcWQ/USOADObp7Knn0J?=
 =?us-ascii?Q?jfy3taz4YvoIv7hJvUe8pC9r+J4LX+mPHGunDt2Zq8hPcTA/vPB+aPwowm2G?=
 =?us-ascii?Q?yyBdX+XPsG22IhoHd3NQ5tyklfsKKAO2VGNBpbAqTKyjsfakMw4xbWQkAbAU?=
 =?us-ascii?Q?KNb1WqzHnvA3AsAxiG4pWJrn+C0i4Gv9hkNhf7CZB1sqB86ZXgUhOQ+dQaKH?=
 =?us-ascii?Q?9FHUbgL3edxacG1OI4NvimvCEztlu5FrnJY1mZhlcHNUhcmZEXuYINSyLWIV?=
 =?us-ascii?Q?v9JzwcV8GiIJcbRlV2nMOu0g37S9sJZFY2USHXI7SAXtimJQ1yxBigR2ysie?=
 =?us-ascii?Q?WTwmY8qo+UGN3Q6WwlAZRPlkKu3ges93+g6FBxZRD58jDn5az9lomyTiOuqk?=
 =?us-ascii?Q?qyr0qybYrpR2a7sTs5ItjBWuukWIsd0fkPCuCK+gOXX5yhDbEveH+b2AET5r?=
 =?us-ascii?Q?eO5op+Pm/htKUDashk8vLCGiqWAynZn8lA5MO1RaAAGvVWpqHSmD2TZEkXTL?=
 =?us-ascii?Q?HH8/e5g+zUtXopvNoEqEIDNIm8n/470g497knUt9pWjJ4QiFdlx652nCxBEb?=
 =?us-ascii?Q?azCFoAa3h00KLkuqOrXydaSgf2JbyypDOO/aiBICRmB4XFX3yLSdGt7MztY3?=
 =?us-ascii?Q?opR905DlsV1+rr6pM6YmWvkMAYlgBd1BMplXSgvg854EVSMFL4SfIrXnGEl7?=
 =?us-ascii?Q?05QJG5JhCICUX6Q4fKcxLR7eqlztHkpGRNdg93aYy0ijI9fNKW+s9WcIqb6S?=
 =?us-ascii?Q?PrbKZnpzmS/2uAJ3DP8tErlxr/6p8dpWc3yjJ/5tLy5TEjqPx/BFrBZJuJEv?=
 =?us-ascii?Q?49CKQwuVbrvaKDYM+TZFGW1d3+tTSqnaeqc+FvRMyXeBdkiCJHaNw9Ij5KBs?=
 =?us-ascii?Q?HigRcq1aiJ7Kz/bLgAhtOvzKfCTq0pBZh+P4nWwHGLhluD5GmaDILxFt6ZzB?=
 =?us-ascii?Q?MywTo6QnJOQ6gqd5RU0CPhGtoF9HDGS/E9GiIo/EBaMr3erRKTx+78XQf8iC?=
 =?us-ascii?Q?lp85TNgQFz4C/bHJNOy7Sus+uEODOGalczGvHBUiTQCsQZvijYqfF8B7fqoR?=
 =?us-ascii?Q?HJWq18kn48rFQJE45rUj8xHrgOQlDtFKsiCnAENfXTtjbI2UCWgJ+op7VzM1?=
 =?us-ascii?Q?0vE5xTz9dDwryRamWFFPOHxbyP9bz9Dh+KH89BYs4fO0HE7cg2rKyQHeMWZG?=
 =?us-ascii?Q?kFTx/pcT72bgqQK7EeLOCNiJYudQ5tg67UDUCRTw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47f1c08-ab6a-48ac-86a3-08db7c0b3e60
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 21:19:53.7296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjQQTnzKrQlSH7IFyarfb+H+pmp9140ZF0iZ474XS4aC9/n7XXbeYZ19bNVYNMDV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 29, 2023 at 09:10:17PM -0700, Linus Torvalds wrote:
> On Wed, 28 Jun 2023 at 17:46, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > Here are the changes for RDMA for this cycle, there was a small rxe
> > conflict with v6.4 that I resolved in the usual way.
> 
> Please just don't. I'd rather know about the conflicts. See
> 
>    Documentation/maintainer/rebasing-and-merging.rst
> 
> and about gazillion emails on the issue.

OK, I thought the release merges were OK, I've sent them this way for
a long time now. Easy to change
 
> > - Lots of small cleanups and rework in bnxt_re
> >    * Use the common mmap functions
> >    * Support disassociation
> >    * Improve FW command flow
> >
> > - bnxt_re support for "low latency push", this allows a packet
> 
> This allows a packet WHAT?

Oh it got lost "a packet to be Tx'd without DMA"

> On a positive note, I see that you have a blue checkmark by google
> now, and Google says
> 
>   "The sender of this email has verified that
>     they own nvidia.com and the logo in the
>     profile image. Learn more"
> 
> which is lovely. I expect great things from nvidia now that you
> apparently own it. Congratulations! Champagne all around!

I thought only Twitter did blue checkmarks!

Thanks,
Jason
