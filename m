Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC058EDCB0
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 11:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfKDKhn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 05:37:43 -0500
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:57608
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728449AbfKDKhn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Nov 2019 05:37:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keTZ40KkcfKNMj5xgvuj6Q9h6Gx58aA8DqpsMnWyFP62gFLbyNt8dZmcG8/nGux5sqYphe/BIxy5eg8NKtUDWCn9Wd+gszX18sQozXuIxc6mXA5hP32puvxw/l810WF3gk9l9fo/TjOJVJSznzv/sWB6DGVk3hMlPupQUVwsLYg3g8Eb3sl0jftNlZNC5gL/V/NtXNB/l9yiVBNNUWMfB2kyI0aeCRyk3vER4nth4387+VKe7dmfRuZQyWWKChYFCoopEZCHI6IwyyDTe0h5jkCrm5gqboUPpCnpsvZNYPaEs77jfu/wVTnXxwCLa4lttW3XAeNPcKdBeEq/LPTCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0QUycYtYdILemwHJFGJJevFMM9g6sLgXKXO9Vhd6BI=;
 b=iuhgZeKSiwN9+1etskTYnowICCUubOnFoV8xXEAqYuR/Bn4PTvIWrJUQdrUZ1hCToIdM6GFV/YuFETCxA57f/3WWYMFW1nDukpTV9dgElPz3m15yPJDYZhQLN4qmACbpAXLg7CVxc5WwlRqS4D8emPtu6TsEXfR5e3C68lvZbemJhTNXqpPOiZEXina6NoY5/qkZIGQq3bU958QVjrbJEGOPgl1A3L4q2zc/qvAfYkuvEJhCYvwBIkB9qRhpmaa3OMAorxjSdAz7kRa4/ItsdLjLdzNhBWbFnUm/GhvLXNJwRUHHwfDSvovcVUGqbVvYi2FrM2RJgbWcDtLXtcmI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0QUycYtYdILemwHJFGJJevFMM9g6sLgXKXO9Vhd6BI=;
 b=lNbHpDTWPI6AztHBMqBIuzpE4KDoA0e+W7gkQAwNB9G9DCXAre25XuyM9T/UOtgPVPv6ByyICV/6pu9vybbNGvIdri7PWIfAO+foRl216vmyJbR28WdhS0V8zmB5Ex0xPRjkTEeayZ4YAxkSQjmO2CzkNRdBdBKyxyirDlHtSkE=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6232.eurprd05.prod.outlook.com (20.178.86.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 10:37:28 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 10:37:28 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 4/5] tests: Add RDMACM synchronous traffic test
Thread-Topic: [PATCH rdma-core 4/5] tests: Add RDMACM synchronous traffic test
Thread-Index: AQHVkvvaYLePQ614dE6cNrL/UsO/Kw==
Date:   Mon, 4 Nov 2019 10:37:28 +0000
Message-ID: <20191104103710.11196-5-noaos@mellanox.com>
References: <20191104103710.11196-1-noaos@mellanox.com>
In-Reply-To: <20191104103710.11196-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM4PR0701CA0039.eurprd07.prod.outlook.com
 (2603:10a6:200:42::49) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61b28178-f672-4297-3223-08d76112fd45
x-ms-traffictypediagnostic: AM6PR05MB6232:|AM6PR05MB6232:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6232D862D047E22890632B59D97F0@AM6PR05MB6232.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(25786009)(8676002)(2501003)(66066001)(386003)(6506007)(71200400001)(71190400001)(99286004)(11346002)(6436002)(8936002)(2616005)(476003)(107886003)(1076003)(5660300002)(50226002)(6636002)(316002)(6512007)(54906003)(81166006)(446003)(81156014)(110136005)(4326008)(14454004)(6116002)(186003)(3846002)(86362001)(256004)(36756003)(6486002)(14444005)(52116002)(486006)(478600001)(66446008)(64756008)(66556008)(66476007)(66946007)(76176011)(102836004)(305945005)(26005)(2906002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6232;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ghhJjxm9UNIIHWrns6mSVHGN+O6G+Y1m51X8AFFj4Zzd1s3DfC3KtQbr9SWZpEPKSeIcKndNBQcBIxz/4q5/5cBGnTGDf1ltduoKgtlNGJvYoJ/sr6pZh/mUQZfaEiFQ1v4C1XkJRlVLuo5tGw/SilsGMmLLW0QmsD1uinwcXjP+iUCyBo1MTJ29Q7Aap6VHrTmS53H+4HxdCRlBHypkba/R+tTcmxJT3n+UjTDuIApgdnbCVF+vnn1maHaaiVJpgQ8GOaBosnH0TVhlDitiA1lM4wFfJlIYgDnT8g3cn9WXzsLns+WzFbrwha/BuB8q2T4+6J8a3pfyR1iA6Vs0JFciaCbiUQPMks5k1mZyDUS4FUIp5rbqj+6dXX9o9zTFKjDTLrhpFEskvzdkCAvVIuSpxEN9doncgNMvyfeATQO2BplGgVcTzsHneBDyK/mY
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b28178-f672-4297-3223-08d76112fd45
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 10:37:28.5126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovGNc0U4tf3HpAQZUVASbCwzGOjvpNWuF35qbx5YIUYqzbAo2cajK4R4ayVkDwS7BXEjlOpc61t0HjyIxlphAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6232
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maxim Chicherin <maximc@mellanox.com>

This test creates active and passive sides for RDMACM communication
and validates received messages.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 tests/CMakeLists.txt  |  2 ++
 tests/rdmacm_utils.py | 43 ++++++++++++++++++++++++++++++++
 tests/test_rdmacm.py  | 57 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)
 mode change 100644 =3D> 100755 tests/CMakeLists.txt
 create mode 100755 tests/rdmacm_utils.py
 create mode 100755 tests/test_rdmacm.py

