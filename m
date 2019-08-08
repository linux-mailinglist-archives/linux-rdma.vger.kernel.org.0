Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9285286194
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 14:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfHHM02 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 08:26:28 -0400
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:52086
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728718AbfHHM01 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Aug 2019 08:26:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3rYc4Ms4joyZ3Hso551nZYX+z+I0/F5MfY9+jCpqbgUraQELwOE1pUaKcil8cUJuqwFBSjKlSmCJaAntqw3+SQlcSCI7xSq+hQAHd/bbsYkBTpejOtPdaamd/+QqnEdCxFIc92I9yzWYFPFbAt957ufpv6xb4HZ9fCAe1quO+96O1f7Wpj708+2W8zzJgbqFRdbuEV+GMlZuK5OcWdgqhvCN1u+7Bq3JEY7xDPBaHtTpScj62xJNcublXWL+gpD89g/QnNR1G+7DTpvYYMTffSsa6gzWhLN9y/1Fgg1RhNpSIEMIqqlVVmPj2+8v65367xXrU/K7s7iCn/jFOn9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+GDq6f/1kLy3rhN6iz48fiQOb9054f29onYGnvyIzA=;
 b=UWyHfjfFjjH/6CdiVFqcIx63mTdFLO6oFPjU8TyRauWHKqQLl0w8uvmMquxAa5gOkARNaseh+F5Jftnk/X0TUraqxLzEPYJZwR/JAFSJj0h+ziaLe0FAWw5ecMNCSzgDi6Ug2A/WE0xf/inTrSwtOAC7zlxhsAPwvWX9FL9RJwKmgDtn4vRrkFOPD32dzuqG6+LP/uzFJ12XUX85eYCKdbYWb7VngxWm2foW8h7HTCkkzZ9cnYrBWVGvzaWAE0Dft7pWJEiqKixVwWdZv1Ji34hxmh+sQ7EJDJTb9EWfGOzwWNLV147whPjCecm9hgv2HPduvF+zAuXJgFbjWe3ZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+GDq6f/1kLy3rhN6iz48fiQOb9054f29onYGnvyIzA=;
 b=jAW4jidv45edUKv1DhyvnTT8k+Frd/7SNaJurIbWzK7XdqcXk7h14iN1lcZRL427/oZG+WviaqjzyJIdO5Kt2lx2tTeqsOojZOVXdPywOoLNCkRw5eVI5gs+g4DASxW4RQVIUCv/eS+WTnTQAQ2xcqZVJHR2dfFc6cfofNAs8vY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6383.eurprd05.prod.outlook.com (20.179.26.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Thu, 8 Aug 2019 12:26:21 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2136.022; Thu, 8 Aug 2019
 12:26:21 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-rc] IB/mlx5: Fix use-after-free error while accessing
 ev_file pointer
Thread-Topic: [PATCH rdma-rc] IB/mlx5: Fix use-after-free error while
 accessing ev_file pointer
