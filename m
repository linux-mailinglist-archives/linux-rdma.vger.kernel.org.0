Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9FAE3D7F
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 22:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfJXUqL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 16:46:11 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:63466 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726973AbfJXUqK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 16:46:10 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9OKeV8t029664;
        Thu, 24 Oct 2019 13:46:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=TtV4YBQ7RsbHtGFIfXFZaVykXpAkSfejK1X+BlVeR/0=;
 b=wp6PEOuaNeBEDsD57/vCBdmRs2ivKCKMOvCjvynq5jfSyh07tEKhP7FCZerBTjbNfbVB
 Oj2rM0+LsRgZISA08qqdwqVD2FUQU5GyfD/0VUdX9Yu7FxDFyCaz8ajtj1BkoAu5IzDJ
 HVcYIEsWu7yuDABiWHfnChgYN0tblabh2Ho5Tf1BSMTFlMsUI5S5RPVjW4ltbobz7GYF
 BTR8ddOMIDVhL3Ap1G/Ircxa4D+OGsNJ9zRcMN7nYyl3sU1/M20GHBlK+NxHrZWtDFLU
 6dkqZkcZeq/i63K7nfrJGkRpTcAHtC5OeQgMLGuFYhRUgqgwfweSTs8ep/qhd5QPVCWx Qg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vt9ujs4b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Oct 2019 13:46:07 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 24 Oct
 2019 13:46:05 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 24 Oct 2019 13:46:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRNpQA0AcbT5hJL3/MNRl26GEr2Ixi+8Ssk0+49kMIQHNwKaTc2RWYfXkhhacR33nkt8YVLukVqZ3+KbJXsPETDUFUeT7yvhYH7S2WjgK9pyZv1QlLfgWTDR/B5ssa4i+aRPnpzSCktpwIzEHwOtA56CuV/nZ3cnwv9UHCkqcS9sKba3kiInx3gjJcm/HjtJ5aGaX1s6/bwIU160Wxf4FtCddv3sADnPHa1dil5U0O2RXFVx12V8UtRBf5rhC8bh/pmDXfQF8Q/LlVTsX9dhvxD+LBG/7WK7Gaifh3mFOcy5XcS3YK8BF440LSNzq/KuS2SbfxrI7PqnivXCmgU0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtV4YBQ7RsbHtGFIfXFZaVykXpAkSfejK1X+BlVeR/0=;
 b=TQi8+Fb3JDzNuDW2uhUjduwgS/u8YK3erzjoS7BhdT/hIawUOxHTd/Tb41VXIM/l+51rY8uiV8GF0ctCCPKxhWYKYkHIiClS6CI9U0G2zopUKA5xp1ZTKOVQUE9KSFtqcvWkD4SG7UJgmuR2Ec8cPe5hmCGR5xwu5RV0sFz6Rvl+Jn4dAyOM4S9n/xsb8KEOqjBg0QUk6Y5U+ANPIv1tFStc1odNI/WVX1ZzJNVyzAYiscMdK0Gl8nwe8Gsu1tMvGQX7TmMy5q7LpZ9GYgShhFBwRiC9EPkriaE8ePdAiFaVR40ZPUau0rH9j2f4F4Je/jHWseZAoHBAj8mAw4BhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtV4YBQ7RsbHtGFIfXFZaVykXpAkSfejK1X+BlVeR/0=;
 b=GnA/lXKJXLAue8774HAVjXQP9JiQH34XoOrO/XkGgFRxqfO+swmqK1Ae0HXN8KYDCA+ICk/qRWMNHOqSOuwH+Ywq08CsD3RWukvs5AJI9m6XIuRZjT76nxf9g7jaRW620gLol4PqMczvZsNzkLXczjHbv/RwqMfSaBJ3oAeqNsA=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2943.namprd18.prod.outlook.com (20.179.22.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 24 Oct 2019 20:46:04 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811%6]) with mapi id 15.20.2387.023; Thu, 24 Oct 2019
 20:46:04 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [EXT] Re: [PATCH v3 rdma-next 1/3] RDMA/qedr: Fix qpids xarray
 api used
Thread-Topic: [EXT] Re: [PATCH v3 rdma-next 1/3] RDMA/qedr: Fix qpids xarray
 api used
