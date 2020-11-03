Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D1C2A4682
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 14:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgKCNbp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 08:31:45 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6385 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729326AbgKCNbo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Nov 2020 08:31:44 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa15bc30000>; Tue, 03 Nov 2020 05:31:47 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 13:31:44 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.57) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 3 Nov 2020 13:31:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcyAqX0fwXgMU6CvsKFjjhK/k2oHVY0d3oYhyUWfddmfbKxKbP0Rbgj19tPrRf5Ks/4QXC9Dx9irGQ/4fxxMgtiJgxWEc94S6aD7TstcuqYNj8bXg5fBJXd2g0rO1mEm5JRX0O7pQQ2bObeyBg5/jeEfBh2W6JC8J4XN80mUSGRvg9IRxYclWWBNQ51mEtYEuqSqySRfErjUyuAgQ+F7C1vBCWzgrQiWwX4ykkYlHC/rSkCjUpRldtet1ZYqbbwsXvL87JO3XwSMr6COGoqcKgUQfNtYChW6J5KK1AqccTUuaia2jY0eYJ8hdrpDjqoZcdV5mLLx+szdvjNY7aFtfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oH561qgewJDm2QueCEmp7Qrr94Fp/kALirPoe7rDMI=;
 b=VAogXI4KulXv8vFGedfIEYp/n57StVFONlqTq2hc3JdvRyxrpT5ndap9T93K+lheh9TxpTjuDEi0S2307CZXhjlRtGVdWSsCskB4ZxPEnAYZY4xZMD/p1eeCf7j2L519mINxWwYxzC7ikwxzE4htc4Tlj8EaICkVrF8Mz0aNCkWNYCzCQNrBLLAzYLLsbH/kt3rCcFriwq8eLike1B0zCSqCyo9oHMRqEKpbtvZFb0bbzjeMlMA9tAB/HYslGt7Ft4hzALHobK+oOfRPxPAz/HrPx7T9qfnMXXtKDqeAfg8lXTL3XpbRUjhBy6Pbh1SRbyfRMA+eZg/kGuPtC0NW8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB4760.namprd12.prod.outlook.com (2603:10b6:a03:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Tue, 3 Nov
 2020 13:31:42 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105%5]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 13:31:42 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Doug Ledford" <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH for-next] RDMA/nldev: Add parent bdf to device information
 dump
Thread-Topic: [PATCH for-next] RDMA/nldev: Add parent bdf to device
 information dump
