Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B5F419D26
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 19:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbhI0Ro1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 13:44:27 -0400
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:20513
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235781AbhI0RoY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Sep 2021 13:44:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQWaeomcZEwzBQm75Np3zwx7VVoaKi3gyLl9dvygZMQSzvjVgMO8ttDftp8lVBPTBnUKK9ImdimZf7oDMmsdBju214CBKoTdE253NoJd05lobu+Ac4ahbbc0KmXElcV/b5IUviPA8tYAWCrEXsGCE89rbb4zBV8pKgoH5aEp9tIeA9irKsdPEmXQ0nfqry3WYELxI7Tm6VtkgaLn/2KDjZtgaaspi5sSQrY2lN/174+FkK3z4xOePk3afCUdl/toPNhsdela2N73mkKvME/wpBonPlAELxmBwvJA1Flzy3ccwf5lU7/ZoqMkYhlUcV2Ewf3Afsfj+BBOWYPOc0xUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fGNpTLZo3HAxMp2Yp/Kx3SoqqzOjFqoQFoHCFovkYw4=;
 b=aXTi/Pvj6dhXCbgFD1q/vRtHXfB1+SLdcH9EBPeS3lYnsNUXXE5aO+2bNO1tlT65P+a3CQWmDm/VmF3+DoRPTanRmXaPM9UCTZqemdcQYwiWy1ejni5IJwucAtq0rT0jqvx5+SrvChGYU7wDbwFJA/ZajbPfr6bOGzs8ZEe20ENH6KeTpvG5F9g9wFdf4TE3j1dpTpgy1+TnY/YAh4GNEn7V83oFsdX9HjHRzNGV5Oulon7nU/M6fJHR7j3QXHeUag6mj39Fgfwsqrohei4pIu+TZxzJa4+Vxq8Jk/IGrbZyAxIelTJ7UaU3Gq4E0NxO5nRyaEuwg7BzmbYT7ocfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGNpTLZo3HAxMp2Yp/Kx3SoqqzOjFqoQFoHCFovkYw4=;
 b=gPJ9jUdAb0IP79hhTXUuB4q1yBjDdgtRfuYfDpvxVviJXd2DeWbXwLRsKf/+G4TU3y4+78X0XtK/LOqttOkjMCJVBU9HTo5y+JiKj9Nyu3/DGdSrSVOMjqjRNOuwsjaOIdt4it/F0Zc5Cvk9QUW2FGhNvukNqkOQxro2bpwnEWO9WsP+3RkkJKSMyS36gK+BqAo/aud150JWBEv8HDs9kAyBhADhuHLa+KseoaqNpPPrr3XZ4XAAfEFAbglYBpU0Tw7eV1P/DaHWqH2oRTeT1DsGdXaMVdkKZQZpfLZEJrs8eQfGxVujaTj69eJf8vBTbOOEhsW2wR+Dxkpi7TyN8Q==
Authentication-Results: sjtu.edu.cn; dkim=none (message not signed)
 header.d=none;sjtu.edu.cn; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 17:42:45 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 17:42:45 +0000
