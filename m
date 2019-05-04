Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9783E13709
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2019 04:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfEDCd6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 22:33:58 -0400
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:27201
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbfEDCd6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 May 2019 22:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvvvxguXFS/tCPT8wNJzJ7Ok4iAfTLhai36oe2TR2FY=;
 b=hNYoiAEUkMbnxwJA3/Gjc6FrDm4zGKO7Cyvb62waEqFEJXQIePa5lxSq/hB0JAQQUwSanyM86eR6BBWbCODoEfK6WvTSaoYMvo0zNd9FM6xcutbLchcoETlKbznJ38Jyg1Q3PPW6/mAy8Ag12TezmJvqxpIhF7VT08vzVdJkLMc=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.134.149) by
 VI1PR0501MB2366.eurprd05.prod.outlook.com (10.169.136.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Sat, 4 May 2019 02:33:40 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::8810:9799:ab77:9494]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::8810:9799:ab77:9494%2]) with mapi id 15.20.1856.008; Sat, 4 May 2019
 02:33:40 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Huy Nguyen <huyn@mellanox.com>, Martin Wilck <mwilck@suse.com>
Subject: RE: [PATCH rdma-next v2 0/7] Allow RoCE GID attribute netdev
 detachment
Thread-Topic: [PATCH rdma-next v2 0/7] Allow RoCE GID attribute netdev
 detachment
Thread-Index: AQHVALtq7ORyUtyy6kmeVRpPOML/c6ZaI60AgAATn0A=
Date:   Sat, 4 May 2019 02:33:40 +0000
Message-ID: <VI1PR0501MB2271CB912D76520BB835D694D1360@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <20190502074807.26566-1-leon@kernel.org>
 <20190504004441.GA8449@mellanox.com>
