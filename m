Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE3B476225
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 20:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhLOTt4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 14:49:56 -0500
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:62182
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230341AbhLOTtz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Dec 2021 14:49:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE0Vnln6QZOvboP4cOgvXK7WW9JyX7dcDyQueCLN/DXcfza1tpbDL5ddsrRPvR69CEnIe4Hv8vdcQ8bAmlZXLCKvDSyZaaBkHtEQx044u6K1RE5AyroifnlgcJuqfy+d9buBtP6td5EEk7j/S+qWaCmLVM/R1OgcdGrcpOYj1yXZ7cKm3MHS/b52/U4p7Lf19fzgjcfxe7VLYtckTpGvTQtOhpgjC7d6xNf8SjYNAtfAROJQULwGcYIyZ97kf9NUzVtYXAVTZYEm6iJVfVUe+pGi+B2NdTnaQpSnvjLW6W6lG+jIRqgwGeVwyXL/4zguC/a4RSCeRwrSM1nHk/avsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcykf9g/f/RHgqgz/3J9NYVhQsAS18KABVave/+fUAw=;
 b=Tan7O2XDMWb/EIsp421O2Eai6XphVsErWz96OXwNjnoQdMsVAWgu342dqp9nRS1GxG9Ry3fKK7a/c6RBA6abDGG7reuH6LUPAZROy2xfNpSa+qzbRVJLGE/ZKY21wQDsRfAeNPVwIW48BBjcijo9Arz4du42TyeyQW9BoaIeDRbLL4X1tQ6HoJQmmVXbU+HT//c0GsWoUmd29yh+ppyQdHESvPZ4blxc3C56tHcurN5jgSITrhx2da/Whg/zpFRqUNIlOuvybF79lPJQiNVSq0uj1qERpnK+bH4sEJ7SM5wdfmtp0MAxfZha6iDV74JV8ObOJ10Z75cPjFJJPo7Ruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcykf9g/f/RHgqgz/3J9NYVhQsAS18KABVave/+fUAw=;
 b=newAVbH9w/k//9Y6jZvPEMJnwtPQAbaYbK9Qfe7Gwnf8ndqpOCbPT7BjFK7qDROThS10xhX1nJ94KQxMQwOXbbx3qLrvwZWeEa03ff3b3eiSvVIMSiQ2ldUCjfST/iHzD6g2fGHjINCFAInOC57vRrPoePQfPfb6wzefJDrOL4RuhaxQx8i/EESU0D+Tm5+EQOBV4xuFqIIS6WCE4JrWuMS1UU2AToR8BeI4LOEl+yqDt8yFmai/y5NMgtxYFWYGK+X7WK+mID7GGQLfuF/tVArVa15ZY4e96+7dJGLv3xyV400pMg1qJpDLS0Oy1BEeH3DYOhIPA26bzoGp6kdFJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 19:49:53 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%8]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 19:49:53 +0000
Date:   Wed, 15 Dec 2021 15:49:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH] RDMA/hfi1: Switch to kvfree_rcu() API
Message-ID: <20211215194952.GY6385@nvidia.com>
References: <20211215111845.2514-1-urezki@gmail.com>
 <20211215111845.2514-8-urezki@gmail.com>
 <YbpGWpskiByQNcJO@pc638.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbpGWpskiByQNcJO@pc638.lan>
