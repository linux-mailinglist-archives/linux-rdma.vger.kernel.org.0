Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDD3275651
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 12:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgIWK1a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 06:27:30 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13525 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIWK1a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Sep 2020 06:27:30 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6b23050001>; Wed, 23 Sep 2020 03:27:17 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Sep
 2020 10:27:29 +0000
Received: from dev-l-vrt-092.mtl.labs.mlnx (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 23 Sep 2020 10:27:28 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Subject: [PATCH V1 rdma-core 8/8] tests: Add tests for ibv_query_gid_table and ibv_query_gid_ex
Date:   Wed, 23 Sep 2020 13:27:02 +0300
Message-ID: <20200923102702.590008-9-yishaih@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923102702.590008-1-yishaih@nvidia.com>
References: <20200923102702.590008-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600856837; bh=umT9RbzAGBI/oJU2rcQ1nk5EPbDbYPDi9ejy+OObqs8=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=dTgx2K2H3Esw0uxvf0JUPieBW08FOoSVuFutOIaGZTuEq9sJFiK2MQUXxGkZ6/hNN
         6Ez8QAtDdNUoCfLoV9w9ncGgePHqC3MxGxuCyHm9Kl5YG51kdeWMGUePTWvISFWVY3
         BNkox8Lv/BM0fL8dZ2IAc41SSrIsMT7Z850twqViLtBvfsBtULWwmpoW4MBL3nArpz
         0FRjPKzH8OY9LA1U90e97zJgjtcev/zY3ruRkVbV4EBvuF0cGOgfabD7sbDfRbVl6l
         jL+f3NSYRCwSmg7PK5HJzzfmZNfLdAYidtiuLnVB3YZTRYcbRgpWcDVAZf7BnpohOg
         zDISyzkbxelfQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Add a test for ibv_query_gid_table and another one for
ibv_query_gid_ex.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 tests/test_device.py | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/test_device.py b/tests/test_device.py
index 1eb1a81..94c0e40 100644
--- a/tests/test_device.py
+++ b/tests/test_device.py
@@ -6,6 +6,7 @@ Test module for pyverbs' device module.
 import unittest
 import resource
 import random
+import errno
=20
 from pyverbs.pyverbs_error import PyverbsError, PyverbsRDMAError
 from tests.base import PyverbsAPITestCase
@@ -80,6 +81,37 @@ class DeviceTest(PyverbsAPITestCase):
             with d.Context(name=3Ddev.name.decode()) as ctx:
                 ctx.query_gid(port_num=3D1, index=3D0)
=20
+    def test_query_gid_table(self):
+        """
+        Test ibv_query_gid_table()
+        """
+        devs =3D self.get_device_list()
+        with d.Context(name=3Ddevs[0].name.decode()) as ctx:
+            device_attr =3D ctx.query_device()
+            port_attr =3D ctx.query_port(1)
+            max_entries =3D device_attr.phys_port_cnt * port_attr.gid_tbl_=
len
+            try:
+                ctx.query_gid_table(max_entries)
+            except PyverbsRDMAError as ex:
+                if ex.error_code in [errno.EOPNOTSUPP, errno.EPROTONOSUPPO=
RT]:
+                    raise unittest.SkipTest('ibv_query_gid_table is not'\
+                                            ' supported on this device')
+                raise ex
+
+    def test_query_gid_ex(self):
+        """
+        Test ibv_query_gid_ex()
+        """
+        devs =3D self.get_device_list()
+        with d.Context(name=3Ddevs[0].name.decode()) as ctx:
+            try:
+                ctx.query_gid_ex(port_num=3D1, gid_index=3D0)
+            except PyverbsRDMAError as ex:
+                if ex.error_code in [errno.EOPNOTSUPP, errno.EPROTONOSUPPO=
RT]:
+                    raise unittest.SkipTest('ibv_query_gid_ex is not'\
+                                            ' supported on this device')
+                raise ex
+
     @staticmethod
     def verify_device_attr(attr, device):
         """
--=20
1.8.3.1

