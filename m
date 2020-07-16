Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86036222ABD
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 20:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgGPSRh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 14:17:37 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:23028 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728257AbgGPSRg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jul 2020 14:17:36 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GIErYt002982;
        Thu, 16 Jul 2020 11:17:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=m2izq2YgT4BexewPxf6w/5T7jdUFzcdP8kvbziCc4J8=;
 b=CYzgq4VHJnpo3qdWa8f/4BtpUyRBtHZyc0P1AdMRO+17jp6bWTJMUCBPaAg/ORb87iG7
 9QWdbVM0JVvLvY+9bWm2WOVkWEf9ON+iggFGu6UeaaxkpQk/GyDZOGXWTg64q7ulvkWn
 FLrDBRt0PuSsoxzwwVI7nk18DToMBGPR9+FdeHfKgXPgdd/e/glsfPhK7ZP0zh3v5i5u
 vnGLBDh0yJka64kuGPAc83OTrTh083F+lXivtDmIWG0HEazhaVWHf5PcHBYhfPQyqr2C
 IU+D+blvR8Z+RJKiXYzb9OoELJadHOj820A19D7vBom9z26mfqYtugxDZoFXkk660xsc 2w== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 328mmj11a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 11:17:32 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 16 Jul
 2020 11:17:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 16 Jul 2020 11:17:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgSCpwTXSM+J+WAVab8iPb9xWzDP4vczV4EyXBVJPYA9LUpppbunSClLYcjeT03A+aa5rSiPrFpozVnXJdX/nilU/v8u9PqxanlbAJUQ8yJpD9xtXK3ijYFMJaGZSOTjy/4NVFDRHKZQ0hj8QqaVA601gxnMUo9mcra9kRnznYSFZv1flhuHhb5iuAuymDxoOkjxfiwRm6U5RqCCXxmoHe1DxRefSr4WdJkhXOq6x+E3R3Pe0Pvisy02iP7fAVewQ+GRPB8RxKnwszlX4Vbm0WIhMO/+5ODqw8jqzwXjzaG0LbzayRTUqRYHvjSX8BDgGqW5Zq8aeTPi0KsPSWyHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2izq2YgT4BexewPxf6w/5T7jdUFzcdP8kvbziCc4J8=;
 b=bLGzKbciTzXwavwoKTaIHvKzJRxXr4jken/+LmUUxoTdymPOUjgHL+tZ1yMleJHYjUN7tjwjvqDJqY5uJJRiToGwpn0BVqYj2YZTI3OKNKb22YNuBdpJaM/7ty+/Jzid186QHSbRl6ciVIi1mLK/a5tQUgz8kuVhT4TC3LRHSAsewUpJQP6te0C73SytkZtT39zuPlWiulDso0RBFG+aTEzmpGBK5+HGBFVZ0l7pdv4oaFNyarCxlfRyDhyoKY/CpmaVQIElERSQrr9cTAZZu4YXQ0wV1WXEffLPMTpJFfCyWxNGzG8Ot/T/PdJR4vivqIZmhP8tc9SIPSqsD12Aaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2izq2YgT4BexewPxf6w/5T7jdUFzcdP8kvbziCc4J8=;
 b=q9r0JlPAC0vksn4jCisK4tpo678hQl0d/L2/or4Hmfjovx3/DKPTvCgTX4rFoPGs3Uyr5Te7V1oCBnVad+/44O94CGMzRLMc8OnqrSM2n1wt9Ll+wPcGbo96x5XOeCPOZdOMJJZalLKVYG5OM9MAyJPf+dUx9D4Xi8cfg01YO/w=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by BL0PR18MB3745.namprd18.prod.outlook.com (2603:10b6:208:81::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 18:17:29 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::1849:3020:9782:8979]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::1849:3020:9782:8979%4]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 18:17:29 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        Ariel Elior <aelior@marvell.com>,
        Yuval Basson <ybason@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v3 rdma-next 2/2] RDMA/qedr: Add EDPM max size to alloc
 ucontext response
Thread-Topic: [PATCH v3 rdma-next 2/2] RDMA/qedr: Add EDPM max size to alloc
 ucontext response
Thread-Index: AQHWVCg0clmxjwo/n0KUKYS9RwmNz6kKf9GAgAAQojA=
Date:   Thu, 16 Jul 2020 18:17:29 +0000
Message-ID: <MN2PR18MB31824C9F96D7F0D511D9B261A17F0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20200707063100.3811-1-michal.kalderon@marvell.com>
 <20200707063100.3811-3-michal.kalderon@marvell.com>
 <20200716171055.GA2645531@nvidia.com>