X-ClientProxiedBy: BLAPR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:208:32d::13) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c120de9-8273-40e8-42b0-08d9c0041007
X-MS-TrafficTypeDiagnostic: BL1PR12MB5272:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB527283ADCC6231B4F32EBD96C2769@BL1PR12MB5272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0utu+rUSCY9RpFOjiyJnZvna5OwchO2zD3BAc41d/GxWIhKiCYUWfHsGrhXWhq9Z5qWuacWo3GYBJiGRb72KNtD8m5+Dxp9yDe+qKGgABZ+ZGKgSa9vc5/r2YVw4dn2Rgz0YOe/h0pQbaqiGNBZwhT5EyAoQLCJEO/LhWXH1wjI85jZniiQvBOeJ24iftzW6fshtY52s1ZOpdLlT0oSFrIn1S/NenAJY1C8XHd5ob3ZbdGVYTChC1/vHbcEf9hEAH9Vl+2igDLHEw+vusEd1pHGqfpHK1YRPA66ke2k/uYaUFWgf2Zkvu0tg4zQWtk98a/EIVBDq2pv1XU1O4scev5i2e99mqFor1R+7K9EAG/qGBgF34MR+CtCZDYJogZ+YDisiH4+iqjgIVWYUyMpXCAFQXfZ7ZolnGZ961O9qF34sJl9HBgMjGmZ0wfG60kv6p2tw4jhEdode1YAfyjx/HsV0yEu34jwX/IJ90zhmeA421rIkH+BxiIN8coGTAwLM06hbOw0NNpAjr/vMqWzvmGUGsW7NjArCxJsy4LqxSNxRiWsqav4GFemPfexXWzssbfIv5upa/kxJxP7eWtk5h4SeuQ/iwanayn53hCX+c4U+9d9QVnQx4k3jLALvldMycELS9eYl7+xvAO1dZ243qddNP4I8SQdnLRAVnfuz6LYJaTPIqpj8YhtI5aleDkjIXDVHJfds2cvD7sXMqbabMMFAHf5udHxLbhmIwjR3BOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66946007)(26005)(7416002)(316002)(1076003)(6506007)(54906003)(8936002)(33656002)(83380400001)(5660300002)(36756003)(38100700002)(2906002)(66476007)(4326008)(508600001)(6512007)(6916009)(66556008)(6486002)(86362001)(966005)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L/Pf85pQ1W8KrzZu0+Xk1b+p9/PJBV4sYiIQA5lsxK/hLWD5nis/3rMlY85Q?=
 =?us-ascii?Q?5nTdxAjj4xax5KDB/oobfR54IFiA5qc/ZN5Q6fLoFp3nLf8kGhJEczb5MGWS?=
 =?us-ascii?Q?ome+bd18PzvqIJN/F9G67Ca8lUNZrn5FfNaDq1AnliGyV+amRzdiRr0icLSf?=
 =?us-ascii?Q?XsyDtgyv6AL8dC57SyvaQ2QetAjcnF+qjNR39Mk7BSH+TGEKnqkWV5vaFgZY?=
 =?us-ascii?Q?ngawGF5iToIK6Jf/6LA94mCFuq4J1jeVp5yZgWUWTNa0iWjj5QFBhsGcdkv/?=
 =?us-ascii?Q?dmTjHY3KT/tDDrvBPFTDoQ81kMCparaZunP/FZONg2T9Y950AQGTUkGkVOyG?=
 =?us-ascii?Q?FZ7AeXIwR7gBPgx/GI0cvP1oNDi3+wOlLpPOtg1PL2cvKX0JM4EsXAbXBFz7?=
 =?us-ascii?Q?T0+mVoqQMMkzXIbsxUbhXfuILGkyenljpJABa2jnDiayTNaumI6xN/pnEuTL?=
 =?us-ascii?Q?cDbtPc2pzkP5Zfb5dx7VnZTo1XdoL+hJsgjzwaJ5Dn/ahdg3FnjpSjRFdE51?=
 =?us-ascii?Q?2L4wTlZTqzPxm/jAfzCtv/03Cxo3CiZSQN8g4IwzdjwBbIrzrNYYJbjKLI/q?=
 =?us-ascii?Q?q3+NZFLEQPu0sga6d4Z2Dy6yhvIrFc8Bdnzlua1VdwYIj4Hmi3b9DuvNwGjC?=
 =?us-ascii?Q?iLQQbSQoxD2VSrckicc49uLUpn3gejLn3FVo9RTViQhoTMXJg3ilQovf9DR8?=
 =?us-ascii?Q?YWfH+ZGXUJ/xBZ+5vVUHfXcIDOdmx52PFKFsrE5J0jt7EfUhLTIqfvTkqQh5?=
 =?us-ascii?Q?5e6oFisLx/w0385vHbtd0StuHhkdBB0H+F18AHr/8O/SkAi0gQs3NATvv39r?=
 =?us-ascii?Q?W5Y6DJkMT3TKCJTr/CMlv5CJLnkSwg0YkL3BOxwnIRZZwjyeYvKWUDWv2A9g?=
 =?us-ascii?Q?OqfyHfyrmED21WllxPGRaiNlAzIioLrSodzZtvplr2fhcj2TOGmolZpM75cl?=
 =?us-ascii?Q?rY4gL7cTdhyxL/DifStu+71JIyHp7BbYDKn/p4J7s+FXdc94ISbPxiLVT0mI?=
 =?us-ascii?Q?GpW8XRd094gMV5MzqLuHWji4oUMGGUNtTB/O944kTppwpcQv3/dTyQJJx1Lm?=
 =?us-ascii?Q?WA4HRAXceXyFF80L/2aQhF5pNUg9Wys4qFY8eOzajZ3ZvQwaRXVrFvK2lou+?=
 =?us-ascii?Q?uVaBoxJTR2VbJBHyqhT8j+H9sndCZUyyWrchTAdLIE0GoQL7z3UBm98AMs1O?=
 =?us-ascii?Q?ODGpk7zhkzur++Pe9vSSSi+XZ7fuQIeOnUn5IQB0e4GmN14iq2UTsItLzLIZ?=
 =?us-ascii?Q?HH019A0M1RkHEhKD5bMfmP7D7JuL1Q3ccSmqo1fH6sgnFG2v8AJeSFCPJ25A?=
 =?us-ascii?Q?hj36iJ77zwJVZweK7++IJfKHuBHaRCHhpEocgiBJXYaVm84nlb8RaGCIl80l?=
 =?us-ascii?Q?IhpFCtalbeoERgGitXjOA4BvG9NMqJUYPwDuDJgc2DIa0lAllTjr1HYzDLMi?=
 =?us-ascii?Q?dA0GmEpWPLM0Pz4Xo2NSrsEW7V7b5dFcTAqTtL2b4SX2K54v68Y7Fa+Cc6dE?=
 =?us-ascii?Q?1WSgHQWAR96IZ2QjuaE1mCplNbALBeXHrKeTvhj+5MnU+/7ZM6qhkToz9l0i?=
 =?us-ascii?Q?NUZd6kVMbSLYtUxVV2c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c120de9-8273-40e8-42b0-08d9c0041007
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 19:49:53.2210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xm1ErUbA/XOZVkHTmid4X6MwQXIy5hh0b8SNbFl7HfHEaiXyXFK7+IL5MRtYQ6tI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 15, 2021 at 08:47:38PM +0100, Uladzislau Rezki wrote:
> On Wed, Dec 15, 2021 at 12:18:44PM +0100, Uladzislau Rezki (Sony) wrote:
> > Instead of invoking a synchronize_rcu() to free a pointer
> > after a grace period we can directly make use of new API
> > that does the same but in more efficient way.
> > 
> > TO: linux-rdma@vger.kernel.org
> > TO: Jason Gunthorpe <jgg@nvidia.com>
> > TO: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> > Acked-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >  drivers/infiniband/hw/hfi1/sdma.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
> > index f07d328689d3..7264a35e8f4c 100644
> > +++ b/drivers/infiniband/hw/hfi1/sdma.c
> > @@ -1292,8 +1292,7 @@ void sdma_clean(struct hfi1_devdata *dd, size_t num_engines)
> >  	sdma_map_free(rcu_access_pointer(dd->sdma_map));
> >  	RCU_INIT_POINTER(dd->sdma_map, NULL);
> >  	spin_unlock_irq(&dd->sde_map_lock);
> > -	synchronize_rcu();
> > -	kfree(dd->per_sdma);
> > +	kvfree_rcu(dd->per_sdma);
> >  	dd->per_sdma = NULL;
> >  
> >  	if (dd->sdma_rht) {
> + linux-rdma@vger.kernel.org
> + Jason Gunthorpe <jgg@nvidia.com>
> + Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

If it is not in the rdma patchworks it won't get applied..

https://patchwork.kernel.org/project/linux-rdma/list/

Jason
 