Thread-Index: AQHVipQ4738vWoSORkiY/YbHeWNv5KdqFtWAgAAiFhA=
Date:   Thu, 24 Oct 2019 20:46:04 +0000
Message-ID: <MN2PR18MB31822BE81656DCB137683D3CA16A0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20191024175253.26816-1-michal.kalderon@marvell.com>
 <20191024175253.26816-2-michal.kalderon@marvell.com>
 <20191024180811.GY23952@ziepe.ca>
In-Reply-To: <20191024180811.GY23952@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.176.87.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88992033-58dc-4cb3-1c72-08d758c3300e
x-ms-traffictypediagnostic: MN2PR18MB2943:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2943FBB577507FBE45AFFE66A16A0@MN2PR18MB2943.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(229853002)(3846002)(33656002)(6116002)(6246003)(76176011)(14444005)(256004)(14454004)(71190400001)(71200400001)(102836004)(6506007)(26005)(305945005)(486006)(7736002)(446003)(11346002)(86362001)(2906002)(99286004)(186003)(476003)(107886003)(5660300002)(66446008)(66476007)(64756008)(6436002)(66556008)(6916009)(66946007)(4326008)(52536014)(7696005)(76116006)(66066001)(81156014)(81166006)(8676002)(478600001)(25786009)(8936002)(316002)(54906003)(55016002)(9686003)(74316002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2943;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ocD9jI2wFFtsUkd404VtqEXlTHQ72vXQRBr9We9imDWxt9iAh/BScDSA9l+qcio2zakPtca8DdU3Ou7KNKjMTXU36MogFrc/bfdQyA0rK458eY8Jl10HzK/420EWBvZDO0VCL0JO+9hA9lvRL4T6MPxCmbYQuJx/TxmQYVxIUONKo4dQgMtJ9NPil6kVebUVSfwMb8EgckLlgsEL20wmjQ6kpSdDZKiHRNiAmjlxzA6a6pLj/wfCGCUqdMHBxe/QoHajZkpX+QlotyQDYVOVbQJGZ/zkCH7Y+NssZLTrVrY7lnd9evLLiGl+Z/+r/jcKXV29FJqc2u/8pThAFp2gMVxeyKVdQ5TRgLlZbKNTUHyjdIWZy0wEMs5KDjdYb9TnWxCpPdy80HFIOaScwoN94FqM0cUCcfO/kBx5l2DbkRYn2Zpiwvi6lcneIkE6D+Gw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 88992033-58dc-4cb3-1c72-08d758c3300e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 20:46:04.2253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Map7onRmGjwEPFctU0/OhQjGhnqTA5I9/Id/fPiZcdrM3FdWyR89R4grFVZacyoyElOJiXSVSoBH5lHJYWCDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2943
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-24_11:2019-10-23,2019-10-24 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, October 24, 2019 9:08 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Thu, Oct 24, 2019 at 08:52:51PM +0300, Michal Kalderon wrote:
> > The qpids xarray isn't accessed from irq context and therefore there
> > is no need to use the xa_XXX_irq version of the apis.
> > Remove the _irq.
> >
> > Fixes: b6014f9e5f39 ("qedr: Convert qpidr to XArray")
> > Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> > Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> >  drivers/infiniband/hw/qedr/main.c       | 1 -
> >  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 +-
> >  drivers/infiniband/hw/qedr/verbs.c      | 4 ++--
> >  3 files changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/qedr/main.c
> > b/drivers/infiniband/hw/qedr/main.c
> > index 5136b835e1ba..432dff95a7aa 100644
> > +++ b/drivers/infiniband/hw/qedr/main.c
> > @@ -359,7 +359,6 @@ static int qedr_alloc_resources(struct qedr_dev
> *dev)
> >  	spin_lock_init(&dev->sgid_lock);
> >
> >  	if (IS_IWARP(dev)) {
> > -		xa_init_flags(&dev->qps, XA_FLAGS_LOCK_IRQ);
>=20
> The xarray still has to be init'd, surely?
Yes, you're right, not sure how this slipped and passed regressions (perhap=
s since eventually init zeroes everything).
I just noticed that in original=20
Commit for srqs xarray 9fd15987ed27 ("qedr: Convert srqidr to XArray") ther=
e was no=20
Call to xa_init or xa_init_flags either. Will fix that as well in v4.=20
Thanks.
=20
>=20
> Jason
