Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AC73AF969
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 01:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhFUXeP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 19:34:15 -0400
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41]:61793
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231268AbhFUXeP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 19:34:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJJ7iVLoQ4DX268d2UElMjU6TP92SRe9OULwdfae1vCPV6zrRx/FERxbgzHhbQCv+xT4bQ0++aTIc5/c6N+ErZEVcupdZPSFEeXxUw5RxW9jWqiOrkuZ4/LA0evZANqKJNByqYlLSmAzORjtDtDcoS+g8t0m52fUSFX6vw+ik6uUKom4gTQ9W/P4NgZkq5SCYfZ/i4RsEQWp73hXW22NUhxXN4rKfIC+jmDBgpNJTHHUEm+VVihzcbCuzPMMW5VFXfrIIZjLW9A/NRhGYozwn5m1IAXDTa5ipFB0ygqK3yFYPPTzgZp0YKeP445LVZHKOJ0DyOB92ZHkwjQdoNTOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk3tculldK1MspuE0PdeXmxOtu+64zsKDPSEcxY+EmI=;
 b=LhCskWvX6UXNIVcG2GfbR9A6TZhVhwuPqSuuk35NCDV39Son/vSaNlLHMRoc/NCll3ruupcY7q7RzcQC2mCEfpmk+yvb6U4sre9rD0wDRxJbfyPm/xbP6hplItbJ2L40K2kyvaM+hHOjQgoQ4tuojgLyGx1pqEPqR+c+c/za4RvWPxYAGXWf8hkZBdS1wd+20y93z9zOWOCUJw+ARjAuYn+m5p/uvfIyq6yquWxHQ4j+lSi00qToRRdOWL+yLRHS1kHQoL2N17shsF/N6pnkYBMkMkZr70wOQecp+yNHHufsaAx5Tr6Q1bB2017YyZ+YMzMxQvp+PGcX44sDXEMznQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk3tculldK1MspuE0PdeXmxOtu+64zsKDPSEcxY+EmI=;
 b=aBzK65USpIF/vPNnTdvGv9MzKGQXp1P2HKPvHYy5ihiIGizZQEnHY3znpljmr+EZH+NFPZqTpFV9dsvfLE9WR/wbtVTNDxTVUFrFVe3ZT0U9usNXH5jf+kKkuNWOjpZ6qGUGcD8shl6Y6tmejdfK2RYGw2DXAZ/CZ/PvW4VgA40YwPQ+aPUq1t/44quiGCH0hOYsXHiM5lLVIqrRZnXrXrk/qrNnF8dmzyoupTHMLyt3NfMOtT1Du4vtUUO+8WHDh0WgcSUImwWCbS6DMMQshGahTI4kxG06LIWfGICbye7P3GGBjaXRgoSfNHUNT2qoSGQP6QM8tO7VvLZXEAVoUQ==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Mon, 21 Jun
 2021 23:31:59 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 23:31:59 +0000
