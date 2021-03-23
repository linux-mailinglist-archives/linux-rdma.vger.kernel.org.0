Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCEF346D9E
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 23:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhCWW4w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 18:56:52 -0400
Received: from mail-eopbgr750040.outbound.protection.outlook.com ([40.107.75.40]:33177
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233896AbhCWW4n (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Mar 2021 18:56:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZaL4xPyOeqOy2PmK1z8qiY1EHANwT8QOl6DK9KykMmpIuE7El6R6r0WmUl0qygZUkM4z1kf6SI627t9fMmFmKJ+LrCkw60TLQ8dL0vKl7annCRjyqMkkcQ4WuKO3hTVYx86tgFca3DASb9XAklRxxxqEiU9aDwW2igFb1xZE1Q/vKXrtFvE3Cb9n2d+DixA6tttrG+jrLBplqGQmbPxf4+wM2WDdABeliY0RTHElzAsgg52P0E+zwssshKTJfbZSk58NoKaGOk0/+SunJsYzzEpepSkyk0BNyLDpOeONVX0UDUMSU8L3F+nJrQOPZAJZFKjFi4E+f63yVC5cntcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maOZSk9YeN9QWjXSJyk2sh1K8hdl+fkH4eP9HwYBVWM=;
 b=F+eRwI5L9oEK8SbS3vTxzA/jh9w1T7gJHKypK1xydBROVUeOSvE43sINTDVtw4Ff4j76yOMSpp4KW8uOy9e4NZo7iXv3ngSfxReggqIP+69HZwGEjDoZZCfoOrCs6G2QPnxGcSOmxoAwKUUN5vsxX1GtSD1KF61plVj46O+rN5hotpSkrAk//JZ4KRJoIZB8r9YAoTvNujI776u5HoVNjK6LMXS5AsHYJf+EeRjavFHNz6OsKnscv+mpQPDcAAzUsoS11jH9LoqYNrQfbbNOFTGHJwhNTmTpGQMWc+QCpunp8IUwYZUn19X6JUSyxSwnCBOZ5aTQxgZX1+7IMOUMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maOZSk9YeN9QWjXSJyk2sh1K8hdl+fkH4eP9HwYBVWM=;
 b=OTwehxLXvVIT4BM4DwuW4NbVDoF99bNR12pXpgGvEj2tRPoMJO8wbu4hkWGlHCaI32qZoFIKGPkT5pOG3JH6x0Sd0vzUhqDcMQT59cyQ5nWy72tUvCq9VhA1o851pEQMJegJHs4yv7Y18Q7lbJoXUrGCVTQYGGrPBSE72Hu+KlkAUpKGMKmDdvbltydYDAIN5soc1jgYzYsvJuaSJlutiaP6//a8Qx/oDLinISct/CCaiKVmso2UiRGZAebEWDUhbhM3OQ4XGxseWhnzNNhql2pKJyBPXekZGtXW12E+tISPdV8DG8PMN4NiCwel+xkJJgwGB/ylPdmFCOL/A24bLA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 22:56:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 22:56:41 +0000
Date:   Tue, 23 Mar 2021 19:56:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Hefty, Sean" <sean.hefty@intel.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210323225638.GP2356281@nvidia.com>
References: <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <be96ccbb-17b7-27e3-a4f2-5b2cc4184ecc@cornelisnetworks.com>
 <YFcKTjU9JSMBrv0x@unreal>
 <bc56284b-f517-2770-16ec-b98d95caea6f@cornelisnetworks.com>
 <20210321164504.GS2356281@nvidia.com>
 <1aaf8fd0-66c5-b804-26dc-c30a427564fa@cornelisnetworks.com>
 <20210321180850.GT2356281@nvidia.com>
 <DM6PR11MB4609382524AE6EA1EAFB15B29E659@DM6PR11MB4609.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4609382524AE6EA1EAFB15B29E659@DM6PR11MB4609.namprd11.prod.outlook.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: BL1PR13CA0394.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BL1PR13CA0394.namprd13.prod.outlook.com (2603:10b6:208:2c2::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Tue, 23 Mar 2021 22:56:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOpx0-001jBB-Dd; Tue, 23 Mar 2021 19:56:38 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12e2c791-d56d-46ed-cbb6-08d8ee4eec0d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2582:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2582219CE159A12AAC40614BC2649@DM5PR12MB2582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pP2I9+kErPR0rjShE8Pqhpm+LU5Fb4exYvZqhY0ScGxkNYq9r0Kh0lXnVWM0HDQN2rkMoZEaa9zUBYoLH2JKlJ9NHh2PKELRffOXMe+YlABXAKB5io3KpyBxJGg4r/7/AWKL9MJvLcnh5+P6kHPVDy1GP8Ge2bP5geTWHDYOlrMyMQ2fIKWvCogM6uzAQF1peHO3HLxMo2sTvKqmUsyd0CwBN3CukzrDjkxfgd1YOgtCn5yF1xh0HlnrslRevemPfoqjwrSBG1yAjp9vYfg4RiBg7Bb1KrNZ0orn7xCwdao49Znu42IoQHEor55GSb/0oIiorJ0iZ6wXta/0q60dzYlNhh7a0Tn5DcT2rkpnppocW4fnqn9OWFcdhxg9xAnbRFSoyhlOMAoJ+FY4GOC0zd36/zoCXSpfrDJTS73HWbPETehrR4blw+No+XEoB3dR762F4lIWx5VMfBG0cGaf5Yb+DH+JYh/DcJPCYMl0ItnEcx5p9YYqhwtdFHk9Bv+4+wZCK5PgSi3B1jnR+BAH0fV7B8yVOFG1BP/dkM7+tQnjHGvLFI1CfcG1OAKbZb22vorRa124MBWqve+eG7T1kgq6J4P1LfNAheA3/KG+vLU8z0qom+RYdWiEhBVuuCZvQWC+YQlIOTCOzvS/WVkgM7PdaAjdKaSZKrQzpQYkCQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(2906002)(426003)(6916009)(86362001)(8676002)(38100700001)(8936002)(2616005)(33656002)(316002)(36756003)(478600001)(54906003)(9746002)(83380400001)(186003)(66946007)(5660300002)(66556008)(26005)(9786002)(1076003)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2wyW2IIfXVrHWWmrFz+vg4J30vESyEeWcmtc0uifJEfVHizRdBtMPqma14sD?=
 =?us-ascii?Q?lNHAZjGLo9Pckjc4APMWo1sEn0N8xnfqpSoec2cCAEljGmJg0LbWfrBLkNfy?=
 =?us-ascii?Q?bHJ5MLcQ0wmtxFggij/BnVhjfC/7fWf5PFZ4ltdHAJnm6084yP4jd6wJnMhK?=
 =?us-ascii?Q?N6ABulnW6tJyGfK/ksqcfoYu1yR9Z8KzH+Dd03nmi/aociPGGp1rQWaH8LYz?=
 =?us-ascii?Q?8fqOphH447kULUIoM8CVURtknatqbXe5f33jYFzIp04P0edG0kijjcDjVnlF?=
 =?us-ascii?Q?RbjnOyMyp8lP/xBp6KGbzX5w/CbxYF7SnQfUApLTBtxBGf6yA5IuveAqMWfS?=
 =?us-ascii?Q?L/kBybBO5UBuvvRsnpvJYHxW29s627Tg549WqzZYLlmmF+viMgU/gnlnXWQe?=
 =?us-ascii?Q?8k8SqUJ6JQJTQ8KNlW5SGumJgqAz3d+jjsmVWvymLcKuUM3kmufjIRwwYT4M?=
 =?us-ascii?Q?YqghtHKH11n6WKSsM45r+D9mUpzl9YPW5VRNAtQ5UWsB+MTRDVx9UXnE99jh?=
 =?us-ascii?Q?8ASLPX9iUWh0E1ijJ93CQOkXqWSuJ9TOszrSgti/mE6jWb96NIYUvUKqxmYO?=
 =?us-ascii?Q?1WMmpoTIpXE9IwBs6Bx6RYAfSKfTVkql2xeWhM+Ia8OvGRTVFBDVTE86EYyK?=
 =?us-ascii?Q?9t+9rMRVOk34Q7fdLramrcTaQy1tsxXbhuasG7rVtqMp0o4cptFYiI2kSTD3?=
 =?us-ascii?Q?0kKRuqDQxVep9744H9N+Ngm8r6T5SupoK/5n9dhxOL0dm8KNEV6CXNGjeKCX?=
 =?us-ascii?Q?fpJDUt8+tYSp2WUzOMQg8Wid5JbxQzONHm2mrV2m2LbQ/z1N6pJE1OlnmA7v?=
 =?us-ascii?Q?yekSdiodXa9G4dT/1xGYj/bXUe+6mJ49NfeuwJfp2HLiTlY8fei47OD9lk3N?=
 =?us-ascii?Q?PSKdZBu7JejKbBfM3cYXlXhrbDmek4L72/GBKs43Sg+2BBmmR6cDGaco9hCE?=
 =?us-ascii?Q?CT6JGSDRBKdv0sE2tdnSV6PQEKbpjpy8tN6L0eM9HOj+XXDoYPSin+56OHbT?=
 =?us-ascii?Q?Uyy8mAwNtR6Pk1Tn/0zyqSAnGI+YOV9A802SywHbYC5KihkZZvb0VuEVrxLI?=
 =?us-ascii?Q?yOoQk98RgO8WFkmi8qpqdyOkZFI1EDGTTzDYcuueEvW9gLgVNC0kdIBMJj7q?=
 =?us-ascii?Q?EOnDnurLKI5nxdWViG/LVqJD4pwk8fJfsRjF8c2eqqp5Yf4i1BTf3MVM/iek?=
 =?us-ascii?Q?SiaVUcQ93+IGdSFrBwFJo0pP9o1eA6mhO8SIyABM904OhD0MF6w9iNCCaPFc?=
 =?us-ascii?Q?ywdnHZIavyR+8UKz6y+sWQ4Z6KFVgW+B8sCBLAGAKcDF1g4iE68Te/bGV+Mt?=
 =?us-ascii?Q?/I1zaZ8ouLRxcVuIuO8LXKkq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e2c791-d56d-46ed-cbb6-08d8ee4eec0d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 22:56:41.1110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aflyHnBQRu4QOa1t8QrtZwjxL348Rg5qr1BtPbhxLXHFVyPPz7FFqwVnw90D6jzl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 05:31:07PM +0000, Hefty, Sean wrote:
> > > To be fair it is sent as RFC. So to me that says they know it's a ways off
> > > from being ready to be included and are starting the process early.
> > 
> > I'm not sure why it is RFC. It sounds like it is much more than this
> > if someone has already made a version with links to the NVIDIA GPU
> > driver and has reached a point where they care about ABI stablility?
> 
> I can take some blame here.  A couple of us were asked to look at
> this module.  Because the functionality is intended to be device
> agnostic, we assumed there would be more scrutiny, and we weren't
> sure how acceptable some aspects would be (e.g. mr cache, ib cm data
> format).  Rather than debate this internally for months, rework the
> code, and still miss, we asked Kaike to post an RFC to get community
> feedback.  For *upstreaming* purposes it was intended as an RFC to
> gather feedback on the overall approach.  That should have been made
> clearer.

Well, it is hard to even have that kind of conversation when all the
details are wrong. The way this interfaces with uverbs is *just
wrong*, it completely ignores the locking model for how disassociation
works.

Something like this, that is trying to closely integrate with uverbs,
really cannot exist without major surgery to uverbs. If you want to do
something along these lines the uverbs parts cannot be in a ULP.

The mr cache could be moved into some kind of new uverb, that could be
interesting if it is carefully designed.

The actual transport code.. That is going to be really hard. RDS
doesn't integrate with uverbs for a reason, the kernel side owns the
QPs and PDs.

How you create a QP owned by the kernel but linked to a PD owned by
uverbs is going to need very delicate and careful work to be somehow
compatible with our disassociation model.

Are you *sure* this needs to be in the kernel? You can't take a
context switch to a user process and use the shared verbs FD stuff
to create the de-duplicated QPs instead? It is a much simpler design.

Have you thought about an actual *shared verbs QP* ? We have a lot of
other shared objects right now, it is not such a big step. It does
require inter-process locking though - and that is non-trivial.

A shared QP with a kernel owned send/recv to avoid the locking issue
could also be a very interesting solution.

Jason
