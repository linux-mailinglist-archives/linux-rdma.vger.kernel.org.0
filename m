Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AAF40B70D
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhINSkA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 14:40:00 -0400
Received: from mail-bn8nam11on2058.outbound.protection.outlook.com ([40.107.236.58]:63619
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229946AbhINSj7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 14:39:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYJyIt5dt8cOl1nzGc1GZ1cDmFMgPV6mPVDFSg72WOr8oBmIwTvvSYq2ant+6U4Q+nhNUfldu/p2aHWIg8prqURnRxY/GFPmJnxbthM9Ijkbj9JHI0u1BaKmPTiTMOWT6z5ICUWW3OinfnETnzJbbxkbTXRMvwkNJHDHittpQ3/BKsPBJIRrEz/FTBQi2qTDu5t1VbqCNw7CUKtVVFpBgcd6dyw3CN1sf1zN6Zx+9/pkWtj5JmkLk1wttIwLmAFeteof36h0oV37SQf5Ng/EbBsUYC8VRXJUWsv+oE7xzcO+DZXM7lNdvibpl/PEZXRjvtyW+/OufP2KIE2qzde4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WVLw2oHl6PUiwQtiE/QySBiJdjid4o8P3Reu1bjfGXA=;
 b=FMZRjGaTVbzTp4X6jS2teUiILZOew7lAPpAom03PNq69eCCb0NlKEP0/34L9jZol4H0NKsW8NPTOX2VAyWKA2+IRKRM+Zx+Kyk/BWny51eEr34gaZxBH0d7L/Jf89qXAXMPjapgg7/K+IQMdJ1VC3Q0kpwYBLJb0SiqSdztMc6w+lXnSld2eCS7R2qsHRq4MLyqziz2dKE+9LXx9QUyNbxacPZdAWEOGhH+jcwIoQSmya1L3RCI5t++iXkzkgy4UAACFlCWs9fN+L0uGzJjts10EnRCAGNCXTIBUDNLeq3D2jW58/RmXVbEyU5mq6JJeXR4TOUCI7ou/Q1aMGGxkjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVLw2oHl6PUiwQtiE/QySBiJdjid4o8P3Reu1bjfGXA=;
 b=GZiab4CM8/6qk1umfZd6BdDj5VQ0mbICoxEtmKKIaz4kSmBCb9wR0KxeT0+HrR8A9KqACjti7wK7Nt54gA1ZLYqntNOQPY6KJdVIs0q17Z3dxsATq4+OF+cA4vrsQtbzWVs0byXJrfEA2nOsVJ8SEj4nYS2lLsJHDr7pHXMXu6YOk2Ggst1GpEwdPyVly9xkpuMzeaq1+Ij8bLtYDWq6Wr5eZkWU4Td8d/MiOqdobKHN0cLICdF3D+CYQEOOL5vIX+YY+Q4f4Oeh4y//b98F5LceMCAf4iTRY2uRoLxHwfUtnP04k83pNlBM/QnltrBJ4PktApXrTf9y8J6U5e0Hbg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5524.namprd12.prod.outlook.com (2603:10b6:208:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 14 Sep
 2021 18:38:41 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 18:38:41 +0000
Date:   Tue, 14 Sep 2021 15:38:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Lameter <cl@gentwo.de>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH][FIX] ROCE Multicast: Do not send IGMP leaves for
 sendonly Multicast groups
Message-ID: <20210914183839.GA136775@nvidia.com>
References: <alpine.DEB.2.22.394.2109081340540.668072@gentwo.de>
 <YT8qM0IpIslXL4Ni@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT8qM0IpIslXL4Ni@unreal>
