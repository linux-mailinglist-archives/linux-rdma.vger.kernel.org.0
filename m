Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA2D74A09F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 14:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfFRMTM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 08:19:12 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:54404
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfFRMTM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jun 2019 08:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRFcMgafkRr4aUm482IX+QRvdI8Ozc9GKAsozFKjTqE=;
 b=h3ifsvg51po8NjJSIw2ocYwr24D7tSXQlR2U/61RFgEKMWZQig+fX/CNhShjqQGD89c9uFeBc2MUleiC7EmOOTxp0zGNiQ++OEe0LJpQFHxOnKnqvAMGjRsdqquVY8TW028KX6KxdZZSakg0QWCB4fv3Cu6ny9L3/qNOP9FkBa8=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.186.14) by
 AM4PR05MB3169.eurprd05.prod.outlook.com (10.171.188.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Tue, 18 Jun 2019 12:19:05 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::bc5a:ba8b:1a69:91b6]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::bc5a:ba8b:1a69:91b6%6]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 12:19:05 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 3/3] RDMA: Report available cdevs through
 RDMA_NLDEV_CMD_GET_CHARDEV
Thread-Topic: [PATCH v2 3/3] RDMA: Report available cdevs through
 RDMA_NLDEV_CMD_GET_CHARDEV
Thread-Index: AQHVJdAFMtAvUj1NsEaredjo/1T89g==
Date:   Tue, 18 Jun 2019 12:19:04 +0000
Message-ID: <20190618121900.GL4690@mtr-leonro.mtl.com>
References: <20190614003819.19974-1-jgg@ziepe.ca>
 <20190614003819.19974-4-jgg@ziepe.ca>
