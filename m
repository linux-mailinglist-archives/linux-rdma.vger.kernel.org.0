Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC25418B865
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 14:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgCSNyD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 09:54:03 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:45478
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727180AbgCSNyD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 09:54:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjZzcj+TqZb9GcVNfGaXbrLjC1V+c3Kpwwiqtmc0XKJjA4HoTYYCm/TMaKjKvloUAG7kyD+FMybBercngbOaw446PnSEEf0NAs5JeB+2qqhwB2eH8Tnq5Q/0zAMO+KOMNbYPq9HcOe/NGKvTMJ5ebzJN7n1PkfvF5D0rgx56XJAqlPvx6JfqyVOXW1axQM02INTs/hvR4ZrWujhzzMrElbPgLCIDDR+vGDNXrDCqfw4ZRizh4qgG/ExfIeePIxXQPFkkKp+PQq4LNJoeVTaVGQxD9c7UaQ7jCfQ2Q1UfoS7MSu82NwbCxeHflWqiIUziPR2sWzH8mkGocGgy+wH6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4rCbFSeHaAhrILgIORU7FJ6Ux83uyJHyHnKjNx1xnA=;
 b=ZXYa9d7r8Nav8YNWWvJB6uZMyLF51AaplRTL6c3nwKmvsHxqRfo82oCEBx/KuHQwE35a00dgoCMhfQeZDsewpNrxwwj1ijVRWnkidVewRVhuEN+3rI5/uPlWrMeipuFBhBp5hNv5C5vJg4h/R3X7+tz4DO7U/0xxgtCn5J8pQJeffN+zgGRyO/pSygp0iaH9Y80386EFoYnNAzzIsBDWR5LL7gbW54rDCIcDM4CVf1z4LCPGte98YxX6C8Yi+Pc6caEo5IY+qHp2Hd3L01/2I0Y8VJPyeZdw9eVzR22L0d7TpiWuldqJw+OQmmZnUcDkj26wCNXeer38Qi4u9zk3pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4rCbFSeHaAhrILgIORU7FJ6Ux83uyJHyHnKjNx1xnA=;
 b=iavV5eIaRUORe2KRjaxOIc4F8UH00idwlXKbm181s+3MOoZYVKbiiftPnhp57Kysn6pAIMqHNcMhWZAlcVki8eN7Y+zPhiTkP8yKIAKRLmxIa/VtmRFrrOva26brZa4buNCv9GN617zoT4WreGZTIw85fjcihz988HPtuRAOyOo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6382.eurprd05.prod.outlook.com (20.179.27.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Thu, 19 Mar 2020 13:54:00 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2814.025; Thu, 19 Mar 2020
 13:54:00 +0000
Date:   Thu, 19 Mar 2020 10:53:56 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, linux-rdma@vger.kernel.org, kbusch@kernel.org,
        leonro@mellanox.com, dledford@redhat.com, idanb@mellanox.com,
        shlomin@mellanox.com, oren@mellanox.com, vladimirk@mellanox.com,
        rgirase@redhat.com
Subject: Re: [PATCH v2 3/5] nvmet-rdma: use SRQ per completion vector
Message-ID: <20200319135356.GZ13183@mellanox.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-4-maxg@mellanox.com>
 <d72e0312-1dfd-460e-bc83-49699d86dd64@acm.org>
 <5623419a-39e6-6090-4ae2-d4725a8b9740@mellanox.com>
 <20200319115654.GV13183@mellanox.com>
 <0b11c26f-d3de-faf5-5609-c290ea46ed9c@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b11c26f-d3de-faf5-5609-c290ea46ed9c@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:c0::24) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:c0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.11 via Frontend Transport; Thu, 19 Mar 2020 13:53:59 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jEvcS-0006YX-O5; Thu, 19 Mar 2020 10:53:56 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d810e7b3-2b44-4a13-c1c7-08d7cc0cf9cc
X-MS-TrafficTypeDiagnostic: VI1PR05MB6382:|VI1PR05MB6382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB63828EA77783173E5216A063CFF40@VI1PR05MB6382.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(199004)(4326008)(66946007)(66476007)(9786002)(6862004)(9746002)(478600001)(558084003)(26005)(186003)(52116002)(2616005)(1076003)(2906002)(6636002)(86362001)(81166006)(5660300002)(33656002)(37006003)(81156014)(316002)(66556008)(8676002)(36756003)(8936002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6382;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ecRMMB59QTHK7/JwA6NpD9T+pRQlWyaISc4B230EDVLjQFiB4dmXEvIoBRRuhK+9HGUmK6tgfVxeAUQpS/cFp0pOT6SIVRVG/XF5Grv/hbJTFFW7BNmS07HM7+jlK90FkbkXfXNgyv7CAkXfDwSK3B04Oz5JJJoFFzIBwwxQ5/HOn0PTeGKbxIB7U88laiuNH5RUgtmPKDThvswTYVqKsnjM4mMYg908XCvlOHNDZbMEaqhj8C19P0LgM1XUhjnTGYdotqgRHoU9eSRdAInlZB4teR7+MufY2Vb8BA9oUeSAHodwPVPB5Nt0RoeyE+T02Gydl66O2sXGf2IxsPGtgtY2dUFIKNZjsubuv50lMPS/6URiFow3qOTk32N7IeghhLIYBbxfd+YerbmFxAYa2xWl6qnWgPdwO2lRwwWnIB2oLbv5l0KTGn3k00kLdYPZW33Vf7hytTkIXkdSfAK4QgxVLuxf9ScMO9hulis9TGg0chCPVi4RBskCmIF6+vB
X-MS-Exchange-AntiSpam-MessageData: ea7UjBS5zHF4WR0ONRye884+UfHCWf+RRWM6IDtYeFUV9wnYLgiijpfHRp1+M/usrfM3SCY8Zw/ibX8CCET8DlmZL7ncSomAToHlOsL75S4fghhpvj/X8OQNEzGEFVjMaxHOifNUqoUZCTHDUy08pA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d810e7b3-2b44-4a13-c1c7-08d7cc0cf9cc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 13:54:00.0792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUv6w1AAjl3QJBlUVyKflrM/y77ahqw0BxLQdnYSdMCYL4bjs/GWeIJjFjW59fqCDp0i6xEZNyS3szOwz+0JCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6382
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 19, 2020 at 02:48:20PM +0200, Max Gurtovoy wrote:

> Nevertheless, this situation is better from the current SRQ per HCA
> implementation.

nvme/srp/etc already use srq? I see it in the target but not initiator?

Just worried about breaking some weird target somewhere

Jason
