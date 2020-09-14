Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D9C268501
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 08:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgINGgT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 02:36:19 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6898 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgINGgM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Sep 2020 02:36:12 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5f0f2e0002>; Sun, 13 Sep 2020 23:35:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 13 Sep 2020 23:36:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 13 Sep 2020 23:36:12 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 06:36:12 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 14 Sep 2020 06:36:12 +0000
Received: from mtl-vdi-864.wap.labs.mlnx. (Not Verified[10.228.136.155]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f5f0f5a0000>; Sun, 13 Sep 2020 23:36:12 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-core 8/8] tests: Add tests for ibv_query_gid_table and ibv_query_gid_ex
Date:   Mon, 14 Sep 2020 09:35:03 +0300
Message-ID: <20200914063503.192997-9-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200914063503.192997-1-yishaih@nvidia.com>
References: <20200914063503.192997-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600065326; bh=umT9RbzAGBI/oJU2rcQ1nk5EPbDbYPDi9ejy+OObqs8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
         Content-Type;
        b=moesCRJLfkpv1Mj0yBa2MnYuCPKUDx21GSzsoHqkLTHLe2ANS3tCKObyw50roiV1h
         iWe+PkgNoGNR+Bd3EJguMWKFf8vlTVyMWvQoQJz0Fv3eq87VEO4zT76K4jgg4orO+i
         1gtbbFO+U7WZKxfwjkaKkUtoqzOTJIZ4dBXgf8c069ME/BzJmnTSrDqbf7ISz78Wzh
         MpxuUHCPdLw1w1m5FeOLKxl6mGOdTexCimR5UEQwZ3I+hKb5f+QUgj0q3QyKHUj3o7
         vhD9hSdVmqw15zM8fq4NofJY4pXAuE+10BjCNFcfei8J406dc4eqYphSkSDS1bOk14
         Uc5SThADPl1ww==
Sender: linux-rdma-owner@vger.kernel.org
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

