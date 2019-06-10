Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3853B7B6
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 16:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389952AbfFJOrr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 10:47:47 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:20096
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389123AbfFJOrr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 10:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOVvcnElFQ/HfCZxgopNZ91lj4xpgvFU35giG/ctAaQ=;
 b=h08YdmnF49N5Oj7Wimc8Pa4yERqENnJFrSyQbTJBHtZbz/r2HO0YCtP0S5D4gLYoQO6oJxjBp/eF4B3tLHtYbTB/CpnRfdl0LR9ft8zbSf1pMrFtxLLaEkWjdZIlL0i9T1z0P8NFtBBAydCah2m62PrXSxeLZNvO/ahOKxywizE=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6237.eurprd05.prod.outlook.com (20.178.124.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Mon, 10 Jun 2019 14:47:42 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 14:47:42 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
Thread-Topic: [PATCH 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
Thread-Index: AQHVG80bFOvkY5wVCk6VfUFwXkpPS6aU+IaAgAAGw4A=
Date:   Mon, 10 Jun 2019 14:47:42 +0000
Message-ID: <20190610144737.GE18446@mellanox.com>
References: <20190605183252.6687-1-jgg@ziepe.ca>
 <20190605183252.6687-3-jgg@ziepe.ca>
 <20190610142325.GC6369@mtr-leonro.mtl.com>
In-Reply-To: <20190610142325.GC6369@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::40) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29c905de-09b3-4001-1dbf-08d6edb2975e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6237;
x-ms-traffictypediagnostic: VI1PR05MB6237:
x-microsoft-antispam-prvs: <VI1PR05MB6237C1B946AB7C1E8F91CBDCCF130@VI1PR05MB6237.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(71200400001)(68736007)(229853002)(26005)(71190400001)(3846002)(6116002)(99286004)(2906002)(6436002)(486006)(14454004)(4326008)(476003)(316002)(25786009)(186003)(446003)(386003)(6506007)(6486002)(36756003)(2616005)(11346002)(86362001)(33656002)(76176011)(53936002)(1076003)(305945005)(7736002)(6246003)(478600001)(66066001)(102836004)(5660300002)(66946007)(81166006)(66446008)(66476007)(66556008)(64756008)(81156014)(6512007)(52116002)(73956011)(256004)(14444005)(8936002)(8676002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6237;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c/Ipv3lO7Dmgy+zLA1nj/p2JMai7tK9+ftatnRp055impGnthdsIOhE9BlJ6iy6i9dsmwTyE8Yq1kKXcq8/VLq66iiBDnXG+Ji1C2Kzcr2EWH7vXmvA/tz618uRHWz23nDFzT6Z/LVowuTQugSd4/jv2w1lrk2tRqgGe+7IjQPpq4SaZ6CZwvrqOnvJOJL9ZO7YZieIVaHZBO/0/Xdqm+qlilhfy5Zu91gJoPrF5rgp7iKvlvA9vaC8Z4ag/hlSdsOSkdlYZ0RmC8pL26Wl33ciFU1GFPTZ64T4adPAUSDgAF18N/jjCRSE6nRd2GLREl93kyehbX8vuSwel6AxVp5Y4qcBfBMhkDL6A7HeoZ+cSXgFLuUjWGaYf/dZSh7yi7u/j2E2IV9/y2cOAzczqeFDuxH7wOW8nIQDog1PlqNI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E34AD36998CB7743BB990D0D64376BD9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c905de-09b3-4001-1dbf-08d6edb2975e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 14:47:42.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6237
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 10, 2019 at 05:23:25PM +0300, Leon Romanovsky wrote:
> On Wed, Jun 05, 2019 at 03:32:51PM -0300, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >
> > Allow userspace to issue a netlink query against the ib_device for
> > something like "uverbs" and get back the char dev name, inode major/min=
or,
> > and interface ABI information for "uverbs0".
> >
> > Since we are now in netlink this can also trigger a module autoload to
> > make the uverbs device come into existence.
> >
> > Largely this will let us replace searching and reading inside sysfs to
> > setup devices, and provides an alternative (using driver_id) to device
> > name based provider binding for things like rxe.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> >  drivers/infiniband/core/core_priv.h |  9 +++
> >  drivers/infiniband/core/device.c    | 88 ++++++++++++++++++++++++++++
> >  drivers/infiniband/core/nldev.c     | 91 +++++++++++++++++++++++++++++
> >  include/rdma/ib_verbs.h             |  4 ++
> >  include/rdma/rdma_netlink.h         |  2 +
> >  include/uapi/rdma/rdma_netlink.h    | 10 ++++
> >  6 files changed, 204 insertions(+)
> >
> > diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/c=
ore/core_priv.h
> > index ff40a450b5d28e..a953c2fa2e7811 100644
> > +++ b/drivers/infiniband/core/core_priv.h
> > @@ -88,6 +88,15 @@ typedef int (*nldev_callback)(struct ib_device *devi=
ce,
> >  int ib_enum_all_devs(nldev_callback nldev_cb, struct sk_buff *skb,
> >  		     struct netlink_callback *cb);
> >
> > +struct ib_client_nl_info {
> > +	struct sk_buff *nl_msg;
> > +	struct device *cdev;
> > +	unsigned int port;
> > +	u64 abi;
> > +};
> > +int ib_get_client_nl_info(struct ib_device *ibdev, const char *client_=
name,
> > +			  struct ib_client_nl_info *res);
> > +
> >  enum ib_cache_gid_default_mode {
> >  	IB_CACHE_GID_DEFAULT_MODE_SET,
> >  	IB_CACHE_GID_DEFAULT_MODE_DELETE
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core=
/device.c
> > index 49e5ea3a530f53..80e7911951f6f6 100644
> > +++ b/drivers/infiniband/core/device.c
> > @@ -1749,6 +1749,94 @@ void ib_unregister_client(struct ib_client *clie=
nt)
> >  }
> >  EXPORT_SYMBOL(ib_unregister_client);
> >
> > +static int __ib_get_client_nl_info(struct ib_device *ibdev,
> > +				   const char *client_name,
> > +				   struct ib_client_nl_info *res)
> > +{
> > +	unsigned long index;
> > +	void *client_data;
> > +	int ret =3D -ENOENT;
> > +
> > +	if (!ibdev) {
> > +		struct ib_client *client;
> > +
> > +		down_read(&clients_rwsem);
> > +		xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
> > +			if (strcmp(client->name, client_name) !=3D 0)
> > +				continue;
> > +			if (!client->get_global_nl_info) {
> > +				ret =3D -EOPNOTSUPP;
> > +				break;
> > +			}
> > +			ret =3D client->get_global_nl_info(res);
> > +			if (WARN_ON(ret =3D=3D -ENOENT))
>=20
> You are putting to much WARN_ON, sometimes printk can be enough.

One should not use printk for a kernel bug. It just makes debugging
harder. This is the appropriate pattern for 'things that cannot happen'


> > +				ret =3D -EINVAL;
> > +			if (!ret && res->cdev)
> > +				get_device(res->cdev);
> > +			break;
> > +		}
> > +		up_read(&clients_rwsem);
> > +		return ret;
>=20
> This flow is better to have in separate function, one function for
> loaded client and another for no-loaded.

Yah, maybe so

> > diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_=
netlink.h
> > index f588e8551c6cea..15eb861d1324f4 100644
> > +++ b/include/uapi/rdma/rdma_netlink.h
> > @@ -279,6 +279,8 @@ enum rdma_nldev_command {
> >
> >  	RDMA_NLDEV_CMD_RES_PD_GET, /* can dump */
> >
> > +	RDMA_NLDEV_CMD_GET_CHARDEV,
> > +
> >  	RDMA_NLDEV_NUM_OPS
> >  };
> >
> > @@ -491,6 +493,14 @@ enum rdma_nldev_attr {
> >  	 */
> >  	RDMA_NLDEV_NET_NS_FD,			/* u32 */
> >
> > +	/*
> > +	 * Information about a chardev
> > +	 */
> > +	RDMA_NLDEV_ATTR_CHARDEV_TYPE,		/* string */
> > +	RDMA_NLDEV_ATTR_CHARDEV_NAME,		/* string */
> > +	RDMA_NLDEV_ATTR_CHARDEV_ABI,		/* u64 */
> > +	RDMA_NLDEV_ATTR_CHARDEV,		/* u64 */
>=20
> Please document them, especially RDMA_NLDEV_ATTR_CHARDEV and
> RDMA_NLDEV_ATTR_CHARDEV_TYPE.

Where do you want to put them? There is a distinct lack of
documentation for the netlink attributes in this file. Every one I
wanted to use I had to look up the implementation.

Jason
