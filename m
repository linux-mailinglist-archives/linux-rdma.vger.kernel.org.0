Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003391E12E4
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 18:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389101AbgEYQpc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 12:45:32 -0400
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]:6532
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389108AbgEYQpb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 12:45:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtRRMvWZuCam/bU68Zr6KW5qIYy05DJcQd+sTm+kiqMmkFbdVKx8OR8HyAv8uEzWaQhc+21oKEYyb0NOU5MmEGbkIspsXf8Ww57cTquyv6yov1kWnn6Nfud7vr6gLmMGUA6LPplAXKpOs+cicOzrHipDmM9M8E9yi0g2aJr5e1XBZRXShZ7boBd+PLyaQIg2yUM/mBBnRApOVwqw/1avqxeBOQXU7SrjVVVZm+TD0Pjg4uuzAe/1+nGSzy4A1G8TMoKa9QaWMrKshDWHhqFMvNhNNxzInu84No4UUH2KBEIwdAfD4A8bXWxRpvTor5UJIK9Hw9rRIfNg26abYKLItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pzej4sRDEahXtvtNym1tPU/Tl+tOmQn7iK56dhUGRA=;
 b=g+6pk7/jjmPT7GYVfD/5D7CnfALNseBFeYLZkZPZsTnql6eImvoCV33XADlek97YjBrcdjYVqfAGu4TyGpFf4K7TXUfQ+wVSz+PLV2hRx7wzxqLAVRgUBYUyxDh2i9ItymVvaxXypzEK8e0GV8Hu98+UbchOyInAIt/fKA1leOBfGuRlC1AtkkS2DQyo/lZXL7os2zAO66zI9J3u4OFCpumIJhlleT4JkJ2LGXBSZV68Sk0zUougnEZYNYY2dGFO5T9jM53MbnI+Rxfff1hAhOHSc9ba9Thb+GwB8E6vpatbA0kwHlBE9wx99tEFovvzS+DAlckAYHGUMrOFTOreLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pzej4sRDEahXtvtNym1tPU/Tl+tOmQn7iK56dhUGRA=;
 b=kpxWsaZke1/oJnbZg4LL0phNAKzQQoCg2FVMW/N3rhjS2jFXkJUh+MQESyDc9ZgMOgypDbV0Fbs1ffuemRHsH3vhVXg9UyFzTMmTHiBbrfkRLlai5+2Dj6wnn0VFHoC+yGX5RnvOhps6Ol4+a4XaduDNn7Fv0RMu+I27sW8Uhco=
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB4302.eurprd05.prod.outlook.com (2603:10a6:803:44::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Mon, 25 May
 2020 16:45:26 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 16:45:26 +0000
Date:   Mon, 25 May 2020 13:45:19 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Yamin Friedman <yaminf@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH V3 2/4] RDMA/core: Introduce shared CQ pool API
Message-ID: <20200525164519.GG24561@mellanox.com>
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
 <1589892216-39283-3-git-send-email-yaminf@mellanox.com>
 <dcbddbce-2f30-06a4-383a-c4f41b39f2de@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcbddbce-2f30-06a4-383a-c4f41b39f2de@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0100.namprd02.prod.outlook.com
 (2603:10b6:208:51::41) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by BL0PR02CA0100.namprd02.prod.outlook.com (2603:10b6:208:51::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 16:45:26 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jdGE3-0003OK-Hy; Mon, 25 May 2020 13:45:19 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6bf3e4fd-d252-4a42-6a5e-08d800cb06bb
X-MS-TrafficTypeDiagnostic: VI1PR05MB4302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB43026688FA7699DA57DAF2FCCFB30@VI1PR05MB4302.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDsK6W/sWYdtTz4fYcXL1YjUikrBCDgKV0kVdzpSxdLAXbYfMIvxtORuEdg6A1jB3gucrQuXWsMbisIdWd9lAHhZo9CgjtAfK5WldkHEJ3ezZfVlT7Z82i+M/xBIRQNxWUnPgZhOeT9FDCXJ6evQx43FMsI+q3bHUDU8YR3qKAK64DzPc3RFz1nIGZ8LEiq4Cang9PUm3S8e5oAhWy886xiSedeHtSFXRBdJe7Y4p9PlhoTeydZDYB+RLgfUADLDL8Sd64vBoP6UgcBF7crDEDAHiVdFYI6QrmS074kNyECRXPWf6ouOTcjSYDt/uiQE318hkbj5f8EiJu/kteaPqinxy+Vy/BU0H1WxKt8gLLAOOCinePXCr/dP7mvEh8zd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(316002)(53546011)(1076003)(8936002)(9786002)(9746002)(186003)(478600001)(86362001)(36756003)(52116002)(2906002)(4326008)(33656002)(26005)(6916009)(2616005)(66946007)(5660300002)(66476007)(66556008)(54906003)(8676002)(24400500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: b7ZprApncEi34QHVDCT7Gma8SCj1fKV3MndmF6XA5boMoIaj9dChpALxkDbBfcv8WmtYdMO4oeSxnU2gL6nUVqGZkMQ4teCU8KfMEwLN/xrNL3wCmw9c+JmN/rPKtgTPTuUe+K3ukhjsN/TtCfN8kwvJtPPbeAPBRQQNXdFHZcx1qMF4KWMuh4XtTzy33VflsofAwoZOOWhz1WBjJFoiF0Hu6jNr0HoleRqoelxa7u3humf8A0cJlR376wVe2UCu0MYM2aBlTRAsgzFQiqe2vMFEfcEUmhHG5Ira6HInQqfjOxvi0IDwjLCQN5z9VX+f/TPAsJb8kYKpVLJ3rbCg5Gn/LHjevQOUqkObPT3YcVBiOAG5twgN633VQ7vsEbhrlfpUhsd8FtaftLH4Th3OZ2S8N+J41ItTAUjFvDEXblR5AeFSERKxVo4wVlcGh7+Z2fpeu47E3dLAfMIw5CZRv1rEbyl2z56v3e+6kcPyqGv+YVN4zwujgo7k+VE5BvPf
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf3e4fd-d252-4a42-6a5e-08d800cb06bb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 16:45:26.6330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlDKc9xah9q5lBakQ/yTNMdZacD7b6TvJVdFsLOPBfPUdJyRrKWP/lDwUzqlqGoUTBOj76Dq3mBfkaFy0HtEnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4302
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 08:14:23AM -0700, Bart Van Assche wrote:
> On 2020-05-19 05:43, Yamin Friedman wrote:
> > +	/*
> > +	 * Allocated at least as many CQEs as requested, and otherwise
>            ^^^^^^^^^
>            allocate?
> 
> > +	spin_lock_irqsave(&dev->cq_pools_lock, flags);
> > +	list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
> > +	spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> 
> Please add a WARN_ONCE() or WARN_ON_ONCE() statement that checks that
> poll_ctx >= 1.
> 
> > +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
> > +			     int comp_vector_hint,
> > +			     enum ib_poll_context poll_ctx)
> > +{
> > +	static unsigned int default_comp_vector;
> > +	int vector, ret, num_comp_vectors;
> > +	struct ib_cq *cq, *found = NULL;
> > +	unsigned long flags;
> > +
> > +	if (poll_ctx > ARRAY_SIZE(dev->cq_pools) || poll_ctx == IB_POLL_DIRECT)
> > +		return ERR_PTR(-EINVAL);
> 
> How about changing this into the following?
> 
> 	if ((unsigned)(poll_ctx - 1) >= ARRAY_SIZE(dev->cq_pools))
> 		return ...;
> 
> I think that change will make this code easier to verify.

Yuk also.. It would be alot better to re-order IB_POLL_DIRECT to the
end of the enum and use a IB_POLL_LAST_POOL_TYPE to exclude it
directly.

Jason
