Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814E42C1C24
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 04:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgKXDfB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 22:35:01 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:7549 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgKXDfA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Nov 2020 22:35:00 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc7f620000>; Tue, 24 Nov 2020 11:34:58 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Nov
 2020 03:34:58 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 24 Nov 2020 03:34:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntvYUh3jSzLCQmlyRxxIh1Etly6PF1t6v1ugTbkLA9oN0dPkVyqaeKC8oy/l7zTwqded541Gw8My7jzizWj60e16/R82Vx3PsEja6pz+76X6v3kocUulvJ0GWM9bVZ5J8XqG8LJFXfAzznKkELGMfT5ui1sPF9wQ/YktnqQSZ7Yud5ihu4R/QTeesMiYcNXUi40ctinjjInsQ3R0j2UY7fVPpX68pbWwHr3Jw1c2Ns6ihnvy+iese8jVAS11mP3vNC2wPz9CCq4gBrMGETv4nMyZh0d+XeXjs11zOJbujXMfarBV6H4yrs66Ns41DEZ6PURowh/YS13HRV6r8KRtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bdh3FrIpYFWHfjB+rat2MvHdKwawNrKp9iAE/SMU3ZQ=;
 b=LcZd2e0dcBV0Ik8X4yq9T/F5vpZgY+biBK0CRNLq7YEHhbCgnSZeTKvgPyDWnw3M580iVccymX/4NxNE7HV0XpWq593aV2OPhNizM3oFRWPXlO11/sSw/fMVFS7zbWT5wMICrg9KrXpcxLkpEpY94/b88UKd6gPLLXyDZo+hi8COSFwPSV6JyhBKk3gIENp//JE84u9zNXeLoOatnbrTjchy0+DHo3AY+i9ROVglKZHSzJnbllSsrih30RzY+KlAfN+gx2Q88tsDfd+xwiEgodt36j50Foi0bTXazXRlBtZPT/NxhYvav4lMXdJMVQR7dJV1JYUM/ru6NF+eDAubaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB3224.namprd12.prod.outlook.com (2603:10b6:a03:137::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 03:34:56 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::a1d2:bfae:116c:2f24]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::a1d2:bfae:116c:2f24%5]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 03:34:56 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next] IB/mlx5: Use ib_dma APIs instead of open access
 to parent device
Thread-Topic: [PATCH rdma-next] IB/mlx5: Use ib_dma APIs instead of open
 access to parent device
Thread-Index: AQHWwXIp74xnEXOGsUyQf4FUiMLlXqnVvtaAgADi35A=
Date:   Tue, 24 Nov 2020 03:34:56 +0000
Message-ID: <BY5PR12MB43226D6014DAABFD08BFBEABDCFB0@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201123082400.351371-1-leon@kernel.org>
 <20201123135931.GM917484@nvidia.com>
