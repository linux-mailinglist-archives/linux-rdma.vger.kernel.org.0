Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E11CC164
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfJDRK3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 13:10:29 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:60806 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbfJDRK3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 13:10:29 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94GsYYB014984;
        Fri, 4 Oct 2019 10:10:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=umC2SJ3IBW9vKLcfszuAyJ/B60gUsF4eaYTaqWDTgzU=;
 b=u8F/c5+9qBdWfOQyIj5GRI8PpFGuF1b2O7dTo/AEFh3kNBGRZiMayoc0jxNdOpKI5eZe
 Beuh/kEgYm1re3UvzFfdxhB50V04KRmU72Vckq/rpGwdP8tUTih3ZzmrGqMDrF3OoxB9
 Dsq2s/KQJ2QlKTEyqnJFOxZV+6iLSZ8C9g5iZjb6nftGCmm7q1JtKuhTUX5Z7nen3zat
 venQORjEIr3SOytsdSJXWqVH1uMtSjvjFHyRfO02Zt7gvE/kRrvpX4GOqdIQXTKLsXQE
 /8bm3bW5zD0blpcC/glRxM6h07YpQWNw2hcLMAfoX/alpm2vTl9DLPTEPvYAB52gRBVd 3Q== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vd0ya8u8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 10:10:24 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 4 Oct
 2019 10:10:22 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.53) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 4 Oct 2019 10:10:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fst6vy/7rKzTTNSSonTFXWtvL70LMMSiGRUaGVGYbhUQuXpyc+uPI/N93R3rXYbxBj+s7rVb47SF2eFoux03MA87G/m9sTLFIDmNQT3k2oVNpssGHYZNVw7DxGupG8TOfVV9nKtPRPbtPVJLo9KLsYkFObp0cDrTIkCC6JAfjpBBKdhlgnL3QhvKxnPCK/Y5PnTvqmqDuIMczTO3UYAKr+UsYpDUMdUNOUni73HpKjwU0qbq7tE98tRDhY7D9NpMS0A7kWRJScFplG2I12JkKTTdHqQLCEPLLieaSOUfthMmN6V6ES6/0QWrjRPOxfCFeffSHscNiGoXtRjFd9tv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umC2SJ3IBW9vKLcfszuAyJ/B60gUsF4eaYTaqWDTgzU=;
 b=SWLrn+zs9ofR0e2PAkcTnYb7LD/SMtOCAq6xFhLCXmRnUeVQjl3pIRyAyhYbwf2Wt9Uh7KAg4N0Wms0cbay0BsNm/zhWmAzDw4OqshFdBU0BxwwH2uzJLktCdjjuUga+KZ9u1KNFgA8kDBeFJoxndatgQnOHpRGU4ynL6u/FkN2VRVZLha2H4GcjzDRydS0dT5t8+gtOHfSP+/lFzIVyuYfkbgRUqJA1CEKhLq8mxQZV2dAkRl8PibYVxUy7sjY5bY/DvO03CqOx1Di2oy+UD0VcZCpcQlKHmYbo+tsEzE7LZFAaCZj1ctHxvvaYSwekvzCBLBNc5pfbsrSbJZPkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umC2SJ3IBW9vKLcfszuAyJ/B60gUsF4eaYTaqWDTgzU=;
 b=pFgNVUxa6cWUDBDDh9gG5kdh8Qg1HBChWNbWB+G6SVHMiZc5pqT7R/Ubvk3igy/XQaNe7kgFp69tB30qJgmniUF2ijorbZ1nuTuUv1HM2+XN0JEII6I1gat+q8f2haHubZCC1RS87tR2e11Cgj0bdP1Y0FT0hA3HNaB3fzqwDBQ=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3152.namprd18.prod.outlook.com (10.255.239.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Fri, 4 Oct 2019 17:10:20 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 17:10:20 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH rdma-next 1/2] RDMA/qedr: Fix synchronization
 methods and memory leaks in qedr
Thread-Topic: [EXT] Re: [PATCH rdma-next 1/2] RDMA/qedr: Fix synchronization
 methods and memory leaks in qedr
Thread-Index: AQHVeeL/Zqn8Gmyl/0KSJPUwmRq186dJGBGAgAAuYTCAAF02gIABE/yA
Date:   Fri, 4 Oct 2019 17:10:20 +0000
Message-ID: <MN2PR18MB3182A3BF6C37425F9AA82757A19E0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20191003120342.16926-1-michal.kalderon@marvell.com>
 <20191003120342.16926-2-michal.kalderon@marvell.com>
 <20191003161633.GA15026@ziepe.ca>
 <MN2PR18MB318226121DAB349647E1903CA19F0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20191004003609.GC1492@ziepe.ca>
