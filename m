Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B939F18906A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 22:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgCQVcR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 17:32:17 -0400
Received: from mail-eopbgr700110.outbound.protection.outlook.com ([40.107.70.110]:39105
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbgCQVcR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 17:32:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb9UvV02o90u0LADt4P9Q3tzEu/btu5FsUE8Z/yx3yiJMKezQ4J6BZ6QnuyT64xfeN1/B25nq6dGuXiHVsbwp+xWGJipBhI2KBrLfzZONZLHenIKTkViP9XqlnZFtU8D5wN7tC+6gSQsusKc5e9PtQd/RjZzBU2CuoUrgleP2WnCFZDsSv666EdRBr6RMf73wZsndn+DMfcJMC88OobbYqjghNpEBWXE880ru7m4aTfAGFtIlYQQW90HgS/ZPFlktWpkeJd1PTCmX+U4D1m+cix0D+VRocnXHN/3rF3+OgLWOy+/vDCAMmy96gyQ74UfX9SwjkMmf5MinHU/ENAXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MXA/LIUrC77mWqaPxc60w6eN0AHKLioUGsWJQ36HYc=;
 b=kZiObYOrAB0NKhIaY2HUWgVX8y/OWXwanWPGQoHGBz8ayq53zDKXIRTltVXJxM5jg+Wlg4T1MG7uzwfJbn8IrENhuDJxCJ/1oOFDxVmzPTOlLGtEZJmMqfQyOevtr+Uk2qLnP+vnbIFZHCeVw0Kqc/1aTiXOFb3NW/sZh9QdTN+1FwvsRtIrJD8/kI2t2+GMwWn9+lbT0p1u89Hc9w22Z9dXDQaj2vUJxOJcXQjTclS/sPg/ctIpC2XGejjAKdZ1YWYHA78o2tcCPFZetVIc3pO5/aQn4g25/oeq6lE8M2zwGWEN+wlEdNvFVSnXP6xIfaI1iCnFCukMMz2YO8YSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MXA/LIUrC77mWqaPxc60w6eN0AHKLioUGsWJQ36HYc=;
 b=AJAaqiRlhuNQYsT88qWvaDs1pUJvrDqpIAE1v6y5PTFykGWIjSw+9cg+NW52IF15EbdPG4EAXGquFYfO9NbO/89Wc5k/9hmOsuCpE/aMm6wgF3VdckzqKbhIQizU0RTMMSkaBcvJPagT3IILqkfSm4nCICeFiVUKQsgzwhFcqtE=
Received: from BYAPR21MB1223.namprd21.prod.outlook.com (2603:10b6:a03:107::14)
 by BYAPR21MB1655.namprd21.prod.outlook.com (2603:10b6:a02:cb::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.4; Tue, 17 Mar
 2020 21:32:13 +0000
Received: from BYAPR21MB1223.namprd21.prod.outlook.com
 ([fe80::8d1f:f622:2bc1:a518]) by BYAPR21MB1223.namprd21.prod.outlook.com
 ([fe80::8d1f:f622:2bc1:a518%8]) with mapi id 15.20.2856.001; Tue, 17 Mar 2020
 21:32:13 +0000
From:   Ju-Hyoung Lee <juhlee@microsoft.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ju-Hyoung Lee <juhlee@microsoft.com>
Subject: RE: [EXTERNAL] Re: Find rdma-core version
Thread-Topic: [EXTERNAL] Re: Find rdma-core version
Thread-Index: AdX8G/w1CIvOVTxSRQyfs/GZbAPOgwAeKZaAAAOjc5A=
Date:   Tue, 17 Mar 2020 21:32:13 +0000
Message-ID: <BYAPR21MB1223AC2B4C82BC7287D3665FDAF60@BYAPR21MB1223.namprd21.prod.outlook.com>
References: <BYAPR21MB1223A416AA7FE380D8DDFFC9DAF60@BYAPR21MB1223.namprd21.prod.outlook.com>
 <20200317194539.GW20941@ziepe.ca>
In-Reply-To: <20200317194539.GW20941@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=juhlee@microsoft.com; 
x-originating-ip: [2601:1c2:4b00:8ff0:9b9:5798:e241:7820]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab8669e8-b409-4b4c-288c-08d7cabaa85d
x-ms-traffictypediagnostic: BYAPR21MB1655:|BYAPR21MB1655:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB16556C0342B5207BE17F513CDAF60@BYAPR21MB1655.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(55016002)(9686003)(52536014)(316002)(6916009)(66946007)(478600001)(76116006)(107886003)(10290500003)(2906002)(33656002)(186003)(66476007)(66556008)(66446008)(64756008)(54906003)(4326008)(7696005)(8676002)(8936002)(6506007)(53546011)(81156014)(71200400001)(8990500004)(5660300002)(81166006)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1655;H:BYAPR21MB1223.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ArOOspLVrfO1ZgZ5jkZtfEvcROdZv6+pTEwM6aP1WDRq55zX2l/dD2AQXlgb3aJUFPkzGeaeQh7k10ia7/LLDdsrSUUSDLZhVBfy2dfFpN2mRLudlK42ijllYLL3XoMKHpVVx6FtmsKHUeHBrZlTw0sRo58g/G+qr9EICvn4tBy9WCmP6GSiH3n5QBZ6ycSlUWn1P1DvELUHccQLLTql/Q7rY8smwIpsfaGjuxk4LpuGjTobic2i/DtN7z4lpfFuBTMw1rEsjAvLevY+UUHzeJGzyAxB/j2gf+SnPRM1149b0m2OKiC+nM6KgSvuSAn1bCwqNGlnBO0Nm9QXI0q1A61KB/EovGfVGroOUxGMO1ActuZ1gun0RA4fp9d/8vYwiidVFnfL4Vcsbzo58P+Vh18Nz19l/HTOPpmcjV9OJng725/A7+nmCxOJ/DUcX+gu
x-ms-exchange-antispam-messagedata: WQqAnsdl6XlRGb0UReb6AlAbA+prAvbnD0j2f/oz8A4bGeDCcXuov0Qzi+yLJgzHofw1exwyB7klUWY5fIk3ZUDEVXMDQ03uf3V+aqP+EvF8ikw4m5vLL6JicAZ3LOaijMvxxiaBPdoSJ8OHfcsSInOdbNkigkz4O7T7ZKLCKlAHhHS0IZo5jzQCQ8SIcscTb/m8PQ/+BvKC2RKSQLjWTw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8669e8-b409-4b4c-288c-08d7cabaa85d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 21:32:13.2930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cl29628G9kQtUc+e735kGD878u8JwrEHRE58dMmm2D4q6Dwpif/eID3k9gbw/l/ixKRNynhzqvcdAuEs3mRQDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1655
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

My original  rdma-core version was 22 then but it still shows after install=
ed rdma-core-28.

This is my log of the original state.
dependency-vm:~ # ldd `which ibv_devices`
        linux-vdso.so.1 (0x00007ffdeb7ec000)
        libibverbs.so.1 =3D> /usr/lib64/libibverbs.so.1 (0x00007f68c7ecd000=
)
        libc.so.6 =3D> /lib64/libc.so.6 (0x00007f68c7b12000)
        libnl-route-3.so.200 =3D> /usr/lib64/libnl-route-3.so.200 (0x00007f=
68c789c000)
        libnl-3.so.200 =3D> /usr/lib64/libnl-3.so.200 (0x00007f68c767a000)
        libpthread.so.0 =3D> /lib64/libpthread.so.0 (0x00007f68c745b000)
        libdl.so.2 =3D> /lib64/libdl.so.2 (0x00007f68c7257000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f68c82e9000)
dependency-vm:~ # ls -al /usr/lib64/libibverbs.so.1
lrwxrwxrwx 1 root root 22 Dec  9 12:31 /usr/lib64/libibverbs.so.1 -> libibv=
erbs.so.1.5.22.5
dependency-vm:~ #

After build.sh in rdma-core-28.0,=20

dependency-vm:~/rdma-core-28.0 # ls -al /usr/lib64/libibverbs.so.1
lrwxrwxrwx 1 root root 22 Dec  9 12:31 /usr/lib64/libibverbs.so.1 -> libibv=
erbs.so.1.5.22.5

-----Original Message-----
From: Jason Gunthorpe <jgg@ziepe.ca>=20
Sent: Tuesday, March 17, 2020 12:46 PM
To: Ju-Hyoung Lee <juhlee@microsoft.com>
Cc: linux-rdma@vger.kernel.org
Subject: [EXTERNAL] Re: Find rdma-core version

On Tue, Mar 17, 2020 at 05:23:28AM +0000, Ju-Hyoung Lee wrote:
> Hi,
>=20
> Can anyone help me find what rdma-core version I installed in the=20
> system? It's a set of lib and utilities, but there might be a way I=20
> can verify the version after the official release installation.  Any=20
> help?

$ ldd `which ibv_devinfo`
	linux-vdso.so.1 (0x00007ffc63bd6000)
	libibverbs.so.1 =3D> /lib64/libibverbs.so.1 (0x00007f3de67c4000) [..]

$ ls -l /lib64/libibverbs.so.1
lrwxrwxrwx 1 root root 22 Mar  6 19:43 /lib64/libibverbs.so.1 -> libibverbs=
.so.1.7.27.0*
                                                                           =
       ^^^^

rdma-core version is 27

Jason
