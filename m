Return-Path: <linux-rdma+bounces-606-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D892582B3BF
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jan 2024 18:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC72C1C23BA6
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jan 2024 17:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B15251C48;
	Thu, 11 Jan 2024 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eK2HVcDt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2094.outbound.protection.outlook.com [40.107.93.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2AC50264;
	Thu, 11 Jan 2024 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VL9bT0o2YCGdGOVi4/nZStnYDtnM0q6JPii7/bZD5yVNv9evea16t3YpSfClDde/70SM/vrgm4KeJn2/DIJsHVGG2kVUi7SyPZGAGIY2jRPU8+5u8RfMWgZNv9y2lVLVsxLmHwcG4UsOPW4p+YZelYChmIwGjCRV3KcYyDKNNIDY0n1BBMGd2fcVGa/tC8FbAvlMqy9dROEGWQx7Xz4mNdJmZ8q8lJFnFSbc+gRDxIjRx4S73UcECoEmrG5tehrd4tzAiM2tgVf7J5B0UPtIpe6ptw502+TzM2TzVKC0xK/s9jNReDQMXyhA9qVz84Ow46b5FKw3cWtXQPu8oxDS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LD7jpCLio69VTSM70x+zPY46n69QmS9oBaQ+4FSgDWY=;
 b=GkqHRPXkQzLJTjHn8BkN3uswpiz6q4Ht63mKnFC1unlslNWnGPNu4ThIv39qVNVHTG39AME2aZigbfQT0hG3GF1T3Y+4oRAO5puqUtjb3ax8VrsfnrU0RUxvzZamxCYGnNyWHBzgU/AGtbI315bCrX0V7HX4R0fCkgoxbP7TumLlur88DvUBamYdK88sYAfs+VZ1ZhFWUdT/8YFbjIhdaZk2CaiumtzenG9nu6w5VLqjmMKoGAnz2fgOvJxIy7x9Uy3Oa5hkwMeOni/qrJpCOlpShDlxJOdgMSkjXJo1QMBlD3MKarLdFm1HRZATnMyM5pusLgF/lZhdGQ9iMujBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LD7jpCLio69VTSM70x+zPY46n69QmS9oBaQ+4FSgDWY=;
 b=eK2HVcDtopgiI8kMayvgUzOpncvxaNg4V2p8sWE+c96oivDWjf/uqQkE8zrJHamdpRqWqFqqLUQCXvCpqYoni9ElPhGRI0fzvOr8NOwF7iAzYP9z+P4GTIqu91/zRx2z6s0nBsu5AoydvgLkhMPFWrgun1oiOZU4n/QYa2jUHsE=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by CH2PR21MB1429.namprd21.prod.outlook.com (2603:10b6:610:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.13; Thu, 11 Jan
 2024 17:15:06 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::38ce:7072:976c:bb15]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::38ce:7072:976c:bb15%3]) with mapi id 15.20.7202.010; Thu, 11 Jan 2024
 17:15:06 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@microsoft.com>, Leon Romanovsky
	<leon@kernel.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH next v2 1/1] RDMA/mana_ib: Introduce three
 helper functions to clean mana_ib code
Thread-Topic: [EXTERNAL] Re: [PATCH next v2 1/1] RDMA/mana_ib: Introduce three
 helper functions to clean mana_ib code
Thread-Index: AQHaQ89cTjDTWtOc/EKe7tv13d8w1rDUdwOAgAAjiACAAEC+YA==
Date: Thu, 11 Jan 2024 17:15:06 +0000
Message-ID:
 <PH7PR21MB3263B517321B2258F2E0329DCE682@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1704896074-4355-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240111111417.GC7488@unreal>
 <DU0PR83MB05537ED5ACE714BACA7288AAB4682@DU0PR83MB0553.EURPRD83.prod.outlook.com>
In-Reply-To:
 <DU0PR83MB05537ED5ACE714BACA7288AAB4682@DU0PR83MB0553.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-11T13:21:25.126Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|CH2PR21MB1429:EE_
