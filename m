Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C980E3221
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 14:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439672AbfJXMTv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 08:19:51 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:61138 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726393AbfJXMTv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 08:19:51 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9OC5ujf027440;
        Thu, 24 Oct 2019 05:19:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=2EGRVtM9BrSVKvPu2zsjQ+b3ntorYSf94TXDfG6RYI0=;
 b=NX8Cg91o/ai3hb5hxPcMyJszF50K5Xu+JBY6xvXNs4eQY/uMbaMTgU22PTzHoGaNmHB8
 vPuaBQEMv0ynvX6DvOkRAUAibZ2pB6l5/Y77Bx1H0Uv15gIx+6z86p8irLfCHBFLMZ2q
 ILJvERkGfFyACvYLMeP56BLmFE6/qK6YsGpQR+8Tb9Qh5FXDQrjm1k1ATHacM6sONDj+
 Md3pyluB9hZItpmtQss/DeHf7OImL/BcqnShpHkHnqD9WDx0NTgAVzpwEJht++AlRCNl
 ihuih4rnER0m8HA5DdwLIhV23EPm+deVygh1Op5ePMRK1Hmjp+9uF7y/MEFLsghHsn91 +A== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vt9u5qe0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Oct 2019 05:19:46 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 24 Oct
 2019 05:19:45 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 24 Oct 2019 05:19:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q95SvsgUMf/XMjwk2V0lxXBIpTELTd0l64LzyejzK6ToLi1PXeixpLbC4X5gR+iPIJ3dM9fyskOL2mQIi9CEGw0/eZDx3Xi+kfZdMAcaXFXx34EKbqyzbok2jAzpuxEn5/TOyQFnXVN1DUwe/lGAo4FdWRQDACJa2Co9gCgKlt+W11rfg602+MF4Zz4jdT43+Onau3K/WM3oBNbR7vN/vaiINZtvH+55XbXUN8rEFSLORVrhHa7hFqbqR3Ufo1mCN5kfratLYgoEivQXoJj0odrbJDhxByu/CdsQV8EJTnxxk8fHJHmxsx2+4rnZzmkOgkcEbPpyciK9ZpuN5DEGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EGRVtM9BrSVKvPu2zsjQ+b3ntorYSf94TXDfG6RYI0=;
 b=BWvN1vZt3wu0HfwtWw61cTzLXbK8XKluuR/DaGi1uxqSTSzYSvL9i2woEShvkLicZyx1PvGQsCgRohhc+eEnzjJECC9/VsM1wFP7raJPCZgfLK4yxiBxCmO8ElmgRhPBbZzxfStA2sreBfiL95ebX1QvOzdQk3GPMMeis66E9LCtnfi1vcZsdh9imaQBc9INHpShyoMllN2eRLFMVNpfDbXF5gL3IDnhestJ8ZCkoEkfqA4JGzHjRKBYLm6LTFlpH8kKmwVLKIbWQg8u9cFDmr19YHtWbrLJWGKnjSOVjbIfD+j+Ws5WC+0XgZtD47n/YHdvnSOxYJigbn4DTCWtnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EGRVtM9BrSVKvPu2zsjQ+b3ntorYSf94TXDfG6RYI0=;
 b=f9e3WFiD6fb673Y35gc2u/pbQoKn6Kwhw9toODAKY7L2towZaaSDIQyneX4o6gwYCR3gu/UacnSMtrMJI+daSJIVeYOY1WXBhxVmBAIyNWf4KaAVydQRM0Ih1cL8CrEU7M7ArwVi+3EeJN3GWcIhFFCQv4+VmEwUtam16fpdGpM=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3359.namprd18.prod.outlook.com (10.255.239.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Thu, 24 Oct 2019 12:19:43 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811%6]) with mapi id 15.20.2387.023; Thu, 24 Oct 2019
 12:19:43 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Michal Kalderon <mkalderon@marvell.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [EXT] Re: [PATCH v2 rdma-next 1/2] RDMA/qedr: Fix synchronization
 methods and memory leaks in qedr
Thread-Topic: [EXT] Re: [PATCH v2 rdma-next 1/2] RDMA/qedr: Fix
 synchronization methods and memory leaks in qedr
