Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B435712D74E
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2019 10:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfLaJTw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Dec 2019 04:19:52 -0500
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:29969
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbfLaJTw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 31 Dec 2019 04:19:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=de8qqPTHwJQhnpFBSOUP5jfbN2Ao7fXVL+gxlbLwDY+JM76jc5L8xcVewgPiiHyrjuQE7tl2d1vu8QKqPxvey7F54sYlAlWsjIhaZR6aqzeyJIdFT+BfBUTqz8FU82pGtfhCaWogYZ+BUFLNncFSa0o5v7kPuU/VMpMUv8qvsJC7L0OpBWvpJsK6rij8IfRR4gyhMZfP5hUahDiP8J2Ckdcsd8e/Lra60NMLl3wyjKB3E9zLsdduBD4+8dl2RL6ME0HaW22CKm5Xidsy5OVzfj1mlOBbw64kqVNsgY7ImpnGWGgbV8QphnZ20mp5aVrHucMNjlB6WKTxniRYDqO3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1mVWMZaAJpgYwMP57ixZjJKmz8D8ZlsTCcOGOluzi8=;
 b=bNlqYYkXlk2U204KWJBwIpUNxpdGRBHcZvmQ0Rdnkko2XeklLVpL+whHaK7HMMi7xDj/0+/SlGgADXI94dDRM4O+OG6XR6Sd5xLN0JrIFYUFZMYt1cjwkMe4Q1i1MnsJKtVshBAv8xmjzE4DIL+Ne09r0p9tnE60FcPkJsGGMvNxK96IzGt1tjgdFCjToBBF+/luNaaIz14LTP5QVL/REhIedjWabMF2utZjrarbkU5PIQCzScvyCqsbNfu3lDdiWsSKx03E7f/VrejbGFwmenFuKF+4eoWEysicrnJJdoT9iA3/t0wMZY4tPxOMvAqWNGxnY9VmTD8dsT2A0FJZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1mVWMZaAJpgYwMP57ixZjJKmz8D8ZlsTCcOGOluzi8=;
 b=rePAFYxy7yw/C26+EHTGvQRpPNBJRhJ8tk6wbdmWwYsCiLB6jfSdaK5PQneq/1myK1VZaCz/cp2klzhhJTDkNLDfVw9xnlwLNRXUgTwDYWfp0ffeCYNyYzxbHHsaZUhhmevt7dh/EMBCWcpv59pJexIg4DXkwOjcPzM7LWy2uaU=
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com (10.175.21.136) by
 VI1PR0502MB3742.eurprd05.prod.outlook.com (52.134.1.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Tue, 31 Dec 2019 09:19:31 +0000
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427]) by VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427%5]) with mapi id 15.20.2581.013; Tue, 31 Dec 2019
 09:19:31 +0000
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (94.188.199.18) by AM0PR0102CA0016.eurprd01.prod.exchangelabs.com (2603:10a6:208:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Tue, 31 Dec 2019 09:19:29 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 4/8] tests: Use post_recv in the right place
Thread-Topic: [PATCH rdma-core 4/8] tests: Use post_recv in the right place
Thread-Index: AQHVv7tov13T5Yv6CEGSW9QUK32fQQ==
Date:   Tue, 31 Dec 2019 09:19:30 +0000
Message-ID: <20191231091915.23874-5-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 49b455a1-70e5-45f5-bb7f-08d78dd28ab7
x-ms-traffictypediagnostic: VI1PR0502MB3742:|VI1PR0502MB3742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3742CB91C6BC9161D642B686D9260@VI1PR0502MB3742.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:128;
x-forefront-prvs: 0268246AE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(1076003)(6666004)(316002)(107886003)(36756003)(6636002)(2616005)(956004)(110136005)(478600001)(52116002)(71200400001)(66476007)(4326008)(66946007)(81156014)(81166006)(6506007)(64756008)(86362001)(5660300002)(2906002)(8676002)(186003)(66446008)(8936002)(6486002)(66556008)(16526019)(26005)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3742;H:VI1PR0502MB3006.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oSHY7vXl/8rif54UcJkhM44Ot3qUylgIfLVXTUycZaCyvIaJjjPQE2EXQB2jtxmC52cW1EV1G1Rchelz5y4CnCuGiYD3+eacCVWpJ47BMf7Opq7cU8n/c0BmBRdyLBLi44zOCFODCdC3IFlMOTkRq0yWHiNM08EFFBhW1XsbWEBAKgUcirkTk2L2IWmrO3+rXlqS9WnEyuxaj8vTlZV2zZnRXmQwew3sPc2wFQVAGmQ1JSPWXEhCai2dutvjuYdxq3/S4WRhifwRlKL61uEZHnhMYg/mojhwDblDDLLL42CTQ8obSX+hgrJbTzYml9DoWLvEVWsZ55vK4502IcFGSdqy+K8iQ4keJWXE0I+O1WJVWwAMvhfco/vTDQgqkHiW+96DhYTDdbNxCCJ0FEtAWO2LTGHBde5e9PZdJu6eP3EZANuzAm4ZvwqvgKjMSdwn
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b455a1-70e5-45f5-bb7f-08d78dd28ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2019 09:19:30.9118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYQ/APSNQ0MEcHj/n7NxKr41kPrhfnKnNGjLbR3PX+/9a+QYnmHsQYxkTRTwosWR4uv6gMWuNDT1WjOpQkDGOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3742
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In traffic() helper method, do post_recv after a recv WQE was consumed
by the hardware.

Fixes: 6fb2b9bade55 ('tests: Add traffic helper methods')
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Edward Srouji <edwards@mellanox.com>
---
 tests/utils.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/utils.py b/tests/utils.py
index d4d0d1ef49ef..47eacfee35e5 100755
--- a/tests/utils.py
+++ b/tests/utils.py
@@ -420,14 +420,14 @@ def traffic(client, server, iters, gid_idx, port, is_=
cq_ex=3DFalse):
         post_send(client, c_send_wr, gid_idx, port)
         poll(client.cq)
         poll(server.cq)
-        post_recv(client.qp, c_recv_wr)
+        post_recv(server.qp, s_recv_wr)
         msg_received =3D server.mr.read(server.msg_size, read_offset)
         validate(msg_received, True, server.msg_size)
         s_send_wr =3D get_send_wr(server, True)
         post_send(server, s_send_wr, gid_idx, port)
         poll(server.cq)
         poll(client.cq)
-        post_recv(server.qp, s_recv_wr)
+        post_recv(client.qp, c_recv_wr)
         msg_received =3D client.mr.read(client.msg_size, read_offset)
         validate(msg_received, False, client.msg_size)
=20
--=20
2.21.0

