Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6652E91C3D
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 07:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfHSFGe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 01:06:34 -0400
Received: from mail-eopbgr40054.outbound.protection.outlook.com ([40.107.4.54]:55364
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfHSFGd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 01:06:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjlBn/U5/YSpwjgcjH+VK2dWh2RfsEJ+gzMWR2qZMgyvAF+oIIOdAz0/eF9PAK5Z/v5okE4Ytc2Gato+EAd/fxAMzRkTyhYCxHbbwuzYZ5spJQTGucPFnJeTCX9fHZMUsiFv8D2G1eRAZIkhFe5/R0FqxyULFEolTcSFOTzJUii1jkFbtuQU7AiLn+96FoKsk3dZ9SetdpygHBQLI/EODgupGbmKRrENIDaQ25O1+XBdnEcYTa5yh6EyX+JA2oMUJfsHxZjfgAlu6AlvycwQiJ65M5YL+XYWn9Ph2J0NOeBaAFLwnN/hC8HpFogbj9pRUzektf4uK9tL9+q8raCiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPxiOFoaXgb2OADOUnZ2ZKTJIPKdy4BTXCbFkdwXBGg=;
 b=bD/jZZgTFqxD713QBDGfgfciKiuuaYYWY1DKZzNpgTPB8OLuU6iYfYdMLkpzxUGYMnk4EZ2vdFiSENHKlRc51FHtZmI8tvmei+vLxxl4EgdKIoLE4xNq6w2oYc/5d2F7tMQ+/A4Gf+q0jnhFcNIbJN4eJV9PmL1VydE8X8S4uShhyTAvjJik7iP+Qopwb0TQ6blBhN78Ky+mtrf1Ds/jOrOfNcFkbTNWNXXnjdllHaH/EaE4TZZYL1VLfSl8HHH6xzVuH+pkJwCfbSj7oXTtpdxwfZo0vNSP+TuyA0Ce/9MSXwRY05+UUGRkrkk3G3Y9n1YRedO0LbXNheFnVfMvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPxiOFoaXgb2OADOUnZ2ZKTJIPKdy4BTXCbFkdwXBGg=;
 b=jeGXgUrsz33PuwdSchFKnh9k7MlEWg3f3I+/14LqiTwvqPvoyYnJiZKW6r21DKigmkzZtMiFfQN5uxMgaRdVwmURN181snkmsanWpd2i0mmuQcsD/WUYou2JuLLO/EDI8DIAa3lWvPrp1TwrvW+YBtznx0URX203sBCJawolZuE=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5634.eurprd05.prod.outlook.com (20.178.114.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 05:06:30 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::216f:f548:1db0:41ea]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::216f:f548:1db0:41ea%6]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 05:06:30 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     zhengbin <zhengbin13@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Danit Goldberg <danitg@mellanox.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: RE: [PATCH] RDMA/cma: fix null-ptr-deref Read in cma_cleanup
Thread-Topic: [PATCH] RDMA/cma: fix null-ptr-deref Read in cma_cleanup
Thread-Index: AQHVVkWODkBVCopgKkmigQdKB2CSF6cB6uCg
Date:   Mon, 19 Aug 2019 05:06:30 +0000
Message-ID: <AM0PR05MB486617E43CBB7128D907C36ED1A80@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1566188859-103051-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1566188859-103051-1-git-send-email-zhengbin13@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.22.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 901e1752-e8f9-4cf2-2110-08d72462ff72
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB5634;
x-ms-traffictypediagnostic: AM0PR05MB5634:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB563459261795BF8232E1F233D1A80@AM0PR05MB5634.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(199004)(189003)(13464003)(446003)(6116002)(110136005)(3846002)(81166006)(316002)(256004)(66446008)(66556008)(66946007)(305945005)(76116006)(14454004)(6246003)(25786009)(33656002)(8676002)(478600001)(71200400001)(102836004)(229853002)(6506007)(53546011)(9686003)(55016002)(26005)(66476007)(64756008)(55236004)(7696005)(186003)(76176011)(71190400001)(6436002)(99286004)(66066001)(2906002)(7736002)(74316002)(86362001)(2201001)(486006)(11346002)(5660300002)(52536014)(476003)(9456002)(81156014)(8936002)(53936002)(14444005)(4326008)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5634;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ppw9D5jVuC1j1NKJfbO1BA4TNA71rxQkVKa3VlZc33m737ghtU/ZKZiYj8jPKdULYG9Ky1jDjGQjxyu5TSbRv/Gvy/g6sPBWEx6L5twE+60RYA0lQoPBu+6RfEDTuokhVMW7VglOJV6TVR9mK6CtfEpGaxaFf7aPpRwkPmrppDMZdvhip8BUM0vOIbLWZwLyyqTfEZDjce7L5zcy+CE4YgyeOwEjN4ljSaHfT9Coklk5+NzyzS/0+Z8kRgGudvZmWFKwlOWOeZwjHdZHuoe+iJ/iGMRLe4bYKGmBFyFDJKzElmtZ0EiuNnB5pBnuFodRuaKer9/gtWsCIzJyE7ySptfjbuoBpuXhH4eV8mvH7GX4WdWFPn1d0C7FII12Eooj1eNTPHXGmEbHwYpGStf9G+r/w26ihfSl57cHC4qyEbY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901e1752-e8f9-4cf2-2110-08d72462ff72
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 05:06:30.6339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KK2LT0TiEHmFUVUDg8jpV8jXPe+hkJWiQN+mIOxUaO7mmilC5f4PKEM6+nJSGyplV6LDmdAeCIYAsPcuwCygxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5634
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: zhengbin <zhengbin13@huawei.com>
> Sent: Monday, August 19, 2019 9:58 AM
> To: dledford@redhat.com; jgg@ziepe.ca; leon@kernel.org; Parav Pandit
> <parav@mellanox.com>; swise@opengridcomputing.com; Daniel Jurgens
> <danielj@mellanox.com>; Danit Goldberg <danitg@mellanox.com>;
> willy@infradead.org; linux-rdma@vger.kernel.org
> Cc: zhengbin13@huawei.com; yi.zhang@huawei.com
> Subject: [PATCH] RDMA/cma: fix null-ptr-deref Read in cma_cleanup
>=20
> In cma_init, if cma_configfs_init fails, need to free the previously memo=
ry and
> return fail, otherwise will trigger null-ptr-deref Read in cma_cleanup.
>=20
> cma_cleanup
>   cma_configfs_exit
>     configfs_unregister_subsystem
>=20
> Fixes: 045959db65c6 ("IB/cma: Add configfs for rdma_cm")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  drivers/infiniband/core/cma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.=
c
> index 19f1730..a68d0cc 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -4724,10 +4724,14 @@ static int __init cma_init(void)
>  	if (ret)
>  		goto err;
>=20
> -	cma_configfs_init();
> +	ret =3D cma_configfs_init();
> +	if (ret)
> +		goto err_ib;
>=20
>  	return 0;
>=20
> +err_ib:
> +	ib_unregister_client(&cma_client);
>  err:
>  	unregister_netdevice_notifier(&cma_nb);
>  	ib_sa_unregister_client(&sa_client);
> --
> 2.7.4
Reviewed-by: Parav Pandit <parav@mellanox.com>


