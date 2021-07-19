Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13E93CE7B2
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 19:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345165AbhGSQa4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 12:30:56 -0400
Received: from mail-bn8nam08on2070.outbound.protection.outlook.com ([40.107.100.70]:28512
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350364AbhGSQ3X (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Jul 2021 12:29:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+0MMyYj839OVJTSLKtoXaXHq5oMYdZa1lVb6CDVjMRF46H3542qLWHhJ2dX0ErKuZ5Z23M5L4MydECf6GD6huWWkh9njPxY28a3GOeshV39BUlaBuuBS3XmixoSZQLlPeofVLIsEXXcEtgEqfsBz91ON3OBypDjl7QzaK+E1CxnC1/CVJ5HzFOezl2aMcjciO5K7OSMg0/4i53PEFrVeIH0CA2r4dnBQPep9ZTwP8nDlA0XZE9qfCELPkwg5LsAN0SxLzfAnkhMM1RP1+LqsV5DD1/g+88MqC5nC1MrhIT1o9EhI1pCWzu12CDghIx5LGWXYYAi6TZ6iMl59D0skg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzCkTeEqlYJjq2O6KMNtZ/dd5OuKdu8NcjuehLKPvpc=;
 b=k+jCFhGKZ7Q4ae/o8zAVqU8m+FxjGOWtqhgg5Sbjm0vyGMTt1mQYcqpqTrobrw+VTNFmAuR4l9csPZYsqmKA/uX5WNS0gZApZWBbtbvMGdERU8zf/aWG55EsWRM5n9xcMZKFwsPTssq7AZNr4JswZhKe2SOxCHbz+CmYJudrgMsggZ05KPig+pldDpJVpSIg4oON2WU9QOeqx41g0UdvjOqJrAGsrEvdYFGaSyzPCftMVxm49+hW6PHAinnuD41KCU2cFETSqvOzjM35WL6uixA6QuY7tObgEio5WXQGTaSjopVegtzHzfAuMH3ZaaFLHtWIWhNJPhIV6Jx/yL7Iwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzCkTeEqlYJjq2O6KMNtZ/dd5OuKdu8NcjuehLKPvpc=;
 b=EfFn6sqxjGrs42BP1nHRTRLts5LI6iT1XN/VnT+kOis2ETtv3eZnjEDo0SBVhZBL2YIGpVzRlmm4nKaFFg6dl9ayoIV4bQ0WYxbRrjJn3mWvUZpi32ivp/ymwi3R9/nYkgubU6TVJy4vy19wB2jTaixnjNHRSHxGe2S6zdX0ayIoEDv3Wlj54iXhCAzIDJVj/id1wQIL7znsb1mj0/sq0bx7DB1y7zUJ3jZIvpL5HixUJdLZULkJE5YaCERmMwTGHkzb9O8W9YbcJQPfi9Hs+lmJTXB5Y65obvUsZtIDkm9V565d1ZZ0Tk+bvg8F+SV+pVLaOB/8qB/0LgwDJYMUbw==
Authentication-Results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5537.namprd12.prod.outlook.com (2603:10b6:208:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 17:10:02 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 17:10:02 +0000
Date:   Mon, 19 Jul 2021 14:10:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v2 0/9] ICRC cleanup
Message-ID: <20210719171000.GT543781@nvidia.com>
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
 <20210716173804.GA767510@nvidia.com>
 <CAD=hENfj2vkNV1uKK7hgfDLqN9xY2fwjiFS536tM9oknMuZ4Fg@mail.gmail.com>
 <CAN-5tyFrtf8SEet8at7QvwnFqLmdZoK2AaULXfXK-kq0_F8azw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyFrtf8SEet8at7QvwnFqLmdZoK2AaULXfXK-kq0_F8azw@mail.gmail.com>
X-ClientProxiedBy: MN2PR20CA0056.namprd20.prod.outlook.com
 (2603:10b6:208:235::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR20CA0056.namprd20.prod.outlook.com (2603:10b6:208:235::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 17:10:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m5WmG-004Z45-L4; Mon, 19 Jul 2021 14:10:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06b9eb6b-4a21-4524-ac79-08d94ad80ba4
X-MS-TrafficTypeDiagnostic: BL0PR12MB5537:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55375DA9EA9763EE707FC96CC2E19@BL0PR12MB5537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ult/0JS03vM8kuOU9aYM7jMp46A1vBsL5JEqerktggrcx+J7OWlwCKb9pzgzDafDx/xlXjLyw+PIIbbwSzIdotYW0B5/6ay+DzJb/pQPNUu+P+6f81mRg8xG5YhWR4XhWC/18mEJLU18QO9c5+JF3O0H6aVgQm7IXgHX/AsO/zGF1Qum2BQJ+vRWGM+och/naSC+nXZJkwlPEfuNJTfXM6mtqh3XhFZ1qrI2624dXBnHvmGT67GZXEcDt7WV8C8aLnOJ1WD4dc2bNy7ZGcLXlD/ivNl/kZUv6Evp5OtZSmYsTdDptqseMwqgN3126jQNFF+HkKqoi4jSo0rSXnvC/rxfXSbqq4LUc45SGOiNZvDHl0KvxpVfHz4f1ODlqNKlorGd/0N/c9mIeK2EnLzr/8y06RksA7mIgov446R6GfG/5jdcuU79c1TK/96kUtHG5Qq2HCyQMKsp42g+K1+J9Yzo/mt6tbIz/zb3RZS531aeF9aOmvO/gd8UAWNITloKFgvz9qx5HpIjB+8rjpYnxoI0ZVaCK5qdDV49AsAsnbTXelColX71WOPj2eFO98gdHFe/CVwDbtAfD8xJ4zFJoQWTfHEDLUnV3beXhQYNQF1hGO5yiIb1IOtnKLmMUPT2+qhpbziTKeImwbgGdG7Dy8MrJluydWmbWcjoCxTGeaU7Lnnu96gEsUG8cwrF9bdr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(1076003)(36756003)(66946007)(66476007)(53546011)(4326008)(26005)(66556008)(6916009)(8676002)(83380400001)(38100700002)(2616005)(426003)(5660300002)(54906003)(86362001)(186003)(508600001)(316002)(33656002)(9786002)(9746002)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Moj2OuP/52PpW0uwLiLoNNOGdCNk1Ft0i7nTypQnO7ZbxPm4XzDr4sALs18?=
 =?us-ascii?Q?hPxuLsdRk4z03B+PbsJAMcvx4rIwiIpRzLqBwTls0YkYhGbjZoyo8sPrVrPo?=
 =?us-ascii?Q?veSfNsmROsRj0VmIt9NSC+BVNDG6WlJfzxdBC4LycpFSadVYKTZcxd/Ajgux?=
 =?us-ascii?Q?Xp9tKFOP8MgXfj0xmiE0sQfZFMyeQ8tkEDaBM0rZHeK74ZdUkhze6XhrEy7f?=
 =?us-ascii?Q?3yZ2hrPatZPZ9TJUUVH2eYfDI/7ot3KroeunG2aMXSqxPQLbhAELoMo907Xj?=
 =?us-ascii?Q?QhtyX3MHQz7VA0gGKfO8UYgmlGvdL8GF4aXeHMsJXyyfe0xUy3ZEP23OlO3K?=
 =?us-ascii?Q?KsZkHqytPHkPRY9gOY9xtx298OMMB4S6Dgyd9tQDUz2npDadU7vFiNIlWs6v?=
 =?us-ascii?Q?ZRm0qWNHIywzDEirkkhbPwew5ftMollPUg93UK15djhqaBPv7NW7QdP/OyRu?=
 =?us-ascii?Q?u3R5+QCMgJlJd+ZNYx/xsyoB7cE0gtUsVzR8vl0FsAt+zLRVSv9iyAJb+emz?=
 =?us-ascii?Q?BNrTrR/n15z4CX0SZci0fvTrBxxcIfL4YxO2zAr/NlQMvXaM3uC0rsaiC8MR?=
 =?us-ascii?Q?FDnJH1/z+pwcgUDRk9r8TjVMkyxp+8IPOAQt7jx6BT45SwfjHEX9bVsbbxGA?=
 =?us-ascii?Q?/Jis2VmjoVWrMA7KNI4d61bmGUKPHowbjLgeWtE+arlPa6QVZnubMQTHxkjY?=
 =?us-ascii?Q?THputwnYN9FvOnv0USq063wrtHoadEWkY0CER7SxCPWXgMLr8eckpvO+5C24?=
 =?us-ascii?Q?OWG6Bfpzj/bAxbXTVVHqmxXyEWfC9EiSjY8ZPL/F7UMZ3K2NwIzwF2+j70vP?=
 =?us-ascii?Q?DCSV9jhJotitbH43gpuLmM2w3aMu3k+4sfLYw5uLRWlbZUsPNV/HEByQaulh?=
 =?us-ascii?Q?lpOBOVlBoh7A7OzJuYV8XKWeeZXWl/ZKHHc5CmIcmgKv3lqM5bTTsEqQAdyj?=
 =?us-ascii?Q?qXvFrX3gMXIAsSKaskwB9I8Qd7+p6CzeUVf1lRzClLpz9Fdc0gO6ae6YHp1s?=
 =?us-ascii?Q?Gm5C+0wI6fC3AvX7AXu057zId+vLowcxTUg+ToXsXAc0IbK/RNh++x0ANF0V?=
 =?us-ascii?Q?UieixES0CkXZ+Opv3JxiGLKKfPUS/nLWe2GZ1pS5j8nKbpCCB3puYa+rZT7a?=
 =?us-ascii?Q?HjaIyza2lYHQnF8TjQTT56YFWlAUP+ZW6XIaP6PxuEuYzkhQ7Fn9WlEgU20N?=
 =?us-ascii?Q?y48+seWJyMeVjc5VcZAN7DGNkDzv54gnIetH+mek2VbS78FIYZm6+h6z9ekM?=
 =?us-ascii?Q?VS88wyNAVFxnVOk06jXBaHm4YktooeIvi8EkOQIHNyLh42kB/Y7+AfEiO5XZ?=
 =?us-ascii?Q?h5Q3jJ1lek9JSJV9wISSPhDN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b9eb6b-4a21-4524-ac79-08d94ad80ba4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 17:10:01.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6EOqqJTsGODeUjJo5maOQFxws8KCJiIwcMkd9HGu5QPc2FWRfamfPa4tcZikipV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5537
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 19, 2021 at 11:53:20AM -0400, Olga Kornievskaia wrote:
> On Mon, Jul 19, 2021 at 5:16 AM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> >
> > On Sat, Jul 17, 2021 at 1:38 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Tue, Jul 06, 2021 at 11:00:32PM -0500, Bob Pearson wrote:
> > > > This series of patches is a cleanup of the ICRC code in the rxe driver.
> > > > The end result is to collect all the ICRC focused code into rxe_icrc.c
> > > > with three APIs that are used by the rest of the driver. One to initialize
> > > > the crypto engine used to compute crc32, and one each to generate and
> > > > check the ICRC in a packet.
> > > >
> > > > Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > > > v2:
> > > >   Split up the 5 patches in the first version into 9 patches which are
> > > >   each focused on a single change.
> > > >   Fixed sparse warnings in the first version.
> > > >
> > > > Bob Pearson (9):
> > > >   RDMA/rxe: Move ICRC checking to a subroutine
> > > >   RDMA/rxe: Move rxe_xmit_packet to a subroutine
> > > >   RDMA/rxe: Fixup rxe_send and rxe_loopback
> > > >   RDMA/rxe: Move ICRC generation to a subroutine
> > > >   RDMA/rxe: Move rxe_crc32 to a subroutine
> > > >   RDMA/rxe: Fixup rxe_icrc_hdr
> > > >   RDMA/rxe: Move crc32 init code to rxe_icrc.c
> > > >   RDMA/rxe: Add kernel-doc comments to rxe_icrc.c
> > > >   RDMA/rxe: Fix types in rxe_icrc.c
> > >
> > > Applied to for-next, thanks
> >
> > Hi, Jason && Bob
> >
> > I confronted a problem.
> > One hosts with this patch series, A
> > other hosts, without this patch series, B
> >
> > I run rping between A <-------> B.
> >
> > I confronted the following errors, and rping can not succeed.
> > "
> > ...
> > [ 1848.251273] rdma_rxe: bad ICRC from 172.16.1.61
> > [ 1971.750691] rdma_rxe: bad ICRC from 172.16.1.61
> > ...
> > "
> > It seems that this patch series breaks the Backward compatibility of RXE.
> >
> > Not sure if it is a problem. Please comment.
> >
> > Thanks a lot.
> > Zhu Yanjun
> 
> I would like to second this post. I was about to submit a new post
> asking about why rxe isn't working and if it's known. I'm trying to
> figure out when/what patch broke things. From the stand point of
> NFSoRDMA, it stopped working and I have discovered that simple rping
> doesn't work as well. The last known working release was 5.11.

This isn't included in v5.13 or v5.14, so it can't be this series

You should send Bob and Zhu your non-working report

Jason