In-Reply-To: <20190504004441.GA8449@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [68.203.16.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 347a561e-5462-4c9e-0456-08d6d038eb7a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0501MB2366;
x-ms-traffictypediagnostic: VI1PR0501MB2366:
x-microsoft-antispam-prvs: <VI1PR0501MB2366479A9ADF24F531C499F4D1360@VI1PR0501MB2366.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0027ED21E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(136003)(396003)(189003)(199004)(54534003)(13464003)(6116002)(14454004)(3846002)(25786009)(33656002)(11346002)(478600001)(71200400001)(71190400001)(52536014)(53546011)(6246003)(54906003)(66476007)(229853002)(76176011)(7696005)(64756008)(66066001)(66446008)(73956011)(66946007)(476003)(76116006)(66556008)(5660300002)(8676002)(7736002)(99286004)(4326008)(6436002)(8936002)(110136005)(305945005)(446003)(55016002)(81156014)(486006)(186003)(81166006)(316002)(6506007)(74316002)(5024004)(2906002)(256004)(14444005)(102836004)(86362001)(53936002)(68736007)(9686003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2366;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iUDjZ+jsrGK8PcBBkywjz09+J0yKas4is60WMf/UuTzYqqSmoIQ+hEuzJMc7LQbXJ1xUc4b23N9/8k0dnKQ6YTP6KDWGC24x6HhxOCVSUWbyyfcXhk1FVXonErWN0E3ypc1A/SCpkDPPxAuPawtGFOt2yCY6x7a7eiMjo52AMC16dcO7pSlF8UbcJtNQg6ljB/Z11766RPYBff1G0pnUmGpzjoSXa6VBnKWjs8kawqUExw63WMLsWaLDD3CCZfthgScCb09t7kqCgdjaQuhnyR47DBW9B5nbbslg+mJG37VROEX3n/6e0SGoP5XxwWbpuRgnec941sa4SX7dvuZoLTD3O3HuLU31o7IzkGgcIEFepY6B+iF+qTJLts+AtD6uHvuIcz0T+ryVy5zPVi2QzhFeXCL0jqxwM3B96a1S1LE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347a561e-5462-4c9e-0456-08d6d038eb7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2019 02:33:40.5661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2366
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe
> Sent: Friday, May 3, 2019 7:45 PM
> To: Leon Romanovsky <leon@kernel.org>
> Cc: Doug Ledford <dledford@redhat.com>; Leon Romanovsky
> <leonro@mellanox.com>; RDMA mailing list <linux-rdma@vger.kernel.org>;
> Huy Nguyen <huyn@mellanox.com>; Martin Wilck <mwilck@suse.com>;
> Parav Pandit <parav@mellanox.com>
> Subject: Re: [PATCH rdma-next v2 0/7] Allow RoCE GID attribute netdev
> detachment
>=20
> On Thu, May 02, 2019 at 10:48:00AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Changelog:
> >  v1 -> v2:
> >  * Resent
> >  v0 -> v1:
> >  * Fixed wrong RCU pointer access in patch "RDMA/core: Allow detaching
> >    gid attribute netdevice for RoCE"
> >
> > ----------------------------------------------------------------------
> > -
> >
> > >From Parav,
> >
> > This series covers following changes.
> >
> > 1. A fix in RXE to consider right reserved space of the netdev.
> > 2. ib_cm to avoid accessing netdev of GID attribute.
> > 3. Several RoCE drivers and net/smc needs to know the mac and vlan of
> > the GID entry.
> >
> > Instead of open coded accessing netdev fields, we introduce an API to
> > get such fields filled up using new API rdma_read_gid_l2_fields().
> >
> > 4. When there is active traffic through a GID, a QP/AH holds reference
> > to this GID entry. GID entry holds reference to its attached netdevice.
> > Due to this when netdevice (such as vlan netdev) is deleted by admin
> > user, its refcount is not dropped.
> >
> > Therefore, use netdev under rcu lock so that netdev reference can be
> > dropped when netdev and associated RoCE GID entry is deleted. This is
> > facilitated by existing API rdma_read_gid_attr_ndev_rcu.
> >
> > Thanks
> >
> >
> > Parav Pandit (7):
> >   RDMA/rxe: Consider skb reserve space based on netdev of GID
> >   IB/cm: Reduce dependency on gid attribute ndev check
> >   RDMA: Introduce and use GID attr helper to read RoCE L2 fields
> >   RDMA/cma: Use rdma_read_gid_attr_ndev_rcu to access netdev
> >   RDMA/rxe: Use rdma_read_gid_attr_ndev_rcu to access netdev
> >   net/smc: Use rdma_read_gid_l2_fields to L2 fields
> >   RDMA/core: Allow detaching gid attribute netdevice for RoCE
> >
> >  drivers/infiniband/core/addr.c             |   1 +
> >  drivers/infiniband/core/cache.c            | 117 +++++++++++++++++++--
> >  drivers/infiniband/core/cm.c               |   5 +-
> >  drivers/infiniband/core/cma.c              |  12 ++-
> >  drivers/infiniband/core/sysfs.c            |  13 ++-
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  18 ++--
> >  drivers/infiniband/hw/hns/hns_roce_ah.c    |  14 +--
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c |   7 +-
> >  drivers/infiniband/hw/mlx4/ah.c            |   8 +-
> >  drivers/infiniband/hw/mlx4/qp.c            |   6 +-
> >  drivers/infiniband/hw/mlx5/main.c          |  42 ++------
> >  drivers/infiniband/hw/ocrdma/ocrdma_ah.c   |   9 +-
> >  drivers/infiniband/hw/ocrdma/ocrdma_hw.c   |   7 +-
> >  drivers/infiniband/hw/qedr/qedr_roce_cm.c  |  11 +-
> >  drivers/infiniband/hw/qedr/verbs.c         |   5 +-
> >  drivers/infiniband/sw/rxe/rxe_net.c        |  18 +++-
> >  include/rdma/ib_cache.h                    |   4 +
> >  include/rdma/ib_verbs.h                    |   2 +-
> >  net/smc/smc_ib.c                           |  16 +--
> >  19 files changed, 221 insertions(+), 94 deletions(-)
>=20
> Now that we have the RCU pointer in the gid_attr it is really ugly that t=
he
> onstack version and the pointer version are the same type, this needs a
> cleanup to add some kind of gid_attr_init structure instead
>
Hmm ok.=20
Other option I was considering is to pass ndev pointer as additional argume=
nt in add_gid code flow.
But it was too much changes in roce_gid_mgmt.c.
We can possibly keep the scope limited of gid_init_attr within cache.c and =
git_mgmt.c.

> But otherwise applied to for-next
>=20
Thanks

> Thanks,
> Jason
