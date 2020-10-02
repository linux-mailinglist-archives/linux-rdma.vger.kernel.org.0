Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D896E2811B8
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 13:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387798AbgJBL4H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 07:56:07 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6148 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387783AbgJBL4H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Oct 2020 07:56:07 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7715220003>; Fri, 02 Oct 2020 04:55:14 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 11:56:05 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 2 Oct 2020 11:56:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9GFWbaa5Yxknkaz2EQWeOC8/Y47LiuvQ+BLm7x45iYw2GhpnlXspClVlwzK8bCJHlbfcodXIBPlPxwJMy3FQ9miO8UpORGGbD/yUcXujXDqlANRljJ0vlelUgFjZNP7jcpPv5fBvVlHsNWA83xl30/Car1YJc1oUumpjX6cG7u837KlP7kDR18sc439iK05FRu+Tl7upbg8hthZmhSAfKBNnC92OE/0e1JCLEEgV3AjE6RKEVG/BsffZwRXIFnAeZQqEM/zmXXWlt1u1cJTLF5f6FaisnW6Ip5p/aMQmp3N0EeltR+TKSLJeo78IAhlnqfm6zl1HGBz6vGXgJ+aHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWhiyAOwUoGSc1FPIUb5uot3cltvuiRMSnC2Yl7siNU=;
 b=DF43+EIpXBYlz3x3E3DwtaRS/ndkI58TVtXp7viMigHeX8l0wwEU4oXFuSMx3krURRUMDvRwrPZUTDbUTQFBHBUms5Gltflkcfd5wH2DC4xQmcpwatVKAgFWkEH1uXodkOzybcH8ydUhksRNQ2r/r6vTEi452sWWlehuztKjaHIVdqlf1Y6lrb7Ldo4J7UZakeM1Of/QAMI2kZz3HiNz8+JJeWR+xrS/jq3t+viJxReeXG6wLPczCx/jpipELJsynlcLB4sveN+4koWctIDCqMRxbmIXvzCrqoIIJEq9z4dyMidOAS6M7a+a1qjI5hSCpp2ETXxZNkC6YrrJ8G3I4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB3429.namprd12.prod.outlook.com (2603:10b6:a03:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Fri, 2 Oct
 2020 11:56:02 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105%6]) with mapi id 15.20.3433.038; Fri, 2 Oct 2020
 11:56:02 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "Ertman, David M" <david.m.ertman@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/6] Add ancillary bus support
Thread-Topic: [PATCH 1/6] Add ancillary bus support
Thread-Index: AQHWl7C1MSqUSmitS0u6NuJRdy7sUamCa2qAgACTjYCAAAWKgIAABlCQgAAY64CAAKN2UIAAEZaAgAAjU/CAAC69AIAAAg4QgAAG2ICAAAEzUA==
Date:   Fri, 2 Oct 2020 11:56:02 +0000
Message-ID: <BY5PR12MB43224DEDE3F8D10BB42605CADC310@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201001083229.GV3094@unreal>
 <DM6PR11MB2841DEF5C090BC8D830DEC52DD300@DM6PR11MB2841.namprd11.prod.outlook.com>
 <20201001174025.GW3094@unreal>
 <BY5PR12MB4322C7955974B4DCFC8078EFDC300@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201001193211.GX3094@unreal>
 <BY5PR12MB4322EDDDF036BB58DE3A1F7BDC310@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201002062011.GY3094@unreal>
 <BY5PR12MB4322C2E2E726DCF700802104DC310@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201002111354.GZ3094@unreal>
 <BY5PR12MB432201FCEA970DA28AB06166DC310@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201002114545.GB3094@unreal>
