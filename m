Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EBD380BEC
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 16:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhENOgb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 May 2021 10:36:31 -0400
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:47841
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234206AbhENOgb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 May 2021 10:36:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQ4Hj/PwU1xg5TWf1vxdx/H0xP8QhjxxaSdygAFdQenO5rRVj93g0O0ekEz7tZ2HcpWJOYRP34Hdc4yxKhznYF/8vT5cG3TXUlwgSgnOPr4eEGRrL2SKnatX7ja9uA9cL36nN+HnuT78Gss/itVqK05TLc2R1ZXcNNaK+svjyeklh6CTvY8h6EggC4Ds2bK+EMmUh/0+cLVPy545LDUmY+LyYEEH5/Jrn3/otPGDJsg6cox1sNA5wQMCH6R6VjDSK4t8YVYLXUyKRKgqiPvveBh/baLmLIDXjEWCC/CZQ0bK8xfdEe22eOkLBu/yAG6vVnGqceURtwwB71YcH+b9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP9KUMf8UidM7S+hJAkXIDAO9Z7DWud4t5IJqYq+qeo=;
 b=aHmbwwxQ/zG7ImCKqNwSIGggl9udkJR0CYtxKuSBd2lMZX3GmJ73/g2ULHo8icS6BNko/8uOsWi5n0Bs8J1/Yr79TfK7453wHYGk0qD7kxBAflt8GSsC1Kbp/8H3sk+l2W6Ma63ZAN0NFpkCGP09c1t4yqYpaXY7kVYNPx/8qNdPQQ/wWy/LsQdFe5V4IM9v5uiPlDY/R36GyyH3jPRQ2Tzxjhtlt5z/iWFTMrFohS4yKruq/PkXi2ueu7yJ++agyiHy9iZKOfjDJutJZU4qbL8f2zvAUzf7nlq6BWLV7RcCbzB4sP5VPmP6MYFLfL/9nUxwdpkTMd7aAyYNWh5CvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP9KUMf8UidM7S+hJAkXIDAO9Z7DWud4t5IJqYq+qeo=;
 b=gVTXcQAnMHTmAF/1GosnAI6ODk+az5AUJHAwpbUYup/OYBDALamzc/giwrf3QkG50EyVJZ4zA6eZd7MT7Nii2yE2yWfMqe4hvkPTmi7UqTdt4C2sL+NkepsIsXYkrggRCvEWdOYepq+dUJYtT8x8yy1bO5T3LC0kPyYL3Fc55T9Gy1loww4rmAXy2CQGEdOzXzDLv4pWl/KIv/5gUbOkkgJvH9mHCEj4q2xWjUBqVF+2vRJL+LuGplNgCN+Gt1MryZvLFhLGK5//1BuAF+s5ADkole6dxbK04xfBH2RPrSTwYJpax08/ubN4OsVgKSk/13uivsMlHBzulquYzHTv+w==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4009.namprd12.prod.outlook.com (2603:10b6:5:1cd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 14:35:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 14:35:18 +0000
