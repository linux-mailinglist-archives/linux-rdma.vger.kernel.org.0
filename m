Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FEE1B0DF0
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 16:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgDTOHg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 10:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbgDTOHf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 10:07:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79C9C214AF;
        Mon, 20 Apr 2020 14:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587391655;
        bh=cQSuLRegs1XFnkD4DvQ2RS/O5HE0wf8Uc3Q/Co4irOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dfpzuYNxRrBUXxrRyAUjEZgQopvCcfMmxqzTUThS6Qhqsoc/3pF/OU6D345OI1FAW
         PHm/Cz8wNhaTwCXHqNkFi0M367SoEqflX7xeLplghjFEonXGzpTXNznEp5l4D/s2rx
         Xp+3o2XUcYvcZsuLFILZj/96elpDcrbo6OfhI3cs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ido Kalir <idok@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-core 12/12] tests: Add test for rdmacm ECE mechanism
Date:   Mon, 20 Apr 2020 17:06:48 +0300
Message-Id: <20200420140648.275554-13-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200420140648.275554-1-leon@kernel.org>
References: <20200420140648.275554-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ido Kalir <idok@mellanox.com>

Add test case that use the ECE mechanism in RDMA CM connection
establishment.

Signed-off-by: Ido Kalir <idok@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 tests/rdmacm_utils.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tests/rdmacm_utils.py b/tests/rdmacm_utils.py
index c71bab18..d8d22f65 100755
--- a/tests/rdmacm_utils.py
+++ b/tests/rdmacm_utils.py
@@ -4,10 +4,12 @@
 Provide some useful helper function for pyverbs rdmacm' tests.
 """
 from tests.utils import validate, poll_cq, get_send_element, get_recv_wr
-from pyverbs.pyverbs_error import PyverbsError
+from pyverbs.pyverbs_error import PyverbsError, PyverbsRDMAError
 from tests.base import CMResources
 from pyverbs.cmid import CMEvent
 import pyverbs.cm_enums as ce
+import unittest
+import errno
 import os

 events_dict = {ce.RDMA_CM_EVENT_ADDR_ERROR: 'Resolve Address Error',
@@ -117,6 +119,13 @@ def event_handler(agr_obj):
         agr_obj.create_qp()
         param = agr_obj.create_conn_param()
         if agr_obj.with_ext_qp:
+            try:
+                ece = agr_obj.qp.query_ece()
+                agr_obj.cmid.set_local_ece(ece)
+            except PyverbsRDMAError as ex:
+                if ex.error_code == errno.EOPNOTSUPP:
+                    pass
+                raise ex
             param.qpn = agr_obj.qp.qp_num
         agr_obj.cmid.connect(param)
     elif cm_event.event_type == ce.RDMA_CM_EVENT_CONNECT_REQUEST:
@@ -124,6 +133,13 @@ def event_handler(agr_obj):
         param = agr_obj.create_conn_param()
         agr_obj.create_qp()
         if agr_obj.with_ext_qp:
+            try:
+                ece = agr_obj.child_id.get_remote_ece()
+                agr_obj.qp.set_ece(ece)
+            except PyverbsRDMAError as ex:
+                if ex.error_code == errno.EOPNOTSUPP:
+                    pass
+                raise ex
             agr_obj.modify_ext_qp_to_rts()
             param.qpn = agr_obj.qp.qp_num
         agr_obj.child_id.accept(param)
--
2.25.2

