Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00BE4EF45B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 05:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfKEEJS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 23:09:18 -0500
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:9799
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728064AbfKEEJS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Nov 2019 23:09:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9JGg54PEhUgWrqjAtj61j/X5SnFTBnarGkCjRQYYT80/EqfY8P/ugETY80byhsWsBcyIeO5LOc59H8Hm9llWNtCKQ7n9T8X576U+0HWORin/Gr3d50nqQb90Rt8sNBdLZGy/W7xpvGwMdvtpD72npjWa9w3Wy3cBHWalxZw1R0SiTU3ncMDxtbOkzM+0L0Q+1SsV9CEHxOkLVK/DeK8kJGjT+oRtVem6HMftSQOLLdyVNGQo4NwQ4cx2835QGkzwOLJd/7qRFQ1cnuWxBilD7fsJs37XLRc6Y2py7OVEfD3aU8UkYOzWv9sALcjHuujMESI/hRGzTdy34p2cN2/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiMbosXBb6HrCM/VB283ZKmOGkLgcjFNjKE46XSQWcg=;
 b=klXQkWc2I1G6bklSEDGfOdW0ZQNkdjEgN32FDWLCNLwt2C9m7EgkuSchrpu59G7dmhIldWoh5LjMP5uiDMgPTuzF2oqvUpDN5W/TwJYolosdS424YoG8sxP0ih+G7FO7e7kpjQNrhqGeRfuoDm9tH8gZYccy8N//1jq6pRX08CIkuLl6PPOflC1kziCoEJRq4b2/OOIi3zp0LC6+abl4vtb6Y9y1quVWGOWJPO8fihHWEac8FJ+XbKwoztkjbrV3oVJYCm8sJ/bR7yNRiFODCnH5oVlskF6hTcuriAd/JtSsfn1IZ9/ENRNogseWJUkh1Ce9zXZbnYWC//zL8SyY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiMbosXBb6HrCM/VB283ZKmOGkLgcjFNjKE46XSQWcg=;
 b=b5k77eHRwPk92rqIbaDAOXAzS2Iq6qggXJaOj0cC7AAcWJkkjyqaI4E2qtwSmD2VX3UWMXIxW/EbAECLUETybhzKEXSKlgj2kMufOUibOiNVF9J17oO2xkH+2ZzPFyTmZrXj8uhcKiNjjQUvdfa78i/ruyq5fHsZAU0E5jVDjBg=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5747.eurprd05.prod.outlook.com (20.178.113.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 04:09:12 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::e5c2:b650:f89:12d4]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::e5c2:b650:f89:12d4%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 04:09:12 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Yixian Liu <liuyixian@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [PATCH rdma-next] RDMA/core: Use pr_warn_ratelimited
Thread-Topic: [PATCH rdma-next] RDMA/core: Use pr_warn_ratelimited
Thread-Index: AQHVk4vMK3Mc37DJKkWCrxmn97AfOqd79C5A
Date:   Tue, 5 Nov 2019 04:09:12 +0000
Message-ID: <AM0PR05MB4866B3612F0AE576136EED94D17E0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1572925690-7336-1-git-send-email-liuyixian@huawei.com>
In-Reply-To: <1572925690-7336-1-git-send-email-liuyixian@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec82:1c00:7198:5d2b:7ff1:d0d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab4f880e-7e4b-4b7a-c9f3-08d761a5ea3f
x-ms-traffictypediagnostic: AM0PR05MB5747:
x-microsoft-antispam-prvs: <AM0PR05MB5747EF476FF0F9CE4BF2A72AD17E0@AM0PR05MB5747.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(51914003)(199004)(189003)(13464003)(6246003)(486006)(14454004)(478600001)(99286004)(76176011)(7696005)(86362001)(74316002)(53546011)(6506007)(9686003)(110136005)(54906003)(186003)(316002)(102836004)(5660300002)(256004)(476003)(229853002)(46003)(2906002)(76116006)(71200400001)(52536014)(6436002)(25786009)(66946007)(7736002)(14444005)(6116002)(81166006)(55016002)(2201001)(4326008)(305945005)(33656002)(2501003)(446003)(8936002)(66556008)(64756008)(81156014)(66446008)(8676002)(66476007)(11346002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5747;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yDUJ0V16/AUG+8tp2dM76ABaccgSo/GRugguLDPaHBg69P5WjXlK21ZQ728T6g/2XveSkJuenPuK8xmRy7DdYqtZQXlJ6v2Dymoht6+ThreC+sWU0gect5bUpLq4nZYHyxUdI5ZtFU/dSxK4ekndtsdta+vbRkxfNnMzKQTmP0Y+0VoB28bTNhk+o1tNdngrkEJSjfLLMVdtnzsQQ5R0zgKSQ/BuEPSZ3FZyrv92KAw9jSZrzIYyvWaYiQ8ikKZ+GVmCCpe8hVSe97B3Rcpv4HciK1VobSp0CNoMH5Re62kj+75Ec7sm9hcURr7jwrpxgCkDYZKbDj31OPT3pAFn6A2XO5xxC/BA5SSzHpAkwZGgobi4jW+LxsBZPxezPmcYSDrPJecMLQDewRQCUfHq3QCR0/VqkJhikT/Fu2Fr2JFlDLsM7rZNHOOcGtp56X0Q
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4f880e-7e4b-4b7a-c9f3-08d761a5ea3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 04:09:12.2912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvrCU1b28MN7mmBf2B+SlCQNNjzT9jSxpZ2UEnDL+zyud5AORZa/KLt259Yyr70hcsjopZFgjShJBh98f3HUNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5747
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Yixian Liu,

> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Yixian Liu
> Sent: Monday, November 4, 2019 9:48 PM
> To: dledford@redhat.com; jgg@ziepe.ca
> Cc: Parav Pandit <parav@mellanox.com>; leon@kernel.org; linux-
> rdma@vger.kernel.org; linuxarm@huawei.com
> Subject: [PATCH rdma-next] RDMA/core: Use pr_warn_ratelimited
>=20
> This warning can be triggered easily when adding a large number of VLANs
> while the capacity of GID table is small.
>=20
> Fixes: 598ff6bae689 ("IB/core: Refactor GID modify code for RoCE")
> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> ---
>  drivers/infiniband/core/cache.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
Thanks for the patch. However, vlan netdevice addition is an administrative=
 operation allowed to process which has CAP_NET_ADMIN privilege.
So large number of VLAN addition by a user for a RoCE device whose GID capa=
city is small is constrained operation.
Therefore, we shouldn't be rate limiting it.
By rate limiting we miss the information about any bugs in GID cache manage=
ment.
At best we can convert it to dev_dbg() so that we still get the necessary d=
ebug information when needed.
I wanted to convert them trace functions which will allow us to more debug =
level prints such as netdev name, vlan etc.
I think I remember comment from Leon too while working on it, but it was lo=
ng haul that time.

Its base infrastructure is just got ready with Chuck Lever's patch.
So around 5.5, I should convert to trace calls.

> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/ca=
che.c
> index 00fb3ea..2990075 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -579,8 +579,8 @@ static int __ib_cache_gid_add(struct ib_device
> *ib_dev, u8 port,
>  out_unlock:
>  	mutex_unlock(&table->lock);
>  	if (ret)
> -		pr_warn("%s: unable to add gid %pI6 error=3D%d\n",
> -			__func__, gid->raw, ret);
> +		pr_warn_ratelimited("%s: unable to add gid %pI6
> error=3D%d\n",
> +				    __func__, gid->raw, ret);
>  	return ret;
>  }
>=20
> --
> 2.7.4