Date:   Fri, 14 May 2021 11:35:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <20210514143516.GG1002214@nvidia.com>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <f72bb31b-ea93-f3c9-607f-a696eac27344@cornelisnetworks.com>
 <YJp589JwbqGvljew@unreal>
 <BYAPR01MB3816C9521A96A8BA773CF613F2529@BYAPR01MB3816.prod.exchangelabs.com>
 <YJvPDbV0VpFShidZ@unreal>
 <7e7c411b-572b-6080-e991-deb324e3d0e2@cornelisnetworks.com>
 <20210513191551.GT1002214@nvidia.com>
 <4237ab8a-a851-ecdf-ec41-4e798a2da156@cornelisnetworks.com>
 <20210514130247.GA1002214@nvidia.com>
 <47acc7ec-a37f-fa20-ea67-b546c6050279@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47acc7ec-a37f-fa20-ea67-b546c6050279@cornelisnetworks.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0055.namprd16.prod.outlook.com
 (2603:10b6:208:234::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR16CA0055.namprd16.prod.outlook.com (2603:10b6:208:234::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Fri, 14 May 2021 14:35:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lhYuK-007SZZ-TH; Fri, 14 May 2021 11:35:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6c49756-99ca-4ec9-4382-08d916e57edb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4009:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4009C35278EEEECF030B6EE8C2509@DM6PR12MB4009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLO92W8CbbN+2IpcY5uDtrjG6acjF1OMccrvxAEraGP/nuNyE3EYeSiyk7UYxBwruaaIx9NUF2YWfaQWN5AAkI0O/W0xr+gd5o3dPmVOEMXGRpnr2CqckaRmNKOVfy3oVr7pYBC/7D8iZeq9tERnk/4OSG07vqDz7SGoPbjzm4hXDSb+j9iKPKBr1UcCkpAEDYdKZ5Wz8iLXac2O0RxAWsNf+hNRSPjGdoHa9SvAumrH7Pz9qix232IuyJg+Nedq/9JrCyb78TsvDAYKgyqk7uhmAUUuzBXrQkmxLkkFYqan935Qfta7NBXUG3EJcVXh8CpFwICtvB9VPaBx4LTM/hZybW6tBxkZBs/hfS3YTjgD0lnQujchKuiumWF2ppvguNzChbC9YP2TDIwBT0x7hCMCZZ1yetiwVkxT6g25m3+Wr7wXgFlEU8JYvKyQfKCQYOZr2+l1uaCkSAW9llmRVswWloXiThV2pjPTFhw91En6TCLgMfukShwFrgtdQtt8dqo+tbKqB77Ohqbsu+WXQQoKferDi7FxoL2Z8xplChUn+41Cd/34kT1ntnS2rOOIlIYk0OUwiJqeICnrG5IntrJWAvoRV6neUDukdoP/1VA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(478600001)(83380400001)(9786002)(36756003)(33656002)(26005)(9746002)(2906002)(54906003)(316002)(426003)(8936002)(2616005)(186003)(86362001)(6916009)(5660300002)(66946007)(4326008)(1076003)(66556008)(66476007)(38100700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1N5Ht0cJFXyh890ATXQF8ySgFpmuIYrnzuy4/Ryh0animxICR8fq65bP64ln?=
 =?us-ascii?Q?mlgdTv9nSTHzV6trlcG6GwhKmoU9u3nCqCvN3Tkm1EInc4+NKw/PRqWwPFsg?=
 =?us-ascii?Q?oAfYmV9TzyST3gKG7mrldaX4EiKnwSsprbdXvtwqNYUnQ0wf2gqx3pjJleZD?=
 =?us-ascii?Q?3gdbKLKk2QuS85Et/H5uwpV/W2f89goG9+HWtOP8YjMICIRdHV69foI428MD?=
 =?us-ascii?Q?A5SyEImL7bgSMF9rMz06SR2/MsUYGeqRYdgXy5GoUTwNHJq1hwIeOGukSi54?=
 =?us-ascii?Q?pi2Ef2Zmo+VKuDJMyOdrPXmhburOsjmv3TtckzKZ4GnTD/3JV0aIDRN6cyWi?=
 =?us-ascii?Q?NoRMjpMmQvG2soVxlqjA6prUqrDE5DRNlMVKDHS2S0vQXG4wz7QZs5zLv2Hn?=
 =?us-ascii?Q?d+9Sj7icu7MjThCeH0FqGFYk5d1c4eKSSprqGjIkRKPxPzZqM7UzOrGAp5HJ?=
 =?us-ascii?Q?ONhAGBnYC7f4PgAlKECnOerdtS6uQbpc+HcmvRaOjAf0DEx9mCs4XK37g76k?=
 =?us-ascii?Q?PCEynsUBwtzxw9UuHSaOAGXv3hDh17ZpVZcFJgEQzlNJKdnQGcVRP8Wn4pU6?=
 =?us-ascii?Q?ZftT/6DC4u7N09U92uqVDn5Faq4JTVFV/6Cq7GIVTXUlo1Z434BgKQVo3kfT?=
 =?us-ascii?Q?s2F9hst40M7gerneR5Wn4e+/z9uEeqKNU/AmNDiqiG3c7xwSzYpMZ9xiT2LV?=
 =?us-ascii?Q?ezySGIaBZs/uRBCEdEc0OLEJwsCrQNtnR3duvPmGQp3/KnE1BwgzYyv1PO2y?=
 =?us-ascii?Q?d/OdwJVAhhUy1WGpal9uQ6ibyhUhbStS/9Cuzj6DG8otkc70liIcooEymyfK?=
 =?us-ascii?Q?nq6sOb0kJFRA68WCiU7KfCqsQ7T4QB+hjKwfKWMhjdCIxBiZDxY1QWlRQQkm?=
 =?us-ascii?Q?/gY5YrmSavRBA+V5JuN3ciw9bDC5hnhoDqTwFVlVcXE/5WiMWem7TTA7wiAX?=
 =?us-ascii?Q?vA7sNcGA7LVvf5E9oDEOuPY/SmvTobPmuMK5CsRvnE9ys+TpDxp+sCitXlUl?=
 =?us-ascii?Q?CQkH9NO06V/cryrT8NFHgvfTGgXf2u5OrPFhbKxPzJ2nufxYLNl0DZcF1NPt?=
 =?us-ascii?Q?+PqyrIY1W2OE3NHedwnu5M3bPiB4JRUlGADxjPr44fCQ0rYojIhQFg2aQzre?=
 =?us-ascii?Q?XUCPxPAekQ2YlWBCNFHxtMGno05meQ6wkqusMGRO8pFtrTKGELSjyksn0HdR?=
 =?us-ascii?Q?DcqgoQtMTZExjOBGhMOWjMqNkYJpYNUSw7FnGHNq4nRUJjvVeOmCBwNqd9/m?=
 =?us-ascii?Q?xah550xY2EdBTzKCuHGXaPtH7jcgXsarDS0XWRt2tHwO/qfP6YXSCSmB4tdx?=
 =?us-ascii?Q?I4G9xjTq+nWS94dt38c5uHUU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c49756-99ca-4ec9-4382-08d916e57edb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 14:35:18.3775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRWN64d1/D73n76pX4a7F/93GZ7ujixBWxkT5kp6Caft8laTn0425Y/kJekKgfmn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4009
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 14, 2021 at 10:07:43AM -0400, Dennis Dalessandro wrote:
> > IMHO if hf1 has a performance need here it should chain a sub
> > allocation since promoting node awareness to the core code looks
> > not nice..
> 
> That's part of what I want to understand. Why is it "not nice"? Is it
> because there is only 1 driver that needs it or something else.

Because node allocation is extremely situational. Currently the kernel
has some tunable automatic heuristic, overriding it should only be
done in cases where the code knows absolutely that a node is the
correct thing, for instance because an IRQ pinned to a specific node
is the main consumer of the data.

hfi1 might have some situation where putting the QP on the device's
node makes sense, while another driver might work better with the QP
on the user thread that owns it. Who knows, it depends on the access
pattern.

How do I sort this out in a generic way without making a big mess?

And why are you so sure that node allocation is the right thing for
hfi?? The interrupts can be rebalanced by userspace and user threads
can be pinned to other nodes. Why is choosing the device node
unconditionally the right choice?

This feels like something that was designed to benifit a very
constrained use case and harm everything else.

> As far as chaining a sub allocation, I'm not sure I follow. Isn't that kinda
> what Leon is doing here? Or will do, in other words move the qp allocation
> to the core and leave the SGE allocation in the driver per node. I can't say
> for any certainty one way or the other this is OK. I just know it would
> really suck to end up with a performance regression for something that was
> easily avoided by not changing the code behavior. A regression in code that
> has been this way since day 1 would be really bad. I'd just really rather
> not take that chance.

It means put the data you know is performance sensitive in a struct
and then allocate that struct and related on the node that is
guarenteed to be touching that data. For instance if you have a pinned
workqueue or IRQ or something.

The core stuff in ib_qp is not performance sensitive and has no
obvious node affinity since it relates primarily to simple control
stuff.

> I would love to be able to go back in our code reviews and bug tracking and
> tell you exactly why this line of code was changed to be per node.
> Unfortunately that level of information has not passed on to Cornelis.

Wow, that is remarkable

Jason
