Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696BE280D11
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 07:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgJBF3c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 01:29:32 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11261 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgJBF3b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Oct 2020 01:29:31 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f76ba540000>; Thu, 01 Oct 2020 22:27:48 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 05:29:29 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.56) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 2 Oct 2020 05:29:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrGl3Wo0UQlNqvPpX076Z2v4/r9YFxbAcwWzqkF7l9LkwcXjekxDdDwt6Z0M04Ds+HBgFhKv/SseYIMvdBjLHcvyXLi9mRlKTHwgoFsHiMU+mN1VkT6kPj8B3y0Lxsivneyl9T/Ci1yBRWosqj9a9Oqmfc+GSvw6of6a1Pa8ZMI366crizAyGFyn0sJIHRO+X8pEg5QlvTGm1ds2YHS61UqxmH6ZAqgmLN2a9J/XSlj01uAxU5lJoKadWwnW6wL8prYwV/GJL7BwzwjaA6avzrnBLtP0CLn6pYyh6paArvXWj5ZBVw/lTBa1I4ZmvBobleyfhS84LD07Qa7QuhdZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsKLDjYeCWUdy/Xk7rDPFAyFWSArYZmY9J9u2fPYeNo=;
 b=flDvvmo2m9LYQ5Wjk8KHX3EG1zrIKsjiNQgFB7zqM+3jdByDU7sXBsaWRaS5bsRfF4/UAdHovLF6oDvQVxVMamD7u7LT/mUkgGpAsU/tPi6vSWHdhTxyOpqZ9fapGv1UfcECEMvK7zJk4VBkmArpaql6NCa+rfWZ4/m3YUDMBL/B3WALVFaJY/8xdZYhqFQjrlhpSnBZNo4Y6imS9LqSNff5oMjty1EM3h2Zn3Mrd76ZXlt00odLfrBWmXgDXkC6SeLXv+mmYrOlM9PKzCfiAEtIh4wCntYU4i6JjJhHN6rtxic3mqKD9yZ01CYiQWBTFRdawMPPj6/J5u6LOlY0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB3080.namprd12.prod.outlook.com (2603:10b6:a03:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 2 Oct
 2020 05:29:26 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105%6]) with mapi id 15.20.3433.038; Fri, 2 Oct 2020
 05:29:26 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "Ertman, David M" <david.m.ertman@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/6] Add ancillary bus support
Thread-Topic: [PATCH 1/6] Add ancillary bus support
Thread-Index: AQHWl7C1MSqUSmitS0u6NuJRdy7sUamCa2qAgACTjYCAAAWKgIAABlCQgAAY64CAAKN2UA==
Date:   Fri, 2 Oct 2020 05:29:26 +0000
Message-ID: <BY5PR12MB4322EDDDF036BB58DE3A1F7BDC310@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201001050534.890666-1-david.m.ertman@intel.com>
 <20201001050534.890666-2-david.m.ertman@intel.com>
 <20201001083229.GV3094@unreal>
 <DM6PR11MB2841DEF5C090BC8D830DEC52DD300@DM6PR11MB2841.namprd11.prod.outlook.com>
 <20201001174025.GW3094@unreal>
 <BY5PR12MB4322C7955974B4DCFC8078EFDC300@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201001193211.GX3094@unreal>
