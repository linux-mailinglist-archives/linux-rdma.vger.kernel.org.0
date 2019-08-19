Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 122DE91D70
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 08:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHSG6f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 02:58:35 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53156 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726736AbfHSG6e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 02:58:34 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Aug 2019 09:58:30 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7J6wUNG004602;
        Mon, 19 Aug 2019 09:58:30 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 04/14] tests: BaseResources Class
Date:   Mon, 19 Aug 2019 09:58:17 +0300
Message-Id: <20190819065827.26921-5-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819065827.26921-1-noaos@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maxim Chicherin <maximc@mellanox.com>

Base aggregator object which contains basic resources like Context
and PD.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 tests/base.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/base.py b/tests/base.py
index a1eae2becdc0..88f00e07b326 100644
--- a/tests/base.py
+++ b/tests/base.py
@@ -3,7 +3,10 @@
 
 import unittest
 
+from pyverbs.device import Context
 import pyverbs.device as d
+from pyverbs.pd import PD
+
 
 class PyverbsAPITestCase(unittest.TestCase):
     def setUp(self):
@@ -21,3 +24,22 @@ class PyverbsAPITestCase(unittest.TestCase):
     def tearDown(self):
         for tup in self.devices:
             tup[0].close()
+
+
+class BaseResources(object):
+    """
+    BaseResources class is a base aggregator object which contains basic
+    resources like Context and PD. It opens a context over the given device
+    and port and allocates a PD.
+    """
+    def __init__(self, dev_name, ib_port, gid_index):
+        """
+        Initializes a BaseResources object.
+        :param dev_name: Device name to be used (default: 'ibp0s8f0')
+        :param ib_port: IB port of the device to use (default: 1)
+        :param gid_index: Which GID index to use (default: 0)
+        """
+        self.ctx = Context(name=dev_name)
+        self.gid_index = gid_index
+        self.pd = PD(self.ctx)
+        self.ib_port = ib_port
-- 
2.21.0