In-Reply-To: <20191004003609.GC1492@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.182.56.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b48ee78d-5144-4f6c-309e-08d748edbc90
x-ms-traffictypediagnostic: MN2PR18MB3152:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3152E7296976D806E882D1BAA19E0@MN2PR18MB3152.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(229853002)(64756008)(66446008)(55016002)(26005)(52536014)(6246003)(66556008)(66476007)(446003)(11346002)(76116006)(66946007)(9686003)(3846002)(2906002)(8936002)(81156014)(81166006)(6916009)(6116002)(8676002)(476003)(66066001)(478600001)(76176011)(305945005)(256004)(7696005)(14444005)(6506007)(74316002)(25786009)(14454004)(486006)(102836004)(86362001)(99286004)(4326008)(33656002)(54906003)(186003)(7736002)(71190400001)(71200400001)(316002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3152;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zVL4pNMZAlDfcRd/Owi3hO9GVKWjy02/G8FXSSh6xwcv8u5jdaGYfi99E5HMHUKlEgPD5rrWjOB7Kgez8Ih4XrH1nLIhfZ4wqmuVgUe0gshDrox4QisxtlvdMYOG/LfGhp39SswWNB/t8s+B2UeVeY6d9yIBB3y4i7fjMtQkKXxg6kkZmuqYBPiVzllj0e82bTeS2m92rJsWTp8gYTZ7O7EIYpO4BIFpnd+aDNOasHV8w/SaNZSB8CKgC2AE1ckg0QvuMpIbh8GeOhE6YGE22A1yLSktsxZmhh+VHjBT4Sh18En1ykZ6wtb3eev56Hm2iv+QIYcN8SQNHNlVl00zDT0/XatpTF3QX/MZ0C0FZHiEDzAPeZcYOkB2BK0EH6HZCb+uFYtZaDZWhrugZv2mJg98m0Rvq1Qm+C0g3hDROyk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b48ee78d-5144-4f6c-309e-08d748edbc90
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 17:10:20.2330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmu8f4RQSjsQhqJkw6/u9iy6LPHRKf9lxbBVDfRO6eBIVDmozkVPOlKMEIH/O7TyojFVaGZpEj1wJDb+8a6WtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3152
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_09:2019-10-03,2019-10-04 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
>=20
> On Thu, Oct 03, 2019 at 07:33:00PM +0000, Michal Kalderon wrote:
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Thursday, October 3, 2019 7:17 PM On Thu, Oct 03, 2019 at
> > > 03:03:41PM +0300, Michal Kalderon wrote:
> > >
> > > > diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > > > b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > > > index 22881d4442b9..ebc6bc25a0e2 100644
> > > > +++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > > > @@ -79,6 +79,28 @@ qedr_fill_sockaddr6(const struct
> > > > qed_iwarp_cm_info
> > > *cm_info,
> > > >  	}
> > > >  }
> > > >
> > > > +static void qedr_iw_free_qp(struct kref *ref) {
> > > > +	struct qedr_qp *qp =3D container_of(ref, struct qedr_qp, refcnt);
> > > > +
> > > > +	xa_erase_irq(&qp->dev->qps, qp->qp_id);
> > >
> > > why is it _irq? Where are we in an irq when using the xa_lock on this
> xarray?
> > We could be under a spin lock when called from several locations in
> > core/iwcm.c
>=20
> spinlock is OK, _irq is only needed if the code needs to mask IRQs becaus=
e
> there is a user of the same lock in an IRQ context, see the documentation=
.
>=20
> > > > @@ -516,8 +548,10 @@ int qedr_iw_connect(struct iw_cm_id *cm_id,
> > > struct iw_cm_conn_param *conn_param)
> > > >  		return -ENOMEM;
> > > >
> > > >  	ep->dev =3D dev;
> > > > +	kref_init(&ep->refcnt);
> > > > +
> > > > +	kref_get(&qp->refcnt);
> > >
> > > Here 'qp' comes out of an xa_load, but the QP is still visible in
> > > the xarray with a 0 refcount, so this is invalid.
>=20
> > The core/iwcm takes a refcnt of the QP before calling connect, so it
> > can't be with refcnt zero
>=20
> > > Also, the xa_load doesn't have any locking around it, so the entire
> > > thing looks wrong to me.
> > Since the functions calling it from core/iwcm ( connect / accept )
> > take a qp Ref-cnt before the calling there's no risk of the entry
> > being deleted while xa_load is called
>=20
> Then why look it up in an xarray at all? If you already have the pointer =
to get a
> refcount then pass the refcounted pointer in and get rid of the sketchy
> xarray lookup.
>=20
I don't have the pointer, the core/iwcm has the pointer.=20
The interface between the core and driver is that the driver gets a qp numb=
er from
the core/iwcm and needs to get the QP pointer from it's database. All the i=
WARP drivers
are implemented this way, this is also not new to qedr.=20

> I'm skeptical of this explanation
>=20
> Jason
