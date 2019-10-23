Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D802E169B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 11:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403785AbfJWJt3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 05:49:29 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:52540 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403844AbfJWJt2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Oct 2019 05:49:28 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9N9jfbo029271;
        Wed, 23 Oct 2019 02:49:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=5fRgM6mEJw5HZH0NS3yfxjgQqkZO5INvlz34k/nMkp4=;
 b=acSIaBMxzJknDh1trQnc2ZZ8ELRBLVQon+FKSYxrwWiAiB1ossLfCZRZjKTF+Ut+rnAL
 wFR0mA+aOilumCvO3mAnUMdczhuVxVFdGs676FNqURFn5lphB7tq1pfN/HEOz8TYJuWy
 oX759VM126+R4tDpkT4Ix+/nMHM7VdU0fJJbi/zWC0xGRPikjeqtgFBZPXchEuRDvrA/
 Ms+nc/ENMVUdk/M8Ex2drMZje2oNEZRMWQ/y74jK+O/0DFa5TBnbcb3k/O+cUcAlBOdj
 FuteaL2A5I/BMbMF6/I8GdsWOoXDiVKrbh9YaTNUKCHYi8n0UqTtRl/cAntdbaoZzzvi Ew== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vt9u5j8ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 02:49:17 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 23 Oct
 2019 02:49:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.56) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 23 Oct 2019 02:49:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHQ0UBvHzsgeLk1ufEipmPUHLmz39/FggGjv5zq1dfjNF0RCnpMCd7CjWRcSU+dhvwIs46O9tPkPylVm6YDh9sY6UzGOvq+AtNvONGl8muxgx3p28Byvb+wZLoquEccNq0uMWYDegYDIYagZrhfG2ElWnfAVcWSQ9uidNWuqOGx+FRRuBwUnfZ+jhDOnYrKMs1Vgl9oHpPtxttRwHp+HUQFw4r/WcWUk5INpp+iOu5oFFnHnCTvE1Ummbo1W0987+YTZMLwUmfUx4f3Gljd4+1O7rsUxFnH8kHgFCf+TpGnecM8AWcKPchnMMJW9bXKnrgUsVuNZUGJW9QOomxODsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fRgM6mEJw5HZH0NS3yfxjgQqkZO5INvlz34k/nMkp4=;
 b=m+rNPbKT5uCN4SdPK7lU5ND8JzSq0lIZ6PbFVvIbt4zBfS+IG2W9B0glfONCxuVUMqilATLExvufSLIqw/z/wo0n6LiAHS3WjlKWMhQ7qgWw1fmpGndMFGi53m21fLAgWW5ftOrTXI58cV26TX/o4GfNu/mfLcH9IlEbSI2mibflzl2dKxrKBbfjRYGH/kVm8avLC7bvosHzCmN8Ha3f4X8EveQnsqAvQcysjlMYsySnTzdBRP3BwsEkH76ADCrCeHxjNdJDyWBcGVE+VGpCoRg0mrebic0UdK7mj6aenBSTCKc2HfurWtXpAc7/I4gVmPZO+gsTCNKUGvOinb5Odg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fRgM6mEJw5HZH0NS3yfxjgQqkZO5INvlz34k/nMkp4=;
 b=T2JL75tG87qYw+7N6U34zYHLEahpzGVVabp+9/FNN+PoNsGLP9Oq9FHaePkxnYbRRAS8YMH1YDXidZ5y3ZiiPbswMQ9TMyJERGiJDYVAKC/F6chv4GDo+maDiK4VS3QqpgGoJS53pqzK6AdpZNy63vNsWFSrWDyKz2TFDrro/i0=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3055.namprd18.prod.outlook.com (20.178.255.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Wed, 23 Oct 2019 09:49:14 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811%6]) with mapi id 15.20.2387.021; Wed, 23 Oct 2019
 09:49:14 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [EXT] Re: [PATCH v2 rdma-next 1/2] RDMA/qedr: Fix synchronization
 methods and memory leaks in qedr
