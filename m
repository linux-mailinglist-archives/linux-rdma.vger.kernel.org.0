Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3F9BE335
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 19:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440244AbfIYRRx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 13:17:53 -0400
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:46070
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730327AbfIYRRx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Sep 2019 13:17:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htuDqaerKf+ggLcYBuwUQPuEuq8PQxG+gb2KuPLZ5CpeSi7bILmlx6FK/QTElcXllGmSaWl1iOJjysOi4yGAiMkva9BPqxx1tdHch7+b/P0nvIKIT4WfFQ2866UYnj5FU2YMNJm03bI6SzBnfY2YENRgvC1HLOw9kHNi4e8joNadDBRAMyfhOZ4Luva9FRdGnT/Ja3MVPaX/td+XjBGIX47YAisAWy0s2ELRCJEPaPpsckxeHZzzryiYV0qKt8fv3pjz3s/ThHjmbACy4006M9WzSTxqNCDbh4wLPVF1qMnq3sAwmpYBaF0k7UmvunYfj4KlWcFgxMuMhm/+N9z0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILhjDjVRpOYZG2xgbMV4TXoKHd+E4IPrPIIJzBYwoto=;
 b=bEHJ63Owmrx2mtYthVhAdaOYOKroYS7BwzWOOA35d7xpj8k2LJ1ZXPBTD0uYfr+zRvWCDS9G+iLyq+7Ng2cvBaqoYaAOZLuvw+R3VQTFTzr2tfmCZGjlujLfMHPNFtO637THrLr7HDn7klGKXbAW6iuEvmIx1hGn5nditFt4/aBqzBWOhkdR6to+NLjiQ3kUJe2ZBGluQLmmenoSEoD1WYXRW/utTZFI1WuHssp3j8goCbmsPe1zPvUwBr/FrZNrh7nZRGSqg/dOBA+qxa988+X8hwNI5OTZC+/pWV6Cb5lNzKFO/WIoxGGcy/27sW3FpWtfWb76WpTetmH4mbRdsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILhjDjVRpOYZG2xgbMV4TXoKHd+E4IPrPIIJzBYwoto=;
 b=pzH0BukRvUmaR3tX/vemUR6rMtDSpd7RX1hkfhvOJrXfUvGE1yRpaSDfcpYnOi9pZMtgzkjeJl/OBWtbVfentPwvXpPw5TGkbtV9PoJ4fb5GtCVl2HmZPX7N9m8DYAJGZxEXZ7uxjYXQIlsVixG/FdawiWnNh6r0l8sGUO7BTno=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5283.eurprd05.prod.outlook.com (20.178.18.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Wed, 25 Sep 2019 17:17:50 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::bc4c:7c4c:d3e2:8b28]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::bc4c:7c4c:d3e2:8b28%6]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 17:17:50 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Yuval Basson <ybason@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "mkalderon@marvell.com" <mkalderon@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [PATCH rdma-next] RDMA/core: Fix find_gid_index to use the proper
 API to retrieve the vlan ID 
Thread-Topic: [PATCH rdma-next] RDMA/core: Fix find_gid_index to use the
 proper API to retrieve the vlan ID 