Date:   Mon, 27 Sep 2021 14:42:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Message-ID: <20210927174243.GA1535288@nvidia.com>
References: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
X-ClientProxiedBy: MN2PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::37) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR07CA0027.namprd07.prod.outlook.com (2603:10b6:208:1a0::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend Transport; Mon, 27 Sep 2021 17:42:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mUueJ-006RPN-8s; Mon, 27 Sep 2021 14:42:43 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86308d9c-b86f-430b-15ca-08d981de36e7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128AF18DC865D32972E817BC2A79@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orvhXd8vYqpu/aXn/heE/Xau1g/mete2sTX1mXiLrW3Z4ORCkLDi53958oY6fyj2vVwPeTyO5XMAKP8uCNeVlnoplxD+2Ni9DEZOzn19bZvAFVF3VQpL6xjgL9lip2D3WjzrzOqyH888EzIfGNsP2I2Ilbdo47GxeIXRxzprS7MSIZrUYxhUTPMgj6jJznae05tXKOcfumffmqFX2uyR+JuSjwC9kQK6A5NJVvbv8VZDmcZRlS8BVAERgj1Z0z4Jb+rB6mAxK2dmv2loHbyMGc9dRCjx66h+afubhgKkqladIZ12TveeNvv3h9LJP51hHDXd5gOOtuwxa0gOD+nU8Vtkl6gr3ZOf4vhz0vW9vmqA1l3zRXAcRndSFL0BQazeZDM37f+hE/74hIIymSdW/HH/vZrPGFlJzJY8wNQLou1hoKE4bBMsBFC5yt3TP3Lim6cfSUoA+J66RFkW4CpvCTzhzb7L58PEWvkl5H59NcwGYq8RXxzti9pEzJ0CkB/nKIX58DChPGQXk7j8xYNy08NtzjqSRXoc/z8DtF93BuLbEm5xCBmrg7IM7QtQbflyWDFamslYe3ilb1OJCopJlj821Hu1wqb9f+xQn0BEfZbuztwFaEKfwswT+gmnYILtRntEY/cnYKG0K0JUwIpB6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(2616005)(426003)(36756003)(83380400001)(2906002)(4744005)(316002)(1076003)(508600001)(4326008)(6916009)(186003)(86362001)(38100700002)(66476007)(9746002)(9786002)(66946007)(66556008)(8936002)(5660300002)(26005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YnXGLBHWvxxxeGP0Mydm+t30H+5hPt211yic1+EUisv3PQtyL6+EUUdz3CRX?=
 =?us-ascii?Q?rrN8XPMcagObtinen2hZ8WpBKKXCGYdlAo9GXbhhw+HjuXOfaWkI1UC9Tw23?=
 =?us-ascii?Q?dqvCyWAYz0jWPYs5+dDfkIAe+EpyjG7SfT/BWQoYE2rkZtWDWKZBWhy09uoO?=
 =?us-ascii?Q?kGpZIFrj3h1gUg+wLWyWYzORYguT5igEQk+rHRPgSGOlQUkLUMyaVoah2wHt?=
 =?us-ascii?Q?CsA7h9X1ytfikyYtiV4l+5V2Ggbrbe4katZdzsO9pzHwiPQXof9iREYQ/Cnx?=
 =?us-ascii?Q?w5hKbU2eSOkzce4mY3/Z/KqaajX0bs1e5V9Hn02092wPYL1xuvxn3rHTpMpG?=
 =?us-ascii?Q?k061Tvbrcao8nfoR4+Sfh4y1HmCZfq+lRXlogh9w0GrMryDrT3F5xaEGTqO5?=
 =?us-ascii?Q?txKR/3DmVvkF646A5po8Xerwk9FYkfGkjbO4Vo81BrtLi8xTP+0IMNvVrH4u?=
 =?us-ascii?Q?eAnScVhlXkCHP5dEzw5eElXNBwZWwOc5ITVZAMJsnfHD/vCaJbCIQJnLKeKD?=
 =?us-ascii?Q?3zyZJFcf5TtiYTSCCi6scHT02IJfvJE7AZx6VXX/STNcQtKAmwMWE3jqG8XA?=
 =?us-ascii?Q?dYnR+wKNDd2ke8Yi37QkpXBlF1I1MV7IWv09+1kWMoFzO9qW6Lop11C6uwIm?=
 =?us-ascii?Q?+S43tndIn3/nHovO5ZQ4y19CLybhuEaHas85Syg2MW9YXAVEJJ5ZC7R9t+xT?=
 =?us-ascii?Q?XhAytKOtwEHuXSwwg1eBPsdzKf2TuI2aCHB5ahvoTWRB7jy/CB5gCbM1H9AW?=
 =?us-ascii?Q?uhjmgzpE8nNBHud7GjTt9XE2R63y8SYfBomX2iE7RRBZYdIGhxdy8mhyYNDJ?=
 =?us-ascii?Q?us9XWkMG48Ca6mjM/YUY8CQ549MaVvc0ANi2sRR3IOIp9Y6lxi7QokLhWiA4?=
 =?us-ascii?Q?EmEcXAdUncxa4UuWFoFTQ0y9h7Q9Ct9e9B1uWCRKqq8GoDbjFvK4rraYIQow?=
 =?us-ascii?Q?yp6a8fT3k6uE4ubvM8JAblAh5UjxgAY3B+Bcmt7McGorx1y4bCHtLpqtycQZ?=
 =?us-ascii?Q?IipvIVw0zAQAfA5VMNNxGIGA4k4PhAgCjF26FdCkH0MqClHHdddJe2PwZEva?=
 =?us-ascii?Q?47mpzKK88K9NO3e4ihzfmoDGVIlz/DqBfsnpNiLpYgzMJWNWdOSvAJ4Y+4ke?=
 =?us-ascii?Q?A0IbrrHB3z1YP2KnS+r9nMij+6/0w1jClVJEzRb0iolarzxN5SGQjI0SCs+b?=
 =?us-ascii?Q?KFyeM8Clort4GIz0XEBOUED9CLtCet+4BvlIQPHjho6LbVGR7fpBdWSwH+TB?=
 =?us-ascii?Q?mnXDqWul0EMzMf9WJQ8KPVRRsWIavVCzUOLxqtfj5liern7waimpd8vMNhuA?=
 =?us-ascii?Q?I8sfYAOgHzrDJcF5lKn1nJyA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86308d9c-b86f-430b-15ca-08d981de36e7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 17:42:45.6857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkP9zEaYssjz8Or7oDXMw/FO0g80CXZbadY6+WxI+EdUOe5/P3neIOZmoLEEMGyB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 22, 2021 at 09:48:57PM +0800, Guo Zhi wrote:
> Pointers should be printed with %p or %px rather than
> cast to (unsigned long long) and printed with %llx.
> Change %llx to %p to print the pointer.
> 
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> Acked-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi1/ipoib_tx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to for-rc with a fixes line

Jason
