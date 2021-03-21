Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D3E343387
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 17:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhCUQpf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 12:45:35 -0400
Received: from mail-dm6nam08on2059.outbound.protection.outlook.com ([40.107.102.59]:63716
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229784AbhCUQpH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Mar 2021 12:45:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTIl/9mH6NUf7dR9JumieBz+ViBSwrvMSh0KLdxsjR/9PpnFD1t49TGUNOCwx4A7i6I5ThbupQfum2byJPMWwQj94utwbTnLbU4EItc7QxxOedwBabRDl6fB/e4/xrUV3Zi7miaWuO9hLS/rR6r24MAFxIYO86lr3v1k3KZmKdTLizQN5EiR/9ulLFtBNMKecP4cIY7ZqWvdDyKeeSo8jtleZIgbVATo1QsP+C40uVRW5ucB/WKWqZzQjIcXDdSvC2qTnmTwzbR7qmRPKa0VlR8b/ucosKHCciidS6jc8BgaPg1xcvjhlQcXqpZLHorRSaxtPr9jTdVrZG/IE5UFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7Sa91QeJ77eOfg3nFdXnZR1J/g8xhQ8hKgBTDJmd7Y=;
 b=bySAu9ktihKpqQY9AI8DHI6Bu2zzt5UB27uKdQ6SrJ0lDJTdbXjSy8Lu9lMXEWyRT5nhN2EFIT1Na9qMEkczgQzCfMepE4mrNPW9YbIFJKSyy0iuRzujxQffkvPcX+8zWIPdf7gzIX6ehbed7DZ+k9ic0ig/PFT3X+B0+oA/nCKA5Pq/YQi+3La3xG9Dm57/yhq7kHPJDSCPJs3w5zo1zkAphehsJ/HwA1S19+YSzy1jjqB4Bfxhq58WaQOpOz5grRDAxrQ6x5aYGtfBIDs9k2qUjDtQfv//TskMcE8oN+KASjFY/2XMS85GYINFJetvoVtF2OIq3ByUKZpVvdjKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7Sa91QeJ77eOfg3nFdXnZR1J/g8xhQ8hKgBTDJmd7Y=;
 b=mV4kEnMHXL41DqWB6oSOtsOeIMYcKTrnjTs0t5yWkuZ15JgvqZQ1AtKrl/ZdDXTA0jyksZCXT3fuWJ/vF4MmojdDGRjPpPxua3GO04sPM0zl6AF/EncRFN5ZFLV4+q3ctWSw+Ftea8Mqn7iqQG7HbXyM26jFgWurG6tr3UquZH3BVsTYNtboMVtDpGqzSs9Xdpb6E4aF2ZzJ2+03yhjuGLMGkcv300uELMpEZIWoBvKPb1khjeYb5AgrnD07epyxDHe3pbg/pSzI9mYEgQi2YTrlY7W6M+6536eG08rjC93YjRC8mJDkiEY5nBqvd8fqOQzYNib23eVadBhLYnQzsw==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sun, 21 Mar
 2021 16:45:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.025; Sun, 21 Mar 2021
 16:45:05 +0000
Date:   Sun, 21 Mar 2021 13:45:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210321164504.GS2356281@nvidia.com>
References: <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <be96ccbb-17b7-27e3-a4f2-5b2cc4184ecc@cornelisnetworks.com>
 <YFcKTjU9JSMBrv0x@unreal>
 <bc56284b-f517-2770-16ec-b98d95caea6f@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc56284b-f517-2770-16ec-b98d95caea6f@cornelisnetworks.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:c0::43) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR05CA0030.namprd05.prod.outlook.com (2603:10b6:208:c0::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Sun, 21 Mar 2021 16:45:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lO1CK-000cER-1A; Sun, 21 Mar 2021 13:45:04 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e3259f4-5f6a-4ea5-6ab4-08d8ec88ae12
X-MS-TrafficTypeDiagnostic: DM6PR12MB2601:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26010773BB7E73097BA71C49C2669@DM6PR12MB2601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 307KQ+BRnYqbiGnPg0oV8PkPJfuPDAwL8qhBIngnH6fXtjrO9lfTlfk9/vuJCpvlJuEUjJsfqoH8HFiacp7wznYdwqH84E55Uk4qsb/So5qOOSUZBqnxW5VinnquzXxHwoD22s+Admay8mlcalA/v2dTWOuXiKNaPTKhABBC9s0/wketXvIu/22xulxNB4AebhWuAql1LWGQ0pLcZSAH67w/uhUFbbveFF/LkHBf2SfYO84+BdnrM3UZKFThS08iDgEdlaejPgXOqOrD6QvfGfPvttWb5cG8MIBDvt/tfXZndZqMAbLjh0QfdXuLsE0fDd2WPI/UUp+lIAyreR6DxFJc6VrI7qAMAR8m8row4QnLQUWxsojyLYGeI5pMCJq9pztiI8QDX29/6Gc+Ji3EK+qISFIMxdmDikYhClMdNxkjDUGAC1VDy2kRolg1Pi7EwpWYTUNTExy3hjMqseUQMVFYRWzz7yI4GK3sx5nkwd+GF8eljghiMhXN5q5Ai7WDluG9qCOraGiUPcE31u3siSx1izHI4a3+8AJB3YU/cEw4Ipm/ZBWqHE2u0TWmmTOkveRtX8cl3tqzIEPaghe7QDsMry/l3+C+aFye5EC8YjOnF9y2L+Bhh5lxBIH0QaWU54opBaq6i9iPXWi5fXj0AQ/Tt8Va1ju2MhqNb9qaJis=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(478600001)(426003)(6916009)(38100700001)(2616005)(316002)(5660300002)(53546011)(9786002)(9746002)(186003)(66476007)(26005)(66946007)(83380400001)(54906003)(66556008)(8936002)(86362001)(2906002)(4326008)(8676002)(36756003)(1076003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GVbfrx0aD/b1JpiW6+IJh8NOW9+vb7IO8iclww2sggTvEwYDiSWs+sY0/ASG?=
 =?us-ascii?Q?/nDEqY0VxLr/uQ4YZkzXMFzmJYgFvYEIcxkPP0wAOYGRXm/8kKzaN3h4mgkK?=
 =?us-ascii?Q?r5IozZvJrwff9ddb5s4G/oknD1qIjTBPB6bChpZSyImLbLqUZ7mOGmEFul7+?=
 =?us-ascii?Q?GfSk+184X7FimQ1ZSo+elOb5j4GMwVE3FHfam2hmLtb3YpvOrS52stJHdE/e?=
 =?us-ascii?Q?E8v0ZvnFuJ1CtpbGDyir4EsvFCbtaOJYbzZOpJ98rLvs9i6M8ElF651pQ0B5?=
 =?us-ascii?Q?TavOs3ZAUpRoqzCYJLIlhH1GLRYhj1VJnTosEBApuRExv04sPz0KPh9v+pvF?=
 =?us-ascii?Q?w2loUmpcDT5EDZP6QQy8wuHam3xNKhQ5JUZ1e99sFor++1+lKGlF8eSoK6xb?=
 =?us-ascii?Q?rEKPeIcXEikbNA3QZKEEagIQwm26qiKIzJzbZM6jdkccAh16LRVIbIrmLAEa?=
 =?us-ascii?Q?hDuvWxdl6I/foJj8bhezeCTVIWA0O200PBvXq9DO8aoHLAUqeJhuZmt4aIMZ?=
 =?us-ascii?Q?W9by3dQqg9GDlqxv9zY8r7jECoiE0lQ0oKzDSg2mr7Iyw2AkWrrprCVZMLdc?=
 =?us-ascii?Q?7BsmbAyMhjWM9pHd4GobsgbpdZoj9aPDWimiLMEe7L3E5X7APBrb2mKfkrCx?=
 =?us-ascii?Q?rFgn8dgXFq2yasWB+xLlv1OVUG/A5dN2uarp783R4wG2MKFCoirLBvYSp2yR?=
 =?us-ascii?Q?p/RATGrPdv4FoWX/e7pMmVP55N2CqHd0VBg1zqMV1NIFfeXJ4KoYMaQrNP5C?=
 =?us-ascii?Q?/tsGwhqgIyH0LYZTjyHpI369wO7QDlAWgbHVUAbV9oT8Re0kF38dIItptI+l?=
 =?us-ascii?Q?DFjFs4DbNme2qkS+JHIvJlNMryh48p5rKl4o/Sas+TsYIYj1Cxk1/twhWdzy?=
 =?us-ascii?Q?UpXv+9u5npTiCDa1Fk9B3/gfQdhFgCCnkZ1WNYFnr2dS7DWhiO8ZBlrL/9yp?=
 =?us-ascii?Q?cd/AlPzR+cmJFYmK+hcvOzemLUregg1KMv1Qnae+mZ0wSGGFpksdqcayWZ4A?=
 =?us-ascii?Q?TkmoautulTwGcXZ3jBokDbPCgYG1IycrYhZUsu8c3xuUZAFisICc+D4x+D0F?=
 =?us-ascii?Q?M4q9aDYzRmqiH8ckVtWQqDfivs6uss8jJkt2ZJvn0arFh3nbgfBLEc0XqKED?=
 =?us-ascii?Q?BjiiE0DlAU6BEkyBONce0qgOfGurE/dolcGf+Op8CFmabUdQvyG0JfV4S7o7?=
 =?us-ascii?Q?UiQFIdQGtNMAmQoxpdH25aXi0fqeZhzzJar22s5+wIOGDMr2vZc2STuaFMlU?=
 =?us-ascii?Q?K6lMSwcl2qHD3FfdtP14M0yR7+b0UF91/ZZKRJdVZkQgtt2S0SSrqYp/v523?=
 =?us-ascii?Q?pTIrC4JbYLbFHIN29iw5JTwAmvuzgGq+US9Uw7JQl1I/mQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3259f4-5f6a-4ea5-6ab4-08d8ec88ae12
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2021 16:45:05.4054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rf4gQfG+44kqS1oPlOiImY8ebygdMeZWHlNQEaMI/ZMjXwzmpIuEp/3VeH5CVHbv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2601
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 21, 2021 at 12:24:39PM -0400, Dennis Dalessandro wrote:
> On 3/21/2021 4:56 AM, Leon Romanovsky wrote:
> > On Sat, Mar 20, 2021 at 12:39:46PM -0400, Dennis Dalessandro wrote:
> > > On 3/19/2021 6:57 PM, Rimmer, Todd wrote:
> > > > > > [Wan, Kaike] Incorrect. The rv module works with hfi1.
> > 
> > <...>
> > 
> > > > We have removed all GPU specific code from the upstream submission, but used both the "alignment holes" and the "reserved"
> > > > mechanisms to hold places for GPU specific fields which can't be upstreamed.
> > > 
> > > This problem extends to other drivers as well. I'm also interested in advice
> > > on the situation. I don't particularly like this either, but we need a way
> > > to accomplish the goal. We owe it to users to be flexible. Please offer
> > > suggestions.
> > 
> > Sorry to interrupt, but it seems that solution was said here [1].
> > It wasn't said directly, but between the lines it means that you need
> > two things:
> > 1. Upstream everything.
> 
> Completely agree. However the GPU code from nvidia is not upstream. I don't
> see that issue getting resolved in this code review. Let's move on.
> 
> > 2. Find another vendor that jumps on this RV bandwagon.
> 
> That's not a valid argument. Clearly this works over multiple vendors HW.

At a certain point we have to decide if this is a generic code of some
kind or a driver-specific thing like HFI has.

There are also obvious technial problems designing it as a ULP, so it
is a very important question to answer. If it will only ever be used
by one Intel ethernet chip then maybe it isn't really generic code.

On the other hand it really looks like it overlaps in various ways
with both RDS and the qib/hfi1 cdev, so why isn't there any effort to
have some commonality??

> We should be trying to get things upstream, not putting up walls when people
> want to submit new drivers. Calling code "garbage" [1] is not productive.

Putting a bunch of misaligned structures and random reserved fields
*is* garbage by the upstream standard and if I send that to Linus I'll
get yelled at.

And you certainly can't say "we are already shipping this ABI so we
won't change it" either.

You can't square this circle by compromising the upstream world in any
way, it is simply not accepted by the overall community.

All of you should know this, I shouldn't have to lecture on this!

Also no, we should not be "trying to get things upstream" as some goal
in itself. Upstream is not a trashcan to dump stuff into, someone has
to maintain all of this long after it stops being interesting, so
there better be good reasons to put it here in the first place.

If it isn't obvious, I'll repeat again: I'm highly annoyed that Intel
is sending something like this RV, in the state it is in, to support
their own out of tree driver, that they themselves have been dragging
their feet on responding to review comments so it can be upstream for
*years*.

Jason
