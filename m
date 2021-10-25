Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5B8439445
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 12:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhJYK5Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 06:57:16 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:11946 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232306AbhJYK5P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 06:57:15 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19P91ZmX015145;
        Mon, 25 Oct 2021 03:54:51 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bwdj3abma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 03:54:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIWmKbJfBEPN94FEiUulr/4gkHC3Wo/d7ntNX5JM3Nh13cY6Uc432oUDilGO2o68mrGkL2DW6Ff92b9wtZ6cq3oFgOwwY6tdPfbnIUlz+7wabltHI6T8/2YGxC1x26aPq8pYNiU41QM9C4ijzbwaVHBtFkChSLEWzLUlGsKGclSFD37nbi2PXOxLDo7EhZsH4yDyH/QF5eFCpAD8mBgltRvZ7zMUl9NIysqFMFi856P/gIeP0G+YIFJKzU41YEEQYREAqJNLkeIrTUqP8IIj30tqAOS0TvIa88mnCpSz3qthrCL7rzTHn1FQW4ibd75Uaol7H5lZIaLurXB7P7GrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4BwGOM+uANglxywYd2KTiU1fIX7cNMOJl5XBBOijYw=;
 b=V74ItNeZ+Gl141Rg6wF3N9wvFfJo3O1bicVmcVl/S2LtD56YsYnlQ6k1kp7PtVRGkopes11n6EAdgPBqCs+rqr0F3RB69O7WiQnzpYrCvsrx671PZi66Px8EBuoYpVzQ8QFsR0aZrKuk5H5HH0frYElUU+fDzBP2HSXGxJN6R7lBo62e8r/bWrrnz/iiz9MVkkkkRqTx/CtnoK/A5xtypuCkRjd3BjCVZLoMhUwviG3BOyY2UwShTXwDWT6kYncW8a+fnr5agWcQHlRJRkJc/2H84TlL/qj8ko00I3MNamLPA0l5zVn031czkaCTfcDlwpPc+6I2z962TlrfDQS0Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4BwGOM+uANglxywYd2KTiU1fIX7cNMOJl5XBBOijYw=;
 b=QJGAYChHY9Y1++rmI5IICeaWAGusyst7dXgCWu0cL3/T/6d4eCUxS6riohzxrIi4AAXMKsL8PmNS7wvtTHau7gAOGhkqyzgtdJhyd31rsMnFbeNXI/mpcTkNdvIHiXfMiS9285wCQ13fwrUm1Nd4/+AFmtFJbMrlf0Eq1iyKE70=