Thread-Topic: [EXT] Re: [PATCH v2 rdma-next 1/2] RDMA/qedr: Fix
 synchronization methods and memory leaks in qedr
Thread-Index: AQHVhBctBQC8AoLrfU+3L4N5Y0TGgqdnF8qAgADZ+0A=
Date:   Wed, 23 Oct 2019 09:49:14 +0000
Message-ID: <MN2PR18MB3182B5EED33E362D875C70B6A16B0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20191016114242.10736-1-michal.kalderon@marvell.com>
 <20191016114242.10736-2-michal.kalderon@marvell.com>
 <20191022193623.GG23952@ziepe.ca>
In-Reply-To: <20191022193623.GG23952@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43010f5e-2a4f-45e7-66bd-08d7579e4374
x-ms-traffictypediagnostic: MN2PR18MB3055:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB30554647D6F67152AF37FC3CA16B0@MN2PR18MB3055.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(64756008)(14454004)(446003)(19627235002)(11346002)(476003)(8936002)(86362001)(966005)(33656002)(81156014)(6916009)(478600001)(81166006)(8676002)(66946007)(66476007)(66066001)(66446008)(486006)(66556008)(186003)(102836004)(52536014)(5660300002)(256004)(14444005)(6506007)(26005)(25786009)(76116006)(71190400001)(76176011)(107886003)(2906002)(7696005)(6116002)(54906003)(7736002)(305945005)(74316002)(3846002)(4326008)(6306002)(55016002)(229853002)(99286004)(9686003)(6436002)(6246003)(316002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3055;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QhvxhcKPCmyD6nFu6sMNjCmAbj70MOdxiDi7VmiX8ujWPrO5MLQCdOkdV1xbuvmOCLpz0sxwLpHpIaqPQXwH/FhCfd1YioD0WpDLAJ90Ek0LpCeKqCYc6VRfY+ym/jzOOCw4oAkmmNeZ8SE8/CSMVNmu+jpBuvYijPdZUrAcdGAom4PT5McBSu9o+l6iJRRs+KjCTs50Oll0H7ZhWFggxomoDRR0NogXRE2fDQ9t3aSuYOnN2Mw6Gnsx7LnGuorg8pf+l+lUhlsZRepKgFjPWLzoxVGV3gLngVuFkd3+/bhM9abLQ/jhNM0hWNGmC6BwhpITqTvJYt+lN08SeyVs71RYOsz1tmBASbhP96HAFvR3uzka+rn5wBI/KqiYibFFRTFQLYidg+GpyVoZcznFMikwyc3SS5Lhk1ZVXSD6008l70XNIlH42JsXxxDrhj4kvF37bAEEd9Foeq0AQdGKDRXND0XA3a4BHHdLcSLPx70=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 43010f5e-2a4f-45e7-66bd-08d7579e4374
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 09:49:14.3096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ui380Up0s91hB2lrQBxdlmce9p/3Y05/OCWO7UbvhlMQzYVSF96B6LGamM8jZyZs5gzXznb5j23pSj9+Uxdwsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3055
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-23_02:2019-10-22,2019-10-23 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, October 22, 2019 10:36 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Wed, Oct 16, 2019 at 02:42:41PM +0300, Michal Kalderon wrote:
>=20
> > Re-design of the iWARP CM related objects reference
>=20
> > counting and synchronization methods, to ensure operations
>=20
> > are synchronized correctly and and that memory allocated for "ep"
>=20
> > is released. (was leaked).
>=20
> > Also makes sure QP memory is not released before ep is finished
>=20
> > accessing it.
>=20
> >
>=20
> > Where as the QP object is created/destroyed by external operations,
>=20
> > the ep is created/destroyed by internal operations and represents
>=20
> > the tcp connection associated with the QP.
>=20
> >
>=20
> > QP destruction flow:
>=20
> > - needs to wait for ep establishment to complete (either successfully
>=20
> >   or with error)
>=20
> > - needs to wait for ep disconnect to be fully posted to avoid a
>=20
> >   race condition of disconnect being called after reset.
>=20
> > - both the operations above don't always happen, so we use atomic
>=20
> >   flags to indicate whether the qp destruction flow needs to wait
>=20
> >   for these completions or not, if the destroy is called before
>=20
> >   these operations began, the flows will check the flags and not
>=20
> >   execute them ( connect / disconnect).
>=20
> >
>=20
> > We use completion structure for waiting for the completions mentioned
>=20
> > above.
>=20
> >
>=20
> > The QP refcnt was modified to kref object.
>=20
> > The EP has a kref added to it to handle additional worker thread
>=20
> > accessing it.
>=20
> >
>=20
> > Memory Leaks - https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__www.spinics.net_lists_linux-
> 2Drdma_msg83762.html&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D7Yun
> NpwaTtA-c31OjGDRlmf54csBCXY_j41vn-0xRz4&m=3DDfexSyvBpCQbEUyzV-
> q_oGHiJYpLrH4Igtg963UsuZs&s=3DXNxYMW-
> rrECcE1vRoUReaYZcb01cMCx9X9fs_clAU1Y&e=3D
>=20
> > Reported-by Chuck Lever <chuck.lever@oracle.com>
>=20
> >
>=20
> > Concurrency not managed correctly -
>=20
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__www.spinics.net_lists_linux-
> 2Drdma_msg67949.html&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D7Yun
> NpwaTtA-c31OjGDRlmf54csBCXY_j41vn-0xRz4&m=3DDfexSyvBpCQbEUyzV-
> q_oGHiJYpLrH4Igtg963UsuZs&s=3DzgMS6HLPvQCHcCwmmXuA8EqpZV1cX_DL-
> oPqtLJv2vs&e=3D
>=20
> > Reported-by Jason Gunthorpe <jgg@ziepe.ca>
>=20
> >
>=20
> > Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
>=20
> > Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
>=20
> >  drivers/infiniband/hw/qedr/qedr.h       |  23 ++++-
>=20
> >  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 150
> ++++++++++++++++++++++----------
>=20
> >  drivers/infiniband/hw/qedr/verbs.c      |  42 +++++----
>=20
> >  3 files changed, 141 insertions(+), 74 deletions(-)
>=20
> >
>=20
> > diff --git a/drivers/infiniband/hw/qedr/qedr.h
> b/drivers/infiniband/hw/qedr/qedr.h
>=20
> > index 0cfd849b13d6..8e927f6c1520 100644
>=20
> > +++ b/drivers/infiniband/hw/qedr/qedr.h
>=20
> > @@ -40,6 +40,7 @@
>=20
> >  #include <linux/qed/qed_rdma_if.h>
>=20
> >  #include <linux/qed/qede_rdma.h>
>=20
> >  #include <linux/qed/roce_common.h>
>=20
> > +#include <linux/completion.h>
>=20
> >  #include "qedr_hsi_rdma.h"
>=20
> >
>=20
> >  #define QEDR_NODE_DESC "QLogic 579xx RoCE HCA"
>=20
> > @@ -377,10 +378,20 @@ enum qedr_qp_err_bitmap {
>=20
> >  	QEDR_QP_ERR_RQ_PBL_FULL =3D 32,
>=20
> >  };
>=20
> >
>=20
> > +enum qedr_qp_create_type {
>=20
> > +	QEDR_QP_CREATE_NONE,
>=20
> > +	QEDR_QP_CREATE_USER,
>=20
> > +	QEDR_QP_CREATE_KERNEL,
>=20
> > +};
>=20
> > +
>=20
> > +enum qedr_iwarp_cm_flags {
>=20
> > +	QEDR_IWARP_CM_WAIT_FOR_CONNECT    =3D BIT(0),
>=20
> > +	QEDR_IWARP_CM_WAIT_FOR_DISCONNECT =3D BIT(1),
>=20
> > +};
>=20
> > +
>=20
> >  struct qedr_qp {
>=20
> >  	struct ib_qp ibqp;	/* must be first */
>=20
> >  	struct qedr_dev *dev;
>=20
> > -	struct qedr_iw_ep *ep;
>=20
> >  	struct qedr_qp_hwq_info sq;
>=20
> >  	struct qedr_qp_hwq_info rq;
>=20
> >
>=20
> > @@ -395,6 +406,7 @@ struct qedr_qp {
>=20
> >  	u32 id;
>=20
> >  	struct qedr_pd *pd;
>=20
> >  	enum ib_qp_type qp_type;
>=20
> > +	enum qedr_qp_create_type create_type;
>=20
> >  	struct qed_rdma_qp *qed_qp;
>=20
> >  	u32 qp_id;
>=20
> >  	u16 icid;
>=20
> > @@ -437,8 +449,11 @@ struct qedr_qp {
>=20
> >  	/* Relevant to qps created from user space only (applications) */
>=20
> >  	struct qedr_userq usq;
>=20
> >  	struct qedr_userq urq;
>=20
> > -	atomic_t refcnt;
>=20
> > -	bool destroyed;
>=20
> > +
>=20
> > +	/* synchronization objects used with iwarp ep */
>=20
> > +	struct kref refcnt;
>=20
> > +	struct completion iwarp_cm_comp;
>=20
> > +	unsigned long iwarp_cm_flags; /* enum iwarp_cm_flags */
>=20
> >  };
>=20
> >
>=20
> >  struct qedr_ah {
>=20
> > @@ -531,7 +546,7 @@ struct qedr_iw_ep {
>=20
> >  	struct iw_cm_id	*cm_id;
>=20
> >  	struct qedr_qp	*qp;
>=20
> >  	void		*qed_context;
>=20
> > -	u8		during_connect;
>=20
> > +	struct kref	refcnt;
>=20
> >  };
>=20
> >
>=20
> >  static inline
>=20
> > diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
>=20
> > index 22881d4442b9..26204caf0975 100644
>=20
> > +++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
>=20
> > @@ -79,6 +79,28 @@ qedr_fill_sockaddr6(const struct qed_iwarp_cm_info
> *cm_info,
>=20
> >  	}
>=20
> >  }
>=20
> >
>=20
> > +static void qedr_iw_free_qp(struct kref *ref)
>=20
> > +{
>=20
> > +	struct qedr_qp *qp =3D container_of(ref, struct qedr_qp, refcnt);
>=20
> > +
>=20
> > +	xa_erase(&qp->dev->qps, qp->qp_id);
>=20
>=20
>=20
> This probably doesn't work right because qp_id is not derived from the
>=20
> xa_array, but some external entity.
>=20
>=20
>=20
> Thus the qp_id should be removed from the xarray and kref put'd right
>=20
> before the qp_id is deallocated from the external manager.
>=20
Thanks! This is a good point.
I will remove the element from xarray and kref put before deallocation, as =
you mentioned,=20
But will wait for the kref-free function to be called ( perhaps using compl=
etion )=20
Before deallocation.=20

>=20
>=20
> Ie you want to avoid a race where the qp_id can be re-assigned but the
>=20
> xarray entry hasn't been freed by its kref yet. Then it would
>=20
> xa_insert and fail.
>=20
>=20
>=20
> Also the xa_insert is probably not supposed to be the _irq version
Right, this was originally an idr which was modified with the massive patch=
set
That changed all idrs to xarrays. I'll re-review it.

>=20
> either.
>=20
>=20
>=20
> > @@ -224,13 +249,18 @@ qedr_iw_disconnect_event(void *context,
>=20
> >  	struct qedr_discon_work *work;
>=20
> >  	struct qedr_iw_ep *ep =3D (struct qedr_iw_ep *)context;
>=20
> >  	struct qedr_dev *dev =3D ep->dev;
>=20
> > -	struct qedr_qp *qp =3D ep->qp;
>=20
> >
>=20
> >  	work =3D kzalloc(sizeof(*work), GFP_ATOMIC);
>=20
> >  	if (!work)
>=20
> >  		return;
>=20
> >
>=20
> > -	qedr_iw_qp_add_ref(&qp->ibqp);
>=20
> > +	/* We can't get a close event before disconnect, but since
>=20
> > +	 * we're scheduling a work queue we need to make sure close
>=20
> > +	 * won't delete the ep, so we increase the refcnt
>=20
> > +	 */
>=20
> > +	if (!kref_get_unless_zero(&ep->refcnt))
>=20
> > +		return;
>=20
>=20
>=20
> The unless_zero version should not be used without some kind of
>=20
> locking like this, if you have a pointer to ep then ep must be a valid
>=20
> pointer and it is safe to take a kref on it.
>=20
>=20
>=20
> If there is a risk it is not valid then this is racy in a way that
>=20
> only locking can fix, not unless_zero
Ok, ep is valid here, I'll modify to kref_get. Thanks.

>=20
>=20
>=20
> > @@ -476,6 +508,19 @@ qedr_addr6_resolve(struct qedr_dev *dev,
>=20
> >  	return rc;
>=20
> >  }
>=20
> >
>=20
> > +struct qedr_qp *qedr_iw_load_qp(struct qedr_dev *dev, u32 qpn)
>=20
> > +{
>=20
> > +	struct qedr_qp *qp;
>=20
> > +
>=20
> > +	xa_lock(&dev->qps);
>=20
> > +	qp =3D xa_load(&dev->qps, qpn);
>=20
> > +	if (!qp || !kref_get_unless_zero(&qp->refcnt))
>=20
> > +		qp =3D NULL;
>=20
>=20
>=20
> See, here is is OK because qp can't be freed under the xa_lock.
>=20
>=20
>=20
> However, this unless_zero also will not be needed once the xa_erase is
>=20
> moved to the right spot.
Right. Thanks.

>=20
>=20
>=20
> > +		/* Wait for the connection setup to complete */
>=20
> > +		if
> (test_and_set_bit(QEDR_IWARP_CM_WAIT_FOR_CONNECT,
>=20
> > +				     &qp->iwarp_cm_flags))
>=20
> > +			wait_for_completion(&qp->iwarp_cm_comp);
>=20
> > +
>=20
> > +		if
> (test_and_set_bit(QEDR_IWARP_CM_WAIT_FOR_DISCONNECT,
>=20
> > +				     &qp->iwarp_cm_flags))
>=20
> > +			wait_for_completion(&qp->iwarp_cm_comp);
>=20
> >  	}
>=20
>=20
>=20
> These atomics seem mis-named, and I'm unclear how they can both be
>=20
> waiting on the same completion?

In IWARP the connection establishment and disconnect are offloaded to hw an=
d asynchronous.=20
The first waits for CONNECT to complete. (completes asynchronously)=20
If we are in the middle of a connect that was offloaded (or after connect) =
the bit will be on and completion will be completed
once the connection is fully established.
We want to wait before destroying the qp due to hw constraints (can't destr=
oy during connect).

The seconds waits for DISCONNECT to complete ( doesn't always occur, only i=
f a graceful disconnect was initiated on either side)
Disconnect can't occur on a connection not established yet, so we can't get=
 the completion of the disconnect instead.=20
Similar for connect, once we start the disconnect we turn on the bit and wi=
ll complete once the disconnect completes.=20

I didn't see a reason to use another completion structure, since from what =
I read complete does comp->done++ and wait_for_completion
checks done and eventually does done-- so it can be used several times if t=
here is no need to distinguish which event occurred first
(in this case there is only one option first connect then disconnect and di=
sconnect can't occur without connect)

But if this is wrong I will add another completion structure.

Thanks,
Michal
>=20
>=20
>=20
> > @@ -2490,11 +2488,11 @@ int qedr_destroy_qp(struct ib_qp *ibqp, struct
> ib_udata *udata)
>=20
> >
>=20
> >  	qedr_free_qp_resources(dev, qp, udata);
>=20
> >
>=20
> > -	if (atomic_dec_and_test(&qp->refcnt) &&
>=20
> > -	    rdma_protocol_iwarp(&dev->ibdev, 1)) {
>=20
> > -		xa_erase_irq(&dev->qps, qp->qp_id);
>=20
>=20
>=20
> This is probably too late, it should be done before the qp_id could be
>=20
> recycled.
>=20
>=20
>=20
> Jason

