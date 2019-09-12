Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B8EB1027
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2019 15:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbfILNjk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Sep 2019 09:39:40 -0400
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:56197
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732202AbfILNjk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Sep 2019 09:39:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj9KdIXjXR3ksLFC+mZqw4Ny6DqTJdvaeqjj8yTTsed69W+6UvWYuc4IXMTDQ3ONi5ykqP11AZLTvvesP97oTqGfRILxOFyhZUAxDYixKyOGjeWO+YJ7lzYiRiD8QW182FywtkCSPm+25jzGLkNwO8lXnwDjB2JM85AOMWK3xQyPF4Su7U7NSaX3LWLPfCVDlI/Uvpud0lCZENaaO7OsXecCLUuk5ioxU3JS/XdeK8EyWdM6YvDlG0nKI5PlxCEIKpc/623DJnSQWccM46C5+iEdY5bj3SW2FOPJBGHsaUZq58nrO+RFPaT3WZN8oRtbSR4ghYXY/XVf0sz6ndu9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01Ooo3eb00QyAlLdOjKwSonviTYyGSQTLeRXCp99Pg4=;
 b=DukYV8Ebh5JVGCW09vQ6MjdCZAMKCj7lUVRz3WmRKIKJiTj0xdy4q+zt2po3e9dUwUelC73sTfFneOB5YRlzbnwiEhgXnG1XnKCKGLUP3SqJWiiOSqqtJWZsLv6ac3scZGf+dtGTWzR586OavGEG77ahOslyT4gciwuaWZ4q/VcG8RcCRIBXXxKLbqYGkEH8gP6BCQEuAP3LW29sfLNOfBoGfXNpgTg6Hz0YdmF8r9OxBMCGjYuolV1AalFeaAvieLAY8pWODQsYf5T+/gkkyO1NQ7FWNTuhXnYTD61s9lk7WHTlMYpeVlqyfFQJPy/SkBpVO7Ouq5mt6YVUsGx0/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01Ooo3eb00QyAlLdOjKwSonviTYyGSQTLeRXCp99Pg4=;
 b=RCuqNahcPs80WIYJpKTUa5HNZsl19NiRSwi6pNlFZRmKTbQlKhayJ765eFjtnmlQnKfsxl/1COLWFuw4dBv7zT/8Fimx/QdIxzatqsg3FpZH4Au0HbdqZp4XtiuAInl2B/RktaMVArUkGDF9zkerKWH8T7RJiboNnRby+70HHlE=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5646.eurprd05.prod.outlook.com (20.178.120.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 12 Sep 2019 13:39:36 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2241.022; Thu, 12 Sep 2019
 13:39:36 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/odp: Add missing cast for 32 bit
Thread-Topic: [PATCH rdma-next] RDMA/odp: Add missing cast for 32 bit
Thread-Index: AQHVZhx5RqWyZcR+dEmdfVWpab+Au6coErcA
Date:   Thu, 12 Sep 2019 13:39:36 +0000
Message-ID: <20190912133916.GA25528@mellanox.com>
References: <20190908080726.30017-1-leon@kernel.org>
In-Reply-To: <20190908080726.30017-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR21CA0048.namprd21.prod.outlook.com
 (2603:10b6:3:ed::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.167.24.153]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df8112ba-0829-4c8d-26e0-08d73786a72d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB5646;
x-ms-traffictypediagnostic: VI1PR05MB5646:|VI1PR05MB5646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB5646621A1743D4AFF1E22AABCFB00@VI1PR05MB5646.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(189003)(199004)(478600001)(229853002)(6486002)(25786009)(3846002)(6116002)(53936002)(107886003)(6246003)(6436002)(476003)(14444005)(4326008)(6512007)(256004)(5660300002)(4744005)(86362001)(71190400001)(71200400001)(1076003)(11346002)(316002)(54906003)(2616005)(446003)(7736002)(14454004)(6506007)(386003)(52116002)(102836004)(76176011)(186003)(26005)(99286004)(486006)(305945005)(33656002)(81156014)(8936002)(8676002)(36756003)(2906002)(81166006)(66066001)(66446008)(64756008)(66556008)(66476007)(66946007)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5646;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tvu13rXZ5X3HOgxGtRNa2XYmOjuCjiwiy+8VRleuoaiew5nk8zDGmDJzH11+z5YMuX3Cc9LKL1e0UaDWEOXekcsa4T+AoqF+Ets9HG7f/zyuWRDgBf09sqGhP+woQqEvVtgah/iSLbbYmkm2cWDe4UDqhNx9eXa0jTqesjPIuQYK5Fuc8Y8+LRpd/EoJrIv9rc2KngpvspP90RxWkFIWoCjXXSiitxOLSbA9uT5zAYQSfoc4rLDVqbfOughmaOOXkm2fhkJAxdGBMxvNysuHIm9h8d/huJnMzxYStNs5arPszd3wSeoGI1GS1VJ5WP0VmSKfrZQDwTFfIvHz6GkdqzxnWexMqCNhL+7UMkOP0Nlq/M1UByESsNAOrU9SNtbTbwxt9gr4AmWTjTqaO/sLNd0cVOXjGHGOC5bz2kE4V0I=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <86E574C32743EF418745D06D7F6F0FAC@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8112ba-0829-4c8d-26e0-08d73786a72d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 13:39:36.7393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zEQevz62I58Vo0sCL7RBSuiAQ40fu04/dTb0ikkhb7i/QC41v9Oif0C/aEBb31QccVcZOSgLSrZED+fflt4x0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5646
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 08, 2019 at 11:07:26AM +0300, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>=20
> length is a size_t which is unsigned int on 32 bit:
>=20
> ../drivers/infiniband/core/umem_odp.c: In function 'ib_init_umem_odp':
> ../include/linux/overflow.h:59:15: warning: comparison of distinct pointe=
r types lacks a cast
>    59 |  (void) (&__a =3D=3D &__b);   \
>       |               ^~
> ../drivers/infiniband/core/umem_odp.c:220:7: note: in expansion of macro =
'check_add_overflow'
>=20
> Fixes: 204e3e5630c5 ("RDMA/odp: Check for overflow when computing the ume=
m_odp end")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next

Jason
