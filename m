Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F61543D109
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Oct 2021 20:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbhJ0SsZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Oct 2021 14:48:25 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:13790 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238688AbhJ0SsZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Oct 2021 14:48:25 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RFoKGh011518;
        Wed, 27 Oct 2021 11:45:55 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-0016f401.pphosted.com with ESMTP id 3by9rtrsgd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Oct 2021 11:45:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY6RD16vzz0OPYRbNXgxUfOOe48XHsYi62PIZB2Apc6fvGEh4ZCYg5Ngsby8gssgxq5UW1bYLgDctdrHbnHc2ix9zIhnbFGEdewpTWxDx7izPcYd9imyCACbVOiky8tA+YTlaThTvcyp/evlSpmgRMensZ2UVEi1IluYblrJs5DNl9qzPAhB9pCR812vbjGYHM60+948rFq5D7gxEm458Up+CWZV4zSreVfwJ40L9qneET4aALT9XQZlxUhNSIfHNJgBait+/SIw8gVGj4a/Y+vL/6F3YxXTAoP8cLBzYQcDcSHYfskzclJjAOb8v6n5Dq3i9537IlkA7G0yJbNe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7db9NkPDU5Orz+jhuMHWFY0rimzgMTTdnTyfvt5tBg=;
 b=jJlE76N08sxLbeFD2xDYcUaW1dew0f6IJZIV8WIc3FhugxHY266dK/RCgf1W7m6LYgPeyKqzco90To55iMQtjLZZCapz9CKxqloPm/f8tJpLz9Ak4wAZfdAMKyvGlEpS/F7DiQA0PDmN5BZ1IkI4ljUc2FkfepgrQGHAvPqBwookYQ4i3fuTtO8QCSM5dVhzyRDoQknvZY/GcVcPQh62alquoo/IMAB0uRRlkJZKfOhknrcwTQXI5RRohAz4vMRbU1rOf7X/O6vqCF1RL10PH0isH7Z3VFLlEHbl7b4F5g8EZ8sI/gWajjKO5221PyTunhGygoDEfOFJFIt4Y4pROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7db9NkPDU5Orz+jhuMHWFY0rimzgMTTdnTyfvt5tBg=;
 b=KgxWlcy2Ec0xLMmPyEgvQXhGXfcNFZ6a4b8ov1DpyukxT4fESsinp/G30ZYptJmHq3D1SUr13cQ/Ug4xYtJMpmSm+wiGofD+oS6iAjJabbAcVfN6s1abGCBP9/REOunQBFMA9IczACk2l19rrlhEFc22ZnQLokQVb2njopGT3cc=
