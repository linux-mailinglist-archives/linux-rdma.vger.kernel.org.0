Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73316ACB7E
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Sep 2019 10:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfIHIKb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Sep 2019 04:10:31 -0400
Received: from mail-eopbgr30084.outbound.protection.outlook.com ([40.107.3.84]:26343
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726887AbfIHIKa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 8 Sep 2019 04:10:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/c3+BGgXbQoAeP10ZAWY/o8KZqOchfTIXvQKbTW0BZN1jx1hHV9IryXnBhyRfCHguTfOYQNI7LB6ebmWs1tnUDZrFNSoOyAtCoJA1NEo4GEyPCyS3m1lwS0abIhuFiZEVY4fkaWLf2zb7wVKQJhM54M1uINfOJfGAgrBP/H45VEWXYJSxk9+e00ClyIxelP/OBQbqhMZj/FIr06+TavF9EWmUtsMBmK9qYi8zV+/kkO1FCSaZ739pqNq0S7QjkgtsRIhms6D484M2c5a/iIQhsNRccGr0ES35iBOToO076qwox7LP0hPUBrs/Zp1KCAipT3PDmJZFk1RgoubXuzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50kO4/Gp3LkG2Rky5u0yz5FbBmLLNh2EUDsvE6XbuSQ=;
 b=UEihqBUnWEwuIHbn1EURrUFjhzmO4URqiYR4FgB6Xano7vj88L3GpeP8i9llzgqBWpqjWtit56MncYPNu+FE6TWJBF+eTo9k3GRjDW4ZhWpJSZwNp9V4Si34vTq1tnkqWQaJy1X6uvdrFoXO9lh7IZ3Ib+uLR5ps6jPvbfDd1thi0zLeUOXNv8LjCq+dutVud36Sxh7Hi3WCmrFconu2bLx/UPCyUMDlpDG+3s0RgFxjyKVvpa66h/tLGKhDnJtv4F1HWY8JOQyVVwHlVOu8uGYaoDRVx88yrW6ucip9IJebO44KTDohzAUhQmODezdLRSZ81WwEXS5XPw5U7tmnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50kO4/Gp3LkG2Rky5u0yz5FbBmLLNh2EUDsvE6XbuSQ=;
 b=HzOGhYLrwsVj4FrvgsgJITUDJdch9OtzlsKEgLNM8eA7pmya8mXyRKf9ZEBHZ83ajeUBWoZL0HxuOPjZ8jraWdkjmTb1MmFTI1I0t8PRSAyPvKW0Os2TUDsn7vKjI30MnJCSuRfoz68rXSuqXWTNIgdB1jiW36SSLrxgsaH09gM=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3441.eurprd05.prod.outlook.com (10.171.188.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Sun, 8 Sep 2019 08:10:26 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e826:7a52:5488:2b6f]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e826:7a52:5488:2b6f%7]) with mapi id 15.20.2199.027; Sun, 8 Sep 2019
 08:10:26 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ib_umem: fix type mismatch
Thread-Topic: [PATCH] ib_umem: fix type mismatch
Thread-Index: AQHVZMnBKDP0iI/3WEGssN3nZ5iyQqchcCUA
Date:   Sun, 8 Sep 2019 08:10:26 +0000
Message-ID: <20190908081022.GD26697@unreal>
References: <20190906154243.2282560-1-arnd@arndb.de>
In-Reply-To: <20190906154243.2282560-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR05CA0030.eurprd05.prod.outlook.com (2603:10a6:205::43)
 To AM4PR05MB3137.eurprd05.prod.outlook.com (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.137.95.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28323dd4-0562-4641-50f6-08d734340158
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3441;
x-ms-traffictypediagnostic: AM4PR05MB3441:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB3441D4EBCFED40AF2921F902B0B40@AM4PR05MB3441.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0154C61618
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(346002)(396003)(39850400004)(376002)(366004)(189003)(199004)(102836004)(186003)(446003)(25786009)(71200400001)(99286004)(316002)(5660300002)(66446008)(1076003)(476003)(66556008)(64756008)(86362001)(3846002)(66476007)(6116002)(66946007)(33656002)(966005)(11346002)(7736002)(33716001)(14454004)(478600001)(53936002)(6246003)(486006)(6512007)(2906002)(81156014)(81166006)(6486002)(66066001)(9686003)(6916009)(229853002)(6506007)(14444005)(26005)(256004)(8936002)(76176011)(386003)(6306002)(54906003)(52116002)(71190400001)(4326008)(305945005)(6436002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3441;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sgsm4ltbFEbuLpe+ICF3EO/WuSpKaz6vpkltwUnyZ5hOc1wulY0lHd3zSP/RYac+CGE+N6RC9b4x2zP2Y9ikKIsbP5XirLzMechhqtKWtnwl8pDqxf92lG5kOHl3dOOh2D06IkxitGUsKAtoZiTUyN0LxYFDKmORSm4MZbhAOk1UvTKVZKo3L7NbeeK0fgabu2dwt0A39LHJLHy3TJ8okrdwlu6VeAo5dUpTwg+YX3E44JWu8mFgagLksB/M/R8GOWIMVkWKVMZtf2p3XitMBdPmqG++kvitXckY7Q/HTwq7z2mKZVH+dzL9qqW0kje4o3q/XY2slwqT7hIpzUOjpUKKODotNwkjuEYgdK6gezKBXgoAbNS/bs8SKxsNiw4F2/7ysDmP5YR2umAczjB89Pz45bsVlHn+HEPpYQQBSyU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA26B0A927FF7949822EDA1C4ACA620A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28323dd4-0562-4641-50f6-08d734340158
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2019 08:10:26.6040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haUQg5nX1vFqJ/gcqFGHs6KAr+CdD93ZbfWCXB+o8CouUq97ufvv4Rsje9U2XwNsuoD+UaVJ1ZGskt4tmlj09g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3441
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 06, 2019 at 05:42:37PM +0200, Arnd Bergmann wrote:
> On some 32-bit architectures, size_t is defined as 'int' rather
> than 'long', causing a harmless warning:
>
> drivers/infiniband/core/umem_odp.c:220:7: error: comparison of distinct p=
ointer types ('typeof (umem_odp->umem.address) *' (aka 'unsigned long *') a=
nd 'typeof (umem_odp->umem.length) *' (aka 'unsigned int *')) [-Werror,-Wco=
mpare-distinct-pointer-types]
>                 if (check_add_overflow(umem_odp->umem.address,
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/overflow.h:59:15: note: expanded from macro 'check_add_over=
flow'
>         (void) (&__a =3D=3D &__b);                  \
>                 ~~~~ ^  ~~~~
>
> As size_t is always the same length as unsigned long in all supported
> architectures, change the structure definition to use the unsigned long
> type for both.
>
> Fixes: 204e3e5630c5 ("RDMA/odp: Check for overflow when computing the ume=
m_odp end")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/rdma/ib_umem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Hi Arnd,

I had slightly different fix in my submission queue, which I think is
better because it leaves length to be size_t.

https://lore.kernel.org/linux-rdma/20190908080726.30017-1-leon@kernel.org/T=
/#u

Thanks
