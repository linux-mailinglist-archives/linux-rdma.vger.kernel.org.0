Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F39386D92
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 01:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbhEQXMG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 19:12:06 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:33120
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234781AbhEQXMF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 19:12:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfH+CmRXmQafhm6y7xGwJ0jMsFfq5CCMMzo7QYwO6tuz/nlB59UdPD/oY1izYc4/jI3HyFHVfJF9rPuhUpNyKgP5IcMuDr45/5GL/5kWAonD+gFPxLBMhYl3p77zOTwk0hWLQblriA7ozk7XrNQRfXhC/kflPSPJsCukTzgkpnbxUdBi5TqZdkKZXfX1rci0p0CFVETUs9E2eiBVHoQu7GiEjq7JZO89FQPPmQ87dgSb0WELQBl8tPCsWKcAP1M81fb2kYH0F+ZJYUoRr9z2PzX7QJGR9OkdKGjLxTcKcbktYIUipBWN1aCU6iHBrYnY/sxqk89pdMBYs8fSzVizSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/PUuftrNY00JYgj5Kplxqd8id19pj36XIrKaGkizVA=;
 b=OdDe6MPnUbJyXdVnhhPG8mahkBe76iFJ07iD8UgFx3FLoToT2+EZN9+ebkbL7USaJViFl89skSm0NLqeBkJ2pAUDFvmB4vhfWnSxRg/5bLbA6VP95EUn8xuEMdq0KjtbqFUtI9EpWU7uaU5Kqax2a6/ewiQCtuAA+Fy614RqjO4pb5nfOafnXoZFTrS8DoeRwCIiSkEbpGalIKRG3Njof5RWfTWqFJVYjJgVBELSxkqkoPHcSgNt1MppOCR/NCchAfiN6zw6T7QQtkx5PqQvGu0l1p1dYjYhXAX2zQuIWB5kZ901C/avumv+k1VV4+jQ4qXZEblUAdj7bdmKKl5pzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/PUuftrNY00JYgj5Kplxqd8id19pj36XIrKaGkizVA=;
 b=tzaV21vto5iFah79xa7RjGxprE4s1eTw5ADuopMR7F8DzAc7CSVV2PgRhmzboTciMT7OI5zeooV3tEPqa6G8NnhNnx7qdNguYk/0WbVUoUWvLpD5nXWoxz3/ekTn9Ka6sHsc4YzWdaBYDXgUHd2E2rMGTJQP5DHc2wA8w1954gGUhtHn24rTc2KaXWDIjKczdqTbD/THYeVMDsTaaNFw8kuJ5JY7zoGylWhsGB4T9z9mZu4lPzqaaDhKFP+WXaWPG5y8oiChJzSKv9LLzFfJJvN6uduV1HKaeAUDOUuM1dkpNlyYyDgyMkEufKKDEX8/HfBbmrzxwhmsdko/oPKpuQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 23:10:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 23:10:47 +0000
Date:   Mon, 17 May 2021 20:10:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
 device variants
