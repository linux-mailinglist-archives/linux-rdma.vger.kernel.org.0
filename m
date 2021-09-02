Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D233FEE44
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhIBND5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 09:03:57 -0400
Received: from mail-dm3nam07on2050.outbound.protection.outlook.com ([40.107.95.50]:60362
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234054AbhIBND4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Sep 2021 09:03:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chN0KicyYSRfV1VairJeAgQlYGIkEoZ8Rf/Lmti962B2pA+SP3nca9I53J/DikBbRXVgTArkSnqGuN0Zf5Paeuw24mYH4/vFWId95legNr6I6xc9MRSYmDEsrbmmhwc1Ze8xgyTe1xMRstvk6e2p3d9yGejAJ8NNLv5XG4vz0OG3CVo24KcWCNkousy1L/Nr8KdB+0XshE6KVqydDKJQ132kP59x8XignWOwfirYrJBISDu5+tU9Far9ykn5UXG75crb9yMFVRfJU3b3U5jz15H740aDMzhupjsXIHR8qn7hwhgDW/3AowwmF0ZWA8OxyqMt18xRxCB0bRoR925zkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xH4+HkFoRMYQKv77u+92aE5kJxVFg7i5Z/dZQ/PIQBY=;
 b=jFk7yLJPlNT1uM5XLS98vwDI+bx3xXvLP1x68Jsu5f7LV2B/C+lOk8RWk8KYPQ0QZr6HZQDvA9DPlCewW7GMDsLTGrz3pwAL6Zo3YfEqEfDPcxkbgXgkUReMv+XVQ68ce5m7/cUZH8/gJjoUbpPiG+2TGyUaOUFxJUXG/Otq3eFZPzk6oBgPni2cvMlyllPf+CJNv8MhzKoKKFS0qwImdxYdJNJsAEvaPtUX203Dj0H2g1lcqXiOMa05kehj+hif6OWyJMqUYsy18LCwZsZuipxoH8ndBhfyoCB68jA/8JC5iyqJfRj8f3gDI3Znk6qx85x3qf9qOodjH24/pP3yow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH4+HkFoRMYQKv77u+92aE5kJxVFg7i5Z/dZQ/PIQBY=;
 b=GPMcGbn6ljpKDVxsYG6PqaVtiW0Mn7heoijSk2+WM4cmLXByLzmQcyoDLe60/amNqI2+0A0tQzg4n7848p1rHCen5FSvrtPpJia1OhWD8SByIgCrXfDkoyEYmMP8MBhhYkQqUxI+z9Sn12FxTQEIkwr30rJtJuUAIxVOSh9rrB5DgeS+DX/PaJm9dR+ESby+cZiPvAllYtuviytcwhbjhAByA7qpbjLg+FOC2urr8JN+wOrsNIMLMEtmay/prIE+7k6Zp04DFQ0ZANTVkApHSRD5kDUpVS5gH1s7w++k35vMIfqcnuZN48dv+MpLTQT6ODiWrJRrRBRzANWQzaMacg==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 13:02:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.020; Thu, 2 Sep 2021
 13:02:56 +0000
Date:   Thu, 2 Sep 2021 10:02:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 4/4] RDMA/efa: CQ notifications
Message-ID: <20210902130255.GR1721383@nvidia.com>
References: <20210811151131.39138-1-galpress@amazon.com>
 <20210811151131.39138-5-galpress@amazon.com>
 <20210820182702.GA550455@nvidia.com>
 <7a4963ea-f028-e787-a5ba-fabf907c6d6b@amazon.com>
 <20210901115716.GG1721383@nvidia.com>
 <c8549e51-47a2-1426-b44b-f1c4ade3dce2@amazon.com>
 <20210901153659.GL1721383@nvidia.com>
 <d1b2dc01-5a42-371e-c4b6-2f9b3425f5b6@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b2dc01-5a42-371e-c4b6-2f9b3425f5b6@amazon.com>
