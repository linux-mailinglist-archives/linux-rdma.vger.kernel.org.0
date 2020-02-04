Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9FCD1516A5
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 08:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgBDHxi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 02:53:38 -0500
Received: from mail-db8eur05on2053.outbound.protection.outlook.com ([40.107.20.53]:6255
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbgBDHxh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 02:53:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8Eq6hVU3ogZD4DtmebAztIKqMrvPkZ1C6vl5QP9fzJuBq6Wm7/D5+Tcn+tBxsMJ3XGstCNZE8znON6+QYa2YQaS/CzUqCSW9aW/MMsz+zb1XH6EMkvkmWfoH9WZTvLzDoXnipRycR8/vM4VpwdcYnTW3th7rCbKfs72f51TEXWFT4DXI7xYyNe7mJaNeuuHAFIqUtOuLxKwNCcnJjxg773gBJsaEHQnzCZ4KbMTTuosZQod5C4J6y9iGg62G9aCC1TwKbAiWkI6yryDJ/nA3iLjEClWIbaMSJmM9s6nZkkHfG6eStupHo8fXuk6fDLzSJ5mW5K0fQlpJqBTnT/Qiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOldGgiWFxZcm0itPMPyoXUNAGM1QSqvxkA3ycpuidk=;
 b=Kp6FmXwQKjzzSZTHuSd7VsfPSWXv9aKYFel851PCMeSmeorAHxtd+0msZ3uI7RyJYQqyydrFkJPsZfndbalLZyqVrAERnQE+/ONlXexMWduOu5tf/FDtQhs9MmSo53NO4W9VWzEIAvqb+h2+Bxq7m15TYYuJd9oFyxVAcz00x/bv154PhpN6S5jYY0q0nV0HYtZdimOpU/dwvwVzhlhys5NcIrYA0+M/aSYI5su66nWarqdWzu5bbAeDLTSaJPKJwCOkfVbZxC/UYiPKtrWSqpxGSvecQ14e478HLDq1l0HLKB+rOvTbcKydur+rckFZVVzTrxbidPWEQ9YPSH6c+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOldGgiWFxZcm0itPMPyoXUNAGM1QSqvxkA3ycpuidk=;
 b=njG60+OK3mXx993AcPCM3dNtA4PqvN/fzUx3Xqg4oShgxCNsEDJskBTQjbx3UOlFXFFYP+LcSBOou6pWIzs/ey7BwMCCPkg4qp/qQWL2/rBzb/yEvI8mmyLszf83f3nf6A2hGzW11kKnKvg6KN5Uq69THstmo/nalNH0gh9lNk4=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6260.eurprd05.prod.outlook.com (20.177.41.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 07:53:35 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346%7]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 07:53:35 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: RDMA header inspection
Thread-Topic: RDMA header inspection
Thread-Index: AQHV2shkUinwDP1Kl029NFz/juAI7agJ5csAgAC+U4A=
Date:   Tue, 4 Feb 2020 07:53:35 +0000
Message-ID: <AM0PR05MB4866C4C3F7553DA6273725C8D1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <CAOc41xG5xb-6LEKmsvPPET9jKZ8ScAMW1rW=AzV1_HLs9DhNEQ@mail.gmail.com>
 <20200203200820.GU414821@unreal>
In-Reply-To: <20200203200820.GU414821@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.31.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 538ee9bd-cc8f-4c56-528f-08d7a9475672
x-ms-traffictypediagnostic: AM0PR05MB6260:
x-microsoft-antispam-prvs: <AM0PR05MB62609795B1911B29883DB548D1030@AM0PR05MB6260.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(189003)(3480700007)(55016002)(9686003)(53546011)(6506007)(2906002)(52536014)(55236004)(33656002)(316002)(966005)(4326008)(86362001)(7696005)(5660300002)(71200400001)(76116006)(81166006)(110136005)(66946007)(8676002)(66446008)(81156014)(186003)(7116003)(66556008)(26005)(478600001)(8936002)(66476007)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6260;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E0ZBf4vi9iLZ/dfO+EyKf3jIbd2vyqWREWQruIe8is2k10wnitzbI6Ml02+2xGJnT3QW4mm9DN2IEhVAz/xG4vNw1A/eLmjZ+/hJvoK3MmH3/wtEpkFetVOohfxdBCs0osPtsdv04aEI9SUrZFQqG2eT5ZcE9lcYnGnVZnOomP+29cNN43TnUcTYzR4ymArNYim/m6mdkLib2jFyxtBWR4C4uFENZeCjsOFI5zs9JKNXccoTQ5iJChnJG/uke4fNDLkkQFaL18fq6lI5zBKQJb8itFM33GDWWZw1++biRLWidHAsZ+o7E4MPNT3wkekB8OZ2LIMJtg0UwlsD8HX/2//NZGmxaIQ2AXhbFiyWy+H+1P6zS9zkPZj6zSZi2PhP/+VpsiCR7iLilcHYDIyTcyctGcSn8rbHRTVSNdKhw3dsGsX9DB6rYgm59KVdoH0ta0LImx9RvLFEb11n7Zx50VjjdHUqk3jscQo3tHiRawy3j4ieIfgissMemM53H8y/D3bKAsxMKdKz54/n7PNpcQ==
x-ms-exchange-antispam-messagedata: dEwQ0gm8xa8NYmly6iOqgoi0E2PCnpkhp2MgbFvZEryO+jgKD4JZ7itfkARG3ZrfYxLhgKtPWx64fH1rQEqtcyn2jompdI7A+FdJ0WqeTsDcrio2qtL+dOqMSOm/ZbCdCV6znkoMTNwa2IfZUDa6qA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538ee9bd-cc8f-4c56-528f-08d7a9475672
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 07:53:35.2540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTGk/aoSe8+SMbHLhr0fEbryX9jgEud9y4G5B5/fwn51kbzgCPP7MYpM02F/k6uxYocQolc9+V/gXhgk5EPW6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6260
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Leon Romanovsky
> Sent: Tuesday, February 4, 2020 1:38 AM
> To: Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
> Cc: linux-rdma@vger.kernel.org
> Subject: Re: RDMA header inspection
>=20
> On Mon, Feb 03, 2020 at 11:30:09AM -0800, Dimitris Dimitropoulos wrote:
> > Hi,
> >
> > I'm trying to inspect RDMA headers and they do not show up on
> > wireshark. How can I observe RDMA headers ? Also, any header parser
> > available in the code base that I can link to and use to process the
> > headers ?
>=20
> The libpcap which is compiled with RDMA support has ability to catch traf=
fic for
> mlx4/mlx5 devices.
> https://github.com/the-tcpdump-group/libpcap/pull/585
>=20

If you want to consume this feature in simpler and quicker way, you can fol=
low the steps [1] without affecting your OS userspace environment.
I find it useful and quick way to debug issues.

But feel free ignore my suggestion and use your latest or compiled tcpdump =
with latest libpcap.

[1] https://hub.docker.com/r/mellanox/tcpdump-rdma