Message-ID: <20210517231045.GV1002214@nvidia.com>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <b6045737954e4279939669a1f229c835@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6045737954e4279939669a1f229c835@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:208:23d::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR06CA0020.namprd06.prod.outlook.com (2603:10b6:208:23d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26 via Frontend Transport; Mon, 17 May 2021 23:10:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1limNp-009tqj-LW; Mon, 17 May 2021 20:10:45 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e5ade05-b04b-4751-4ab7-08d9198900f6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0106F8F8C7DAFDDA089453B3C22D9@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayA6MUM8JrNU7pFLWdy4QqrLnOsEPpASzTL7BLPFjJEd3PnTwVXo/G8EsszLQ5USMoJdNW1ZTCEWtXsBPbFIqRHNeoXUxRBAfmD2sZNuNreGctrY/D0ZZPoRhoZ7gQZ4IxGyU4X19ZX+3Cfn0JM+oZ9yRpbng7G5RSRi77Gz0uhX0tKAj+BGwKMgU08/foDJtqrd/mEXIW37CAiCMAZMl4mwJB6H71xqoLreD6HvB5yfMqJGYl8mlxa4f4sxAzEK0WXeWQ2/IGRqAC0CgOpYB+oa3kEFScHQQy62giDSGDaoeaBo0t4P9ml9alPHFGtTFagFu/kf2777ZEPYnQc1xKRqG7p6GMf3KkCiaTmp9bhHfDExVNpsn7FoW1KzItViCLjl9UcTAarCP8MOqzKwqv8yThfeCjebJQmRNj/2Dhg+Z70fWPEFfxlueHy2STQzJug1s+h/ispir0qyoTAA1AkOFujFxno4JZ2W4fAs+BFQMtwLCrXQFlvooq3c2DG4DpaKTHClF1SVFZNQPtEVnLSuMTDJZ58yNcn6dA6raJnHhUIKsCHHanjkih9TwGCuL3qEdDCZ7y3MybMM4+GDkuvZrU43xv9sumrbexbQMfQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(66946007)(66556008)(83380400001)(4326008)(316002)(426003)(2616005)(38100700002)(26005)(8676002)(9746002)(6916009)(54906003)(1076003)(2906002)(478600001)(8936002)(186003)(7416002)(5660300002)(33656002)(66476007)(36756003)(9786002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4hE0E8TYC/NkY66e1iiV6EpIx8icKLOmNFYmGcqlG1OdBHAi167qA90YRbi1?=
 =?us-ascii?Q?61lf4et641tZUpm5YK9nW5L9LXWf4t6mMhsiFjjg+mh56b1l4u+YeXkXf6sO?=
 =?us-ascii?Q?obXZ3jzhO0w0Mk3fY1Y0xN+mY7TzJ9eNt2C4vgh/KIB1FKA2K89R3UGi7iG0?=
 =?us-ascii?Q?5bImnwcvuXQmP1wEbeZVt/RPm1Nss0J/f/gwAg3DQX+rRX7qTk+qOUttI9qN?=
 =?us-ascii?Q?FKZwLEFcTjlbKtOI8YFvyTIgTGR2lmbQzByCGw5hcWBnOp43vCzbc1OPn9cA?=
 =?us-ascii?Q?+CeI0xpdKovxi5oZcs7pLa9n0PMbvA2tfjN8JMekjOrHy+SOK8pkO5DDCOuQ?=
 =?us-ascii?Q?3OvNY5+JpxlMfflUNsLwsVjTGocPPaLx2KHGLL1DlrVELsnN7TGLi6QGgTP6?=
 =?us-ascii?Q?ekJs64rGsproCYEUAUT+IOM+YdsjdRpJp0rO7ILdUz9jgMXajUlJmQQtbzyd?=
 =?us-ascii?Q?O4YgvXmDIVLzwSsqyct39UjGk4opik6GP39fUN6x3fU/V9AnFFBUc9qFVqu/?=
 =?us-ascii?Q?BOFdZPDMQgJAb+6wicEfDVf+QVhruDMFp5DcAPmI4V9pyVQruiZQR1JlzwrG?=
 =?us-ascii?Q?nnQuEKfWdtTlRLEuNoUOseMzCG5fGCMQS4ayNe63odIUBMUoxCohwenGp25s?=
 =?us-ascii?Q?YtmWYoBy50iSO4P2fyLwYEgieIXVdJngm1SBkTmm0jDfJHqsauYzIQmdix/f?=
 =?us-ascii?Q?yDZJK74td9Nbh/MOhaoIHtyjSouQim/kV7SMDSH0/FHhwP2NRfz80C3ESKtj?=
 =?us-ascii?Q?e4LE2VpXc8bwGsZRic2W1QO6QP4pY3gmRchBhgx5Osx+jXYNDqlVLGkdiPq5?=
 =?us-ascii?Q?nPqPBbLdxFfUHDamjozrBhs3UR5/QOefZJQDGkmpBg2dn1WrXw6IG7tpJ8XH?=
 =?us-ascii?Q?9qnShVuYMqow/dP69isMSNUFYcRWddRGnVMeDtMkxwFUg/ccZ+4rrvR/S+L7?=
 =?us-ascii?Q?IRmaO4CBLHfwreNmTEar61ycj9ziWzw3YzL2Tw/mmajdCZ3wFoEbdWTdiiX0?=
 =?us-ascii?Q?ckcSbhHkzYIszvyPSu/pFWL3Kv5AQVbSwICxphQKS1ZEEMusoSuHEUe+nKuu?=
 =?us-ascii?Q?D4LPNr1vgYsDEbZzPiWDrexh9qo4LMw7PdaxW+JRHQzKcS/ZNhf94ssjh6NT?=
 =?us-ascii?Q?kgq1vObzfAH2aCSeEgu+yle0mZaECr8XSBPEhyoJBcWE9iM+DcLlPdppbjj2?=
 =?us-ascii?Q?uCnVbU7lMRwF896L4qnLKcP+EfElI6qoL3DRG3ms20zMyhtfN1mWhOxRU7VW?=
 =?us-ascii?Q?wl5VRlhWsQhHFgSdnabHH6DptSc/r3Ael4lUL953Esu7QdQ3n00648oi2FGC?=
 =?us-ascii?Q?VcCoEOxNuCj4FmqDfS033YnC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5ade05-b04b-4751-4ab7-08d9198900f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 23:10:46.9279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tVrqtilqFVLPqtRj1eYjmh0xQ8h1GFTvjlkQO8dRlVMHsJozyxwdaLLhmQJE1lp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 17, 2021 at 11:06:29PM +0000, Saleem, Shiraz wrote:
> > Subject: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and device
> > variants
> > 
> > This is being used to implement both the port and device global stats, which is
> > causing some confusion in the drivers. For instance EFA and i40iw both seem to
> > be misusing the device stats.
> > 
> > Split it into two ops so drivers that don't support one or the other can leave the op
> > NULL'd, making the calling code a little simpler to understand.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >  drivers/infiniband/core/counters.c          |  4 +-
> >  drivers/infiniband/core/device.c            |  3 +-
> >  drivers/infiniband/core/nldev.c             |  2 +-
> >  drivers/infiniband/core/sysfs.c             | 15 +++-
> >  drivers/infiniband/hw/bnxt_re/hw_counters.c |  7 +-
> > drivers/infiniband/hw/bnxt_re/hw_counters.h |  4 +-
> >  drivers/infiniband/hw/bnxt_re/main.c        |  2 +-
> >  drivers/infiniband/hw/cxgb4/provider.c      |  9 +--
> >  drivers/infiniband/hw/efa/efa.h             |  3 +-
> >  drivers/infiniband/hw/efa/efa_main.c        |  3 +-
> >  drivers/infiniband/hw/efa/efa_verbs.c       | 11 ++-
> >  drivers/infiniband/hw/hfi1/verbs.c          | 86 ++++++++++-----------
> >  drivers/infiniband/hw/i40iw/i40iw_verbs.c   | 19 ++++-
> >  drivers/infiniband/hw/mlx4/main.c           | 25 ++++--
> >  drivers/infiniband/hw/mlx5/counters.c       | 42 +++++++---
> >  drivers/infiniband/sw/rxe/rxe_hw_counters.c |  7 +-
> > drivers/infiniband/sw/rxe/rxe_hw_counters.h |  4 +-
> >  drivers/infiniband/sw/rxe/rxe_verbs.c       |  2 +-
> >  include/rdma/ib_verbs.h                     | 13 ++--
> >  19 files changed, 158 insertions(+), 103 deletions(-)
> > 
> 
> [...]
> 
> >  /**
> > - * i40iw_alloc_hw_stats - Allocate a hw stats structure
> > + * i40iw_alloc_hw_port_stats - Allocate a hw stats structure
> >   * @ibdev: device pointer from stack
> >   * @port_num: port number
> >   */
> > -static struct rdma_hw_stats *i40iw_alloc_hw_stats(struct ib_device *ibdev,
> > -						  u32 port_num)
> > +static struct rdma_hw_stats *i40iw_alloc_hw_port_stats(struct ib_device *ibdev,
> > +						       u32 port_num)
> >  {
> >  	struct i40iw_device *iwdev = to_iwdev(ibdev);
> >  	struct i40iw_sc_dev *dev = &iwdev->sc_dev; @@ -2468,6 +2468,16 @@
> > static struct rdma_hw_stats *i40iw_alloc_hw_stats(struct ib_device *ibdev,
> >  					  lifespan);
> >  }
> > 
> > +static struct rdma_hw_stats *
> > +i40iw_alloc_hw_device_stats(struct ib_device *ibdev) {
> > +	/*
> > +	 * It is probably a bug that i40iw reports its port stats as device
> > +	 * stats
> > +	 */
> 
> The number of physical ports per ib device is 1.

Does something skip the port stats in this case? I don't see anything
like that?

What does the sysfs look like? Aren't there duplicated HW stats?

Jason