Received: from DM5PR1801MB2057.namprd18.prod.outlook.com (2603:10b6:4:63::16)
 by DM6PR18MB3227.namprd18.prod.outlook.com (2603:10b6:5:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 10:54:49 +0000
Received: from DM5PR1801MB2057.namprd18.prod.outlook.com
 ([fe80::a8de:65b:4fe0:32e3]) by DM5PR1801MB2057.namprd18.prod.outlook.com
 ([fe80::a8de:65b:4fe0:32e3%4]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 10:54:49 +0000
From:   Prabhakar Kushwaha <pkushwaha@marvell.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, Ariel Elior <aelior@marvell.com>,
        Alok Prasad <palok@marvell.com>
Subject: RE: [EXT] Re: [PATCH for-next] RDMA/qedr: Remove unsupported
 qedr_resize_cq callback
Thread-Topic: [EXT] Re: [PATCH for-next] RDMA/qedr: Remove unsupported
 qedr_resize_cq callback
Thread-Index: AdfJgSWJM4G+JcdHTbe+udu9aj7oqgABuPIAAAF+z5A=
Date:   Mon, 25 Oct 2021 10:54:49 +0000
Message-ID: <DM5PR1801MB2057BE3C59E04DEE68C3FF64B2839@DM5PR1801MB2057.namprd18.prod.outlook.com>
References: <DM5PR1801MB20576F5ED830B11E8F83A037B2839@DM5PR1801MB2057.namprd18.prod.outlook.com>
 <YXaBvtre1/BzFJYy@fedora>
In-Reply-To: <YXaBvtre1/BzFJYy@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91b9842b-5fde-4160-b6dc-08d997a5ddca
x-ms-traffictypediagnostic: DM6PR18MB3227:
x-microsoft-antispam-prvs: <DM6PR18MB3227C8A326ABCC754FE7F534B2839@DM6PR18MB3227.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i/QXJapeGErocwyqaMd7xhipbMuxZJGV9dI0FIPPgnXhbkvO984v3eIOKYqRHTKL2996zZf5GEOB2IWQ1ymArcRm6stCfOcZLGQ9bTGnP7KYUBkME1ZSfDyQ4u9ljfKhgs+QoekTC3PAFffASSH1O6QzNoEphVsPqsg5FYUSPsgW8s4/PxB1boh6ykoX6XJokUkMEXZeZfTWraPrP9P7JW7qWsjgssFmWW6yO/Qw2C9snlmL7/MvxgtxhmoZ+oX6miT0hh8VGR8JgFDAP/dkHb9hQVE6vcIuKWT0aMJ0P5ajIL2NHAepOAY2YISYr8ghR7pOdsIAZmFzhxFV5C3Yeg4mW96WBsbk63K0qWgZ/dfku7wfhn1OgxDgsGIOFxDQRxPqk64d5Nr9leVMmEbW239Bv4SmLQJNHS4PGCedTn3bK/ELGrt8J8TkwXEVfZ4bfGsQIBAg/sTXfEMrehYxSBxb84jRr7o/m20UH8tyTw8Lutk3Um6L0UtsoKNKv3qkyoM7PNiLZbeyF08G7JCLRuc9oZz79ib6DWeMwWOSP0xjuwHfhU2qu92AjqfhVxx8qhYQe4SZCCLkGZvai8JB13bxm9wrEbUVa/2GyhbLx0EI1ldsRvD8BIEZCAgGOow+3zD0Wp5ZtKtTuIGu0a2Z7DCRp6r95Ukk2LR8ZJ/KJZG8szf86wiSqt3e+VPSZq60KH0Hroxlyd8s4Qe51nf2Ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1801MB2057.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66446008)(55016002)(2906002)(53546011)(83380400001)(6506007)(38070700005)(76116006)(4326008)(64756008)(6916009)(86362001)(52536014)(26005)(5660300002)(122000001)(9686003)(38100700002)(508600001)(316002)(186003)(33656002)(7696005)(54906003)(71200400001)(8936002)(66556008)(107886003)(8676002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VdUyRMyEpn60KMOkAbU1XaKLfZ8d8DPNhra9dRsmEm+ChSOfDA4eTEBC1lQQ?=
 =?us-ascii?Q?aoh5HwqXLSjhVaOQyxhFQyBiiVgxZ2SF7U1WnA6A/FLbhEt6xC9+0WjoGdS1?=
 =?us-ascii?Q?vuykUpEaojQa0d/5jo4Jc5rcBq+0iM81OjniEo7pqc5nGIVDaXnBOBiSiJzh?=
 =?us-ascii?Q?KkXWBwMJhSxgwsyuqCkZBPalaYkHd/H4h+g0OEusa2esd8YzM+abY0UGIoYj?=
 =?us-ascii?Q?xM0c5uVYlLJnOqbZdF+rdVbnaY628gFoIV7jB6Ae65ZkOIiuIrWRgM8ECO5v?=
 =?us-ascii?Q?kp36xO+MLDcLcNYBPDct7/XeonmAvVGxPsVLpmuEgi8/jRfqEj5m/XK9zXvc?=
 =?us-ascii?Q?mpzrIWPoCONUZ/WkxmJz7DKhQYOaTCtUi8ZCamMWkCHvp1Eb7YcMhTHes3fA?=
 =?us-ascii?Q?tRivbGrPS+jy+xX+pR3fDgjWTRmrz0IMHfKbIm5dbiL6oTyw2R8BqJGIbSWx?=
 =?us-ascii?Q?zMA/RAydrMrleZGmuasUqzH/Z1xTA6/jxID2A46UGhrkHfM9ro/aAgxiAMXp?=
 =?us-ascii?Q?RrDCHNVxNzlouyEWkSseYhAueQjHwXD+VfWTZmcKnXVJlwAmH6Bn0Gz4rKAJ?=
 =?us-ascii?Q?MOd7Qaq7fcaRyw8wx8k+u1p2rPs/pAfaNmFp/VNLfN2+hOlLtkYIj2/Yxvfj?=
 =?us-ascii?Q?H0p+hmt74ZXFXc2SPix+96VXHjQYbACj2bNwRCfocRXGYO0tPAPEzGZ15Yiz?=
 =?us-ascii?Q?fsxcaTxq7cFzMdgTSaVCgBO1ysdNfqXXsxG/CMMhS/3HBLwXofdEbnCMuSVu?=
 =?us-ascii?Q?0eat9WfPtAqUBOXdTnMDoXJMPPgHL8HZIxJO22CLuzA/t8/6Sy8kRurpjDFE?=
 =?us-ascii?Q?MkErYYYjXNA2vbZaedshjEkcuUhVMdgsAncCKn/i79m5nL2f525fQI/2FnSU?=
 =?us-ascii?Q?3fnZflusLA9zB5g13TSGohvKKCSH+RUd4pqGfu4NR0oOx3B9UvoqRHJU6JUj?=
 =?us-ascii?Q?7mOud9zmfdoYoKRaFLjvV93kZZEqpD1A2vtjCJ4ZbOHaeKUbwuClD921KhtN?=
 =?us-ascii?Q?SklWYmb17vGNjhGHK0+1CQap07MTpdW897Ei9FGEcqNbk5POOGE4dJ0Pe8uk?=
 =?us-ascii?Q?PJn3COvlESkhweb4mxjqyfaDygYsA9fBRIAGiWMNF6UEoZ1baIDpczc+DPhe?=
 =?us-ascii?Q?WVfuiHvoFO8pqYayGXhnnEzOq9c34CILdAGBs2YO7Y6YzkCiC/Gx4Ay1glBJ?=
 =?us-ascii?Q?5iSCNPC7wq8VBKAdYg5TtJ+zmGpgpJ8ned5TFJjiU30tXgOOk9WK7U+BEFic?=
 =?us-ascii?Q?vJuXLMgCvWy9c1IwyYJImteDVMJSNYdUOF8Wrk5WYARklCfTrctGjTY6q+eX?=
 =?us-ascii?Q?z9Ix5bym4a8x1ecCACarao+Teprkwy/nnbHSk3yIIj/wVygyoeY54VNXkZ2L?=
 =?us-ascii?Q?a/j6Z2JK3BltWkWyDiIQtyujgYak4yPkWe+k9juAelk4ur3m3rsJtiF7l1Aw?=
 =?us-ascii?Q?J3AlpuDoRmK7waKxLvAJov6zgMzkDd3od+c1PROW9yCM6zC6hbj62pUtls6B?=
 =?us-ascii?Q?QcowQnuFUjN4xErlU7lfvgbPVOLcbMlG18pbTbfMZD7zU4eBKPDNgalI5NE+?=
 =?us-ascii?Q?34Nw29f0OBfzwLK48qVmo7bzyU5tbcc8Ok478Ros4y0jaEezXeylnp6MogA9?=
 =?us-ascii?Q?zaPEdnTaEaoFU167E84Gwa4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1801MB2057.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b9842b-5fde-4160-b6dc-08d997a5ddca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 10:54:49.4654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5gyAILhqHfYr8H64aSec3CTf0760NzSAXSrvfsHE6jYvK0hfZhUwtFvCc8T5SRzbBlLN5bJtFHk4AtGQpBqmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3227
X-Proofpoint-GUID: TkAB-3cwlhFZmEWIkCFQIOkBbuthXtCM
X-Proofpoint-ORIG-GUID: TkAB-3cwlhFZmEWIkCFQIOkBbuthXtCM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_04,2021-10-25_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Kamal,

> -----Original Message-----
> From: Kamal Heib <kamalheib1@gmail.com>
> Sent: Monday, October 25, 2021 3:37 PM
> To: Prabhakar Kushwaha <pkushwaha@marvell.com>
> Cc: linux-rdma@vger.kernel.org; Michal Kalderon <mkalderon@marvell.com>;
> dledford@redhat.com; jgg@ziepe.ca; Ariel Elior <aelior@marvell.com>; Alok
> Prasad <palok@marvell.com>
> Subject: Re: [PATCH for-next] RDMA/qedr: Remove unsupported
> qedr_resize_cq callback
>=20
=20
> ----------------------------------------------------------------------
> On Mon, Oct 25, 2021 at 09:24:41AM +0000, Prabhakar Kushwaha wrote:
> > Dear Kamal,
> >
>=20
> Hi Prabhakar,
>=20
> > > -----Original Message-----
> > > From: Kamal Heib <kamalheib1@gmail.com>
> > > Sent: Monday, October 25, 2021 9:27 AM
> > > To: linux-rdma@vger.kernel.org
> > > Cc: Michal Kalderon <mkalderon@marvell.com>; Ariel Elior
> > > <aelior@marvell.com>; Doug Ledford <dledford@redhat.com>; Jason
> > > Gunthorpe <jgg@ziepe.ca>; Kamal Heib <kamalheib1@gmail.com>
> > > Subject:  [PATCH for-next] RDMA/qedr: Remove unsupported
> > > qedr_resize_cq callback
> > >

> > > ---------------------------------------------------------------------=
-
> > > There is no need to return always zero for function which is not supp=
orted.
> > >
> > > Fixes: a7efd7773e31 ("qedr: Add support for PD,PKEY and CQ verbs")
> > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > ---
> > >  drivers/infiniband/hw/qedr/main.c  |  1 -
> drivers/infiniband/hw/qedr/verbs.c |
> > > 10 ----------  drivers/infiniband/hw/qedr/verbs.h |  1 -
> > >  3 files changed, 12 deletions(-)
> >
> > Have you tested this patch? I afraid, there may be a crash because of  =
this
> >
>=20
> I do not think that we will face a crash, because the libqedr in the
> rdma-core package dose not implement the resize_cq() callback.
>=20
> Furthermore, if there is a bug in the kernel rdma core this doesn't mean
> that the qedr driver need to fake supporting resize_cq() to avoid a crash=
!.
>=20

a7efd7773e31 is quite old commit.  Not sure about the reason behind such fu=
nction definition.
But a patch should consider the possible side-effects.=20


> Anyway, To be in the safe side we I'll prepare another patch that checks
> for NULL in the core and return -EOPNOTSUPP if resize_cq() is not set
> by the driver.
>=20

Thanks!!

--pk

