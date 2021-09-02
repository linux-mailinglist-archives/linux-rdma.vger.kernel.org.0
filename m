Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32BA3FEFE2
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 17:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345727AbhIBPLb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 11:11:31 -0400
Received: from mail-mw2nam12on2051.outbound.protection.outlook.com ([40.107.244.51]:18432
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345691AbhIBPLa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Sep 2021 11:11:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYZcgdAdUw2z8lJWURslHP/pYU2cY8Ivr6wBz/CM/8SEsKtecmoeTpso5KTvbnuRXP3T/5XflhKOp123fMGG5FYXT1JEHYt4QAl8BxsqITZeVewl0ka3atwnfw6f36NlMKgPSqf0Lt9beUWzA6Sl2IE5sk2Axwx5wBGqhVDWrwqega+v46Eyjla4cqyOGSSdlCbobw9NRDnSIUbTtQjt5rOscjd5vVK+VWGpTrN0gzVZbNQaACrvg8i9w66dpGBD/rXkT6SbXkQNO0sBXzy9IKw2tW//PRd7nT4pyAPZT8aPsPE3K2MEbFgu3kMk99ISib48ZqDEwYqXcWyPYR6k1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=73rcgcplQBk1lUABntzaqPuO33cBCRrNX+fAFrLZsSs=;
 b=gPqV2hZApGxUeeGT4zCH+PyTuB6aPi9nYT3TrsGvB+QjM9UXRAcbSQCoz1h4Sxt1eqgKyKHoYnrQGcTSQNvTCOcd/rh/1M2mXeMWnEsRkQXbCC0gqjmMyfCPN9dWyR20VpSNlj0/2RVGFonBM4eA2ZjM1zfnbGuPLlBVFnt+Ys1AUiVTzDIUkAdQmXJ+auvnKuDVFQQ0y3+pVT03tOsqL588UQTcCY9VCX50mQvCTxgai3yUi+31oF+D94Ihpi9q0FGvtBRWVH8AFXy7syLYeaT1eBmpOvbl1p5M7em39G3Kokb2md38GahkuJMooNKDAMKpe2xWyAXCgY8tIAafVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73rcgcplQBk1lUABntzaqPuO33cBCRrNX+fAFrLZsSs=;
 b=SOVsbZtDTd/O0dER8InvG1fBq6qQzuB9+An6egGoSYS4v1uqOnUt1NqVZ9VIfwlvAs/HCxSBZUdav9Z6LIn9/4PH7avb+KlmiYNUhoNrMJxjb/9b1dD5Vl5lvBLv4aIj5MAOymuiLy3viNlMR8AdIVDPPdQwzEjYTSI00GH6ApgAWzZ3ulmDzDiWmrOCDkOFWdXWQuUFcMxEry+0xRm1m9zmuGqtWqRVpTBMGoPIUmJwsFZ+idDm4EDSBTf30T1SzIMmCjHcoxR3H4M5pILLB5EZIpZRRO4u2HwuOFiYlk/w7/XH556HNte8Q6/uK5wnGLa/V7FDE4Hrakmqwl69BA==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 15:10:31 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.020; Thu, 2 Sep 2021
 15:10:31 +0000
Date:   Thu, 2 Sep 2021 12:10:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 4/4] RDMA/efa: CQ notifications
Message-ID: <20210902151029.GV1721383@nvidia.com>
References: <20210811151131.39138-1-galpress@amazon.com>
 <20210811151131.39138-5-galpress@amazon.com>
 <20210820182702.GA550455@nvidia.com>
 <7a4963ea-f028-e787-a5ba-fabf907c6d6b@amazon.com>
 <20210901115716.GG1721383@nvidia.com>
 <c8549e51-47a2-1426-b44b-f1c4ade3dce2@amazon.com>
 <20210901153659.GL1721383@nvidia.com>
 <d1b2dc01-5a42-371e-c4b6-2f9b3425f5b6@amazon.com>
 <20210902130255.GR1721383@nvidia.com>
 <3a5fb37a-dd72-e322-f7c6-790ee4e04efa@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5fb37a-dd72-e322-f7c6-790ee4e04efa@amazon.com>
