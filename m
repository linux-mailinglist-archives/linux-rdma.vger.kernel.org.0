Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 999AA7939C
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 21:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfG2TNp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 29 Jul 2019 15:13:45 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:33428 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728447AbfG2TNo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 15:13:44 -0400
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.147) BY m4a0039g.houston.softwaregrp.com WITH ESMTP
 FOR linux-rdma@vger.kernel.org;
 Mon, 29 Jul 2019 19:13:41 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 29 Jul 2019 18:57:03 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 29 Jul 2019 18:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNqEXYb5otQUpO7X/dDTiI2DbFF8e2uCuJk47Uk86F58FHveoWZgFSJspe64vS26WdbkAFK08ArSMdENfI3L3kbQKdo4hRtzPrso4605xI4Jjs8S7+Hlv6ehxm2KefocMk79GgOUhZOdq+R/gG/muxyD8o1AZA7WUIpaYZadv2tZdK/o5W4qz88HsqO4DqV2piTSarddYgY9UUMmCO0YK/5oOvmptmy06sOe40DUmnMC3PWnjMgkR+3pyb7GwXvNFVtKOlY6nGS3rVx39P0ozTKggzRmRPn36u3vDx+65D4YqWrT3tg4yoeVJPq0fY0P3yH8ufdKQT3UbLKGX24TgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv07uuejnX9xnQditZmtViGaq3Rm4/xaHsN+dCkivtA=;
 b=m+k/XlTRL3xL01SkWUV9vDKZD1dt/2kdhnyOoZQG6C9gGwd0C3Ne19yfdgqogkrXfDlUTD4xUm9st2tFKknSLds+Vk4u0d9mMrOZ1fJw+i2nbg8OWEPlZ6eMNYORECnM4X7tjaVhE815uRjdW5g5gaHYA6DpkIzpDAiiIoPAhzSq66tx8N9XSvLuSO5NoH1mVyrQRUbFYhUiP9OJVzu3ezW0Qnesol+m+QtbU3vEo2HU0+Mgj/xb3iSxD8Tad8Sc6V7KmFo6HSKbVWQc6BrRANVeQ+wCl2ThDOsLOA7nJAKBoJ5krzRAW2m6tpXP5XuIPQbSauhaTbzoJXzQGChzNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from CY4PR18MB1240.namprd18.prod.outlook.com (10.172.176.10) by
 CY4PR18MB1127.namprd18.prod.outlook.com (10.173.185.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Mon, 29 Jul 2019 18:57:02 +0000
Received: from CY4PR18MB1240.namprd18.prod.outlook.com
 ([fe80::e548:277f:9d22:e8f8]) by CY4PR18MB1240.namprd18.prod.outlook.com
 ([fe80::e548:277f:9d22:e8f8%12]) with mapi id 15.20.2094.017; Mon, 29 Jul
 2019 18:57:02 +0000
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: [RFC] mlx5: add parameter to disable enhanced IPoIB
Thread-Topic: [RFC] mlx5: add parameter to disable enhanced IPoIB
Thread-Index: AQHVRj9ohuRLHy8cmUmnUbAt1DZZQA==
Date:   Mon, 29 Jul 2019 18:57:02 +0000
Message-ID: <42703d01-0496-a4ce-6599-5115e49290af@suse.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0067.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::31) To CY4PR18MB1240.namprd18.prod.outlook.com
 (2603:10b6:903:108::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=NMoreyChaisemartin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.220.97.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f653238-6abc-4686-a362-08d714568a97
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR18MB1127;
x-ms-traffictypediagnostic: CY4PR18MB1127:
x-microsoft-antispam-prvs: <CY4PR18MB1127D28800E49CB0E20D22F4BFDD0@CY4PR18MB1127.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(54524002)(199004)(189003)(8936002)(68736007)(2501003)(80792005)(8676002)(19627235002)(81156014)(6116002)(81166006)(3846002)(7736002)(256004)(71190400001)(71200400001)(305945005)(478600001)(14454004)(5660300002)(6486002)(5640700003)(6436002)(6512007)(6916009)(53936002)(102836004)(186003)(26005)(316002)(476003)(2616005)(486006)(2906002)(66946007)(66476007)(66556008)(64756008)(66446008)(31696002)(52116002)(6506007)(386003)(99286004)(25786009)(36756003)(31686004)(66066001)(86362001)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR18MB1127;H:CY4PR18MB1240.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iDmr0UEf5fv4Sf1912GQzHsDpVrdXQHzXCfWPsgJlBvruvz/PgxonfQsYlN++Koi7S5S8vWEdKPfqhLHJq+pN534C9Rvfb0RkzVWSXyk7bUBq/W1SKHYDa6I0HR93wWYbg/rRVoNBoH+gagXHkach+E3V3FOAeZ/1T4jkg3/J1FCeljbG1vOaxVf/mwGnCrWQq/pRbgKUpyl9WPGhcO9urvWqBqBga6FpKZZlRKrhs8qSe5pv83dFFX0ui4ihXY0tjVie1kMOTWTUITCO6I2aIzwSODA3nSjiUy3ZLy30Ai14MD9xAXZVVtINCtse0jwevVSy/J6TOix3i3H/7oxSoNTLyqySGnExABBkVIvOlEIEq+/P0q3SOmvV7fgZvKPrHz6ToBPsacCzktzjURF+U9Ky7Xc0oYjluJJtOvfh5s=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <904EABF0F8E63E4EAA49A9E7A040C963@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f653238-6abc-4686-a362-08d714568a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 18:57:02.3170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMoreyChaisemartin@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1127
X-OriginatorOrg: suse.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Recent ConnextX-[45] HCA have enhanced IPoIB enabled which prevents the use of the connected mode.
Although not an issue in a fully compatible setup, it can be an issue in a mixed HW one.

Mellanox OFED uses a ipoib_enhanced flag on the ib_ipoib module to work around the issue.
This patch adds a similarly name flag to the mlx5_ib module to disable enhanced IPoIB for
all mlx5 HCA and allow users to pick datagram/connected the usual way.

Signed-off-by: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
- ---
 drivers/infiniband/hw/mlx5/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index c2a5780cb394..779a35883494 100644
- --- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -78,6 +78,10 @@ MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox Connect-IB HCA IB driver");
 MODULE_LICENSE("Dual BSD/GPL");
 
+static int ipoib_enhanced = 1;
+module_param(ipoib_enhanced, int, 0444);
+MODULE_PARM_DESC(ipoib_enhanced, "Enable IPoIB enhanced for capable devices (default = 1) (0-1)");
+
 static char mlx5_version[] =
 	DRIVER_NAME ": Mellanox Connect-IB Infiniband driver v"
 	DRIVER_VERSION "\n";
@@ -6383,6 +6387,7 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 		(1ull << IB_USER_VERBS_EX_CMD_DESTROY_FLOW);
 
 	if (MLX5_CAP_GEN(mdev, ipoib_enhanced_offloads) &&
+	    ipoib_enhanced &&
 	    IS_ENABLED(CONFIG_MLX5_CORE_IPOIB))
 		ib_set_device_ops(&dev->ib_dev,
 				  &mlx5_ib_dev_ipoib_enhanced_ops);
- -- 
2.21.0

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl0/QXMACgkQgBvduCWY
j2TqCQf/YjNVtRd/EbsZUt5bnwIevHPaETwJ7Xa88cjG8kW7THZCokom1fh5UWmV
4ZBGep2b4UEfeJ0u3NMI1ux3G9qFnhhE/hmwMNlsLalc2vQzqX0OIcvcYrpYwEys
ipo78KQjQHFSZAEc+AGq/PfvKp//zi/BWLRAivncF1nM4u3kQ0bO4eGK7NaNiLOK
D43hrAgsLLu+tYxFMX9rLi/RcZkHiMCJwMvp6i9PTKghSow7FbzyK2p8KSzBWzGa
urtYs66ckvyfHSoUKcoMlGfeTBbUYC8yziKqXobRbI7n4CttCxOlrNqLCFF1kzAl
PsnK1EDFTaKHamblNrdQzZTqLiywzQ==
=FENl
-----END PGP SIGNATURE-----
