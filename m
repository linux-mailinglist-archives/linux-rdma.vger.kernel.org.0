Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12560135DA
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2019 00:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfECWtp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 18:49:45 -0400
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:8165
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbfECWtp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 May 2019 18:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OL98wtGijlXnz4YcOnCsETbyslRXJd8ylrjSYb9kxbg=;
 b=kIy06Y6HyZrmcP/8wW0XfBBIzleOuyUtEH4Db0L2sO9UYXsGxBDyFZWGhnkcJXxvkWEZ0NvLniinAD5ot5n4hkYKwZe/BjMQtvGwLGrSIxsDZRTdQwdOSO3XKjvAVgF4C0QHq7HSxg5yhZWVNBdF5MAy7SH8sgOxovaq+Cl3PWI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5213.eurprd05.prod.outlook.com (20.178.12.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Fri, 3 May 2019 22:49:38 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Fri, 3 May 2019
 22:49:38 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Do not invoke init_port on compat
 devices
Thread-Topic: [PATCH rdma-next] RDMA/core: Do not invoke init_port on compat
 devices
Thread-Index: AQHU/+FOPfJRXDHnQ0Gk5AS+YwHVBqZZbNIA
Date:   Fri, 3 May 2019 22:49:38 +0000
Message-ID: <20190503134412.GA11087@mellanox.com>
References: <20190501054655.15525-1-leon@kernel.org>
In-Reply-To: <20190501054655.15525-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:208:2d::49) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [65.119.211.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7750925c-2d87-48d3-6d8c-08d6d0199f23
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5213;
x-ms-traffictypediagnostic: VI1PR05MB5213:
x-microsoft-antispam-prvs: <VI1PR05MB52136A64F91B2240B457A876CF350@VI1PR05MB5213.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(136003)(376002)(199004)(189003)(256004)(6116002)(3846002)(99286004)(33656002)(66066001)(68736007)(305945005)(6916009)(53936002)(6512007)(66446008)(64756008)(66556008)(66476007)(73956011)(1076003)(4326008)(6246003)(107886003)(14454004)(25786009)(66946007)(26005)(7736002)(81156014)(8676002)(71200400001)(81166006)(71190400001)(86362001)(6436002)(76176011)(186003)(2906002)(476003)(102836004)(486006)(2616005)(11346002)(52116002)(446003)(8936002)(54906003)(316002)(229853002)(6506007)(386003)(478600001)(6486002)(5660300002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5213;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: itqtuE+nCK/TDhqHoeY3obGqpvdnPIhW1lSMgQM4+RQuLSlSBVtKxzjpjEracAFmmyMF50LbvhJVEZtiFIpWj3ULvPNV/QUiQwAiz7PR1fXqZF7mkIRyH2J6obgpyE8utKB5otMi0F9P45FULJh+xOlyC6iPs50kGLaFwYVxQhBxom/wlnxNZ6QTc5+dNDnlDRfRTxaFClA46bjcEpzB+d4AMYMLHYa44ZlLhavtq9d7LY3w3odaSONzdSvdY5oNxq4Ada/PDZFkmnaKMhvdOxQM5OpYa7dHKwNKFnz6Odm88+ZfJoQ/2EMmYD0bfUXf9bIpxEhvT3V0GLx1Hc2N5mVTeuLVfkrN/r8s+5fy3+ZMd6m1a5m77yfeB2C7mSOJ8LW2oCcA6we/8xXsm8o4WfCWJ/6yGx39Hs9Ge7eQYqg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ABD7AE2BD7F3D147BF3A8E06EE19278F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7750925c-2d87-48d3-6d8c-08d6d0199f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 22:49:38.5575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5213
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 01, 2019 at 08:46:55AM +0300, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
>=20
> As compat devices in net namespaces may not need vendor specific control
> attributes, avoid invoking init_port() on them.
>=20
> This avoids below reported call trace.
>=20
> Call Trace:
> dump_stack+0x5a/0x73
> kobject_init+0x74/0x80
> kobject_init_and_add+0x35/0xb0
> hfi1_create_port_files+0x6e/0x3c0 [hfi1]
> ib_setup_port_attrs+0x43b/0x560 [ib_core]
> add_one_compat_dev+0x16a/0x230 [ib_core]
> rdma_dev_init_net+0x110/0x160 [ib_core]
> ops_init+0x38/0xf0
> setup_net+0xcf/0x1e0
> copy_net_ns+0xb7/0x130
> create_new_namespaces+0x11a/0x1b0
> unshare_nsproxy_namespaces+0x55/0xa0
> ksys_unshare+0x1a7/0x340
> __x64_sys_unshare+0xe/0x20
> do_syscall_64+0x5b/0x180
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> Fixes: 5417783eabb2 ("RDMA/core: Support core port attributes in non init=
_net")
> Reported-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/core_priv.h |  2 +-
>  drivers/infiniband/core/sysfs.c     | 13 +++++++------
>  2 files changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/cor=
e/core_priv.h
> index 2764647056d8..77956c42358e 100644
> --- a/drivers/infiniband/core/core_priv.h
> +++ b/drivers/infiniband/core/core_priv.h
> @@ -342,7 +342,7 @@ struct net_device *rdma_read_gid_attr_ndev_rcu(const =
struct ib_gid_attr *attr);
> =20
>  void ib_free_port_attrs(struct ib_core_device *coredev);
>  int ib_setup_port_attrs(struct ib_core_device *coredev,
> -			bool alloc_hw_stats);
> +			bool init_port_alloc_stats);

Yuk this name is ugly. I reworked it a bit and put this in the wip
branch, please check it:

commit eb15c78b05bd9fbac45ee5b56aaf29b2570b5238
Author: Parav Pandit <parav@mellanox.com>
Date:   Wed May 1 08:46:55 2019 +0300

    RDMA/core: Do not invoke init_port on compat devices
   =20
    The driver interface cannot manipulate the sysfs of the compat device,
    only of the full device so we must avoid calling the driver sysfs APIs =
on
    compat devices.
   =20
    This prevents an oops:
   =20
     Call Trace:
     dump_stack+0x5a/0x73
     kobject_init+0x74/0x80
     kobject_init_and_add+0x35/0xb0
     hfi1_create_port_files+0x6e/0x3c0 [hfi1]
     ib_setup_port_attrs+0x43b/0x560 [ib_core]
     add_one_compat_dev+0x16a/0x230 [ib_core]
     rdma_dev_init_net+0x110/0x160 [ib_core]
     ops_init+0x38/0xf0
     setup_net+0xcf/0x1e0
     copy_net_ns+0xb7/0x130
     create_new_namespaces+0x11a/0x1b0
     unshare_nsproxy_namespaces+0x55/0xa0
     ksys_unshare+0x1a7/0x340
     __x64_sys_unshare+0xe/0x20
     do_syscall_64+0x5b/0x180
     entry_SYSCALL_64_after_hwframe+0x44/0xa9
   =20
    Fixes: 5417783eabb2 ("RDMA/core: Support core port attributes in non in=
it_net")
    Reported-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
    Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
    Signed-off-by: Parav Pandit <parav@mellanox.com>
    Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/=
core_priv.h
index 2764647056d8fd..ff40a450b5d28e 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -341,8 +341,7 @@ int roce_resolve_route_from_path(struct sa_path_rec *re=
c,
 struct net_device *rdma_read_gid_attr_ndev_rcu(const struct ib_gid_attr *a=
ttr);
=20
 void ib_free_port_attrs(struct ib_core_device *coredev);
-int ib_setup_port_attrs(struct ib_core_device *coredev,
-			bool alloc_hw_stats);
+int ib_setup_port_attrs(struct ib_core_device *coredev);
=20
 int rdma_compatdev_set(u8 enable);
=20
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c
index 76088655f06ef7..2123cc693a2959 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -870,7 +870,7 @@ static int add_one_compat_dev(struct ib_device *device,
 	ret =3D device_add(&cdev->dev);
 	if (ret)
 		goto add_err;
-	ret =3D ib_setup_port_attrs(cdev, false);
+	ret =3D ib_setup_port_attrs(cdev);
 	if (ret)
 		goto port_err;
=20
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysf=
s.c
index 2fe89754e59207..7a599c5e455fa9 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1015,10 +1015,10 @@ static void setup_hw_stats(struct ib_device *device=
, struct ib_port *port,
 	return;
 }
=20
-static int add_port(struct ib_core_device *coredev,
-		    int port_num, bool alloc_stats)
+static int add_port(struct ib_core_device *coredev, int port_num)
 {
 	struct ib_device *device =3D rdma_device_to_ibdev(&coredev->dev);
+	bool is_full_dev =3D &device->coredev =3D=3D coredev;
 	struct ib_port *p;
 	struct ib_port_attr attr;
 	int i;
@@ -1057,7 +1057,7 @@ static int add_port(struct ib_core_device *coredev,
 		goto err_put;
 	}
=20
-	if (device->ops.process_mad && alloc_stats) {
+	if (device->ops.process_mad && is_full_dev) {
 		p->pma_table =3D get_counter_table(device, port_num);
 		ret =3D sysfs_create_group(&p->kobj, p->pma_table);
 		if (ret)
@@ -1113,7 +1113,7 @@ static int add_port(struct ib_core_device *coredev,
 	if (ret)
 		goto err_free_pkey;
=20
-	if (device->ops.init_port) {
+	if (device->ops.init_port && is_full_dev) {
 		ret =3D device->ops.init_port(device, port_num, &p->kobj);
 		if (ret)
 			goto err_remove_pkey;
@@ -1124,7 +1124,7 @@ static int add_port(struct ib_core_device *coredev,
 	 * port, so holder should be device. Therefore skip per port conunter
 	 * initialization.
 	 */
-	if (device->ops.alloc_hw_stats && port_num && alloc_stats)
+	if (device->ops.alloc_hw_stats && port_num && is_full_dev)
 		setup_hw_stats(device, p, port_num);
=20
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
@@ -1308,7 +1308,7 @@ void ib_free_port_attrs(struct ib_core_device *corede=
v)
 	kobject_put(coredev->ports_kobj);
 }
=20
-int ib_setup_port_attrs(struct ib_core_device *coredev, bool alloc_stats)
+int ib_setup_port_attrs(struct ib_core_device *coredev)
 {
 	struct ib_device *device =3D rdma_device_to_ibdev(&coredev->dev);
 	unsigned int port;
@@ -1320,7 +1320,7 @@ int ib_setup_port_attrs(struct ib_core_device *corede=
v, bool alloc_stats)
 		return -ENOMEM;
=20
 	rdma_for_each_port (device, port) {
-		ret =3D add_port(coredev, port, alloc_stats);
+		ret =3D add_port(coredev, port);
 		if (ret)
 			goto err_put;
 	}
@@ -1336,7 +1336,7 @@ int ib_device_register_sysfs(struct ib_device *device=
)
 {
 	int ret;
=20
-	ret =3D ib_setup_port_attrs(&device->coredev, true);
+	ret =3D ib_setup_port_attrs(&device->coredev);
 	if (ret)
 		return ret;
=20
