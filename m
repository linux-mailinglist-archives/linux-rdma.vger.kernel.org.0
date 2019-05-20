Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764502305F
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 11:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbfETJao (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 05:30:44 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:44144 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732166AbfETJao (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 05:30:44 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4K9ULEL013744;
        Mon, 20 May 2019 02:30:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=GxNqxaMZtu6wbeixvKEw1Shac827xcFoxXNzOQ7JB6A=;
 b=L3R8xWqjkue7pZLJWt9xiEWRSBP6bz0R8CSsR13I7mHrwhF8bCOGb1FLTUrpLquGqA68
 sYZ7lAvOZn6rWEVUUeqYNla8XDn4jenlIgZ3j882hR+ZeZqfYGMlX0HXQa5NQ4V3rjbm
 OLq3dXJWiSUcG75A0fYw8RDGpjOSj5uVA+6g7UitibDScAbn19dFFNTn0qPl4fSz/jdB
 hstSpu7kG4SWO6d8kdSp9kfEcos1RqryVOX7QvbQ+Vsjcn7xwNBAmL6ON8gq/rKKSVsv
 8t70bgN8QL0S3MLOWj4cCbqS58qrc2Geri1fn/4vePZmvOH7MxRP7xeFDpQSPTFesmof Fw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2skr7m8cfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 20 May 2019 02:30:41 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 20 May
 2019 02:30:41 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.56) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 20 May 2019 02:30:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxNqxaMZtu6wbeixvKEw1Shac827xcFoxXNzOQ7JB6A=;
 b=BkuC8yDHdE2+xmxPPNHtKf0eSM8gyM50dLrMhgNTZR0tVLd/O64FZawpAkc5f9Bqe63zsMCRmpoqxWXIsQGDxro+vR7hDW2tnIafwE37vkmcRkwhfS9fs1ZLd0ldUWOjGQcVuuzzr5au5l05RYcou9JXUEP1wBkTa2IuOADyimc=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3152.namprd18.prod.outlook.com (10.255.236.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Mon, 20 May 2019 09:30:39 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::70e4:8c34:d3ab:945f]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::70e4:8c34:d3ab:945f%6]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 09:30:39 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Ariel Elior <aelior@marvell.com>, Sagiv Ozeri <sozeri@marvell.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH rdma] RDMA/qedr: Fix incorrect device rate.
Thread-Topic: [EXT] Re: [PATCH rdma] RDMA/qedr: Fix incorrect device rate.
Thread-Index: AQHVDu0jwon78g056EuGQhlheSBezKZzvrOAgAAAv0A=
Date:   Mon, 20 May 2019 09:30:39 +0000
Message-ID: <MN2PR18MB31820BBFBBFDE7D5111D8145A1060@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190520091812.3311-1-michal.kalderon@marvell.com>
 <20190520092743.GC4573@mtr-leonro.mtl.com>
