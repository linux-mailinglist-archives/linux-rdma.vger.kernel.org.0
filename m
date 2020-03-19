Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105CB18B2BC
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 12:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCSLyh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 07:54:37 -0400
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:57972
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727195AbgCSLyh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 07:54:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CD20e4LlwmgM/UR6LbOtRcz82W0ESav5yMPGqq+rLoI5YTzsLK+vj3/faCD6kyVaQk0OlfIZMUMMGekM2JP76KGcIG+AOT4piMJAw/OGVl1uJ/koouYdpV3jq1vyGTfAkP+PYFmsRIJKJYFAytOe49XfCYgWJkrB8CmSBhYVKOwZpC5WJ3WCyaqnwWS9oMKLxGPYbAfphN+skIJ3yWKe3VhqSv8KuvzF2FTc2JfA+T3uRLIl8PlMTpiV3z00SRMjZR00QTGTJF+3xINyODrx2vmu9xmhqcHijUgFhkmY8pWcBQsyiWH/OANhMoqu2Ppp7/lVV1ZtlpxWMJV2eI3aHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4zELetwIoPLR2PIVLmlttLQxzwTA8m1LtVPwHBe58Y=;
 b=lX5Vx0qB9El/QYCz5SFT7J2su/+lcCeaxaTG8jGdUU2lMUd/Zj0qoNi+YN3Wa/yy77TYLA5UBXyGzZModzPCddV/q7JhhT+piftQt80uIbaGA0Yq6eOZwK/ytca7dTL1bF5yrdCXXoIQCMJeBeSA59ff/sBynT14U8J2TPEBgoucr9Orfn5amBEkqfIHH06rAmlDPmHyhJ6QYfLBvmVNX6CqYB2Um6MSEfPvNp6IJiEBdtG9FbpKaKcCSC1poyny9DERnmv8GCb391PfBplOOgL8g3vW2Dlbg7zFpkTOjAk5clY/jcrImAuBhMSEMWU2H1sPhVLYOMDFMl3HGCVnCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4zELetwIoPLR2PIVLmlttLQxzwTA8m1LtVPwHBe58Y=;
 b=gtGYuEHPIdbPDSfgq4sPIDo5fTwv/KmBNCitmcFpxV3p0yLpXHipLCyhrm/apE8+h1t5AU0gdN4CjfRpZHBjs5rQsstJZPMB42GvhDjTBZSIkEobLX2cgVeZh2KKRRBUVlgf66qvpXy8JU/BZuP5deKNaBlfIN27c59Risv7ji4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6061.eurprd05.prod.outlook.com (20.178.204.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Thu, 19 Mar 2020 11:54:34 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2814.025; Thu, 19 Mar 2020
 11:54:34 +0000
Date:   Thu, 19 Mar 2020 08:54:31 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, leonro@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, rgirase@redhat.com
Subject: Re: [PATCH v2 2/5] nvmet-rdma: add srq pointer to rdma_cmd
Message-ID: <20200319115431.GU13183@mellanox.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-3-maxg@mellanox.com>
 <20200318233258.GR13183@mellanox.com>
 <1a79f626-c358-2941-4e8e-492f5f7de133@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a79f626-c358-2941-4e8e-492f5f7de133@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:207:3c::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0007.namprd02.prod.outlook.com (2603:10b6:207:3c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22 via Frontend Transport; Thu, 19 Mar 2020 11:54:33 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jEtkt-0004pd-4d; Thu, 19 Mar 2020 08:54:31 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1a55e8f-e148-437d-ed00-08d7cbfc4a87
X-MS-TrafficTypeDiagnostic: VI1PR05MB6061:|VI1PR05MB6061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB6061369AABC7AD1F43186691CFF40@VI1PR05MB6061.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(86362001)(8676002)(1076003)(66946007)(66476007)(66556008)(33656002)(53546011)(9746002)(9786002)(8936002)(26005)(5660300002)(966005)(2906002)(52116002)(36756003)(186003)(478600001)(7416002)(110136005)(81166006)(316002)(81156014)(2616005)(4326008)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6061;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5A/XmGlilKw2HWbCNkFzxUP3UXsOZ3YrK4GZKV07NOZI+/KB/tW3THQ1fCUUiDDGylzOWA7lU0tyLkcfaQ5zc4DMHdrp1VLFIZst3wc1+AJZfwsKxWbzT4pYHMvZpyX6+lHgSClO1qHR5nr9KKmHDCcfgXMS+ghjmuBE8pfziulaNd3a2ZlfVSrMgOo2Up+2it3tAg5kZ1OoCC/xpDDNijgXFmyLNGMM3ZrY3fAHiid+kDNW58Cgajt2dRzysT5jt35BlH8sl+HI+YSQTGPsyttxQA9/uldlamD9R0SMAgULyhHZFRvetRze9lxDkuM7Qp2XBeHZd2wqVg8+O6xH/uIeTAzBsWYPQLWCg7alW8VQVqT0zRwyPYULMrD0xjvVHSQ+nfLmxZYYwJK7Bl3xtuG4L8F8GNahCpKDXr4g3+FK+aLN2osuvptKEft7x1S/7t9+tZjdTdTgY68/x+VkmdJe1FJSrNhZwEhz8uULCi9rPeyqzcV41iqOuJmpiqlx8me/jMkqILwwMmDkwnD+IhdEfUdxpSgBt6uVzN/nHvconRVLqOopEweLGPz8PTCCVjuyTfeCZxQIrXG3l9w1g==
X-MS-Exchange-AntiSpam-MessageData: /jUdGRKM3uDg12skzTXqYzWs5cjVdBCSnvC5gwowFhTjN7lle7rTZb+dl1HOLWrjkFDCEQQbK+3iQUVL01oMvxukree9LmHI8BTYh89ug2AeTsI58zkk1vT3GkcshjY/dYmsqGbEVqrlLG2QdfS6Ew==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a55e8f-e148-437d-ed00-08d7cbfc4a87
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 11:54:34.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mc2v4Ljs2cbYABpAYVY/nExaem0OCqVtW1vzbPq9MJYCRzyUv+XCVRf1UAkLpS07iGKrf0CcDhmiM7PVkBEQVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6061
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 19, 2020 at 10:48:22AM +0200, Max Gurtovoy wrote:
> 
> On 3/19/2020 1:32 AM, Jason Gunthorpe wrote:
> > On Wed, Mar 18, 2020 at 05:02:54PM +0200, Max Gurtovoy wrote:
> > > This is a preparetion patch for the SRQ per completion vector feature.
> > > 
> > > Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> > >   drivers/nvme/target/rdma.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > Max, how are you sending these emails, and why don't they thread
> > properly on patchworks:
> > 
> > https://patchwork.kernel.org/project/linux-rdma/list/?series=258271
> > 
> > This patch is missing from the series
> > 
> > v1 had the same issue
> > 
> > Very strange. Can you fix it?
> 
> I'm using "git send-email".
> 
> Should I use some special flags or CC another email for it ?
> 
> How do you suggest sending patches so we'll see it on patchworks ?

I looked at these mails and they seem properly threaded/etc.

I've added Konstantin, perhaps he knows why patchworks is acting
weird here?

Jason