x-ms-office365-filtering-correlation-id: 86cebacd-312e-4a8e-c0f4-08dc12c8db5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 k8os0ME2+TyOcj8oIdUo+Vtu8dfJPFYevIGvegVmmmwaTO6352Q0IvQDG0bJMlmufYruma+Hh2AoLJj9CWNH0nlnz4FcRveuR9XHTr0s9s9T/OB4PTDEqrWmfGDMbdlhttnqkR5MzaTTLf5YwEuQIsCOqwn8VFIRnapcJozoFNMY3dFJdsMXaj4an0oWhy0i6rhEo6pOZDR8b8h5kzIjopdIJhe9OOvyepQn6S3U6lTwU6mQroHBI0KjORMnv9VxRgZ1xtp0XNsOvpzgtbHknoNfYNIinCcjb9z4NPJa36J95+zh0Gq9EE1ODsSf3oj+SOYpKTU1OYdaevj7G70qQAGrjKjFt+WfkYwTxSNphUAqSpvehZoUACR55MgvBgvVjFaNfPP8g2h3xjbsdisIvjiyalAKDpwIuZ8ARW1vG27ihmT4WfkzeXTUeU6QW/jOcOpdY1Jriuvu2YByGiLWQ5i2ytiVN+F/V6DKzeK9qKLEYwJi/ghl1+vV+YiuLeBruZksZMUF+7fDzSzPVVMjaS5tWI1UjQkEsfNARD3UWuQjLmiW2CxbwOMkkZCCOKYwSiq0v37NiBiRVJyy7Gg/nTCbkWYZcydZcf2MIm7oG5iul45BCOER+JqXu3FkEqhNbYZXM6Tjj6gAfryLYA6FsMdRFKFSd15hf97Ne1V+s0c1E2u3W4/Q+juQQn2Vi5UjEe05eY8dWU0EWaZSB+CX4d10CSCHkvHqSWzghwg9XKa8DerFmVlopBUG6BD9KGju
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39860400002)(230373577357003)(230173577357003)(230922051799003)(230273577357003)(230473577357003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(9686003)(6506007)(53546011)(26005)(122000001)(38100700002)(4326008)(8676002)(52536014)(8936002)(8990500004)(30864003)(5660300002)(7696005)(2906002)(10290500003)(966005)(478600001)(54906003)(71200400001)(110136005)(66946007)(64756008)(66446008)(66476007)(66556008)(316002)(76116006)(41300700001)(38070700009)(82960400001)(82950400001)(33656002)(86362001)(55016003)(66899024)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?a/DP1e4BioJGMfiBDjOTQ42IkHYUYg2LlpRKDNfe29qKpDh1O+gg2w9nHuaN?=
 =?us-ascii?Q?zDncV6xNfiuaMijLEVXQou1UW0O2Nh55FJINr1vJXgI4LlVgHvBAjomglIVO?=
 =?us-ascii?Q?QEYj2zgc6EbsWXRK33BxVnJfUjKrN1ey5sva+JydJQSsQRmIMtEybaMDKJGS?=
 =?us-ascii?Q?vCoTjMwWZT/cVyqjl/cPaX/8dHA6kXGYtm353uafp8XDoVXlFC2omNbYscOO?=
 =?us-ascii?Q?l/o58/Rhpr1SKDvP7GUuuunovlm/r6/The6oaeln8GCR46+vbEmQR3V+PY4q?=
 =?us-ascii?Q?Itd/luXPPBQdWM306Yths+5GJEmh1aeTFDAS+HEBrpVuCgu4BoxYwhES6y4y?=
 =?us-ascii?Q?FlvdYqoS/mz/oVmn5PczIsnLNBKoZcG/tAYyWtN6ruyfABcnWz2hrssJswbs?=
 =?us-ascii?Q?RmAdbZllJtQEAe4TKsm5jdi9gD8+at2Q7eS+CTc+vRTZlk1a1YIVGKgHuDiW?=
 =?us-ascii?Q?ov3H0qaGBpBog7wliOIMLI4CVjR+42XiZDwNRJcvgNkbXvpbsgnRbNGlXLZ/?=
 =?us-ascii?Q?KrAeKakeHNYXmINO/ClBGthXXjuCBjlPYbSC54vFntEtAXRPn6mlNhsMxfzR?=
 =?us-ascii?Q?z1KnpKqcgau2ZRVCVG4j58JeZneqThNKVdH6dtxUHA6HiTcBp5rgm7Mv2D7M?=
 =?us-ascii?Q?nPaL2vP2nLW6IT7y3Pk/8WKb2ftA50RLNouw22LGtLOfHdINFuOJbheKexHb?=
 =?us-ascii?Q?YgjH4dbL9VrA8tehySzbZH5P8/OKN1dkcWO8OYeABeaAWK7rHvtTV77KPBI4?=
 =?us-ascii?Q?bJ6910dmiLhjwtSHYkI57P65vzB/DpTTF8aw/8/QDJgbuJzNmDcjvDBhq9D2?=
 =?us-ascii?Q?v/XO5bwB46G71LZoeW4civQj/7Ng6IjQb51vuuQauOMuB+wncC2QdscxvrrY?=
 =?us-ascii?Q?jX6AMbh4VIIztduXGSVqM/AB/fIqJKQwysFcrLmnE9wUaYmij1zfcuu+irhy?=
 =?us-ascii?Q?uwzM8AXGOoljO9fcceMED6fz6ka348m2dKv/8ab998vU62i1yEIQp+Begly6?=
 =?us-ascii?Q?geDV0Rcu8dmFCcR5mCXXPPhKaVJwmC/CYNb0cLfP//owcxPFU+qegKVAZCnu?=
 =?us-ascii?Q?zW/BELn+zY86WSlrdsdSBOD/S1ED5ony3U9Uxkyd2u9mD59hUvFN9BZTiBcS?=
 =?us-ascii?Q?xHSoskB+vUmUH5temY2ClEbIvYtuao+mOTvXtXxZtdZBh82GkyUgzydLBeM3?=
 =?us-ascii?Q?0bhgxjkUE7MnibPcxX3lqjy3oQQBnyRQ0uXHDXmyWsrFv69mwLePL7EiUfCN?=
 =?us-ascii?Q?fXKGWeyqGvOz+1TQHyroAu4GjBwDCD5pwpFPZxeUmDxY9pmNK2n47ZWsjmfd?=
 =?us-ascii?Q?YGG5dhwYkZ1OuzEKfRRtSQjLXG+br8Mqqsy4wHRlBQQt7Wxb6rtOYjEi6PGD?=
 =?us-ascii?Q?/KpkzgebMgHsLvDfZlXBjfbGQH9ZAyZr+lRE8gyW0O+XOc1el55ox4wEjoYY?=
 =?us-ascii?Q?tZUS1F34lvRekHGC/I2/COaSWT5K6dbpmUfKaVuN2E1mX6DNUuFpINSx8+Et?=
 =?us-ascii?Q?8LoHnjsIVbeUFWU4kAlFYh41deOOng7FDUfEIpYDx/p3R8lCTKwXCautJ1sY?=
 =?us-ascii?Q?5y/lLi+BL6D1KhgfxaUR4w/YD6VHUMWDBJOpmWe7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cebacd-312e-4a8e-c0f4-08dc12c8db5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 17:15:06.2297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDRDKrV63Qe/nSDm3903CsbmUID9xrCaX1YbmjJVokROjW6Y/gBoDrRwsi/iTL+1ojZW7iMIQVmRoCr5RlfiIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1429

> Subject: Re: [EXTERNAL] Re: [PATCH next v2 1/1] RDMA/mana_ib: Introduce
> three helper functions to clean mana_ib code
>=20
> Hi Leon,
>=20
> // Sorry for re-sending the email. I did not know that I had to enable pl=
ain-text
> messages in outlook.
>=20
> thanks for pointing out the merge window. I will resend after it.
>=20
> I can also split it into 2 commits (mdev_to_gc and mana_ib_get_netdev in =
one,
> and CQ cb in the other), if it is required.
> I cannot separate "mdev_to_gc" and "mana_ib_get_netdev " into 2 commits a=
s it
> will double the changes and obstruct the reader.
>=20
> > And how is it safe now? What is unsafe here?
>=20
> The issue with the gdma_dev is  the following.
> Our mana HW device has two gdma_devs: one for ethernet and one for rdma.
> And in the code of mana_ib.ko it is not clearly indicated what gdma_dev i=
s used.
> So it means in some functions it is ethernet and in some it is rdma.
> The use of a wrong device in the hardware channel leads to errors and was=
te
> time of developers.
>=20
> This problem is addressed as follows:
> We avoid using gdma_dev explicitly in functions of mana_ib.ko except the =
init.
> As the gdma_context is only one, we abstract it into mdev_to_gc, to preve=
nt the
> user to declare gdma_dev.
> When a function actually needs to use gdma_dev of the ethernet, it uses n=
etdev,
> which encapsulates the correct gdma_dev.
> Getting netdev is implemented with mana_ib_get_netdev, to prevent  the us=
er to
> declare gdma_dev.
> When a function needs to use gdma_dev of the rdma, it will use struct
> mana_ib_dev (a child of ib_dev) in its hardware channel requests.
>=20
> I hope it explains what becomes safer. If it was useful, I can add this e=
xplanation
> to the commit message.

You patch doesn't make it safer, but rather makes it easier to understand. =
The wording "Unsafe and inconsistent" should be removed.

Long

>=20
> Thanks,
> Konstantin
>=20
> ________________________________________
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Thursday, January 11, 2024 12:14 PM
> To: Konstantin Taranov
> Cc: Konstantin Taranov; Long Li; jgg@ziepe.ca; linux-rdma@vger.kernel.org=
; linux-
> kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH next v2 1/1] RDMA/mana_ib: Introduce three
> helper functions to clean mana_ib code
>=20
> [You don't often get email from leon@kernel.org. Learn why this is import=
ant at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> On Wed, Jan 10, 2024 at 06:14:34AM -0800, Konstantin Taranov wrote:
> > From: Konstantin Taranov <kotaranov@microsoft.com>
> >
> > This patch aims to address two issues in mana_ib:
> > 1) Unsafe and inconsistent access to gdma_dev and  gdma_context
>=20
> And how is it safe now? What is unsafe here?
>=20
> > 2) Code repetitions
> >
> > As a rule of thumb, functions should not access gdma_dev directly
> >
> > Introduced functions:
> > 1) mdev_to_gc
>=20
> Which is exactly "mdev->gdma_dev->gdma_context" as before.
>=20
> > 2) mana_ib_get_netdev
> > 3) mana_ib_install_cq_cb
> >
> >
>=20
> We are in merge window and cleanup patch will need to wait till it ends.
>=20
> Thanks
>=20
> > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > ---
> > Sorry that was sent again, I forgot to add RDMA/mana_ib to the subject
> > ---
> >  drivers/infiniband/hw/mana/cq.c      | 23 ++++++++++++++--
> >  drivers/infiniband/hw/mana/main.c    | 40 ++++++++++------------------
> >  drivers/infiniband/hw/mana/mana_ib.h | 17 ++++++++++++
> >  drivers/infiniband/hw/mana/mr.c      | 13 +++------
> >  drivers/infiniband/hw/mana/qp.c      | 36 ++++++-------------------
> >  5 files changed, 63 insertions(+), 66 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mana/cq.c
> > b/drivers/infiniband/hw/mana/cq.c index 83ebd0705..255e74ab7 100644
> > --- a/drivers/infiniband/hw/mana/cq.c
> > +++ b/drivers/infiniband/hw/mana/cq.c
> > @@ -16,7 +16,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struc=
t
> ib_cq_init_attr *attr,
> >       int err;
> >
> >       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     gc =3D mdev->gdma_dev->gdma_context;
> > +     gc =3D mdev_to_gc(mdev);
> >
> >       if (udata->inlen < sizeof(ucmd))
> >               return -EINVAL;
> > @@ -81,7 +81,7 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct
> ib_udata *udata)
> >       int err;
> >
> >       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     gc =3D mdev->gdma_dev->gdma_context;
> > +     gc =3D mdev_to_gc(mdev);
> >
> >       err =3D mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
> >       if (err) {
> > @@ -107,3 +107,22 @@ void mana_ib_cq_handler(void *ctx, struct
> gdma_queue *gdma_cq)
> >       if (cq->ibcq.comp_handler)
> >               cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
> > }
> > +
> > +int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq
> > +*cq) {
> > +     struct gdma_context *gc =3D mdev_to_gc(mdev);
> > +     struct gdma_queue *gdma_cq;
> > +
> > +     /* Create CQ table entry */
> > +     WARN_ON(gc->cq_table[cq->id]);
> > +     gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> > +     if (!gdma_cq)
> > +             return -ENOMEM;
> > +
> > +     gdma_cq->cq.context =3D cq;
> > +     gdma_cq->type =3D GDMA_CQ;
> > +     gdma_cq->cq.callback =3D mana_ib_cq_handler;
> > +     gdma_cq->id =3D cq->id;
> > +     gc->cq_table[cq->id] =3D gdma_cq;
> > +     return 0;
> > +}
> > diff --git a/drivers/infiniband/hw/mana/main.c
> > b/drivers/infiniband/hw/mana/main.c
> > index faca09245..29dd2438d 100644
> > --- a/drivers/infiniband/hw/mana/main.c
> > +++ b/drivers/infiniband/hw/mana/main.c
> > @@ -8,13 +8,10 @@
> >  void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *p=
d,
> >                        u32 port)
> >  {
> > -     struct gdma_dev *gd =3D &dev->gdma_dev->gdma_context->mana;
> >       struct mana_port_context *mpc;
> >       struct net_device *ndev;
> > -     struct mana_context *mc;
> >
> > -     mc =3D gd->driver_data;
> > -     ndev =3D mc->ports[port];
> > +     ndev =3D mana_ib_get_netdev(&dev->ib_dev, port);
> >       mpc =3D netdev_priv(ndev);
> >
> >       mutex_lock(&pd->vport_mutex);
> > @@ -31,14 +28,11 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev,
> > struct mana_ib_pd *pd,  int mana_ib_cfg_vport(struct mana_ib_dev *dev, =
u32
> port, struct mana_ib_pd *pd,
> >                     u32 doorbell_id)
> >  {
> > -     struct gdma_dev *mdev =3D &dev->gdma_dev->gdma_context->mana;
> >       struct mana_port_context *mpc;
> > -     struct mana_context *mc;
> >       struct net_device *ndev;
> >       int err;
> >
> > -     mc =3D mdev->driver_data;
> > -     ndev =3D mc->ports[port];
> > +     ndev =3D mana_ib_get_netdev(&dev->ib_dev, port);
> >       mpc =3D netdev_priv(ndev);
> >
> >       mutex_lock(&pd->vport_mutex);
> > @@ -79,17 +73,17 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct
> ib_udata *udata)
> >       struct gdma_create_pd_req req =3D {};
> >       enum gdma_pd_flags flags =3D 0;
> >       struct mana_ib_dev *dev;
> > -     struct gdma_dev *mdev;
> > +     struct gdma_context *gc;
> >       int err;
> >
> >       dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     mdev =3D dev->gdma_dev;
> > +     gc =3D mdev_to_gc(dev);
> >
> >       mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),
> >                            sizeof(resp));
> >
> >       req.flags =3D flags;
> > -     err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req), &re=
q,
> > +     err =3D mana_gd_send_request(gc, sizeof(req), &req,
> >                                  sizeof(resp), &resp);
> >
> >       if (err || resp.hdr.status) {
> > @@ -119,17 +113,17 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct
> ib_udata *udata)
> >       struct gdma_destory_pd_resp resp =3D {};
> >       struct gdma_destroy_pd_req req =3D {};
> >       struct mana_ib_dev *dev;
> > -     struct gdma_dev *mdev;
> > +     struct gdma_context *gc;
> >       int err;
> >
> >       dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     mdev =3D dev->gdma_dev;
> > +     gc =3D mdev_to_gc(dev);
> >
> >       mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_PD, sizeof(req),
> >                            sizeof(resp));
> >
> >       req.pd_handle =3D pd->pd_handle;
> > -     err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req), &re=
q,
> > +     err =3D mana_gd_send_request(gc, sizeof(req), &req,
> >                                  sizeof(resp), &resp);
> >
> >       if (err || resp.hdr.status) {
> > @@ -206,13 +200,11 @@ int mana_ib_alloc_ucontext(struct ib_ucontext
> *ibcontext,
> >       struct ib_device *ibdev =3D ibcontext->device;
> >       struct mana_ib_dev *mdev;
> >       struct gdma_context *gc;
> > -     struct gdma_dev *dev;
> >       int doorbell_page;
> >       int ret;
> >
> >       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     dev =3D mdev->gdma_dev;
> > -     gc =3D dev->gdma_context;
> > +     gc =3D mdev_to_gc(mdev);
> >
> >       /* Allocate a doorbell page index */
> >       ret =3D mana_gd_allocate_doorbell_page(gc, &doorbell_page); @@
> > -238,7 +230,7 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext
> *ibcontext)
> >       int ret;
> >
> >       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     gc =3D mdev->gdma_dev->gdma_context;
> > +     gc =3D mdev_to_gc(mdev);
> >
> >       ret =3D mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell=
);
> >       if (ret)
> > @@ -322,15 +314,13 @@ int mana_ib_gd_create_dma_region(struct
> mana_ib_dev *dev, struct ib_umem *umem,
> >       size_t max_pgs_create_cmd;
> >       struct gdma_context *gc;
> >       size_t num_pages_total;
> > -     struct gdma_dev *mdev;
> >       unsigned long page_sz;
> >       unsigned int tail =3D 0;
> >       u64 *page_addr_list;
> >       void *request_buf;
> >       int err;
> >
> > -     mdev =3D dev->gdma_dev;
> > -     gc =3D mdev->gdma_context;
> > +     gc =3D mdev_to_gc(dev);
> >       hwc =3D gc->hwc.driver_data;
> >
> >       /* Hardware requires dma region to align to chosen page size */
> > @@ -426,10 +416,8 @@ int mana_ib_gd_create_dma_region(struct
> > mana_ib_dev *dev, struct ib_umem *umem,
> >
> >  int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev, u64
> > gdma_region)  {
> > -     struct gdma_dev *mdev =3D dev->gdma_dev;
> > -     struct gdma_context *gc;
> > +     struct gdma_context *gc =3D mdev_to_gc(dev);
> >
> > -     gc =3D mdev->gdma_context;
> >       ibdev_dbg(&dev->ib_dev, "destroy dma region 0x%llx\n",
> > gdma_region);
> >
> >       return mana_gd_destroy_dma_region(gc, gdma_region); @@ -447,7
> > +435,7 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct
> vm_area_struct *vma)
> >       int ret;
> >
> >       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     gc =3D mdev->gdma_dev->gdma_context;
> > +     gc =3D mdev_to_gc(mdev);
> >
> >       if (vma->vm_pgoff !=3D 0) {
> >               ibdev_dbg(ibdev, "Unexpected vm_pgoff %lu\n",
> > vma->vm_pgoff); @@ -531,7 +519,7 @@ int
> mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
> >       req.hdr.resp.msg_version =3D GDMA_MESSAGE_V3;
> >       req.hdr.dev_id =3D dev->gdma_dev->dev_id;
> >
> > -     err =3D mana_gd_send_request(dev->gdma_dev->gdma_context, sizeof(=
req),
> > +     err =3D mana_gd_send_request(mdev_to_gc(dev), sizeof(req),
> >                                  &req, sizeof(resp), &resp);
> >
> >       if (err) {
> > diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> > b/drivers/infiniband/hw/mana/mana_ib.h
> > index 6bdc0f549..6b15b2ab5 100644
> > --- a/drivers/infiniband/hw/mana/mana_ib.h
> > +++ b/drivers/infiniband/hw/mana/mana_ib.h
> > @@ -142,6 +142,22 @@ struct mana_ib_query_adapter_caps_resp {
> >       u32 max_inline_data_size;
> >  }; /* HW Data */
> >
> > +static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev
> > +*mdev) {
> > +     return mdev->gdma_dev->gdma_context; }
> > +
> > +static inline struct net_device *mana_ib_get_netdev(struct ib_device
> > +*ibdev, u32 port) {
> > +     struct mana_ib_dev *mdev =3D container_of(ibdev, struct mana_ib_d=
ev,
> ib_dev);
> > +     struct gdma_context *gc =3D mdev_to_gc(mdev);
> > +     struct mana_context *mc =3D gc->mana.driver_data;
> > +
> > +     if (port < 1 || port > mc->num_ports)
> > +             return NULL;
> > +     return mc->ports[port - 1];
> > +}
> > +
> >  int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_um=
em
> *umem,
> >                                mana_handle_t *gdma_region);
> >
> > @@ -188,6 +204,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const str=
uct
> ib_cq_init_attr *attr,
> >                     struct ib_udata *udata);
> >
> >  int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
> > +int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq
> > +*cq);
> >
> >  int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> > int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> > diff --git a/drivers/infiniband/hw/mana/mr.c
> > b/drivers/infiniband/hw/mana/mr.c index 351207c60..ee4d4f834 100644
> > --- a/drivers/infiniband/hw/mana/mr.c
> > +++ b/drivers/infiniband/hw/mana/mr.c
> > @@ -30,12 +30,9 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev
> > *dev, struct mana_ib_mr *mr,  {
> >       struct gdma_create_mr_response resp =3D {};
> >       struct gdma_create_mr_request req =3D {};
> > -     struct gdma_dev *mdev =3D dev->gdma_dev;
> > -     struct gdma_context *gc;
> > +     struct gdma_context *gc =3D mdev_to_gc(dev);
> >       int err;
> >
> > -     gc =3D mdev->gdma_context;
> > -
> >       mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req),
> >                            sizeof(resp));
> >       req.pd_handle =3D mr_params->pd_handle; @@ -77,12 +74,9 @@ static
> > int mana_ib_gd_destroy_mr(struct mana_ib_dev *dev, u64 mr_handle)  {
> >       struct gdma_destroy_mr_response resp =3D {};
> >       struct gdma_destroy_mr_request req =3D {};
> > -     struct gdma_dev *mdev =3D dev->gdma_dev;
> > -     struct gdma_context *gc;
> > +     struct gdma_context *gc =3D mdev_to_gc(dev);
> >       int err;
> >
> > -     gc =3D mdev->gdma_context;
> > -
> >       mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_MR, sizeof(req),
> >                            sizeof(resp));
> >
> > @@ -164,8 +158,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd
> *ibpd, u64 start, u64 length,
> >       return &mr->ibmr;
> >
> >  err_dma_region:
> > -     mana_gd_destroy_dma_region(dev->gdma_dev->gdma_context,
> > -                                dma_region_handle);
> > +     mana_gd_destroy_dma_region(mdev_to_gc(dev), dma_region_handle);
> >
> >  err_umem:
> >       ib_umem_release(mr->umem);
> > diff --git a/drivers/infiniband/hw/mana/qp.c
> > b/drivers/infiniband/hw/mana/qp.c index e6d063d45..e889c798f 100644
> > --- a/drivers/infiniband/hw/mana/qp.c
> > +++ b/drivers/infiniband/hw/mana/qp.c
> > @@ -17,12 +17,10 @@ static int mana_ib_cfg_vport_steering(struct
> mana_ib_dev *dev,
> >       struct mana_cfg_rx_steer_resp resp =3D {};
> >       mana_handle_t *req_indir_tab;
> >       struct gdma_context *gc;
> > -     struct gdma_dev *mdev;
> >       u32 req_buf_size;
> >       int i, err;
> >
> > -     gc =3D dev->gdma_dev->gdma_context;
> > -     mdev =3D &gc->mana;
> > +     gc =3D mdev_to_gc(dev);
> >
> >       req_buf_size =3D
> >               sizeof(*req) + sizeof(mana_handle_t) *
> > MANA_INDIRECT_TABLE_SIZE; @@ -39,7 +37,7 @@ static int
> mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
> >       req->rx_enable =3D 1;
> >       req->update_default_rxobj =3D 1;
> >       req->default_rxobj =3D default_rxobj;
> > -     req->hdr.dev_id =3D mdev->dev_id;
> > +     req->hdr.dev_id =3D gc->mana.dev_id;
> >
> >       /* If there are more than 1 entries in indirection table, enable =
RSS */
> >       if (log_ind_tbl_size)
> > @@ -106,7 +104,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp=
,
> struct ib_pd *pd,
> >       struct gdma_queue **gdma_cq_allocated;
> >       mana_handle_t *mana_ind_table;
> >       struct mana_port_context *mpc;
> > -     struct gdma_queue *gdma_cq;
> >       unsigned int ind_tbl_size;
> >       struct net_device *ndev;
> >       struct mana_ib_cq *cq;
> > @@ -231,19 +228,11 @@ static int mana_ib_create_qp_rss(struct ib_qp *ib=
qp,
> struct ib_pd *pd,
> >               mana_ind_table[i] =3D wq->rx_object;
> >
> >               /* Create CQ table entry */
> > -             WARN_ON(gc->cq_table[cq->id]);
> > -             gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> > -             if (!gdma_cq) {
> > -                     ret =3D -ENOMEM;
> > +             ret =3D mana_ib_install_cq_cb(mdev, cq);
> > +             if (!ret)
> >                       goto fail;
> > -             }
> > -             gdma_cq_allocated[i] =3D gdma_cq;
> >
> > -             gdma_cq->cq.context =3D cq;
> > -             gdma_cq->type =3D GDMA_CQ;
> > -             gdma_cq->cq.callback =3D mana_ib_cq_handler;
> > -             gdma_cq->id =3D cq->id;
> > -             gc->cq_table[cq->id] =3D gdma_cq;
> > +             gdma_cq_allocated[i] =3D gc->cq_table[cq->id];
> >       }
> >       resp.num_entries =3D i;
> >
> > @@ -409,18 +398,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibq=
p,
> struct ib_pd *ibpd,
> >       send_cq->id =3D cq_spec.queue_index;
> >
> >       /* Create CQ table entry */
> > -     WARN_ON(gc->cq_table[send_cq->id]);
> > -     gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> > -     if (!gdma_cq) {
> > -             err =3D -ENOMEM;
> > +     err =3D mana_ib_install_cq_cb(mdev, send_cq);
> > +     if (err)
> >               goto err_destroy_wq_obj;
> > -     }
> > -
> > -     gdma_cq->cq.context =3D send_cq;
> > -     gdma_cq->type =3D GDMA_CQ;
> > -     gdma_cq->cq.callback =3D mana_ib_cq_handler;
> > -     gdma_cq->id =3D send_cq->id;
> > -     gc->cq_table[send_cq->id] =3D gdma_cq;
> >
> >       ibdev_dbg(&mdev->ib_dev,
> >                 "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n",
> > err, @@ -442,7 +422,7 @@ static int mana_ib_create_qp_raw(struct ib_qp
> > *ibqp, struct ib_pd *ibpd,
> >
> >  err_release_gdma_cq:
> >       kfree(gdma_cq);
> > -     gd->gdma_context->cq_table[send_cq->id] =3D NULL;
> > +     gc->cq_table[send_cq->id] =3D NULL;
> >
> >  err_destroy_wq_obj:
> >       mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
> >
> > base-commit: d24b923f1d696ddacb09f0f2d1b1f4f045cfe65e
> > prerequisite-patch-id: 1b5d35ba40b675d080bfbe6a0e73b0dd163f4a03
> > --
> > 2.43.0
> >
>=20
>=20
> ________________________________________
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Thursday, January 11, 2024 12:14 PM
> To: Konstantin Taranov
> Cc: Konstantin Taranov; Long Li; jgg@ziepe.ca; linux-rdma@vger.kernel.org=
; linux-
> kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH next v2 1/1] RDMA/mana_ib: Introduce three
> helper functions to clean mana_ib code
>=20
> [You don't often get email from leon@kernel.org. Learn why this is import=
ant at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> On Wed, Jan 10, 2024 at 06:14:34AM -0800, Konstantin Taranov wrote:
> > From: Konstantin Taranov <kotaranov@microsoft.com>
> >
> > This patch aims to address two issues in mana_ib:
> > 1) Unsafe and inconsistent access to gdma_dev and  gdma_context
>=20
> And how is it safe now? What is unsafe here?
>=20
> > 2) Code repetitions
> >
> > As a rule of thumb, functions should not access gdma_dev directly
> >
> > Introduced functions:
> > 1) mdev_to_gc
>=20
> Which is exactly "mdev->gdma_dev->gdma_context" as before.
>=20
> > 2) mana_ib_get_netdev
> > 3) mana_ib_install_cq_cb
> >
> >
>=20
> We are in merge window and cleanup patch will need to wait till it ends.
>=20
> Thanks
>=20
> > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > ---
> > Sorry that was sent again, I forgot to add RDMA/mana_ib to the subject
> > ---
> >  drivers/infiniband/hw/mana/cq.c      | 23 ++++++++++++++--
> >  drivers/infiniband/hw/mana/main.c    | 40 ++++++++++------------------
> >  drivers/infiniband/hw/mana/mana_ib.h | 17 ++++++++++++
> >  drivers/infiniband/hw/mana/mr.c      | 13 +++------
> >  drivers/infiniband/hw/mana/qp.c      | 36 ++++++-------------------
> >  5 files changed, 63 insertions(+), 66 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mana/cq.c
> > b/drivers/infiniband/hw/mana/cq.c index 83ebd0705..255e74ab7 100644
> > --- a/drivers/infiniband/hw/mana/cq.c
> > +++ b/drivers/infiniband/hw/mana/cq.c
> > @@ -16,7 +16,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struc=
t
> ib_cq_init_attr *attr,
> >       int err;
> >
> >       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     gc =3D mdev->gdma_dev->gdma_context;
> > +     gc =3D mdev_to_gc(mdev);
> >
> >       if (udata->inlen < sizeof(ucmd))
> >               return -EINVAL;
> > @@ -81,7 +81,7 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct
> ib_udata *udata)
> >       int err;
> >
> >       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     gc =3D mdev->gdma_dev->gdma_context;
> > +     gc =3D mdev_to_gc(mdev);
> >
> >       err =3D mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
> >       if (err) {
> > @@ -107,3 +107,22 @@ void mana_ib_cq_handler(void *ctx, struct
> gdma_queue *gdma_cq)
> >       if (cq->ibcq.comp_handler)
> >               cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
> > }
> > +
> > +int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq
> > +*cq) {
> > +     struct gdma_context *gc =3D mdev_to_gc(mdev);
> > +     struct gdma_queue *gdma_cq;
> > +
> > +     /* Create CQ table entry */
> > +     WARN_ON(gc->cq_table[cq->id]);
> > +     gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> > +     if (!gdma_cq)
> > +             return -ENOMEM;
> > +
> > +     gdma_cq->cq.context =3D cq;
> > +     gdma_cq->type =3D GDMA_CQ;
> > +     gdma_cq->cq.callback =3D mana_ib_cq_handler;
> > +     gdma_cq->id =3D cq->id;
> > +     gc->cq_table[cq->id] =3D gdma_cq;
> > +     return 0;
> > +}
> > diff --git a/drivers/infiniband/hw/mana/main.c
> > b/drivers/infiniband/hw/mana/main.c
> > index faca09245..29dd2438d 100644
> > --- a/drivers/infiniband/hw/mana/main.c
> > +++ b/drivers/infiniband/hw/mana/main.c
> > @@ -8,13 +8,10 @@
> >  void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *p=
d,
> >                        u32 port)
> >  {
> > -     struct gdma_dev *gd =3D &dev->gdma_dev->gdma_context->mana;
> >       struct mana_port_context *mpc;
> >       struct net_device *ndev;
> > -     struct mana_context *mc;
> >
> > -     mc =3D gd->driver_data;
> > -     ndev =3D mc->ports[port];
> > +     ndev =3D mana_ib_get_netdev(&dev->ib_dev, port);
> >       mpc =3D netdev_priv(ndev);
> >
> >       mutex_lock(&pd->vport_mutex);
> > @@ -31,14 +28,11 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev,
> > struct mana_ib_pd *pd,  int mana_ib_cfg_vport(struct mana_ib_dev *dev, =
u32
> port, struct mana_ib_pd *pd,
> >                     u32 doorbell_id)
> >  {
> > -     struct gdma_dev *mdev =3D &dev->gdma_dev->gdma_context->mana;
> >       struct mana_port_context *mpc;
> > -     struct mana_context *mc;
> >       struct net_device *ndev;
> >       int err;
> >
> > -     mc =3D mdev->driver_data;
> > -     ndev =3D mc->ports[port];
> > +     ndev =3D mana_ib_get_netdev(&dev->ib_dev, port);
> >       mpc =3D netdev_priv(ndev);
> >
> >       mutex_lock(&pd->vport_mutex);
> > @@ -79,17 +73,17 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct
> ib_udata *udata)
> >       struct gdma_create_pd_req req =3D {};
> >       enum gdma_pd_flags flags =3D 0;
> >       struct mana_ib_dev *dev;
> > -     struct gdma_dev *mdev;
> > +     struct gdma_context *gc;
> >       int err;
> >
> >       dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     mdev =3D dev->gdma_dev;
> > +     gc =3D mdev_to_gc(dev);
> >
> >       mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),
> >                            sizeof(resp));
> >
> >       req.flags =3D flags;
> > -     err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req), &re=
q,
> > +     err =3D mana_gd_send_request(gc, sizeof(req), &req,
> >                                  sizeof(resp), &resp);
> >
> >       if (err || resp.hdr.status) {
> > @@ -119,17 +113,17 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct
> ib_udata *udata)
> >       struct gdma_destory_pd_resp resp =3D {};
> >       struct gdma_destroy_pd_req req =3D {};
> >       struct mana_ib_dev *dev;
> > -     struct gdma_dev *mdev;
> > +     struct gdma_context *gc;
> >       int err;
> >
> >       dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     mdev =3D dev->gdma_dev;
> > +     gc =3D mdev_to_gc(dev);
> >
> >       mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_PD, sizeof(req),
> >                            sizeof(resp));
> >
> >       req.pd_handle =3D pd->pd_handle;
> > -     err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req), &re=
q,
> > +     err =3D mana_gd_send_request(gc, sizeof(req), &req,
> >                                  sizeof(resp), &resp);
> >
> >       if (err || resp.hdr.status) {
> > @@ -206,13 +200,11 @@ int mana_ib_alloc_ucontext(struct ib_ucontext
> *ibcontext,
> >       struct ib_device *ibdev =3D ibcontext->device;
> >       struct mana_ib_dev *mdev;
> >       struct gdma_context *gc;
> > -     struct gdma_dev *dev;
> >       int doorbell_page;
> >       int ret;
> >
> >       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     dev =3D mdev->gdma_dev;
> > -     gc =3D dev->gdma_context;
> > +     gc =3D mdev_to_gc(mdev);
> >
> >       /* Allocate a doorbell page index */
> >       ret =3D mana_gd_allocate_doorbell_page(gc, &doorbell_page); @@
> > -238,7 +230,7 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext
> *ibcontext)
> >       int ret;
> >
> >       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     gc =3D mdev->gdma_dev->gdma_context;
> > +     gc =3D mdev_to_gc(mdev);
> >
> >       ret =3D mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell=
);
> >       if (ret)
> > @@ -322,15 +314,13 @@ int mana_ib_gd_create_dma_region(struct
> mana_ib_dev *dev, struct ib_umem *umem,
> >       size_t max_pgs_create_cmd;
> >       struct gdma_context *gc;
> >       size_t num_pages_total;
> > -     struct gdma_dev *mdev;
> >       unsigned long page_sz;
> >       unsigned int tail =3D 0;
> >       u64 *page_addr_list;
> >       void *request_buf;
> >       int err;
> >
> > -     mdev =3D dev->gdma_dev;
> > -     gc =3D mdev->gdma_context;
> > +     gc =3D mdev_to_gc(dev);
> >       hwc =3D gc->hwc.driver_data;
> >
> >       /* Hardware requires dma region to align to chosen page size */
> > @@ -426,10 +416,8 @@ int mana_ib_gd_create_dma_region(struct
> > mana_ib_dev *dev, struct ib_umem *umem,
> >
> >  int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev, u64
> > gdma_region)  {
> > -     struct gdma_dev *mdev =3D dev->gdma_dev;
> > -     struct gdma_context *gc;
> > +     struct gdma_context *gc =3D mdev_to_gc(dev);
> >
> > -     gc =3D mdev->gdma_context;
> >       ibdev_dbg(&dev->ib_dev, "destroy dma region 0x%llx\n",
> > gdma_region);
> >
> >       return mana_gd_destroy_dma_region(gc, gdma_region); @@ -447,7
> > +435,7 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct
> vm_area_struct *vma)
> >       int ret;
> >
> >       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     gc =3D mdev->gdma_dev->gdma_context;
> > +     gc =3D mdev_to_gc(mdev);
> >
> >       if (vma->vm_pgoff !=3D 0) {
> >               ibdev_dbg(ibdev, "Unexpected vm_pgoff %lu\n",
> > vma->vm_pgoff); @@ -531,7 +519,7 @@ int
> mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
> >       req.hdr.resp.msg_version =3D GDMA_MESSAGE_V3;
> >       req.hdr.dev_id =3D dev->gdma_dev->dev_id;
> >
> > -     err =3D mana_gd_send_request(dev->gdma_dev->gdma_context, sizeof(=
req),
> > +     err =3D mana_gd_send_request(mdev_to_gc(dev), sizeof(req),
> >                                  &req, sizeof(resp), &resp);
> >
> >       if (err) {
> > diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> > b/drivers/infiniband/hw/mana/mana_ib.h
> > index 6bdc0f549..6b15b2ab5 100644
> > --- a/drivers/infiniband/hw/mana/mana_ib.h
> > +++ b/drivers/infiniband/hw/mana/mana_ib.h
> > @@ -142,6 +142,22 @@ struct mana_ib_query_adapter_caps_resp {
> >       u32 max_inline_data_size;
> >  }; /* HW Data */
> >
> > +static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev
> > +*mdev) {
> > +     return mdev->gdma_dev->gdma_context; }
> > +
> > +static inline struct net_device *mana_ib_get_netdev(struct ib_device
> > +*ibdev, u32 port) {
> > +     struct mana_ib_dev *mdev =3D container_of(ibdev, struct mana_ib_d=
ev,
> ib_dev);
> > +     struct gdma_context *gc =3D mdev_to_gc(mdev);
> > +     struct mana_context *mc =3D gc->mana.driver_data;
> > +
> > +     if (port < 1 || port > mc->num_ports)
> > +             return NULL;
> > +     return mc->ports[port - 1];
> > +}
> > +
> >  int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_um=
em
> *umem,
> >                                mana_handle_t *gdma_region);
> >
> > @@ -188,6 +204,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const str=
uct
> ib_cq_init_attr *attr,
> >                     struct ib_udata *udata);
> >
> >  int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
> > +int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq
> > +*cq);
> >
> >  int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> > int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> > diff --git a/drivers/infiniband/hw/mana/mr.c
> > b/drivers/infiniband/hw/mana/mr.c index 351207c60..ee4d4f834 100644
> > --- a/drivers/infiniband/hw/mana/mr.c
> > +++ b/drivers/infiniband/hw/mana/mr.c
> > @@ -30,12 +30,9 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev
> > *dev, struct mana_ib_mr *mr,  {
> >       struct gdma_create_mr_response resp =3D {};
> >       struct gdma_create_mr_request req =3D {};
> > -     struct gdma_dev *mdev =3D dev->gdma_dev;
> > -     struct gdma_context *gc;
> > +     struct gdma_context *gc =3D mdev_to_gc(dev);
> >       int err;
> >
> > -     gc =3D mdev->gdma_context;
> > -
> >       mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req),
> >                            sizeof(resp));
> >       req.pd_handle =3D mr_params->pd_handle; @@ -77,12 +74,9 @@ static
> > int mana_ib_gd_destroy_mr(struct mana_ib_dev *dev, u64 mr_handle)  {
> >       struct gdma_destroy_mr_response resp =3D {};
> >       struct gdma_destroy_mr_request req =3D {};
> > -     struct gdma_dev *mdev =3D dev->gdma_dev;
> > -     struct gdma_context *gc;
> > +     struct gdma_context *gc =3D mdev_to_gc(dev);
> >       int err;
> >
> > -     gc =3D mdev->gdma_context;
> > -
> >       mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_MR, sizeof(req),
> >                            sizeof(resp));
> >
> > @@ -164,8 +158,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd
> *ibpd, u64 start, u64 length,
> >       return &mr->ibmr;
> >
> >  err_dma_region:
> > -     mana_gd_destroy_dma_region(dev->gdma_dev->gdma_context,
> > -                                dma_region_handle);
> > +     mana_gd_destroy_dma_region(mdev_to_gc(dev), dma_region_handle);
> >
> >  err_umem:
> >       ib_umem_release(mr->umem);
> > diff --git a/drivers/infiniband/hw/mana/qp.c
> > b/drivers/infiniband/hw/mana/qp.c index e6d063d45..e889c798f 100644
> > --- a/drivers/infiniband/hw/mana/qp.c
> > +++ b/drivers/infiniband/hw/mana/qp.c
> > @@ -17,12 +17,10 @@ static int mana_ib_cfg_vport_steering(struct
> mana_ib_dev *dev,
> >       struct mana_cfg_rx_steer_resp resp =3D {};
> >       mana_handle_t *req_indir_tab;
> >       struct gdma_context *gc;
> > -     struct gdma_dev *mdev;
> >       u32 req_buf_size;
> >       int i, err;
> >
> > -     gc =3D dev->gdma_dev->gdma_context;
> > -     mdev =3D &gc->mana;
> > +     gc =3D mdev_to_gc(dev);
> >
> >       req_buf_size =3D
> >               sizeof(*req) + sizeof(mana_handle_t) *
> > MANA_INDIRECT_TABLE_SIZE; @@ -39,7 +37,7 @@ static int
> mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
> >       req->rx_enable =3D 1;
> >       req->update_default_rxobj =3D 1;
> >       req->default_rxobj =3D default_rxobj;
> > -     req->hdr.dev_id =3D mdev->dev_id;
> > +     req->hdr.dev_id =3D gc->mana.dev_id;
> >
> >       /* If there are more than 1 entries in indirection table, enable =
RSS */
> >       if (log_ind_tbl_size)
> > @@ -106,7 +104,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp=
,
> struct ib_pd *pd,
> >       struct gdma_queue **gdma_cq_allocated;
> >       mana_handle_t *mana_ind_table;
> >       struct mana_port_context *mpc;
> > -     struct gdma_queue *gdma_cq;
> >       unsigned int ind_tbl_size;
> >       struct net_device *ndev;
> >       struct mana_ib_cq *cq;
> > @@ -231,19 +228,11 @@ static int mana_ib_create_qp_rss(struct ib_qp *ib=
qp,
> struct ib_pd *pd,
> >               mana_ind_table[i] =3D wq->rx_object;
> >
> >               /* Create CQ table entry */
> > -             WARN_ON(gc->cq_table[cq->id]);
> > -             gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> > -             if (!gdma_cq) {
> > -                     ret =3D -ENOMEM;
> > +             ret =3D mana_ib_install_cq_cb(mdev, cq);
> > +             if (!ret)
> >                       goto fail;
> > -             }
> > -             gdma_cq_allocated[i] =3D gdma_cq;
> >
> > -             gdma_cq->cq.context =3D cq;
> > -             gdma_cq->type =3D GDMA_CQ;
> > -             gdma_cq->cq.callback =3D mana_ib_cq_handler;
> > -             gdma_cq->id =3D cq->id;
> > -             gc->cq_table[cq->id] =3D gdma_cq;
> > +             gdma_cq_allocated[i] =3D gc->cq_table[cq->id];
> >       }
> >       resp.num_entries =3D i;
> >
> > @@ -409,18 +398,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibq=
p,
> struct ib_pd *ibpd,
> >       send_cq->id =3D cq_spec.queue_index;
> >
> >       /* Create CQ table entry */
> > -     WARN_ON(gc->cq_table[send_cq->id]);
> > -     gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> > -     if (!gdma_cq) {
> > -             err =3D -ENOMEM;
> > +     err =3D mana_ib_install_cq_cb(mdev, send_cq);
> > +     if (err)
> >               goto err_destroy_wq_obj;
> > -     }
> > -
> > -     gdma_cq->cq.context =3D send_cq;
> > -     gdma_cq->type =3D GDMA_CQ;
> > -     gdma_cq->cq.callback =3D mana_ib_cq_handler;
> > -     gdma_cq->id =3D send_cq->id;
> > -     gc->cq_table[send_cq->id] =3D gdma_cq;
> >
> >       ibdev_dbg(&mdev->ib_dev,
> >                 "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n",
> > err, @@ -442,7 +422,7 @@ static int mana_ib_create_qp_raw(struct ib_qp
> > *ibqp, struct ib_pd *ibpd,
> >
> >  err_release_gdma_cq:
> >       kfree(gdma_cq);
> > -     gd->gdma_context->cq_table[send_cq->id] =3D NULL;
> > +     gc->cq_table[send_cq->id] =3D NULL;
> >
> >  err_destroy_wq_obj:
> >       mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
> >
> > base-commit: d24b923f1d696ddacb09f0f2d1b1f4f045cfe65e
> > prerequisite-patch-id: 1b5d35ba40b675d080bfbe6a0e73b0dd163f4a03
> > --
> > 2.43.0
> >
>=20
>=20
> ________________________________________
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Thursday, January 11, 2024 12:14 PM
> To: Konstantin Taranov
> Cc: Konstantin Taranov; Long Li; jgg@ziepe.ca; linux-rdma@vger.kernel.org=
; linux-
> kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH next v2 1/1] RDMA/mana_ib: Introduce three
> helper functions to clean mana_ib code
>=20
> [You don't often get email from leon@kernel.org. Learn why this is import=
ant at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> On Wed, Jan 10, 2024 at 06:14:34AM -0800, Konstantin Taranov wrote:
> > From: Konstantin Taranov <kotaranov@microsoft.com>
> >
> > This patch aims to address two issues in mana_ib:
> > 1) Unsafe and inconsistent access to gdma_dev and  gdma_context
>=20
> And how is it safe now? What is unsafe here?
>=20
> > 2) Code repetitions
> >
> > As a rule of thumb, functions should not access gdma_dev directly
> >
> > Introduced functions:
> > 1) mdev_to_gc
>=20
> Which is exactly "mdev->gdma_dev->gdma_context" as before.
>=20
> > 2) mana_ib_get_netdev
> > 3) mana_ib_install_cq_cb
> >
> >
>=20
> We are in merge window and cleanup patch will need to wait till it ends.
>=20
> Thanks
>=20
> > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > ---
> > Sorry that was sent again, I forgot to add RDMA/mana_ib to the subject
> > ---
> >  drivers/infiniband/hw/mana/cq.c      | 23 ++++++++++++++--
> >  drivers/infiniband/hw/mana/main.c    | 40 ++++++++++------------------
> >  drivers/infiniband/hw/mana/mana_ib.h | 17 ++++++++++++
> >  drivers/infiniband/hw/mana/mr.c      | 13 +++------
> >  drivers/infiniband/hw/mana/qp.c      | 36 ++++++-------------------
> >  5 files changed, 63 insertions(+), 66 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mana/cq.c
> > b/drivers/infiniband/hw/mana/cq.c index 83ebd0705..255e74ab7 100644
> > --- a/drivers/infiniband/hw/mana/cq.c
> > +++ b/drivers/infiniband/hw/mana/cq.c
> > @@ -16,7 +16,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struc=
t
> ib_cq_init_attr *attr,
> >       int err;
> >
> >       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     gc =3D mdev->gdma_dev->gdma_context;
> > +     gc =3D mdev_to_gc(mdev);
> >
> >       if (udata->inlen < sizeof(ucmd))
> >               return -EINVAL;
> > @@ -81,7 +81,7 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct
> ib_udata *udata)
> >       int err;
> >
> >       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     gc =3D mdev->gdma_dev->gdma_context;
> > +     gc =3D mdev_to_gc(mdev);
> >
> >       err =3D mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
> >       if (err) {
> > @@ -107,3 +107,22 @@ void mana_ib_cq_handler(void *ctx, struct
> gdma_queue *gdma_cq)
> >       if (cq->ibcq.comp_handler)
> >               cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
> > }
> > +
> > +int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq
> > +*cq) {
> > +     struct gdma_context *gc =3D mdev_to_gc(mdev);
> > +     struct gdma_queue *gdma_cq;
> > +
> > +     /* Create CQ table entry */
> > +     WARN_ON(gc->cq_table[cq->id]);
> > +     gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> > +     if (!gdma_cq)
> > +             return -ENOMEM;
> > +
> > +     gdma_cq->cq.context =3D cq;
> > +     gdma_cq->type =3D GDMA_CQ;
> > +     gdma_cq->cq.callback =3D mana_ib_cq_handler;
> > +     gdma_cq->id =3D cq->id;
> > +     gc->cq_table[cq->id] =3D gdma_cq;
> > +     return 0;
> > +}
> > diff --git a/drivers/infiniband/hw/mana/main.c
> > b/drivers/infiniband/hw/mana/main.c
> > index faca09245..29dd2438d 100644
> > --- a/drivers/infiniband/hw/mana/main.c
> > +++ b/drivers/infiniband/hw/mana/main.c
> > @@ -8,13 +8,10 @@
> >  void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *p=
d,
> >                        u32 port)
> >  {
> > -     struct gdma_dev *gd =3D &dev->gdma_dev->gdma_context->mana;
> >       struct mana_port_context *mpc;
> >       struct net_device *ndev;
> > -     struct mana_context *mc;
> >
> > -     mc =3D gd->driver_data;
> > -     ndev =3D mc->ports[port];
> > +     ndev =3D mana_ib_get_netdev(&dev->ib_dev, port);
> >       mpc =3D netdev_priv(ndev);
> >
> >       mutex_lock(&pd->vport_mutex);
> > @@ -31,14 +28,11 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev,
> > struct mana_ib_pd *pd,  int mana_ib_cfg_vport(struct mana_ib_dev *dev, =
u32
> port, struct mana_ib_pd *pd,
> >                     u32 doorbell_id)
> >  {
> > -     struct gdma_dev *mdev =3D &dev->gdma_dev->gdma_context->mana;
> >       struct mana_port_context *mpc;
> > -     struct mana_context *mc;
> >       struct net_device *ndev;
> >       int err;
> >
> > -     mc =3D mdev->driver_data;
> > -     ndev =3D mc->ports[port];
> > +     ndev =3D mana_ib_get_netdev(&dev->ib_dev, port);
> >       mpc =3D netdev_priv(ndev);
> >
> >       mutex_lock(&pd->vport_mutex);
> > @@ -79,17 +73,17 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct
> ib_udata *udata)
> >       struct gdma_create_pd_req req =3D {};
> >       enum gdma_pd_flags flags =3D 0;
> >       struct mana_ib_dev *dev;
> > -     struct gdma_dev *mdev;
> > +     struct gdma_context *gc;
> >       int err;
> >
> >       dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     mdev =3D dev->gdma_dev;
> > +     gc =3D mdev_to_gc(dev);
> >
> >       mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),
> >                            sizeof(resp));
> >
> >       req.flags =3D flags;
> > -     err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req), &re=
q,
> > +     err =3D mana_gd_send_request(gc, sizeof(req), &req,
> >                                  sizeof(resp), &resp);
> >
> >       if (err || resp.hdr.status) {
> > @@ -119,17 +113,17 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct
> ib_udata *udata)
> >       struct gdma_destory_pd_resp resp =3D {};
> >       struct gdma_destroy_pd_req req =3D {};
> >       struct mana_ib_dev *dev;
> > -     struct gdma_dev *mdev;
> > +     struct gdma_context *gc;
> >       int err;
> >
> >       dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     mdev =3D dev->gdma_dev;
> > +     gc =3D mdev_to_gc(dev);
> >
> >       mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_PD, sizeof(req),
> >                            sizeof(resp));
> >
> >       req.pd_handle =3D pd->pd_handle;
> > -     err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req), &re=
q,
> > +     err =3D mana_gd_send_request(gc, sizeof(req), &req,
> >                                  sizeof(resp), &resp);
> >
> >       if (err || resp.hdr.status) {
> > @@ -206,13 +200,11 @@ int mana_ib_alloc_ucontext(struct ib_ucontext
> *ibcontext,
> >       struct ib_device *ibdev =3D ibcontext->device;
> >       struct mana_ib_dev *mdev;
> >       struct gdma_context *gc;
> > -     struct gdma_dev *dev;
> >       int doorbell_page;
> >       int ret;
> >
> >       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     dev =3D mdev->gdma_dev;
> > -     gc =3D dev->gdma_context;
> > +     gc =3D mdev_to_gc(mdev);
> >
> >       /* Allocate a doorbell page index */
> >       ret =3D mana_gd_allocate_doorbell_page(gc, &doorbell_page); @@
> > -238,7 +230,7 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext
> *ibcontext)
> >       int ret;
> >
> >       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     gc =3D mdev->gdma_dev->gdma_context;
> > +     gc =3D mdev_to_gc(mdev);
> >
> >       ret =3D mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell=
);
> >       if (ret)
> > @@ -322,15 +314,13 @@ int mana_ib_gd_create_dma_region(struct
> mana_ib_dev *dev, struct ib_umem *umem,
> >       size_t max_pgs_create_cmd;
> >       struct gdma_context *gc;
> >       size_t num_pages_total;
> > -     struct gdma_dev *mdev;
> >       unsigned long page_sz;
> >       unsigned int tail =3D 0;
> >       u64 *page_addr_list;
> >       void *request_buf;
> >       int err;
> >
> > -     mdev =3D dev->gdma_dev;
> > -     gc =3D mdev->gdma_context;
> > +     gc =3D mdev_to_gc(dev);
> >       hwc =3D gc->hwc.driver_data;
> >
> >       /* Hardware requires dma region to align to chosen page size */
> > @@ -426,10 +416,8 @@ int mana_ib_gd_create_dma_region(struct
> > mana_ib_dev *dev, struct ib_umem *umem,
> >
> >  int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev, u64
> > gdma_region)  {
> > -     struct gdma_dev *mdev =3D dev->gdma_dev;
> > -     struct gdma_context *gc;
> > +     struct gdma_context *gc =3D mdev_to_gc(dev);
> >
> > -     gc =3D mdev->gdma_context;
> >       ibdev_dbg(&dev->ib_dev, "destroy dma region 0x%llx\n",
> > gdma_region);
> >
> >       return mana_gd_destroy_dma_region(gc, gdma_region); @@ -447,7
> > +435,7 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct
> vm_area_struct *vma)
> >       int ret;
> >
> >       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> > -     gc =3D mdev->gdma_dev->gdma_context;
> > +     gc =3D mdev_to_gc(mdev);
> >
> >       if (vma->vm_pgoff !=3D 0) {
> >               ibdev_dbg(ibdev, "Unexpected vm_pgoff %lu\n",
> > vma->vm_pgoff); @@ -531,7 +519,7 @@ int
> mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
> >       req.hdr.resp.msg_version =3D GDMA_MESSAGE_V3;
> >       req.hdr.dev_id =3D dev->gdma_dev->dev_id;
> >
> > -     err =3D mana_gd_send_request(dev->gdma_dev->gdma_context, sizeof(=
req),
> > +     err =3D mana_gd_send_request(mdev_to_gc(dev), sizeof(req),
> >                                  &req, sizeof(resp), &resp);
> >
> >       if (err) {
> > diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> > b/drivers/infiniband/hw/mana/mana_ib.h
> > index 6bdc0f549..6b15b2ab5 100644
> > --- a/drivers/infiniband/hw/mana/mana_ib.h
> > +++ b/drivers/infiniband/hw/mana/mana_ib.h
> > @@ -142,6 +142,22 @@ struct mana_ib_query_adapter_caps_resp {
> >       u32 max_inline_data_size;
> >  }; /* HW Data */
> >
> > +static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev
> > +*mdev) {
> > +     return mdev->gdma_dev->gdma_context; }
> > +
> > +static inline struct net_device *mana_ib_get_netdev(struct ib_device
> > +*ibdev, u32 port) {
> > +     struct mana_ib_dev *mdev =3D container_of(ibdev, struct mana_ib_d=
ev,
> ib_dev);
> > +     struct gdma_context *gc =3D mdev_to_gc(mdev);
> > +     struct mana_context *mc =3D gc->mana.driver_data;
> > +
> > +     if (port < 1 || port > mc->num_ports)
> > +             return NULL;
> > +     return mc->ports[port - 1];
> > +}
> > +
> >  int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_um=
em
> *umem,
> >                                mana_handle_t *gdma_region);
> >
> > @@ -188,6 +204,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const str=
uct
> ib_cq_init_attr *attr,
> >                     struct ib_udata *udata);
> >
> >  int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
> > +int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq
> > +*cq);
> >
> >  int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> > int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> > diff --git a/drivers/infiniband/hw/mana/mr.c
> > b/drivers/infiniband/hw/mana/mr.c index 351207c60..ee4d4f834 100644
> > --- a/drivers/infiniband/hw/mana/mr.c
> > +++ b/drivers/infiniband/hw/mana/mr.c
> > @@ -30,12 +30,9 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev
> > *dev, struct mana_ib_mr *mr,  {
> >       struct gdma_create_mr_response resp =3D {};
> >       struct gdma_create_mr_request req =3D {};
> > -     struct gdma_dev *mdev =3D dev->gdma_dev;
> > -     struct gdma_context *gc;
> > +     struct gdma_context *gc =3D mdev_to_gc(dev);
> >       int err;
> >
> > -     gc =3D mdev->gdma_context;
> > -
> >       mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req),
> >                            sizeof(resp));
> >       req.pd_handle =3D mr_params->pd_handle; @@ -77,12 +74,9 @@ static
> > int mana_ib_gd_destroy_mr(struct mana_ib_dev *dev, u64 mr_handle)  {
> >       struct gdma_destroy_mr_response resp =3D {};
> >       struct gdma_destroy_mr_request req =3D {};
> > -     struct gdma_dev *mdev =3D dev->gdma_dev;
> > -     struct gdma_context *gc;
> > +     struct gdma_context *gc =3D mdev_to_gc(dev);
> >       int err;
> >
> > -     gc =3D mdev->gdma_context;
> > -
> >       mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_MR, sizeof(req),
> >                            sizeof(resp));
> >
> > @@ -164,8 +158,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd
> *ibpd, u64 start, u64 length,
> >       return &mr->ibmr;
> >
> >  err_dma_region:
> > -     mana_gd_destroy_dma_region(dev->gdma_dev->gdma_context,
> > -                                dma_region_handle);
> > +     mana_gd_destroy_dma_region(mdev_to_gc(dev), dma_region_handle);
> >
> >  err_umem:
> >       ib_umem_release(mr->umem);
> > diff --git a/drivers/infiniband/hw/mana/qp.c
> > b/drivers/infiniband/hw/mana/qp.c index e6d063d45..e889c798f 100644
> > --- a/drivers/infiniband/hw/mana/qp.c
> > +++ b/drivers/infiniband/hw/mana/qp.c
> > @@ -17,12 +17,10 @@ static int mana_ib_cfg_vport_steering(struct
> mana_ib_dev *dev,
> >       struct mana_cfg_rx_steer_resp resp =3D {};
> >       mana_handle_t *req_indir_tab;
> >       struct gdma_context *gc;
> > -     struct gdma_dev *mdev;
> >       u32 req_buf_size;
> >       int i, err;
> >
> > -     gc =3D dev->gdma_dev->gdma_context;
> > -     mdev =3D &gc->mana;
> > +     gc =3D mdev_to_gc(dev);
> >
> >       req_buf_size =3D
> >               sizeof(*req) + sizeof(mana_handle_t) *
> > MANA_INDIRECT_TABLE_SIZE; @@ -39,7 +37,7 @@ static int
> mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
> >       req->rx_enable =3D 1;
> >       req->update_default_rxobj =3D 1;
> >       req->default_rxobj =3D default_rxobj;
> > -     req->hdr.dev_id =3D mdev->dev_id;
> > +     req->hdr.dev_id =3D gc->mana.dev_id;
> >
> >       /* If there are more than 1 entries in indirection table, enable =
RSS */
> >       if (log_ind_tbl_size)
> > @@ -106,7 +104,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp=
,
> struct ib_pd *pd,
> >       struct gdma_queue **gdma_cq_allocated;
> >       mana_handle_t *mana_ind_table;
> >       struct mana_port_context *mpc;
> > -     struct gdma_queue *gdma_cq;
> >       unsigned int ind_tbl_size;
> >       struct net_device *ndev;
> >       struct mana_ib_cq *cq;
> > @@ -231,19 +228,11 @@ static int mana_ib_create_qp_rss(struct ib_qp *ib=
qp,
> struct ib_pd *pd,
> >               mana_ind_table[i] =3D wq->rx_object;
> >
> >               /* Create CQ table entry */
> > -             WARN_ON(gc->cq_table[cq->id]);
> > -             gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> > -             if (!gdma_cq) {
> > -                     ret =3D -ENOMEM;
> > +             ret =3D mana_ib_install_cq_cb(mdev, cq);
> > +             if (!ret)
> >                       goto fail;
> > -             }
> > -             gdma_cq_allocated[i] =3D gdma_cq;
> >
> > -             gdma_cq->cq.context =3D cq;
> > -             gdma_cq->type =3D GDMA_CQ;
> > -             gdma_cq->cq.callback =3D mana_ib_cq_handler;
> > -             gdma_cq->id =3D cq->id;
> > -             gc->cq_table[cq->id] =3D gdma_cq;
> > +             gdma_cq_allocated[i] =3D gc->cq_table[cq->id];
> >       }
> >       resp.num_entries =3D i;
> >
> > @@ -409,18 +398,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibq=
p,
> struct ib_pd *ibpd,
> >       send_cq->id =3D cq_spec.queue_index;
> >
> >       /* Create CQ table entry */
> > -     WARN_ON(gc->cq_table[send_cq->id]);
> > -     gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> > -     if (!gdma_cq) {
> > -             err =3D -ENOMEM;
> > +     err =3D mana_ib_install_cq_cb(mdev, send_cq);
> > +     if (err)
> >               goto err_destroy_wq_obj;
> > -     }
> > -
> > -     gdma_cq->cq.context =3D send_cq;
> > -     gdma_cq->type =3D GDMA_CQ;
> > -     gdma_cq->cq.callback =3D mana_ib_cq_handler;
> > -     gdma_cq->id =3D send_cq->id;
> > -     gc->cq_table[send_cq->id] =3D gdma_cq;
> >
> >       ibdev_dbg(&mdev->ib_dev,
> >                 "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n",
> > err, @@ -442,7 +422,7 @@ static int mana_ib_create_qp_raw(struct ib_qp
> > *ibqp, struct ib_pd *ibpd,
> >
> >  err_release_gdma_cq:
> >       kfree(gdma_cq);
> > -     gd->gdma_context->cq_table[send_cq->id] =3D NULL;
> > +     gc->cq_table[send_cq->id] =3D NULL;
> >
> >  err_destroy_wq_obj:
> >       mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
> >
> > base-commit: d24b923f1d696ddacb09f0f2d1b1f4f045cfe65e
> > prerequisite-patch-id: 1b5d35ba40b675d080bfbe6a0e73b0dd163f4a03
> > --
> > 2.43.0
> >

