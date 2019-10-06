Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A006FCD8F8
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2019 21:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfJFTtO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Oct 2019 15:49:14 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:57528 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbfJFTtO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 6 Oct 2019 15:49:14 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x96JjsMZ014942;
        Sun, 6 Oct 2019 12:49:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=NrP8CuzRcs/W2WEQr4XLhnuMF3UcgKfIlUQISnaKdSI=;
 b=O2O7awNFJ51lvvGmFIUSGYG9a+csKsGnEEUSAX87UVQlYq58YyduVZQTUMPb6Lnp1NpE
 yFLJXfXZodALYt0JPIx8q19HpRZasmzMOLovSvV/pNHQDv8qlwVeHj3AVMZl5cqTGDf0
 VBIhBSrLAeXGuSZloCIFjt2FtwhWesYW7hVxgj+vS63yZkxTbp58ubQWCH4W0sW5nZsX
 Jvx3PQsjlVMQn3NMYetSEcWh6qehxykDda3qHjbEQEvb9akNqo3PWNhFjaEOQLYPHlSR
 UPHxyIAHKVDDaHFy4PrCyj8ntwrNd0Hjd1ltD0A219F42sr4QcYY9mkYEjIOPONr/vAW /g== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vetpmujn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 06 Oct 2019 12:49:09 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 6 Oct
 2019 12:49:07 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 6 Oct 2019 12:49:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpxoDIzax5rGuXgPSXaW2aETGKqKd5KyuvxeclvYQE3KCtCNi/JCFCmk8AR3rnoYNN4twf7m8ZOLE9VJTo0wU8hftnVNEseqkcbJcTug3QRDS5NIV412O5FgG15UiZUsQbS0qNNXjNVspm5Ctiug4bR94+o2l4mZf72cdDzrAQEIdf37XCOEvEdmvc19m+dTkbEOghrxHcctVmLQGV/kzkgYGVCaUSYqTsnAgywMHXnfQ82Zn3McMBcENkp4D1SEeJcB3PLx0IA+e77+QfKDpXQW9qAB2vT7zfmU3xPVusjdnudnx77Xpk4pB8AfyzNSWl0+bvTpvYSOI2RJVVEeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrP8CuzRcs/W2WEQr4XLhnuMF3UcgKfIlUQISnaKdSI=;
 b=N/fgOLh3GLrc5ARXR7Ve7D5AgUNGbx2vxdmtibWGGrYygFKF8O6DVSjkr36B/aUZ93MFW2FJDfB7JuWndTa8y18OuZ7g2o27cynMfbfyVkuLqbtlr+sILy/sUlDaWPvp0CC7Ph0K5LzgFaXu6lej9dZs7Sx4DCwlJ6gg4sW/dTbHNd8+LZJd2mIPwqnagXMg/CNeIBVsh3+dI21a82fbhPngj83Uf4cHIxwfWCT4SH9WSF4v7ioJd3Ock++Wwd53w6vSVzumeLcnKEi2zX98VOL7gOTXNiVJS2gQeE3HCayTY0nuBCEer769iFCt0WwjM9Q7HdrcHa57IJFOCNkCgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrP8CuzRcs/W2WEQr4XLhnuMF3UcgKfIlUQISnaKdSI=;
 b=J69dL5SBYBb1sOTQICpTFOZzHeP2Ry1H3rw2/tPg0IAjVFRHVmzipJdRN7cgjX7Q42w0G8mrwUN3k5LHg5ajMLXMh/2oRIT9rhCBFwnhqfj2/xzLV/CUXBh1mbCZDSSCbIb5P0RNhUoC3LfoSIr+HPGQusvwt+a2LfyYZnbAna0=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3325.namprd18.prod.outlook.com (10.255.86.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Sun, 6 Oct 2019 19:49:06 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811%6]) with mapi id 15.20.2327.023; Sun, 6 Oct 2019
 19:49:06 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH rdma-next 1/2] RDMA/qedr: Fix synchronization
 methods and memory leaks in qedr
Thread-Topic: [EXT] Re: [PATCH rdma-next 1/2] RDMA/qedr: Fix synchronization
 methods and memory leaks in qedr
Thread-Index: AQHVeeL/Zqn8Gmyl/0KSJPUwmRq186dJGBGAgAAuYTCAAF02gIABE/yAgAAGxQCAA0qesA==
Date:   Sun, 6 Oct 2019 19:49:06 +0000
Message-ID: <MN2PR18MB3182C44253B9C98D2BBC8179A1980@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20191003120342.16926-1-michal.kalderon@marvell.com>
 <20191003120342.16926-2-michal.kalderon@marvell.com>
 <20191003161633.GA15026@ziepe.ca>
 <MN2PR18MB318226121DAB349647E1903CA19F0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20191004003609.GC1492@ziepe.ca>
 <MN2PR18MB3182A3BF6C37425F9AA82757A19E0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20191004172810.GA13988@ziepe.ca>