Thread-Index: AQHWseUFa8s51ZXrO02crXmgHvhE86m2Zv/w
Date:   Tue, 3 Nov 2020 13:31:42 +0000
Message-ID: <BY5PR12MB4322DDA3AB63B3073FC63989DC110@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201103132627.67642-1-galpress@amazon.com>
In-Reply-To: <20201103132627.67642-1-galpress@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [223.226.73.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 772db549-69a9-4b10-01a4-08d87ffccd25
x-ms-traffictypediagnostic: BYAPR12MB4760:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB47603394714C3CF03C612905DC110@BYAPR12MB4760.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k6pvpeB00zP56WCpJp1hDziurtQj0qIfunSrGRLATtOOG4BjMWY23j85G21cmvr1sGwOzKozJIRIwa+J6H3+vCKbB64mooL77kyjfEDe63EqXyUO5pxdv/ax7o2ot4dBNtQAClHcqIBacS5LU86zLPU1+lgiHmlbcVPqGZzKSfufMOjBKjQRPEsZH4ouuxIu2pxvx+oz73veCFYY1tQbq9HvU+EXcR4H7ntFPc0mhLEpOib1ITlQNWFdsgD1Wcd5oO8YxA5daXckN+kO4oVTbOL2AlPDdfsYTQNLvd55DGKcCS+pP8JnC7M604zlV5hTlv5WhP9ImjAYD99W2fABHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(66556008)(64756008)(66446008)(55236004)(66946007)(76116006)(52536014)(8676002)(33656002)(4326008)(8936002)(107886003)(186003)(6506007)(26005)(71200400001)(83380400001)(66476007)(2906002)(9686003)(478600001)(55016002)(86362001)(316002)(110136005)(54906003)(7696005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: C7vOJSN3DWWisdCipfIRbhuI3MuKkdUQn0Q4Lwhp08UBDgXKGEQ75elKGkwufz7k6yCrhm9OWaKwXPztiMRsZHDHcvNhHXXhbJoTcqgL9ztAnn+ZTKY2v+W2F9yD8PQ9dfskd8T5gXmcFbDP7nUr5uWoKzpMchH+2FnnA6ZVutP9TnkauY7y6R32hKiouae6Xl9JzycosKvIKKO3vY01JavCTrrueQD34JbiVWItZq17RA8XHySZQKDXkcqOKB8I3nd1hRiFSexHGdBPTVVS7JYri3axXKAVHvPDhaRsxVHKFQJ4IeSSzNNheXg1QoZlxB3U1NvlhyEf35fqIDqqd+DrfONQtEjrauJqmCoFY8eDmyXVWXX9/MHra+UiqP0eVTwtWCD1/NWOEHj/bZFg3lcF2MwDkJsg1w7SGxt6me29FF5+2awEOIskmxCKOTdvCykeoHABb9xJugC1VdCeKOY8Ok2AW6YodKWxz+cbnROSCF33YkZ/YxuJc4DI/unQ6b7042GNbPYW9cgLo2k1aLzwcB3LS0SBPVVP6ByufN0cXDrOKRfjhkDYNuB3krbCsD3GlruuTAJ68LujjwCaJk6plaWJRkORqRM7Wnu17mgmQSS/eyiONLbhKqKsZclXb5nU5Xdz3sihOsYjbqN/ow==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772db549-69a9-4b10-01a4-08d87ffccd25
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 13:31:42.1542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RTNqmpJ3unQvrp2sYEO99L3LQQ4Hmpr++qmToTdnmYKg/0BYeobLfv7LNmvF+SZ4RlG9wK5XLvAJP/LJjOvOVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4760
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604410307; bh=+oH561qgewJDm2QueCEmp7Qrr94Fp/kALirPoe7rDMI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=FVFz19OIKuGzKBtdj53Bse6h4UVy181lnDnv1WS8fXDwWNnx3yaWAPr/vlbbHoVrS
         LdV9U8uNpyXUTYRg856HgQtF9zDE9fm/5r4dPYsG+N4A9xkIXsX/Wup5l8JRdIawcp
         urx1y+LSpfPQhAu3TiW9QpNHxuvmnYc96ltZQEZMVbShx5n3NTmBfuAD9W0vk4Y6WW
         b7RHkjEiBYm3R5+1VdY74fpOBSgrSNypWUVRDwNb+Sq3SQpP+PTYpEs2YbNNfnYFHY
         unvWvvjsJJW1hevf/Sc+i7MNxztaY27O/1bGdc8JF7GBfochIaZXk6CZi40aldmGrr
         wM67Hhdy5zLIQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Gal Pressman <galpress@amazon.com>
> Sent: Tuesday, November 3, 2020 6:56 PM
>=20
> Add the ability to query the device's bdf through rdma tool netlink comma=
nd
> (in addition to the sysfs infra).
>=20
New netlink attribute addition needs to show an example in the commit messa=
ge for
$ rdma dev show
or=20
$rdma link show=20
Whichever applicable.

> In case of virtual devices (rxe/siw), the netdev bdf will be shown.
>=20
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/core/nldev.c  | 10 +++++++++-
> include/uapi/rdma/rdma_netlink.h |  5 +++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nl=
dev.c
> index 12d29d54a081..9704b1449c01 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -291,7 +291,15 @@ static int fill_dev_info(struct sk_buff *msg, struct
> ib_device *device)
>  	else if (rdma_protocol_usnic(device, port))
>  		ret =3D nla_put_string(msg,
> RDMA_NLDEV_ATTR_DEV_PROTOCOL,
>  				     "usnic");
> -	return ret;
> +	if (ret)
> +		return ret;
> +
> +	if (device->dev.parent)
> +		if (nla_put_string(msg, RDMA_NLDEV_PARENT_BDF,
Not everything is PCI, BDF is too pci specific.

So name attribute name should be RDMA_NLDEV_PARENT_DEV and additional one a=
s PARENT_BUS

> +				   dev_name(device->dev.parent)))
> +			return -EMSGSIZE;
> +
> +	return 0;
>  }
>=20
>  static int fill_port_info(struct sk_buff *msg, diff --git
> a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
> index d2f5b8396243..7495104668eb 100644
> --- a/include/uapi/rdma/rdma_netlink.h
> +++ b/include/uapi/rdma/rdma_netlink.h
> @@ -533,6 +533,11 @@ enum rdma_nldev_attr {
>=20
>  	RDMA_NLDEV_ATTR_RES_RAW,	/* binary */
>=20
> +	/*
> +	 * Parent device BDF (bus, device, function).
> +	 */
> +	RDMA_NLDEV_PARENT_BDF,			/* string */
> +
>  	/*
>  	 * Always the end
>  	 */
> --
> 2.29.1

