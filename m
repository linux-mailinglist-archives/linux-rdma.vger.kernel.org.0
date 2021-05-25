Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E433903CC
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 16:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhEYOWY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 10:22:24 -0400
Received: from mail-sn1anam02on2050.outbound.protection.outlook.com ([40.107.96.50]:59328
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233889AbhEYOWV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 10:22:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpLMlHXBDJhIQb1wt4jJ2wgIowqXgc9G+QtTjb4lN/DzQwdT+kFjbduJiIvzQmaztBLzVGFj4mZJaQmu63HWNUjeDGE2929yU7qFFHuA4Uh4pmEWWcBANxnKRWqrEXIVEiVworulRIKPralLw2zXegte8HtR8ZoNVXRDPS753J1Qo7BjcB59HJL7XSxhsmcbZgPmVleMnhfI2KVo+a3hDHQ4wa2PSGUL81dbJcnLnunzkrYf5V91U+Lk/faP97SnntAecdoSxlpfpUW4GAGM+Y0mGvt+qrKOxymXYFsfeQ6LJzfavIiSJgLXhnngR5mbj7vVGBEnJiAzSz80tdmWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz4CTrLTLJr4AXE24LbXciq4DIulj6LgHdZjFL8gzko=;
 b=XgOdaTaQf7Hr3tuWksxPvele22ErCIB3ZlwjDF/W57Hx/tTDArxHQjl7jzKfAEfb8LodQB9daWL9il2i1ELP5eP2rqrnLg8buV5iMdtsU3+B5FGqzjAm+Tm+J6q3juHCAJ/c6h7Fm++NfodvoT2+b606hpFyWR0JhZGBT5sXR1en8RW+OUf7QS12fGQCrdYaNRxxDgFypu+HvL5xLf7wypzEcqkoZMezWeQxehLrdy4jryK3cTRxQsjLSaGUI9eD+D0McTcpLWPu1CeYzPDo1k5ZHgSN+WI0+X0CPG42ZvbWZK8UV1pVsFGK61wY7ssoFQ/MVJ/XJGhyNvShUat3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz4CTrLTLJr4AXE24LbXciq4DIulj6LgHdZjFL8gzko=;
 b=ub3IUTuFwO5UhwfZhlaMCjsP3JnEbgJQH0JXsAFeetf1/NFQCW43h5Ay6rwRGHsImP3m8t4wELMvjjcv4DA9yIPjTElb5EdywZhHq0uqkskf274Qg1k7Jd0zUzaQR8rYK2uv/AxOc7Ob/UG5NTI/BNMFS4R9sKTo32EdKU5MJi6qChcsyp3nga1CbTt02Ko3JYE/XW0zYTaq0DId0KCtWimR+a4lgYUlOEBr3VcObLqCqB/vfVaPnvGKcqhrVs5N0IMkYcLMA/m1+YE9AvdeOjzyQW8otFITRLiirLSxcBS/DdtjcW2rx8dvQp4CTFld64SjtHIxma25S1qZOiFFOw==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 14:20:50 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 14:20:50 +0000
Date:   Tue, 25 May 2021 11:20:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <20210525142048.GZ1002214@nvidia.com>
References: <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
 <20210514150237.GJ1002214@nvidia.com>
 <YKTDPm6j29jziSxT@unreal>
 <0b3cc247-b67b-6151-2a32-e4682ff9af22@cornelisnetworks.com>
 <20210519182941.GQ1002214@nvidia.com>
 <1ceb34ec-eafb-697e-672c-17f9febb2e82@cornelisnetworks.com>
 <20210519202623.GU1002214@nvidia.com>
 <983802a6-0fa2-e181-832e-13a2d5f0fa82@cornelisnetworks.com>
 <20210525131358.GU1002214@nvidia.com>
 <4e4df8bd-4e3a-fe35-041d-ed3ed95be1cb@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e4df8bd-4e3a-fe35-041d-ed3ed95be1cb@cornelisnetworks.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:610:b1::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:610:b1::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Tue, 25 May 2021 14:20:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llXvM-00EFtQ-SH; Tue, 25 May 2021 11:20:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d97eb01-27ff-4366-d3f5-08d91f884bfa
X-MS-TrafficTypeDiagnostic: BL1PR12MB5361:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5361E957EA7B2FDC136D16C5C2259@BL1PR12MB5361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jnDNZteV0beqh1ed99C8Qrc9O26zk7nogUcTzQvGXkiNhsm0lm1WbHzw1zBYnvk5bbZPNF84RAll4ZGtaVepmqQqD4JiOrfkfPTYqE3jztjyeq21+azKBcxTLQgxXiAL3wBEchKBmV6OyCh+x54l1VEVX+adfmYQ5LXSvLnmwSGrQR+ya/Fi+fuhfRQ076SXp0dvM/y/MMRe55XTdpUdR3uQEtLHcPLwIl/GrXw9LRIlMT+8zUDkjEbvjxkGfdD32mHMP6YCArF0KqGClq5Ki6p+EgTZlmVbFva36IXl3L1NTuD75tpGOQt1C2LcpZdiLhYIHotcHcCMJgwwzBM+F2F6h0QAsc3OeWHKzlVDnoOQZzAlMgrEhkISxOKeIu/fWzeWELxw/lSQiDBEaKXvjt3xq2mXg3aCVaH/r9tBe8zD/62iY/vFrBJltIpsANSqfplv4G27yfuuoxvfNABIBdNhZLnMnfki8LUoATVRXRNctyxPhMPSLC5upvwLQr5PiVQorZG/ifp7k+3dCkvh7YouHzRh6VpQETKDtPZUcjc+VLSapnvlRiK0fwVj1eHZv09k5oM3vEpXFtkCYQ8jefkuaD5prAzIwIOJhw2ad/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(9746002)(9786002)(83380400001)(2906002)(316002)(2616005)(186003)(8936002)(36756003)(5660300002)(8676002)(38100700002)(4326008)(33656002)(478600001)(86362001)(426003)(1076003)(54906003)(66946007)(53546011)(26005)(66556008)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Gdw6ID7Mub4H6SHD0kGSbS/xa93V6amv/7gY/P6s9Di5UoYevtGAQ0f3+C6x?=
 =?us-ascii?Q?4F4fv8af13BBNtT3BQFoY5D4HU8fTKsl3lhwKMHTq9BTzf0taMzB3gIx0kTE?=
 =?us-ascii?Q?EJbRBRaahQBnB87PwIsF2E4HvmT7x/LOdrLkAiwh7tIrg8J4sbOPSghV+ICY?=
 =?us-ascii?Q?bPQ2+rbO19HdF/7LeapVjsU9MXDhyxPbFPwGHmw2z1jrZ04D4/3J3Gvr6Rqx?=
 =?us-ascii?Q?GIjYMuiz04EKOc5ziBZ6kT/rhFg1n5EWozm6IDTPIZAvGoat1hYcTWfftQEA?=
 =?us-ascii?Q?GZlsDvpo5mPq9oyZ2+SAPuEeMAlBLvsc9vVQqzcMoDTDV8Jord2NOiDAJn5X?=
 =?us-ascii?Q?U8spzoBYW0HPluPpjsdkZ0KFwlahPqUZsMCWOBnuv3wIZTSQLIh+sOGsgME+?=
 =?us-ascii?Q?x+e0ZnI6WL04cPwQ47FMhCV0zsd+pjJ3QddUE99+VbaiZHKPa0dVKm/OYjXA?=
 =?us-ascii?Q?JsbWxzf92u4kThT2kZ6SjEbY7ktXhY4hIaKCys4HSSCHNqNhaT0rnCDyZMpi?=
 =?us-ascii?Q?bQlLurQUhgWsB7lakl0YcEdwKVtOf9GfhCrh3qxuDqOvmcwoP2q+iR5RIy/S?=
 =?us-ascii?Q?BdgWUEKjkxtaTzOoR+EGBoJOve5jRn37mluS02w42tMcRoPo6wmogjXdOdLr?=
 =?us-ascii?Q?GkbcC7rLEyEEScGAOTwWYPP/ztxMJZhwsLR31We7rPESJt7MB0NBNY9OLetX?=
 =?us-ascii?Q?Bh+zO186H8sammaOpfpAVctC6Dad6zoem5QpdW6UOjmaaKKkcdyMdT9Du7J4?=
 =?us-ascii?Q?VMTnbd9ZhpTqAau8ockDNJSERIrsv+G13CuZ+7p/7o+T1QtR7SqeXjLhpPgJ?=
 =?us-ascii?Q?wIG8FfAgoqOUi2GRYobCkf4bzyHPYIfHbGMWDu40OfFSHqHSYTEJsJj4TI4i?=
 =?us-ascii?Q?RjVv0Hyiz//hJzvCarszyxmHK3gSx3NZCefMbUjFAdVwM77oKPNqYoqACrt3?=
 =?us-ascii?Q?o+akvsBWIjwZewVhIQgNS+MznbValLmUj6IUn0TMwHKTdauGX7GP+4D3y14i?=
 =?us-ascii?Q?LwV/gvWXMcS3179E7Il8rleVxThs+D0TCAlq7QGXFx9VqOgeHpF0GOKHjn7k?=
 =?us-ascii?Q?dzFmGcLUhUzLtF/JyGOppVHqt15NrNkIgjYspHh2tjiVXsZUf2/Q98voY4Ys?=
 =?us-ascii?Q?AU8MVBKu66+36+xqp6Y8MpQfMiFPb9xPEZRhFfF7CPM/hSSJSIrPe9naeH+i?=
 =?us-ascii?Q?+FUmtsqFBzKT3JCi0aYRc0eJAY4AG21oUZZWZNFAUTz/Fs2+kV6RrBFcSOx9?=
 =?us-ascii?Q?Z+CINOIIFm+LRuj8iTFHvJiEtbooXbzGOH4POvA9VtBITYuhdmhCO2Fcv5WQ?=
 =?us-ascii?Q?8ZsqLhS2HEaN12s2+gx9uFwC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d97eb01-27ff-4366-d3f5-08d91f884bfa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 14:20:50.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFneKPJ7oJTkg8L8gb57HQ6l05pCeNnr/cLCe/UN6BrqcBwyMXBQNqlRye6EualN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 10:10:47AM -0400, Dennis Dalessandro wrote:
> On 5/25/21 9:13 AM, Jason Gunthorpe wrote:
> > On Thu, May 20, 2021 at 06:02:09PM -0400, Dennis Dalessandro wrote:
> > 
> > > > I don't want to encourage other drivers to do the same thing.
> > > 
> > > I would imagine they would get the same push back we are getting here. I
> > > don't think this would encourage anyone honestly.
> > 
> > Then we are back to making infrastructure that is only useful for one,
> > arguably wrong, driver.
> 
> That's just it, you argue that it's wrong. We don't agree that it's wrong.
> In fact you said previously:

You haven't presented a single shred of anything to substantiate this
disagreement beyoned "we have ancient benchmarks we can't reproduce"

Not even a hand wavey logical argument why it could matter.

> "
> The *only* reason to override the node behavior in the kernel is if
> the kernel knows with high certainty that allocations are only going
> to be touched by certain CPUs, such as because it knows that the
> allocation is substantially for use in a CPU pinned irq/workqeueue or
> accessed via DMA from a node affine DMA device.
> "
> 
> Well, that's pretty much why we are doing this.

Huh?I don't see DMA from the qp struct and as I said any MSI affinity
should be driven by the comp_vector, so no, I don't think that is what
HFI is doing at all.

> We are already mid 5.13 cycle. So the earliest this could be queued up to go
> in is 5.14. Can this wait one more cycle? If we can't get it tested/proven
> to make a difference mid 5.14, we will drop the objection and Leon's patch
> can go ahead in for 5.15. Fair compromise?

Fine, but the main question is if you can use normal memory policy
settings, not this.

Jason