Thread-Index: AQHVhBctBQC8AoLrfU+3L4N5Y0TGgqdnF8qAgADZ+0CAAc2n0A==
Date:   Thu, 24 Oct 2019 12:19:43 +0000
Message-ID: <MN2PR18MB318222E31E0D52FCE0350C5EA16A0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20191016114242.10736-1-michal.kalderon@marvell.com>
 <20191016114242.10736-2-michal.kalderon@marvell.com>
 <20191022193623.GG23952@ziepe.ca>
 <MN2PR18MB3182B5EED33E362D875C70B6A16B0@MN2PR18MB3182.namprd18.prod.outlook.com>
In-Reply-To: <MN2PR18MB3182B5EED33E362D875C70B6A16B0@MN2PR18MB3182.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25b6e86d-ca02-4596-8af0-08d7587c737f
x-ms-traffictypediagnostic: MN2PR18MB3359:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB33595DE677994B8FA5B4346DA16A0@MN2PR18MB3359.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(199004)(189003)(6246003)(55016002)(9686003)(186003)(305945005)(86362001)(14444005)(5660300002)(256004)(71200400001)(486006)(76176011)(26005)(476003)(11346002)(71190400001)(7696005)(6506007)(19627235002)(102836004)(99286004)(107886003)(446003)(52536014)(229853002)(110136005)(81166006)(33656002)(14454004)(8676002)(81156014)(966005)(54906003)(4326008)(66066001)(64756008)(66446008)(66556008)(66476007)(478600001)(76116006)(2906002)(30864003)(66946007)(74316002)(25786009)(6436002)(8936002)(6116002)(3846002)(6306002)(316002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3359;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8NssjZyNAHh9DQkLwl5SUyYsRtWZjgvn0Af4xsutypsF4pK2c1z2cf9JsIWIbK5/FxCrbmiJIXHCzJxM3wVXNbBJe5x5pWqzSRCQumZzMy3/mCFh0N+Ho3kybhV39el2qaIpskMq9KzLxioKFyBBlgImsalGp9/R2V6nCwA+F0wSz6AVaaOArUXEgSOYNMc7kl3RyvN0OrjkyaDcxbry9XNYNm8EeHyF4DgRxpR2GXehjvrLMtC4jjQkraZwUOllGG6VIGcNM67UvoiwF/P7S40hf2uUj5/dnex8kxu3AGRhtIpueE3zOQdh4OREv1JC5vBf8mPO6UbrrbHWn4PUzkWTCwTJQDKy3D2cafVtmNO8gcDbU/BnQY3Kke5fecYZGEvsSRR4i3kS5SuufbjMyR1JpR/K/5iohN30Ap6pvDRGkD4irgzPEPKPSJGwZne+eJ/JwlJ/VqjrYAfxzxjFRT/P7EmTiGSPy4V6Vp7+zVs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b6e86d-ca02-4596-8af0-08d7587c737f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 12:19:43.1552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: isiTwykjKj3jJ56kb3pk0ZurTHGXA5geSJcB2M6nJuHmGJaNi66/gI/pSzUXZ8D4h6nCAte7s+iRMKvzWLYA6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3359
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-24_08:2019-10-23,2019-10-24 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Michal Kalderon
>=20
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Tuesday, October 22, 2019 10:36 PM
> >
> > External Email
> >
> > ----------------------------------------------------------------------
> > On Wed, Oct 16, 2019 at 02:42:41PM +0300, Michal Kalderon wrote:
> >
> > > Re-design of the iWARP CM related objects reference
> >
> > > counting and synchronization methods, to ensure operations
> >
> > > are synchronized correctly and and that memory allocated for "ep"
> >
> > > is released. (was leaked).
> >
> > > Also makes sure QP memory is not released before ep is finished
> >
> > > accessing it.
> >
> > >
> >
> > > Where as the QP object is created/destroyed by external operations,
> >
> > > the ep is created/destroyed by internal operations and represents
> >
> > > the tcp connection associated with the QP.
> >
> > >
> >
> > > QP destruction flow:
> >
> > > - needs to wait for ep establishment to complete (either
> > > successfully
> >
> > >   or with error)
> >
> > > - needs to wait for ep disconnect to be fully posted to avoid a
> >
> > >   race condition of disconnect being called after reset.
> >
> > > - both the operations above don't always happen, so we use atomic
> >
> > >   flags to indicate whether the qp destruction flow needs to wait
> >
> > >   for these completions or not, if the destroy is called before
> >
> > >   these operations began, the flows will check the flags and not
> >
> > >   execute them ( connect / disconnect).
> >
> > >
> >
> > > We use completion structure for waiting for the completions
> > > mentioned
> >
> > > above.
> >
> > >
> >
> > > The QP refcnt was modified to kref object.
> >
> > > The EP has a kref added to it to handle additional worker thread
> >
> > > accessing it.
> >
> > >
> >
> > > Memory Leaks - https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> > 3A__www.spinics.net_lists_linux-
> >
> 2Drdma_msg83762.html&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D7Yun
> > NpwaTtA-c31OjGDRlmf54csBCXY_j41vn-0xRz4&m=3DDfexSyvBpCQbEUyzV-
> > q_oGHiJYpLrH4Igtg963UsuZs&s=3DXNxYMW-
> > rrECcE1vRoUReaYZcb01cMCx9X9fs_clAU1Y&e=3D
> >
> > > Reported-by Chuck Lever <chuck.lever@oracle.com>
> >
> > >
> >
> > > Concurrency not managed correctly -
> >
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> > 3A__www.spinics.net_lists_linux-
> >
> 2Drdma_msg67949.html&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D7Yun
> > NpwaTtA-c31OjGDRlmf54csBCXY_j41vn-0xRz4&m=3DDfexSyvBpCQbEUyzV-
> >
> q_oGHiJYpLrH4Igtg963UsuZs&s=3DzgMS6HLPvQCHcCwmmXuA8EqpZV1cX_DL-
> > oPqtLJv2vs&e=3D
> >
> > > Reported-by Jason Gunthorpe <jgg@ziepe.ca>
> >
> > >
> >
> > > Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> >
> > > Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> >
> > >  drivers/infiniband/hw/qedr/qedr.h       |  23 ++++-
> >
> > >  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 150
> > ++++++++++++++++++++++----------
> >
> > >  drivers/infiniband/hw/qedr/verbs.c      |  42 +++++----
> >
> > >  3 files changed, 141 insertions(+), 74 deletions(-)
> >
> > >
> >
> > > diff --git a/drivers/infiniband/hw/qedr/qedr.h
> > b/drivers/infiniband/hw/qedr/qedr.h
> >
> > > index 0cfd849b13d6..8e927f6c1520 100644
> >
> > > +++ b/drivers/infiniband/hw/qedr/qedr.h
> >
> > > @@ -40,6 +40,7 @@
> >
> > >  #include <linux/qed/qed_rdma_if.h>
> >
> > >  #include <linux/qed/qede_rdma.h>
> >
> > >  #include <linux/qed/roce_common.h>
> >
> > > +#include <linux/completion.h>
> >
> > >  #include "qedr_hsi_rdma.h"
> >
> > >
> >
> > >  #define QEDR_NODE_DESC "QLogic 579xx RoCE HCA"
> >
> > > @@ -377,10 +378,20 @@ enum qedr_qp_err_bitmap {
> >
> > >  	QEDR_QP_ERR_RQ_PBL_FULL =3D 32,
> >
> > >  };
> >
> > >
> >
> > > +enum qedr_qp_create_type {
> >
> > > +	QEDR_QP_CREATE_NONE,
> >
> > > +	QEDR_QP_CREATE_USER,
> >
> > > +	QEDR_QP_CREATE_KERNEL,
> >
> > > +};
> >
> > > +
> >
> > > +enum qedr_iwarp_cm_flags {
> >
> > > +	QEDR_IWARP_CM_WAIT_FOR_CONNECT    =3D BIT(0),
> >
> > > +	QEDR_IWARP_CM_WAIT_FOR_DISCONNECT =3D BIT(1),
> >
> > > +};
> >
> > > +
> >
> > >  struct qedr_qp {
> >
> > >  	struct ib_qp ibqp;	/* must be first */
> >
> > >  	struct qedr_dev *dev;
> >
> > > -	struct qedr_iw_ep *ep;
> >
> > >  	struct qedr_qp_hwq_info sq;
> >
> > >  	struct qedr_qp_hwq_info rq;
> >
> > >
> >
> > > @@ -395,6 +406,7 @@ struct qedr_qp {
> >
> > >  	u32 id;
> >
> > >  	struct qedr_pd *pd;
> >
> > >  	enum ib_qp_type qp_type;
> >
> > > +	enum qedr_qp_create_type create_type;
> >
> > >  	struct qed_rdma_qp *qed_qp;
> >
> > >  	u32 qp_id;
> >
> > >  	u16 icid;
> >
> > > @@ -437,8 +449,11 @@ struct qedr_qp {
> >
> > >  	/* Relevant to qps created from user space only (applications) */
> >
> > >  	struct qedr_userq usq;
> >
> > >  	struct qedr_userq urq;
> >
> > > -	atomic_t refcnt;
> >
> > > -	bool destroyed;
> >
> > > +
> >
> > > +	/* synchronization objects used with iwarp ep */
> >
> > > +	struct kref refcnt;
> >
> > > +	struct completion iwarp_cm_comp;
> >
> > > +	unsigned long iwarp_cm_flags; /* enum iwarp_cm_flags */
> >
> > >  };
> >
> > >
> >
> > >  struct qedr_ah {
> >
> > > @@ -531,7 +546,7 @@ struct qedr_iw_ep {
> >
> > >  	struct iw_cm_id	*cm_id;
> >
> > >  	struct qedr_qp	*qp;
> >
> > >  	void		*qed_context;
> >
> > > -	u8		during_connect;
> >
> > > +	struct kref	refcnt;
> >
> > >  };
> >
> > >
> >
> > >  static inline
> >
> > > diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> >
> > > index 22881d4442b9..26204caf0975 100644
> >
> > > +++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> >
> > > @@ -79,6 +79,28 @@ qedr_fill_sockaddr6(const struct
> > > qed_iwarp_cm_info
> > *cm_info,
> >
> > >  	}
> >
> > >  }
> >
> > >
> >
> > > +static void qedr_iw_free_qp(struct kref *ref)
> >
> > > +{
> >
> > > +	struct qedr_qp *qp =3D container_of(ref, struct qedr_qp, refcnt);
> >
> > > +
> >
> > > +	xa_erase(&qp->dev->qps, qp->qp_id);
> >
> >
> >
> > This probably doesn't work right because qp_id is not derived from the
> >
> > xa_array, but some external entity.
> >
> >
> >
> > Thus the qp_id should be removed from the xarray and kref put'd right
> >
> > before the qp_id is deallocated from the external manager.
> >
> Thanks! This is a good point.
> I will remove the element from xarray and kref put before deallocation, a=
s
> you mentioned, But will wait for the kref-free function to be called ( pe=
rhaps
> using completion ) Before deallocation.
Hi Jason,=20

Actually I was wrong about this one. I can't wait for the kref-free functio=
n to be called,=20
As it requires the deallocation flow to complete for ep->qp reference to de=
crease.=20
I think I can simply call xa_erase before the deallocation flow and not as =
part of the
Kref release function and call kref_put for the qp object at the end of the=
 flow after
everything is freed so that qp can be freed.

>=20
> >
> >
> > Ie you want to avoid a race where the qp_id can be re-assigned but the
> >
> > xarray entry hasn't been freed by its kref yet. Then it would
> >
> > xa_insert and fail.
> >
> >
> >
> > Also the xa_insert is probably not supposed to be the _irq version
> Right, this was originally an idr which was modified with the massive pat=
chset
> That changed all idrs to xarrays. I'll re-review it.
>=20
> >
> > either.
> >
> >
> >
> > > @@ -224,13 +249,18 @@ qedr_iw_disconnect_event(void *context,
> >
> > >  	struct qedr_discon_work *work;
> >
> > >  	struct qedr_iw_ep *ep =3D (struct qedr_iw_ep *)context;
> >
> > >  	struct qedr_dev *dev =3D ep->dev;
> >
> > > -	struct qedr_qp *qp =3D ep->qp;
> >
> > >
> >
> > >  	work =3D kzalloc(sizeof(*work), GFP_ATOMIC);
> >
> > >  	if (!work)
> >
> > >  		return;
> >
> > >
> >
> > > -	qedr_iw_qp_add_ref(&qp->ibqp);
> >
> > > +	/* We can't get a close event before disconnect, but since
> >
> > > +	 * we're scheduling a work queue we need to make sure close
> >
> > > +	 * won't delete the ep, so we increase the refcnt
> >
> > > +	 */
> >
> > > +	if (!kref_get_unless_zero(&ep->refcnt))
> >
> > > +		return;
> >
> >
> >
> > The unless_zero version should not be used without some kind of
> >
> > locking like this, if you have a pointer to ep then ep must be a valid
> >
> > pointer and it is safe to take a kref on it.
> >
> >
> >
> > If there is a risk it is not valid then this is racy in a way that
> >
> > only locking can fix, not unless_zero
> Ok, ep is valid here, I'll modify to kref_get. Thanks.
>=20
> >
> >
> >
> > > @@ -476,6 +508,19 @@ qedr_addr6_resolve(struct qedr_dev *dev,
> >
> > >  	return rc;
> >
> > >  }
> >
> > >
> >
> > > +struct qedr_qp *qedr_iw_load_qp(struct qedr_dev *dev, u32 qpn)
> >
> > > +{
> >
> > > +	struct qedr_qp *qp;
> >
> > > +
> >
> > > +	xa_lock(&dev->qps);
> >
> > > +	qp =3D xa_load(&dev->qps, qpn);
> >
> > > +	if (!qp || !kref_get_unless_zero(&qp->refcnt))
> >
> > > +		qp =3D NULL;
> >
> >
> >
> > See, here is is OK because qp can't be freed under the xa_lock.
> >
> >
> >
> > However, this unless_zero also will not be needed once the xa_erase is
> >
> > moved to the right spot.
> Right. Thanks.
>=20
> >
> >
> >
> > > +		/* Wait for the connection setup to complete */
> >
> > > +		if
> > (test_and_set_bit(QEDR_IWARP_CM_WAIT_FOR_CONNECT,
> >
> > > +				     &qp->iwarp_cm_flags))
> >
> > > +			wait_for_completion(&qp->iwarp_cm_comp);
> >
> > > +
> >
> > > +		if
> > (test_and_set_bit(QEDR_IWARP_CM_WAIT_FOR_DISCONNECT,
> >
> > > +				     &qp->iwarp_cm_flags))
> >
> > > +			wait_for_completion(&qp->iwarp_cm_comp);
> >
> > >  	}
> >
> >
> >
> > These atomics seem mis-named, and I'm unclear how they can both be
> >
> > waiting on the same completion?
>=20
> In IWARP the connection establishment and disconnect are offloaded to hw
> and asynchronous.
> The first waits for CONNECT to complete. (completes asynchronously) If we
> are in the middle of a connect that was offloaded (or after connect) the =
bit
> will be on and completion will be completed once the connection is fully
> established.
> We want to wait before destroying the qp due to hw constraints (can't
> destroy during connect).
>=20
> The seconds waits for DISCONNECT to complete ( doesn't always occur, only
> if a graceful disconnect was initiated on either side) Disconnect can't o=
ccur on
> a connection not established yet, so we can't get the completion of the
> disconnect instead.
> Similar for connect, once we start the disconnect we turn on the bit and =
will
> complete once the disconnect completes.
>=20
> I didn't see a reason to use another completion structure, since from wha=
t I
> read complete does comp->done++ and wait_for_completion checks done
> and eventually does done-- so it can be used several times if there is no=
 need
> to distinguish which event occurred first (in this case there is only one=
 option
> first connect then disconnect and disconnect can't occur without connect)
>=20
> But if this is wrong I will add another completion structure.
>=20
> Thanks,
> Michal
> >
> >
> >
> > > @@ -2490,11 +2488,11 @@ int qedr_destroy_qp(struct ib_qp *ibqp,
> > > struct
> > ib_udata *udata)
> >
> > >
> >
> > >  	qedr_free_qp_resources(dev, qp, udata);
> >
> > >
> >
> > > -	if (atomic_dec_and_test(&qp->refcnt) &&
> >
> > > -	    rdma_protocol_iwarp(&dev->ibdev, 1)) {
> >
> > > -		xa_erase_irq(&dev->qps, qp->qp_id);
> >
> >
> >
> > This is probably too late, it should be done before the qp_id could be
> >
> > recycled.
> >
> >
> >
> > Jason

