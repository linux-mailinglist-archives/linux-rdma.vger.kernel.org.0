Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE8811899D2
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 11:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgCRKq2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 06:46:28 -0400
Received: from mail-am6eur05on2041.outbound.protection.outlook.com ([40.107.22.41]:6177
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727168AbgCRKq2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 06:46:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYtilIU/R2Uht+JZQD4DU9lbiuZG5+2iUEMY3OSu2ozvn6wwchqYiwJLWCe9Gg5VDlIT49gxl3j4Jza5ZFsBDPZcvYTe5dg6QP89zKzukPB/inALdfgTCGnU1EI/eLEbUOvzOQtXjJN3YCVnr0CXBt15vHB5NfgxKOmFA1JSWEGYELDubvi5Y9VozpW8dHgStS74EGx2JmrXiqlgSSM3R6G1dWyLeuCDn46gwGzj/K36sM2wflqdTZYdMXmQoi1xqpYgEYedgLvGf1/zw8lSC2OzITJlrSja15pzEbjsUQdi2iPsDMi+p0Iuh00iJp0PwQ5EjWy/ovLaPjuySYkGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19kzu/EqAeelovX57DiszVqKVIRy+1cD/q7YR3KFKGM=;
 b=SrRLBg28acFGf8kRCdjbsZVmEg1F9+vlAN/5fgI/4imq7aieb+Zs5B6/wlULUiiuJ46eECu4fYTgzIcuFNKhBx0orgnWYNBdIHHWV7Ie36+81jRbVqLwAzPS7dcew5/9UHD3Yfw3kNHLtLDAPAjsVsKuAf4twLkDGCAjI8GfOi+Dgioy0WZF+5n5raXSgUbDwIGKIx4Jwrk1LD+xQ4bcvtg1VqVIk44gbpc4HqqgpFMrMJjqs9vfvQjl3AwHGCJUJgXm+u09NMfU0LNP4QHTuVfxnk/ZsuGiXq3R2v4m7XRmAKNV00cKB8q7GajueaTDc7kZEN7sWOZuNdJNaNIa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19kzu/EqAeelovX57DiszVqKVIRy+1cD/q7YR3KFKGM=;
 b=JHnsynTqdjEFD0VEqJdktT6+6mX4AKcAjZ8rzIl6xLQ/9+TqLKIJeV1n7WW5AZr4oL4DTU4opRt3ojxbzfKrBVGAUQIXgN6/iprK1NV8Y0OZOPZEib6tAcTP8/D6RMkTytatZfdzJsigQ2959PV8eG6wD2EEaOsQv4aunEXzkFs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB4423.eurprd05.prod.outlook.com (52.135.168.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18; Wed, 18 Mar 2020 10:46:21 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 10:46:21 +0000
Date:   Wed, 18 Mar 2020 12:46:18 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com
Subject: Re: [PATCH 1/5] IB/core: add a simple SRQ set per PD
Message-ID: <20200318104618.GU3351@unreal>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-2-maxg@mellanox.com>
 <20200317135518.GG3351@unreal>
 <46bb23ed-2941-2eaa-511a-3d0f3b09a9ed@mellanox.com>
 <20200318064724.GP3351@unreal>
 <ec3ff6af-dd68-d049-5ff3-0c01320117e7@mellanox.com>
 <20200318102942.GT3351@unreal>
 <32f23851-6f89-18ef-236f-1416c49b079c@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32f23851-6f89-18ef-236f-1416c49b079c@mellanox.com>
X-ClientProxiedBy: AM0PR01CA0144.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::49) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::393) by AM0PR01CA0144.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Wed, 18 Mar 2020 10:46:20 +0000
X-Originating-IP: [2a00:a040:183:2d::393]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98777e17-98f1-478b-5789-08d7cb2998aa
X-MS-TrafficTypeDiagnostic: AM6PR05MB4423:|AM6PR05MB4423:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB4423189332579FC44E9A9397B0F70@AM6PR05MB4423.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:483;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(199004)(4326008)(107886003)(5660300002)(6862004)(66946007)(66476007)(66556008)(33716001)(2906002)(6486002)(9686003)(52116002)(6496006)(8936002)(53546011)(81166006)(8676002)(81156014)(1076003)(316002)(6636002)(478600001)(186003)(33656002)(86362001)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4423;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+btQs67XENK4UcALEA8NSZIKGTtVW8VT7B3gTlyT8dutYGtVI40emQa9VddIah8up9krZMsWDWM2x6uuoFTMQ8WZqqTfAHryjlhdBtj3plQFFxcHhgQJUjr6kbMz9gsoucTnsi+nmlzQgsX4rn1FiPB/jz4Hc3ZUVcVoL6FLIw4xY3ZzZvmuIuRs/YaHV2qHpZuZ42s7EN2vp5DzkI53RKr+LYWxB7sWDpVfrfybq7pE5jopQM/SuteO+W3wGKKMUv3UAm3mGvCDoLL7Cr9wfOF2BjkUqQz+FY8naLWopEhJd75YZOCGnOe7xLjCXvJKHiCJMumclthOK5SURTm1PvGjevDE699nmLZiQgs6Zl5Om80cDjvlK03HaaHs7wD5VbixqdxHwqPCeN2V9gtEoTlhaApHqCnzqHkh9wm2zMYhiHjQQ8ukVhMJgM83xJR
X-MS-Exchange-AntiSpam-MessageData: p6l7ibl3ayfUhyDxqvdhK7scgOCN9evFX1yDkUvCG477ffVjnqcTRUy0VJf0T6HE9yagI+2SgScxsiXzV/VGfWZMiCoki8e2yph0oHUuEX1vFKBZUFjPjRwnVb4NXfglo9dhHyWjqi5oTkTyDtGeBs1TB0/Q+tp3cBaPv9J/Nu4=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98777e17-98f1-478b-5789-08d7cb2998aa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 10:46:21.3161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFvupzfi3G/WUPD5/98pjt4tEe0qrkkQMKOzLK9EtPQaYngYMgWaNxjyK9bQ2uWgHkhXfBrts2WVQ5vM5T0QCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4423
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 18, 2020 at 12:39:44PM +0200, Max Gurtovoy wrote:
>
> On 3/18/2020 12:29 PM, Leon Romanovsky wrote:
> > On Wed, Mar 18, 2020 at 11:46:19AM +0200, Max Gurtovoy wrote:
> > > On 3/18/2020 8:47 AM, Leon Romanovsky wrote:
> > > > On Tue, Mar 17, 2020 at 06:37:57PM +0200, Max Gurtovoy wrote:
> > > > > On 3/17/2020 3:55 PM, Leon Romanovsky wrote:
> > > > > > On Tue, Mar 17, 2020 at 03:40:26PM +0200, Max Gurtovoy wrote:
> > > > > > > ULP's can use this API to create/destroy SRQ's with the same
> > > > > > > characteristics for implementing a logic that aimed to save resources
> > > > > > > without significant performance penalty (e.g. create SRQ per completion
> > > > > > > vector and use shared receive buffers for multiple controllers of the
> > > > > > > ULP).
> > > > > > >
> > > > > > > Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> > > > > > > ---
> > > > > > >     drivers/infiniband/core/Makefile  |  2 +-
> > > > > > >     drivers/infiniband/core/srq_set.c | 78 +++++++++++++++++++++++++++++++++++++++
> > > > > > >     drivers/infiniband/core/verbs.c   |  4 ++
> > > > > > >     include/rdma/ib_verbs.h           |  5 +++
> > > > > > >     include/rdma/srq_set.h            | 18 +++++++++
> > > > > > >     5 files changed, 106 insertions(+), 1 deletion(-)
> > > > > > >     create mode 100644 drivers/infiniband/core/srq_set.c
> > > > > > >     create mode 100644 include/rdma/srq_set.h
> > > > > > >
> > > > > > > diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
> > > > > > > index d1b14887..1d3eaec 100644
> > > > > > > --- a/drivers/infiniband/core/Makefile
> > > > > > > +++ b/drivers/infiniband/core/Makefile
> > > > > > > @@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
> > > > > > >     				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
> > > > > > >     				multicast.o mad.o smi.o agent.o mad_rmpp.o \
> > > > > > >     				nldev.o restrack.o counters.o ib_core_uverbs.o \
> > > > > > > -				trace.o
> > > > > > > +				trace.o srq_set.o
> > > > > > Why did you call it "srq_set.c" and not "srq.c"?
> > > > > because it's not a SRQ API but SRQ-set API.
> > > > I would say that it is SRQ-pool and not SRQ-set API.
> > > If you have some other idea for an API, please share with us.
> > >
> > > I've created this API in core layer to make the life of the ULPs easier and
> > > we can see that it's very easy to add this feature to ULPs and get a big
> > > benefit of it.
> > No one here said against the feature, but tried to understand the
> > rationale behind name *_set and why you decided to use "set" term
> > and not "pool", like was done for MR pool.
>
> Ok. But srq_pool was the name I used 2 years ago and you didn't like this
> back then.

I don't like it today too, but don't have better name to suggest.

Thanks