X-ClientProxiedBy: BL1PR13CA0401.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0401.namprd13.prod.outlook.com (2603:10b6:208:2c2::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.12 via Frontend Transport; Thu, 2 Sep 2021 15:10:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mLoMH-00ALyg-VM; Thu, 02 Sep 2021 12:10:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9282d8d2-70c3-4a3b-9135-08d96e23ce07
X-MS-TrafficTypeDiagnostic: BL1PR12MB5378:
X-Microsoft-Antispam-PRVS: <BL1PR12MB537890550E388F254122FBCDC2CE9@BL1PR12MB5378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzZolqI2AsTxAgBxjQp3uo5ko4HcMaSetCQVzzLhPHBlPscMRsH0hDLxH5laOsYgq+msgfhZFlMvL3Y7c4nIILzrOXjui9rMSaNffVA7BNzQu8HT+v080qmBfDB7Qt5adS7TVHnCyPv4HJiaNNNcRNxURhlBBonONATXH8Cmzj0r8r3Q/rptiiXq58YtgC4BoyOxnT5G1f4zcZF+CvWbKyU4oYkhpw562MwOnfTVQTk8h1Xfh877GfExvJG32TO6+uvFDyXNZqq+Y9SsXwu1EDIdVdPPErFPft4G0fcPbo8hsihsvS1jSFWGMjU3FoFr6Fytui7H/OFpQ/huw1YavCx0eDb4OMl/YMiKSI7p3dY5ayqdjto4RMaxIG245gJRI9qB8ujdSxqNTUTBK4Wg9dcnm2URT+J8iWnC5LI5CvJV5MxM9q6mIZN3+OVfKDWgBau6UGUgkqggOV+Q8Sjyizbp3ghiHeKcJxOBQOIDsZxz7UJCkA8IPCCUwqABFbMICH4Kh3XtV7Y3wM2CFQRZye/qiusf4HIRWTiiLEi35avgYQxW4Q8aaMjCuYQIB6J7Q3X/UOPCUjykMKxkbvryVI10+RAxMKnn08LILLAJ/fJTPzVtXhasYq+tE9FCGh0WwqRlgxz4MqcVIMGkYMTnlhdNeqRQ3DJOaOSYxj7RKI0gymkoL3sk/9gKkc0R60L4AojqDmlkiGZ+NytMnWWwOVU7yc+B4jf/tMCWJ1Nh9vL13noZZQKqhFq15WX4FQSBAAiFj5XB55/Go8ckzgnQVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(9746002)(1076003)(9786002)(86362001)(966005)(38100700002)(66946007)(8676002)(53546011)(5660300002)(2616005)(54906003)(316002)(26005)(83380400001)(66476007)(33656002)(8936002)(66556008)(426003)(4326008)(36756003)(6916009)(478600001)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N0+bHHaKDVSyhwW8jHAL3ZMRWQWfIeasTC7N0PdRJMx6466FGfolokS+4Xil?=
 =?us-ascii?Q?XlNhHTHjYUWxcxNBmsrJNm3roQWyG+SDxktgsiFpEXAoGi4uY7vqT4l8cKhn?=
 =?us-ascii?Q?w/9WSWXxTwnvkpdQ6TuwJDvc9CJE4NUBr+4ErQx7Eq0t/Zbg8O4yGe1SbKMf?=
 =?us-ascii?Q?7wuKCpBM3W9UFgH0EM4bH+tNZ5xomMhuaLMFa9ebkDZCu8XzqRHNUD2pmly+?=
 =?us-ascii?Q?sL3EqbAV3tazoe0IU8FtHHbeSprua6oZMzR1v+DK2tTLX6rzcf/afOOe1C2w?=
 =?us-ascii?Q?WuH3a+Auub7esyT1pc/sBxfCsd8pzbAStgoq8X/oLILnoDw14u13PGPSiFJm?=
 =?us-ascii?Q?bpri6PA/bf4vx85Q1tPK9xyauJf8AQNDNCktzMNCUX2zKHzOUoO8va6xACMy?=
 =?us-ascii?Q?ZK73NEQx1ZEvVerdrMALJj1pOrPSe9OPA8SlL4QSsyK+BZ6u91duZuVSvzo0?=
 =?us-ascii?Q?ZvlJ5lZQQKI+5MffZGLb0Ft297w5Nv45ek8X3Ftb7ehQtf/NUBM7NlHUTF5+?=
 =?us-ascii?Q?PUQhVZjxcHD9d+aHZ2PsFKkjN06AQVMYfLJSC9WDD/8nJpXCgEEuVZN14zuU?=
 =?us-ascii?Q?Oe1kdJTDn6pLrTc/QNOqIuhUSSQ5+dIECbrD1usDo6M/Bxag2BSC1WSR2JCl?=
 =?us-ascii?Q?zIszwJexk/yjhoFLxCU7Hrum28BXaau01A57cfJpdq4K4r2qRKF/wi0rddHW?=
 =?us-ascii?Q?g6xkNqpHv/DWSPxnuz5el49HVnfmoz/FA0HJeD86vxcFhuKUpfPKoRNVj988?=
 =?us-ascii?Q?im/Grjv7cYn0JoSKugH19twS8mgX0k+yTyO7Jsk2316kIsPmgLyRLDGV3bNF?=
 =?us-ascii?Q?xpWHJWt02el6Gax0fWO6e/pOnRa+KvZiCZoYXO18edtX/b1jS5+HtYinRk+r?=
 =?us-ascii?Q?6MP6DOEj14fkoXR2p+dU/DuQpqc4/5224I0B/Zw8oIXaWOFFBlqq/6qwlWjP?=
 =?us-ascii?Q?NoPktSuV8Q4LRq9EIN4NaUlvOipuhPMJM+ELA5YRHNmmx2a6XuYBjX7IyOSu?=
 =?us-ascii?Q?C4gtv2A5i/E8WjVEB2VXdOlWPCZ3RLUeu6WCNld3Vh3YuG0Lz5daxYq32s6W?=
 =?us-ascii?Q?s03Z2CUjTT0JxuHgegqfZstDQDx2H6Mkzo0c7Ni5WSvU5MZDz8fxhLP/8V0C?=
 =?us-ascii?Q?gdWVfRuhc7ZS0WyQlWLgbZNcT7juoBtZIHRLZEt9MsfZ4dwI5S0f8iEP85hh?=
 =?us-ascii?Q?OTbBA/0KZETm2xIRws8YVfxIZj7HcAyQvGTn5etXiKfCj/zCMHAQWz7oFuo7?=
 =?us-ascii?Q?Y8yzFYW79Fg3dCOobJZauLQ2+/U1+IhMJnGTqaVxL86LuEa05TrAEEzEM2ok?=
 =?us-ascii?Q?/Ar4frbhng/1Ctfzkl6riGfj8MAMTVOoOctjWCu8LvudVA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9282d8d2-70c3-4a3b-9135-08d96e23ce07
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 15:10:31.1050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4adbPCEjFnxtpnfjk9ssD9sHzdvbqwsz8mBM30MtB/8aXOv8wQ4hy92DQXU1A4D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 02, 2021 at 06:09:39PM +0300, Gal Pressman wrote:
> On 02/09/2021 16:02, Jason Gunthorpe wrote:
> > On Thu, Sep 02, 2021 at 10:03:16AM +0300, Gal Pressman wrote:
> >> On 01/09/2021 18:36, Jason Gunthorpe wrote:
> >>> On Wed, Sep 01, 2021 at 05:24:43PM +0300, Gal Pressman wrote:
> >>>> On 01/09/2021 14:57, Jason Gunthorpe wrote:
> >>>>> On Wed, Sep 01, 2021 at 02:50:42PM +0300, Gal Pressman wrote:
> >>>>>> On 20/08/2021 21:27, Jason Gunthorpe wrote:
> >>>>>>> On Wed, Aug 11, 2021 at 06:11:31PM +0300, Gal Pressman wrote:
> >>>>>>>> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
> >>>>>>>> index 417dea5f90cf..29db4dec02f0 100644
> >>>>>>>> +++ b/drivers/infiniband/hw/efa/efa_main.c
> >>>>>>>> @@ -67,6 +67,46 @@ static void efa_release_bars(struct efa_dev *dev, int bars_mask)
> >>>>>>>>  	pci_release_selected_regions(pdev, release_bars);
> >>>>>>>>  }
> >>>>>>>>  
> >>>>>>>> +static void efa_process_comp_eqe(struct efa_dev *dev, struct efa_admin_eqe *eqe)
> >>>>>>>> +{
> >>>>>>>> +	u16 cqn = eqe->u.comp_event.cqn;
> >>>>>>>> +	struct efa_cq *cq;
> >>>>>>>> +
> >>>>>>>> +	cq = xa_load(&dev->cqs_xa, cqn);
> >>>>>>>> +	if (unlikely(!cq)) {
> >>>>>>>
> >>>>>>> This seems unlikely to be correct, what prevents cq from being
> >>>>>>> destroyed concurrently?
> >>>>>>>
> >>>>>>> A comp_handler cannot be running after cq destroy completes.
> >>>>>>
> >>>>>> Sorry for the long turnaround, was OOO.
> >>>>>>
> >>>>>> The CQ cannot be destroyed until all completion events are acked.
> >>>>>> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/man/ibv_get_cq_event.3#L45
> >>>>>> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/cmd_cq.c#L208
> >>>>>
> >>>>> That is something quite different, and in userspace.
> >>>>>
> >>>>> What in the kernel prevents tha xa_load and the xa_erase from racing together?
> >>>>
> >>>> Good point.
> >>>> I think we need to surround efa_process_comp_eqe() with an rcu_read_lock() and
> >>>> have a synchronize_rcu() after removing it from the xarray in
> >>>> destroy_cq.
> >>>
> >>> Try to avoid synchronize_rcu()
> >>
> >> I don't see how that's possible?
> > 
> > Usually people use call_rcu() instead
> 
> Oh nice, thanks.
> 
> I think the code would be much simpler using synchronize_rcu(), and the
> destroy_cq flow is usually on the cold path anyway. I also prefer to be certain
> that the CQ is freed once the destroy verb returns and not rely on the callback
> scheduling.

I would not be happy to see synchronize_rcu on uverbs destroy
functions, it is too easy to DOS the kernel with that.

Jason
