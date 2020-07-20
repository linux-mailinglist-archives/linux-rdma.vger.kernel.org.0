Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993E3226214
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 16:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgGTO2C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 10:28:02 -0400
Received: from mail-db8eur05on2075.outbound.protection.outlook.com ([40.107.20.75]:56096
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726458AbgGTO2C (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jul 2020 10:28:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAUqJygyLpT7DTPWvpMkRHRZrVwe/8ruCBr6rmGBmrnWo3DPxLKMbYk9x/Nllh8mPDuHLD+jLB5qeIV7r+L+jeb0E5aNyp81LgdbS7BYD1A83mYlyo1JHltfRRe8Qfb4Cnvsme9Igs2l1Twm2iZwMCoC19wF3e14JV+K63LofUVp8LAY/wAj0qQeeaqzS44Xc72xsDMWQnMTVh1tOPEFVI4FNDCiHt4jXoAg26P5H8Ktqs6QPZT9vxhRYR/F/yRHzcUN1EZwN97VtB241SMKwYom8LMIB9zRAv61IfkkhftYj7RLbq/GFjsaEEquTp0LNgJ/OLNNBrHvuSZeUWSwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+Xn04JdUcubIKkUR7pSSjAUDaWzYf2mRteBM+/TiNs=;
 b=HazYJfsu7H7Q+rRHI3XAM2dfwMcfPEMNsjmznW3I/p2VCRkWNMHAdhhKs77nE/AgAtXDySgmspJYZSyqTri4U6l6g47Q4CJK+8kmk2gttXdC/++EoU/0i8JR5muIKwmPkxKEFbqrpmY/9+ru3XUVTR6SEOu81MRth6/8z84/7Z7ircqfpL0p+c/j9KSIHOQWr/oUr3favx1liiCs9zG8QBGy2ig26XOIjw7i79h7BztTWX9n1dkO+m0faPKnXdZWidqi9HcvEZJ6aehF1fLS6KYMuKesBPbISq8XVPL3X1o+TX04D+Q+44nWGvPyGopD/OmDTkK2ZbugUuqpimU0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+Xn04JdUcubIKkUR7pSSjAUDaWzYf2mRteBM+/TiNs=;
 b=D27WywcrSZVK38Yo7sQAv0+1A8OANNHneCuwIdkC2PtN5nG00ZWG/lZA6y5S5LILxZFJaeEDWuo3fqN5BwC7rFK/eFt7VucYR5nlmMID5EDWB/RabJJtYkjU0CSrHz1id4BqCsgx6ACWj68X5cCtOLgNLxQOD5lrm7W5/s8Ti1Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6141.eurprd05.prod.outlook.com (2603:10a6:803:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 14:27:59 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::252e:52c7:170b:35d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::252e:52c7:170b:35d%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 14:27:59 +0000
Date:   Mon, 20 Jul 2020 11:27:55 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Gal Pressman <galpress@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        kernel test robot <lkp@intel.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/2] RDMA/uverbs: Remove redundant assignments
Message-ID: <20200720142755.GL2021248@mellanox.com>
References: <20200719060319.77603-1-leon@kernel.org>
 <20200719060319.77603-2-leon@kernel.org>
 <ea42d404-45eb-ec83-b42a-4a3acf659d26@amazon.com>
 <20200719132733.GE127306@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719132733.GE127306@unreal>
X-ClientProxiedBy: MN2PR22CA0023.namprd22.prod.outlook.com
 (2603:10b6:208:238::28) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR22CA0023.namprd22.prod.outlook.com (2603:10b6:208:238::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 14:27:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@mellanox.com>)      id 1jxWln-00CayN-R8; Mon, 20 Jul 2020 11:27:55 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0252cc1c-5989-418c-d708-08d82cb919d7
X-MS-TrafficTypeDiagnostic: VI1PR05MB6141:
X-Microsoft-Antispam-PRVS: <VI1PR05MB61416F0155AC22DF0D62F274CF7B0@VI1PR05MB6141.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUZPdhrdBRznGycvh3rig+NOJu8zk3uWdXAaXb1c9U4OVGDOaCYmeIpDLN0YIgNMVkp/DeqU2REEeVqQu1Hejs9wSBqrOi4qbmGL4M+5js/dpb4ZEPdSBa9lhNUPNUrLHGpBWKZmA2ifYFAQyCJ5QKkVG4wyotN55oPo53aL8Cj/cL31/m0SCj25EqSIadSAzj3wv3XpRA/FRC5bRK5pVuNAWhK5FOp4vRiRCLWg8CjP40/5rce+2xyCzuRwdkl1aClPfOw9DUyKbnUOf0Ne78mtiVuRNqVkjkyMhwsSoilUhkmuwKXwAfnE6mI4FUE50NAyITay2kvPPbbfnIU9dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(316002)(426003)(9786002)(83380400001)(186003)(4326008)(54906003)(33656002)(2616005)(1076003)(8676002)(9746002)(5660300002)(66946007)(66556008)(26005)(8936002)(6916009)(478600001)(2906002)(36756003)(53546011)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8HF5MJGt+V/6NcBrAfcfIT0Eq9pNdWoy9pMBOwVe9GQV6ntS/tt3j5DefrXr1AO6RPCnWAnrFg3EI5eIQPqx/G4COKKw8WK2dx1hkbEkL0pxm0XgPgmP86v8MPI47iC18yD8PK5fPYzzkzojWikqUub96qIP5O80YaIi/S7lf0yDS9EsQb/15FNL+fy4CDPgsD3Z4Z4aqo52f0zzcf+EWbyi9Enmq7KM96xafX7p1g8FtUJqIGeXIHKQl4Hr95KzpLTiFMwMQaSusslDkxe11uzkwQkZPNgHuZwTisqgBDu4+fAy6i23iFCNu+QgArAzfAgGWx+aGg2aGd0KySIWGnW5uVlHIq8FTsm+n6L6QV6vYEIQPsGme7yfuiSlTfI1q3oZjpPDsWByUU1MEcN+wcQFegnOJ7gfT72DQkZxGgcz2eZV8irwfEgD9nqtjPOyRhCo/oj4GJURRXuftafSCt/BAoogWHTNaO14KRlqomo=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0252cc1c-5989-418c-d708-08d82cb919d7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 14:27:58.9561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1/zYpshrw5bQ9srDphWZRy8A094PjQUy0ls4pWhcS+WE6Ip/MprLQ6q77W3OGywMz4H0ukX6/Rfu6h74caEEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6141
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 19, 2020 at 04:27:33PM +0300, Leon Romanovsky wrote:
> On Sun, Jul 19, 2020 at 04:21:04PM +0300, Gal Pressman wrote:
> > On 19/07/2020 9:03, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@mellanox.com>
> > >
> > > The kbuild reported the following warning, so clean whole uverbs_cmd.c file.
> > >
> > >    drivers/infiniband/core/uverbs_cmd.c:1066:6: warning: Variable 'ret'
> > > is reassigned a value before the old one has
> > > been used. [redundantAssignment]
> > >     ret = uverbs_request(attrs, &cmd, sizeof(cmd));
> > >         ^
> > >    drivers/infiniband/core/uverbs_cmd.c:1064:0: note: Variable 'ret' is
> > > reassigned a value before the old one has been
> > > used.
> > >     int    ret = -EINVAL;
> > >    ^
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >  drivers/infiniband/core/uverbs_cmd.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> > > index a66fc3e37a74..7d2b4258f573 100644
> > > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > > @@ -558,9 +558,9 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
> > >  	struct ib_uverbs_open_xrcd	cmd;
> > >  	struct ib_uxrcd_object         *obj;
> > >  	struct ib_xrcd                 *xrcd = NULL;
> > > -	struct fd			f = {NULL, 0};
> > > +	struct fd f = {};
> > >  	struct inode                   *inode = NULL;
> > > -	int				ret = 0;
> > > +	int ret;
> > >  	int				new_xrcd = 0;
> > >  	struct ib_device *ib_dev;
> >
> > I don't mind removing the whitespace, but changing it for just some of the
> > variables makes it harder to read the code IMO.
> 
> I wanted to remove for all variables in the same patch but was afraid to hear
> opposition and waste my time on redoing it.
> 
> Once we decide that this should be done, we will change. It will take less than
> ten seconds with clang-formatter.

It has been something that is going on slowly, I'm not sure a big
reformatting is a good idea, it really messes up backporting

Maybe these changes could be moved to the end so it is more readable?

Jason
