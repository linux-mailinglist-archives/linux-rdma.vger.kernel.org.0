Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8814C135DB
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2019 00:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfECWtq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 18:49:46 -0400
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:8165
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbfECWtq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 May 2019 18:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XBwEns4M88qp2KJIPiP9CiHxcnkaegDxWJ8AtQPsG0=;
 b=KfETgl1FqBq0xXXMcHpdksU27oV7qzAhIVq8kKCpdFSQLmckB+MtobmZLQSxwTshliZYdgLK4K/04KREEcPb/NxmYW8nsRjnNeM05v9fm5G0Luy6nmyZ6OctffcYul4jkKeC6eDybMNioEm410jkkXYJNRBTk6poOm89e/p+47g=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5213.eurprd05.prod.outlook.com (20.178.12.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Fri, 3 May 2019 22:49:43 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Fri, 3 May 2019
 22:49:43 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eli Cohen <eli@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Add missing XRC options to QP optional
 params mask
Thread-Topic: [PATCH rdma-next] IB/mlx5: Add missing XRC options to QP
 optional params mask
Thread-Index: AQHU/+AhuQpRRpA73EOmalBpAxM1IaZZZSUA
Date:   Fri, 3 May 2019 22:49:42 +0000
Message-ID: <20190503131642.GA21998@mellanox.com>
References: <20190501053830.7186-1-leon@kernel.org>
In-Reply-To: <20190501053830.7186-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR01CA0022.prod.exchangelabs.com (2603:10b6:208:71::35)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [65.119.211.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08d1f97d-fe37-4fb2-7726-08d6d019a1b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5213;
x-ms-traffictypediagnostic: VI1PR05MB5213:
x-microsoft-antispam-prvs: <VI1PR05MB5213E43586087401A2E533C1CF350@VI1PR05MB5213.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(136003)(376002)(199004)(189003)(256004)(6116002)(3846002)(99286004)(33656002)(66066001)(68736007)(305945005)(6916009)(53936002)(6512007)(66446008)(64756008)(66556008)(66476007)(73956011)(1076003)(4326008)(6246003)(107886003)(14454004)(25786009)(66946007)(26005)(7736002)(81156014)(8676002)(71200400001)(81166006)(71190400001)(86362001)(6436002)(76176011)(186003)(2906002)(476003)(102836004)(486006)(2616005)(11346002)(52116002)(446003)(8936002)(54906003)(316002)(229853002)(6506007)(386003)(478600001)(6486002)(5660300002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5213;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ws7FgdexhqZmT9U6Jkcec5KnY9+KIiGy7nGYaVtAQBuyS2XdE/SLh88B3GbZozTyo7HdilT12jvxICT61bPuDriIj0+xps1M1l9mB1IZV446eLkZcjkEK6wKr7VkyyWK3q3/e7FxYm1WqvXkdNpF6G3/3rN/3/q+M3gR/Oji1eQYOfcKpcVBV2ce+7yosUqWrFgacEAimUhsujArwfSDhMhQMFTd4RLmZn4b+a8JnP9z4Wy90dUJcqJm+lz/rydkJI4BiLb7CSZbUbS0NLyQ/ZGKYmovWwLYqMxBV3Xl90WNUyKqhP6Vwb98f5fO4lFa4i3ckx98je+7ILbFQxeNX1kVgBwUVUCqPUkEK7d2Dlmg6KAFEJNfLgbwKLNm6IHxojGS4wkIKLwqaL+3jdb5sOhb9V5FCDadnjVOwHQYgvA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62B332B8D93B514399F7FDFD56F997DA@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d1f97d-fe37-4fb2-7726-08d6d019a1b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 22:49:42.9956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5213
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 01, 2019 at 08:38:30AM +0300, Leon Romanovsky wrote:
> From: Jack Morgenstein <jackm@dev.mellanox.co.il>
>=20
> The QP transition optional parameters for the various transition
> for XRC QPs are identical to those for RC QPs.
>=20
> Many of the XRC QP transition optional parameter bits are
> missing from the QP optional mask table.  These omissions caused
> failures when doing XRC QP state transitions.
>=20
> For example, when trying to change the response timer of an XRC
> receive QP via the RTS2RTS transition, the new timer value was
> ignored because MLX5_QP_OPTPAR_RNR_TIMEOUT bit was missing from
> the optional params mask for XRC qps for the RTS2RTS transition.
>=20
> Fix this by adding the missing XRC optional parameters for all QP
> transitions to the opt_mask table.
>=20
> Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
> Fixes: a4774e9095de ("IB/mlx5: Fix opt param mask according to firmware s=
pec")
> Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Applied to for-next thanks

Jason