X-ClientProxiedBy: BL1PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:208:257::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0044.namprd13.prod.outlook.com (2603:10b6:208:257::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Tue, 14 Sep 2021 18:38:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQDKJ-000Zcl-CR; Tue, 14 Sep 2021 15:38:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b59b235-b94b-4596-23d9-08d977aedf81
X-MS-TrafficTypeDiagnostic: BL0PR12MB5524:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5524A2B7DE27219638018B0CC2DA9@BL0PR12MB5524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LGmpsbdIXyCeLl+yHjcfS4t115CPFLqEXS20+Q/q3Nc9M8EpWtlT9o3e4L2A6rN9GdfYu3gUXK/9Wf+z77/3JHo1QPh3oP3Lr9yme9ARz0cGAuSwJd2vFbMIMGQqb5p2wmfLBzCgm/NjqkebbA2LyCew98tBV/8ccJEAg99kDGQbcItGC5X25W8M5JnxCeybGIvc9Uy9HTiPXb0NdaXzjmA1W7Hp7jDETMSz8IbfkztqM1sEkWSd9ep2PnoNW8ZmPEQ5CZFQP4tbv1yZREYuwgvja+x5EKgmAp3/90pOUv5beHzXV7N7QakNfKRM8JFkx2EEIdw1gDDEZEp/WyvB0zbZArxkdqyJ154BdHJQojSZu5Oabi4mg52K2jGHxtbxHQShZM9Cy55yH9FcOdjfuv/C187IjDS+dXiLDNU+TmNC2rbsp3wDZiKLBou7I9Q1XSNshd9cuXc6djqsaZw4Tqpi2W1jQbVkOWktloJ9YkH7d+fJwysKCOvJNPQpJtndBexhgQNS7Uwge65GDYE9ftvE/PExtK8R1/KqcetR9dqtsR8GdN2WGfMPscd6pcmtOuuk5wgIf5bv/W3WiCGLeQQEXG2WHXUueLKALocjPilk4irqkdDqyNjEcWK11ulm2dilrZiMUt/R00IJmBxiCDOhJGUc5WWrL/eSsP1U57ymmELvTlXlx4EgVIeQj18dLZLJMMs7ftoKaFOTlr+Szw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(186003)(8936002)(6916009)(26005)(8676002)(4326008)(38100700002)(33656002)(9786002)(2616005)(66946007)(66476007)(66556008)(5660300002)(1076003)(2906002)(478600001)(316002)(83380400001)(86362001)(36756003)(426003)(9746002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNdZNkiTK8zpqIVJY0piV/rvWseem3gfdrBoBOUy+AB1rEV+twU0GL0iQXJm?=
 =?us-ascii?Q?UbgZ/5rHP00pOPkhol18QDpOpUX7HUeC9finffaUOFBSe9kpZ8APnEONMthH?=
 =?us-ascii?Q?OgD2oaft9/tAgOr1e90fwdcBrAk9kkk8/pUJYYP9VJYVyA9Y+keecxIBSVci?=
 =?us-ascii?Q?ynxxazpGH7CQYX1kJqfO1pJyuo+f6yURWbtRagRQF0yc1JVSmVvc4a5GMX25?=
 =?us-ascii?Q?0/Si215bxzpHgSyJLPZcT4cgeMj3vumjsyyHOJVPyOB8CVAag75M3fuvPv4y?=
 =?us-ascii?Q?Qt4kLdw9ZnFGcxC8ZVVRGnENlsWJY/oUtNQxJP5d6RM5lsFN1Aaw5B408PGA?=
 =?us-ascii?Q?SploPm+ji1b1+lyYTKEjW4ULB7nxzNZn1dbX2SyrSj8DXgY8/d3xi7TjtTLi?=
 =?us-ascii?Q?QZg4Z3bWp8CX8W2120mOmdseWXvJnoe/Zgd11y61VPqiyQAy0p8oM1nHShUU?=
 =?us-ascii?Q?EFQea7m1ZUNshDIOWHEc3QCPLqI8YijxprIhIekQfh4CRq43DBR4FIDWHFbq?=
 =?us-ascii?Q?JvuOWsvKb7xgMEkyZh/da0z1/fwar0e5NeEF5ciZ2zeDtRjw8vesy+Su20Mx?=
 =?us-ascii?Q?XxwyLHIoCMFrJZsfDytSkOg57i9kdNIva5ZXfpaixMjsyzQW97xrJV1XReta?=
 =?us-ascii?Q?EvMPp+napIRb6bA9ynHEbnxo//h8FOluXPawlSXiboXgCbRehT0EvIUZy3F0?=
 =?us-ascii?Q?qIMOFmluSPJB7j57E0fqEntcLQe1F4fufyPyASa1f04gI9pavDMn/oCVo8EC?=
 =?us-ascii?Q?ZkjqGdkBNXwGjEOdmVGKzUEjz4Mb3bfXfCnSaKextS/uT/C8YBnJ+HTL9uaW?=
 =?us-ascii?Q?6r2Kl8Mc0yH7fZCPOWnzDpZDAT4hcEnhgqhk42DwVjYk/W7RSuXR1Ue2/HP9?=
 =?us-ascii?Q?0mjajeSN6JGc23X8RtPiroEdGLkkABbw0PMc79A7Hn9vCIRXHKL+k/tXcgcm?=
 =?us-ascii?Q?MtrsYZGKMRy6wrfLoRyNUpnDN0ABb1kKlHOwTT/xeVT1T9Li7+n4l/O/sIvp?=
 =?us-ascii?Q?AEsC+xgRy2HTR3lek87FDmP8Vczf88uOG0rxMRRQJugKqgZqAgNi7gLxvH77?=
 =?us-ascii?Q?MJ88tAKrdhrQcZI4Joq2SlqILSYeHG8uSfUVLQllbPILEvrlKO5Nq24e6bTZ?=
 =?us-ascii?Q?uxmpz0R/tUgPYZF3ifuxwkxIJ5Y9zgpwlHVPZ4Qw9cAqeMy/BviZq+pPMzx+?=
 =?us-ascii?Q?ZOQUxUB0ZZj4Tg2h4GAgZ5SoTBb2JprhlTG8bT3rdemICeiC6XTzzeqL18vD?=
 =?us-ascii?Q?XeMxTYSjHk4wzDS72D1NXxkW302NWl6kubkYPL8133bIA3qFbEdqxDO7jsOb?=
 =?us-ascii?Q?Ve1jkF8t72UHD6QHWj5s1PTQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b59b235-b94b-4596-23d9-08d977aedf81
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 18:38:41.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qfPGyua2NbPwg51m4MPyF5iyOIGOU/o1nVgoEMpmViPjuKsAkesOu/S0SPoHrTY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5524
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 13, 2021 at 01:38:43PM +0300, Leon Romanovsky wrote:
> On Wed, Sep 08, 2021 at 01:43:28PM +0200, Christoph Lameter wrote:
> > ROCE uses IGMP for Multicast instead of the native Infiniband system where
> > joins are required in order to post messages on the Multicast group.
> 
> According to the IBTA v1.5, there is no need to join multicast group to
> send messages.
> 
>  10.5.2 MULTICAST WORK REQUESTS
>  10.5.2.1 IBA UNRELIABLE MULTICAST WORK REQUESTS
>   ...
>   A QP is not required to be attached to a Multicast Group
>   in order to initiate an IBA Unreliable Multicast Work Request.
> 
> Did I look in wrong place?

This is talking about the ibv_attach_mcast() verb, which is different
from the SM notion of a node being joined to a multicast group or not.

In IBA a node that is not joined to a MGID will not be able to send to
that MGID, the network is allowed to drop the packet.

With ethernet all nodes can always send to all multicast addresses,
the IGMP stuff is only required to receive

Jason
