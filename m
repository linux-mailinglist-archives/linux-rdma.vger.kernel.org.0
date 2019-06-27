Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D787058D2E
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 23:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF0Vfj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 17:35:39 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:12508 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726384AbfF0Vfj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jun 2019 17:35:39 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RLZKW6019502;
        Thu, 27 Jun 2019 14:35:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=wqtqSoBCg5+HinLtLsUUrBfO7xI8qiasSb/+Ky96B80=;
 b=OJTNLvA53Z2xo8E4SkXsWeNc5wxjhg22TW6z9MYC04y9IkuI1Ptx7L/cjPMI+qRF+sOD
 04vkpuIev0S/9AcLEWe+DaZpKFpxVpvqL3As73tqnurCrRZukGCLjqqut/V3HJTZybG7
 51hMBCuCfrFKb22i7OYbvkx7uoBy8CeJqJwaf42+rKWyX57psaUvNMQue8m1UKWrcuq7
 kLyIQS2YBXMo9yCTz9cVyjlWTo6fpp5OfXH8r46YSJy5tlN9fE0Tmo/uIH/94OdN1+ef
 Ax1LK80NKGppOsCnnAb6pi56VScD8TH0/GkWvm2GVjQ17ve4O3qaMUpmm1M8GzDgTcMz xw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tcvnhaeb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 14:35:21 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 27 Jun
 2019 14:35:18 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.57) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Jun 2019 14:35:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqtqSoBCg5+HinLtLsUUrBfO7xI8qiasSb/+Ky96B80=;
 b=ez4akiDCxWlCPr+YFRmS0k1FHTx8WvBt3Q6kPNexmTNTcQ2E/8u9ydVGqD0hAyCsmn8/WLbdRGigzoCIo97BcSHY3rrhlSoSwz84ANX1qTzQ6RRe8g2UU+tAH3ItwyUgV2yipKKLfr1PxZP+JGGOxXaIewQVPzJGFfnN7FOZLcI=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2960.namprd18.prod.outlook.com (20.179.22.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 21:35:16 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413%3]) with mapi id 15.20.2008.017; Thu, 27 Jun 2019
 21:35:16 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Gal Pressman <galpress@amazon.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Thread-Topic: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Thread-Index: AQHVLPCe9cWnyNWtL0+HivI8Maeykaavn0KAgAAHdoCAAFtDwA==
Date:   Thu, 27 Jun 2019 21:35:16 +0000
Message-ID: <MN2PR18MB3182402E20F3A908B700CB62A1FD0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
 <20190627135825.4924-2-michal.kalderon@marvell.com>
 <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
 <20190627155219.GA9568@ziepe.ca>
In-Reply-To: <20190627155219.GA9568@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.178.10.114]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4033201-0107-4af2-9560-08d6fb475893
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2960;
x-ms-traffictypediagnostic: MN2PR18MB2960:
x-microsoft-antispam-prvs: <MN2PR18MB29608435D0B7B9EDDE6B7626A1FD0@MN2PR18MB2960.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(189003)(199004)(43544003)(8676002)(81166006)(81156014)(7736002)(305945005)(4326008)(25786009)(476003)(14454004)(8936002)(74316002)(446003)(52536014)(71190400001)(71200400001)(68736007)(256004)(11346002)(486006)(66066001)(14444005)(6116002)(3846002)(66946007)(53936002)(7696005)(76176011)(64756008)(54906003)(110136005)(73956011)(316002)(33656002)(2906002)(53546011)(6506007)(66476007)(102836004)(55016002)(186003)(99286004)(478600001)(86362001)(66556008)(26005)(229853002)(6246003)(5660300002)(6436002)(9686003)(76116006)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2960;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Aq37xGCdiOBstHNDpd/P95kXhwz0bdwBeq4eYAz0e290XG/mhzQQ91DoUYhV2rZ3JDh85HYi8XrtHrCL/6pCTAETSvewL8jL7Gz9qkGun2pN0fm8k5nZBd2cwsSFwgOMcp2/PfHTakatHAgVDJS/SbLsVcoLo8dT0hosWobxLoNVVgjJc4IkwIDn+1xXWVVGZlNjMXuqsj+P8+qODe4PxsJ87lcy6sK+Hq/PhPAEToHrGJlvwTQfPPBKPtGMT6SxuUN787+Tfz1YdvqESWhojAxeNoh7N0Vym8pbJH05FkwJUloeRiNwXO90V/nYpA06wmd0yUy6SskJNtNyNkR4sCbk5bTEyB5Yh8+LAbO4Tu8DXSlmD4LTiB4CsrO6UwHaRmb6B9l8gAmjMuGJateBgaYLPD4ZKkKmhqW5oYWpHVQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f4033201-0107-4af2-9560-08d6fb475893
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 21:35:16.5591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2960
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_14:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
>=20
> On Thu, Jun 27, 2019 at 06:25:37PM +0300, Gal Pressman wrote:
> > On 27/06/2019 16:58, Michal Kalderon wrote:
> > > Create a common API for adding entries to a xa_mmap.
> > > This API can be used by drivers that don't require special mapping
> > > for user mapped memory.
> > >
> > > The code was copied from the efa driver almost as is, just renamed
> > > function to be generic and not efa specific.
> >
> > I don't think we should force the mmap flags to be the same for all dri=
vers..
> > Take a look at mlx5 for example:
> >
> > enum mlx5_ib_mmap_cmd {
> > 	MLX5_IB_MMAP_REGULAR_PAGE               =3D 0,
> > 	MLX5_IB_MMAP_GET_CONTIGUOUS_PAGES       =3D 1,
> > 	MLX5_IB_MMAP_WC_PAGE                    =3D 2,
> > 	MLX5_IB_MMAP_NC_PAGE                    =3D 3,
> > 	/* 5 is chosen in order to be compatible with old versions of libmlx5
> */
> > 	MLX5_IB_MMAP_CORE_CLOCK                 =3D 5,
> > 	MLX5_IB_MMAP_ALLOC_WC                   =3D 6,
> > 	MLX5_IB_MMAP_CLOCK_INFO                 =3D 7,
> > 	MLX5_IB_MMAP_DEVICE_MEM                 =3D 8,
> > };
> >
> > The flags taken from EFA aren't necessarily going to work for other dri=
vers.
> > Maybe the flags bits should be opaque to ib_core and leave the actual
> > mmap callbacks in the drivers. Not sure how dealloc_ucontext is going
> > to work with opaque flags though?
>=20
> Yes, the driver will have to take care of masking the flags before lookup

The efa flags seemed pretty generic, perhaps we should have two sets ?=20
This way if a driver ( like mlx5) has additional flags it can have it's own
Mmap function and for the generic flags call the common mmap function.=20

>=20
> We should probably store the struct page * in the
> rdma_user_mmap_entry() and use that to key struct page behavior.
>=20
> Do you think we should go further and provide a generic mmap() that does
> the right thing? It would not be hard to provide a callback that computes=
 the
> pgprot flags
>=20
> Jason