In-Reply-To: <20190520092743.GC4573@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b56e3eeb-d656-4220-5dd5-08d6dd05d25f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR18MB3152;
x-ms-traffictypediagnostic: MN2PR18MB3152:
x-microsoft-antispam-prvs: <MN2PR18MB31528D7D0A0217BBBA0D9792A1060@MN2PR18MB3152.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39850400004)(366004)(396003)(199004)(189003)(76116006)(66556008)(66446008)(2906002)(64756008)(66476007)(66946007)(9686003)(86362001)(486006)(102836004)(476003)(66066001)(316002)(73956011)(74316002)(71200400001)(25786009)(71190400001)(305945005)(229853002)(6436002)(55016002)(7696005)(5660300002)(3846002)(6506007)(6116002)(54906003)(256004)(4326008)(76176011)(99286004)(33656002)(53936002)(81166006)(81156014)(7736002)(6246003)(8936002)(14454004)(186003)(8676002)(26005)(11346002)(6916009)(478600001)(68736007)(52536014)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3152;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pvp6jn+oF6eqEMDHUCvJOJghh2Ajony8cygNx47YgwXiyOz5VNnubIWyKnLqUYHVpeEKTEjrKnN+9tbWACPiW0g7A4f3v6BweX+yMSDWUR1EWez1gQ8mqIYjFha2fGmFlXuOjsZzg0DOKLwgXyWoaajCqmJ2SArfQXb8YcwDpk86gOreH9b+nOdVTAuNaT/LRZ+g884HwSqkmlmOWbM4OFdPN6M8DE5lvUhYuiVxc2oPP7o9DZ2Z06KiUM3yeEOA0cLVqAFfwmzylZ/YG1RDbotAISrFmuqRemVn5Tqh7PsU0My/6cMMDDt0YOXlIJl3R7jvBTrGn9yZeOTvCR2JTMAMDjXKZSi3CXSxpkM4G23VNcG43grcgeMSo3VKVTfRp1IjmqW2AEXaNJ4GhBq+EJnYqVWNb0oVvdpWFSqa/O4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b56e3eeb-d656-4220-5dd5-08d6dd05d25f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 09:30:39.1973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3152
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_04:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Leon Romanovsky <leon@kernel.org>
> Sent: Monday, May 20, 2019 12:28 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Mon, May 20, 2019 at 12:18:12PM +0300, Michal Kalderon wrote:
> > From: Sagiv Ozeri <sagiv.ozeri@marvell.com>
> >
> > Use the correct enum value introduced in commit 12113a35ada6
> > ("IB/core: Add HDR speed enum") Prior to this change a 50Gbps port
> > would show 40Gbps.
> >
> > This patch also cleaned up the redundant redefiniton of ib speeds for
> > qedr.
> >
> > Fixes: 12113a35ada6 ("IB/core: Add HDR speed enum")
> >
>=20
> No extra space please.
Thanks, will send a fix
Michal
>=20
> > Signed-off-by: Sagiv Ozeri <sagiv.ozeri@marvell.com>
> > Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> > ---
> >  drivers/infiniband/hw/qedr/verbs.c | 25 +++++++++----------------
> >  1 file changed, 9 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/qedr/verbs.c
> > b/drivers/infiniband/hw/qedr/verbs.c
> > index e52d8761d681..f940da2eb61e 100644
> > --- a/drivers/infiniband/hw/qedr/verbs.c
> > +++ b/drivers/infiniband/hw/qedr/verbs.c
> > @@ -159,54 +159,47 @@ int qedr_query_device(struct ib_device *ibdev,
> >  	return 0;
> >  }
> >
> > -#define QEDR_SPEED_SDR		(1)
> > -#define QEDR_SPEED_DDR		(2)
> > -#define QEDR_SPEED_QDR		(4)
> > -#define QEDR_SPEED_FDR10	(8)
> > -#define QEDR_SPEED_FDR		(16)
> > -#define QEDR_SPEED_EDR		(32)
> > -
> >  static inline void get_link_speed_and_width(int speed, u8 *ib_speed,
> >  					    u8 *ib_width)
> >  {
> >  	switch (speed) {
> >  	case 1000:
> > -		*ib_speed =3D QEDR_SPEED_SDR;
> > +		*ib_speed =3D IB_SPEED_SDR;
> >  		*ib_width =3D IB_WIDTH_1X;
> >  		break;
> >  	case 10000:
> > -		*ib_speed =3D QEDR_SPEED_QDR;
> > +		*ib_speed =3D IB_SPEED_QDR;
> >  		*ib_width =3D IB_WIDTH_1X;
> >  		break;
> >
> >  	case 20000:
> > -		*ib_speed =3D QEDR_SPEED_DDR;
> > +		*ib_speed =3D IB_SPEED_DDR;
> >  		*ib_width =3D IB_WIDTH_4X;
> >  		break;
> >
> >  	case 25000:
> > -		*ib_speed =3D QEDR_SPEED_EDR;
> > +		*ib_speed =3D IB_SPEED_EDR;
> >  		*ib_width =3D IB_WIDTH_1X;
> >  		break;
> >
> >  	case 40000:
> > -		*ib_speed =3D QEDR_SPEED_QDR;
> > +		*ib_speed =3D IB_SPEED_QDR;
> >  		*ib_width =3D IB_WIDTH_4X;
> >  		break;
> >
> >  	case 50000:
> > -		*ib_speed =3D QEDR_SPEED_QDR;
> > -		*ib_width =3D IB_WIDTH_4X;
> > +		*ib_speed =3D IB_SPEED_HDR;
> > +		*ib_width =3D IB_WIDTH_1X;
> >  		break;
> >
> >  	case 100000:
> > -		*ib_speed =3D QEDR_SPEED_EDR;
> > +		*ib_speed =3D IB_SPEED_EDR;
> >  		*ib_width =3D IB_WIDTH_4X;
> >  		break;
> >
> >  	default:
> >  		/* Unsupported */
> > -		*ib_speed =3D QEDR_SPEED_SDR;
> > +		*ib_speed =3D IB_SPEED_SDR;
> >  		*ib_width =3D IB_WIDTH_1X;
> >  	}
> >  }
> > --
> > 2.14.5
> >
