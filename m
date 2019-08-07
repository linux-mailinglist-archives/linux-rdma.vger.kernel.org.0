Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C15CA84AEE
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfHGLoV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 07:44:21 -0400
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:4771
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726873AbfHGLoV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 07:44:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9ggJRJcxtHU+ksWwWIYDk90MO7vWGZnQcRoIBC6YFICFgrmwEMmcpVnU1HQnsJV6qGnjD8bro0VZ0ZXN85vEskTl509eGTBMYYZKC8Q4Q9lCDvNQSFDCM7/ZrURYUbf1Hfkkk890sHaWSZIYS+HQYRGkPFrPSYS2iHf6rESwS7iL/UemOS2mXeUoc7CEdUChOm2+jVJSOkKxyDP4eYakzK5K1Bw7H0hYcNxzCrJ5lssarbOte2KEVVXSsf04yhCKURIucx0QwixMXVyuAl0cuKPapgpNRHKTyqLj8DN/5wjwJjl0dav4TMbBp26xOzNNZ/r4cwpdsklUqN/mkbH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyKXqDWTircQ/10we1irTyTtQsbGILpivNNfZczo4lI=;
 b=AwnouLfxTT04FjMi/NhJa43n4tV2J71rztPjEymopjOCLzvyFCHJZiBMhK6IQXG0P3DFASu+NKByUaIbZI/Rw6/O8p2XU/6khoQrwRedDBDM6rAUaoYzUnx/+3DOSxN+A+0mmydlkI/BhTGH2K2t8SnbnYGI4RhyA1hMMgt3p7gtDN/nvu5q3egkoP5Om66ys9UWKnQMuQZSJLfTuOaIlMiLXw2T1NmzFw+9PNzfojXhG4Ph6YVOL8VLCYH4ioioCjGL8h1aqaF6FrDU53D8VuScYc4un4Hu1JYlbWoAxpfgxrwFb4jwXNtrlMRePCFIncywYMHOlSUFzORGsrU1ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyKXqDWTircQ/10we1irTyTtQsbGILpivNNfZczo4lI=;
 b=lLC6Ow4qJMt5IxzaSWA+tyH5vr/terQNM7R3GI4bBoRsafrU//DBt4F8qiKt0gkFuA8pnmXd5FhcvPz262M/DkMu05AdkrLaxAcEdwR3ugg5n2DGnWoo4DgI8/NmpY6ICLD8+e7/vjOdqRzhhFwI2s9E7hS6BS3JDqAhalpsBM4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5853.eurprd05.prod.outlook.com (20.178.125.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.12; Wed, 7 Aug 2019 11:44:16 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 11:44:16 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next 2/6] RDMA/umem: Add ODP type indicator within
 ib_umem_odp
Thread-Topic: [PATCH rdma-next 2/6] RDMA/umem: Add ODP type indicator within
 ib_umem_odp
Thread-Index: AQHVTQurSLl8p2IgR0SgHRqdFJrlUKbvkL4A
Date:   Wed, 7 Aug 2019 11:44:16 +0000
Message-ID: <20190807114406.GC1571@mellanox.com>
References: <20190807103403.8102-1-leon@kernel.org>
 <20190807103403.8102-3-leon@kernel.org>
In-Reply-To: <20190807103403.8102-3-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::42) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abfe1660-9715-41bf-5b0a-08d71b2c93b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5853;
x-ms-traffictypediagnostic: VI1PR05MB5853:
x-microsoft-antispam-prvs: <VI1PR05MB58530381D2CD8B70A86A5717CFD40@VI1PR05MB5853.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(189003)(199004)(52116002)(86362001)(71200400001)(478600001)(386003)(71190400001)(6116002)(6246003)(3846002)(6506007)(14454004)(476003)(446003)(2616005)(53936002)(486006)(11346002)(68736007)(26005)(107886003)(4326008)(1076003)(102836004)(99286004)(25786009)(76176011)(2906002)(186003)(4744005)(5660300002)(64756008)(54906003)(316002)(66946007)(6916009)(7736002)(8936002)(305945005)(81156014)(81166006)(6486002)(66066001)(229853002)(8676002)(33656002)(6436002)(66476007)(36756003)(256004)(6512007)(66556008)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5853;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QCr1sXX4GAzjLNfJELRBArSnHVg8kg6Y0B5WF10ZoFlmdv2FL4Qv0HFbI+rH+Nbi2w7UZaxfC22YYv9TgrxSzREw4VsEzpcLr7ajSbNLEZNryEIbud3VBF95gswq6Cr/jOisZpaKJeDbEMMSkCpPv7xc7LE/GIDZBmj2s+hFvbm86YTJdOlSeroQtJEOqIdw+vxd/qXWm2uuws9fdgcPLUaZkzO4Kl0UU+X7KI98sKFooQLBpTvY+c9rDE/Pr3otnao/lRySRJ5Lms6Vj94t1U1yAjwZBiolFVipCd6I4G8mgYIq/ovgWgQ9kiaXDyBPIdnUjUg5x7CILj0t/k9q+G2Bg1aUSWc98qdGf8WOItjBJ8+GjpQ8R8aVlKHnpXBwbzlDSBnbppV5NLWAKOGA+H4laeOEEc5jVktCKIAjNjE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6550640B6DE5FE499824194455242F6C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abfe1660-9715-41bf-5b0a-08d71b2c93b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 11:44:16.8075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5853
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 07, 2019 at 01:33:59PM +0300, Leon Romanovsky wrote:
> From: Erez Alfasi <ereza@mellanox.com>
>=20
> ODP type can be divided into 2 subclasses:
> Explicit and Implicit ODP.
>=20
> Adding a type enums and an odp type flag within
> ib_umem_odp will give us an indication whether a
> given MR is ODP implicit/explicit registered.
>=20
> Signed-off-by: Erez Alfasi <ereza@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/umem.c    |  1 +
>  include/rdma/ib_umem_odp.h        | 14 ++++++++++++++
>  include/uapi/rdma/ib_user_verbs.h |  5 +++++
>  3 files changed, 20 insertions(+)

No for this patch, I've got a series cleaning up this
implicit/explicit nonsense, and the result is much cleaner than this.

This series will have to wait.

Jason