Thread-Index: AQHVc5MTM1a6voHI6kiBhGkmns3LeKc8omqA
Date:   Wed, 25 Sep 2019 17:17:49 +0000
Message-ID: <AM0PR05MB4866E99966FEE8C17A295228D1870@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20190925112301.10440-1-ybason@marvell.com>
In-Reply-To: <20190925112301.10440-1-ybason@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e5b4ada-524c-4be1-5e8d-08d741dc4ad7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR05MB5283;
x-ms-traffictypediagnostic: AM0PR05MB5283:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM0PR05MB5283950400414533B3D66E84D1870@AM0PR05MB5283.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(199004)(189003)(13464003)(6306002)(2906002)(2501003)(99286004)(4743002)(71200400001)(71190400001)(256004)(33656002)(5660300002)(7736002)(305945005)(74316002)(3846002)(6116002)(7696005)(76176011)(6506007)(66946007)(6246003)(478600001)(76116006)(102836004)(53546011)(66446008)(64756008)(66556008)(66476007)(54906003)(26005)(966005)(476003)(486006)(110136005)(4326008)(86362001)(316002)(14454004)(8936002)(446003)(81156014)(81166006)(66066001)(2201001)(11346002)(229853002)(8676002)(186003)(52536014)(6436002)(9686003)(25786009)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5283;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RlNkFNcZNwhUcvBE99iHsUBfLjtaN5uv5pkl4X1fZnr5Yu2oVtpCM6yerd1l0BwjBAarmOUMHnOAyzpzX5iHqIOgRcHDSCMF0gxcDQ8xTS0L1TtlxJMdrMe8GznubqIWKReQYDEyPBZmAu04Ve9bd2qu2/uxf9319doYdnDqSyhhk6fBKfrEHzWJkH9XTy1ZitLlmsaZOaQK4JEaDREzL6Axj/oyug2s/nbP61XVAPS+ZOh/nEwYaOdX6MoEIrfLcIZ6PUdNKvgqtW1Rk/IN6dR3eGUVLFO0e/V8D2s6ukhDAWx5cqeQKAnVRi8hhjWthD0QVPIpkLT6DzfF/GRrLz7GiAgpDVhdzD5/RGj/FeaLRmErSPg4DaUn38HWj3O59QJoqrw0q9auCxVTZj+rjXCbnehE4UXTjSV75YOn1diPctUe8I9U14AYHEsxBNFtBIONw6IupKmc8OfJQbICEw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5b4ada-524c-4be1-5e8d-08d741dc4ad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 17:17:49.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PsJpVeA8rF4pt6roghnYp6Tc3fudQZPSTuy/2QDOqqfI68xWr4/0/mJs8gnLfoEU5oW3RqyD4Wnpiz1Tb5k2tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5283
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Yuval,


> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Yuval Basson
> Sent: Wednesday, September 25, 2019 6:23 AM
> To: dledford@redhat.com; jgg@ziepe.ca
> Cc: leon@kernel.org; mkalderon@marvell.com; linux-rdma@vger.kernel.org;
> Yuval Basson <ybason@marvell.com>; Ariel Elior <aelior@marvell.com>
> Subject: [PATCH rdma-next] RDMA/core: Fix find_gid_index to use the prope=
r
> API to retrieve the vlan ID
>=20
> When working over a macvlan device which was itself created over a vlan
> device, the roce CM traffic should use the vlan from the lower vlan devic=
e, but
> instead it simply queries the macvlan device as to whether it is itself a=
 vlan
> device.
> Since it is not, the roce CM traffic is sent without any vlan, which caus=
es it not
> to be accepted by the peer which is running directly over a vlan device, =
and will
> thus only accept roce CM traffic carrying the vlan.
>=20
> Fixes: dbf727de7440 ("Use GID table in AH creation and dmac resolution")
> Signed-off-by: Ariel Elior <aelior@marvell.com>
> Signed-off-by: Yuval Basson <ybason@marvell.com>
> ---
>  drivers/infiniband/core/verbs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/ve=
rbs.c
> index f974b68..1d2d9be0 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -662,13 +662,13 @@ static bool find_gid_index(const union ib_gid *gid,
>  			   void *context)
>  {
>  	struct find_gid_index_context *ctx =3D context;
> +	u16 vlan_id;
>=20
>  	if (ctx->gid_type !=3D gid_attr->gid_type)
>  		return false;
>=20
> -	if ((!!(ctx->vlan_id !=3D 0xffff) =3D=3D !is_vlan_dev(gid_attr->ndev)) =
||
> -	    (is_vlan_dev(gid_attr->ndev) &&
> -	     vlan_dev_vlan_id(gid_attr->ndev) !=3D ctx->vlan_id))
> +	rdma_read_gid_l2_fields(gid_attr, &vlan_id, NULL);
> +	if (ctx->vlan_id !=3D vlan_id)
>  		return false;

A little shorter version [1] along with rdmacm support [2] are in Leon's qu=
eue which is needed for macvlan to work properly.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/com=
mit/?h=3Drdma-next&id=3D9811bdac481cf6278512a8d052c5ba91cfb69c71
[2] https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/com=
mit/?h=3Drdma-next&id=3Dd190d04808be104a2a3ef71841ff03c5ffaa16f8

>=20
>  	return true;
> --
> 1.8.3.1

