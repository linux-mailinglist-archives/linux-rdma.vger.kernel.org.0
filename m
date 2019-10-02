Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEB4C878D
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 13:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfJBLri (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 07:47:38 -0400
Received: from mail-eopbgr50057.outbound.protection.outlook.com ([40.107.5.57]:17380
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726657AbfJBLri (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Oct 2019 07:47:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bP7VmuakSDt7qqRBxx1pkolpjdA9nVIKC3h1Bjli6hHxPdW3wEDpzW/t9yBAvfYe/pT5tua5EjhLzbA3y7/48OKgVH1fwM9J6ffMNm8qJU2OMp4N30pYnacY336W7NIYooYgC0dejppPFRAS6ZR6fzvCB5sJT/Xs4mgZhiE6sYSJtNzqDd3nvi4NiPfPBa2xKS4ZYThDRW6QCWb5HlXjFnv+paCNfVeIc1bU8FgFwvyDR6M6df+ZcXN9XZUQQcXuC8eCbF/Aq1P+U6mitg8kiiFYzoTREzDwY8VwRdtoUsegjPfaXhrOAed5f8x5WHQdmzBrIcr4qGFEECyVk7c6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akJNxVNQP+OtRiLZvLd1X9zyN8JVyMridlePKnSY14M=;
 b=UUaJ+/oCrBj4z++gk0rMBjrIb9ORkn25vX1pvXsNbYRWPA7nlI8SUaLHGj2Lwc8R/5fO//I6nc9CBGCylI+mj6xaBKcMLAR/AwIgaU/Yxb6l6tFX15HQEbNrNS9W82Bi5vZro1ZCc/T3zuOV+yTHt6As0ldCzoPHuGIw32+7xBpjvizveUi9oRNaEQWRCdacp/2rqE6HNEdq1aLyrgoGDyM9cZKroBS6a5o7pHX083PhT4+CU3LkIbgPze8GNFrqQ6L8N1WOZtOc5KT09bQXAIiOk/NEwcDkN9ZdoJ6mCLsXU3/ce21UI/VvvNdV1HGQZNl9OSQ9j80HX3N0l8ZeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akJNxVNQP+OtRiLZvLd1X9zyN8JVyMridlePKnSY14M=;
 b=rCDr6BBI0dabwTcxbwFC5eAjJVGZeT0G2iPksEyBeeKSKv7EAqNCtWC6+9t6OGmZJv+MRknfWYPVdIdZCsPjwYh2hQwSCIO2gPvw8RmtXPirCcmv9E7nxCPJjk8GFRmW7MVKe0kxBi3g8OtxBWmSHkJn1n8NZH3VWXGTk0qGHm0=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3250.eurprd05.prod.outlook.com (10.170.126.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 11:47:34 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::dde1:60df:efba:b3df]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::dde1:60df:efba:b3df%7]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 11:47:33 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] kernel-boot: Tighten check if device is virtual
Thread-Topic: [PATCH rdma-core] kernel-boot: Tighten check if device is
 virtual
Thread-Index: AQHVdE7LAGXIjACNK0+Rc7oOXfaY1adHRbkA
Date:   Wed, 2 Oct 2019 11:47:33 +0000
Message-ID: <20191002114730.GB5855@unreal>
References: <20190926094253.31145-1-leon@kernel.org>
In-Reply-To: <20190926094253.31145-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0060.eurprd02.prod.outlook.com
 (2603:10a6:208:d2::37) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bd15001-ba4b-432e-dbf2-08d7472e5032
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM4PR05MB3250:|AM4PR05MB3250:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB3250DF99F8F0E3D7FAC42CDEB09C0@AM4PR05MB3250.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(396003)(39860400002)(136003)(346002)(366004)(189003)(199004)(26005)(6246003)(7736002)(6636002)(110136005)(33656002)(478600001)(8676002)(6306002)(66446008)(66066001)(5660300002)(6512007)(9686003)(3846002)(305945005)(186003)(71190400001)(71200400001)(4326008)(2906002)(102836004)(476003)(6486002)(486006)(66946007)(66556008)(66476007)(11346002)(256004)(5024004)(25786009)(33716001)(64756008)(6116002)(446003)(6436002)(4744005)(316002)(8936002)(14454004)(229853002)(6506007)(86362001)(1076003)(386003)(81166006)(81156014)(966005)(99286004)(52116002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3250;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U9JItivsTIEHoo8g9o32jFPIUtzqcCn2V8CO5cVqfNOcNUXcHZ0IUQ2CjTpiqvMijwduVq23f48xw1WgmOuKblr3idtkVAa4jIrtmblC0XCJzcQOZ8By7qZr1RwBmZ0r4mJRb1/E30HoRF0x8thublOeBfOjEC2wiCXXQCey2l84M1l2081Twdnp6hTElVIB4NzrADU+5LI83/n//Mp7qwoXwI5Mi0XmCMkbVYNiGYLYoPu20zlKl7MyLxgDpRZxMMqNkAOHE6HkdavGDeKON6ET2FOh0+dinhs4u8fn+c0kew6xtx8IgGgMrLTkXvl+bEXB4IhGM5B0rr89LCEu8qiboTcxOM1CLRXGSxEVyB2ZC8y3A6pXE8d7TwzU9AWAg/wlr3g7VDxcFhbZhThz5djQe0BrUBUcKP9i6Rc4j6Hg4gOzHkug/WB1/pqd6JH5cSSn32ccpuqghQOrqc//ew==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <02F6F1852E77A546A162552AC76BDEAB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd15001-ba4b-432e-dbf2-08d7472e5032
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 11:47:33.7901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ughC1opu3anQ5DLf+hjmmJzHa4IRhWNL6qUHbRZ7eRHSq+UnsusukwWeSGkpFjtqg3F89aGzvDzC3V/gAE/c8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3250
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 26, 2019 at 12:42:53PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> Virtual devices like SIW or RXE don't set FW version because
> they don't have one, use that fact to rely on having empty
> fw_ver file to sense such virtual devices.
>
> Such change is needed to ensure that virtual devices which are
> attached to real hardware won't be renamed, because during
> device attachment, user already supplied desired name.
>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  kernel-boot/rdma_rename.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)

PR https://github.com/linux-rdma/rdma-core/pull/588

Thanks