In-Reply-To: <20200716171055.GA2645531@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [46.116.41.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d272a105-892f-48a1-b992-08d829b48060
x-ms-traffictypediagnostic: BL0PR18MB3745:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR18MB374524B0C5100184C6682C28A17F0@BL0PR18MB3745.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /lFIBJfTZlZSl9san3jebshZIEYNm1xbLWTfhj6aRkv3cnyEVPSe98D9qJngX9OFs3S/PBnMoXzVz3y9pu0M+YYFqGw+iOD/oBhdANMaN6b1tBzbHUuUyEzPf/+8ZkMv1gXgGD6g4h5yK7uJQ7BTBO9SgyCB9zcb5HpzMwp/aJgzWO3R5qZR2xKw3xmNClCG/AeTEHjpRptRvLN3DfGsPt9cZuIsxjxAXGTQ19Ol8YPjbjeAkBrstEdKLlIzf/4cCMoheZgtzcXIVpvhkGzyiOYnqhgyQyK6IvNaBIN6aKkZ7RBQcbaeLx1ihVasftVGM/Yvq5sCJP8k+9n8V0Egmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(83380400001)(54906003)(66946007)(33656002)(76116006)(66556008)(66446008)(55016002)(64756008)(8936002)(5660300002)(52536014)(478600001)(8676002)(71200400001)(66476007)(9686003)(7696005)(316002)(2906002)(4326008)(6506007)(186003)(26005)(6916009)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 3Wl8HH3fs00R7BRvIbfDgsCZahd+DUHi1o6D/5qfZYyyFLzxohGeR3HhyL8iX2hbu9E0JJ/aqPsS2covFCd9TB3yen0nYm97lZe4z6MNFFnYaARgiL5ritt6wlkS5wzLklDLz9jVyzyjjhzSh8p1bIJb28dGj9pTfoRilPsRWIkC3Q39l0yKDr3hGk5zv2HCKsvbTNfgITyqf++qll9i9PGj0vSfjTlOCIW4IYcREU5OyijgYwP9angGtKKNWrCyGuFJyMcWs0djy1GmAai/oPFx9Epl16u6cKOBg5yv5jPJwX1jdU2uFsDU+cVn2vg87yAH92i7bzAgb4nPwCvZuL627LciqkysEKo0l4u+iVG62CQui4VnWPu2iJ+M9CmyLKLDzSMENGwJuYugte6z6LCrDqhRFtc5zymrysphiDuXwKQEckRDXRa06T+BQe7wWFkeEDDu036jPu4RBOrV/h1HDrIVOEAwCouBVYTmE+Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3182.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d272a105-892f-48a1-b992-08d829b48060
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 18:17:29.5750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sm2aroQ4xdz1Ae7g+DRVQ8KLj6KVWULZVpB5XEIyayZZXVho1zep+Q+6QXKEnaR88fhMSitgs0yGMlE3KgTcTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB3745
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_08:2020-07-16,2020-07-16 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
>=20
> On Tue, Jul 07, 2020 at 09:31:00AM +0300, Michal Kalderon wrote:
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
> > drivers/infiniband/hw/qedr/verbs.c | 9 ++++++---
> >  include/uapi/rdma/qedr-abi.h       | 6 +++++-
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/qedr/verbs.c
> > b/drivers/infiniband/hw/qedr/verbs.c
> > index fbb0c66c7f2c..cfe4cd637f1c 100644
> > +++ b/drivers/infiniband/hw/qedr/verbs.c
> > @@ -320,9 +320,12 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx,
> struct ib_udata *udata)
> >  				  QEDR_DPM_TYPE_ROCE_LEGACY |
> >  				  QEDR_DPM_TYPE_ROCE_EDPM_MODE;
> >
> > -	uresp.dpm_flags |=3D QEDR_DPM_SIZES_SET;
> > -	uresp.ldpm_limit_size =3D QEDR_LDPM_MAX_SIZE;
> > -	uresp.edpm_trans_size =3D QEDR_EDPM_TRANS_SIZE;
> > +	if (ureq.context_flags & QEDR_SUPPORT_DPM_SIZES) {
>=20
> Why does this need an input flag just to set some outputs?
>=20
> The usual truncate on not enough size should take care of it, right?
At this point it just sets some output, but for future related changes arou=
nd these sizes
there will also be fw related configurations, we will need to know whether =
the lib supports
accepting different sizes or not. This is for forward compatibility between=
 libqedr and
driver.=20

>=20
> Jason
