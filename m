Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFF9AD54E
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 11:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbfIIJHY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 05:07:24 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48365 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389623AbfIIJHT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 05:07:19 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Sep 2019 12:07:16 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8997Fp5028426;
        Mon, 9 Sep 2019 12:07:16 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 07/12] pyverbs: Add XRC to ODPCaps
Date:   Mon,  9 Sep 2019 12:07:07 +0300
Message-Id: <20190909090712.11029-8-noaos@mellanox.com>
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

Added PCI atomic caps and XRC ODP caps:
XRC ODP caps reports about XRC ODP capabilities of the device. To make
it easier for users, pyverbs reports XRC ODP caps as part of the
device's odp_caps, even though they're reported in a separate field.
PCI atomic caps represents ibv_pci_atomic_caps which is part of
DeviceAttrEx and is now exposed to pyverbs' users.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 pyverbs/device.pxd     |  4 ++++
 pyverbs/device.pyx     | 42 ++++++++++++++++++++++++++++++++++++++++++
 pyverbs/libibverbs.pxd |  9 ++++++++-
 3 files changed, 54 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 pyverbs/device.pxd
 mode change 100644 => 100755 pyverbs/device.pyx

diff --git a/pyverbs/device.pxd b/pyverbs/device.pxd
old mode 100644
new mode 100755
index ed2f1ca3d6ef..5cc13acb4331
--- a/pyverbs/device.pxd
+++ b/pyverbs/device.pxd
@@ -26,6 +26,7 @@ cdef class QueryDeviceExInput(PyverbsObject):
 
 cdef class ODPCaps(PyverbsObject):
     cdef v.ibv_odp_caps odp_caps
+    cdef object xrc_odp_caps
 
 cdef class RSSCaps(PyverbsObject):
     cdef v.ibv_rss_caps rss_caps
@@ -33,6 +34,9 @@ cdef class RSSCaps(PyverbsObject):
 cdef class PacketPacingCaps(PyverbsObject):
     cdef v.ibv_packet_pacing_caps packet_pacing_caps
 
+cdef class PCIAtomicCaps(PyverbsObject):
+    cdef v.ibv_pci_atomic_caps caps
+
 cdef class TMCaps(PyverbsObject):
     cdef v.ibv_tm_caps tm_caps
 
diff --git a/pyverbs/device.pyx b/pyverbs/device.pyx
old mode 100644
new mode 100755
index f238d37ce3a9..084086bdbc69
--- a/pyverbs/device.pyx
+++ b/pyverbs/device.pyx
@@ -393,6 +393,42 @@ cdef class ODPCaps(PyverbsObject):
     @property
     def ud_odp_caps(self):
         return self.odp_caps.per_transport_caps.ud_odp_caps
+    @property
+    def xrc_odp_caps(self):
+        return self.xrc_odp_caps
+    @xrc_odp_caps.setter
+    def xrc_odp_caps(self, val):
+       self.xrc_odp_caps = val
+
+    def __str__(self):
+        general_caps = {e.IBV_ODP_SUPPORT: 'IBV_ODP_SUPPORT',
+              e.IBV_ODP_SUPPORT_IMPLICIT: 'IBV_ODP_SUPPORT_IMPLICIT'}
+
+        l = {e.IBV_ODP_SUPPORT_SEND: 'IBV_ODP_SUPPORT_SEND',
+             e.IBV_ODP_SUPPORT_RECV: 'IBV_ODP_SUPPORT_RECV',
+             e.IBV_ODP_SUPPORT_WRITE: 'IBV_ODP_SUPPORT_WRITE',
+             e.IBV_ODP_SUPPORT_READ: 'IBV_ODP_SUPPORT_READ',
+             e.IBV_ODP_SUPPORT_ATOMIC: 'IBV_ODP_SUPPORT_ATOMIC',
+             e.IBV_ODP_SUPPORT_SRQ_RECV: 'IBV_ODP_SUPPORT_SRQ_RECV'}
+
+        print_format = '{}: {}\n'
+        return print_format.format('ODP General caps', str_from_flags(self.general_caps, general_caps)) +\
+            print_format.format('RC ODP caps', str_from_flags(self.rc_odp_caps, l)) +\
+            print_format.format('UD ODP caps', str_from_flags(self.ud_odp_caps, l)) +\
+            print_format.format('UC ODP caps', str_from_flags(self.uc_odp_caps, l)) +\
+            print_format.format('XRC ODP caps', str_from_flags(self.xrc_odp_caps, l))
+
+
+cdef class PCIAtomicCaps(PyverbsObject):
+    @property
+    def fetch_add(self):
+        return self.caps.fetch_add
+    @property
+    def swap(self):
+        return self.caps.swap
+    @property
+    def compare_swap(self):
+        return self.caps.compare_swap
 
 
 cdef class TSOCaps(PyverbsObject):
@@ -477,6 +513,7 @@ cdef class DeviceAttrEx(PyverbsObject):
     def odp_caps(self):
         caps = ODPCaps()
         caps.odp_caps = self.dev_attr.odp_caps
+        caps.xrc_odp_caps = self.dev_attr.xrc_odp_caps
         return caps
     @property
     def completion_timestamp_mask(self):
@@ -493,6 +530,11 @@ cdef class DeviceAttrEx(PyverbsObject):
         caps.tso_caps = self.dev_attr.tso_caps
         return caps
     @property
+    def pci_atomic_caps(self):
+        caps = PCIAtomicCaps()
+        caps.caps = self.dev_attr.pci_atomic_caps
+        return caps
+    @property
     def rss_caps(self):
         caps = RSSCaps()
         caps.rss_caps = self.dev_attr.rss_caps
diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index a92286d42c67..02137d81e2d3 100755
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -2,7 +2,7 @@
 # Copyright (c) 2018, Mellanox Technologies. All rights reserved. See COPYING file
 
 include 'libibverbs_enums.pxd'
-from libc.stdint cimport uint8_t, uint32_t, uint64_t
+from libc.stdint cimport uint8_t, uint16_t, uint32_t, uint64_t
 
 cdef extern from 'infiniband/verbs.h':
 
@@ -117,6 +117,11 @@ cdef extern from 'infiniband/verbs.h':
         unsigned int    max_cq_count
         unsigned int    max_cq_period
 
+    cdef struct ibv_pci_atomic_caps:
+        uint16_t fetch_add
+        uint16_t swap
+        uint16_t compare_swap
+
     cdef struct ibv_device_attr_ex:
         ibv_device_attr         orig_attr
         unsigned int            comp_mask
@@ -132,6 +137,8 @@ cdef extern from 'infiniband/verbs.h':
         ibv_tm_caps             tm_caps
         ibv_cq_moderation_caps  cq_mod_caps
         unsigned long           max_dm_size
+        ibv_pci_atomic_caps     pci_atomic_caps
+        uint32_t                xrc_odp_caps
 
     cdef struct ibv_mw:
         ibv_context     *context
-- 
2.21.0

