Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 795C762FE9
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 07:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfGIFZx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 01:25:53 -0400
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:16632
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbfGIFZx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Jul 2019 01:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx3xdHlLC+NXeR4kgfL1jgfNoZQulUTrl2b5aAtPW+s=;
 b=oIo/Y2crBrgeEHlzAjnaZvWujq2rkmcONHNeTZ4yiiancnLtH/26R2uVKzwPlkJ1LvEQhA0sjiRyJfQ/eXKg00ekauzU7XFMcKaQQut+t5p/bUViNtK7MH5YCBKBTMrMtLRwUgqXukQtkAVojm+TMgYEx9bBpGK7WMVJJkBe6Pk=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6417.eurprd05.prod.outlook.com (20.179.35.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Tue, 9 Jul 2019 05:25:09 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::217d:2cd7:c8da:9279]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::217d:2cd7:c8da:9279%5]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 05:25:09 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: RE: [PATCH rdma-next] RDMA/core: Annotate destroy of mutex to ensure
 that it is released as unlocked
Thread-Topic: [PATCH rdma-next] RDMA/core: Annotate destroy of mutex to ensure
 that it is released as unlocked
Thread-Index: AQHVMmhxKjOzj89pa0iSATWqBIqqXqbBKvkAgACdTDA=
Date:   Tue, 9 Jul 2019 05:25:09 +0000
Message-ID: <AM0PR05MB486691B6892C99F8E8867B59D1F10@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20190704130012.8177-1-leon@kernel.org>
 <20190708200114.GA25699@ziepe.ca>