In-Reply-To: <20190614003819.19974-4-jgg@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P195CA0008.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::21) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:3::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e58bf27b-41f2-4568-3385-08d6f3e7274b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3169;
x-ms-traffictypediagnostic: AM4PR05MB3169:
x-microsoft-antispam-prvs: <AM4PR05MB31691C680AADEB058798FC82B0EA0@AM4PR05MB3169.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(189003)(71200400001)(71190400001)(6916009)(14444005)(68736007)(81156014)(256004)(81166006)(5660300002)(8676002)(7736002)(53936002)(99286004)(14454004)(305945005)(1076003)(2906002)(316002)(54906003)(229853002)(3846002)(6512007)(6116002)(9686003)(8936002)(6436002)(64756008)(25786009)(66556008)(73956011)(66476007)(6506007)(102836004)(66446008)(478600001)(386003)(11346002)(26005)(107886003)(186003)(486006)(446003)(66946007)(33656002)(6486002)(6246003)(4326008)(52116002)(476003)(86362001)(66066001)(76176011)(131093003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3169;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8WeeNUtVHqDg+dtMZFo5O+rwCnbLrZqljznQdwL0YSCBMnTx6hfAdiHMDBmyEG8vNfW5X1lRiFi/veMjR3O1eRLBFgeRJ2dnDq2DJPl47obwsmxJVJww/kNiFd6NlcKKTo0TvVHe/y48i9Xws8+QfuPXFqMC1v+HBECRhHoWwltM2Jf/BObI2shZxOnjkaR7d3bynbXnUNMIK5C9osSfQiM2WQGJdTv2ICqjomD9y9vvwIjdmeVFuKg79KuKCNpVwb0Hy4sxsD2mgc2f5kCmTRbrbDDOZF0qrPF9K4LR0xm5B429L6pENcAer0clLmfcC+iNlB8nSWu99O65H+MyVgbRxH16DJRBJTlWxrLQ6Di5qlRXKi6j9Z/YduUxXdu6Em/b5JHt4P3YB2kpxj/8E9MTjRy7qeMeDEFec1o+QYo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A82B42A28B6E64695424D86E7A0FCC7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58bf27b-41f2-4568-3385-08d6f3e7274b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 12:19:05.3721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonro@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3169
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 13, 2019 at 09:38:19PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> Update the struct ib_client for all modules exporting cdevs related to th=
e
> ibdevice to also implement RDMA_NLDEV_CMD_GET_CHARDEV. All cdevs are now
> autoloadable and discoverable by userspace over netlink instead of relyin=
g
> on sysfs.
>
> uverbs also exposes the DRIVER_ID for drivers that are able to support
> driver id binding in rdma-core.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/device.c             |  3 ++
>  drivers/infiniband/core/ucma.c               | 23 +++++++++
>  drivers/infiniband/core/user_mad.c           | 51 ++++++++++++++++++--
>  drivers/infiniband/core/uverbs_main.c        | 32 +++++++++++-
>  drivers/infiniband/hw/cxgb3/iwch_provider.c  |  1 +
>  drivers/infiniband/hw/hns/hns_roce_main.c    |  1 +
>  drivers/infiniband/hw/mthca/mthca_provider.c |  1 +
>  include/rdma/ib_verbs.h                      |  1 +
>  include/uapi/rdma/rdma_netlink.h             |  1 +
>  9 files changed, 109 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index 7db8566cdb8904..1de4ae5d5e0ef6 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2428,6 +2428,9 @@ void ib_set_device_ops(struct ib_device *dev, const=
 struct ib_device_ops *ops)
>  	if (ops->uverbs_abi_ver)
>  		dev_ops->uverbs_abi_ver =3D ops->uverbs_abi_ver;
>
> +	dev_ops->uverbs_no_driver_id_binding |=3D
> +		ops->uverbs_no_driver_id_binding;
> +
>  	SET_DEVICE_OP(dev_ops, add_gid);
>  	SET_DEVICE_OP(dev_ops, advise_mr);
>  	SET_DEVICE_OP(dev_ops, alloc_dm);
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucm=
a.c
> index 39823c842202db..0274e9b704be59 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -52,6 +52,8 @@
>  #include <rdma/rdma_cm_ib.h>
>  #include <rdma/ib_addr.h>
>  #include <rdma/ib.h>
> +#include <rdma/rdma_netlink.h>
> +#include "core_priv.h"
>
>  MODULE_AUTHOR("Sean Hefty");
>  MODULE_DESCRIPTION("RDMA Userspace Connection Manager Access");
> @@ -1788,6 +1790,19 @@ static struct miscdevice ucma_misc =3D {
>  	.fops		=3D &ucma_fops,
>  };
>
> +static int ucma_get_global_nl_info(struct ib_client_nl_info *res)
> +{
> +	res->abi =3D RDMA_USER_CM_ABI_VERSION;
> +	res->cdev =3D ucma_misc.this_device;
> +	return 0;
> +}
> +
> +static struct ib_client rdma_cma_client =3D {
> +	.name =3D "rdma_cm",
> +	.get_global_nl_info =3D ucma_get_global_nl_info,
> +};
> +MODULE_ALIAS_RDMA_CLIENT("rdma_cm");
> +
>  static ssize_t show_abi_version(struct device *dev,
>  				struct device_attribute *attr,
>  				char *buf)
> @@ -1816,7 +1831,14 @@ static int __init ucma_init(void)
>  		ret =3D -ENOMEM;
>  		goto err2;
>  	}
> +
> +	ret =3D ib_register_client(&rdma_cma_client);
> +	if (ret)
> +		goto err3;
> +
>  	return 0;
> +err3:
> +	unregister_net_sysctl_table(ucma_ctl_table_hdr);
>  err2:
>  	device_remove_file(ucma_misc.this_device, &dev_attr_abi_version);
>  err1:
> @@ -1826,6 +1848,7 @@ static int __init ucma_init(void)
>
>  static void __exit ucma_cleanup(void)
>  {
> +	ib_unregister_client(&rdma_cma_client);
>  	unregister_net_sysctl_table(ucma_ctl_table_hdr);
>  	device_remove_file(ucma_misc.this_device, &dev_attr_abi_version);
>  	misc_deregister(&ucma_misc);
> diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core=
/user_mad.c
> index 671f07ba1fad66..547090b41cfbb7 100644
> --- a/drivers/infiniband/core/user_mad.c
> +++ b/drivers/infiniband/core/user_mad.c
> @@ -54,6 +54,7 @@
>
>  #include <rdma/ib_mad.h>
>  #include <rdma/ib_user_mad.h>
> +#include <rdma/rdma_netlink.h>
>
>  #include "core_priv.h"
>
> @@ -1124,11 +1125,48 @@ static const struct file_operations umad_sm_fops =
=3D {
>  	.llseek	 =3D no_llseek,
>  };
>
> +static int ib_umad_get_nl_info(struct ib_device *ibdev, void *client_dat=
a,
> +			       struct ib_client_nl_info *res)
> +{
> +	struct ib_umad_device *umad_dev =3D client_data;
> +
> +	if (!rdma_is_port_valid(ibdev, res->port))
> +		return -EINVAL;
> +
> +	res->abi =3D IB_USER_MAD_ABI_VERSION;
> +	res->cdev =3D &umad_dev->ports[res->port - rdma_start_port(ibdev)].dev;
> +
> +	return 0;
> +}
> +
>  static struct ib_client umad_client =3D {
>  	.name   =3D "umad",
>  	.add    =3D ib_umad_add_one,
> -	.remove =3D ib_umad_remove_one
> +	.remove =3D ib_umad_remove_one,
> +	.get_nl_info =3D ib_umad_get_nl_info,
>  };
> +MODULE_ALIAS_RDMA_CLIENT("umad");
> +
> +static int ib_issm_get_nl_info(struct ib_device *ibdev, void *client_dat=
a,
> +			       struct ib_client_nl_info *res)
> +{
> +	struct ib_umad_device *umad_dev =3D
> +		ib_get_client_data(ibdev, &umad_client);
> +
> +	if (!rdma_is_port_valid(ibdev, res->port))
> +		return -EINVAL;
> +
> +	res->abi =3D IB_USER_MAD_ABI_VERSION;
> +	res->cdev =3D &umad_dev->ports[res->port - rdma_start_port(ibdev)].sm_d=
ev;
> +
> +	return 0;
> +}
> +
> +static struct ib_client issm_client =3D {
> +	.name =3D "issm",
> +	.get_nl_info =3D ib_issm_get_nl_info,
> +};
> +MODULE_ALIAS_RDMA_CLIENT("issm");
>
>  static ssize_t ibdev_show(struct device *dev, struct device_attribute *a=
ttr,
>  			  char *buf)
> @@ -1387,13 +1425,17 @@ static int __init ib_umad_init(void)
>  	}
>
>  	ret =3D ib_register_client(&umad_client);
> -	if (ret) {
> -		pr_err("couldn't register ib_umad client\n");
> +	if (ret)
>  		goto out_class;
> -	}
> +
> +	ret =3D ib_register_client(&issm_client);
> +	if (ret)
> +		goto out_client;
>
>  	return 0;
>
> +out_client:
> +	ib_unregister_client(&umad_client);
>  out_class:
>  	class_unregister(&umad_class);
>
> @@ -1411,6 +1453,7 @@ static int __init ib_umad_init(void)
>
>  static void __exit ib_umad_cleanup(void)
>  {
> +	ib_unregister_client(&issm_client);
>  	ib_unregister_client(&umad_client);
>  	class_unregister(&umad_class);
>  	unregister_chrdev_region(base_umad_dev,
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/c=
ore/uverbs_main.c
> index 870b3dd35aac63..11c13c1381cf5c 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -51,6 +51,7 @@
>
>  #include <rdma/ib.h>
>  #include <rdma/uverbs_std_types.h>
> +#include <rdma/rdma_netlink.h>
>
>  #include "uverbs.h"
>  #include "core_priv.h"
> @@ -1148,12 +1149,41 @@ static const struct file_operations uverbs_mmap_f=
ops =3D {
>  	.compat_ioctl =3D ib_uverbs_ioctl,
>  };
>
> +static int ib_uverbs_get_nl_info(struct ib_device *ibdev, void *client_d=
ata,
> +				 struct ib_client_nl_info *res)
> +{
> +	struct ib_uverbs_device *uverbs_dev =3D client_data;
> +	int ret;
> +
> +	if (res->port !=3D -1)
> +		return -EINVAL;
> +
> +	res->abi =3D ibdev->ops.uverbs_abi_ver;
> +	res->cdev =3D &uverbs_dev->dev;
> +
> +	/*
> +	 * To support DRIVER_ID binding in userspace some of the driver need
> +	 * upgrading to expose their PCI dependent revision information
> +	 * through get_context instead of relying on modalias matching. When
> +	 * the drivers are fixed they can drop this flag.
> +	 */
> +	if (!ibdev->ops.uverbs_no_driver_id_binding) {
> +		ret =3D nla_put_u32(res->nl_msg, RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID,
> +				  ibdev->ops.driver_id);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  static struct ib_client uverbs_client =3D {
>  	.name   =3D "uverbs",
>  	.no_kverbs_req =3D true,
>  	.add    =3D ib_uverbs_add_one,
> -	.remove =3D ib_uverbs_remove_one
> +	.remove =3D ib_uverbs_remove_one,
> +	.get_nl_info =3D ib_uverbs_get_nl_info,
>  };
> +MODULE_ALIAS_RDMA_CLIENT("uverbs");
>
>  static ssize_t ibdev_show(struct device *device, struct device_attribute=
 *attr,
>  			  char *buf)
> diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infini=
band/hw/cxgb3/iwch_provider.c
> index acba96f289cc06..810fa96af2e9fd 100644
> --- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
> +++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
> @@ -1230,6 +1230,7 @@ static const struct ib_device_ops iwch_dev_ops =3D =
{
>  	.owner =3D THIS_MODULE,
>  	.driver_id =3D RDMA_DRIVER_CXGB3,
>  	.uverbs_abi_ver =3D IWCH_UVERBS_ABI_VERSION,
> +	.uverbs_no_driver_id_binding =3D 1,
>
>  	.alloc_hw_stats	=3D iwch_alloc_stats,
>  	.alloc_mr =3D iwch_alloc_mr,
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniba=
nd/hw/hns/hns_roce_main.c
> index 3e45b119b0eba7..c0e819ed8c9be9 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -417,6 +417,7 @@ static const struct ib_device_ops hns_roce_dev_ops =
=3D {
>  	.owner =3D THIS_MODULE,
>  	.driver_id =3D RDMA_DRIVER_HNS,
>  	.uverbs_abi_ver =3D 1,
> +	.uverbs_no_driver_id_binding =3D 1,
>
>  	.add_gid =3D hns_roce_add_gid,
>  	.alloc_pd =3D hns_roce_alloc_pd,
> diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infin=
iband/hw/mthca/mthca_provider.c
> index efd4e3d13ae22c..d97124bee703d7 100644
> --- a/drivers/infiniband/hw/mthca/mthca_provider.c
> +++ b/drivers/infiniband/hw/mthca/mthca_provider.c
> @@ -1147,6 +1147,7 @@ static const struct ib_device_ops mthca_dev_ops =3D=
 {
>  	.owner =3D THIS_MODULE,
>  	.driver_id =3D RDMA_DRIVER_MTHCA,
>  	.uverbs_abi_ver =3D MTHCA_UVERBS_ABI_VERSION,
> +	.uverbs_no_driver_id_binding =3D 1,
>
>  	.alloc_pd =3D mthca_alloc_pd,
>  	.alloc_ucontext =3D mthca_alloc_ucontext,
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index a1265e9ce2d11f..6f09fcc21d7a41 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2321,6 +2321,7 @@ struct ib_device_ops {
>  	struct module *owner;
>  	enum rdma_driver_id driver_id;
>  	u32 uverbs_abi_ver;
> +	unsigned int uverbs_no_driver_id_binding:1;
>
>  	int (*post_send)(struct ib_qp *qp, const struct ib_send_wr *send_wr,
>  			 const struct ib_send_wr **bad_send_wr);
> diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_ne=
tlink.h
> index 9903db21a42c58..b27c02185dcc19 100644
> --- a/include/uapi/rdma/rdma_netlink.h
> +++ b/include/uapi/rdma/rdma_netlink.h
> @@ -504,6 +504,7 @@ enum rdma_nldev_attr {
>  	RDMA_NLDEV_ATTR_CHARDEV_NAME,		/* string */
>  	RDMA_NLDEV_ATTR_CHARDEV_ABI,		/* u64 */
>  	RDMA_NLDEV_ATTR_CHARDEV,		/* u64 */
> +	RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID,       /* u64 */

This should be inside nla_policy too.

Thanks



>
>  	/*
>  	 * Always the end
> --
> 2.21.0
>
