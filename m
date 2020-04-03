Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B95A919DE4A
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2020 20:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgDCS5S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Apr 2020 14:57:18 -0400
Received: from mail-db8eur05on2056.outbound.protection.outlook.com ([40.107.20.56]:6168
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727989AbgDCS5S (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 Apr 2020 14:57:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvUftMy9X092yul7/1rxULOTflr7UWDHn2I96hI6BfJG/hSHF/AKIR2yNeNx6z4NLd67Bi98ZpqkLvi12OnOUkIyQNBmqEwyyIdTT2I4obQhKXqZp8q2kEXtv7SmEc7mDcWIkkTgtaEPrT9ScVRqGcniXeIw+Uzf8go7TigMo5/xmN/NGvgtiT0pe0Ka6gflBarJ7xw7PUGOPy32TZqJGirEWneOZbw/KWagpy712DSsT5fCMDu33y8Nw2CfMKpgRNVyK6ldcT02BJ2IF9JfBgZLjV19rBknCEhF7yCTpS0CEJviG4E4ou5JCageaIfJAzGsTc6mP7j1J47MApykUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U48ZUCAYtNTAlY0Mk+m/KgacxiYUCC/z1eVJzReqjLY=;
 b=cVbxRdYO8iw/PJBR9M4n3vPwaqK6sc20r75UlTM6RNWkY5KFiMio6Dknoqm6YHN2wyCOQBrkFpNw9IE3SHDjzAU//tyHMDgHFC7fpblTbful4PokVizl61AV74YPvA8UZyu7A8RZAqNzugUdBPGD4mybNWTJ+xS65ZoU6SXOL+x9EunW7hyHL0zg0Ma7DkDbXUELRkP2u+D6/DoIZ9uJ+kk73FrzyFc9lDes+tmOWfm7n/MrsizwQb77iuKYJg9Wt0YcWt7I8ZsqY5JQK1cQt4LBpMmZxm9bPLBrKpZMfXXtG8H5leLIcyMrmvcxfUDeGOex/R5jfeJRfUNfn5lFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U48ZUCAYtNTAlY0Mk+m/KgacxiYUCC/z1eVJzReqjLY=;
 b=XMlPIYvAxOQa5IrF4SANNuIwO1PIcAyPrOlBMW48R49o7qD9UZ6HdShjxF3VkVGFMcMqHSFIjWMvkHgPx4MsMduIT4I6KE7hUzsD6Vy92iZE1ixzHNXLDuDYxvcVBmT0+9d6/b/YWOE6vZ2skEAYzBrg6m0nsYSVix5C1990jII=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB5631.eurprd05.prod.outlook.com (2603:10a6:803:d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Fri, 3 Apr
 2020 18:57:15 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 18:57:15 +0000
Date:   Fri, 3 Apr 2020 15:57:07 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        syzbot+69226cc89d87fd4f8f40@syzkaller.appspotmail.com
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        george.kennedy@oracle.com
Subject: Re: [PATCH for-rc] RDMA/cma: fix race between addr_handler and
 resolve_route
Message-ID: <20200403185707.GE8514@mellanox.com>
References: <20200403184328.1154929-1-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200403184328.1154929-1-haakon.bugge@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:208:91::16) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:91::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.5 via Frontend Transport; Fri, 3 Apr 2020 18:57:14 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jKRV5-0000el-9n; Fri, 03 Apr 2020 15:57:07 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41788fcb-68fd-433f-aa26-08d7d800d315
X-MS-TrafficTypeDiagnostic: VI1PR05MB5631:
X-Microsoft-Antispam-PRVS: <VI1PR05MB5631A4D96B314D5A48AE6AF8CFC70@VI1PR05MB5631.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(9746002)(9786002)(66574012)(1076003)(81156014)(2616005)(4744005)(52116002)(36756003)(81166006)(66476007)(66946007)(86362001)(8676002)(8936002)(33656002)(66556008)(186003)(4326008)(478600001)(2906002)(5660300002)(26005)(316002)(24400500001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+1S+Ks+YD+lRyyadwq6PBqh3Mt9BN77nD7awR7r3H0ZLR1Rllu9b5ogAal1aSKlfZgSA0kZkNKyvfLzfUp1RrT1Fn0yJlwwkyAeRVoBtHyOnOnLuMn07ykZwsflUhZrf2vmDvG8r4kGA3Pf5+4NpVj55NAVR+kRICPnifb8qnhqite3noIfxKzX8Eb2JR1LpFnH+q17p+RWA+x/KJ12n+ISy8QM5VVQXcpTMYB1jBy/XYqgaeVar3W7BiC/us60UpXg7YRHZixtsE+YynfVMWGjMuF52YdHe4aeRdof4ZtLAHUct6a/Bz9/A67YhtzuihI+4jb4iYrLPaPzgzNmflBFFmoUzfzv3EtQSnDdfVIxUmRb4T1Z07L3658cLGf6cnnw938QBOurWpwdTEjgP6eJ9Ic0/BJhov1m/OIbfXOAQZscbjYzsopP28xrxniOBPRvdvktISwcqQl61gDcRdSeaeVB9rxMVXvh53mG6Z6DTeAxlG2U7J/0rcLgPhFo
X-MS-Exchange-AntiSpam-MessageData: CIog/beaycfAVl3fezsWOOlBt/SZo7gHb2SqUJTlpB99WDyBE6by9MMtGHxZjalmvG+L72TyPHFhsbGRLPaCN65im3/yU11Es4z4olOqP5eQs5aTr8hZmh2QvJVFOZ28l5DW09MezLNkuYZxhakHtQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41788fcb-68fd-433f-aa26-08d7d800d315
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 18:57:15.1954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZiRfuqLukZruyJmFP7bt9qibAu7i0HmZ2BYYuJMh0wHcG1I+ELnm+RNOdqPKjx12t4NvTuG3FFyrko8+naV63A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5631
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 03, 2020 at 08:43:28PM +0200, Håkon Bugge wrote:
> A syzkaller test hits a NULL pointer dereference in
> rdma_resolve_route():

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next

This commit in 5.7 probably fixes this:

commit 7c11910783a1ea17e88777552ef146cace607b3c
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Tue Feb 18 15:45:38 2020 -0400

    RDMA/ucma: Put a lock around every call to the rdma_cm layer


Lets find out.

Jason
