Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 111BE1AF97
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2019 06:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfEME6o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 May 2019 00:58:44 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:35944
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727629AbfEME6o (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 May 2019 00:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4whbu7ROlgylTJL6Guu1gt247Q8rcc21b7aQNsU8TU=;
 b=aNYWeVD9c9UZBsr17chgcrIKCO10eE0aALxpRwat11ckpJzbIHDqzMCpzP7HXumcaMxg7Fufmht5a2NPRdpWHP0RvkooFnArKcsk0oXS7456h6Ms4uUaBlWwt4KAyW/pQtn26G+eyxPJdqqGBq3l5DUpBu6Jsp3iBB87vAWyu1A=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.186.14) by
 AM4PR05MB3297.eurprd05.prod.outlook.com (10.170.125.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Mon, 13 May 2019 04:58:39 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::74f5:6663:e5fa:3d6a]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::74f5:6663:e5fa:3d6a%5]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 04:58:39 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] kernel-boot: Fix build failure with ancient
 libnl3 versions
Thread-Topic: [PATCH rdma-core] kernel-boot: Fix build failure with ancient
 libnl3 versions
Thread-Index: AQHVCUiHmvBZZNysfkiPkg8g/pp1PQ==
Date:   Mon, 13 May 2019 04:58:39 +0000
Message-ID: <20190513045836.GD6425@mtr-leonro.mtl.com>
References: <20190512131904.2414-1-leon@kernel.org>
In-Reply-To: <20190512131904.2414-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::13) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:3::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.3.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fda9ee21-514b-4521-7af7-08d6d75fa9c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3297;
x-ms-traffictypediagnostic: AM4PR05MB3297:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM4PR05MB3297E6F71271524D31E665F6B00F0@AM4PR05MB3297.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(366004)(199004)(189003)(53936002)(6306002)(6506007)(386003)(6512007)(9686003)(102836004)(186003)(14444005)(1076003)(256004)(26005)(305945005)(7736002)(81156014)(71200400001)(71190400001)(8936002)(25786009)(68736007)(81166006)(8676002)(3846002)(6116002)(6636002)(6486002)(33656002)(6246003)(6436002)(4326008)(2906002)(229853002)(5660300002)(73956011)(64756008)(66446008)(66556008)(486006)(66476007)(66066001)(110136005)(86362001)(14454004)(52116002)(316002)(446003)(966005)(76176011)(4744005)(99286004)(476003)(66946007)(478600001)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3297;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9iodkfFCLma2G0kC3CFP1A5qM5U0opQsk+YgMxpk038xB1vIIt1NHAWuFx51nCH0wDOGtQjRhl4lAlG56IX4vVbhWgWtPWQELN/PaNxFZNwyPxlqqrrMONrpRK3tfzX1OS8jM3ObI4KxpAuEyFK5g+QImehAGfNQaiQGEKr76rgjZCnpjw7ZYUcRmTzvRmo9P0n/tAMfhqA1FJzc8L1V/k079jij2ucuTbPu06x2zKUd/zzPE8rgiZXrqFoixCHBL/tO3JLrcJvs38XyVvBJomuLj1HrEKdhMLn9ubN4vaA732aauidxkErVZbP9SjLQ5rIRcSnM4J+hIBdKkiFAC0MDVPlKJujz8TPK9uXBhxg8JD7InEGytnLBMlAC/1iy2ZAeJhCxtu6me3MFMJb2WlOS+w+QkAOuzs9+HfZhTLQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B821DBDD61C6654A9A6638832896A3FF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda9ee21-514b-4521-7af7-08d6d75fa9c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 04:58:39.4440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3297
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 12, 2019 at 04:19:04PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> Debian jessie provides a very ancient libnl3 version without NLA_NUL_STRI=
NG.
> In order to do not disable persistent naming on such systems, we prefer
> to loose our netlink type validation.
>
> Fixes: 6b4099d47be3 ("kernel-boot: Perform device rename to make stable n=
ames")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> PR: https://github.com/linux-rdma/rdma-core/pull/526
> ---
>  kernel-boot/rdma_rename.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Thanks, applied.
