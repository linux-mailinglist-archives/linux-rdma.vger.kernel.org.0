Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9BA9CAF4B
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 21:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfJCTdI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 15:33:08 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:33886 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730979AbfJCTdH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Oct 2019 15:33:07 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x93JFmAA019413;
        Thu, 3 Oct 2019 12:33:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=hE6LEGaRXo/pLY3ofA5JybT6+DI/lOWPB9Xl/h0VgSY=;
 b=jmRRtDpYVvG6CFEYpWb+QzYiDCX1svAcEadfduW5V9e3RuQMaDnpTzK35BH+VmAkGp5f
 sZEomjLQNhgz94x7qLh/Ui8dnj9KzsTYt4Zy4xVg3UVc8l5JIo4SJ65ZgqlxTosCpcaV
 AZb0O7zQpd6oFeO8kJ0M9eG8M/UWG5bI+nc7iVneBg8xK7ji+e7lX3n1jalt0Gr5ErhR
 Ql52QSLwbO6tPu4CCeEWfBY49QEItd9mGBTFKZPP24ihnuMECwniqHLEJTpE/Sn8Ggd7
 uEaLxWhSHFMpOdKa6ylFr3cVwqBI/PHhgXHiq9wSso81MG+1vD1JXnDGRoa2w38Lp4Cv Rg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vd0ya4yjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 03 Oct 2019 12:33:04 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 3 Oct
 2019 12:33:02 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.59) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 3 Oct 2019 12:33:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfQudMS1jiUQv8nTswRiOkP+75XsiKqoKMBivqFnfiFhq3u+ws36LwYSEJngG2hC4WRvDDNGH2bQqtYTMYwRn63jDkSTaJP/OC66mIp0PYam+FB1BbKbVytOInT+0IfoEs+lswryT/CGYwg13k1RvEOw8sxIvw3E4Im55jVynJyCqskYo/3v2ta/bNN1Y42phgImJQ3ntZef+9uQ9El/ce0IhLFDg0SYVES8sNLcnweMmcSa0d8Fxxnj4lMwQEpndj5OpwMX5J+riI5r16N6k+ESemrA7gqMWBuGg8XFAja5KtUh/93sbNXuIY1uZp352EAlJlq2jsDaP/aVIOPm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hE6LEGaRXo/pLY3ofA5JybT6+DI/lOWPB9Xl/h0VgSY=;
 b=kcKusbA2Z9UuO0laLrl2ODVHcv2PUJljNCN8990wERcxi+YmD90TqnMSXiELOPiMOhVXBryhbpJbTjB2HOGgdEzcxhNS3LVFt/arPMRdagqYLSaodZAP2E3d+Ul25G0ZM8U620OYu3ygI8hQT+JmSpp0NRfRgK3sMIrFNq11HEfbf7InWCr5EMv7t8sXAvdpNFhQxy+dbVt66+Wa0NgqwcMjT7aDZjsHxxSc1yPZTElQQWCpvxD1zBG54HmDKE8wrXPJ1j4GxEj4xjOAuxG7kk4oBMZa3tgkDKd+J90+b9uKac4AcQc0qs30/8HEcoLFkXiGevD3E6pOGWWdZEuHgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hE6LEGaRXo/pLY3ofA5JybT6+DI/lOWPB9Xl/h0VgSY=;
 b=D51f6W/AW80P7AF2AD0SQZw/ZTaLxFdt476pw4N/kCoV+tVKm2v0wOIO1WR67kOalEr0xudAOZMmbQoupSHm2T82rNLaWjn4iKjaLX1QpX1bsI0MP4OyjYqMbI07DMAjIDwLELH8cTjUSWRNMWF7BrmpWpHmzCOyEA0xqurt3jU=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2527.namprd18.prod.outlook.com (20.179.82.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Thu, 3 Oct 2019 19:33:00 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 19:33:00 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [EXT] Re: [PATCH rdma-next 1/2] RDMA/qedr: Fix synchronization
 methods and memory leaks in qedr
Thread-Topic: [EXT] Re: [PATCH rdma-next 1/2] RDMA/qedr: Fix synchronization
 methods and memory leaks in qedr
Thread-Index: AQHVeeL/Zqn8Gmyl/0KSJPUwmRq186dJGBGAgAAuYTA=
Date:   Thu, 3 Oct 2019 19:33:00 +0000
Message-ID: <MN2PR18MB318226121DAB349647E1903CA19F0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20191003120342.16926-1-michal.kalderon@marvell.com>
 <20191003120342.16926-2-michal.kalderon@marvell.com>
 <20191003161633.GA15026@ziepe.ca>
In-Reply-To: <20191003161633.GA15026@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.182.56.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 080495ae-867c-4e71-6146-08d74838808a
x-ms-traffictypediagnostic: MN2PR18MB2527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB25275507ED33D5A34AD021D8A19F0@MN2PR18MB2527.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(376002)(136003)(366004)(346002)(189003)(199004)(52536014)(14444005)(256004)(5660300002)(3846002)(6116002)(11346002)(2906002)(71190400001)(71200400001)(66066001)(486006)(8936002)(81166006)(8676002)(102836004)(81156014)(229853002)(476003)(446003)(7696005)(76176011)(6506007)(186003)(7736002)(6916009)(74316002)(478600001)(305945005)(26005)(25786009)(4326008)(14454004)(86362001)(66446008)(6436002)(107886003)(66476007)(76116006)(55016002)(9686003)(316002)(66946007)(33656002)(54906003)(64756008)(6246003)(66556008)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2527;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p9FutXKk4mtblBrVd121bNq738WlJJ5+IoECRS/F7kGZkyM+eaWb22HzE6Bnvt43SVPZnwkKiAGvxA2GWB/yZxr/hJv1v1HwzR5Cvzy56U6b+i0ozINAJDvE/ZPeXFYQLBnE5+UhW3ctffJoTG3fBJbz/I5uPbnMMdpJkHsKLeCYMgAU5nrdOtNEtW9SoWErcA2JCE4iQjDBvwpRmzAqhWsA6G9GvJ0HduYvZa0zxBsLKk7PSpSwPP8LCBvtdmOvelu9kFNBahfq38e7ZpYOV3an+oaxzOHFpg6EHUh113ct5lhvo9PcnLdGWy1v5EgIsjn0f3CHsnl855OKWOTgZaGfAqXOGZgIV9RJcX0B6W/PC7vxZJPe07yppvDc0iLtjexNSbkLR79SoJGHmiSqc+WDcgHFfQfrj/Di9IKwMp4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 080495ae-867c-4e71-6146-08d74838808a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 19:33:00.6436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FlrOqCat2RBwQrn55ntfWTBzoiVa67G1EgKECETXnxAkEZmsaTGMBxIkJFAtk4THo7KA/1RyTwQjFkzgheqKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2527
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-03_07:2019-10-03,2019-10-03 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, October 3, 2019 7:17 PM
> On Thu, Oct 03, 2019 at 03:03:41PM +0300, Michal Kalderon wrote:
>=20
> > diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > index 22881d4442b9..ebc6bc25a0e2 100644
> > +++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > @@ -79,6 +79,28 @@ qedr_fill_sockaddr6(const struct qed_iwarp_cm_info
> *cm_info,
> >  	}
> >  }
> >
> > +static void qedr_iw_free_qp(struct kref *ref) {
> > +	struct qedr_qp *qp =3D container_of(ref, struct qedr_qp, refcnt);
> > +
> > +	xa_erase_irq(&qp->dev->qps, qp->qp_id);
>=20
> why is it _irq? Where are we in an irq when using the xa_lock on this xar=
ray?
We could be under a spin lock when called from several locations in core/iw=
cm.c
>=20
>=20
> > +	kfree(qp);
>=20
> [..]
>=20
> > @@ -516,8 +548,10 @@ int qedr_iw_connect(struct iw_cm_id *cm_id,
> struct iw_cm_conn_param *conn_param)
> >  		return -ENOMEM;
> >
> >  	ep->dev =3D dev;
> > +	kref_init(&ep->refcnt);
> > +
> > +	kref_get(&qp->refcnt);
>=20
> Here 'qp' comes out of an xa_load, but the QP is still visible in the xar=
ray with
> a 0 refcount, so this is invalid.
The core/iwcm takes a refcnt of the QP before calling connect, so it can't =
be with
refcnt zero

>=20
> Also, the xa_load doesn't have any locking around it, so the entire thing=
 looks
> wrong to me.
Since the functions calling it from core/iwcm ( connect / accept ) take a q=
p
Ref-cnt before the calling there's no risk of the entry being deleted while
xa_load is called

>=20
> Most probably you want to hold the xa_lock during xa_load and then use a
> kref_get_not_zero - failure of the get also means the qp is not in the xa=
rray
>=20
> Or rework things so the qp is removed from the xarray earlier, I'm not su=
re.
This would make qedr more robust, but I think it not needed given the exist=
ing
Core/iwcm implementation.=20

Thanks,
Michal
>=20
> Jason
