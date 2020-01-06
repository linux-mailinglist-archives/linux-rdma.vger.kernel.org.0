Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F89131444
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 16:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgAFPBd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 10:01:33 -0500
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]:13558
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbgAFPBd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jan 2020 10:01:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFZY/yg4PUzINJNorWFm895t5SRmnr8tqlct05tLXaZ139aYj7JZTgpbvNne4ul5zpHFuHy7eLUFaFI8oEIf5JohVbD8Q/1culC7+YYp97utklbzwn+C52VB1VFjhWWGXEqOKiPP8Uq8f8Qtbc2r6uSG+Cx6UGyKZD6R24Ya+J+Wu3z8Gi0k9fx9oObKul+w3+qkEh6YVp83WH44r9P1XUBHhhB6LgOYfgKhmf7Az91vOuOJBm48nK0v/B9QMkcyrE/dJEIV5+irL/JfD1+Hf/k3MguJwQxhRjvnLuAoy5+j6aS2GwsbaFgVlzX+n5OF9wgHEiV9y76JGukMkSsuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHRk5BGlnTqOQvqH+Cx8jDqMQoAxZhKRxveoNbXshXE=;
 b=Z0XSxxNNJ0LGSz8/8jAXnkyTfrQce4HvRHP8C6YQRt+YFi4GBDXEBvTwx7GEFLof0fnyYKy5aEgtW83lnvI/uUO6Aa4URFniN1JyLMCz2FwMy1nZ7b5qyoy9PDJUuOKc9n5XEkQiAmEMnd8aev8CarrEU7Wbrzo5QjUkQdElfjqFSYaylCnzWNLPQmpN5f1LR6B+weXDnOkRURuz2sAsn7DpJDgisGErjIpARyqBOsKhxwMjC2BtKjtzera7fTAhPpnFAdfJlKUaPnw4nVE7N+/3TsxyXBQHYebzo443ws0DQnrfrjBAYsXvCKv4FvfIV3H5z0L9E/1DVJaBgRihGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHRk5BGlnTqOQvqH+Cx8jDqMQoAxZhKRxveoNbXshXE=;
 b=W0tB8v4RpIf1CCPbfe9jdG6hqJXEte/bekWai4ORLc9LKWcd/9Yy6TbxAn5LSya1b8UnZ29Hp2Bvbu4Nisv9UuZ1XaFaNig8nnpeOnQctwxUS9yX+GVYlDVaEtA4xtkB6etYtpkksn8cp4lzK03ZOSEokbOkIcYbK4WV3PM3VfU=
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com (10.175.21.136) by
 VI1PR0502MB2989.eurprd05.prod.outlook.com (10.175.21.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 15:01:29 +0000
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427]) by VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427%5]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 15:01:29 +0000
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (94.188.199.18) by AM4PR07CA0007.eurprd07.prod.outlook.com (2603:10a6:205:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.4 via Frontend Transport; Mon, 6 Jan 2020 15:01:28 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 2/2] tests: Add a test for completion events
Thread-Topic: [PATCH rdma-core 2/2] tests: Add a test for completion events
Thread-Index: AQHVxKIsJxPZBmsVBEGqxcqAmmvqyg==
Date:   Mon, 6 Jan 2020 15:01:29 +0000
Message-ID: <20200106150115.14746-3-noaos@mellanox.com>
References: <20200106150115.14746-1-noaos@mellanox.com>
In-Reply-To: <20200106150115.14746-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM4PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:205:1::20) To VI1PR0502MB3006.eurprd05.prod.outlook.com
 (2603:10a6:800:b2::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c59a6e1e-b4cb-49d0-9f67-08d792b94f31
x-ms-traffictypediagnostic: VI1PR0502MB2989:|VI1PR0502MB2989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB29891B81C111710D4D0EB3E9D93C0@VI1PR0502MB2989.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(52116002)(71200400001)(6486002)(2906002)(2616005)(956004)(1076003)(66556008)(64756008)(66946007)(66476007)(26005)(81166006)(6636002)(186003)(16526019)(81156014)(66446008)(86362001)(8676002)(6506007)(8936002)(316002)(110136005)(54906003)(6512007)(478600001)(4326008)(107886003)(36756003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB2989;H:VI1PR0502MB3006.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eUSCQ5Ecix1ic9zyl6OFpA0lvHatujJ1YQqCxOSL0EXrdlM3iySPCV5B49rqTRXxSpreugqvjg1aO8I3FU0UIvTr7R1OZYAB9sKZYj0cZCxc904bAr5b+nfWhE7ULYsp4LjwyvPrTnN+W9/r7RAnXor2drcFKUyiB6ihU08w3N7B5+vacxT6tXRg9BApI57Q2MasvdUh07y8SXYhklx82pEIuqpyUtVpt9SRycQ75sPxJlY77hUokLaGzt3jRlZ+Eu0w9c+OZuTSOIakRz/ZVOBxDJQjkcEWLa2AU73vD4VFXEG+wHLCn5D+UMOGgwyr/Y1pxCjSrAu7gOJhValQVAm+8+AsvElXuuF/MWsDcSp8ebk5zVj4aiKgWy06etqCDxGUpmWG1zd669Vp9+1BpJINzMAV0lVljdPNfJO4jJgNz9GE/r/GACmFvVp4vmFW
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59a6e1e-b4cb-49d0-9f67-08d792b94f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 15:01:29.4570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBYpoZ71uRAtKFWNXqhFxWen/nvkq0CnxGDCjGCSMLxsSXy+dLHKkwLWK6/1WWJFv7g3v4g9Saja9uGYsMHUfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2989
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a test which runs RC/UD traffic and uses a completion channel.
Add support for utils method poll_cq to use the completion channel
when a CQ has one.
This commit also fixes a bug in poll_cq - only the last polled CQEs
were returned to the user.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Edward Srouji <edwards@mellanox.com>
---
 tests/CMakeLists.txt    |  1 +
 tests/test_cq_events.py | 45 +++++++++++++++++++++++++++++++++++++++++
 tests/utils.py          | 11 +++++++---
 3 files changed, 54 insertions(+), 3 deletions(-)
 create mode 100644 tests/test_cq_events.py

diff --git a/tests/CMakeLists.txt b/tests/CMakeLists.txt
index 6d702425886c..8d946349bd67 100755
--- a/tests/CMakeLists.txt
+++ b/tests/CMakeLists.txt
@@ -7,6 +7,7 @@ rdma_python_test(tests
   test_addr.py
   base.py
   test_cq.py
+  test_cq_events.py
   test_cqex.py
   test_device.py
   test_mr.py
diff --git a/tests/test_cq_events.py b/tests/test_cq_events.py
new file mode 100644
index 000000000000..bcb3f7d158ee
--- /dev/null
+++ b/tests/test_cq_events.py
@@ -0,0 +1,45 @@
+from tests.base import RCResources, UDResources
+from tests.base import RDMATestCase
+from tests.utils import traffic
+
+from pyverbs.cq import CQ, CompChannel
+
+
+def create_cq_with_comp_channel(agr_obj):
+    agr_obj.comp_channel =3D CompChannel(agr_obj.ctx)
+    agr_obj.cq =3D CQ(agr_obj.ctx, agr_obj.num_msgs, None, agr_obj.comp_ch=
annel)
+    agr_obj.cq.req_notify()
+
+
+class CqEventsUD(UDResources):
+    def create_cq(self):
+        create_cq_with_comp_channel(self)
+
+
+class CqEventsRC(RCResources):
+    def create_cq(self):
+        create_cq_with_comp_channel(self)
+
+
+class CqEventsTestCase(RDMATestCase):
+    def setUp(self):
+        super().setUp()
+        self.iters =3D 100
+        self.qp_dict =3D {'ud': CqEventsUD, 'rc': CqEventsRC}
+
+    def create_players(self, qp_type):
+        client =3D self.qp_dict[qp_type](self.dev_name, self.ib_port,
+                                       self.gid_index)
+        server =3D self.qp_dict[qp_type](self.dev_name, self.ib_port,
+                                       self.gid_index)
+        client.pre_run(server.psn, server.qpn)
+        server.pre_run(client.psn, client.qpn)
+        return client, server
+
+    def test_cq_events_ud(self):
+        client, server =3D self.create_players('ud')
+        traffic(client, server, self.iters, self.gid_index, self.ib_port)
+
+    def test_cq_events_rc(self):
+        client, server =3D self.create_players('rc')
+        traffic(client, server, self.iters, self.gid_index, self.ib_port)
diff --git a/tests/utils.py b/tests/utils.py
index c45170dbd329..d59ab54eec19 100755
--- a/tests/utils.py
+++ b/tests/utils.py
@@ -332,14 +332,19 @@ def poll_cq(cq, count=3D1):
     :return: An array of work completions of length <count>, None
              when events are used
     """
-    wcs =3D None
+    wcs =3D []
+    channel =3D cq.comp_channel
     while count > 0:
-        nc, wcs =3D cq.poll(count)
-        for wc in wcs:
+        if channel:
+            channel.get_cq_event(cq)
+            cq.req_notify()
+        nc, tmp_wcs =3D cq.poll(count)
+        for wc in tmp_wcs:
             if wc.status !=3D e.IBV_WC_SUCCESS:
                 raise PyverbsRDMAError('Completion status is {s}'.
                                        format(s=3Dwc_status_to_str(wc.stat=
us)))
         count -=3D nc
+        wcs.extend(tmp_wcs)
     return wcs
=20
=20
--=20
2.21.0

