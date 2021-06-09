Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73DC3A135B
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 13:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbhFILuE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 07:50:04 -0400
Received: from mail-bn8nam08on2043.outbound.protection.outlook.com ([40.107.100.43]:48480
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239662AbhFILtS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 07:49:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUKIz8zx1d6TYoS5aBs/ZEoYmyegj0vWiu6vSqcSKWFh2dn2RM9vK2rx5ut/30nmZ0paCHdWWKShIGsGAIWyabjcj2vWcAl6VthJL5LRSsPrZjo7Sk+zHNTUyWrJwSeZUjGPpr3vBwiPsm/So2YROy/nALd7fs7zDaF/i8kbUSs9FlE2Fj+lWLHnUA7xwmd5e1aD/CaDyPycKpNYoU7A1eI/TBNjgzdCucL6bVFkRBj+iikn0Y1V/svDXJz2JzBu9CgwdZqQAPixSpH5J1Em7NWfL9g/qoPmPZFZr1z+S6o8GuqezgNfEuJ+g5hKouT99HWY+YzGa0lMD0qeQ/4klg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8cEJP+SVk9rM6+U/f/LWFUjG7XL6+D06OMPsxJ+zms=;
 b=OzNfBmfCbwotDYqvvRgWCKNDbuoEqqGI2jEWXo/850Ymm9bNmqB/rXjYtk7CR5HPXR2q6ikUJXWxI+prjzK+5PtBO4EnZoYJt6hUpVBSxviPjq/UnoKLVzydsnMUavM7uGkwKjsO04uxcdsZHuth/ftstiSDR/L1WWeXLL4ymla536/CISw4qmOYQXZ7bdg5sFOMYgw3oD/sx0rE3sMAWtudZ0C7eh2fodg5AINcARmt6KyOpec0tu3XK3Tb7ZFpCOVws+ojAlmXr9MEkyhNw/e5epzUIamoM1voXa82SIjlnR82gK4uHs9x5X3UqCuqopg7WGuUR6o1AyyaAm9iVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8cEJP+SVk9rM6+U/f/LWFUjG7XL6+D06OMPsxJ+zms=;
 b=R8pM9lO1wZj0E3bL/xVT3sMf9OrGHI41bDjd7wMXunB2tsluGxHi7dmJyB3tGeEWgqkAF3b+E76LzuO3KYgcZk6AcCVTnwHBuEp0MC93UsH16JrBlQSfJb6OK8CzdE6f0oLW/vHQUdGcy9m43YowFDcaYEEc3RkKgQ1Sc7LtH31CkECHiuEBbj+Km1UWdoVFoRrkwjcX2zry8QX6S1hENC4LIPrqq43Suh3VyW/sBdEqPAd0eal8mZ6a10ryeawe6EC2qpODBX/kga1fDfSSKRTv7Yc5MPt6qJ93vHMT/bXpGWpvqbkJEObDO1yK4/OUsToIQGSi0N+TeUZK3xRotQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 11:47:21 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 11:47:21 +0000
Date:   Wed, 9 Jun 2021 08:47:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Bloch <markb@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA: Verify port when creating flow rule
Message-ID: <20210609114720.GW1002214@nvidia.com>
References: <07ddc8516a0e53e54e3cf5cbbff19cac6cda3d82.1623129061.git.leonro@nvidia.com>
 <20210608200935.GA992630@nvidia.com>
 <YMCeGiLRG9aTIC2O@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMCeGiLRG9aTIC2O@unreal>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0044.prod.exchangelabs.com (2603:10b6:208:23f::13)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR01CA0044.prod.exchangelabs.com (2603:10b6:208:23f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 11:47:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqwg4-004aps-G0; Wed, 09 Jun 2021 08:47:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb142cf0-3243-4aeb-c01b-08d92b3c5772
X-MS-TrafficTypeDiagnostic: BL0PR12MB5508:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB550805F20E96509E0005B5CAC2369@BL0PR12MB5508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcka7Jhk+n0RAO05NZVSQStB8q4oU56xHAJVf12x3bXXVAJCdLPe96CVh2Pfm3fA9svErUfkQ2S0fQAPhycshOfv+umR5U8hVJvEBNR+esrF3uL4gNcIxJGgoM+QySWsb6BQAxs2MCcs88vu/YKYr0UEVqmaKkveJcZh4Y6S4kvvsP7EhAj9y0XjPFj+VH6m4+5ixyVB0R584qJGp+VTDqrx9AMPyT4i/ZM3SUB7IZqa6KTl29wwoJZooNLvMtilZzxW6OCKaQoM2Xby5RxYcacV4zWmvTy7MnQxXWhCq8rXp7caL6inKOgRu656jkWGk+BQT59RpQHtyB4vPwQW/DGvsUd/2nW5ziDceNZxsUc0kArGD78oCsR7LQFqqvZzaZu3OraGLQwL+WcrKh9knOvZa84eUjrdyB1a0zR6vy4NYCUlRFNWuogbJTPmjtuYDCcrzw2SB4FJYIw6vmOEAgh3S0v0iRSrf9E3+3JcAJdeNL2+3mlnkHHyAKELY8j8Hkn6oGINXdv6X0owjPTLnEUr3DD/FYl1mVOdtindS5f/paK63AV/Sr8rSCAkeLTkBLU9/vt1dYMPW4gMow3k35P4rQ0PredItarnXxMJ3DQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(6916009)(478600001)(9746002)(86362001)(38100700002)(9786002)(8936002)(54906003)(8676002)(4326008)(426003)(33656002)(5660300002)(316002)(36756003)(83380400001)(2906002)(26005)(186003)(1076003)(66946007)(66556008)(66476007)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?61UNKKatzuFbTd6VRRN088e0wK3j9VI/VNMH7uUsxpWwLCQ7y31O/NDfaHBq?=
 =?us-ascii?Q?Ez0MfJZanObXx1zB9Q/q6ThO8DOF35BaTu/jqaLHBbmVRi3hlrLCYdzvdYup?=
 =?us-ascii?Q?CW/0+ZDYBxdrQIvgspsNhDBPPQgxjeSpRdiGSavhMzorg3wtvGxGUqPZ5mZM?=
 =?us-ascii?Q?UgyZD9IqJcf4tLATDkmyGA4zE8KAJaWbaJ0pNO+IxJ0ohbcUdw6eKvDQM0JU?=
 =?us-ascii?Q?2sUWtFx47LAxW3usmbi0/qhutcGHAiId06h/z0qKNEivN4LsKLjr1ebP0N6C?=
 =?us-ascii?Q?ufEM924wQJ9sNUeDTS09WZxda6Fs/cZN6axj7f5P7kEz7phxzIFStf3il+sV?=
 =?us-ascii?Q?hEWYNSjfOdzyiUo1turpTecp6GEqqrWbw4fok8DDX7qGqi8gAxqYJEZ1otCr?=
 =?us-ascii?Q?fl4TZQTetGn/fARPTcpIKXzdqTleoomAo2p4EcR0+w9fAQc+Lk4Pduz5/ftE?=
 =?us-ascii?Q?xovA6/2KIv+4hgJDUWBK4LPxdsktVk4sDY/fJzsnbLzfrfX7wOPsJXDfxL8i?=
 =?us-ascii?Q?lqCWarymzdKw1/k8WSkOsub5LVJ/CDHb9/7cNp1miyEJKkBNg9Dv8WUZQ50Q?=
 =?us-ascii?Q?w0yA8q2hNoGias5TxJxz42kdY5lMyPcvfomdV/ixfzGutblXjxL4s+aRwc+i?=
 =?us-ascii?Q?5lPm6zHSkUMPN7Dxch+cXjxEwhADIkn/QpWINUwjIIP/KJWjv+qAqouZv1kh?=
 =?us-ascii?Q?Eb3juas+Efh+yeehodQlJ/8uVdKqFn9irgNofCrDPmkUXzH/AUgcLR3gK1Ke?=
 =?us-ascii?Q?72c/QMEfRiKOWShpqhFuZ2FDfiFb9hRQIaRfOYh+ZOi/WTCiZWzFZ9CxoGNh?=
 =?us-ascii?Q?p3Wmw74NB4HUGMg7p7+yRPHI6/7kgMynb73imcrl4y9gjGordRnLy5zfG2DR?=
 =?us-ascii?Q?EDwRyxsL5wLusZt/sigF50b4BVMRQ6o9q3oqsZ7kC3sxMwM/QXEm5WCxKSnk?=
 =?us-ascii?Q?4v9AN5U1MiKlIzvtc+MX8Qf01HBbqfRAbvGo9/7b93rA06oz7FayHwRDvIh2?=
 =?us-ascii?Q?2Ec7lc4yqIZO6GyBWqjcvQ3gHwFTJmKbBQITOK2OmKiYtFox9H1N2QMCRbhj?=
 =?us-ascii?Q?h0jeG0B95DSFWDSGu3xckoMhV/WBmzDcZ0hW3UZTCilJckFSmVKwEsp1OsxX?=
 =?us-ascii?Q?JBDJTWcD6VRLx7S5OOPBR2thBLPhsv6nv5HXRCLn7jl5L6CNBhOSZOiPRzXP?=
 =?us-ascii?Q?Qtu3HNFO91KbB8anp+CCKMNrgtqlGIHHHP3UGvLX5okR0Sr6MeESgo++2soM?=
 =?us-ascii?Q?3pTkmikAUm8sRdpyb07NJyKlFSIZx4HQ19U+OcpBUsuuuVXwhZkUqa+0/79A?=
 =?us-ascii?Q?55e7YEu0rTmSL4wZXB1LLDX8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb142cf0-3243-4aeb-c01b-08d92b3c5772
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 11:47:21.5931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+4tCcTiMX9D254VfNGCbpHtQjf8VRutD8WJ+7TcCbzEV+BuT+oLCYvQUKCHj6T4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 09, 2021 at 01:55:22PM +0300, Leon Romanovsky wrote:
> On Tue, Jun 08, 2021 at 05:09:35PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 08, 2021 at 08:12:24AM +0300, Leon Romanovsky wrote:
> > > @@ -3198,6 +3199,13 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
> > >  	if (err)
> > >  		return err;
> > >  
> > > +	ucontext = ib_uverbs_get_ucontext(attrs);
> > > +	if (IS_ERR(ucontext))
> > > +		return PTR_ERR(ucontext);
> > 
> > ib_uverbs_get_ucontext() should only be used by methods that don't
> > have a uboject, this one does so it should be using uobj->context
> > instead
> 
> Why "should"?
> At the end, we will get same ucontext.

The locking methodologies are different, they are not guarenteed to be
exactly the same, but once the uobj is obtained then the related
ucontext is fixed.

> > It looks like this can be moved down to after the uobject is allocated
> 
> The idea is to fail early, before first kmalloc and uobj_alloc, so we won't need
> to do any error unwinding.

The error handling is needed anyhow..

Jason
