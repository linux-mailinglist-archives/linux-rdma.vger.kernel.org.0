Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE381124788
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 14:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfLRNCr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 08:02:47 -0500
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:39813
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726718AbfLRNCr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Dec 2019 08:02:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoVWsDkESYNziDQC87jCvgwwNL++4eTWeTnY8211Yub2uzpxG9IRCpDob4niWdRxMdZFq/fuY3qR8V8giS+gOgJL+XFx9mBb9HiNDeX8G+/iGtwqKfR/pJVqMZ2yC4G2MYD3n1ybb4Y1Gl1e8FY/F0U4dpqpFsV77bZ0SD/6zctpNaCWa8WiLVO6zPyH++mbzUo4NUhuLCQpikOayHY4vYcpqGKWO528Ry9KEDRFPkg4huQT+5b8NTHbBQ1+hfWex2sshZlIabmO9qImysMTQKgf4sE6IAmMfORnhq3dzoEFL+Hhs+FxuKOu/VDjVt5ZH5451fdrEEZS2bTUqs8Q0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UsZwTsQ4L9eOmauYmtxHgd05gIy6FFKuPQC1GSdxio=;
 b=BJZd8qj3hYIOgB46VdMy+XvWM+0GIv8b3ul2TFGth9s13vC/2WTRukKIG7RxwxMqWrKITF4OLB7MVqcpwLhMSYHJ/ppaGQur6ELIN1GRw6pQdELD4YwUP4H9uaBKByE4b1oAxSjoR98WiFXs9TAuTjiGPJio8a77ED2iocQanaHash7vL9BKyU4ERWRK8dhMP3C49sYSBq14rF5/Bh3xdJpri6nT0ZjZL5YR+VmY7sRceQAvYQk3UHd+A3bQqnhDtEYtDPQZe49CRbUNcwHWyVNyvyqf8uy9QTX9zw4iHx/rIh6hJvxJvWpxZIgBtEVRv0rE/q8BSfq6pcEU23rX8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UsZwTsQ4L9eOmauYmtxHgd05gIy6FFKuPQC1GSdxio=;
 b=VHYzClfSaPoOTKCqAjsmCqJzPmVYV2qmxCz5o2sR07MHmgyiEeLGN0aDxUPq7NWqCy+prZ0Qh92LaCTiq00GLMApFND5pZJNWovyjv1Tnbwxb/4kXYNM9dJDjCUEFjwpvKs7m7Vl//5Y9XokowZ+QI21z8wLUXLKTw3aobvFa0c=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB5093.eurprd05.prod.outlook.com (20.177.35.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Wed, 18 Dec 2019 13:02:31 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::bc8c:12ca:edd3:92ca]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::bc8c:12ca:edd3:92ca%4]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 13:02:31 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 3/3] tests: Some cleanup
Thread-Topic: [PATCH rdma-core 3/3] tests: Some cleanup
Thread-Index: AQHVtaNoRHlseBtdv02G2wZUyHzIlQ==
Date:   Wed, 18 Dec 2019 13:02:31 +0000
Message-ID: <20191218130216.503-4-noaos@mellanox.com>
References: <20191218130216.503-1-noaos@mellanox.com>
In-Reply-To: <20191218130216.503-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: ZR0P278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::19) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7fe6c08-01b8-493b-6e14-08d783ba8afd
x-ms-traffictypediagnostic: AM6PR05MB5093:|AM6PR05MB5093:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB5093B55564CE7B67962AA801D9530@AM6PR05MB5093.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:241;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(199004)(189003)(86362001)(1076003)(316002)(6486002)(478600001)(6506007)(5660300002)(66446008)(64756008)(66556008)(66946007)(186003)(6636002)(2906002)(26005)(81166006)(107886003)(8676002)(81156014)(52116002)(66476007)(71200400001)(6512007)(54906003)(36756003)(2616005)(110136005)(4326008)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5093;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oSUO1kdq4M52THTrNknuQRwJyB+1iqoRY5eB9x/Nuars+EvosPaqVEOQX/l705EYS47gyKfjVZrTO5kFtrvmwz7sPHwR1eM1yJZzMFxUFSHeVzavnrJw7JH29exoRSGdL+F/+5zXO0xhi5brtMSyyQZDpbbxLvo9vhza5cnD95XhAUDn9Hm8q4FYL3GvFTAiE7Cly/K2cb5Nnbwle77NuhxoEMvTI2BozgkEssCqc/Y1lMB6AAF8EbAj8/jOUYe5D9vFB2FrUcuIMQQot3Xyd5a+heHR2Gas5Ucr+OTPl9fIxsTqt17rrwkb2wn+0xJXVEmeBzEoNzvG7Q/fZHXWHrfk958ox6+0dDRGlwaonKO+lmvsXJOL4AbV5Ptc1JtfBeqsuTciNK1ZjEApX1yxJGEJkINeJFEnSTaA1xE4+sJNNltValshmQ86F6P9lG1q
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fe6c08-01b8-493b-6e14-08d783ba8afd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 13:02:31.7623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHFAWT94kv+KvhfwdLc8s2BP6UYzQ0/u0GBGOiBqq2i8m/Ha1LqhglwBnnpUV1bwHZLN2Xnl7gd3yKBzsLPy2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5093
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some classes' constructors were modified to include 'not None'
parameters. Checking these scenarios gives no additional coverage as
it checks Python/Cython and not rdma-core.
Remove these test cases.