In-Reply-To: <20191004172810.GA13988@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.182.56.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24e799f4-388a-43a8-2573-08d74a963f59
x-ms-traffictypediagnostic: MN2PR18MB3325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3325A30FB56CB7BD7DDDF721A1980@MN2PR18MB3325.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0182DBBB05
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(316002)(6116002)(66556008)(3846002)(66446008)(64756008)(66476007)(5660300002)(2906002)(71200400001)(71190400001)(66946007)(76116006)(8676002)(478600001)(55016002)(229853002)(81156014)(81166006)(9686003)(14454004)(86362001)(54906003)(6436002)(6246003)(25786009)(6916009)(11346002)(446003)(52536014)(8936002)(33656002)(4326008)(66066001)(26005)(99286004)(305945005)(7736002)(186003)(486006)(74316002)(476003)(14444005)(256004)(102836004)(6506007)(76176011)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3325;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mgc4Ur4qyAr7LoSfsM0ROGlZvlz05DlfLWHANwwi+UVEqXqgaJbLL32cKrkDgYsMXWnOublHyy4s6Umk7IIjhglg+m7ZLoxEXep+mZYBSf1muw6OeDULQ9Tb4ZCgY5oaRUF0v1Vy30+tHCpq/P9f41S7wDZ11vtU7K9+kaXFqZM7v9aMJ2ciVtynOGkR+OPg1lun6vfZtsv6x195TjLuIBKNTiXrwNPHVP0N4KNMLL2MgtfuBALjoL+wE5KkNOh9cJlAZsqf3GzSWLjaTBe9QNfFO2oZ+xj/mk9/5sz9b+ldmNM2HoXyEyqWLgDsYKvPr1Wxkq/lAJ4OhyI7fXNrOZ9li7xPn0Ubq8CRo1904WARBgYsnmdjOOH5k6f7o1iFlYk4l9Hd85T5aUIrTnZ6KsdvjkYHxSwEl/xSxBpt06w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e799f4-388a-43a8-2573-08d74a963f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2019 19:49:06.2232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EWCTj8PcvagzzRSkg5dxxTXbZzFo+gURFbKpRGYQKi9ps2wDuSuMEKYfqOneTXudyEu2wse/aZSbXf4ka+rdyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3325
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-06_08:2019-10-03,2019-10-06 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, October 4, 2019 8:28 PM
>=20
> On Fri, Oct 04, 2019 at 05:10:20PM +0000, Michal Kalderon wrote:
> > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
> > >
> > > On Thu, Oct 03, 2019 at 07:33:00PM +0000, Michal Kalderon wrote:
> > > > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > > > Sent: Thursday, October 3, 2019 7:17 PM On Thu, Oct 03, 2019 at
> > > > > 03:03:41PM +0300, Michal Kalderon wrote:
> > > > >
> > > > > > diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > > > > > b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > > > > > index 22881d4442b9..ebc6bc25a0e2 100644
> > > > > > +++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > > > > > @@ -79,6 +79,28 @@ qedr_fill_sockaddr6(const struct
> > > > > > qed_iwarp_cm_info
> > > > > *cm_info,
> > > > > >  	}
> > > > > >  }
> > > > > >
> > > > > > +static void qedr_iw_free_qp(struct kref *ref) {
> > > > > > +	struct qedr_qp *qp =3D container_of(ref, struct qedr_qp,
> > > > > > +refcnt);
> > > > > > +
> > > > > > +	xa_erase_irq(&qp->dev->qps, qp->qp_id);
> > > > >
> > > > > why is it _irq? Where are we in an irq when using the xa_lock on
> > > > > this
> > > xarray?
> > > > We could be under a spin lock when called from several locations
> > > > in core/iwcm.c
> > >
> > > spinlock is OK, _irq is only needed if the code needs to mask IRQs
> > > because there is a user of the same lock in an IRQ context, see the
> documentation.
> > >
> > > > > > @@ -516,8 +548,10 @@ int qedr_iw_connect(struct iw_cm_id
> > > > > > *cm_id,
> > > > > struct iw_cm_conn_param *conn_param)
> > > > > >  		return -ENOMEM;
> > > > > >
> > > > > >  	ep->dev =3D dev;
> > > > > > +	kref_init(&ep->refcnt);
> > > > > > +
> > > > > > +	kref_get(&qp->refcnt);
> > > > >
> > > > > Here 'qp' comes out of an xa_load, but the QP is still visible
> > > > > in the xarray with a 0 refcount, so this is invalid.
> > >
> > > > The core/iwcm takes a refcnt of the QP before calling connect, so
> > > > it can't be with refcnt zero
> > >
> > > > > Also, the xa_load doesn't have any locking around it, so the
> > > > > entire thing looks wrong to me.
> > > > Since the functions calling it from core/iwcm ( connect / accept )
> > > > take a qp Ref-cnt before the calling there's no risk of the entry
> > > > being deleted while xa_load is called
> > >
> > > Then why look it up in an xarray at all? If you already have the
> > > pointer to get a refcount then pass the refcounted pointer in and
> > > get rid of the sketchy xarray lookup.
> > >
> > I don't have the pointer, the core/iwcm has the pointer.
> > The interface between the core and driver is that the driver gets a qp
> > number from the core/iwcm and needs to get the QP pointer from it's
> > database. All the iWARP drivers are implemented this way, this is also =
not
> new to qedr.
>=20
> That seems crazy.

I can take an action item on looking into redesigning this together with th=
e other iwarp vendors.
For this series, that attempts to fix some leaks and concurrency issues in =
qedr ,
are there any more issues except the  xa_erase_irq which you would want me =
to fix for v2?

Thanks,
Michal=20

> Jason
