Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32AF412D74D
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2019 10:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbfLaJTh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Dec 2019 04:19:37 -0500
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:29969
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbfLaJTh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 31 Dec 2019 04:19:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sn1t0Ic1VcZK2t8NIQ41JCmVWCcuoamlYSn43BmwIjtSqAg/0/3qT0y+SY4xYMC4y5QRfx5UEsnQLoANEPNIbCigsqEHZXh3FaZHluCkcTEGP0dG8x3GfpUtipokujh4fakmkQ3mOQnUxnJBi6TEy1xMxlHmWkuOjmxVG67zwU678dhZPrCmrv9Zil2BoC2eGBWwTjBwrsWCsTtNhyhkrUWcN1A49YHwNinCFItXXLrYsMAMpaZs4tfaHGz0heWrU3nrKpKag0s1Yd1j4QgaZEVH3xrGaXM6GfiVamF1OS94qnJIs2iyx87aUG6WtT1Pjkxu+3FV0gRT86Mnfu640A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8Imljte7VZKIvVcmEqU3yVFdcCQH6X5pYmn4pgUOH0=;
 b=JfgLiBdAUNdjdlFpB8dMB3HcPoZRoh8yYh1sGrvPPX6SaMJwZE2bTL18AHJK4LcgL7BodmPlsWsuhX+pAmTyL8IX8BddlDf3p8b7JKg8jbkBG4e/JnTDypequzBlSRHjTzVSpsyxNB2OkS9JbVs6ANag4Mqf2pbVfpQFfO9Qh7shWdxbSa0pRNfNsz9CB0Srii/z6s9N07Z05FoCRxipq7nnwS+g8f1PLEmyUPhFdowywOwK4cinSG+jyyYiXnGs/Kt5AbIXT2bzwBC6gbSQ45bPPJBFyV9j1opr4sXMhXRDo6q6pOFhLpno0QJUOK5i4aeDxEtKBC4x60x04UC1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8Imljte7VZKIvVcmEqU3yVFdcCQH6X5pYmn4pgUOH0=;
 b=TCorwN1eWVXMFKWb80Ncueu8Zz6P3KCJ5lUnrcDbCF7B4B8tK66W4T3HL29wJGqFb/1fTH6pZERAynqOQI6WuOlmCT6q4hhRM8F0Aqc7Vq6iRY6mb5vrSM5GcaqWfpPsBg8scAsIKIu4lls54tyfHE/pczsXoE1OAKyzD+PBSbM=
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com (10.175.21.136) by
 VI1PR0502MB3742.eurprd05.prod.outlook.com (52.134.1.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Tue, 31 Dec 2019 09:19:29 +0000
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427]) by VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427%5]) with mapi id 15.20.2581.013; Tue, 31 Dec 2019
 09:19:29 +0000
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (94.188.199.18) by AM0PR0102CA0016.eurprd01.prod.exchangelabs.com (2603:10a6:208:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Tue, 31 Dec 2019 09:19:28 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 3/8] tests: Decrease maximal TSO header size
Thread-Topic: [PATCH rdma-core 3/8] tests: Decrease maximal TSO header size
Thread-Index: AQHVv7tnOnozrMrzjU2CaN5hwyl3XQ==
Date:   Tue, 31 Dec 2019 09:19:29 +0000
Message-ID: <20191231091915.23874-4-noaos@mellanox.com>
References: <20191231091915.23874-1-noaos@mellanox.com>
In-Reply-To: <20191231091915.23874-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM0PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::29) To VI1PR0502MB3006.eurprd05.prod.outlook.com
 (2603:10a6:800:b2::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42f381b4-105d-4afc-d49c-08d78dd289e9
x-ms-traffictypediagnostic: VI1PR0502MB3742:|VI1PR0502MB3742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB374273780CAE83ACACE2F580D9260@VI1PR0502MB3742.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0268246AE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(1076003)(316002)(107886003)(36756003)(6636002)(2616005)(956004)(110136005)(478600001)(52116002)(71200400001)(66476007)(4326008)(66946007)(81156014)(81166006)(6506007)(64756008)(86362001)(5660300002)(2906002)(8676002)(186003)(66446008)(8936002)(6486002)(66556008)(16526019)(4744005)(26005)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3742;H:VI1PR0502MB3006.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iwuE8P6HKG+T/CPnCyeoYLaLFIDc7RtJ+DxZIuVti4H0n5aOYB8Q4cCa8e2sZ/WLWhgeAZdcsxylmXT7OTGh2XhE9enRXAUbOPnbda6avYSk02+KN69NwQpPCd1OdRZwLaEWovtekdPMtXFevvM+KeEGlEoo2Vag4aXfG9DxghsVQYAy65iSbwFX8iROLc5eQwg4RkAMkIZFX6fQas74zho8Xij2sqpM9Sl+K0BJs4tadI2/oA37ocVTHRbeZ48RhD/5quanJTEEKmW4fZ9NA6OBU1TsDYHgeduG6baLpDKkHLcbt8ChTu5B4ZbcdBUiJejbM3sD9bqwR2m5hGLDNbhZQul/v9Fmm+lcv3ZraWRCj3YbF06Mx82V93WhBTGq3wOvJOyKFCBrcwwywA2MMe9ZBgbQKmtryQmON90OcoNfYyUUY1IqBbtbnLOBFiw6
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f381b4-105d-4afc-d49c-08d78dd289e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2019 09:19:29.5974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRPGcRZzJNj5Luzor0N/yjyK5W24Yk5mB7KkFaQaXkaP/DHn/cjvRsGlsl7SDMmDybmLiUAo9PW2iaqN5mboDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3742
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When creating a Raw Packet QP with a TSO header, send WQE size
increases to accommodate it. If both max_tso_header and max_send_wr
are too large, the requested WQE size can become too large for the
device to support.
Decrease max_tso_header's max value to avoid that.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Edward Srouji <edwards@mellanox.com>
---
 tests/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/utils.py b/tests/utils.py
index c45170dbd329..d4d0d1ef49ef 100755
--- a/tests/utils.py
+++ b/tests/utils.py
@@ -224,7 +224,7 @@ def random_qp_init_attr_ex(attr_ex, attr, qpt=3DNone):
             mask -=3D e.IBV_QP_INIT_ATTR_MAX_TSO_HEADER
         else:
             max_tso =3D \
-                random.randint(16, int(attr_ex.tso_caps.max_tso / 400))
+                random.randint(16, int(attr_ex.tso_caps.max_tso / 800))
     qia =3D QPInitAttrEx(qp_type=3Dqpt, cap=3Dqp_cap, sq_sig_all=3Dsig, co=
mp_mask=3Dmask,
                        create_flags=3Dcflags, max_tso_header=3Dmax_tso)
     if mask & e.IBV_QP_INIT_ATTR_MAX_TSO_HEADER:
--=20
2.21.0

