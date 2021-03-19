Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397DE341D9D
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 14:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCSNBe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 09:01:34 -0400
Received: from mail-mw2nam12on2080.outbound.protection.outlook.com ([40.107.244.80]:42464
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229766AbhCSNBE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 09:01:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaQyLdGbsk7Em6CmxAFwP6bdJ9SzaISQfjqL8ZUrNawKFqLrIYX4g+gobnMpYhc9ENu2Ynvxb8mp2sbpoCcwb4C4Hpe66sQWNwKeCZXwVPZNz5M1XBCCcY4LYmznb7wy/S9HwuJjLr1KJ36hFYDnm/RJW+5+Owzh5KrHJ0BBYqsVrJD0uxDLvhLehbz/zHSZXydNpQHTxQqtn9gOVr2qWDVdWXmT/+yo1Bsn7XnUgshEul56BB10mZ4jXwQTdM3ng+Jr20iB/I/WDvmI661XEBPCWcULJd4otmlovvBJ1MIURHQXjQN9LxWBJF96tTpaE6fluG+SCas8uQORCGh9Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcQ6K9JFWtDU3DttywzSoJrfDTPIUqfu0r098RRg3Hc=;
 b=g1mC8nr4ZnMIScKI/x0TnhrseGRskyIDHD205WAzqlQQwx5knQGhj4WW33pbH+76MeCfnB/rdZQ56EmJJ4VaFdsKVP8ByON3ONuxEt+B4K5G2XT6z5+b3RQKHeenDyDOKbySYCiupOHiFiRyPiuYAl0del1dOdyQ69mjzjzMM2FjEOCux0ADP1dSoGGDPqb2jFHLDswl4U1g3zmkGQoLZnOitX8jzBs+N/4WSgyRGbfQrFf1n87gPrhZY2T7GtE3eWKDFuPNlG1fUTVQeKQ8SnCf1y6B49GJ0h2tvl4vXxph3AhMbgpYgJXPob36H9KO59ZHcABnjozSWsZXEVEYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcQ6K9JFWtDU3DttywzSoJrfDTPIUqfu0r098RRg3Hc=;
 b=AVTj/aPEt9Dd+hD/CxRv6bCF4NO+IOlSXIhnqyCm3Smh2IQew+6cMbfFgQmpgNioukNeu29ViRy6NpwOJRh9hNj0TvqBsr1TYBiAm3qESe0sqQfvFxaQOWHnWit01OqAvpJeylH0LXf2ArtSZjVPJ31IlkEUPKqdYDe0+gE4b//aj1/wjDZXTG5OOIoD+pFeDC0PHmMB7JCdfkRcdx0WcEehVyZRyyjQF19YrseB3vxOT+p3/cra6B+jGO4dvKDP549Ny3bm7SZiMJkMxjfeOCMBqWu+ca+8ZfzT0lgRCND+HbhwguEVlzwuXarirLUmiq9Dpp4vmmfuxvcqI5CRkA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 13:01:01 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 13:01:01 +0000
Date:   Fri, 19 Mar 2021 10:00:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
Message-ID: <20210319130059.GQ2356281@nvidia.com>
References: <CAD=hENcjqtXstsa3bbBCZVGF-XgAhPz-1tom68zm7WNatH2mZw@mail.gmail.com>
 <20210308121615.GW4247@nvidia.com>
 <CAD=hENdymrkFV-_piiOKL-fK38SQh3sTAfc7+WPSky8mHtJ8DA@mail.gmail.com>
 <20210312002533.GS2356281@nvidia.com>
 <CAD=hENcb4DAs7hhPLqgqAhLr8xYqxkMhGp=99bfgq1SZN57QHA@mail.gmail.com>
 <20210312130243.GU2356281@nvidia.com>
 <CAD=hENdqu3v5_PJwQF2=zQ6ifGZD_DUJtUStoiCA5byru5phaA@mail.gmail.com>
 <CAD=hENf07aKBivP93tN9CAR4oZ9jEygmVKowpxGTdAAV9pjpEA@mail.gmail.com>
 <20210312140104.GX2356281@nvidia.com>
 <CAD=hENcNLNvX1isjUYutfsDrXzjpJZWBMaB4EkeBMTz7F4x=pw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENcNLNvX1isjUYutfsDrXzjpJZWBMaB4EkeBMTz7F4x=pw@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0310.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0310.namprd13.prod.outlook.com (2603:10b6:208:2c1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.15 via Frontend Transport; Fri, 19 Mar 2021 13:01:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNEkN-00HBtg-AC; Fri, 19 Mar 2021 10:00:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ccfa7ed-a48a-4345-c60a-08d8ead70bf4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4546B19C4128AC932F44C806C2689@DM6PR12MB4546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxNoPBN2F/lP5JTFJjjJyozHxdIkAO8BVf4shh8CmcC4LwYwrLEsVIlVnBHwQxryC/avFf1qVRKYVj4HrmwHQTJ/Tqc33DkxKwBcpRrLLW73U5pZJZlbGN3Bfw4qmAnGYs/UW7PTMtxOCA7HkCApA8FP5XF0RG6tjXZTUNwyCWJ5cSmrWQmXalXVcJSplkOiqzOijkc1LtMl2eWAE9KwdGKFTbMsulFhapagNqyNviDAKIP4se053jhbaSLBF0QrK5PYOSZhx4uWQ/lDp3MnnouZCkpZT9+mQ0qZWtSmg+sijb7oFzpXAxAwggKsTBI1mZvY/2OJxIKgRr4acYEZi6vPkFL7g0hYRYJPmw/6mTF4LFc/pSPyxgxgnwROKxHZFHFt5FfD4C+Cm6jyQKTA1uCVxjeCF/XKQ5PJdT2x3zPxkvAKst0gxSKsYpg6FPxB6dVjitPiHAFcl4Bl+I32xD9bTl8HAqcYh5BCDELAo8oDcd1BDeVr8WkYYUaUzOUAklmqgWnHfjRGiaM54z3t3DDYHxn556p7PiS4GdlT/ou1UnS8SRs4vyOR3QSgLpjlb3SHatKgETnfQXASBpKf1xp18yKZHofDAMnvdJVMePXSW83z+3/RCxd8v8Pre2oGK/OS2xCVYtnpPhv4/lOm1jc/ifcSJbaGIt5ByPLL/qE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(2616005)(9786002)(8936002)(83380400001)(33656002)(36756003)(478600001)(9746002)(53546011)(186003)(8676002)(5660300002)(1076003)(38100700001)(316002)(107886003)(26005)(6916009)(426003)(86362001)(54906003)(4744005)(66946007)(4326008)(66476007)(2906002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?W5L7E0UG7/lv22ZecD9XnUbj9qvyl2ToRI9SmWVcU6TUzGSakNHQoX4YFCrR?=
 =?us-ascii?Q?blwzAMgygXxNHfVe8qPIYslzlkfJ3uppFDygu0AqoOWUxtHUoJaG/+4MA2p6?=
 =?us-ascii?Q?RefSvQkqLftstW09pHElKyrMr6dB/MxtcJddp4ku5yIptos2LzVWKXmPtlz1?=
 =?us-ascii?Q?5QYcxO/yQhdgp8aKjE0i7q2sr+8CnrVi1fclufr20FvCqCAS6EcwkZL6ken0?=
 =?us-ascii?Q?4WWueVzw/LsvPQJtsnI1CA02BTQXIMo+b18vI9pwkarjw7HuPX+F2JR8ky0T?=
 =?us-ascii?Q?ji3lYzYb1vP2qsUerAIVX0i3QvdUwwSA0Jl6Fgz56oBxxq1umbas0D6FwEfY?=
 =?us-ascii?Q?j9/saOKgzVpCyot79RuACDuPhBSSkXkeODP2RgqfnGdc/+/96e2tUBzRcIiE?=
 =?us-ascii?Q?mQXm/BnbNjxnR8rl6uaK+hC0u1clau+qgMdisy629zfLJCZ4cjUj1G6iIiEQ?=
 =?us-ascii?Q?gjUpkn+9YiB6+FRnyNYv+oKW0sxKcYz3yIz/u6eXgc/uhe4HuO2erBUpgjyT?=
 =?us-ascii?Q?ZdkDcr2GkCABL/upCUfNohUiz6fvE4b8HyvQ0hWAw0UP4pQiEgp2ROp3Oihu?=
 =?us-ascii?Q?IZeI60M8UFlgIbsRWtidA5WxbZrCEwFb7pMJxMkckfuAl3DfVYQFo+Iv8XMF?=
 =?us-ascii?Q?T0tEN9t2BTcGwbW9hl/TIa+NtitGh5kW7r7YFci4dmSWPwhUhT1Ttzlyk256?=
 =?us-ascii?Q?yro/K+xk2Xr91h95JEsseIKNCB9P4a0Q2n859Mtp0Wns4PY7Bf9SIcY29y/E?=
 =?us-ascii?Q?MHru/9vwH5mv2M6Kr2i1PS5JdCRpli2z6yHIOyL00JvYQ9JTIXDrqu3w2fSj?=
 =?us-ascii?Q?W8W556AHw4mMNAFv/b0N6wcFyaX4sWgrGroyJArB8T9Ah/AJ+ZLBs8f37vAq?=
 =?us-ascii?Q?ix2cthR8TI3cIgOPov+XovI+kKu58f3LxUm4T2AhhC9cHC9ZOswnBkBWWdSx?=
 =?us-ascii?Q?Fy9lgZ+HKVYA+Iy2/yKB/msY4BBlA28rBQlIpErXfM3EE3qok9wXdDyG94mb?=
 =?us-ascii?Q?vHmRLBxyy6ujOlmmKN0rpZBNOgOkbOaAS6S+uTW0idoCoMcIzMvfjfGg4Ra3?=
 =?us-ascii?Q?bz8c5SRmgA56GL5qhxeXCVG90jIJApcPlFplzZTn2XSO1G8feZ8PVg/vVRs/?=
 =?us-ascii?Q?5EZxxN5821CbygdJPAH1xa7BI+qO603/HXCro9EULTbm2micdgDxItiXtrSh?=
 =?us-ascii?Q?g2P0HHmcbYd1TFP8/X2JJpHoKmAoaPrLJghOmv7ZIbazXTOeoE/7APchCkd+?=
 =?us-ascii?Q?+tja4E+v32FZjpG0fStaJ0lx7r+pwVChMv5vfWz07WBbTXNgxBBbL1BhWAJO?=
 =?us-ascii?Q?B1+fb9OVAzAI2Ce4CdIhAw1z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccfa7ed-a48a-4345-c60a-08d8ead70bf4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 13:01:01.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTkyM9iOoQIC7sBm4CbQZrCesGkFmDvC2C7P3034BiDqB2yZnKoOib/h6NwHJBdU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4546
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 13, 2021 at 11:02:41AM +0800, Zhu Yanjun wrote:
> On Fri, Mar 12, 2021 at 10:01 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Fri, Mar 12, 2021 at 09:49:52PM +0800, Zhu Yanjun wrote:
> > > In short, the sg list from __sg_alloc_table_from_pages is different
> > > from the sg list from ib_umem_add_sg_table.
> >
> > I don't care about different. Tell me what is wrong with what we have
> > today.
> >
> > I thought your first message said the sgl's were too small, but now
> > you seem to say they are too big?
> 
> Sure.
> 
> The sg list from __sg_alloc_table_from_pages, length of sg is too big.
> And the dma address is like the followings:
> 
> "
> sg_dma_address(sg):0x4b3c1ce000
> sg_dma_address(sg):0x4c3c1cd000
> sg_dma_address(sg):0x4d3c1cc000
> sg_dma_address(sg):0x4e3c1cb000
> "

Ok, so how does too big a dma segment side cause
__sg_alloc_table_from_pages() to return sg elements that are too
small?

I assume there is some kind of maths overflow here?

Jason
