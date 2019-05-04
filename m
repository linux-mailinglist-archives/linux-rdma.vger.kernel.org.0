Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D0A136F2
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2019 03:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfEDB40 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 21:56:26 -0400
Received: from mail-eopbgr50042.outbound.protection.outlook.com ([40.107.5.42]:58691
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726700AbfEDB4Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 May 2019 21:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01Fstppg3+sy23BMpVnJ1nVyFNK7Qh21xt3Xc6rXCX8=;
 b=gH1ErhxZLZ5ptG+hKzB3+hRfnsXfRUSw+tfucC75zPIg+8DNTezdGK2Zk/dBu9Mo1/x3heMz/cQnlFWrBn/IDiH7iwSmu8xyREoM7cDubr4j20d+zO53zKzuesJzre5fPzrn0ULakODLaYuLFksI51XfdSGTTM3xbcf6kttuTU8=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.134.149) by
 VI1PR0501MB2176.eurprd05.prod.outlook.com (10.169.134.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Sat, 4 May 2019 01:54:41 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::8810:9799:ab77:9494]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::8810:9799:ab77:9494%2]) with mapi id 15.20.1856.008; Sat, 4 May 2019
 01:54:41 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: RE: [PATCH rdma-next] RDMA/core: Do not invoke init_port on compat
 devices
Thread-Topic: [PATCH rdma-next] RDMA/core: Do not invoke init_port on compat
 devices
Thread-Index: AQHU/+FOR7fJo0YrTU60EkXuAg0DeaZaBTYAgAAzOaA=
Date:   Sat, 4 May 2019 01:54:41 +0000
Message-ID: <VI1PR0501MB22719C0B4722450BD89323BDD1360@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <20190501054655.15525-1-leon@kernel.org>
 <20190503134412.GA11087@mellanox.com>
