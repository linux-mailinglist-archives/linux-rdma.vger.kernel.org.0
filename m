Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFEA02CED3
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfE1Smi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 14:42:38 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:56838 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727235AbfE1Smh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 14:42:37 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SIVU9G013826;
        Tue, 28 May 2019 11:42:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=7giNjR9aB0xsjzZguQk9Xj/mHq+LcI3fs5+HUcb2GGA=;
 b=enw5+rNpwxA1yFM1sDvu+O/SlB2W6B1P8clxEQy7mF1r8uf6+AXAS1zsNKOGFkgJue5G
 AaMSQ5tuG0eUwXwKUKLNVOX/9hyHkxJzH+6o6IcPH4zy2rLMPLmAdtWRca1b2s8tYNmz
 oa1uX9idje7Hc1FAbbge4XPBd9IIHaN5eLkU/YsfcuZ+vPWHelMy0aDiQpP0bESMkBXf
 xjoeoDDIJC5zG+qQXDMcJgZxN3OOR7z7GZj3Hy9B5ZL0XKg5qkmS2FBchpWBrPd0e8cc
 RQEok9pbpTFOiZXoG/ztRZiCy6wRJng0O42HaRXnVmB9DRN2LweUmKn62h/tfhESSSYI vA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ss6w6s3sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 11:42:36 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 28 May
 2019 11:42:35 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.50) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 28 May 2019 11:42:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7giNjR9aB0xsjzZguQk9Xj/mHq+LcI3fs5+HUcb2GGA=;
 b=plSvMS6OBUvbBOPLj0HtEdAfYGJsxs9sRaEzSraTB3WOJSDwbMK+5WbHklmBw2pMOlC1FIW0EFPaUI6HAi/3uCCVLQ64pazgwk7JXdlDMeeWIQAzrhGfRpjI+TiH+RRQZYgOJP5/AChtreUuAXtcy8gXwd7BJolfILgIlOmN7wg=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.22; Tue, 28 May 2019 18:42:35 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413%3]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 18:42:35 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>, Sagiv Ozeri <sozeri@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2 rdma] RDMA/qedr: Fix incorrect device rate.
Thread-Topic: [PATCH v2 rdma] RDMA/qedr: Fix incorrect device rate.
Thread-Index: AQHVDu8xxRC1ga/MGk6lKs0uXPhvOKZ14ZqAgApjAtCAAJnSgIAADadA
Date:   Tue, 28 May 2019 18:42:34 +0000
Message-ID: <MN2PR18MB318232323987611401AEA33DA11E0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190520093320.3831-1-michal.kalderon@marvell.com>
 <20190521180513.GA24517@ziepe.ca>
 <MN2PR18MB3182D17675466AF1B2B22353A11E0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190528175243.GC31301@ziepe.ca>
In-Reply-To: <20190528175243.GC31301@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.181.13.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 713da74a-54ca-4662-3bf7-08d6e39c4029
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB3182;
x-ms-traffictypediagnostic: MN2PR18MB3182:
x-microsoft-antispam-prvs: <MN2PR18MB31822F8D05B89B7931562EA3A11E0@MN2PR18MB3182.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39860400002)(136003)(189003)(199004)(8676002)(256004)(33656002)(81166006)(52536014)(3846002)(9686003)(81156014)(6116002)(305945005)(102836004)(8936002)(316002)(54906003)(7696005)(76116006)(25786009)(99286004)(7736002)(26005)(64756008)(66556008)(66476007)(66446008)(73956011)(66946007)(4326008)(6506007)(76176011)(6246003)(86362001)(71190400001)(71200400001)(186003)(11346002)(476003)(55016002)(446003)(74316002)(6436002)(2906002)(68736007)(5660300002)(6916009)(478600001)(53936002)(66066001)(486006)(14454004)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3182;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qpk+jcePt6lvocPXZaAwFt0TykkCmO0DpmCcFf0ZkcFuFzDPZoJHkJqLjdXWdi2v+vl8ASU0t3nrr51bDnJWAiH95n5oW39lXZvkZhNqe83EsjyN215qFPDU4bTbtUUj2dnadXrcmRhc5Cht3sgt1RlnVNt4Mmo7pjDu8q7IZu3hp7mBGUTFJTc9/vyVjTLaaWGI6BQOqk2ev65hesW5aqqa6xbPEeQ4n6U4mMtdDdxEYcVos+tEAJRmOha2EqaIeqR1f0M1fu9qx6NnJv7JokJivXxQjWSGAcfZgCdpLhHM9nSnrxm8ZLSTChIvgndZUOyA6Rr3tFYC4EUWNigYFF0peIYxTnLEvWEKQNAtBkIuvMvLKMBIxdBgc+oI+zcXKgEBdqEYFlB7wVlYkrhLpDpXLXBklcBrhzYol9hqwTo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 713da74a-54ca-4662-3bf7-08d6e39c4029
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 18:42:34.9172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3182
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_08:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
>=20
> On Tue, May 28, 2019 at 08:43:20AM +0000, Michal Kalderon wrote:
> > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
> > >
> > > On Mon, May 20, 2019 at 12:33:20PM +0300, Michal Kalderon wrote:
> > > > From: Sagiv Ozeri <sagiv.ozeri@marvell.com>
> > > >
> > > > Use the correct enum value introduced in commit 12113a35ada6
> > > > ("IB/core: Add HDR speed enum") Prior to this change a 50Gbps port
> > > > would show 40Gbps.
> > > >
> > > > This patch also cleaned up the redundant redefiniton of ib speeds
> > > > for qedr.
> > > >
> > > > Fixes: 12113a35ada6 ("IB/core: Add HDR speed enum")
> > > > Signed-off-by: Sagiv Ozeri <sagiv.ozeri@marvell.com>
> > > > Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> > > > v1 --> v2
> > > > Removed empty line after "Fixes"
> > > >
> > > >  drivers/infiniband/hw/qedr/verbs.c | 25 +++++++++----------------
> > > >  1 file changed, 9 insertions(+), 16 deletions(-)
> > >
> > > Applied to for-next, thanks
> > >
> > > Jason
> > Thanks Jason, this patch was actually intended for rc as it is a bug fi=
x.
> > Could you please apply it to for-rc branch ?
>=20
> It is sort of too late now, and the commit message is no really -rc quali=
ty
Fair enough,=20
Thanks,
Michal
>=20
> Jason