Thread-Index: AQHVTcF9MrNNBZGTSEeMMAk1fHMANqbxLW6A
Date:   Thu, 8 Aug 2019 12:26:21 +0000
Message-ID: <20190808122615.GC1975@mellanox.com>
References: <20190808081538.28772-1-leon@kernel.org>
In-Reply-To: <20190808081538.28772-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::47) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a816dd9-6c30-40e2-9d26-08d71bfb9eec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6383;
x-ms-traffictypediagnostic: VI1PR05MB6383:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6383FAE412A5BCC7A44498E0CFD70@VI1PR05MB6383.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(199004)(189003)(11346002)(107886003)(2616005)(33656002)(25786009)(99286004)(26005)(6436002)(386003)(52116002)(8676002)(3846002)(186003)(102836004)(229853002)(6246003)(256004)(14444005)(81156014)(81166006)(71200400001)(6486002)(53936002)(6512007)(478600001)(76176011)(7736002)(486006)(36756003)(305945005)(4326008)(446003)(6116002)(2906002)(8936002)(71190400001)(6506007)(6916009)(14454004)(64756008)(66946007)(476003)(66556008)(1076003)(86362001)(66476007)(66446008)(66066001)(5660300002)(54906003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6383;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gBVeZ1iUZqiUPKXi2u3tOnr4yQ0ewgFrOlwXOVleDQa7DqlU2XGFkbr8SjsdEJyzUIjZmnsil809wvVGzQh0B9qUS/AZq9/rWCD32ObJSoRlb3/bh7v3J7HK4CGIc3ACyzOrPjtEIytftq7O97iftc6sVfcpGkjMODcR+FQxc4pBHw5ArGL3zo3pmZS0lO01Jr+SsztLaVz/vJrnVx0PCQNklFMM4+MAr2FOrqih9nR3CCzTolsIEFxDTxUiV4UcbYHJvOPahcxwd4FVKpEXmkxGefBjoLvLtJRC27UD0NJdWoGCW9EYYGM3rZWwg00H5GGHf+l/dMJPgMSGicA1S/V6YOBuAFt1RcyG/i+OcT3ZcSTMj6b9wxuqtTxyb87RPI4FRI7wAmQj5Yt48W9QI2MVfVlPIf1imSZUm84elK4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F11569549E09774B8E4561B5FEA88E9B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a816dd9-6c30-40e2-9d26-08d71bfb9eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 12:26:21.4951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6383
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 08, 2019 at 11:15:38AM +0300, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@mellanox.com>
>=20
> Call to uverbs_close_fd() releases file pointer to 'ev_file' and
> mlx5_ib_dev is going to be inaccessible. Cache pointer prior cleaning
> resources to solve the KASAN warning below.
>=20
> BUG: KASAN: use-after-free in devx_async_event_close+0x391/0x480 [mlx5_ib=
]
> Read of size 8 at addr ffff888301e3cec0 by task devx_direct_tes/4631
> CPU: 1 PID: 4631 Comm: devx_direct_tes Tainted: G OE 5.3.0-rc1-for-upstre=
am-dbg-2019-07-26_01-19-56-93 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-=
1ubuntu2 04/01/2014
> Call Trace:
> dump_stack+0x9a/0xeb
> print_address_description+0x1e2/0x400
> ? devx_async_event_close+0x391/0x480 [mlx5_ib]
> __kasan_report+0x15c/0x1df
> ? devx_async_event_close+0x391/0x480 [mlx5_ib]
> kasan_report+0xe/0x20
> devx_async_event_close+0x391/0x480 [mlx5_ib]
> __fput+0x26a/0x7b0
> task_work_run+0x10d/0x180
> exit_to_usermode_loop+0x137/0x160
> do_syscall_64+0x3c7/0x490
> entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x7f5df907d664
> Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f
> 80 00 00 00 00 8b 05 6a cd 20 00 48 63 ff 85 c0 75 13 b8
> 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 44 f3 c3 66 90
> 48 83 ec 18 48 89 7c 24 08 e8
> RSP: 002b:00007ffd353cb958 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 000056017a88c348 RCX: 00007f5df907d664
> RDX: 00007f5df969d400 RSI: 00007f5de8f1ec90 RDI: 0000000000000006
> RBP: 00007f5df9681dc0 R08: 00007f5de8736410 R09: 000056017a9d2dd0
> R10: 000000000000000b R11: 0000000000000246 R12: 00007f5de899d7d0
> R13: 00007f5df96c4248 R14: 00007f5de8f1ecb0 R15: 000056017ae41308
>=20
> Allocated by task 4631:
> save_stack+0x19/0x80
> kasan_kmalloc.constprop.3+0xa0/0xd0
> alloc_uobj+0x71/0x230 [ib_uverbs]
> alloc_begin_fd_uobject+0x2e/0xc0 [ib_uverbs]
> rdma_alloc_begin_uobject+0x96/0x140 [ib_uverbs]
> ib_uverbs_run_method+0xdf0/0x1940 [ib_uverbs]
> ib_uverbs_cmd_verbs+0x57e/0xdb0 [ib_uverbs]
> ib_uverbs_ioctl+0x177/0x260 [ib_uverbs]
> do_vfs_ioctl+0x18f/0x1010
> ksys_ioctl+0x70/0x80
> __x64_sys_ioctl+0x6f/0xb0
> do_syscall_64+0x95/0x490
> entry_SYSCALL_64_after_hwframe+0x49/0xbe
>=20
> Freed by task 4631:
> save_stack+0x19/0x80
> __kasan_slab_free+0x11d/0x160
> slab_free_freelist_hook+0x67/0x1a0
> kfree+0xb9/0x2a0
> uverbs_close_fd+0x118/0x1c0 [ib_uverbs]
> devx_async_event_close+0x28a/0x480 [mlx5_ib]
> __fput+0x26a/0x7b0
> task_work_run+0x10d/0x180
> exit_to_usermode_loop+0x137/0x160
> do_syscall_64+0x3c7/0x490
> entry_SYSCALL_64_after_hwframe+0x49/0xbe
>=20
> The buggy address belongs to the object at ffff888301e3cda8
> which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 280 bytes inside of 512-byte region
> [ffff888301e3cda8, ffff888301e3cfa8)
> The buggy address belongs to the page:
> page:ffffea000c078e00 refcount:1 mapcount:0
> mapping:ffff888352811300 index:0x0 compound_mapcount: 0
> flags: 0x2fffff80010200(slab|head)
> raw: 002fffff80010200 ffffea000d152608 ffffea000c077808 ffff888352811300
> raw: 0000000000000000 0000000000250025 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> Memory state around the buggy address:
> ffff888301e3cd80: fc fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb
> ffff888301e3ce00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888301e3ce80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888301e3cf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888301e3cf80: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
> Disabling lock debugging due to kernel taint
>=20
> Cc: <stable@vger.kernel.org> # 5.2
> Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over=
 DEVX")
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/hw/mlx5/devx.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/ml=
x5/devx.c
> index 2d1b3d9609d9..af5bbb35c058 100644
> +++ b/drivers/infiniband/hw/mlx5/devx.c
> @@ -2644,12 +2644,13 @@ static int devx_async_event_close(struct inode *i=
node, struct file *filp)
>  	struct devx_async_event_file *ev_file =3D filp->private_data;

This line is wrong, it should be

  	struct devx_async_event_file *ev_file =3D container_of(struct
 	                   devx_async_event_file, filp->private_data, uobj);

It should get fixed in a followup, along with any other places like
it.

It is also a bit redundant to store the mlx5_ib_dev in the
devx_async_event_file as uobj->ucontext->dev is the same pointer.

Otherwise this patch is Ok

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