In-Reply-To: <20190503134412.GA11087@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [68.203.16.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e6b0025-ec12-40b5-5c36-08d6d033791a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0501MB2176;
x-ms-traffictypediagnostic: VI1PR0501MB2176:
x-microsoft-antispam-prvs: <VI1PR0501MB21769A4301093937133416CBD1360@VI1PR0501MB2176.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0027ED21E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(376002)(136003)(13464003)(199004)(189003)(256004)(53936002)(99286004)(66066001)(6116002)(33656002)(68736007)(76116006)(305945005)(7696005)(9686003)(14454004)(64756008)(66446008)(66476007)(55016002)(73956011)(66556008)(4326008)(107886003)(6246003)(66946007)(25786009)(26005)(81166006)(71200400001)(3846002)(81156014)(8676002)(71190400001)(186003)(86362001)(76176011)(7736002)(2906002)(8936002)(476003)(486006)(11346002)(102836004)(6436002)(446003)(74316002)(54906003)(110136005)(316002)(229853002)(53546011)(6506007)(478600001)(5660300002)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2176;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p6/adRy9Dy1tQNONmYKtOvLmmbXRlfYkG6DA/4pJydKyyF2wmVL2m+zTcGCpjk2nNIVEsD9/UrFLTk+f5POFJwHGQhKBwEjVnurHX5rN/UX1DpFrkJZ/+xkgKCTA3soBBcG5u5VhxISiWL/MS02HVI5cCC7H0Wp9Fj20eaOwjAL+N47MDqTulMNx8cLiO9MjPAjZvYeLy0RmFtWmLt/LM4U9zuCdR2loGopPZJIQo/1DVh9goyqs1yijF6ZiH/p6PenCGR9u3FPiO5EekKKOPzNEwS33S7ZYPU+n67dgIdMafjpOE7QpdvdrOFbeFcA0AOAHVGMVkM4HYGHaH3cx1PadKk87c21BC15D8QVKBpJ4UpwA8YMJZrt7N+fFnlY1ZNMDhPorswkyUG8ysLyw8AZ46LLPtsJAw2cRlKM+ssQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6b0025-ec12-40b5-5c36-08d6d033791a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2019 01:54:41.2343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2176
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe
> Sent: Friday, May 3, 2019 5:50 PM
> To: Leon Romanovsky <leon@kernel.org>
> Cc: Doug Ledford <dledford@redhat.com>; Parav Pandit
> <parav@mellanox.com>; RDMA mailing list <linux-rdma@vger.kernel.org>;
> Mike Marciniszyn <mike.marciniszyn@intel.com>; Leon Romanovsky
> <leonro@mellanox.com>
> Subject: Re: [PATCH rdma-next] RDMA/core: Do not invoke init_port on
> compat devices
>=20
> On Wed, May 01, 2019 at 08:46:55AM +0300, Leon Romanovsky wrote:
> > From: Parav Pandit <parav@mellanox.com>
> >
> > As compat devices in net namespaces may not need vendor specific
> > control attributes, avoid invoking init_port() on them.
> >
> > This avoids below reported call trace.
> >
> > Call Trace:
> > dump_stack+0x5a/0x73
> > kobject_init+0x74/0x80
> > kobject_init_and_add+0x35/0xb0
> > hfi1_create_port_files+0x6e/0x3c0 [hfi1]
> > ib_setup_port_attrs+0x43b/0x560 [ib_core]
> > add_one_compat_dev+0x16a/0x230 [ib_core]
> > rdma_dev_init_net+0x110/0x160 [ib_core]
> > ops_init+0x38/0xf0
> > setup_net+0xcf/0x1e0
> > copy_net_ns+0xb7/0x130
> > create_new_namespaces+0x11a/0x1b0
> > unshare_nsproxy_namespaces+0x55/0xa0
> > ksys_unshare+0x1a7/0x340
> > __x64_sys_unshare+0xe/0x20
> > do_syscall_64+0x5b/0x180
> > entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Fixes: 5417783eabb2 ("RDMA/core: Support core port attributes in non
> > init_net")
> > Reported-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> > Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/core/core_priv.h |  2 +-
> >  drivers/infiniband/core/sysfs.c     | 13 +++++++------
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/core_priv.h
> > b/drivers/infiniband/core/core_priv.h
> > index 2764647056d8..77956c42358e 100644
> > --- a/drivers/infiniband/core/core_priv.h
> > +++ b/drivers/infiniband/core/core_priv.h
> > @@ -342,7 +342,7 @@ struct net_device
> > *rdma_read_gid_attr_ndev_rcu(const struct ib_gid_attr *attr);
> >
> >  void ib_free_port_attrs(struct ib_core_device *coredev);  int
> > ib_setup_port_attrs(struct ib_core_device *coredev,
> > -			bool alloc_hw_stats);
> > +			bool init_port_alloc_stats);
>=20
> Yuk this name is ugly. I reworked it a bit and put this in the wip branch=
,
> please check it:
>
Patch looks good.
I kept the flag to keep door open in case if user requires stats in ns.
But its fine, we can work through it at later point if required.

=20
> commit eb15c78b05bd9fbac45ee5b56aaf29b2570b5238
> Author: Parav Pandit <parav@mellanox.com>
> Date:   Wed May 1 08:46:55 2019 +0300
>=20
>     RDMA/core: Do not invoke init_port on compat devices
>=20
>     The driver interface cannot manipulate the sysfs of the compat device=
,
>     only of the full device so we must avoid calling the driver sysfs API=
s on
>     compat devices.
>=20
>     This prevents an oops:
>=20
>      Call Trace:
>      dump_stack+0x5a/0x73
>      kobject_init+0x74/0x80
>      kobject_init_and_add+0x35/0xb0
>      hfi1_create_port_files+0x6e/0x3c0 [hfi1]
>      ib_setup_port_attrs+0x43b/0x560 [ib_core]
>      add_one_compat_dev+0x16a/0x230 [ib_core]
>      rdma_dev_init_net+0x110/0x160 [ib_core]
>      ops_init+0x38/0xf0
>      setup_net+0xcf/0x1e0
>      copy_net_ns+0xb7/0x130
>      create_new_namespaces+0x11a/0x1b0
>      unshare_nsproxy_namespaces+0x55/0xa0
>      ksys_unshare+0x1a7/0x340
>      __x64_sys_unshare+0xe/0x20
>      do_syscall_64+0x5b/0x180
>      entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
>     Fixes: 5417783eabb2 ("RDMA/core: Support core port attributes in non
> init_net")
>     Reported-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
>     Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
>     Signed-off-by: Parav Pandit <parav@mellanox.com>
>     Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>     Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>=20
> diff --git a/drivers/infiniband/core/core_priv.h
> b/drivers/infiniband/core/core_priv.h
> index 2764647056d8fd..ff40a450b5d28e 100644
> --- a/drivers/infiniband/core/core_priv.h
> +++ b/drivers/infiniband/core/core_priv.h
> @@ -341,8 +341,7 @@ int roce_resolve_route_from_path(struct
> sa_path_rec *rec,  struct net_device *rdma_read_gid_attr_ndev_rcu(const
> struct ib_gid_attr *attr);
>=20
>  void ib_free_port_attrs(struct ib_core_device *coredev); -int
> ib_setup_port_attrs(struct ib_core_device *coredev,
> -			bool alloc_hw_stats);
> +int ib_setup_port_attrs(struct ib_core_device *coredev);
>=20
>  int rdma_compatdev_set(u8 enable);
>=20
> diff --git a/drivers/infiniband/core/device.c
> b/drivers/infiniband/core/device.c
> index 76088655f06ef7..2123cc693a2959 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -870,7 +870,7 @@ static int add_one_compat_dev(struct ib_device
> *device,
>  	ret =3D device_add(&cdev->dev);
>  	if (ret)
>  		goto add_err;
> -	ret =3D ib_setup_port_attrs(cdev, false);
> +	ret =3D ib_setup_port_attrs(cdev);
>  	if (ret)
>  		goto port_err;
>=20
> diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sy=
sfs.c
> index 2fe89754e59207..7a599c5e455fa9 100644
> --- a/drivers/infiniband/core/sysfs.c
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -1015,10 +1015,10 @@ static void setup_hw_stats(struct ib_device
> *device, struct ib_port *port,
>  	return;
>  }
>=20
> -static int add_port(struct ib_core_device *coredev,
> -		    int port_num, bool alloc_stats)
> +static int add_port(struct ib_core_device *coredev, int port_num)
>  {
>  	struct ib_device *device =3D rdma_device_to_ibdev(&coredev->dev);
> +	bool is_full_dev =3D &device->coredev =3D=3D coredev;
>  	struct ib_port *p;
>  	struct ib_port_attr attr;
>  	int i;
> @@ -1057,7 +1057,7 @@ static int add_port(struct ib_core_device *coredev,
>  		goto err_put;
>  	}
>=20
> -	if (device->ops.process_mad && alloc_stats) {
> +	if (device->ops.process_mad && is_full_dev) {
>  		p->pma_table =3D get_counter_table(device, port_num);
>  		ret =3D sysfs_create_group(&p->kobj, p->pma_table);
>  		if (ret)
> @@ -1113,7 +1113,7 @@ static int add_port(struct ib_core_device *coredev,
>  	if (ret)
>  		goto err_free_pkey;
>=20
> -	if (device->ops.init_port) {
> +	if (device->ops.init_port && is_full_dev) {
>  		ret =3D device->ops.init_port(device, port_num, &p->kobj);
>  		if (ret)
>  			goto err_remove_pkey;
> @@ -1124,7 +1124,7 @@ static int add_port(struct ib_core_device *coredev,
>  	 * port, so holder should be device. Therefore skip per port conunter
>  	 * initialization.
>  	 */
> -	if (device->ops.alloc_hw_stats && port_num && alloc_stats)
> +	if (device->ops.alloc_hw_stats && port_num && is_full_dev)
>  		setup_hw_stats(device, p, port_num);
>=20
>  	list_add_tail(&p->kobj.entry, &coredev->port_list); @@ -1308,7
> +1308,7 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
>  	kobject_put(coredev->ports_kobj);
>  }
>=20
> -int ib_setup_port_attrs(struct ib_core_device *coredev, bool alloc_stats=
)
> +int ib_setup_port_attrs(struct ib_core_device *coredev)
>  {
>  	struct ib_device *device =3D rdma_device_to_ibdev(&coredev->dev);
>  	unsigned int port;
> @@ -1320,7 +1320,7 @@ int ib_setup_port_attrs(struct ib_core_device
> *coredev, bool alloc_stats)
>  		return -ENOMEM;
>=20
>  	rdma_for_each_port (device, port) {
> -		ret =3D add_port(coredev, port, alloc_stats);
> +		ret =3D add_port(coredev, port);
>  		if (ret)
>  			goto err_put;
>  	}
> @@ -1336,7 +1336,7 @@ int ib_device_register_sysfs(struct ib_device
> *device)  {
>  	int ret;
>=20
> -	ret =3D ib_setup_port_attrs(&device->coredev, true);
> +	ret =3D ib_setup_port_attrs(&device->coredev);
>  	if (ret)
>  		return ret;
>=20