In-Reply-To: <20201001193211.GX3094@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.172.151.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a5916ef-22c2-47e5-ff4d-08d8669420e8
x-ms-traffictypediagnostic: BYAPR12MB3080:
x-microsoft-antispam-prvs: <BYAPR12MB308063EA4220E1B215F08C6DDC310@BYAPR12MB3080.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Nfn+mP9cNNnuRh3Aj2k5XB4lv7DjiaJNWpL5VuWsxa26kNXNxmaLO1QPRUbeM/1tipdxJiQ2l4mXu9zSPndleimOzaToOqFwvzoAujYgM9LZY6Kg3vle1HoosJOQ9Ppx5MCA5QslR+s9Uj4wmkUWYGf03plfdq4MR0XXQrLmE/QuN/n82I5uuqOfYWa7rA3j5U0hDNdR8xLYrOJL2Dj5ss1w3NzK/pAPPtcLr+oaUCKM5yUcAQiyXUQrSmXsTs+7HzpjebujrfKW0ZoVB+uoqKUoXPUA2BgXm8/P6b01H2lUvMFPnousDmROYysfV0jzq69OhV247sbOJEgPF33oGAapamcc/lfnqsvm9zxXrUUZfiubcAY0N7DCBxdjIZkPuzYXq2G2qseelQhYd9U+V0suDSRgKsLIR9M0Pogg/o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(64756008)(186003)(7696005)(316002)(6506007)(66476007)(66556008)(66446008)(54906003)(66946007)(2906002)(9686003)(71200400001)(55236004)(26005)(86362001)(55016002)(4326008)(8936002)(478600001)(76116006)(83380400001)(33656002)(8676002)(52536014)(5660300002)(6916009)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: sgaP2IYh3tAMLmRIDcVXDKz02X45gilw+/YlRWE7ro84+ihaF3xxn3gADXjfk/HjsBjHBXFhQtjw4PIn7KjUGIlXEffVgQ/wfjnuEZ1Ie23RFZD3NgeTZUUDLfGWSneNArlF33mzjxrMVZ7gV6VPU2G3nr7FJYAQfT+NKS0wz9WHBK0AQ3EAcSVfLBXUuhBgUnLpwbA3OKhpm4zIdMQ8+FW1Ve+QJVxMRDsIDEka8mGa7chgHFUtEMn5021b6QqgAQTIvFDhqrhJO02YAa0rRv38dbQdZiwLdQMRYK+hfs0tru7X8tp8sOATiu1hVT+3PnnNTVjPmnbrKUO3SsLGHCODV67IrjKPfKh8s8j8E+KPCcQk2aSQZK/fArCUlGNQ/7hmhj4A7wrrubI+DJv0VJEl+n0ToeIbh6zu0jYexjnCXAiUgl0vl1urPu/SE5Nruoxgl2akrxTs2kQhLK10EwhZGegYamKZQeQb3hvn0v6bIL9MOQ2Hs5VFGEmUPJ9DE4UpjqFjm5afEX80pxuZLQG2n9kMl+7rniqLTjgYqIrn1h9I7t1VhR5Zb6y5Y5nNupRCFrUPbPj05xKL6HlvjU3VFUEOZ5o3+5fsDMRx9H2f64Y2wg97aUgZu8aFzcsAYceMKVt8xgusNj4XGG1fbQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5916ef-22c2-47e5-ff4d-08d8669420e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 05:29:26.5014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3+URQnvw6IF0Cu1/Fzu7ZN6mnHbPccMc07vpXP7E2e0onijpNQqrA0OZhkZ5AiHpkvd3YAKMfiNidQ9GDu3rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3080
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601616468; bh=LsKLDjYeCWUdy/Xk7rDPFAyFWSArYZmY9J9u2fPYeNo=;
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
        b=Oe6PnEcFY/pyLANFw0oiG4OdYMlIovg0r9B0endjfJcyIeC7w2gkMeKaNzQ5kLBb7
         SYn8Y2HmedeTsEJ1NjkYoXIJmEbYheR6zNnQLDXlzH2bN/IvTzdljhrjJ3A6d0tJYt
         BduD4vdSBP19Z/PwoSMI7IB231377Y039MSZkv2zNV7wE8gxwi31Y01pAUBrOhhTxa
         VUzow3RVFv8VMDqCjxSxang2xh1mpCPNKcjZSDAi01w14AzN0Cs0GkM991x8xkoYhh
         t/blA9ROyHa/4tRW0OLw//ok3GtGfz14EuBHv+xiyQDE4MlDN81jY8SFEFgBFRe5es
         vytD8ZozhdYnw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Leon Romanovsky <leon@kernel.org>
> Sent: Friday, October 2, 2020 1:02 AM

> > > > > > +Registering an ancillary_device is a two-step process.  First
> > > > > > +you must call ancillary_device_initialize(), which will check
> > > > > > +several aspects of the ancillary_device struct and perform a
> > > > > > +device_initialize().  After this step completes, any error
> > > > > > +state must have a call to put_device() in its
> > > > > resolution
> > > > > > +path.  The second step in registering an ancillary_device is
> > > > > > +to perform a
> > > > > call
> > > > > > +to ancillary_device_add(), which will set the name of the
> > > > > > +device and add
> > > > > the
> > > > > > +device to the bus.
> > > > > > +
> > > > > > +To unregister an ancillary_device, just a call to
> > > > > ancillary_device_unregister()
> > > > > > +is used.  This will perform both a device_del() and a put_devi=
ce().
> > > > >
> > > > > Why did you chose ancillary_device_initialize() and not
> > > > > ancillary_device_register() to be paired with
> > > ancillary_device_unregister()?
> > > > >
> > > > > Thanks
> > > >
> > > > We originally had a single call to ancillary_device_register()
> > > > that paired with unregister, but there was an ask to separate the
> > > > register into an initialize and add to make the error condition
> > > > unwind more
> > > compartimentalized.
> > >
> > > It is correct thing to separate, but I would expect:
> > > ancillary_device_register()
> > > ancillary_device_add()
> > >
> > device_initialize(), device_add() and device_unregister() is the patter=
n widely
> followed in the core.
>=20
> It doesn't mean that I need to agree with that, right?
>
Right. May be I misunderstood your comment where you said "I expect device_=
register() and device_add()" in response to "device_initialize() and device=
_add".
I interpreted your comment as to replace initialize() with register().
Because that is odd naming and completely out of sync from the core APIs.

