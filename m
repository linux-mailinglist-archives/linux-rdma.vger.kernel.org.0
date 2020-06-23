Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6188D2058B2
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 19:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbgFWReM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 13:34:12 -0400
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:38133
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732408AbgFWReM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 13:34:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTjN6gmJu65rvhUEgFEOqODrllT/2ON7TkRO9SwzaYE+3cr8fNQ9WoZ8ycAxaAZZEiKIOzi9aFepdWWMSY61GzsWkWNALmecRWAqYtt+rdiI97BmGwR0dToqrEB8Yzzzz4l3Hko5bRHIAahcnSYpa4xkgc1/+ZnKMU8AhmzXTrowH9AVvJzgjDBLULQP5skCURkoL4rLYv8xP+ybcjotYQwWoqug5ZC3tFrOrqR4C3RnBYihrrfAufT4FJTvvh4I33mi62+Hw+RX4CZo2Cxz5vvZiFtU1tbd8pSMalsO8gEYgfaQ5fjtEMGEg9flfG5B5hD0qLQaptuxi1B4uaAfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/14k7nZHDDdPakx9vJmWG34ULtRrwWj2SCsqtpkuuA=;
 b=ALj0n6lZH2C1Amjbg60wsml0tmFtRFwBxmZBr9s9SeJDqmtauRXBwyv8KdZX1uNN0RtTVx/3Me8IMgahV/1QDSN0fQkPD0MyKqsF4SP+0qxpWHSyp17cQRam2PHG73UsDLA5CoydGjXx2giNQ0CDd+a+XbQevoGsG4tCpt1NsJMGfZU+kur3WTqgkcXvAC7NQ7ZRx1oteOCzHCEmuthnH5sySyW4gWgJI9s6rwykVZ+ubBhmy9qS6LFihlG1SInDPbF+gpTub7s0WiKcDWFplLuEF4N069XUreXkUM4oSAn9M7brlx1bwKY8QzHYAxaTtymxyB3dchEogNNmNchyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/14k7nZHDDdPakx9vJmWG34ULtRrwWj2SCsqtpkuuA=;
 b=LX9fHSVkDYO5v4q374JPuKqAU4xxG6eBd5QRO3C+DN7oXIVERXPaR/DA/u6MDADYhi3hRKdtEoH5P08u/9ltyNLJDphn/nPctUtINs/vvlX26q66k5PRRVFCs5G28dI9ugs9w8HnpGBcazSe+IS9gFghmbML4+2Wo1NmujeFBmI=