Received: from SJ0PR18MB3900.namprd18.prod.outlook.com (2603:10b6:a03:2e4::9)
 by BY5PR18MB3188.namprd18.prod.outlook.com (2603:10b6:a03:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 18:45:52 +0000
Received: from SJ0PR18MB3900.namprd18.prod.outlook.com
 ([fe80::a0a9:73bf:6281:36dd]) by SJ0PR18MB3900.namprd18.prod.outlook.com
 ([fe80::a0a9:73bf:6281:36dd%7]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 18:45:52 +0000
From:   Alok Prasad <palok@marvell.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Kamal Heib <kheib@redhat.com>
CC:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Shai Malin <smalin@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "alok.prasad7@gmail.com" <alok.prasad7@gmail.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: RE: [EXT] Re: [v2,for-rc] RDMA/qedr: qedr crash while running
 rdma-tool
Thread-Topic: [EXT] Re: [v2,for-rc] RDMA/qedr: qedr crash while running
 rdma-tool
Thread-Index: AQHXyC2Ev158CtT4DUGkoqU3yZnLt6vh+FOAgAUfv4CAABzlwA==
Date:   Wed, 27 Oct 2021 18:45:51 +0000
Message-ID: <SJ0PR18MB39004E6B2255723159D74CEBA1859@SJ0PR18MB3900.namprd18.prod.outlook.com>
References: <20211023164557.7921-1-palok@marvell.com>
 <1871141c-2af4-5959-4c1a-1a7c9df73598@redhat.com>
 <20211027170059.GA644717@nvidia.com>
In-Reply-To: <20211027170059.GA644717@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 292bbb16-fc59-40d3-82d3-08d9997a0063
x-ms-traffictypediagnostic: BY5PR18MB3188:
x-microsoft-antispam-prvs: <BY5PR18MB3188963114B7FA7732C9DF1BA1859@BY5PR18MB3188.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qBYU/SJS6NqKlokqdWEvkxbEqEssdAH8VFCfUxZ2XKdySDSnLrG6bhUMBPtTNojmkhy8dQ5V5gweGNHdgwRwkGFCp7uRAZbvkQWmzK8CfAnIZf1Su+Q8oMifTOQTpDNnzRKJBXA6QggbOYBo5bo6EneHmbeV/XRkUKuGDP42a2J+0hDEygrYyNToB/LU30WXJYxSuC88hjuzHP5jZoUkZUXrtqhbcTkaoxd+oAm+K88C4RjT+sv6mUsO1P7rrsjH+2s5rP24jqKbjOLRvY+A3bSiuWkJEPeTD7jLBW9rZSYitcafELULujYxGc0SGt3VPzifQ4YHqftgde1kEQFQe+Z4esXOhqqqOQmeWLM6rokrBtFBpiYQvcZCXm5K7n3gbOHAYb1EFuKvesGnwR9R1HVsj8nOpEe2waGWIChj2YS1h0NqiifLdudS9nJ4BGHK8+EAbOOC/AFebsDGg2jtH/K9vRA7dZ5KDznkPY4UFYnh7Ooxf6U7nXv/NgaytiGGvNDG6P+RxPfUfd74lZIE13y6yqWQreBYNvKwuW2uTpm4I9KVxFA1q7rkOgEc5acfm9W8no+YUzNdSEqd0f8TlRbOdMzZUuAUgDstXbjKRYf42NDm5aovuSeu+zbiuqC6bhTXtMVpfd/ZXOBfipMwGSROc7myTEQudh3dl8CENORgorvxIdUNXNqYNWJOADy3n8DS5PVQt6vnW+QdIjJ6/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB3900.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(53546011)(26005)(9686003)(110136005)(7696005)(6506007)(5660300002)(8936002)(8676002)(186003)(71200400001)(83380400001)(4326008)(316002)(54906003)(2906002)(66946007)(76116006)(66476007)(66556008)(64756008)(66446008)(52536014)(508600001)(38070700005)(38100700002)(122000001)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K7eLV2RcWMZt0AmcROaNbIQHQQI+aPQQEPLWSsUzO+dMMcp52lH0uixillUH?=
 =?us-ascii?Q?TrxAqj04Y4dR2FRQ0lyuBGk5oTXCDW8rhmBlw+TDFL5WoZt8mf1pn94ksSV3?=
 =?us-ascii?Q?kV1ppEqnDgYqVvxBIRBs7n8eWh01ePel+SnceuuovbZR5EyFcZQnWXEp4R+k?=
 =?us-ascii?Q?oAYDnBpsAfq0qT+S3+d0qrqtGU008GKyY5Ua67WS4XDA+BfqzgnDVzVvty+c?=
 =?us-ascii?Q?Y6RzXuSd6RKsJ2GDpRyMDXW4nd/oILmgnrznz8Opm/hEoR+aHBCYbVq1iKaO?=
 =?us-ascii?Q?/QWI/QO3q7CZ2tAi0ZcAAsVZBSAy62ee1lDXxM0JevdcRXBYXXEfkFkwFtPb?=
 =?us-ascii?Q?lHYraZh/GZBv63JAC2is7kMM/8TtviU3RzjtMYLD6V4lNCVlmM8zp69LslGa?=
 =?us-ascii?Q?mTx82mBsnMO5aCOrgEx9XJbpMzTh3mvklQozgTyP8cd/ifSI9jvVABPdH8VC?=
 =?us-ascii?Q?SjI1LE7yTwkqhsCsmLn8PqE1Td1sLOcY5EEzDK6ccC4pcNKNsK0nXgMuJoLN?=
 =?us-ascii?Q?fdFjn7u3qIJTNJ8nYFY2lsOznPot+NIVP/yAvHesGo7GTkqvSm4JcD/88sLh?=
 =?us-ascii?Q?+nhcPsrXlitRZutSDvmqfbRaBwMTqOLMbouqfYJ5ukSrFeC7ESTTN0J6pAqe?=
 =?us-ascii?Q?m4ESPOOLYvaPIH18Aqb2mVQnxZVZjua9p7L8Lkp3JafG6eYY+JsKNEq9X3SG?=
 =?us-ascii?Q?805QcGmtZw5KmE1iE2PuXgw0ohYPjfjksOkYleG+NC1hJogHERpHHmTBDm/0?=
 =?us-ascii?Q?cYzOS3JQyoo17PtR+zG2UfMbh3vfhqJ7AFLsVhTtzofBixppUC2sg/ATinOy?=
 =?us-ascii?Q?3v1HpiOUzIzEL5dYLIYneyhYxr2wTYwwnUnx2OxlLPlQJx5fhn7p3puJZ0v/?=
 =?us-ascii?Q?o/We/jvlAaopsZuMqCmiONmZ9ydn6Gbmr0tAM2NFHspxoM3PT4ytNq93Ptno?=
 =?us-ascii?Q?djCwf19zaNBzgMv1FHstWk1Iostq0J/l9v7oZ0aqTHRN6zDLvAe1NZfAnr6n?=
 =?us-ascii?Q?Ong44PLshlxKUTVXHPq5nCQpgqsbr4JBvnToZMwc0gO72qE0PGxCP+Bva1KP?=
 =?us-ascii?Q?B6gd3vgGWCCgUTBx4EZQtY3xrFLdPjwhuCIRcQ4Ia/vNuepkoYR2thkkDQht?=
 =?us-ascii?Q?qqtBqGxN7jOuh6mSa3gPeTk1FPd7DN5/nXn2LGwSzSYkd9H5NW1HLdUAFWlB?=
 =?us-ascii?Q?NEeN6vFPcoViaR1TUkxKm3DuMhzFx0Sl4HNBtJz0o3DYz7YadmPbqBziYRBm?=
 =?us-ascii?Q?93SrU126cECZNQXrP1cso9nDo6TwFx047czEBV+JfVXV0TU5XohgPbEofhLZ?=
 =?us-ascii?Q?iz6Xw9UBt0UN9MK0GFVTHmVuOSHwdJ0nDvR3ZRhQxEuFlqPPSrrRGvLxSFTj?=
 =?us-ascii?Q?+12O8IeITaTwi5Omh5Z9OR4+Fjry4ufuB7Ygm7tlsEn5EXde0ptrsj3hbSAx?=
 =?us-ascii?Q?r3MSVGAOLin5Ykl4KiuFbGpKrPP2sWIMi8J+RzrO9YPJjhd67YaaG+/iauRN?=
 =?us-ascii?Q?1AOAu7EEfGwWR6e9h47wNK+mw5IYcq1clffqaH2TKwpt+tU+WI+UzYV55lmx?=
 =?us-ascii?Q?GY/ezpO5Jbsy65/GzIGHgc3Tcs4qpwhaUYB70Eouv3jXpawKTlDyKXVFbzWf?=
 =?us-ascii?Q?VTSwUdFj9652T7yO8VPtor4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB3900.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292bbb16-fc59-40d3-82d3-08d9997a0063
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 18:45:51.9106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91EZ9meMI/J7Vuo4fuIu4tBTTSv72TM+xrWiWjfVIgQAUxQ6PwlL6Wm6pTpGfIHPrDLpPgsVrNJo2XKxTq0qpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3188
X-Proofpoint-ORIG-GUID: tmBazgreSiry7D7pirmKlVzk2gHUXgx3
X-Proofpoint-GUID: tmBazgreSiry7D7pirmKlVzk2gHUXgx3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_06,2021-10-26_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: 27 October 2021 22:31
> To: Kamal Heib <kheib@redhat.com>
> Cc: Alok Prasad <palok@marvell.com>; Michal Kalderon <mkalderon@marvell.c=
om>; Ariel Elior
> <aelior@marvell.com>; linux-rdma@vger.kernel.org; Shai Malin <smalin@marv=
ell.com>; Ariel
> Elior <aelior@marvell.com>; alok.prasad7@gmail.com; Michal Kalderon
> <mkalderon@marvell.com>; dledford@redhat.com
> Subject: [EXT] Re: [v2,for-rc] RDMA/qedr: qedr crash while running rdma-t=
ool
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Sun, Oct 24, 2021 at 01:46:03PM +0300, Kamal Heib wrote:
>=20
> > > diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/=
hw/qedr/verbs.c
> > > index dcb3653db72d..85baa4f730df 100644
> > > +++ b/drivers/infiniband/hw/qedr/verbs.c
> > > @@ -2744,15 +2744,20 @@ int qedr_query_qp(struct ib_qp *ibqp,
> > >   	int rc =3D 0;
> > >   	memset(&params, 0, sizeof(params));
> > > +	memset(qp_attr, 0, sizeof(*qp_attr));
> > > +	memset(qp_init_attr, 0, sizeof(*qp_init_attr));
> > > -	rc =3D dev->ops->rdma_query_qp(dev->rdma_ctx, qp->qed_qp, &params);
> > > +	if (qp->qed_qp)
> >
> > I suggest to use "if (qp->qp_type !=3D IB_QPT_GSI)" to match the handli=
ng of
> > GSI QPs in the QEDR driver.
>=20
> Alok? Time is closing to get this in before the merge window.
>=20
> Jason

Done now with v3, Sorry for delaying on this.

- Alok
