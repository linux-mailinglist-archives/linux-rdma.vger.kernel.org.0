Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2326D16C1EA
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 14:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgBYNQp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 08:16:45 -0500
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:11575
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729386AbgBYNQp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Feb 2020 08:16:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cm1NZot9OOJZ/jq98cME9LPqd/0LRubqQaPOedzfbl0/BWMIXV/IRdJrp6fO0deaHuPhI3nZ3w3/ctODdnm9+Fy6iNARtPT0t3KNaCEG5l86oUSMHTYjjLFiJ890Fjae1nDbIRnVqcaBs0Bs+ShJNSTG7K9cUzetVy+2ZZntz/9INE4HhDSTaGEKruPflXcIHqWDzcjoQagtZv04tR/vy2vPMCU6Tp6nf+E1rmI/3ZjA2IHdGxgKCeasuQBvDkrgOh0KyMt7DG5PYTC01sH4VUTs5HvJIcXDDRsp1JGILe7cdKUbmIqeeDZwziKPyiCft9nPHRyDuZ9Jrzmh07e15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgJLKx8e/ncDVLnZOY1KR0Bn+czuWT6/LlrInrBMoeM=;
 b=Yvt/sdPyFzOwBiuWfxLPRaNlu5hU+zdFEMHo48LbfHjT2MzJUJxFp7F/NPxXOz5mRRWR4RHVzPViyGcUyEaEs6Dlllgg2RcRqg86fUX2dp/HzqgKtD56XqSHs79GIjFbzgfZZqSOra9MiS4/nWDbCcNUTM8ZAsqIkaf4FkkV6EccBzIYKci2p36Gw2fWdOThcXBBOFTwyQeNNZvIWkX9mDiEuBe7ddY+KQ/D5ePYohz1vCNToUluV4MHH/9w+f4Ff5eXhJv65svE3cg7lkbhnMgkS0HWPEfOQCMiCUU7/rF2Zm0ngbBcYUhQqqlGwcPZz05b1ri/RPA6m2dyn7F43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgJLKx8e/ncDVLnZOY1KR0Bn+czuWT6/LlrInrBMoeM=;
 b=Q9rQtewo1agQUAXw9g+KArRBz+aLCGswllNombzv8SKDaLhiMyb7d2K5+k4+2JiGL9oZzgGDwPNhzTsEf8nOXQUdNRKsN+ajyDPEt2hYaMvy4yLS1zBU8coDlGX4V5rJKnk0O/O+jclkcbT0EqoF4CFp0InclANysJq0seZ1+y0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3438.eurprd05.prod.outlook.com (10.170.236.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 13:16:42 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 13:16:42 +0000
Date:   Tue, 25 Feb 2020 09:16:38 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 3/3] RDMA/bnxt_re: Use driver_unregister and
 unregistration API
Message-ID: <20200225131638.GZ26318@mellanox.com>
References: <1582541395-19409-1-git-send-email-selvin.xavier@broadcom.com>
 <1582541395-19409-4-git-send-email-selvin.xavier@broadcom.com>
 <20200224134338.GH26318@mellanox.com>
 <CA+sbYW2-SLiDNY26h7xgbR3+T3rsr5MTCX9QxORtvREa4vJu5w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW2-SLiDNY26h7xgbR3+T3rsr5MTCX9QxORtvREa4vJu5w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:208:23d::19) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR06CA0014.namprd06.prod.outlook.com (2603:10b6:208:23d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 13:16:42 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j6a4k-0004lj-He; Tue, 25 Feb 2020 09:16:38 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b8df0ef8-712f-422d-131e-08d7b9f4f475
X-MS-TrafficTypeDiagnostic: VI1PR05MB3438:
X-Microsoft-Antispam-PRVS: <VI1PR05MB3438E341AD0FD0C492C924F9CFED0@VI1PR05MB3438.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(199004)(189003)(186003)(8676002)(2616005)(66476007)(66556008)(81156014)(8936002)(26005)(9786002)(66946007)(81166006)(9746002)(4744005)(52116002)(1076003)(6916009)(5660300002)(316002)(36756003)(53546011)(86362001)(2906002)(478600001)(33656002)(4326008)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3438;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLV8SjWrvZ3UjxfdmXZO+XixVzZ/u3sAJXH4Q0BtwBKOr+uEUHN1VocnRsfEmmZFZ3ZqpDlvz+YX8WZmv3IX3x2hkuBaGJSYxGfbMo4RTP1PVU2PewjgB04YyS5VPRcFrD2XM4684fG95MvPfEZJtKDnTwHiM3vr92nlZGzbJz8QZzrKt+BN56WJ8rMENtHLgLuQQ0tpds6gvXSJukMdrLUn7ZqqmxE4s/5FDWhZPs0+0xTz4Miu2CAAHwm06o1HSRDku54Kb0jvFQsbSGlf+U4ugQCJt/GPkeIjJvk2kmbVtlU79a/7sm2zUNpijoxs1585spTLmiv1Pdy7oLkRzHXqpqXy+P63FuZX29a7knyuTSDdoiMwWsvzKj4mqeLMmfzmG/MQwozuuInh86X66qT1ilTONAG0QF6pcCPicy/OsucNRDJdjVfyHYhzLiX86yeI9y8ccUK4yO+VCeOf/hH4hkLedHZeJ3I1zvtzBJhmfnjyQtdSfEM7ZkvT0F+V
X-MS-Exchange-AntiSpam-MessageData: TC4BYPfeFtrsYCxM1r8MDJQdvRct3RBtkUOl3kjO0ZZuedqHCwy7wpUKEQxE/0cYDe9z26wiJfWH8sSER2tjGuCMK7NPM9LTfolN9d93nHDROz793P9M8ELkPERRwrez6Jpnvmi/HuwcigUEz0RJHw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8df0ef8-712f-422d-131e-08d7b9f4f475
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 13:16:42.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2q3pEmIVpE2NcqdthIl5Nium4kOk+slAqd/cO9d7sh7abQbIpSAafwP1MXzSlj+hhC1E0Dow6j37+4bVCoo6lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3438
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 25, 2020 at 09:40:42AM +0530, Selvin Xavier wrote:
> On Mon, Feb 24, 2020 at 7:13 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > On Mon, Feb 24, 2020 at 02:49:55AM -0800, Selvin Xavier wrote:
> > >
> > > @@ -1785,32 +1777,23 @@ static int __init bnxt_re_mod_init(void)
> > >
> > >  static void __exit bnxt_re_mod_exit(void)
> > >  {
> > > -     struct bnxt_re_dev *rdev, *next;
> > > -     LIST_HEAD(to_be_deleted);
> > > +     struct bnxt_re_dev *rdev;
> > >
> > > +     flush_workqueue(bnxt_re_wq);
> >
> > What is this for? Usually flushing a work queue before preventing new
> > work from queueing (ie via unregister) is racy.
> To flush out any netdev events scheduled to be handled by
> bnxt_re_task. Mainly to wait for
> case where we are in the middle of NETDEV_REGISTER event handled from
> bnxt_re_task.

Then the netdev notifer should be unregistered before doing the flush.

Jason
