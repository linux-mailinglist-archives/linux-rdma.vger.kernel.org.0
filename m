Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6002165F5
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 07:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgGGFps (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 01:45:48 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:62294 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727088AbgGGFps (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 01:45:48 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0675ehai021390;
        Mon, 6 Jul 2020 22:45:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=crAM+eY/P0urJRPUVWkVVssMQTv3x2Nekq2mJPHcilU=;
 b=EuYwE7JkukugKAjqmMc29/E+7tufTFAZ134Eg7gWEqYIWKyKl/qp7Nj3iRLd3a6L4HaF
 pwKkwMgtQZIaKbRNXrtuwkmuZoP3IF3HPCy7nQzsisZ5ivafKGwgvRSb8A3AEtNAGeOP
 VqZbcVlQa4z0wiXZaUVLIukHrwNwFF2ZLcNGoxptxIP6DBJz2F6PpzE2kLsONv2zRUci
 fOKrxwcge+EyCMm4t+fp1pOeOvYUexgORsDp3uP57jgFiL9Z59CwZceioweNRTb4qhRY
 IAmaXqgUyaevSf6TzNDSMVUBVV+acKKCyz3hM3oFjZ8oO3FJkhkp1QMVZzrMh5jnEqsa BQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 322s9n9jcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:45:43 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 6 Jul
 2020 22:45:42 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.53) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 6 Jul 2020 22:45:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMVgEDEPDQITICVpitpDuBRUu8L2Fes3JRjLurBxYY7Yi1gFftxUk7944uvArWUAPLNSksXRQ6vrfl7eVHJwym0JvRqByS6aakKLx8x4ObWHHqn2+FzyCErGld/lSq3rwxpGl/XYweYI0CjQZpZdsGNhs6f/hFL9ZjjjI97PWrByH6RZJCeHhGH7QmP2FnX0fkVxJzkTlGIGns9fqyDMQnTMHBFqOBgxhYlnOHuy59uGfjcDZbu62cHnt0zq2SZf6RMMEiJOjRdGW1wr/ORbQRaqdJzD4Dr/P7hQHc5oINa46MIHcBefus2jZumyBxaBgR8Vy0YpfT1p5nKzRR1pdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crAM+eY/P0urJRPUVWkVVssMQTv3x2Nekq2mJPHcilU=;
 b=mtqdgeeUDJ2+v4yXqYOBI4/2zvceQvr5XAVsDiqXuShQIJdlT45B2ns/Ulx+t6bpFsGRNrU/K9ppkqZWqUBsWX7oxvZ9MWX02RTbJBs4HjdhZgTYiAJ5wSAS0/FsCjvzpNIT3T3WPSZKibNE9Nfih0ZeBJoiZFcxZ29TRSTLOF1DJC0CbwMuD2Q84qmUdH6KfjQ5dG45x5swpt1nldWz5OkmQvIBd5Ypsr3SvXcVhCV61ggqoBPqpNpVofenDWA5QK7/h+UvBpB7L16oYOyykd+MfOEV/RFbLjUgdXQoQmq/i4LJ2rYJvwkLukiO/SQWPMJiGI8eQNBfZ+ZHjs2pzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crAM+eY/P0urJRPUVWkVVssMQTv3x2Nekq2mJPHcilU=;
 b=Rw1u5DZB1c4BSAe4P8hykdu5w46wa4YuIrkTGioM4fqp6nt1QD3AGVHpTQwrciTh4JkVXfxw6Xes91Gx4npL/EX7Hil7SkwdoRfKzR83cnMvg1rVDoN3LgPEW6I6KKXPWmx05ZOx1e7EIF6M0LB1X+1HtVNrn2VDX+TN29tne/w=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by BL0PR18MB2116.namprd18.prod.outlook.com (2603:10b6:207:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Tue, 7 Jul
 2020 05:45:40 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::1849:3020:9782:8979]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::1849:3020:9782:8979%4]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 05:45:40 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Ariel Elior <aelior@marvell.com>,
        Yuval Basson <ybason@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [PATCH v2 rdma-next 2/2] RDMA/qedr: Add EDPM max size to alloc
 ucontext response