Authentication-Results: dev.mellanox.co.il; dkim=none (message not signed)
 header.d=none;dev.mellanox.co.il; dmarc=none action=none
 header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB4605.eurprd05.prod.outlook.com (2603:10a6:802:61::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 17:34:09 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3131.020; Tue, 23 Jun 2020
 17:34:09 +0000
Date:   Tue, 23 Jun 2020 14:34:01 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yishai Hadas <yishaih@dev.mellanox.co.il>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        maorg@mellanox.com
Subject: Re: [PATCH rdma-core 04/13] verbs: Handle async FD on an imported
 device
Message-ID: <20200623173401.GL2874652@mellanox.com>
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
 <1592379956-7043-5-git-send-email-yishaih@mellanox.com>
 <20200619123332.GU65026@mellanox.com>
 <778c127c-00c9-9b2d-6c81-a96e51029324@dev.mellanox.co.il>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <778c127c-00c9-9b2d-6c81-a96e51029324@dev.mellanox.co.il>
X-ClientProxiedBy: MN2PR22CA0015.namprd22.prod.outlook.com
 (2603:10b6:208:238::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR22CA0015.namprd22.prod.outlook.com (2603:10b6:208:238::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 17:34:08 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jnmo5-00CyJ9-N8; Tue, 23 Jun 2020 14:34:01 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a4860a64-d25e-49b8-f01d-08d8179ba2b0
X-MS-TrafficTypeDiagnostic: VI1PR05MB4605:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB46055B34809EE5485B81E121CF940@VI1PR05MB4605.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpBr2MZe861vT4EPuZX3X0MKu9APY2vEfKf0JPwyHD4epz+xaiul3Iz2IEB9w0UkNRXuxcOn4eVIYmaErweCf1b8nPbsVNgMVp+XAqkiii1okt3Pz0u2Gz+JQ4kiIw22MbWQPmoNDOHY2PEiw8lfW3ex7Pf6OH8RVjYVE61OI/YO7RqvuhiApqb1cP4SzCjln0xlUgTdh3lY37iWtvB/8frPpIuzoH6cPe4Qq3FCaPCGqgMFgPWkEYHK26acHxuO6ADnojgSanefC2Z7WU5CW0kF19q3Bo5oiXmfXYcL8zuXMHRmLq4uKh+8xNitVayN3og60EbP3X35hARfiR2pHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39850400004)(346002)(376002)(136003)(2906002)(26005)(4326008)(53546011)(186003)(6862004)(107886003)(316002)(478600001)(36756003)(5660300002)(8936002)(1076003)(86362001)(9786002)(2616005)(9746002)(8676002)(33656002)(66556008)(66476007)(426003)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 237FWoVZp+ADr/noWHt4gWyh6TF5105/JYpN70vHDexfp8g1N1kqna/nMl05uBjvkxLrEzEmLi7FHnLDpMs3IkLvvbrSpv/CGM5Dm5dGJXtLy8bHrr3qXi5SfZqbuo0SFTltF2mKeT8g85zGN+XqMnrXHJriY1BsZ7gfFTbU2cqnBOX+76UbPExyhWL6nMj+ji2j752hZcfstRz7An58kyx9oQKnoClIQ05nLZOQmL35F4H+Hylf0JdOGGolMiMsvRqz3AeK+K4r06urm7XsA3qVBjLF8NilgX3jHbj+bIVQDazFlVqSpCMvRdyv5qqMBpnAQHcQhQButB6YayxRhXmoCMToPGP5s6GrHxn7MIrd8MvXrMHGDipwqEehItfMxNK4m+kB+reO9fQ+zjSz2NLmulzSeMvDJT9j/5WS1DKs0Kx5e9/AXE3I88uQFKbqFdYs/rrEQfFjNW1v0rBi4C39D50+lA0G6cIqdH5CqvJNVjv5eYuJr/plKe2ZedqS
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4860a64-d25e-49b8-f01d-08d8179ba2b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 17:34:09.0889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGm9GA2Xsdn98BZW+sb44QBEwmATwrGdDjDpKZoSxVxbVu9eM0X88FXStJzdcLLPE4nekDXLfUb4LKKYBORCvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4605
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 21, 2020 at 12:08:57PM +0300, Yishai Hadas wrote:
> On 6/19/2020 3:33 PM, Jason Gunthorpe wrote:
> > On Wed, Jun 17, 2020 at 10:45:47AM +0300, Yishai Hadas wrote:
> > > @@ -418,7 +427,13 @@ static struct ibv_context *verbs_import_device(int cmd_fd)
> > >   	set_lib_ops(context_ex);
> > > +	context_ex->priv->imported = true;
> > >   	ctx = &context_ex->context;
> > > +	ret = ibv_cmd_alloc_async_fd(ctx);
> > > +	if (ret) {
> > > +		ibv_close_device(ctx);
> > > +		ctx = NULL;
> > > +	}
> > >   out:
> > >   	ibv_free_device_list(dev_list);
> > >   	return ctx;
> > 
> > This hunk should probably be in the prior patch, or ideally the order
> > of these two patches should be swapped.
> > 
> 
> I can swap the order of those two patches as you suggested.
> However, in this case, the first one will be some preparation to force the
> ioctl mode upon an 'imported' flow and only then the second one will
> introduce the 'imported' flow as part of adding ibv_import_device().
> If you are fine with that let's go by that approach.

prep patches are better than having patches with incomplete
functionality

Jason
