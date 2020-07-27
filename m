Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C9722EA25
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 12:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgG0Kge (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 06:36:34 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:39177
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726278AbgG0Kgd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jul 2020 06:36:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M86VAcjmDw8QAPI1vbwqb9z5Yz+VqvarDtrDyph+c0kKZXq0zrDZlU13WODUwYHwfZWsauMjoECR2U92t8uwIDCGEePMzkvuEmrd84SzoSAAhg45yre9j4ZDIIdiJ8SxmG2p5guG7+yGqfqkoi9G1RPqrzHX+OcTFMQI3MXPb9DHrQkLCLKK50XWn3MRdD8OvuyFn7prBzPVyvO8hY3VeoGLz+ipShZ2pwdiRedMXUQ6G/MiFz1SEUsGyX6LJdjatL2NoCGQbfrNOz0S6zR5mAxe2kUMqyQxiqzYoWs70wPnWCljbDaEl+PcwcRr68YE+C+u5L+1f3F+0t40ytkTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/9j9OIn46sqVZubqOzQXVN6U2IwSvSDp/eaRMQqY44=;
 b=g2J9eomQsBiJzlgpLrQsRvUzMpQqk6kSUKZc9Ug182JrfTieEzzS1MgkwZXKsCEEQNkHHiIS8DniR3esldByN0w/37CvVHaMKlswO9of2y/x/8w7zcQ0ZJvRhvbbM8EBniinRLYrJAHKeHFWgqjPPGaIk34nlO0nVWEvMOiq5tIEi/AKek8ecsFf3TN3hzwKA9nBplVksKwwGBEQNjPa8h9ZWXZmCENeSR7k/iv49wKYShoXXRhtZq/QLREPKjImDRaLZmC9SlrtPXeVBtFlRhVszSA2Q+MIA78WxbLBg+aOwYQmS8qj294Xeoz6QR4cIxNlYN7q/3i5gMyBNd/bvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/9j9OIn46sqVZubqOzQXVN6U2IwSvSDp/eaRMQqY44=;
 b=DOX3CgbUIBEM8IZtnrXd04xtgVd692DFbTkr8o+tE+PoI/CWXRUaNDdzZDmFmaIuOKyOU4Juz4srCdcuE2MGUy+YLo+0wBWik4chr+MaQetk5phV8Gc66zmmvyX2ED8HuRtTtPZMuRNSA0pDVDWNzqmNk35WFCXBgZ0pSXsCzag=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (2603:10a6:208:c0::32)
 by AM0PR05MB5746.eurprd05.prod.outlook.com (2603:10a6:208:111::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 10:36:29 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::eccf:72b3:bacb:f09d]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::eccf:72b3:bacb:f09d%5]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 10:36:29 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Li Heng <liheng40@huawei.com>, Jason Gunthorpe <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/core: fix return error value to negative
Thread-Topic: [PATCH] RDMA/core: fix return error value to negative
Thread-Index: AQHWYi8CMNZFniXLvUG1VkRM5rCJo6kbPgdQ
Date:   Mon, 27 Jul 2020 10:36:29 +0000
Message-ID: <AM0PR05MB4866C7A9773DD28AB8ED7708D1720@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1595645787-20375-1-git-send-email-liheng40@huawei.com>
In-Reply-To: <1595645787-20375-1-git-send-email-liheng40@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=mellanox.com;
x-originating-ip: [106.51.108.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a9fbb55-466d-476c-7eac-08d83218ec59
x-ms-traffictypediagnostic: AM0PR05MB5746:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB574615A03458DD0AEDA0DF35D1720@AM0PR05MB5746.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: voh31uIVt3iXxpynFbNo3seL6HIfn2q7d+5gmmGZ7Xkrvxx2DLZtLDmwABV1APg4NsCgDGQaNRhJLXzGnQJyP8Brer9JMp+J70f5qzNiXem+z8smTs6RSDWR8kUNW1C5QwKILUnEwTeSrb2bMwvQeLwwY+CcupTsaTU0w5N2A5gFiXyRsaR+EW9ryqUukA8PEMtKSLP9MDapGu/wPn4RW+JQ92Pdc1YLYzMnTqdS71Cn4zyGu9c3pyilcDjEQ+EXkzGDdmPLYS+54BTbDsqbmaFEwVSin4404rWBM6/VnIUmCGZzuokrX6hRGiGDqsumHIee65WDBIwwQEz6fhCDMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4866.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(55236004)(83380400001)(6506007)(7696005)(55016002)(86362001)(71200400001)(66476007)(33656002)(66446008)(8676002)(66556008)(64756008)(8936002)(66946007)(5660300002)(478600001)(26005)(54906003)(52536014)(4326008)(76116006)(4744005)(2906002)(186003)(316002)(110136005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: V4Zd/8wvwq+0vNsu62FHWtof5VEI4g6g2PIRWLG01dzxSSh5dZBrg+79KutqdA0ZAaJuzyawcK5u3g0K12gDZ4adg4y1l2wV1DKeqwwY92CUd0BKuCC73Yg1PAy+nSDh174zWH3ANsdH5Ok8SfT634CzVZMAAn/pOrU9KbEbOf2ww2TpmDXHHV9heix2BEB0Sralq5uHcdCbRGejxZESSSXn81TpJfwcvF0NDn0cFUhqgLOBZPBSLxoNIhdbkQEVS3vDsGWVVvP0p1f674GRyMCaG+0wl/lYAoFQ1cBNdmdrrWikf7eheo7MX8pOEyB0SHztIkgead+R8jkp0D4ZWb2ufwYoJCnRjMSEEgnXkuhG6DqjYm6PYfuY2VaYKgroCVRT89pIED4N3Yby2k9xEMYLBZh34K/nlgsvpYt/L4nqJQpdLDF53ea501igWiabfcWW2xxEWgcP2eF9lIXtOWXocuPeWMQZY6lDWPsjTUZrJyfL5W+wckgF7Y8t6ApW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4866.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9fbb55-466d-476c-7eac-08d83218ec59
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 10:36:29.7907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeGFq3Cn9s0EOp/BaK/7WvokySN17QvgbiTkiX6+AH8TphDe1hkRJp1WKNzP1fEs6THXAoz2fZPTkAGuC9X16Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5746
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-owner@vger.kernel.org>
> On Behalf Of Li Heng
> Sent: Saturday, July 25, 2020 8:26 AM
>=20
> Fixes: 8d9ec9addd6c (IB/core: Add a sgid_attr pointer to struct rdma_ah_a=
ttr)
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Li Heng <liheng40@huawei.com>
> ---
>  drivers/infiniband/core/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/ve=
rbs.c
> index 53d6505c..f369f0a 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1712,7 +1712,7 @@ static int _ib_modify_qp(struct ib_qp *qp, struct
> ib_qp_attr *attr,
>  		if (!(rdma_protocol_ib(qp->device,
>  				       attr->alt_ah_attr.port_num) &&
>  		      rdma_protocol_ib(qp->device, port))) {
> -			ret =3D EINVAL;
> +			ret =3D -EINVAL;
>  			goto out;
>  		}
>  	}
> --
> 2.7.4

With below corrected fixes tag,

Fixes: 7a5c938b9ed0 ("IB/core: Check for rdma_protocol_ib only after valida=
ting port_num")
Reviewed-by: Parav Pandit <parav@mellanox.com>