Adding TSO header to a QP's init_attr_ex increases send WQE size. In
some executions of the test, the randomized value of max_send_sge is
too high combined with TSO.
Decrease number of send SGEs in case of TSO to avoid these failures.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Edward Srouji <edwards@mellanox.com>
---
 tests/test_mr.py | 14 --------------
 tests/test_pd.py | 12 ------------
 tests/test_qp.py |  2 --
 tests/utils.py   |  3 +++
 4 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/tests/test_mr.py b/tests/test_mr.py
index 1b5482884be6..742c6032b1b3 100644
--- a/tests/test_mr.py
+++ b/tests/test_mr.py
@@ -45,20 +45,6 @@ class MRTest(PyverbsAPITestCase):
                     with MR(pd, u.get_mr_length(), f) as mr:
                         mr.close()
=20
-    @staticmethod
-    def test_reg_mr_bad_flow():
-        """
-        Verify that trying to register a MR with None PD fails
-        """
-        try:
-            # Use the simplest access flags necessary
-            MR(None, random.randint(0, 10000), e.IBV_ACCESS_LOCAL_WRITE)
-        except TypeError as te:
-            assert 'expected pyverbs.pd.PD' in te.args[0]
-            assert 'got NoneType' in te.args[0]
-        else:
-            raise PyverbsRDMAErrno('Created a MR with None PD')
-
     def test_dereg_mr_twice(self):
         """
         Verify that explicit call to MR's close() doesn't fail
diff --git a/tests/test_pd.py b/tests/test_pd.py
index a8d6eb2fb69f..d1b9c7e8a94f 100755
--- a/tests/test_pd.py
+++ b/tests/test_pd.py
@@ -40,18 +40,6 @@ class PDTest(PyverbsAPITestCase):
                 with PD(ctx) as pd:
                     pd.close()
=20
-    @staticmethod
-    def test_create_pd_none_ctx():
-        """
-        Verify that PD can't be created with a None context
-        """
-        try:
-            PD(None)
-        except TypeError as te:
-            assert 'must not be None' in te.args[0]
-        else:
-            raise PyverbsRDMAErrno('Created a PD with None context')
-
     def test_destroy_pd_twice(self):
         """
         Test bad flow cases in destruction of a PD object
diff --git a/tests/test_qp.py b/tests/test_qp.py
index 35a20adec5f1..e7fc447937fd 100644
--- a/tests/test_qp.py
+++ b/tests/test_qp.py
@@ -154,8 +154,6 @@ class QPTest(PyverbsAPITestCase):
             with PD(ctx) as pd:
                 with CQ(ctx, 100, None, None, 0) as cq:
                     for i in range(1, attr.phys_port_cnt + 1):
-                        qpts =3D [e.IBV_QPT_UD, e.IBV_QPT_RAW_PACKET] \
-                            if is_eth(ctx, i) else [e.IBV_QPT_UD]
                         qia =3D get_qp_init_attr_ex(cq, pd, attr, attr_ex,
                                                   e.IBV_QPT_UD)
                         with QP(ctx, qia, QPAttr()) as qp:
diff --git a/tests/utils.py b/tests/utils.py
index ab30f6692951..c45170dbd329 100755
--- a/tests/utils.py
+++ b/tests/utils.py
@@ -227,6 +227,9 @@ def random_qp_init_attr_ex(attr_ex, attr, qpt=3DNone):
                 random.randint(16, int(attr_ex.tso_caps.max_tso / 400))
     qia =3D QPInitAttrEx(qp_type=3Dqpt, cap=3Dqp_cap, sq_sig_all=3Dsig, co=
mp_mask=3Dmask,
                        create_flags=3Dcflags, max_tso_header=3Dmax_tso)
+    if mask & e.IBV_QP_INIT_ATTR_MAX_TSO_HEADER:
+        # TSO increases send WQE size, let's be on the safe side
+        qia.cap.max_send_sge =3D 2
     return qia
=20
=20
--=20
2.21.0