In-Reply-To: <20201123135931.GM917484@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [49.207.223.255]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d008c1c-3165-4db4-1e61-08d89029e9b7
x-ms-traffictypediagnostic: BYAPR12MB3224:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3224B513147DA68B6A306767DCFB0@BYAPR12MB3224.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VX6HkxUmvNpC7SaM7MVn/EoDacaw/qYYe3ddWFes7zqG8b0LUOHIElG9EamCLpFCrQG/kXfrGw/yuvtFdai8RHXH36TZaqEgl2pKsi8BjC73lNAx1mIv1fZpZ7QQZeWUhcxe+jwXlk7BVw1YFMhF2+cwcwZPgG3WKLb/np1WIOns/e0UX8xEtZrbaWBM/ccO3ZugsjtkSOQbCPdptgoku6sg1tptQA8Tgov2iyoiVcjT4dk37MCNYl+6KWtp9aNs425wymBK7pblSII2Wm493c4ifC+AVpK+/isnYgvW+pbt5UMFbbgbK9zxjrsgAFJkEzD7BoMquvc3PxJ0FYm1eQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(110136005)(9686003)(5660300002)(55016002)(316002)(4326008)(83380400001)(54906003)(33656002)(478600001)(55236004)(186003)(71200400001)(76116006)(66946007)(64756008)(6506007)(66556008)(66476007)(86362001)(66446008)(26005)(8676002)(8936002)(7696005)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ZKbGkzyD+Dn0HL7t0frPRs/IIDhBm4cAdfjO+njVUh5pHMXIe3sZIUh15dbSJ4Wbtp9vylglkWCS49cgyHQ2iEbPV3y6LLrJqR8SsE3m3i1ZxHfacXxWqEX4pRrDp6KkI5UulXOUEx/aMxRaChq45e5qcz2n9w61m3SJX9J7ZxUnQNCslEU6CQ83Ks8DR3W7wwmspP/FOeen+PVT0ZXNs1X055gZ/mR++Zmg2i6SY61bEtanUm3l3gmpwUm5lZLFEh6CTvjnj7evsI3SA4jU4YtQT9Zt16PzIwpULhnz5fZPcDZBUw0m0E1Rd7P9aMolyqluB1rjLjFO+GbpuC5+06vRCXC6RjrbfcOZqTF6AXSQG0J1PjeZHU7/vIcpUuDUUlyzFtI8HEo1PVcFioFkWgwsA43QgQDoMjw8ZJjXGISiyV8ASy0Afw8QL24/Z26G2xa1eeMFffUkGXSp/C8xm97Z1kUTu1Hd+n03CT5MGbEJEH7PQb1pp/M8nt4Q9Q4oBE3Nab6eJlEFz2nu2jeeVFnq5f/H7ZS2bvkFKa78tazhoTGpuz0m3F55a0dQ7WyEkD1/zuKE0nTdI4htn7Zz+mfhnbDqpYr0Jvcp0mOwvHepT6TTqgNDgEB2Sq+Fr5kAjOu9DfNMG0qDCCDVqX7y5MA/rJl4h0QuT81Ig9WdvWsvJLwUYfDK5AzKUeF8nv5H0kg1uAJ+OSa9hyeV7F0wA/GaAFvQxU0gKqS3l27uokRrYXuts8m3IWqprykY2n7DttZlwZM1FbwjTjbMiMJog0QAMqHgmseicjK75rJYkBbq4Yap1iES9/feQD3K45hmG0JRTta1zrXSAybyuRlBb2qxbwa3cLQsvxENvt52CxM1xiwLqWlrbR3nhF/mrymNYpfOZ0ODo3Sh+32iYncS7w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d008c1c-3165-4db4-1e61-08d89029e9b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 03:34:56.0652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Opel4F66gUXMfO3GBBfGHBwfZJd/tM34pOL9OQy64NP81fQxJL2kFkKLQ89SSFyrYmomy87uhB+Bb4qmriwyFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3224
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606188898; bh=Bdh3FrIpYFWHfjB+rat2MvHdKwawNrKp9iAE/SMU3ZQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=EO68/Bz4Ttg0AhFm/baOQIbQui3B4yd+cFpxPHJEkqVzWEbEmo8rH5Ek6yl2l9oZ2
         YWTpOzF7+VE/YUAL6F/NfxDPiqLsh5qOnbrUIHx/kBSx5jvX2vQYRi2ZAtO+Mu06BQ
         q96gq4Ob/7BiwghW2FGv5NbFb5g/aBmtPJnfVN9OW3TNxur1dIbhjsfV0paZc2MJZE
         Zt1i8JadVoVQHqdiXAwhuOQ1v50MPIHBRZCAE5HLSCtCSVz8EMl/3QNuhNzufj5YAZ
         3WNGqs1NJD0deEhlUgJIYEsu4hmaNCgCuhCleM2A7l1j7dAZcF+1JggkYYASGSkLsn
         Xsi0RVyL6zqHA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, November 23, 2020 7:30 PM
>=20
> On Mon, Nov 23, 2020 at 10:24:00AM +0200, Leon Romanovsky wrote:
> > From: Parav Pandit <parav@nvidia.com>
> >
> > DMA operation of the IB device is done using ib_device->dma_device.
> > This is well abstracted using ib_dma APIs.
> >
> > Hence, instead of doing open access to parent device, use IB core
> > provided dma mapping APIs.
>=20
> Why?
>=20
> The ib DMA APIs are for people using verbs, they are only needed to pack =
things
> into the ib_sge
>=20
> If you are inside a driver, not using the verbs API, or not using ib_sge,=
 then you
> should not be using the ib_dma API
>
Thanks for clarifying this. Using ib_dma apis make the code clear for dma d=
evice access clear and explicit.
=20
> It is an abberation, we should minimize its use.
Alright. In that case will use the pci_dev as mlx5 driver internally has th=
e knowledge of it and avoid using ib_dma APIs.

>=20
> >  /*
> > - * We can't use an array for xlt_emergency_page because
> > dma_map_single doesn't
> > + * We can't use an array for xlt_emergency_page because
> > + ib_dma_map_single doesn't
> >   * work on kernel modules memory
> >   */
> >  void *xlt_emergency_page;
> > @@ -1081,7 +1081,6 @@ static void *mlx5_ib_create_xlt_wr(struct
> mlx5_ib_mr *mr,
> >  				   unsigned int flags)
> >  {
> >  	struct mlx5_ib_dev *dev =3D mr->dev;
> > -	struct device *ddev =3D dev->ib_dev.dev.parent;
>=20
> Though this looks wrong, it should be dev->mdev->pdev.dev
>=20
> ie it is always OK to use a PCI device with the normal DMA API
>
Ok. will send v2 that uses pci device with existing DMA APIs.
