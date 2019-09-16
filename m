Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B0EB3FD6
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbfIPR6A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 13:58:00 -0400
Received: from mail-eopbgr60061.outbound.protection.outlook.com ([40.107.6.61]:4746
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727039AbfIPR6A (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Sep 2019 13:58:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwIjM5Qh6QQMOJlAVTUMq6p3Cwv5ErMmvPruQ9EF5ccYpsYnY9foJkN0gTmHkZf2DSva86//MeHdV+S+NxnITDW8RfjC4ExDPpk0IU24H91/zwf2VhywLWS3VLnhkdx9ihlxOmY7Tr5pgfu5AJODbGWUuKbUFA07ktDoF8AasE/IDE0/65Z/wTHdVjKjsvHPyZ1AICDk33ldn9V8ZspIXbYN+TBHopPctv+QJq0bXyN27cxcHuVi3VDJDU73VJVt9gTRgMLH2IdTTrBzl9L05LVslVTmdliEYjOO9efQgOkJMWkzWAEtnHhuafcaESVFyyvNGrcEOypIZL36Xls3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVbLft6Qsn0YpONXghtsqWI0ilPQ1uKYGtk8P00ipWU=;
 b=fizQrswwcBrI0j6xHMzceVuNdpfuXmN0K1uIDabpSLy2eGqgwKNZPKQXLCmgWxWzG7JlqUzKKsRio+b8f+qT6evvBqif94z/lBWLT75dpOSUjZUAlh+liD/Ucs6r1wL9t0WOdoWhUx+ebT0oivimTBueeGn2u6sANMBmTPxhr73tycgHKRFfiSRdI5cNGzP/4jlfquBYIA2AP4birWNFKa365LeJIuNxvav9qIDICkC6IBU1uNJYu26XcUbCZaukwwoYUkpATLcc4wA0umgtZcpFtYwYh5unFNWPgxCROg8aWa8tS0V8tQqc7VxSYEGkxE4UL25XpgTJYUL6v0PvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVbLft6Qsn0YpONXghtsqWI0ilPQ1uKYGtk8P00ipWU=;
 b=erIwG47Rsc8hyzKmdTGuhJgEKrxoqITnPFVpB8aDkpPrVsQhfFpIeE1kTU1ycehiNz40reGByODpaIAKpQC2pbTxNZj3I8sIf0UI63JJMvTWzkM7cd8iPMjmnzHBhPfNOOfiWRcOdU/6TjsT7DodSutqE3uE3xca0wJsZFoHZmE=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6109.eurprd05.prod.outlook.com (20.178.204.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Mon, 16 Sep 2019 17:57:56 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 17:57:56 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH 4/4] RDMA: Fix double-free in srq creation error flow
Thread-Topic: [PATCH 4/4] RDMA: Fix double-free in srq creation error flow
Thread-Index: AQHVbF4QjwbsjmAHz0yfz2UVFai7Macul8eA
Date:   Mon, 16 Sep 2019 17:57:56 +0000
Message-ID: <20190916175751.GF2585@mellanox.com>
References: <20190916071154.20383-1-leon@kernel.org>
 <20190916071154.20383-5-leon@kernel.org>
In-Reply-To: <20190916071154.20383-5-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::17) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.223.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7461f9b4-03ee-4320-670e-08d73acf6726
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB6109;
x-ms-traffictypediagnostic: VI1PR05MB6109:|VI1PR05MB6109:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6109B446530C88EF024175AACF8C0@VI1PR05MB6109.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(54906003)(25786009)(476003)(2616005)(33656002)(229853002)(99286004)(6916009)(6486002)(305945005)(186003)(36756003)(8676002)(76176011)(52116002)(26005)(6512007)(71200400001)(6116002)(3846002)(71190400001)(6506007)(386003)(102836004)(7736002)(6436002)(14444005)(316002)(8936002)(1076003)(5660300002)(66066001)(4326008)(14454004)(2906002)(81166006)(256004)(81156014)(86362001)(53936002)(486006)(66556008)(107886003)(66446008)(66946007)(6246003)(446003)(11346002)(66476007)(64756008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6109;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w3w5U+OLMg3WaMgtkCLpfI+YYtLduorAApeBOGDmLzB001gmvZJ+/I/MO13+fFlmWsqX4QBm75CMSrkGRj6HtL47XngjcGsy5E6qKaUcFPnSDyvtGcUjALU0yDiuS2XPK9SjKFM47UI0tc10xxpWuR/VcEQ0SeiVr/rNxskWSqregLuxjThRo/ixlmPNb8f72d9meBeqtoyuZ0W3jgN4xjonKk5yezF1wxlx7SyWHz14ykHw5YT5og3VsuTRMfUon+CB62aEwZv2mS3BkMuPE/aiyueGrdembucDgm2Wor4ONa6w5GWZuQVrDRYio7QaGMUEzQ4KG9x9gB/3/ew1Elm0kIpvhuy2UwA4NBG5tvaN0+ldVl78nPqCsHpnJ0ij+jgG+8l9eA+bgV0U32xdDvpphJxNcKBmuNDJoHEoFM0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07A8E375B379A64E8FD3E3054178F862@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7461f9b4-03ee-4320-670e-08d73acf6726
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 17:57:56.0844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56wpFpRmbyy5B2cbKDSuKIC0Cpns/1YYGE4KcS/LPPfisQasIzeF3uorz5QgQVqgwkkKTnO24s99rLxUeUZPgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6109
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 16, 2019 at 10:11:54AM +0300, Leon Romanovsky wrote:
> From: Jack Morgenstein <jackm@dev.mellanox.co.il>
>=20
> The cited commit introduced a double-free of the srq buffer
> in the error flow of procedure __uverbs_create_xsrq().
>=20
> The problem is that procedure ib_destroy_srq_user() called
> in the error flow also frees the srq buffer.
>=20
> Thus, if uverbs_response() fails in __uverbs_create_srq(),
> the srq buffer will be freed twice.
>=20
> Fixes: 68e326dea1db ("RDMA: Handle SRQ allocations by IB/core")
> Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/uverbs_cmd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/co=
re/uverbs_cmd.c
> index 8f4fd4fac159..13af88da5f79 100644
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -3482,7 +3482,8 @@ static int __uverbs_create_xsrq(struct uverbs_attr_=
bundle *attrs,
>=20
>  err_copy:
>  	ib_destroy_srq_user(srq, uverbs_get_cleared_udata(attrs));
> -
> +	/* It was released in ib_destroy_srq_user */
> +	srq =3D NULL;

I really don't like that we ended up with such a mess of error unwind.

The proper outcome should be that uobj_alloc_abort() does a full
clean up, including destroying and freeing the HW object if it was
allocated.

When we forced the new uobj system into the write() path this was
never cleaned up, instead the abort just disables the HW object clean
up to avoid alot of code churn, while ioctl does actually clean the HW
object on failure.

Ie only one clean up path for uobjects.

I also wonder if there is another race here, this is also missing the
ib_uverbs_release_uevent() after destroying the HW object, but I don't
know if it could be possible for an event to be stuffed in..

In any event, the double free is clearly bad, so applied to for-next

Thanks,
Jason
