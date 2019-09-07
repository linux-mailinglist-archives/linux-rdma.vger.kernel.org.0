Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61709AC526
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Sep 2019 09:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404862AbfIGHev (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 7 Sep 2019 03:34:51 -0400
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:49056
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404852AbfIGHeu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 7 Sep 2019 03:34:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0NcjCE/TaVh0eDBf80fa68PDa9A9vf7i0lgom+/+FKhSR8byVa7yHzjWWWTeEbr3oDFHC5Nzoo952ecJykv0vKK7nFSJRlYRsEkl7RKbn9em6GaDEqPHhrrrnGObCDTpuqRnFoe8Axfz++/db2J2nU8kCWmSf37EFqUaMpjcoiWKiJr3bpQK1YHpjwy8ayUuMhAemCh7neIjNDL3rVXaZ2tGziJrl9dsA3rq65I3RmCLp7o6JNVZBrN+rBw/csQngQOL5H8Txs6ImB0kbDEtyz31ozA+ZZN11BlewKKpeYVU8jEBmGj8E3OfxY6jCgdh5VSXPWbMD0smf3ObFg/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWQDaC/t+eGuPbWI8KGoRscjTfwvIiv8nm+2bfZyTl0=;
 b=n2OF+RcVfesrxF4p5a/QixSjyiiNcxhxF3som3ugCPlGqmHSgdjDFJ6wPlso1a20dPvWT9UOXB44UOXS4fb2XcmJJmW4hPCFtqWJFZdAOJMQ0YkWPgnhOVcTfTfn9CaWiBmJqLHA0hUV0jDX/IQBn/hZK6NIWWFQWukXx7zpNuiPG/yb+l+whEOwNlrR13DOaLwZ76Cyx7RwYJd4jD8rRhZqUJu0y1WqlnwtZdAjLVcQMtMXaHmS73AAWQEulWwNAf+XD9Y3jiM3EAgE77QDKsBiX9W5vMzdiWfeXRk5d+Cr6DJh0QYeMefEkC4ey8WiiK46dnU7RSSSDFmAMOe0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWQDaC/t+eGuPbWI8KGoRscjTfwvIiv8nm+2bfZyTl0=;
 b=Tt7JPi+JNyyuXw6fKTxlmVE5HOyJB8HwZhMXDAmiq5NnGI4+1w1yFlRxRejEhtSuJX6v4lyqc1YwjZpCjX3KilHYlUKglxbJLbLysj4K7dyBsQOSSI4AKvrNh1mApnzIf1I4wgW9wtqY++ZjGjt2v+DbYbt5P8lhjvvGf89IawE=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6160.eurprd05.prod.outlook.com (20.178.123.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Sat, 7 Sep 2019 07:34:47 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2220.022; Sat, 7 Sep 2019
 07:34:47 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rdma/siw: fix NOMMU build
Thread-Topic: [PATCH] rdma/siw: fix NOMMU build
Thread-Index: AQHVZMU+LvVEBVeztU6/43oPJmdmBqcf0+QA
Date:   Sat, 7 Sep 2019 07:34:46 +0000
Message-ID: <20190907073444.GB3873@mellanox.com>
References: <20190906151028.1064531-1-arnd@arndb.de>
In-Reply-To: <20190906151028.1064531-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0284.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::32) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.218.143.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b262804-99e7-4cdf-4fe9-08d73365db7d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6160;
x-ms-traffictypediagnostic: VI1PR05MB6160:
x-microsoft-antispam-prvs: <VI1PR05MB61602B12002F70E2BE9477E3CFB50@VI1PR05MB6160.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0153A8321A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(66946007)(316002)(54906003)(66446008)(64756008)(33656002)(2906002)(6116002)(66476007)(3846002)(66556008)(14454004)(99286004)(86362001)(305945005)(1076003)(8676002)(478600001)(52116002)(7736002)(14444005)(71200400001)(256004)(71190400001)(81166006)(66066001)(6436002)(26005)(2616005)(6512007)(476003)(486006)(186003)(102836004)(4326008)(446003)(11346002)(386003)(6486002)(76176011)(229853002)(6506007)(25786009)(8936002)(5660300002)(36756003)(53936002)(6246003)(6916009)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6160;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tJGM1J1eyODS4REme2yPa60Dxy4HAK96g3eJ4dKZ0WvmFH+ZawkGVvCwlQ1NnGXmejRTyH25lp6dWnKH9nLB5utBcEZ01E3bEt30zVMhYwaG5g6oql/PbvgR1ZNM720h6PepZ7TvUoJRCNIO0frvFbvyYVlcz768njxuQVJF0PxAMhcuN1GZzkMV4rehrPFkTyy5hQdw4AanDZXX5tjWxF4l36ICeTOhyvadzpjGoqCedAVfXq/m4EvYztXL2AjzoRwPuzc4QYUhI2xcfTJ2QF6pagbQ/w9v/VOe1ocMyYe6+OUpgQaLuRuOlRhYF331FtblAm/CumrfoV+1aB3qRK6JwzoNvHcX3Zq5TSt9g/NCaxvokebNPTOniw1yEHfARjAfUIaTO49hjs+I8RkB4OIKsHctlqxKFJfwfMwYa9E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EAD6BCF316711A4C919CFBF15B106EFD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b262804-99e7-4cdf-4fe9-08d73365db7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2019 07:34:46.9926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1iOhfrp2s2Wu786ffUrNpFmf20nhUYvgTejmMPGx4X7HWgQJ7aBvoG1Pig81LtIOD+j0fsrHPSluZbNAHlecA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6160
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 06, 2019 at 05:10:10PM +0200, Arnd Bergmann wrote:
> On kernels without CONFIG_MMU, we get a link error for the siw
> driver:
>=20
> drivers/infiniband/sw/siw/siw_mem.o: In function `siw_umem_get':
> siw_mem.c:(.text+0x4c8): undefined reference to `can_do_mlock'
>=20
> I don't know whether this driver is able to work at all without
> an MMU, but it's easy to avoid the link problem by adding another
> compile-time check.
>=20
> Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>  drivers/infiniband/sw/siw/siw_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/=
siw/siw_mem.c
> index e99983f07663..b3b614c07fdb 100644
> +++ b/drivers/infiniband/sw/siw/siw_mem.c
> @@ -374,7 +374,7 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, boo=
l writable)
>  	unsigned int foll_flags =3D FOLL_WRITE;
>  	int num_pages, num_chunks, i, rv =3D 0;
> =20
> -	if (!can_do_mlock())
> +	if (!IS_ENABLED(CONFIG_MMU) || !can_do_mlock())
>  		return ERR_PTR(-EPERM);

I feel like !CONFIG_MMU should provide a dummy inline stub for can_do_mlock
instead?

Jason