diff --git a/tests/CMakeLists.txt b/tests/CMakeLists.txt
old mode 100644
new mode 100755
index 960276230860..0d81d1a98fb7
--- a/tests/CMakeLists.txt
+++ b/tests/CMakeLists.txt
@@ -3,6 +3,7 @@
=20
 rdma_python_test(tests
   __init__.py
+  rdmacm_utils.py
   test_addr.py
   base.py
   test_cq.py
@@ -11,6 +12,7 @@ rdma_python_test(tests
   test_pd.py
   test_qp.py
   test_odp.py
+  test_rdmacm.py
   utils.py
   )
=20
diff --git a/tests/rdmacm_utils.py b/tests/rdmacm_utils.py
new file mode 100755
index 000000000000..59b627393e4f
--- /dev/null
+++ b/tests/rdmacm_utils.py
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved.  See=
 COPYING file
+"""
+Provide some useful helper function for pyverbs rdmacm' tests.
+"""
+from tests.base import CMResources
+from tests.utils import validate
+
+
+def active_side(node):
+    client =3D CMResources(dst=3Dnode)
+    client.pre_run()
+    connected_id =3D client.cmid
+    send_msg =3D 'c' * client.msg_size
+    for _ in range(client.num_msgs):
+        client.mr.write(send_msg, client.msg_size)
+        connected_id.post_send(client.mr)
+        while connected_id.get_send_comp() is None:
+            pass
+        connected_id.post_recv(client.mr)
+        while connected_id.get_recv_comp() is None:
+            pass
+        msg_received =3D client.mr.read(client.msg_size, 0)
+        validate(msg_received, False, client.msg_size)
+    connected_id.disconnect()
+
+
+def passive_side(node):
+    server =3D CMResources(src=3Dnode)
+    server.pre_run()
+    connected_id =3D server.new_id
+    send_msg =3D 's' * server.msg_size
+    for _ in range(server.num_msgs):
+        connected_id.post_recv(server.mr)
+        while connected_id.get_recv_comp() is None:
+            pass
+        msg_received =3D server.mr.read(server.msg_size, 0)
+        validate(msg_received, True, server.msg_size)
+        server.mr.write(send_msg, server.msg_size)
+        connected_id.post_send(server.mr)
+        while connected_id.get_send_comp() is None:
+            pass
+    connected_id.disconnect()
diff --git a/tests/test_rdmacm.py b/tests/test_rdmacm.py
new file mode 100755
index 000000000000..e435c635d7b2
--- /dev/null
+++ b/tests/test_rdmacm.py
@@ -0,0 +1,57 @@
+from tests.rdmacm_utils import active_side, passive_side
+from tests.base import RDMATestCase
+from multiprocessing import Process
+import pyverbs.device as d
+import subprocess
+import unittest
+import json
+
+
+class CMTestCase(RDMATestCase):
+    def setUp(self):
+        if self.dev_name is not None:
+            net_name =3D self.get_net_name(self.dev_name)
+            try:
+                self.ip_addr =3D self.get_ip_address(net_name)
+            except KeyError:
+                raise unittest.SkipTest('Device {} has no net interface'
+                                        .format(self.dev_name))
+        else:
+            dev_list =3D d.get_device_list()
+            for dev in dev_list:
+                net_name =3D self.get_net_name(dev.name.decode())
+                try:
+                    self.ip_addr =3D self.get_ip_address(net_name)
+                except IndexError:
+                    continue
+                else:
+                    self.dev_name =3D dev.name.decode()
+                    break
+            if self.dev_name is None:
+                raise unittest.SkipTest('No devices with net interface')
+        super().setUp()
+
+    @staticmethod
+    def get_net_name(dev):
+        process =3D subprocess.Popen(['ls', '/sys/class/infiniband/{}/devi=
ce/net/'
+                                   .format(dev)], stdout=3Dsubprocess.PIPE=
)
+        out, err =3D process.communicate()
+        return out.decode().split('\n')[0]
+
+    @staticmethod
+    def get_ip_address(ifname):
+        process =3D subprocess.Popen(['ip', '-j', 'addr', 'show', ifname],
+                                   stdout=3Dsubprocess.PIPE)
+        out, err =3D process.communicate()
+        loaded_json =3D json.loads(out.decode())
+        interface =3D loaded_json[0]['addr_info'][0]['local']
+        if 'fe80::' in interface:
+            interface =3D interface + '%' + ifname
+        return interface
+
+    def test_rdmacm_sync_traffic(self):
+        ps =3D Process(target=3Dpassive_side, args=3D[self.ip_addr])
+        ps.start()
+        ps.join(1)
+        active_side(self.ip_addr)
+        ps.join()
--=20
2.21.0