In-Reply-To: <20190708200114.GA25699@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [122.172.186.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5f91845-4533-4f56-9dff-08d7042dcf66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB6417;
x-ms-traffictypediagnostic: AM0PR05MB6417:
x-microsoft-antispam-prvs: <AM0PR05MB64173BD7C7E250FD7B1D981AD1F10@AM0PR05MB6417.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:369;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(13464003)(4326008)(229853002)(68736007)(11346002)(107886003)(55236004)(102836004)(6506007)(53546011)(66946007)(66556008)(66476007)(446003)(486006)(64756008)(66446008)(7696005)(76116006)(99286004)(86362001)(14454004)(55016002)(52536014)(186003)(2906002)(73956011)(25786009)(26005)(6246003)(476003)(71200400001)(81156014)(74316002)(478600001)(305945005)(81166006)(8676002)(7736002)(14444005)(8936002)(9686003)(256004)(5660300002)(76176011)(53936002)(316002)(6116002)(66066001)(71190400001)(3846002)(6436002)(110136005)(33656002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6417;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vDEKQl0rohfr4++kJRwCPIUFyTj8gn+jPctB38xKvXQ+k6FJEIOsIuosqqqRBx6xqxBXHEAyuBubwBFt9RUTkqQbV+B21PrtjxSfyEJcsYc1ymFdemLB5scM1jJ0z5+SrI/MivBdxhEpSwrTZVNEtlJs0heq/qo0schV5mNUe3D/s/1/T6I0aTm8Ep8Z6VGBWZ7dV8ugmk1HU4M+SOe1ynHRiIQUqmVmXDAXOaT+QmdUzrFOT2j748bZxRydi0bN2qsR/kvngvDZGE640RublWj4k8NPpaEl6Dw6BJ7mLQ0iifbj9tCW60yIEu7rRIWifSeu87Hn1TQUMVlEGjwnHlW3lch4HQjWbmPD1r2Pl7CJ2f2BuEojRfasFcdmDkOe/Isbrv/iG1kZ8dU1SLO5JdvB/ZKQCKVtb27Z7SLNJTs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f91845-4533-4f56-9dff-08d7042dcf66
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 05:25:09.4293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: parav@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6417
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, July 9, 2019 1:31 AM
> To: Leon Romanovsky <leon@kernel.org>
> Cc: Doug Ledford <dledford@redhat.com>; Parav Pandit
> <parav@mellanox.com>; RDMA mailing list <linux-rdma@vger.kernel.org>;
> Leon Romanovsky <leonro@mellanox.com>
> Subject: Re: [PATCH rdma-next] RDMA/core: Annotate destroy of mutex to
> ensure that it is released as unlocked
>=20
> On Thu, Jul 04, 2019 at 04:00:12PM +0300, Leon Romanovsky wrote:
> > From: Parav Pandit <parav@mellanox.com>
> >
> > While compiled with CONFIG_DEBUG_MUTEXES, the kernel ensures that
> > mutex is not held during destroy.
> > Hence add mutex_destroy() for mutexes used in RDMA modules.
> >
> > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/cache.c        | 1 +
> >  drivers/infiniband/core/cma_configfs.c | 1 +
> >  drivers/infiniband/core/device.c       | 3 +++
> >  drivers/infiniband/core/user_mad.c     | 2 +-
> >  drivers/infiniband/core/uverbs_main.c  | 2 ++
> >  drivers/infiniband/core/verbs.c        | 1 +
> >  6 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/core/cache.c
> > b/drivers/infiniband/core/cache.c index 18e476b3ced0..00fb3eacda19
> > 100644
> > +++ b/drivers/infiniband/core/cache.c
> > @@ -810,6 +810,7 @@ static void release_gid_table(struct ib_device
> *device,
> >  	if (leak)
> >  		return;
> >
> > +	mutex_destroy(&table->lock);
> >  	kfree(table->data_vec);
> >  	kfree(table);
> >  }
> > diff --git a/drivers/infiniband/core/cma_configfs.c
> > b/drivers/infiniband/core/cma_configfs.c
> > index 3ec2c415bb70..0a7b5eba2fc0 100644
> > +++ b/drivers/infiniband/core/cma_configfs.c
> > @@ -350,4 +350,5 @@ int __init cma_configfs_init(void)  void __exit
> > cma_configfs_exit(void)  {
> >  	configfs_unregister_subsystem(&cma_subsys);
> > +	mutex_destroy(&cma_subsys.su_mutex);
> >  }
>=20
> There is a missing mutex_destroy in cma_configfs_init's error path.
>=20
Ack. Adding it.

> > diff --git a/drivers/infiniband/core/device.c
> > b/drivers/infiniband/core/device.c
> > index 7f4affe8a10d..adf8d93bb42d 100644
> > +++ b/drivers/infiniband/core/device.c
> > @@ -508,6 +508,9 @@ static void ib_device_release(struct device *device=
)
> >  			  rcu_head);
> >  	}
> >
> > +	mutex_destroy(&dev->unregistration_lock);
> > +	mutex_destroy(&dev->compat_devs_mutex);
> > +
> >  	xa_destroy(&dev->compat_devs);
> >  	xa_destroy(&dev->client_data);
> >  	kfree_rcu(dev, rcu_head);
> > diff --git a/drivers/infiniband/core/user_mad.c
> > b/drivers/infiniband/core/user_mad.c
> > index 9f8a48016b41..e0512aef033c 100644
> > +++ b/drivers/infiniband/core/user_mad.c
> > @@ -1038,7 +1038,7 @@ static int ib_umad_close(struct inode *inode, str=
uct
> file *filp)
> >  				ib_unregister_mad_agent(file->agent[i]);
> >
> >  	mutex_unlock(&file->port->file_mutex);
> > -
> > +	mutex_destroy(&file->mutex);
> >  	kfree(file);
>=20
> The file->port->file_mutex is missing a destroy in ib_umad_dev_free (bit =
tricky
> to do)
>=20
I will leave this for now and address in second iteration.

> >  	return 0;
> >  }
> > diff --git a/drivers/infiniband/core/uverbs_main.c
> > b/drivers/infiniband/core/uverbs_main.c
> > index 11c13c1381cf..4827aa3415ff 100644
> > +++ b/drivers/infiniband/core/uverbs_main.c
> > @@ -120,6 +120,8 @@ static void ib_uverbs_release_dev(struct device
> > *device)
> >
> >  	uverbs_destroy_api(dev->uapi);
> >  	cleanup_srcu_struct(&dev->disassociate_srcu);
> > +	mutex_destroy(&dev->lists_mutex);
> > +	mutex_destroy(&dev->xrcd_tree_mutex);
>=20
> This file also has ucontext_lock and umap_lock that are missing destroy
>=20
Ack. Adding it.
