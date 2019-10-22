Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C15EE03EF
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 14:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388220AbfJVMfb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 08:35:31 -0400
Received: from mail-eopbgr30043.outbound.protection.outlook.com ([40.107.3.43]:22424
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388066AbfJVMfa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 08:35:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRmqGxTWIRsraatWNydp0MpfE+G9dN3cndbNH4vxjvwpyY9j4TPm++eVoPNeFWYLqaCJbw69Pj1DZmKOPqokFwzdw9IiLprn9sOXKHlPZ1XWD4QgudUL702WlLjH4Ia+i73j5JKh8cO6Z+jaLeuzv5OwrdXHhAiwiu+/XGLN46QRic82TCyPpDVcjOhw4cQg5hMwvPgoODBvtGDkZbhva1+0Gfmcq9ZNYgs2rg/cIm1BDWu6gRbAicSR1bU1xVWjEenHsMsfVu8i3XpLBP5E2hycDiElujdB8ahUSh/votO25VSpRL46IV6eI0x6lqZr4l++oqp0yE/NeMMDvCJgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BBa+W+SPlwtQjvmv7dj450AvPyt85TeEAdY4WS+mEM=;
 b=fU5NPXDmMkaDx6I+XfJ2vAmqvdxdMDyJl6gFXRV7Zw4IVFbSacQkcCqGI6jVQRufdmrZI2b09oxGvvVPTohXL+yGlL7QH9nixDTNLXtC+DYPjD/sTN3Cgm8xkwJvgMhosqresqwlcw6SlI/9C9aMlSFu0t5bNTYvfmJ0O9S4GJgrZiw58HkwFcX2lIKNmkeVuPxdhXccQTEsKI8qhLHsFewGytQa8luXpHzODQKothFTRuYwA3mXp6zRX5ozDQoADCUr+48wSm8bjncoVoM8xEzsm7SWeYLaJrPFHpNKa364r4yrY9349s9zhzdlXFx5t1UhVYRgWOeo0w1186jEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BBa+W+SPlwtQjvmv7dj450AvPyt85TeEAdY4WS+mEM=;
 b=gQXSqCeDCiID5PW1lcYLofNqdvRHw8onOuxAVwaJs7oW+CrfIfHjmIESsw2vXig6FV9aTtNKt++sRwskETlNE2muYu5mRJtLz32Ckeiq6gTggWvQpqr8dm/LkEPh/TAYhJkpxW83yLrQvZD5yjLoXPtKhBVkIJlV2HfhMfKyBxs=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3202.eurprd05.prod.outlook.com (10.171.189.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 12:35:27 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::dde1:60df:efba:b3df]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::dde1:60df:efba:b3df%7]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 12:35:27 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Michael Guralnik <michaelgur@mellanox.com>
Subject: Re: [PATCH rdma-next 2/2] IB/mlx5: Test write combining support
Thread-Topic: [PATCH rdma-next 2/2] IB/mlx5: Test write combining support
Thread-Index: AQHViNUuVcQiHIU45Umq1xcsNfy+KQ==
Date:   Tue, 22 Oct 2019 12:35:26 +0000
Message-ID: <20191022123523.GH4853@unreal>
References: <20191020064400.8344-1-leon@kernel.org>
 <20191020064400.8344-3-leon@kernel.org>
In-Reply-To: <20191020064400.8344-3-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::24) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.137.89.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fce364c0-2b42-4c05-b45e-08d756ec50f6
x-ms-traffictypediagnostic: AM4PR05MB3202:|AM4PR05MB3202:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB32029608710982190D583FDCB0680@AM4PR05MB3202.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(199004)(189003)(386003)(6506007)(102836004)(6486002)(76176011)(25786009)(54906003)(110136005)(26005)(186003)(229853002)(33656002)(486006)(476003)(4326008)(446003)(11346002)(66946007)(316002)(64756008)(66556008)(66476007)(6116002)(66446008)(3846002)(86362001)(7736002)(305945005)(52116002)(6246003)(6636002)(107886003)(99286004)(8936002)(2906002)(81166006)(81156014)(6512007)(9686003)(8676002)(5660300002)(33716001)(66066001)(71190400001)(71200400001)(478600001)(14444005)(256004)(1076003)(6436002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3202;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ayTkQmrzNj5OtfA3U1JFbpEM7fgsnW0DOyanjeoUjFvRa4gd1CI6JMVzQoMyKlJZdAy2A6lstjWEp5Qu15vDo9XV0kuIX92jhCDjao2zUftIZNr0DuH0SFa9jXmNzNwurD/ZxxnRW/p9G+SxfQpxfr4k94hwMnffeNm+7LqF4XLj+1E1NdEN+kHsXmu9IpBU0KoWiYW4rYzbefOZT5rsn99E78k2Qlov37DbcKoj4hy1+6RazzpT0NU6cNhEkDZtBJF8jt9iB+NLBMlRnLY4YAxW9XydybtVLSBul11rJ6DwE35wxRdr9t1lVU21mutrpYtuMmUIvA0V7Npvo2JsP7kjg/7Lue22hSGhEQbyKskWqFX83nPlTsAF43Mc+D+pCK0molz1XFAjR0HDz348Zsd/33xLuTpgHxZe4rfsb2s4M0piclEZk6Ym2U18dSUY
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A55AB7EBA615EE469EC30BC48CAA30D7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce364c0-2b42-4c05-b45e-08d756ec50f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 12:35:26.9425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nChOt8s7galzviAWyEXYOGJGrYr5ny0p3hTxNKD2lJRwwsvGdtZs/BeHe/e3UOA90Nm3a5y8IMtoNSM7877V3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3202
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 09:44:00AM +0300, Leon Romanovsky wrote:
> From: Michael Guralnik <michaelgur@mellanox.com>
>
> Add a test in mlx5_ib initialization process to test whether
> write-combining is supported on the machine.
> The test will run as part of the enable_driver callback to ensure that
> the test runs after the device is setup and can create and modify the
> QP needed, but runs before the device is exposed to the users.
>
> The test opens UD QP and posts NOP WQEs, the WQE written to the BlueFlame
> is different from the WQE in memory, requesting CQE only on the BlueFlame
> WQE. By checking whether we received a completion on one of these WQEs we
> can know if BlueFlame succeeded and whether write-combining is supported.
>
> Change reporting of BlueFlame support to be dependent on write-combining
> support.
>
> Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c    |  15 +-
>  drivers/infiniband/hw/mlx5/mem.c     | 200 +++++++++++++++++++++++++++
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |   6 +
>  drivers/infiniband/hw/mlx5/qp.c      |   6 +-
>  4 files changed, 224 insertions(+), 3 deletions(-)
>

We found statistical failure with this patch and I'll resend it.

Thanks