Thread-Topic: [PATCH v2 rdma-next 2/2] RDMA/qedr: Add EDPM max size to alloc
 ucontext response
Thread-Index: AQHWU8wxbBElPhIz/kWNuRW1GS6JOqj7izyAgAAQuKA=
Date:   Tue, 7 Jul 2020 05:45:39 +0000
Message-ID: <MN2PR18MB3182A4C3363CDC1969F43592A1660@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20200706193214.19942-1-michal.kalderon@marvell.com>
 <20200706193214.19942-3-michal.kalderon@marvell.com>
 <20200707044519.GJ207186@unreal>
In-Reply-To: <20200707044519.GJ207186@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [46.116.41.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5c750ea-8674-453a-551d-08d82238fb49
x-ms-traffictypediagnostic: BL0PR18MB2116:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR18MB211600B01A69864D255AF968A1660@BL0PR18MB2116.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: //A+SCq2YPlmVXXn5GdjqhDWXLHew2fp56F3nYR1OgUsCQO8YHDrE6V2DTE3I7YWVplOyTMn1gyRtV5E1BMu/QU7Xi0n45vugQgNoL7pzfDmp9lBlN+f9MlvjTnsoBWT0FSYBa1rjPhM4ZT29/R7XlKOf72JyYn7tP2GyDxJmqd5U0iZAd8sf0ns6m9n4T14JUc4x3qnlu52LMsBeJeqrWzL78MAB2QT9q/NJD2IfG/FiJ76W4Z1cb/wI61FttvbomTE5JFLmHAZuvkfsqQtwYvcuBNWlg14ChQlT885gnJLVp5F7ORxPbxSTPbuSmgGE4Ov8C1Abc5g3J/A3bEjkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(52536014)(107886003)(9686003)(66556008)(64756008)(66446008)(83380400001)(478600001)(6506007)(66476007)(4326008)(7696005)(76116006)(86362001)(8676002)(5660300002)(316002)(54906003)(2906002)(8936002)(186003)(6916009)(26005)(71200400001)(66946007)(55016002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BQrtX1I+BVbAmB7BZzoo0Idr5gUJ8tafkX7rWtncj26TBznVCalvS4fQLJ3wN/PAVGUXbA4zXTi/sPtlIU+tcylMUgC+jBALpBnk2tqTArGHNI+Yx+27i0/64LFp5gLZbCBRGdGe2hl4CBKP/goG28FrUZtRfSbWeguz1W2a7zJjIegdMIdkUSNcb0lVlSkNoc0359flBFWbJM2AL5F0+ddTWRQTbIuv3eqMYQopk32IUopSV64p+Ljp7e8zKwloeuvWywqBHpMByCsJ6PqG2HqRgvoq5QfHNWyxZ7YgZYGIvqXRgh8HhW04C5iWUFTbLL06DLF/eAB8HWXEm0Pplx3wqumafMsGHGNN4/ocaWUWAF4WBJ0RQTWDkX8Zf/8R9RgkVR6oL83XH+m8h4ROCcM5swdT2bVQ05rmv4WgXE41ZqTFsCc1X5Ee2l7n3rIPoFMJ74pfPq9XZgoLQPVB7Gnmts1iNUKfJ7uMzfZPX+0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3182.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c750ea-8674-453a-551d-08d82238fb49
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 05:45:40.0306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LCWG2ADu112LvjYUHqbp7a4TRl3mlooyx6jlPHqRJXr3FWLBBJhAIUmmTu22qDEd3X/hLhBGDuCnemHK0BAjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2116
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_02:2020-07-07,2020-07-07 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Leon Romanovsky
>=20
> On Mon, Jul 06, 2020 at 10:32:14PM +0300, Michal Kalderon wrote:
> > User space should receive the maximum edpm size from kernel driver,
> > similar to other edpm/ldpm related limits.
> > Add an additional parameter to the alloc_ucontext_resp structure for
> > the edpm maximum size.
> >
> > In addition, pass an indication from user-space to kernel (and not
> > just kernel to user) that the DPM sizes are supported.
> >
> > This is for supporting backward-forward compatibility between driver
> > and lib for everything related to DPM transaction and limit sizes.
> >
> > This should have been part of commit mentioned in Fixes tag.
> > Fixes: 93a3d05f9d68 ("RDMA/qedr: Add kernel capability flags for dpm
> > enabled mode")
> > Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> > Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> > ---
> >  drivers/infiniband/hw/qedr/verbs.c | 9 ++++++---
> >  include/uapi/rdma/qedr-abi.h       | 6 +++++-
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/qedr/verbs.c
> > b/drivers/infiniband/hw/qedr/verbs.c
> > index fbb0c66c7f2c..f03178866b50 100644
> > --- a/drivers/infiniband/hw/qedr/verbs.c
> > +++ b/drivers/infiniband/hw/qedr/verbs.c
> > @@ -320,9 +320,12 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx,
> struct ib_udata *udata)
> >  				  QEDR_DPM_TYPE_ROCE_LEGACY |
> >  				  QEDR_DPM_TYPE_ROCE_EDPM_MODE;
> >
> > -	uresp.dpm_flags |=3D QEDR_DPM_SIZES_SET;
> > -	uresp.ldpm_limit_size =3D QEDR_LDPM_MAX_SIZE;
> > -	uresp.edpm_trans_size =3D QEDR_EDPM_TRANS_SIZE;
> > +	if (!!(ureq.context_flags & QEDR_SUPPORT_DPM_SIZES)) {
>=20
> "!!" is not needed here.
>=20
> Thanks
You're right, I'll fix. Thanks.

>=20
> > +		uresp.dpm_flags |=3D QEDR_DPM_SIZES_SET;
> > +		uresp.ldpm_limit_size =3D QEDR_LDPM_MAX_SIZE;
> > +		uresp.edpm_trans_size =3D QEDR_EDPM_TRANS_SIZE;
> > +		uresp.edpm_limit_size =3D QEDR_EDPM_MAX_SIZE;
> > +	}
> >
> >  	uresp.wids_enabled =3D 1;
> >  	uresp.wid_count =3D oparams.wid_count; diff --git
> > a/include/uapi/rdma/qedr-abi.h b/include/uapi/rdma/qedr-abi.h index
> > b261c9fca07b..bf7333b2b5d7 100644
> > --- a/include/uapi/rdma/qedr-abi.h
> > +++ b/include/uapi/rdma/qedr-abi.h
> > @@ -40,7 +40,8 @@
> >  /* user kernel communication data structures. */  enum
> > qedr_alloc_ucontext_flags {
> >  	QEDR_ALLOC_UCTX_EDPM_MODE	=3D 1 << 0,
> > -	QEDR_ALLOC_UCTX_DB_REC		=3D 1 << 1
> > +	QEDR_ALLOC_UCTX_DB_REC		=3D 1 << 1,
> > +	QEDR_SUPPORT_DPM_SIZES		=3D 1 << 2,
> >  };
> >
> >  struct qedr_alloc_ucontext_req {
> > @@ -50,6 +51,7 @@ struct qedr_alloc_ucontext_req {
> >
> >  #define QEDR_LDPM_MAX_SIZE	(8192)
> >  #define QEDR_EDPM_TRANS_SIZE	(64)
> > +#define QEDR_EDPM_MAX_SIZE
> 	(ROCE_REQ_MAX_INLINE_DATA_SIZE)
> >
> >  enum qedr_rdma_dpm_type {
> >  	QEDR_DPM_TYPE_NONE		=3D 0,
> > @@ -77,6 +79,8 @@ struct qedr_alloc_ucontext_resp {
> >  	__u16 ldpm_limit_size;
> >  	__u8 edpm_trans_size;
> >  	__u8 reserved;
> > +	__u16 edpm_limit_size;
> > +	__u8 padding[6];
> >  };
> >
> >  struct qedr_alloc_pd_ureq {
> > --
> > 2.14.5
> >
