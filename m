Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 520C3154345
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 12:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgBFLkk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 06:40:40 -0500
Received: from mail-am6eur05on2059.outbound.protection.outlook.com ([40.107.22.59]:6154
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727415AbgBFLkj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Feb 2020 06:40:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKpkgeddFzZV49oCssyoywaEGkFT7WwFthhFXstIxHRVcKCpqgBlzJcyMpWeU/ltYU1VeKaJtkQ+wcFnKUawANdOSOl/A46jGhZgTRpMLWp8l7Rk3OHZfi2URLgHiBWWkWDd1o74oe3zqXDuV1aVHItD5avWZOFyuDtmmloGwiGLcDA0mKoiaY2BHQy1QuejJZ7VmtzC8TUmqHHhc1bB3h9NOl+XrG3EjfjHfKbOhaNAR5zdIFcoN7lDrJXVutiErTMk+kelyG114xDtgqQ1xBwYF8Rd0clhOqCK9AMR1GfztnKta9JR5vqDnZQPqxvXs0+Cp0vWGKeylpSyRPAiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBuDUHkSrmGHDsgMyNAHYx5JK9nya8hmZTvi+YhuoT8=;
 b=nff14A8d0CJJ51k0VI6cW/aAeBHAvCoDCGd9NjQh2obw7Sa0siPqoYX8atASWVQKZnJHrOcwJ1SX9EeGpanYW4QKPMm/QcRqEwPTelAX8d3NAn0a27eF2M68szmALpoI85kiAGnc/1UN2EJDfI6O9fr9+0KdPDOKktYMvWti7QzDeI3PQg214iAdndp0wDyoSb8dCNXmrMEibs1mF/Q+k6/eg1L+W0sj1zz2R3KjStL1svZVUXXHMnXo7zdQx0sBWqS6BTinOt+tCBg9vejVxyPIxjkQckz3afEpmniNmoSg7QTeRwi1ln603VlWrhGQZqEMzOMOXa0RRV4Rc32zfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBuDUHkSrmGHDsgMyNAHYx5JK9nya8hmZTvi+YhuoT8=;
 b=X7rbaEohF5AxDLrkYe0czafA3wBKlqNzZhxcdzclqOtEsRIWn8l0vH2SFtP04k242DbmbusvZ+gaHWWvrid4hFr78n3E14DRcSDL0ePogAuIdpGCj7gWWCxkUkKHa0QQ2mL0NRTO8tn7FXiEnD0C49BaQNGYQEVcLJxsFvWJ9mE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB4488.eurprd05.prod.outlook.com (52.135.168.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Thu, 6 Feb 2020 11:40:36 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2707.024; Thu, 6 Feb 2020
 11:40:35 +0000
Date:   Thu, 6 Feb 2020 13:40:33 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: Tree for Jan 30 + 20200206
 (drivers/infiniband/hw/mlx5/)
Message-ID: <20200206114033.GF414821@unreal>
References: <20200130152852.6056b5d8@canb.auug.org.au>
 <df42492f-a57e-bf71-e7e2-ce4dd7864462@infradead.org>
 <ee5f17b6-3282-2137-7e9d-fa0008f9eeb0@infradead.org>
 <20200206073019.GC414821@unreal>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200206073019.GC414821@unreal>
X-ClientProxiedBy: AM3PR04CA0136.eurprd04.prod.outlook.com (2603:10a6:207::20)
 To AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
MIME-Version: 1.0
Received: from localhost (193.47.165.251) by AM3PR04CA0136.eurprd04.prod.outlook.com (2603:10a6:207::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 11:40:35 +0000
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a375df30-b181-4bc7-eab8-08d7aaf9619c
X-MS-TrafficTypeDiagnostic: AM6PR05MB4488:
X-Microsoft-Antispam-PRVS: <AM6PR05MB4488CA302360198CF585B050B01D0@AM6PR05MB4488.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10009020)(7916004)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(199004)(189003)(478600001)(81166006)(81156014)(33656002)(8936002)(1076003)(86362001)(8676002)(966005)(66946007)(6916009)(4326008)(52116002)(6496006)(33716001)(53546011)(5660300002)(956004)(66556008)(66476007)(54906003)(6486002)(9686003)(316002)(186003)(16526019)(26005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4488;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrJGcjHHKzbZGarWf2eK5/cQAV9/DI9QQrWaeKC/SnrReMpr4tBP5hYLY7qVO8L/knvBBWi6XcdLT1LTKvpv2xqPVoAaN751xM5ee+6aWA9d7sZh1NAqA3tBRiY4/gkjgDPHhUMGEN5q9BU0GOE57NcqNOJOd3yZFeEQKansbyRyGGgwB7Ijfq42zuBIbx+T5xkAmB5cgn1+IiTfI8o/E8lXFW8IMQ0quslZ3NXqYegLm+LVUvIwuK4L9roaDaI/vmU+pjqmJa/s7Z9OFEeP0lstgPplmKJus4KjW/4r8LVFMv6GIKfoUZ7OtbioxGi9EALoSoXQ8h0INd127J4dp6HH40v2RVfVGlMVeuQNWRdH9xC9seGxlyQQiJGPkINKVIrGnQDcYxbFLRCvrdPEXiMW3TH0phjAGU3zvqzupavSpRd8/mrD/8Q9bIsNzHMo9+qsEbm3VPXo1wf0YL73LXuCzmQJ7xRN3d2pzW/w/xHL0Utz+DjHaVTyHWbQVVmeFXzuwzmKDcLkcCRFWZjVsdOZxSefZXW3hYnjYr5K950Dyg2XO2N8ZVz3RR99wHOkEK3fZvhGAsd/HUGalyiNE7CKkgxJMNCLo/i/gvaobaONyIYOa+/Fq2fO1ouxHCpT2sbEAwiBZWvfG4Y+YsgMHU0uL76lGd0tFj4O2hPCs0D7VrIaSbjjYOecNBfzvjGAvse8rmvCIwinDqs5GmrZkkyhMu5sMWOj8q/h2k3FF5g=
X-MS-Exchange-AntiSpam-MessageData: eq0dCmv2FQEOehOm1PBB0DdtFLkrbpkx4AElFkzqj0Ei/K6mMOG7ddWXdImw5ia/CQ4KUQ+392Ods/oCp9XeAgIq05BDXI4t1TuzSIBDNGW7DXA5dxTxsrpiERjJgwK08XPeMSwF5ao6mdcy8/UA0Q==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a375df30-b181-4bc7-eab8-08d7aaf9619c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 11:40:35.9065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlxz2dzuT6M2Zhcf5jsCWdX15A2MqceDFJWo1SuiVNrS3gTDUQs8SepwwLuEoOaNgz79CSv3zVKQxcUBf9Phpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4488
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 06, 2020 at 09:30:19AM +0200, Leon Romanovsky wrote:
> On Wed, Feb 05, 2020 at 09:31:15PM -0800, Randy Dunlap wrote:
> > On 1/30/20 5:47 AM, Randy Dunlap wrote:
> > > On 1/29/20 8:28 PM, Stephen Rothwell wrote:
> > >> Hi all,
> > >>
> > >> Please do not add any v5.7 material to your linux-next included
> > >> branches until after v5.6-rc1 has been released.
> > >>
> > >> Changes since 20200129:
> > >>
> > >
> > > on i386:
> > >
> > > ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> > > ERROR: "__divdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> > >
> > >
> > > Full randconfig file is attached.
> > >
> > >
> >
> > I am still seeing this on linux-next of 20200206.
>
> Sorry, I was under wrong impression that this failure is connected to
> other issue reported by you.
>
> I'm looking on it right now.

Randy,

I'm having hard time to reproduce the failure.
➜  kernel git:(a0c61bf1c773) ✗ git fixes
Fixes: a0c61bf1c773 ("Add linux-next specific files for 20200206")
➜  kernel git:(a0c61bf1c773) ✗ wget https://lore.kernel.org/lkml/df42492f-a57e-bf71-e7e2-ce4dd7864462@infradead.org/2-config-r9621
from https://lore.kernel.org/lkml/df42492f-a57e-bf71-e7e2-ce4dd7864462@infradead.org/
➜  kernel git:(a0c61bf1c773) ✗ mv 2-config-r9621 .config
➜  kernel git:(a0c61bf1c773) ✗ make ARCH=i386 -j64 -s M=drivers/infiniband/hw/mlx5
➜  kernel git:(a0c61bf1c773) ✗ file drivers/infiniband/hw/mlx5/mlx5_ib.ko
drivers/infiniband/hw/mlx5/mlx5_ib.ko: ELF 32-bit LSB relocatable, Intel 80386, version 1 (SYSV), BuildID[sha1]=49f81f5d56f7caf95d4a6cc9097391622c34f4ba, not stripped

on my 64bit system:
➜  kernel git:(rdma-next) file drivers/infiniband/hw/mlx5/mlx5_ib.ko
drivers/infiniband/hw/mlx5/mlx5_ib.ko: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), BuildID[sha1]=2dcb1e30d0bba9885d5a824f6f57488a98f0c95d, with debug_info, not stripped

Thanks

>
> Thanks
>
> >
> > --
> > ~Randy
> >
