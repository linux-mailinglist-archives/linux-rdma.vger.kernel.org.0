Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 589D191D7A
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 08:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfHSG6f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 02:58:35 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53162 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726553AbfHSG6e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 02:58:34 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Aug 2019 09:58:31 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7J6wUNK004602;
        Mon, 19 Aug 2019 09:58:31 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 08/14] tests: ODP requires decorator
Date:   Mon, 19 Aug 2019 09:58:21 +0300
Message-Id: <20190819065827.26921-9-noaos@mellanox.com>
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

Add a 'requires_odp' decorator, to be used when registering an MR with
ON_DEMAND access flag.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 tests/utils.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/utils.py b/tests/utils.py
index 30166f41d555..20a7e8d38e54 100644
--- a/tests/utils.py
+++ b/tests/utils.py
@@ -5,6 +5,7 @@ Provide some useful helper function for pyverbs' tests.
 """
 from itertools import combinations as com
 from string import ascii_lowercase as al
+import unittest
 import random
 
 from pyverbs.qp import QPCap, QPInitAttrEx
@@ -241,3 +242,32 @@ def wc_status_to_str(status):
     except KeyError:
         return 'Unknown WC status ({s})'.format(s=status)
 
+
+# Decorators
+
+def requires_odp(qp_type):
+    def outer(func):
+        def inner(instance):
+            odp_supported(instance.ctx, qp_type)
+            return func(instance)
+        return inner
+    return outer
+
+
+def odp_supported(ctx, qp_type):
+    """
+    Check device ODP capabilities, support only send/recv so far.
+    :param ctx: Device Context
+    :param qp_type: QP type ('rc', 'ud' or 'uc')
+    :return: None
+    """
+    odp_caps = ctx.query_device_ex().odp_caps
+    if odp_caps.general_caps == 0:
+        raise unittest.SkipTest('ODP is not supported - No ODP caps')
+    qp_odp_caps = getattr(odp_caps, '{}_odp_caps'.format(qp_type))
+    has_odp_send = qp_odp_caps & e.IBV_ODP_SUPPORT_SEND
+    has_odp_recv = qp_odp_caps & e.IBV_ODP_SUPPORT_RECV
+    if has_odp_send == 0:
+        raise unittest.SkipTest('ODP is not supported - ODP send not supported')
+    if has_odp_recv == 0:
+        raise unittest.SkipTest('ODP is not supported - ODP recv not supported')
-- 
2.21.0

