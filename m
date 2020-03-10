Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBE417F1C9
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 09:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCJIVe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 04:21:34 -0400
Received: from mail-eopbgr140043.outbound.protection.outlook.com ([40.107.14.43]:38574
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbgCJIVe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 04:21:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPR/7ID7MuhlXr+KztCqZB9ydjY+yx1QmdMWedkXP7OCfdzBy1k5AlbAK2M3Y5Qllg1N/NOL5uqEIl9bl0nqTb8Qu6U/mptj5kP9W874ol2fAVwwIam8WTXqK/Utn3wc0KCC+OWvpK3nQOvFLyn2bsuTUIP8xVE7bmtjJYsi+PmcYyPjKRSHYfVI1jCaRu4xecI0lpCwy3FwTuz866Rl6jZlPFhX7agSA51j7OOp9PZUkI+B6UFPV58HUDXL64ljobaWOx/gPZq6OF9z2qziHuh7EGWrYTrVJWqMyAFXNhMnKf+84Yzz7vKMCb6f9VHtUGCjp4A9SJm0q8b29+GlLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO5L1ww3b2p/Kt5Iy+N0L1gkSZ78YxUZaclDf79TToU=;
 b=LLNga55F5tQWER39xe5v6CCJkJ9EYugA9Vb3zzxFU/gSBBM7F4T1u+ZLlV0gXiwqLZtMAsGiYU91ssFfmL4oTDOAI5WwvVlDF33G1OHYA+Mndm/PSxR6FlTGG1KkQODdBWmMZGR4t15tTeIcMHRvg2ygfoctKdkE0c6jznGG/xZ2/q/Dxnu+G/F7YugEOEg/RAnr29v2U6K0syVP4yjYUoBAQDbRo/bjfS5n0SlXc03KiYyJ77p/iZlD0sfjyu2g3983BWFsKxRZjhBX6Pq3tm4nRoH/xNr3VqFwJcFGa0oC6ti48eawu+3lziRadr+rOywWFWAlqEGVjrPlkKW6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO5L1ww3b2p/Kt5Iy+N0L1gkSZ78YxUZaclDf79TToU=;
 b=BrN7XZaQAPRAkSfh7tl4/ncjkJOfq91agaVjl2d6cRTHteZgkEMBpZB9a8Aa6BVzboqSejlQfn6uqKvhZ5cw5y+AY9C4Hb1rarYArJqdMof8HZZiamxh8hadxbnWV25rZ8lS4lC9TjmFBwpP/TftQhwMEYaoCBTJC1TtQFmC+p8=
Received: from AM6PR05MB5014.eurprd05.prod.outlook.com (20.177.33.13) by
 AM6PR05MB5473.eurprd05.prod.outlook.com (20.177.118.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Tue, 10 Mar 2020 08:21:29 +0000
Received: from AM6PR05MB5014.eurprd05.prod.outlook.com
 ([fe80::cbb:a034:c324:138b]) by AM6PR05MB5014.eurprd05.prod.outlook.com
 ([fe80::cbb:a034:c324:138b%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 08:21:29 +0000
From:   Yanjun Zhu <yanjunz@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     syzbot <syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: KASAN: use-after-free Read in rxe_query_port
Thread-Topic: KASAN: use-after-free Read in rxe_query_port
Thread-Index: AQHV9jkJCU28FFAXfky+bua200OhVqhBcaYAgAAJUZA=
Date:   Tue, 10 Mar 2020 08:21:29 +0000
Message-ID: <AM6PR05MB50143279152CCAB54786D930D8FF0@AM6PR05MB5014.eurprd05.prod.outlook.com>
References: <0000000000000c9e12059fc941ff@google.com>
 <20200309173451.GA15143@mellanox.com> <20200310073936.GF172334@unreal>
In-Reply-To: <20200310073936.GF172334@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yanjunz@mellanox.com; 
x-originating-ip: [118.201.220.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2351a862-edee-495a-0eef-08d7c4cc0889
x-ms-traffictypediagnostic: AM6PR05MB5473:|AM6PR05MB5473:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB547345437D3E60D4E150A13DD8FF0@AM6PR05MB5473.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(189003)(199004)(81166006)(8936002)(81156014)(54906003)(2906002)(8676002)(6636002)(110136005)(71200400001)(4326008)(186003)(26005)(33656002)(6506007)(86362001)(7696005)(52536014)(966005)(53546011)(76116006)(478600001)(66556008)(64756008)(66476007)(66446008)(316002)(5660300002)(55016002)(9686003)(66946007)(99710200001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5473;H:AM6PR05MB5014.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1grKfgoK2M5AYjacnY2byxxKjjbgS1plCUqgdbII9+mnDFAyp6WkmfSQfHnhB2k8vx85tPM6o7KwgDHx86hHrhuwPhlloWOg29C3Bc4Xo4H2bP/9EkNwZCTkqWlbYBLJlQJhtbT30oTEKpkHW8b4cOtUe4nqYF7TO9jpcXjhDc/HV5tExMzQCyVmtRTZWqlj0sw2iuv2mbpv4haVS6KejKS9ChL7Q0/S8DFOWqaXjKQd8SzK2jebZ+XB8eoRDC8gTq8r/+oUH4kl20wSDLPc/1EFNTcUxrYuYj1nn1K8G17tNA7rhwOBYBMfB7S8r+cfTXkw7qk6p29gEoI/7vvBlibYCoIMUcciqh76nhcLIcdHgmM9GhA9JOT8twJ51aS113LghEIc5PXntVdU625VvXI7hY2wa+IbJIiEPA5sH/fd0JC71W6bEdAV/FgwmfnGRz1bpdXmJLasDlSPN7hYNIDAO2vJmoZLEjgr8QD3H4w1MLJ/6T6C1MeGhOzxeU6fUcqsMK4MkLewmLvtA1odiW14xi+75PQRQAZd0hIeq/P/Zz9YO1wFblNOzD1XhjspRN3x8y26ugPXAasQlEDu19uEcmg3g12SjtLsvYIdmmwrXOilf8h2dIWzsuhNMZgccmNHy8qVa69fqVP6SnEksg==
x-ms-exchange-antispam-messagedata: nmkfxGpOEzRDEfvafZsiy8hpraDaoAsUUBKYPccYPXfgveufQUVlhCiUXgo5mogJnGzC3bMo7yrZzSqK5H/mLcZGLRy8QD7O3UnG3Ptck72G+wChGRwKwpwAGxUzUW+iAc+iJS9QF0vpgUohPaNepw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2351a862-edee-495a-0eef-08d7c4cc0889
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 08:21:29.0657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLNwtZmPzN1QPPkPKQKmNW1Fnc09gUSKEeeU1mNgnbWrRRutXekLGoYjA/4fJpZe9sbhCCP0ni4jYuPG0hQ/ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5473
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, Leon

Thanks. From the patch https://lore.kernel.org/netdev/20200306134518.84416-=
1-kgraul@linux.ibm.com,

@@ -240,6 +240,9 @@ static void smc_ib_port_event_work(struct work_struct *=
work)
 		work, struct smc_ib_device, port_event_work);
 	u8 port_idx;
=20
+	if (list_empty(&smcibdev->list))
+		return;
+
 	for_each_set_bit(port_idx, &smcibdev->port_event_mask, SMC_MAX_PORTS) {
 		smc_ib_remember_port_attr(smcibdev, port_idx + 1);
 		clear_bit(port_idx, &smcibdev->port_event_mask);

This block is try to check smcibdev->list to avoid ib_query_port after the =
NIC is down.
But smcibdev->list is used by spinlock when add and del.
"
...
549         spin_lock(&smc_ib_devices.lock);
550         list_add_tail(&smcibdev->list, &smc_ib_devices.list);
551         spin_unlock(&smc_ib_devices.lock);
...

579         spin_lock(&smc_ib_devices.lock);
580         list_del_init(&smcibdev->list); /* remove from smc_ib_devices *=
/
581         spin_unlock(&smc_ib_devices.lock);
...
"
So in the above block, is it necessary to protect  smcibdev->list when it i=
s accessed?
Please comment on it.

Thanks a lot.
Zhu Yanjun

-----Original Message-----
From: Leon Romanovsky <leon@kernel.org>=20
Sent: Tuesday, March 10, 2020 3:40 PM
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: syzbot <syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com>; dledfor=
d@redhat.com; linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Mon=
i Shoua <monis@mellanox.com>; syzkaller-bugs@googlegroups.com; Yanjun Zhu <=
yanjunz@mellanox.com>
Subject: Re: KASAN: use-after-free Read in rxe_query_port

On Mon, Mar 09, 2020 at 02:34:51PM -0300, Jason Gunthorpe wrote:
> On Sun, Mar 01, 2020 at 03:20:12AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    f8788d86 Linux 5.6-rc3
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D132d3645e00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9833e26bab3=
55358
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3De11efb687f5ab=
7f01f3d
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> > Reported-by: syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com
>
> Yanjun, do you have some idea what this could be?

See this fix in the net mailing list.
https://lore.kernel.org/netdev/20200306134518.84416-1-kgraul@linux.ibm.com

Thanks

>
> Thanks,
> Jason
