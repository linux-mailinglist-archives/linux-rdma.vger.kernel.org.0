Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3879E275650
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 12:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgIWK12 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 06:27:28 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13522 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIWK12 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Sep 2020 06:27:28 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6b23030003>; Wed, 23 Sep 2020 03:27:15 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Sep
 2020 10:27:27 +0000
Received: from dev-l-vrt-092.mtl.labs.mlnx (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 23 Sep 2020 10:27:25 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Subject: [PATCH V1 rdma-core 7/8] pyverbs: Add query_gid_table and query_gid_ex methods
Date:   Wed, 23 Sep 2020 13:27:01 +0300
Message-ID: <20200923102702.590008-8-yishaih@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923102702.590008-1-yishaih@nvidia.com>
References: <20200923102702.590008-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600856835; bh=pk68iv0MABgMawuRMZ46be1k1jyb/nHS9lvZQ+5qt+0=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=PO1o9mZClXyfXZr8oClSAaBl8yCkMP1Pv3YK2mDAanRm4xKv3TvptAe2SEjYu0XvU
         jvxHAnST+QHaX+YTQT4yBakCKh5miklK0TIe6VfUQ61AZts0JsMjyUr6sWr/IPA+Iq
         nIbLRSwetOn1zujkscZrsEuPDX/ZUyKm9Hwa7LIBKizjJFtig6CTgK9MxqD0C3Jmoe
         0I0okmUTDJVgtQ3hxthJqX9zEgS1+RZUNDF9HKEoM9quaT5pXWI8A7SNnFQvlW393W
         8JwjTiYS7x5Ehg8jHs/FJWjdqnZjrHdh6wRQNxUkIpbpLpkani0NGfKCbbKSeU5KSz
         hazi09vKc0BOw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Add two new methods to Context class: query_gid_table and query_gid_ex.

query_gid_table queries all GID tables of the device and returns
a list of GIDEntry objects containing all valid GID entries.

query_gid_ex queries the GID table of the given port in the given index
and returns a GIDEntry object.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 pyverbs/device.pxd           |   3 ++
 pyverbs/device.pyx           | 106 +++++++++++++++++++++++++++++++++++++++=
++++
 pyverbs/libibverbs.pxd       |  13 ++++++
 pyverbs/libibverbs_enums.pxd |   5 ++
 4 files changed, 127 insertions(+)

diff --git a/pyverbs/device.pxd b/pyverbs/device.pxd
index 73328d3..0519c4b 100755
--- a/pyverbs/device.pxd
+++ b/pyverbs/device.pxd
@@ -64,3 +64,6 @@ cdef class DM(PyverbsCM):
=20
 cdef class PortAttr(PyverbsObject):
     cdef v.ibv_port_attr attr
+
+cdef class GIDEntry(PyverbsObject):
+    cdef v.ibv_gid_entry entry
diff --git a/pyverbs/device.pyx b/pyverbs/device.pyx
index c1323cd..b16d6d0 100755
--- a/pyverbs/device.pyx
+++ b/pyverbs/device.pyx
@@ -26,6 +26,8 @@ from libc.stdlib cimport free, malloc
 from libc.string cimport memset
 from libc.stdint cimport uint64_t
 from libc.stdint cimport uint16_t
+from libc.stdint cimport uint32_t
+from pyverbs.utils import gid_str
=20
 cdef extern from 'endian.h':
     unsigned long be64toh(unsigned long host_64bits);
@@ -240,6 +242,53 @@ cdef class Context(PyverbsCM):
                                    format(p=3Dport_num), rc)
         return port_attrs
=20
+    def query_gid_table(self, size_t max_entries, uint32_t flags=3D0):
+        """
+        Queries the GID tables of the device for at most <max_entries> ent=
ries
+        and returns them.
+        :param max_entries: Maximum number of GID entries to retrieve
+        :param flags: Specifies new extra members of struct ibv_gid_entry =
to
+                      query
+        :return: List of GIDEntry objects on success
+        """
+        cdef v.ibv_gid_entry *entries
+        cdef v.ibv_gid_entry entry
+
+        entries =3D <v.ibv_gid_entry *>malloc(max_entries *
+                                            sizeof(v.ibv_gid_entry))
+        rc =3D v.ibv_query_gid_table(self.context, entries, max_entries, f=
lags)
+        if rc < 0:
+            raise PyverbsRDMAError('Failed to query gid tables of the devi=
ce',
+                                   rc)
+        gid_entries =3D []
+        for i in range(rc):
+            entry =3D entries[i]
+            gid_entries.append(GIDEntry(entry.gid._global.subnet_prefix,
+                               entry.gid._global.interface_id, entry.gid_i=
ndex,
+                               entry.port_num, entry.gid_type,
+                               entry.ndev_ifindex))
+        free(entries)
+        return gid_entries
+
+    def query_gid_ex(self, uint32_t port_num, uint32_t gid_index,
+                     uint32_t flags=3D0):
+        """
+        Queries the GID table of port <port_num> in index <gid_index>, and
+        returns the GID entry.
+        :param port_num: The port number to query
+        :param gid_index: The index in the GID table to query
+        :param flags: Specifies new extra members of struct ibv_gid_entry =
to
+                      query
+        :return: GIDEntry object on success
+        """
+        entry =3D GIDEntry()
+        rc =3D v.ibv_query_gid_ex(self.context, port_num, gid_index,
+                                &entry.entry, flags)
+        if rc !=3D 0:
+            raise PyverbsRDMAError(f'Failed to query gid table of port '\
+                                   f'{port_num} in index {gid_index}', rc)
+        return entry
+
     cdef add_ref(self, obj):
         if isinstance(obj, PD):
             self.pds.add(obj)
