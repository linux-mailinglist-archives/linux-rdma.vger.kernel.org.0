Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBBA197DCD
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfHUO6L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:58:11 -0400
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:49985
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbfHUO6K (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 10:58:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxXbNrJS/UVnuxf6YOB2YUT7vtv99At+RBJKVbx11bm7bG7DgpJ6wYr36xGdXSXnady4OkFqIN/L5CWFio/TuApm8v7cfwcIiMzMMyS3K6Cw5O3l3sNUpiAn8x6hLt/TOcajO+s9PmJb4cBGAhhaVQlg8Z4y0eKVBBEZMm2e66R1UstW7M3jO4dDg4sPbF4ma38Ot/FJgmPb02nj7g6N0Z17y+Bk14eZmaWc4Y7r0RSkZmWY3FAEXO+vNV4tAvU8EBtHUUpZS+qR9c8Ge9PN74jh0OB8rimnw+AjZQ9va3w1m43V4Qi1lu7R82ewipONOKb5zUluL+ZMJJXVaRUFTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbjbFQxO2cLphAI9JWF1TaijhFuDj5I0VogVJnnhc34=;
 b=mfyludb2pa9WII55cMba/1h2r/wkS+FspevDbpBRwA9DlzLKCawG3kl53pPkpE7JiLWY2YEgnSO0j5xieatfL7ZRYKRCmD1TOEpPSmYYVoDKEsk6ws25vtZncUKd3Jhu6eXO8VwKM1+uFR8hhgu2ZqjYqH5kMdES+EjUevcgDwH2A+qEinsbj5S+8bGosizq9sYC1bJaGttSaZKr/hMXudOORX4KdMFxlhTFAuiRoLGnwJwagm5fNaz9iQ24KsDUasNCmPZlGKl3AYbxZ+7+3kDpwpQ8y7/Xgv87CMpPJgfHlvmNWZJX4Xc4XTokajV5NjTCKBWka7x9MkIZzXqEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbjbFQxO2cLphAI9JWF1TaijhFuDj5I0VogVJnnhc34=;
 b=GdEHN45dLEnjylWjNzOE+/gH5P1nm1I/Q93yU7POnyACU3sUImWr4OkMx9qpIqfeR2pvrQmc0eGGLuuV2RhCwg7RX8jj47Gq6VjkInDPJ1QqQtP9JNddTpKO+49YrQsric6nCaXK0War6/enzf0Z3OIJn7doOJEOi/UD+QvpF3k=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6254.eurprd05.prod.outlook.com (20.178.205.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 14:57:59 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 14:57:59 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "shamir.rabinovitch@oracle.com" <shamir.rabinovitch@oracle.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 07/24] IB/uverbs: Add context import lock/unlock helper
Thread-Topic: [PATCH v1 07/24] IB/uverbs: Add context import lock/unlock
 helper
Thread-Index: AQHVWCvjou60KcBhtUOZwHHYCHk9nacFsUcA
Date:   Wed, 21 Aug 2019 14:57:59 +0000
Message-ID: <20190821145754.GC8667@mellanox.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821142125.5706-8-yuval.shaia@oracle.com>
In-Reply-To: <20190821142125.5706-8-yuval.shaia@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53e8f5fa-304b-43ee-0db5-08d72647f509
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6254;
x-ms-traffictypediagnostic: VI1PR05MB6254:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6254C37BD6EEABCC19064B83CFAA0@VI1PR05MB6254.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(199004)(189003)(33656002)(2906002)(316002)(7416002)(52116002)(5660300002)(8936002)(66446008)(64756008)(6436002)(66556008)(66476007)(6916009)(486006)(66946007)(6512007)(6246003)(8676002)(4326008)(81156014)(81166006)(66066001)(25786009)(36756003)(53936002)(305945005)(7736002)(99286004)(54906003)(1076003)(102836004)(256004)(14444005)(446003)(386003)(6506007)(2616005)(478600001)(86362001)(76176011)(6486002)(26005)(186003)(3846002)(6116002)(14454004)(11346002)(229853002)(71200400001)(71190400001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6254;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YWxusC6DpUa3jYF/epPZu8o2Ne+J5kzMBE67eBaZFbW7W3n5rJlYKx4cof8z2fLzjpQqZLyYbF2Erwu/wfcTiiym/VQMdC2Gjc4s1iQJPJ1h4kgYpW0ZHeyHnKIzYQxkC9yAgMabvgUlP8pido5dBpNK+H7XD0upXkztisv5XIrtLVDDPYf0FpgAjc/zulM+c0SHWsNlCXkcQjeavYou0nWcCKgas3d2As53iMQPVl5Qek1HxR+TTsE4ueAIb87BZjE2yomy2mD4rzdJDD0F4rfjbi5fHxvvjbOca53F3671v416k+AKWHtNXoVccBASrhwRGJ/0L40Ecdeoa5COlqolsVDQWfHg4AERXUIinns0kew0jH94cg+EsCOgO2z8dPee8r7JVCbzFVCP6MtgJUZ0+0NleqUtRb4z8EmKung=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C8D526F6BEC654C98E108FEC80A1664@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e8f5fa-304b-43ee-0db5-08d72647f509
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 14:57:59.6926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UKjwgtFiDISyP37lEUHsOO48FhKjdsb67oNKRrSfL19nZSH9/PpiJOup5LrHyFilQF44sP8onP0ym5YsJ8mcPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6254
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 05:21:08PM +0300, Yuval Shaia wrote:
> From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>=20
> The lock/unlock helpers will be used in every import verb.
>=20
> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
>  drivers/infiniband/core/uverbs.h      |  2 +
>  drivers/infiniband/core/uverbs_cmd.c  | 73 +++++++++++++++++++++++++++
>  drivers/infiniband/core/uverbs_main.c |  1 +
>  3 files changed, 76 insertions(+)
>=20
> diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/u=
verbs.h
> index 1e5aeb39f774..cf76336cb460 100644
> +++ b/drivers/infiniband/core/uverbs.h
> @@ -163,6 +163,8 @@ struct ib_uverbs_file {
>  	struct page *disassociate_page;
> =20
>  	struct xarray		idr;
> +
> +	struct file	       *filp;
>  };
> =20
>  struct ib_uverbs_event {
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/co=
re/uverbs_cmd.c
> index 4f42f9732dca..21f0a1a986f4 100644
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -43,6 +43,7 @@
> =20
>  #include <rdma/uverbs_types.h>
>  #include <rdma/uverbs_std_types.h>
> +#include <rdma/uverbs_ioctl.h>
>  #include "rdma_core.h"
> =20
>  #include "uverbs.h"
> @@ -3791,6 +3792,78 @@ static void uverbs_init_attrs_ufile(struct uverbs_=
attr_bundle *attrs_bundle,
>  	};
>  }
> =20
> +/* ib_uverbs_import_lock - Function which gathers code that is
> + *	common in the import verbs.
> + *
> + *	This function guarntee that both source and destination files are
> + *	protected from race with vfs close. The current file is protected
> + *	from such race because verb is executed in a system-call context.
> + *	The other file is protected by 'fget'. This function also ensures
> + *	that ib_uobject identified by the type & handle is locked for read.
> + *
> + *	Callers of this helper must also call ib_uverbs_import_unlock
> + *	to undo any locking performed by this helper.
> + */
> +static int ib_uverbs_import_lock(struct uverbs_attr_bundle *attrs,

This isn't a lock, it is a get

> +				 int fd, u16 type, u32 handle,
> +				 struct ib_uobject **uobj,
> +				 struct file **filep,
> +				 struct ib_uverbs_file **ufile)
> +{
> +	struct ib_uverbs_file *file =3D attrs->ufile;
> +	struct ib_uverbs_device *dev =3D file->device;
> +	struct uverbs_attr_bundle fd_attrs;
> +	struct ib_uverbs_device *fd_dev;
> +	int ret =3D 0;
> +
> +	*filep =3D fget(fd);
> +	if (!*filep)
> +		return -EINVAL;
> +
> +	/* check uverbs ops exist */
> +	if ((*filep)->f_op !=3D file->filp->f_op) {
> +		ret =3D -EINVAL;
> +		goto file;
> +	}
> +
> +	*ufile =3D (*filep)->private_data;
> +	fd_dev =3D (*ufile)->device;

Most likely all of this should be in the ioctl code as part of some=20

> +	/* check that both files belong to same ib_device */
> +	if (dev !=3D fd_dev) {
> +		ret =3D -EINVAL;
> +		goto file;
> +	}
> +
> +	uverbs_init_attrs_ufile(&fd_attrs, *ufile);

This makes no sense here

> +	*uobj =3D uobj_get_read(type, handle, &fd_attrs);
> +	if (IS_ERR(*uobj)) {
> +		ret =3D -EINVAL;
> +		goto file;
> +	}
> +
> +	/* verify ib_object is shareable */
> +	if (!(*uobj)->refcnt) {
> +		ret =3D -EINVAL;
> +		goto uobj;
> +	}
> +
> +	return 0;
> +uobj:
> +	uobj_put_read(*uobj);
> +file:
> +	fput(*filep);
> +	return ret;
> +}

Most likely most of this belongs to the ioctl path as some new input
attr type 'foreign context'

Jason