Date:   Mon, 21 Jun 2021 20:31:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Hans Ry <hans.westgaard.ry@oracle.com>
Subject: Re: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Message-ID: <20210621233157.GV1002214@nvidia.com>
References: <1623934765-31435-1-git-send-email-haakon.bugge@oracle.com>
 <YNA7ZnKIKC217pCw@unreal>
 <C8E39F1F-14D5-4DBE-ABE0-2EFC20353D83@oracle.com>
 <YNBhuZNjGvUsJHUy@unreal>
 <FB3E1A32-A1BA-48B8-A20D-99662CDAC921@oracle.com>
 <20210621143758.GP1002214@nvidia.com>
 <36906AC6-B2DB-40D4-972C-8058FF0B462C@oracle.com>
 <20210621151240.GQ1002214@nvidia.com>
 <AFF46FA1-4679-4625-89CD-B608FCBE14C1@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AFF46FA1-4679-4625-89CD-B608FCBE14C1@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR14CA0010.namprd14.prod.outlook.com
 (2603:10b6:208:23e::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:208:23e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Mon, 21 Jun 2021 23:31:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvTOX-009ty7-VA; Mon, 21 Jun 2021 20:31:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aba767a3-e799-4890-57cf-08d9350cc3a4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5125D4C67F769EEFB6ADA0E9C20A9@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: az8T9EAWU9BxY7AQeB3oN5G86rDLZ+E5wTG16BFA4a0xWp4EDcPskWw2JHwIEpQtf7d0dsl8PhL5ENtgHvJfIFVtfXAEiLg/Ci6MuRtyRWgjYDCgab/HnwenvG4IIkxVAPIWhq9qhsPYcCqUB964r/6wdlWP6Zd8w1QCCg/WW7SHPYtgojiAGKOHi8bvsB0Era/naF79egzl1bMQQzW1XU4UNPjL2fcrNwnej1uapnM0h1Uz3jqx+F1JpEHAETv7Z/Y4MeOXDWi4Z/Gd8CE0cZJGdnY7C3kgmoP8y/oEri1JSMixAMWtfx0FBGRtrIBqRpKQrKeceNATnB2sy8khu9rfTTpSCGIOmbI2cao2saN77k/nvX2Evo4OQYTAGwsSKHDt9YXFOAUI6/BUA4reZEg+jAtYHBUdpaZRQN4r2Ut54rP4SYL5d3S4Dqso0V5C2wdzxBhfnwJiEMLSYOgd2j1n0KYf+a0c0e80niiLVRUEub42/BSgdJsmLHzt57ssU77Ddi1tJJ1x+Ty2atTJLYNDMA1n9QMbQnn//WOBKYx27LqZwO/LjV3XR+1lFaP08GA4WI7/1McS+Up+U8RKJgN0Lqo/cTWtR8/urObBHaA3sr6mPSK3Qcrcqv3IwVXbocVe0ezYmE5PGWdl2GeYO+PYRvRnUOtLjF2BUoOx1lwlrRQSABE0ONnh24StfhsTpNScDigqYhfsbRd3BaVEQXgKy860kiFGo+ahtrjTO8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(6916009)(316002)(478600001)(83380400001)(86362001)(54906003)(9746002)(8936002)(38100700002)(426003)(2906002)(33656002)(4326008)(53546011)(66476007)(66556008)(966005)(26005)(5660300002)(66946007)(2616005)(36756003)(186003)(8676002)(9786002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gr/kMVGn2v6yp5+9XdAmTg6tzBeLdvczLjbs06H501eiTbbVSjfle/XqBhgx?=
 =?us-ascii?Q?jfjp7VGQoFtfIpH7OTub/Yv84w3/mrAu1ot1+VvYU6U7VD/83GAjVL1eerH4?=
 =?us-ascii?Q?i4i17YGG1DSFzZeE3oM6iokCYcIKhKvZLjKfiv7fyfVesH8E/ViL5Zg0Mopx?=
 =?us-ascii?Q?SuOe3+lnnS2pk7poq1QI0Dy8ifpwJ2wSH1DvTXGkWCV9oIupAQO1ghWjFnzH?=
 =?us-ascii?Q?kwq+aLqZrAVzb7m5bsw+X3Xmoaf3Mzrmjcg15dAzHxwR6oIHFFMNvuSto/eK?=
 =?us-ascii?Q?j4d9PEZq4z8o5Z/GX83DxvULMIFwgM7dn3ZY9gNnVoYO36pe3u8ATxMDWy7v?=
 =?us-ascii?Q?80b6PEmBMK0ISCfstxOzcmg3qoUky2ByzemzCBSMJGTYeP4gCLE0foCQp5ms?=
 =?us-ascii?Q?A4REKyMnTR0lrj32i1V3mw5nxtuUqeuJSY/NLCTTGpX61TOfg8jUEfF0pmdU?=
 =?us-ascii?Q?GPGhTTzuFjJd901+D9PdIqzbyNQQ0AOSUNfvrS8r2i8hSK5HnYKELuzy5vRG?=
 =?us-ascii?Q?rp1xdp0SQTFS24col9yLZ8mMfXyVQD8MXPUX2c3oS7JsHQMYDXBTdpp705BQ?=
 =?us-ascii?Q?m9heGBOLcWSdeveOjripBftMAgBZ07eC2xaC1CUb8rjmZYoWW24OJ5aN7yJA?=
 =?us-ascii?Q?j/0vD5dMsUGXbvSL52dS7QvoPWvwClDyGuCt1ApJL9kHWnuxUhw/j+MDpkAx?=
 =?us-ascii?Q?+HiWaiO+ScxUq2YIIiDAw+mL+PBU/fILotBUlR2QZdkS/DMLlYv9vjHcGz25?=
 =?us-ascii?Q?6fmhIiIT6deZoePsSDfGLT+GE7kvYIfEHu4U/Iiu1e/8hDDvuOb07N0UMuHC?=
 =?us-ascii?Q?LzI8izFMAHG44afYZTUk/Hz/ZCi1EIIDlyjzIIscf9hhrKQXfVAiVR9rkCvE?=
 =?us-ascii?Q?xhi02k42H6nba5EUjqWgua0R3cwJE4mi7VXNnq57ghux0tfO0fZUHpla89JE?=
 =?us-ascii?Q?V0dzTZgu/gTueYIrf2hSjvHUIrtRFmthIJBzvfMLqtau3S8hIL3xYWjHRcIE?=
 =?us-ascii?Q?qR+s0u649nHwl/w4/BWZ9W2zGo6N8Sjr9wNy2Z1bgbt7ODQo1h6QrF0BkZpN?=
 =?us-ascii?Q?8CbK9HK7W+Z90mUI7O62LNUt229uzkQ4DGMlGCoYUqt3HAjOpk0ScpQK6mR6?=
 =?us-ascii?Q?OKXQsKLIn5ZbXXiOTNHIxlkG2Ayf1/c8ScXdULuGW2NrtRhrkGs0ovkkiW8Q?=
 =?us-ascii?Q?j7cFYMFL5JyDYvvfyEzDFlQZmtNVPZz6Ut+5qg3ueq5Po6+Nxg6GVpb9lzRD?=
 =?us-ascii?Q?JxRDjtkk+tQnKegF27RXa4upL2kKpW3TGAuVL6/ViRtfX4Em/fH9sofSwzap?=
 =?us-ascii?Q?4EuRF7kq0vjFGcK8YwsqztF3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba767a3-e799-4890-57cf-08d9350cc3a4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 23:31:58.9246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGfF9W4cM18FvjMfWgvkC1Fv+VDWFPbsSoegF3PVZ7MJ2krbOMulzzIB/O8qNuyt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 03:55:40PM +0000, Haakon Bugge wrote:
> 
> 
> > On 21 Jun 2021, at 17:12, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Mon, Jun 21, 2021 at 02:58:46PM +0000, Haakon Bugge wrote:
> >> 
> >> 
> >>> On 21 Jun 2021, at 16:37, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>> 
> >>> On Mon, Jun 21, 2021 at 10:46:26AM +0000, Haakon Bugge wrote:
> >>> 
> >>>>>> You're running an old checkpatch. Since commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning"), the default line-length is 100. As Linus states in:
> >>>>>> 
> >>>>>> https://lkml.org/lkml/2009/12/17/229
> >>>>>> 
> >>>>>> "... But 80 characters is causing too many idiotic changes."
> >>>>> 
> >>>>> I'm aware of that thread, but RDMA subsystem continues to use 80 symbols limit.
> >>>> 
> >>>> I wasn't aware. Where is that documented? Further, it must be a
> >>>> limit that is not enforced. Of the last 100 commits in
> >>>> drivers/infiniband, there are 630 lines longer than 80.
> >>> 
> >>> Linus said stick to 80 but use your best judgement if going past
> >>> 
> >>> It was not a blanket allowance to needless long lines all over the
> >>> place.
> >> 
> >> That is not how I interpreted him:
> > 
> > There was a much newer thread on this from Linus, 2009 is really old
> 
> Yes, from last year, lkml.org/lkml/2020/5/29/1038
> 
> <quote>
> Excessive line breaks are BAD. They cause real and every-day problems.
> 
> They cause problems for things like "grep" both in the patterns and in
> the output, since grep (and a lot of other very basic unix utilities)
> is fundamentally line-based.
> 
> So the fact is, many of us have long long since skipped the whole
> "80-column terminal" model, for the same reason that we have many more
> lines than 25 lines visible at a time.
> 
> And honestly, I don't want to see patches that make the kernel reading
> experience worse for me and likely for the vast majority of people,
> based on the argument that some odd people have small terminal
> windows.
> </quote>
> 
> Occasionally enforcing 80-chars line lengths in the RDMA subsystem
> seems like a strange policy to me :-)

Well, that threads from Linus seems more forceful than other threads I
recall so <shrug> Still coding-style gives the same guidance I gave
you:

 Statements longer than 80 columns should be broken into sensible chunks,
 unless exceeding 80 columns significantly increases readability and does
 not hide information.

Can't say I have anything more clever to say, other than try to follow
coding style.

Jason
