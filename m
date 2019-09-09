Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A432AD545
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 11:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbfIIJHT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 05:07:19 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48362 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727674AbfIIJHT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 05:07:19 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Sep 2019 12:07:16 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8997Fox028426;
        Mon, 9 Sep 2019 12:07:16 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 01/12] pyverbs: Fix WC creation process
Date:   Mon,  9 Sep 2019 12:07:01 +0300
Message-Id: <20190909090712.11029-2-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909090712.11029-1-noaos@mellanox.com>
References: <20190909090712.11029-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maxim Chicherin <maximc@mellanox.com>

In WC constructor, parameters assignment was incorrect and values
were not stored properly.
imm_data attribute was not initiated, imm_data represents immediate
data in network byte order if wc_flags & IBV_WC_WITH_IMM or stores the
invalidated rkey if wc_flags & IBV_WC_WITH_INV.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 pyverbs/cq.pyx | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)
 mode change 100644 => 100755 pyverbs/cq.pyx

diff --git a/pyverbs/cq.pyx b/pyverbs/cq.pyx
old mode 100644
new mode 100755
index dc09924e88a9..3ac5f704766b
--- a/pyverbs/cq.pyx
+++ b/pyverbs/cq.pyx
@@ -366,18 +366,19 @@ cdef class WC(PyverbsObject):
     def __cinit__(self, wr_id=0, status=0, opcode=0, vendor_err=0, byte_len=0,
                   qp_num=0, src_qp=0, imm_data=0, wc_flags=0, pkey_index=0,
                   slid=0, sl=0, dlid_path_bits=0):
-        self.wr_id = wr_id
-        self.status = status
-        self.opcode = opcode
-        self.vendor_err = vendor_err
-        self.byte_len = byte_len
-        self.qp_num = qp_num
-        self.src_qp = src_qp
-        self.wc_flags = wc_flags
-        self.pkey_index = pkey_index
-        self.slid = slid
-        self.sl = sl
-        self.dlid_path_bits = dlid_path_bits
+        self.wc.wr_id = wr_id
+        self.wc.status = status
+        self.wc.opcode = opcode
+        self.wc.vendor_err = vendor_err
+        self.wc.byte_len = byte_len
+        self.wc.qp_num = qp_num
+        self.wc.src_qp = src_qp
+        self.wc.wc_flags = wc_flags
+        self.wc.pkey_index = pkey_index
+        self.wc.slid = slid
+        self.wc.imm_data = imm_data
+        self.wc.sl = sl
+        self.wc.dlid_path_bits = dlid_path_bits
 
     @property
     def wr_id(self):
@@ -456,6 +457,13 @@ cdef class WC(PyverbsObject):
     def sl(self, val):
         self.wc.sl = val
 
+    @property
+    def imm_data(self):
+        return self.wc.imm_data
+    @imm_data.setter
+    def imm_data(self, val):
+        self.wc.imm_data = val
+
     @property
     def dlid_path_bits(self):
         return self.wc.dlid_path_bits
@@ -476,6 +484,7 @@ cdef class WC(PyverbsObject):
             print_format.format('pkey index', self.pkey_index) +\
             print_format.format('slid', self.slid) +\
             print_format.format('sl', self.sl) +\
+            print_format.format('imm_data', self.imm_data) +\
             print_format.format('dlid path bits', self.dlid_path_bits)
 
 
-- 
2.21.0

