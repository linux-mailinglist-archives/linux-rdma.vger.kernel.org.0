Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA26188D65
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 19:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCQSnr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 14:43:47 -0400
Received: from mail-vi1eur05on2078.outbound.protection.outlook.com ([40.107.21.78]:6062
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbgCQSnr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 14:43:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjsdQ9QGPaiSQ/N7DvA763Ag7fG7VM8kskQj52Ay8P/U7bZn6LrlrSppVLDCQcp1JMwHW9W331V0viD7ZZi8Sq0HnM7oXXmYzz3XzjNJBUPweuvrXcQd5K2xgvtCPEyc7a4vXqkBQtgaN/HYSrtI77Ra0vmIEfEm0x8P4al/bcRqAXm7a0NO6IZ8BaPSZQovaRp/fopwgeJK2/AcsRHw1xxT1iOPLX4y5mlyZPP86i41H4ij3lRIHy3iItvNL0PBuXym1NvAoQQOsyTTJr4TAVek6lUpEfwyWhdhfqqvfLgki2e0eXB0V7IgMVYurHRskwtVuljz6YmqNGi0XnQVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roXq8p0SuM/QyIp3uD0RkUTCceIM0ZkgSVK0rpZjuM0=;
 b=JDaqVshqvuic44ISp+rWljZCGwmTFyLk7bDfhoz94Y3jKH3Hp4FfP+ormNatHf6W++HOVc0E69y9pRWNNourC8rbMIvnFZWwaoUBieagTIQvftLhbDj6zFj4fkqyCbZrbwhvr1x9Lnhzwf0iDBTfqnn7EKwQIHU5zavF0+YzDCaij2Zx02yg0smCZ0LgzwQoNzC49whvMaSj00s2CLfD1OA7Yzk+cTtF61gsysVmbJeAregp/z85oc2421qOd6GbY936fc/YuoN8PhPq/dB8r6VVyKSwGtnpsjRzmEH+bc+3tMZuFTsyuQ3WP/NVzYsvfiah1dx9VrFh5qrZOdy8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roXq8p0SuM/QyIp3uD0RkUTCceIM0ZkgSVK0rpZjuM0=;
 b=sFOVPDTWoNwVVqrAStuFlamw3wka1tj1Xc3G1H7+5vAO9N8TPIOsQHl8RtUIZzURy4LizXxTfr6XAudW0KSjM9V9pGOfA8Yps4pol6q4MH0VC2FZSyW0XU+jq+8cjXxkn5Z9V5RYKLTEquYZG0i+w3EZH2YfEsOoV19TIlknLjg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5357.eurprd05.prod.outlook.com (20.178.12.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 18:43:43 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 18:43:43 +0000
Date:   Tue, 17 Mar 2020 15:43:38 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, dledford@redhat.com,
        idanb@mellanox.com, shlomin@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com
Subject: Re: [PATCH 1/5] IB/core: add a simple SRQ set per PD
Message-ID: <20200317184338.GY13183@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-2-maxg@mellanox.com>
 <20200317135518.GG3351@unreal>
 <46bb23ed-2941-2eaa-511a-3d0f3b09a9ed@mellanox.com>
 <20200317181036.GX13183@mellanox.com>
 <290500dc-7a89-2326-2abf-1ab9f613162e@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <290500dc-7a89-2326-2abf-1ab9f613162e@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0106.namprd02.prod.outlook.com
 (2603:10b6:208:51::47) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0106.namprd02.prod.outlook.com (2603:10b6:208:51::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 18:43:42 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jEHBi-00019t-UY; Tue, 17 Mar 2020 15:43:38 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 920091ce-7e2b-4f13-acbf-08d7caa31e02
X-MS-TrafficTypeDiagnostic: VI1PR05MB5357:|VI1PR05MB5357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB535771C249153891EE926D13CFF60@VI1PR05MB5357.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(2906002)(2616005)(33656002)(4326008)(9746002)(9786002)(6636002)(66946007)(478600001)(86362001)(66476007)(66556008)(1076003)(26005)(316002)(186003)(53546011)(36756003)(5660300002)(6862004)(8936002)(37006003)(8676002)(107886003)(52116002)(81156014)(81166006)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5357;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0dUD/j5ZlLWRT2LwzdSQ9mgQ75nuuFVF+4PVSeMQcuVqr7Kfgw2cFYIvd16dgOtxO3LEfWMh5sLxCOnQOneep9vrfDkb0YqbbaaH6EJqQMWgH05g35JxJU4s3nr753CmjkGl9lMb1cashX+QpDrReTJa7VCPdyn0RgcJViT7nW89qx1jPRX1odQWNM5JDB9n9uWDI6YW2VGpAncdJo3rAr0sNSnDcQhKfBhIqCdsyce2cjMq7nTL4IEbjpz0vcFl5yykXjwZVEggFaeHi2aYTdttyjMipJYgdoSnLzAI4MQSme+kU3fz08ILWX2dI+xt5y6tSVlXprXyQ0FJZyAAHLlCsDi6o95fqe3po3CwsZPkKTm6wCxkyGfAbcja8k+VBDxXQYAuIKH1sMDzAOcCX9krt0jMz0GdTlEIUos9/prpbAG7okg/qEPkD5sgv5zd6d0qCCGdeswb1hs3NQTX9doU8nLiEJtjmrVrGHI6Vl3lCzzkuqBEDKBwZNrOHoVE
X-MS-Exchange-AntiSpam-MessageData: /I6Ba9szBRoXTkKBfe0EB37fbfPYzXkgAwPOtPHvoUe/HFo39ZJrad0Kqi7CPdcyLzN4/XDwbmxne7MwfKbMfkyGMADyzgXQe2FCjzPs6BFLQkrMndVd9v48QI6Wv5cxkf26YOe81vxA0OLCj3HtbQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920091ce-7e2b-4f13-acbf-08d7caa31e02
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 18:43:43.0295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8rqfnrSwj62Ede//IM4mWCwWDCMJ2Dm1pkQ9u4m0aNMitRCTs9lQma4/puFClYPDod/u1NFwuJ8K12AdIMPJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5357
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 17, 2020 at 08:24:30PM +0200, Max Gurtovoy wrote:
> 
> On 3/17/2020 8:10 PM, Jason Gunthorpe wrote:
> > On Tue, Mar 17, 2020 at 06:37:57PM +0200, Max Gurtovoy wrote:
> > 
> > > > > +#include <rdma/ib_verbs.h>
> > > > > +
> > > > > +struct ib_srq *rdma_srq_get(struct ib_pd *pd);
> > > > > +void rdma_srq_put(struct ib_pd *pd, struct ib_srq *srq);
> > > > At the end, it is not get/put semantics but more add/remove.
> > > srq = rdma_srq_add ?
> > > 
> > > rdma_srq_remove(pd, srq) ?
> > > 
> > > Doesn't seems right to me.
> > > 
> > > Lets make it simple. For asking a SRQ from the PD set lets use rdma_srq_get
> > > and returning to we'll use rdma_srq_put.
> > Is there reference couting here? get/put should be restricted to
> > refcounting APIs, IMHO.
> 
> I've added a counter (pd->srqs_used) that Leon asked to remove .
> 
> There is no call to kref get/put here.

I didn't look closely, any kind of refcount scheme is reasonable, but
if add is supposed to create a new srq then that isn't 'get'..

> Do you prefer that I'll change it to be array in PD: "struct
> ib_srq           **srqs;" ?

Not particularly..

It actually feels a bit weird, should there be some numa-ness involved
here so that the SRQ with memory on the node that is going to be
polling it is returned?

> And update ib_alloc_pd API to get pd_attrs and allocate the array during PD
> allocation ?

The API is a bit more composable if things can can be done as
following function calls are done that way.. I don't like the giant
multiplexor structs in general

Jason
