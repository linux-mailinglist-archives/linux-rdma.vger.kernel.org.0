Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7752C18F
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 10:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfE1In1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 04:43:27 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:32842 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbfE1In1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 04:43:27 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4S8YGT8017319;
        Tue, 28 May 2019 01:43:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=DBOP6IR/a9K5w1K+sUpd+vFASU/tdJ1WPVmQ3QYKvKk=;
 b=jizh37CUKbXBErpKpRWk0zPx8wkdunvEAL7rxRGY+czeTK/NFdqYEwjMI2iMCcjNXT5U
 IHsF4wwR7RcPYZnWXN8KbQnQ3TxlMm+3Xy7Ltt5ICVK4G6+0nDYEI9GOjGH3JiJClHIP
 xlEwsxO0HGc8x2iMmMtewu56mFYohfg2OcHTHqBw7zcwjkaXAlPOTIRPJIAwSgFCgCmJ
 0SV1dpcsI1LBB2JkoEpv+KaKi0ZFmPZR+nrMw0wiZQn1QVm5Lh6gNxHAauwLrEmEk3r1
 rOt29vQrNQ2hBSH5OiDEmSELsYth0T+fijspMeYEk0mF6NUxVNinQg/+aseoGPvp3pLj xA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sr7e4dh0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 01:43:24 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 28 May
 2019 01:43:22 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.54) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 28 May 2019 01:43:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBOP6IR/a9K5w1K+sUpd+vFASU/tdJ1WPVmQ3QYKvKk=;
 b=UrDDDPxup8UkehVum+CVqxOGDwcaSZu1/xlYm079SfHhTL2lACoYxPlSeP3kQ3gcRRxeNEusyj09MKxbppMuOclWaasMG/1IFXF1AC30mPfyow+Y4LeF3Wiywq/tyS59JZIzseyRsL1lMU0NKt5+e0ZutE7xLyJa4hEsRE934E8=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3328.namprd18.prod.outlook.com (10.255.238.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Tue, 28 May 2019 08:43:20 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413%3]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 08:43:20 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>, Sagiv Ozeri <sozeri@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2 rdma] RDMA/qedr: Fix incorrect device rate.
Thread-Topic: [PATCH v2 rdma] RDMA/qedr: Fix incorrect device rate.
Thread-Index: AQHVDu8xxRC1ga/MGk6lKs0uXPhvOKZ14ZqAgApjAtA=
Date:   Tue, 28 May 2019 08:43:20 +0000
Message-ID: <MN2PR18MB3182D17675466AF1B2B22353A11E0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190520093320.3831-1-michal.kalderon@marvell.com>
 <20190521180513.GA24517@ziepe.ca>
In-Reply-To: <20190521180513.GA24517@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8448c7c9-0f21-499e-6abc-08d6e34889c6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3328;
x-ms-traffictypediagnostic: MN2PR18MB3328:
x-microsoft-antispam-prvs: <MN2PR18MB3328040CF534F1E218E7B596A11E0@MN2PR18MB3328.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39850400004)(346002)(376002)(366004)(199004)(189003)(52536014)(7696005)(54906003)(5660300002)(99286004)(86362001)(478600001)(25786009)(33656002)(14454004)(66066001)(2906002)(6436002)(229853002)(68736007)(4744005)(4326008)(6246003)(256004)(26005)(73956011)(8676002)(81166006)(81156014)(486006)(74316002)(7736002)(71190400001)(71200400001)(9686003)(55016002)(11346002)(476003)(446003)(316002)(102836004)(6116002)(3846002)(53936002)(76176011)(6506007)(66946007)(66476007)(66556008)(64756008)(66446008)(6916009)(186003)(8936002)(76116006)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3328;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PDeXjQuiqxlAWDraXfSZvnP1gpANDlveDo0Od0R7nx+mJhzOPesJWBMRy2dolsWnFAxczM1tGXN0FPFCRkVTrBH5ntaZQ1d6x5v1sdBy6hlGw6Gwn0mFVANVXHqkAMU8xK7FYDNAIZQxwZkwn4dcPAAfwFaWyjlz+nBc03m1PDG2kbawYH3P2lBdvjkkIQZ7YQsZ0BGFXzb6HGj0EbtVTjS8T6x6ve6MPuRCgolSJwvxB30XrCaFOd7Uj3SgIETPaBQ7GlxQkWCzj8bQeKXMM588YR6tMm+378+ZkHnBeQIZ18Gw60AA0cPvctZxU0upyZxI1/ucfQXAJWd/r5c/hgDH0SyvpniTXwps1KSWaVG0vvFlgk7n7XsOiam3wBMGKiJi3VDJwFjPQucQwivlRFtiCnxmM1nipcRjwI/SOrA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8448c7c9-0f21-499e-6abc-08d6e34889c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 08:43:20.7166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3328
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_04:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
>=20
> On Mon, May 20, 2019 at 12:33:20PM +0300, Michal Kalderon wrote:
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
> > Signed-off-by: Sagiv Ozeri <sagiv.ozeri@marvell.com>
> > Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> > ---
> > v1 --> v2
> > Removed empty line after "Fixes"
> >
> > ---
> >  drivers/infiniband/hw/qedr/verbs.c | 25 +++++++++----------------
> >  1 file changed, 9 insertions(+), 16 deletions(-)
>=20
> Applied to for-next, thanks
>=20
> Jason
Thanks Jason, this patch was actually intended for rc as it is a bug fix.=20
Could you please apply it to for-rc branch ?=20

Thanks,
Michal
