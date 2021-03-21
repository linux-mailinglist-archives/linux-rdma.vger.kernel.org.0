Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FF4343404
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 19:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCUSJK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 14:09:10 -0400
Received: from mail-eopbgr760059.outbound.protection.outlook.com ([40.107.76.59]:25295
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229987AbhCUSI4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Mar 2021 14:08:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZFT2wcCIQbpc+m22Ws0rIY8kFyfS++TaojYNO0bXbG2s3flUHNPTc2pqpZc2j7c+aa0N0EkVLBxG4BdPkjP/d06XwT9oNTXhE4gMT4A8eCpC5oGqg6NXn44GSSzUfzzQNPzNyQIGYli5E7JffCrjg6vYn7zf+QbXYL60ncmakHrWyKmE0wEh+0SLRf4Gu5W9GdvhtmYpNwWbb4houZap2GFvDhMf5MWGsQDv6mG5SWIhiAX5kuKza+eOoysEXlzDYKS5Er2IdfQ2bpw4j11nRpOJNCDdD/k7Y01nV1IlWqbIIi5YidKeqqjqbTkTCmcSGaUD/iBsS3aPIvI03QuBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsiLK/o5NwIRgSjQ/E2iKsp/N72lFS6C3FnJ+fgh46E=;
 b=Cqt5KP5pFH1atsmf2T5WqrILYPmf4vpK2rNRT7SppVb/e+zbcTzSOJnh54GcwtyckTRErupvfOxlVsqPIcquoc7uv3qTYRgcSioqLqRB9uR2mqAuoTVJZADDFhYIAVmwgKh+HZQBa8VY4njXX1z1dsZI8h0y1n0j+muoXF0+HtGMG53/uDEOUJhjfJcXOv6qgNrYJPgK/UAb705GInupE7ASnzEQ/qts6jXeALoqHK99BBhgCSbhLchBSVstSGPApHeIpSqlcrOkkQWBxUUsyU4xyirvwdKzOi6FPKwk9sLIirqSSoXz/m8yrGJrxyv7ObqL73NTBCwZCbOJoVfcyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsiLK/o5NwIRgSjQ/E2iKsp/N72lFS6C3FnJ+fgh46E=;
 b=byPDgCs+3p+K/Y9o79pvcdplk4rd9oCqOr4H4kMezlJ7sWzne7/7kHZfUoCPT8MDYvL6idIw0aKO48h/1XvFzl3s34lu8/ZfXpivZD3Edd8F5ACW+WOrdeCg6rL5XSLenxb5OauZMay27tNmpdBBpuZML+/JL6EO0AC+13Xt4VCjWnL+YuLpIpPCZflSDPwH4vOwwZl+SM/ogEKTTdv1zPy1NEf/CMamHBN1ZlbWv+/DvBEpj9jzslrR6GLwSvtI/96r3ogVem0+CgipXzXIbXXzDZRtGZ+eUbVDP7jVS+V3DssbYLcSmwQEZpYimpI0oldQsFHM4o5mLpMK8l5iPA==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sun, 21 Mar
 2021 18:08:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.025; Sun, 21 Mar 2021
 18:08:53 +0000
Date:   Sun, 21 Mar 2021 15:08:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210321180850.GT2356281@nvidia.com>
References: <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <be96ccbb-17b7-27e3-a4f2-5b2cc4184ecc@cornelisnetworks.com>
 <YFcKTjU9JSMBrv0x@unreal>
 <bc56284b-f517-2770-16ec-b98d95caea6f@cornelisnetworks.com>
 <20210321164504.GS2356281@nvidia.com>
 <1aaf8fd0-66c5-b804-26dc-c30a427564fa@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aaf8fd0-66c5-b804-26dc-c30a427564fa@cornelisnetworks.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:208:32d::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0042.namprd03.prod.outlook.com (2603:10b6:208:32d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Sun, 21 Mar 2021 18:08:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lO2VO-000dir-Vv; Sun, 21 Mar 2021 15:08:51 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e20655d-dc15-4892-ba22-08d8ec94626b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4500:
X-Microsoft-Antispam-PRVS: <DM6PR12MB45007C437FE2760203DC0063C2669@DM6PR12MB4500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nSuFeAerS1FD4liYMu+HoskjSMz/oJ1/CBk+eklAzaRbhzN8jOv1s5g/RJh/tMKwvJCHPReiOBfASOmI2k4SYIpis2PsZnK5xk0kI+KzGqp1PdiEHX7fanIUBikZKtjbR9w+uprzJjriuFbFcarmGIN3PMaRA4mQL22hK9DqQsyXKuQF4E8MooOaajuhWGQK0BWWGUHC3vXihm0nce2MK0J3YMdcFUx36bKX/ckaGmbTqu3+m9dPbo9UE6HZd/bvTnWPDg66+m9BcfztgSapqpyBNPhsfvXbsbnKWPLsDQgkcBLpy0S0xKghBuYeUsjbFRHjJWImbFks7t2kCUO/3OsdSk8duLC33HY0WPPsBSfXeXzbNSI3VXMR35tR1Dan8kKN9zfKBGqqAp1m3oBowWddqv/e8lrGhdwWSkLyESncVWhJnNBGfy1ZuLoKq8720Aa0fLIJQ2d7NiiaTMbiKYnvKpGU1P+mlFbCFNfhtEy+PHI1byELlXqOtpvV3bHtgJLjAzqdNrAXd8ZnHIXJycpzPt1D8ITN9A6XPBczBh5g5DkJEsVlZ2tcezhkNYPNvkHlmKSvJkn5t980fOi5gxR4TYfEebdgU/eQRsBxdflFECWnsymhwyqZUo3AXRnTa5nAKq2Ppj/z4EDJFKTIOSX8S8UdH0zoKP9gkqR0co=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(9746002)(316002)(2906002)(36756003)(26005)(9786002)(4326008)(8676002)(33656002)(478600001)(426003)(66946007)(38100700001)(2616005)(1076003)(6916009)(8936002)(66476007)(186003)(5660300002)(54906003)(86362001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ODwO1Sc+Z6CL9JKMfBmFudYBUwncCb9va7/5YC1VRRTZeioDhbITeNEtHert?=
 =?us-ascii?Q?uTzyhvuJgVSy7AXW8bAm11sCWcM/XVJNk1Ejab2MQzXA4t+8kJs/rcj/JDkd?=
 =?us-ascii?Q?Oe6ZWOknv4SvVO856pQ8FEhiaG2hhPukyRguI12z1YeXy/KcscsFcMSve2uT?=
 =?us-ascii?Q?9ph+/m6usWpxRWrJHKJW2yKci3WVmptNP/ag/8+H6Q18gU1sY1Clf5Bdc9k+?=
 =?us-ascii?Q?bcJlGcyAoLzR1OyFztCXS7XmW3pwjShIpWRv/zOO+JOcyWMKEp0LV0fWLgsC?=
 =?us-ascii?Q?HD3CMNSYBOMggzZbRHGwmn9wjC09Nq8maCWTFZYl9ujXoYsMybTKU8tu23wR?=
 =?us-ascii?Q?BM7IxqCSbcJlYBfjMrA+F14MgyFRjjlzktQCHTOqMXpd+jK98emQjPocoK0a?=
 =?us-ascii?Q?2m9WynIxBLo4ybf6XgTPNP0Eu6S3uDUnZkDxu5rznNN6hjC+kTxz2bvLQlqM?=
 =?us-ascii?Q?+4/KcW6d/ah+mk+A6kPwQti1eYUgRjSmHsb2RqixHE8ROz5Uu2cXvVvyWen5?=
 =?us-ascii?Q?dDkqgtdnZyqdKb1X8u5lxwEoquHSD9DOxlypPoGPNsdOZ5sswQ+i7/kn5z5j?=
 =?us-ascii?Q?sk6uN7y4dPKwUYdqGTqg3In8jRHk1laF4IFtlne2N10Tb4rDdPoD8ekkPX2h?=
 =?us-ascii?Q?8Tt0TcAaed9gRWi4NCifNifYjffcgb7C2l++QKFLqqt2il7I2zyvVnNHzFeI?=
 =?us-ascii?Q?7L9BJjqxrtEULZDoQkeRUEmhQvV3RTYHMCOIgN7KWUeV8mCt/Pjmeq51AJyo?=
 =?us-ascii?Q?WHrx1MwTmF9kwmaH1N4JxLfJ51Kvn/7FIJqPCLIj+eEBFntiSyJaDl4aBTBz?=
 =?us-ascii?Q?m/92ZAOy5OwQIBwamMI0j7+dqtPLHGVALhA4aI5zU2Gf1y+7D0+zyug/A68M?=
 =?us-ascii?Q?IfNf5YgCLnteCtmx9PVcTxz39YhXRcTs2faX5nF1yCilEYRqMgaBJ1WNvUOT?=
 =?us-ascii?Q?XdwxNmOxQLaIjFvzATOkqH54r939tZtbIYcSNg8VX2cYlKS33ibs+o9RtbCp?=
 =?us-ascii?Q?jbyG6DLx4VaacDG5xl9GtfOKiRIk/CzUwc7bkFZEHQCv2xtGI8xu5vaQ99Hg?=
 =?us-ascii?Q?IdTXOXEz7tH2EEn68CPvQHwvaZa7dCnfuiVequTYh/psBPAoNaXXor8+Cjyq?=
 =?us-ascii?Q?2sqH/wb4D8W7ZsIGeEDzW9bf8kI89OCqHkdUt+ASQZs5rCDj1kgU7DAtdG8f?=
 =?us-ascii?Q?zKs2YqKfHqM62l+Gpi83REmPEzoDqghm81RifHbVSeuk0F34ut6T+rQvZY+y?=
 =?us-ascii?Q?+ORt6Po3KUS92/5v6n8wv6VMVCtua0Z4s6sXzAesvQKifiKWVZgGUJWtFCj0?=
 =?us-ascii?Q?9pEzo7FWkjArVyc/c7J00pfhxel0wQvmAqmAErvI2+kgaw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e20655d-dc15-4892-ba22-08d8ec94626b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2021 18:08:53.2732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ePz31RIkvTmgDup+plssBNvVrjpsiVJg2ErVjjk/avvOD2MwGA/AjRxc6QqUrAO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 21, 2021 at 01:21:14PM -0400, Dennis Dalessandro wrote:

> Maybe that's something that should be explored. Isn't this along the lines
> of stuff we talked about with the verbs 2.0 stuff, or whatever we ended up
> calling it.

I think verbs 2.0 turned into the ioctl uapi stuff, I don't remember anymore.

> > > We should be trying to get things upstream, not putting up walls when people
> > > want to submit new drivers. Calling code "garbage" [1] is not productive.
> > 
> > Putting a bunch of misaligned structures and random reserved fields
> > *is* garbage by the upstream standard and if I send that to Linus I'll
> > get yelled at.
> 
> Not saying you should send this to Linus. I'm saying we should figure out a
> way to make it better and insulting people and their hard work isn't
> helping.

No - you've missed what happened here. Todd responded very fast and
explained - Intel *knowingly* sent code that was sub-standard as some
calculated attempt to make Intel's life maintaining their out of tree
drivers easier.

This absoultely needs strong language as I can't catch everything and
people need to understand there are real consequences to violating the
community trust in this way!

> No one is suggesting to compromise the upstream world. 

I'm not sure what you mean - what could upstream do to in any way
change the situation other than compromising on what will be merged?

> There is a bigger picture here. The answer for this driver may just
> be take out the reserved stuff. That's pretty simple. The bigger
> question is how do we deal with non-upstream code. It can't be a
> problem unique to the RDMA subsystem. How do others deal with it?

The kernel community consensus is that upstream code is on its own.

We don't change the kernel to accomodate out-of-tree code. If the kernel
changes and out of tree breaks nobody cares.

Over a long time it has been proven that this methodology is a good
way to effect business change to align with the community consensus
development model - eventually the costs of being out of tree have bad
ROI and companies align.

> That is completely not what I meant at all. I mean we should be
> trying to get rid of the proprietary, and out of tree stuff. It
> doesn't at all imply to fling crap against the wall and hope it
> sticks. We should be encouraging vendors to submit their code and
> work with them to get it in shape.

Well, I am working on something like 4-5 Intel series right now, and
it sometimes does feel like flinging. Have you seen Greg KH's remarks
that he won't even look at Intel patches until they have internal
expert sign off?

> not encourage that behavior. Vendors should say I want to submit my code to
> the Linux kernel. Not eh, it's too much of a hassle and kernel people are
> jerks, so we'll just post it on our website.

There is a very, very fine line between "working with the community"
and "the community will provide free expert engineering work to our
staff".

> To be fair it is sent as RFC. So to me that says they know it's a ways off
> from being ready to be included and are starting the process early.

I'm not sure why it is RFC. It sounds like it is much more than this
if someone has already made a version with links to the NVIDIA GPU
driver and has reached a point where they care about ABI stablility?

Jason