In-Reply-To: <20201002114545.GB3094@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.172.151.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd4ec71b-f905-4d37-88b0-08d866ca22f8
x-ms-traffictypediagnostic: BYAPR12MB3429:
x-microsoft-antispam-prvs: <BYAPR12MB342985C72A2080D65DD45EB1DC310@BYAPR12MB3429.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EILiX/jxUQ2JhyyFtsNiN6qNNUaf/Hk3V5qIeeX+/Soiv0xktZ4LGufaeF20t1/k6P3vNph2v7sthnp7uATATCbRMMLtmEhYfRaFFPCx2nAPe+BDZyS6w1rw0vIkERg9FaFsM+Pk5BFPgkvm1CDcMPdUVoXFB3sUQRXxGHo+THLYo2Knm3TG16euA+NSa4/Dx3d7mHdCzuz/pmdD29ohQR47GTI1ABiVXEg1FqflGfaJPuMQxOaZRe3IrLOqABbxGlYFQkLR0+3somibKT+BAl0mMu+N0tMquJ+LvYHTdKtHbRhQd3Qzo0I1rk7OZ+zl4klBKhi586VGCZke6OVz7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(54906003)(8936002)(6916009)(478600001)(33656002)(4326008)(7696005)(55016002)(5660300002)(26005)(9686003)(55236004)(186003)(6506007)(66446008)(8676002)(64756008)(66476007)(66946007)(76116006)(86362001)(66556008)(2906002)(71200400001)(316002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Bgz5zBbn/DT1Jv34ah01clmDYsg+dJ+PfnqOPZ80uAUR+FEcbVohYSAcfztV2ZgVog14PVqEPBrtLXzIexuqgF9WOZlPNOZ8chUtrZ/O0wyS0/DfRG5yONfTHzdm+WTwOEf17RqI5uan7oB08h/5EXE+dJMlyF6qnJY425qvHXr7DGpppedGBJnzCUVW2foUe1LS6rg6gjgxjsM7/GnVjC0WaMGw9P4WDawwZv2wz2KHBX91M7twz4pdWRxlJyS7ZPnC5L9GQCPKB7TE2np2TjxgTbg9ITe3mTDP7oplJSuWTK2FIu6sa4VL8oiX2pXywr00OX/jrU3ka5NNLqX6dhvtO55uwLiwLxMNgLkrnaSdyEhMYsWjs3xumPL0ZCI4MHmUloGNI4pwzoFRuER4Q9Z2dNhAIM492NZm5jm/RZZ49u2dy7OAFaCAqs7PwxNaWn1qUOVRdjfudWxaULp7pqR+s6Hg2jHUWkql4Fw/O69bljoktlx+8UJp7Dz6ipQpJWOj4C6qZgQXlqr4qxC1IzT9Ok+fOCzhhEOXSAcHInOWXf5xOdS9ylYuBMkt66JWX4RfnhBeG2FEytwFFxS9T1zyXUOSMk7+nmgty350HnD79WKdwWQyh31XdyaS/rfNJrqr4ZH3XIEJbIokGhowFw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4ec71b-f905-4d37-88b0-08d866ca22f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 11:56:02.7651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8l2wICOkH/1SQ0EYdpZGziDI1kl0Fv8kUBq5p0iHB2Yj6kvmveS4nVo7fra5HT+vHBYy1FAYK7/urHra3/HJ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3429
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601639714; bh=tWhiyAOwUoGSc1FPIUb5uot3cltvuiRMSnC2Yl7siNU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
         x-microsoft-antispam:x-microsoft-antispam-message-info:
         x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
         x-ms-exchange-transport-forked:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=XNXT4+UWpPm+DPKIxIgGUhf30dFvhgvaOwLujEotPoLCei4VItBH7fDrs/9SERh4O
         IrG4nmvX3CYL2BmEzX8n9uLXKiCjzgnRWlVvktH4/XMKJHWb6fFrLG1vcNtNXwUled
         UVKjix5mCQak2mO/Quy39jEu1iG70L8XChR6eXdtVkXZIBZuT/yVA9+2NzLlyONEZq
         ZfbYRTTaLcbZOaX8IWcErJbCtqOmlcH2VdXHeFKN4Nh2Fhah3dlRmglGgxUWOKEwy1
         mEkoNw7Bxc/JEzakavT+Kyx4yTGZf4zJ4VKNFru/9IB3SaRXZ0JVe9pDZATFBySlGt
         Xnwhd1CLHevDQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Leon Romanovsky <leon@kernel.org>
> Sent: Friday, October 2, 2020 5:16 PM
>=20
> On Fri, Oct 02, 2020 at 11:27:43AM +0000, Parav Pandit wrote:
> >
> >
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Friday, October 2, 2020 4:44 PM
> >
> > [..]
> > > > > ../../../devices/pci0000:00/0000:00:0b.0/mlx5_core.eth.2
> > > > This gives you the ability to not load the netdevice and rdma
> > > > device of a VF
> > > and only load the vdpa device.
> > > > These are real use case that users have asked for.
> > > > In use case one, they are only interested in rdma device.
> > > > In second use case only vdpa device.
> > > > How shall one achieve that without spinning of the device for each
> class?
> > >
> > > Why will it be different if ancillary device is small PCI core?
> > > If you want RDMA, you will use specific ancillary driver that
> > > connects to that small PCI logic.
> >
> > I didn't follow, wwhat is PCI core and PCI logic in this context?
>=20
> mlx5_core is PCI core/logic - ancillary device mlx5_ib/mlx5_en/mlx5_vdpa =
-
> ancillary drivers
>=20
> >
> > Not sure if you understood the use case.
> > Let me try again.
> > Let say there are 4 VFs enabled.
> > User would not like to create netdev for 3 VFs (0 to 2) ; user only wan=
ts
> rdma device for these VFs 0 to 2.
> > User wants only vdpa device for 4th VF.
> > User doesn't want to create rdma device and netdevice for the 4th VF.
> > How one shall achieve this?
>=20
> It depends on how N-to-1 bus will be implemented. For example, devlink
> already allows to disable RoCE on specific function, nothing prohibits to
> extend it to support other classes.

Sure. Please go through the our internal RFC dated 7/7/20 with subject "dev=
link device params to disable rdma, netdev" which exactly achieves similar.

And recent 3rd internal RFC "devlink to set driver parameters" discussion w=
ith Eli, Jason, Jiri and others that describes to have one ancillary_device=
_per_class instead of devlink.

Lets discuss it offline as we have multiple proposals floating.

>=20
> > It is easily achievable with current ancillary device instantiation per=
 class
> proposal.
>=20
> It is byproduct of 1-to-1 connection and not specific design decision.
>=20
> >
> > > Being nice to the users and provide clean abstraction are important g=
oals
> too.
> > Which part of this makes not_nice_to_users and what is not abstracted.
> > I lost you.
>=20
> Your use case perfectly presented not_nice_to_users thing. Users are
> interested to work on functions (VF/PF/SF) and configure them without
> need to dig into the sysfs directories to connect ancillary classes and t=
heir
> indexes to the real functions.
>=20
> Thanks