@@ -816,6 +865,63 @@ cdef class PortAttr(PyverbsObject):
             print_format.format('Flags', self.attr.flags)
=20
=20
+cdef class GIDEntry(PyverbsObject):
+    def __init__(self, subnet_prefix=3D0, interface_id=3D0, gid_index=3D0,
+                 port_num=3D0, gid_type=3D0, ndev_ifindex=3D0):
+        super().__init__()
+        self.entry.gid._global.subnet_prefix =3D subnet_prefix
+        self.entry.gid._global.interface_id =3D interface_id
+        self.entry.gid_index =3D gid_index
+        self.entry.port_num =3D port_num
+        self.entry.gid_type =3D gid_type
+        self.entry.ndev_ifindex =3D ndev_ifindex
+
+    @property
+    def gid_subnet_prefix(self):
+        return self.entry.gid._global.subnet_prefix
+
+    @property
+    def gid_interface_id(self):
+        return self.entry.gid._global.interface_id
+
+    @property
+    def gid_index(self):
+        return self.entry.gid_index
+
+    @property
+    def port_num(self):
+        return self.entry.port_num
+
+    @property
+    def gid_type(self):
+        return self.entry.gid_type
+
+    @property
+    def ndev_ifindex(self):
+        return self.entry.ndev_ifindex
+
+    def gid_str(self):
+        return gid_str(self.gid_subnet_prefix, self.gid_interface_id)
+
+    def __str__(self):
+        print_format =3D '{:<24}: {:<20}\n'
+        return print_format.format('GID', self.gid_str()) +\
+            print_format.format('GID Index', self.gid_index) +\
+            print_format.format('Port number', self.port_num) +\
+            print_format.format('GID type', translate_gid_type(
+                                self.gid_type)) +\
+            print_format.format('Ndev ifindex', self.ndev_ifindex)
+
+
+def translate_gid_type(gid_type):
+    types =3D {e.IBV_GID_TYPE_IB: 'IB', e.IBV_GID_TYPE_ROCE_V1: 'RoCEv1',
+             e.IBV_GID_TYPE_ROCE_V2: 'RoCEv2'}
+    try:
+        return types[gid_type]
+    except KeyError:
+        return f'Unknown gid_type ({gid_type})'
+
+
 def guid_format(num):
     """
     Get GUID representation of the given number, including change of endia=
nness.
diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index c84b9fc..6fbba54 100755
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -483,6 +483,13 @@ cdef extern from 'infiniband/verbs.h':
         uint32_t options
         uint32_t comp_mask
=20
+    cdef struct ibv_gid_entry:
+        ibv_gid gid
+        uint32_t gid_index
+        uint32_t port_num
+        uint32_t gid_type
+        uint32_t ndev_ifindex
+
     ibv_device **ibv_get_device_list(int *n)
     int ibv_get_device_index(ibv_device *device);
     void ibv_free_device_list(ibv_device **list)
@@ -613,6 +620,12 @@ cdef extern from 'infiniband/verbs.h':
     void ibv_unimport_mr(ibv_mr *mr)
     ibv_pd *ibv_import_pd(ibv_context *context, uint32_t handle)
     void ibv_unimport_pd(ibv_pd *pd)
+    int ibv_query_gid_ex(ibv_context *context, uint32_t port_num,
+                         uint32_t gid_index, ibv_gid_entry *entry,
+                         uint32_t flags)
+    ssize_t ibv_query_gid_table(ibv_context *context,
+                                ibv_gid_entry *entries, size_t max_entries=
,
+                                uint32_t flags)
=20
=20
 cdef extern from 'infiniband/driver.h':
diff --git a/pyverbs/libibverbs_enums.pxd b/pyverbs/libibverbs_enums.pxd
index 83ca516..a5c07b3 100755
--- a/pyverbs/libibverbs_enums.pxd
+++ b/pyverbs/libibverbs_enums.pxd
@@ -427,6 +427,11 @@ cdef extern from '<infiniband/verbs.h>':
=20
     cdef void *IBV_ALLOCATOR_USE_DEFAULT
=20
+    cpdef enum ibv_gid_type:
+        IBV_GID_TYPE_IB
+        IBV_GID_TYPE_ROCE_V1
+        IBV_GID_TYPE_ROCE_V2
+
=20
 cdef extern from "<infiniband/verbs_api.h>":
     cdef unsigned long long IBV_ADVISE_MR_ADVICE_PREFETCH
--=20
1.8.3.1