A helper like below that wraps initialize() and add() is buggy, because whe=
n register() returns an error, it doesn't know if should do kfree() or put_=
device().

ancillary_device_register(adev)
{
  ret =3D ancillary_device_initialize();
  if (ret)
    return ret;

  ret =3D ancillary_device_add();
  if (ret)
    put_device(dev);
  return ret;
}

> >
> > > vs.
> > > ancillary_device_unregister()
> > >
> > > It is not a big deal, just curious.
> > >
> > > The much more big deal is that I'm required to create 1-to-1 mapping
> > > between device and driver, and I can't connect all my different
> > > modules to one xxx_core.pf.y device in N-to-1 mapping. "N"
> > > represents different protocols (IB, ETH, SCSI) and "1" is one PCI cor=
e.
> >
> > For one mlx5 (pf/vf/sf) device, there are three class erivers (ib, vdpa=
, en).
> >
> > So there should be one ida allocate per mlx5 device type.
> >
> > Static const mlx5_adev_names[MLX5_INTERFACE_PROTOCOL_MAX] =3D {
> > 	"rdma",
> > 	"eth",
> > 	"vdpa"
> > };
> >
> > Something like for current mlx5_register_device(),
>=20
> I know it and already implemented it, this is why I'm saying that it is n=
ot what I
> would expect from the implementation.
>=20
> It is wrong create mlx5_core.rdma.1 device that is equal to mlx5_core.eth=
.1 just
> to connect our mlx5_ib.ko to it, while documentation explains about creat=
ing

Ancillary bus's documentation? If so, it should be corrected.
Do you have specific text snippet to point to that should be fixed?

For purpose of matching service functionality, for each different class (ib=
, eth, vdpa) there is one ancillary device created.
What exactly is wrong here? (and why is it wrong now and not in previous ve=
rsion of the RFC?)

Do you want to create one device and 3 drivers to bind to it? If you think =
that way, may be pci core should be extended to support that, ancillary bus=
 may not be required.
But that is different solution than what is being proposed here.
Not sure I understand your comment about wrong create mlx5_core.rdma1 equal=
 to core.eth.1", because they are not equal.
To begin with, they have different id for matching service, and in future i=
t should be extended to pass 'only' needed info.
mlx5_core exposing the 'whole' mlx5_core_dev to other drivers doesn't look =
correct.

> single PCI code device and other drivers connect to it.
>=20
> Thanks
>=20
>=20
> > mlx5_register_device()
> > {
> > 	id =3D ida_alloc(0, UINT_MAX, GFP_KERNEL);
> >
> > 	for (i =3D 0; I < MLX5_INTERFACE_PROTOCOL_MAX; i++) {
> > 		adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> > 		adev.name =3D mlx5_adev_names[i];
> > 		adev.id =3D ret;
> > 		adev.dev.parent =3D mlx5_core_dev->device;
> > 		adev->coredev =3D mlx5_core_dev;
> > 		ret =3D ancillary_device_initialize(&adev);
> > 		ret =3D ancillary_device_register(adev); }
> >
> > This will create 3 ancillary devices for each PCI PF/VF/SF.
> > mlx5_core.rdma.1
> > mlx5_core.eth.1
> > mlx5_core.vdpa.1
> >
> > and mlx5_ib driver will do
> >
> > ancillary_driver_register()
> > {
> > 	For ID of mlx5_core.rdma.
> > }
> >
> > mlx5_vdpa driver does,
> >
> > ancillary_driver_register()
> > {
> > 	For ID of mlx5_core.vdpa
> > }
> >
> > This is uniform for pf/vf/sf for one or more all protocols.

