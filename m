Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13942189C3F
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 13:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgCRMqF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 08:46:05 -0400
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:63970
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726795AbgCRMqF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 08:46:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORxBgAYGZgXnBhp/zYIxUDcDKXA8JSCHXJk12YyzCSlBwAP7aVFGjtxUt5zi1xADBvfA3Qvz2QIs7OgySU80KE5X/B5PCug/FJ0yuhTXg/B6AH0vmQhRGpMoI+45ZLLUDOy83McLFs9JmqQ4EShfiDkv5KuF73bQTNH6vNIE0aDqu8frlinWvUZJpbcMTVUCRq3BPyNcFiTOPmKrzz17or2fLpuLHjhmtZ+isbFZaL/2t9nZ+YvYDPIOSul8+CeQhB1AR+o74bY1cEKCSAbxJn4Zq0XVdAItRnzTnwDNW+jr14rre4+vIbr1Hp1KgRT+MzZJZzFKgLEbQnpzeChmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/5miTeist+ROXeIz8QfA7wtcoczwuI2BZY4ujGhaNA=;
 b=oXad+MUmGtGt4Z9kfXMHcP+ZYcyoHJJ9bb4mnwEbV0AvzP5L90qCs0Zs+62MAD/pfds/RM2rk3IGci1s0I6VIvfY+62HoPXJlbdHDUuHQFtDbgq4RqSL7ZHjbcvD/EbZuucxMGb1TnLDamjfTEO4seIFVADe8ZmIoSgrAlXPEk6Spjei4jdQEWW6Yc0+4LJr/yC9QU8L/gGdTu9WVvMSaG5lw6sDvcGlK3z8j7Udk7h27uGOZ1l2GI4ggx8HWtaiBJpBBo2u6bu3qeoOtSJnCfJmbr7iID84egKE/7S0yDiTIRPYXGLyttFqGJKPT59Fo3FfCGI2uJkhJomCg62DtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/5miTeist+ROXeIz8QfA7wtcoczwuI2BZY4ujGhaNA=;
 b=L6aqP5u9+5dNzBTE+zJjXOFj6inkMnI0Rw4/jSND+RidSTZ9/rviMjYqSG+y+P6zsVjp9abkg+1CEfejSsydkdm+MKFIDfclVs44hXnZ2YyM4Sd5Gr8sxYmTGg1SfwGHc4XBLC09nU5wlL+k+juf7Ohz1N4ZPp0i8IdmSX8JnbE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6272.eurprd05.prod.outlook.com (20.177.52.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Wed, 18 Mar 2020 12:46:02 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2814.025; Wed, 18 Mar 2020
 12:46:02 +0000
Date:   Wed, 18 Mar 2020 09:45:58 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yishai Hadas <yishaih@dev.mellanox.co.il>
Cc:     Andrew Boyer <aboyer@pensando.io>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, maorg@mellanox.com
Subject: Re: Lockless behavior for CQs in userspace
Message-ID: <20200318124558.GH13183@mellanox.com>
References: <6C1A3349-65B0-4F22-8E82-1BBC22BF8CA2@pensando.io>
 <20200317150057.GJ3351@unreal>
 <F97A8269-872F-4B94-8F03-7A8E26AE0952@pensando.io>
 <20200317195153.GX20941@ziepe.ca>
 <73154a58-8d65-702a-2bf3-1d0197079ed8@dev.mellanox.co.il>
 <20200318114332.GE13183@mellanox.com>
 <49d65148-8915-9a61-383f-1919e0594a8c@dev.mellanox.co.il>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49d65148-8915-9a61-383f-1919e0594a8c@dev.mellanox.co.il>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR18CA0015.namprd18.prod.outlook.com
 (2603:10b6:208:23c::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR18CA0015.namprd18.prod.outlook.com (2603:10b6:208:23c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend Transport; Wed, 18 Mar 2020 12:46:02 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jEY58-0004Jd-NZ; Wed, 18 Mar 2020 09:45:58 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c4f3c88-495a-4511-e8ad-08d7cb3a50e2
X-MS-TrafficTypeDiagnostic: VI1PR05MB6272:|VI1PR05MB6272:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB6272017ED21AECCB6AF44E06CFF70@VI1PR05MB6272.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(36756003)(2906002)(6862004)(66476007)(8936002)(9746002)(86362001)(66556008)(66946007)(54906003)(4326008)(1076003)(107886003)(9786002)(316002)(478600001)(81166006)(81156014)(8676002)(5660300002)(2616005)(53546011)(33656002)(52116002)(26005)(186003)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6272;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6AVyQvyTLxJ+YNExYL6gYD6hCd4SjqMn88CRjMMF3KqK2z/06dIMXiUfFZQcroVQIOKchK2CP+NPsatFnuHW9t9X7SZOS3nUhsKMRTS3+Q5Ow9CPs5jkgC6dj4LIYKdhkmIRfigh2/UdYfRVHkDKqRG63STLT6NjRklnlx+tWrYqIxNznasHcZmq8vVn11jDzGide8t1Z78Ome1Ql6MzVdPYecCrWHpZ0+t1/X8O447Gbj9x12VH6BYiBY9iSl5k/c5BCcJsHYvCwOcNEmzottkimKX2s2Gh5OOG4lt0yX12FtlAdbEtJ6G6mQBK7STRmGtqimfQKY/iuVus+1lU+B6J764IykznlzdmW9YHPgSbM1cwn39MQybtYVcQjmuLSU0coTPYbYxLY0kfkiejQnDc8W7ajTw/gbPQ2E5XFLpF/QcU//aKPK1812EB/WYhv5TPHpQi8KQrj4eq5fBU5JkuADAXoBaKIPpKPe87DqAdcxAbvxe6vPW8gn+0duA
X-MS-Exchange-AntiSpam-MessageData: 5G5DZrwlKkK8vUQfG4kqjuWYA/VSkFvK5TKKuii3wXTQXnayCxb8+h2VnNsGDYTJOrlE20+xuXx9VXXoj1Fnu9MGbvVce1Wh8f/th8fQdUl82asEaQoOpOb35a49QvM6gih564SKLmIBlR21MjGIpw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4f3c88-495a-4511-e8ad-08d7cb3a50e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 12:46:02.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+ekQNM9ZHBUk+7QlE78p3EEJDzjwVZKXS9Q/DthybJ+bJpRNR0wPCQpvCL3yFX5sX+Sh1YjQZtlZMgLIdJcdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6272
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 18, 2020 at 02:36:35PM +0200, Yishai Hadas wrote:
> On 3/18/2020 1:43 PM, Jason Gunthorpe wrote:
> > On Wed, Mar 18, 2020 at 09:52:27AM +0200, Yishai Hadas wrote:
> > 
> > > We can really consider extending the functionality of a parent domain that
> > > was just added for CQ in case it holds a thread domain for this purpose.
> > > However, current code enforces creating a dedicated BF as part of thread
> > > domain unless we extend ibv_alloc_td() to ask only for marking the single
> > > thread functionality.
> > 
> > Doesn't the CQ need a BF too?
> 
> Not really, it uses a per-allocated device one for writing 8 bytes for
> doorbell, applicable only in the arm/events mode.

But this also wastes a BF, if the app is only running a single
lockless TD then the CQ could use the BF from the TD, shared with the
QP and not allocate another one

> > > The existing alternative is or to use the legacy ENV that mentioned above or
> > > to use the ibv_cq_ex functionality which upon its creation gets an explicit
> > > flag for single threaded one (i.e. IBV_CREATE_CQ_ATTR_SINGLE_THREADED).
> > 
> > An apps that don't want the BF can always use
> > IBV_CREATE_CQ_ATTR_SINGLE_THREADED
> > 
> 
> This requires moving to the new polling mechanism where this option is
> really applicable (see a3a31e8dc6a3fbf577dd8b12742d0c70cf63bd29).

cq_ex is pollable the normal way if converted with ibv_cq_ex_to_cq()

It is also a bug if the old env driven lock elimination doesn't trigger
for normal CQ poll if IBV_CREATE_CQ_ATTR_SINGLE_THREADED is specified.

Jason