X-ClientProxiedBy: MN2PR15CA0057.namprd15.prod.outlook.com
 (2603:10b6:208:237::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR15CA0057.namprd15.prod.outlook.com (2603:10b6:208:237::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Thu, 2 Sep 2021 13:02:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mLmMp-00AJoW-OT; Thu, 02 Sep 2021 10:02:55 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95c84eb4-3637-4030-6a18-08d96e11fbb5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5160871740A6074E1CAC76A1C2CE9@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYHFYaPI/KksleukwF2Z0llNwtbyQpUaC2Az1dI4L+TcN9K60/nc8haGqiNYNMW/JdtrqDWdBSsZcM9f5tmRCdk8hJ/eIUfhNzVh7gJEUl2CulSrWfW15JvCu8Kclj4paiTI3l6nUhz0ilFs4RKlN0B2BdZn7f6KaRLV3FrQ6BY35yiN2LkNRSztk18SuAIxP9IaoG6h2hnLUWWwo2VJ7AeR6qDWLqjlNX52QAEcmPpx/t9a03/dSKDr6W8yRs2U4rrRbgn2ZdSH+WsoBW5oCj5S+NdMqYU7edq9M+LCLbVn8icbC0fKiosw2nkswpDzTrMaiyys6IDGx1yEkGtrQpt8aEUjP73nWCeNf4Z1veSPKOusBDAo2DHHhRMsWtB3HhdW19yz4ZkhbDnWWfItwA1n54QbQi7p5+2ZoFM0v9/S9rYxegXTB4n7pZ0rJe7yajBiborHrqCKl/nfW7mwmyYCuDnEtoAk9FSEkjhZnVDf5XPzUbSfKqf30r8na2gBcuVnXRUFDeDFAH1MR9Z0sRCw5a1wdqD4ZurkjTzUNz5uTyp3+/zKTiQWcx+r2beKStH0EEjoOD5UE7p/MfGwFZf5KFpU+hfAy7WA8af8PnQlj3LRk7lF7TMXU7ZQ9jf8iTP4h/oECHBdTH///TIfzJ2i3oqfSsIq0jqWKav7B06ySiA3k/k81T/K3t+NwiIsmbCpN7mmPEhNNrA2Amo5ONpsH8p2t8hII0WxJIpZDkI4l4Zj8eetG6fxarnKj8vFb+R9y0gyyFrBVwkrH/dvFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(1076003)(9786002)(9746002)(53546011)(66946007)(86362001)(66556008)(66476007)(478600001)(33656002)(6916009)(38100700002)(83380400001)(54906003)(2906002)(966005)(316002)(8676002)(2616005)(426003)(186003)(36756003)(4326008)(26005)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z+Qu6blT0uYCVPHzxNWxFEP9U+SGJGw5N2jg3RCLyg1nFQth77Yc32PFRzah?=
 =?us-ascii?Q?UWIJJ4CQAtGY/0tZTTI/42VmSEaThYR7G/ha6yDRlye12FfQN1PaR3Y6KxG9?=
 =?us-ascii?Q?2rjMVWcTycTEXRYp89/Qtwh9ultbYysF+Wy1ywSSxTt38nTXIwBP+MlZ7gLf?=
 =?us-ascii?Q?BVilZlJpPkwKsfA07l7WuOwluY040GM2s7ghmBIadoBgmVEfaJh0f+D6ybiW?=
 =?us-ascii?Q?gbWtJZLPWuhUT+Ia+Tg32K/quwmFPKbD2JLhAIdFL4mx6Td1R/gXU5aZe1p9?=
 =?us-ascii?Q?uyvLePGBpePRWMY1SHqM7n+jYd9DVogtlkct2QrqxLFbtQfxXySRNQxp3AKm?=
 =?us-ascii?Q?F7nclwp6ORr/TSz4GjIhQtvKtHzRY2RY6XwVcJKC2ZEx3I7I2uJ2j8NpU8o1?=
 =?us-ascii?Q?Erfm9lnxJ4pK+ds9t6YEvAr37vIyjZjn6HLH3olKicCtRUnV263JB7yJv07X?=
 =?us-ascii?Q?o86yC+SmNYj+61/88gaqUr+lB1b+tebp5rSz2ouOcLYWPs+XU+w6Rto/tiM+?=
 =?us-ascii?Q?cyRkLpXvv89MfktPgmbRAzTZude9YFLvh1PzIwwx5e+6PF77E5es4HCkU6VV?=
 =?us-ascii?Q?R5NpIkTQzq+JonsDgYizi7apRkH2xLERA1i2P+7lidB7E8XOmJDmwxoM12n4?=
 =?us-ascii?Q?Cl+hOOsSf4vjHhDcc4HryUQMXR5DNAbA+JttfN5rpGLgjwIesAdbosO42fS0?=
 =?us-ascii?Q?lnKePbC8ZBlIfHbrNA1/ZaXvc9FUcidwrZnC/kS2T622Up4CsTv3rCZNjMAZ?=
 =?us-ascii?Q?lnJ8FP/9jrlINpiGMZ3Lh6REmr4XW8Ibn6uqgDEpj8K2HsFY76el1nys7kAJ?=
 =?us-ascii?Q?ZsRY8eD9Pcq6hV8LSM0LRstZHdO39oXn8EEUlC3P++A/4vt6ziWFYnK4q8Qn?=
 =?us-ascii?Q?X8Qz3j8ZzmTjeFOuce8vKuU19kmlgFgvi0ITsvvo4/d7L4gxgiSJqnBiDoK9?=
 =?us-ascii?Q?rhWgPh4qJ9tJozb4uZKOpWVTGKFrdSFPywh29sOJ2J9aZQyPrK8u5ml/VMBJ?=
 =?us-ascii?Q?IHiJAj5FIjhzZt7ZpBa+I5W+rtESxV/BECHl0VPVy87zpoAL960ditmknhYA?=
 =?us-ascii?Q?5E6iWL80Ha+fOvx4DKrKaV0fpbaAijBB8OmEzLPjBbX1L9jTB/dMw5D9V1DS?=
 =?us-ascii?Q?lSm1kjjZ2Fh2dmLJ/fhrGFX6lvb1bSp7DiSr/z+e5nzOE24yoEDLGEPefTLR?=
 =?us-ascii?Q?hM8IrqmuExcWiMgZBIL7ke1uljI8SDzMkgXOUJXUs9TxAPUv7gPr9Ih7Kenn?=
 =?us-ascii?Q?MnpkOrEMyjBss2yfmpA235zhLw1r2dzrhFd3U7X82r1BCvb8+Ch/j5APlI3q?=
 =?us-ascii?Q?FY3uXrXXRgdBUHN3h/4n16iJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c84eb4-3637-4030-6a18-08d96e11fbb5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 13:02:56.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V77U/s8Yws/KWRMqcM8vdytMxabQpacWSUzdJ4aHRXbvpO4MtCwlVEtRr2eNltJ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 02, 2021 at 10:03:16AM +0300, Gal Pressman wrote:
> On 01/09/2021 18:36, Jason Gunthorpe wrote:
> > On Wed, Sep 01, 2021 at 05:24:43PM +0300, Gal Pressman wrote:
> >> On 01/09/2021 14:57, Jason Gunthorpe wrote:
> >>> On Wed, Sep 01, 2021 at 02:50:42PM +0300, Gal Pressman wrote:
> >>>> On 20/08/2021 21:27, Jason Gunthorpe wrote:
> >>>>> On Wed, Aug 11, 2021 at 06:11:31PM +0300, Gal Pressman wrote:
> >>>>>> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
> >>>>>> index 417dea5f90cf..29db4dec02f0 100644
> >>>>>> +++ b/drivers/infiniband/hw/efa/efa_main.c
> >>>>>> @@ -67,6 +67,46 @@ static void efa_release_bars(struct efa_dev *dev, int bars_mask)
> >>>>>>  	pci_release_selected_regions(pdev, release_bars);
> >>>>>>  }
> >>>>>>  
> >>>>>> +static void efa_process_comp_eqe(struct efa_dev *dev, struct efa_admin_eqe *eqe)
> >>>>>> +{
> >>>>>> +	u16 cqn = eqe->u.comp_event.cqn;
> >>>>>> +	struct efa_cq *cq;
> >>>>>> +
> >>>>>> +	cq = xa_load(&dev->cqs_xa, cqn);
> >>>>>> +	if (unlikely(!cq)) {
> >>>>>
> >>>>> This seems unlikely to be correct, what prevents cq from being
> >>>>> destroyed concurrently?
> >>>>>
> >>>>> A comp_handler cannot be running after cq destroy completes.
> >>>>
> >>>> Sorry for the long turnaround, was OOO.
> >>>>
> >>>> The CQ cannot be destroyed until all completion events are acked.
> >>>> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/man/ibv_get_cq_event.3#L45
> >>>> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/cmd_cq.c#L208
> >>>
> >>> That is something quite different, and in userspace.
> >>>
> >>> What in the kernel prevents tha xa_load and the xa_erase from racing together?
> >>
> >> Good point.
> >> I think we need to surround efa_process_comp_eqe() with an rcu_read_lock() and
> >> have a synchronize_rcu() after removing it from the xarray in
> >> destroy_cq.
> > 
> > Try to avoid synchronize_rcu()
> 
> I don't see how that's possible?

Usually people use call_rcu() instead

> Sure, I wasn't sure if it's OK to nest rcu_read_lock() calls.

It is OK

Jason
