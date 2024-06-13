Return-Path: <linux-rdma+bounces-3112-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF06906724
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 10:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38B51F2175D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 08:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5946413F453;
	Thu, 13 Jun 2024 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="lwer38ml"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7113D518
	for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2024 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267900; cv=none; b=cIimPUSk2TKS5DMN6L8uv4MkNTIWMAJT127zBtbyOTDfjepp0wIpW6CRmW/OsJVcawtLWs4RPcFRSdcm2JSkC88PhCzbF442VCUV1H5bihSKX3dg9Tt9YM5lNkHxlFCCz1wjrKKzNqczHGj8fnSD/Aeh7qFC1YFrCC4bzrOQgcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267900; c=relaxed/simple;
	bh=gaxx2q2lBpReRqFc6sJMRniQR0JrPz62/YWwtxq4a0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UYMPxU+uSzYVwQ+ZQyitaqbVK0BPSthwD6iVycNm5yuzWR77bOUXHX91p4SsBBLbBbT+TpEln2c5Oo7Ow284x3LCPX5421KahGkF3a3lCMaFKGQMTjl33LKShURLtoyRcLIt0+YxGjqBGYzf97DYY05xELkEAQjhXJ4wyusLXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=lwer38ml; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1718267891; bh=gaxx2q2lBpReRqFc6sJMRniQR0JrPz62/YWwtxq4a0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lwer38mlo048sLXmNLpz0USdnNAeWKyRoj+C8Bw/gvYyFR173p/cM3NuS8FdSfup+
	 UMa8hcq8rO1XeS7bQ1yUR05GZxS69LMFJqQjNs4O+F5MtevX0qjlXM+p5ce+HZmoiC
	 QM+KYiw3TDZsPFwu6MRV9aGVD+/CM4MpbFvTkMMOqG9HZAJH+aVtgUbZZsTFpy6gdI
	 A+KTv9M2/reBfFNg468xQPwlFUh7O8krXDkQzc0XuP5wyhFUezL2FD6tNRwDPaAPNO
	 PYG4FiolrSzaTP08UNXXIMnHd89j/OevJVVjgGdZRessvaZdA+RvNa8v1m8T9MY2R5
	 wrxeozIiZF9nw==
Received: from oshpigelman-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by oshpigelman-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 45D8c2va1440923;
	Thu, 13 Jun 2024 11:38:03 +0300
From: Omer Shpigelman <oshpigelman@habana.ai>
To: linux-rdma@vger.kernel.org
Cc: ogabbay@kernel.org, oshpigelman@habana.ai, zyehudai@habana.ai
Subject: [PATCH 3/4] pyverbs/hbl: direct verbs support
Date: Thu, 13 Jun 2024 11:38:01 +0300
Message-Id: <20240613083802.1440904-4-oshpigelman@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613083802.1440904-1-oshpigelman@habana.ai>
References: <20240613083802.1440904-1-oshpigelman@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support all DV operations.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Co-developed-by: Abhilash K V <kvabhilash@habana.ai>
Signed-off-by: Abhilash K V <kvabhilash@habana.ai>
Co-developed-by: Andrey Agranovich <aagranovich@habana.ai>
Signed-off-by: Andrey Agranovich <aagranovich@habana.ai>
Co-developed-by: Bharat Jauhari <bjauhari@habana.ai>
Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
Co-developed-by: David Meriin <dmeriin@habana.ai>
Signed-off-by: David Meriin <dmeriin@habana.ai>
Co-developed-by: Sagiv Ozeri <sozeri@habana.ai>
Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
Co-developed-by: Zvika Yehudai <zyehudai@habana.ai>
Signed-off-by: Zvika Yehudai <zyehudai@habana.ai>
---
 pyverbs/CMakeLists.txt               |   3 +-
 pyverbs/providers/hbl/CMakeLists.txt |  10 +
 pyverbs/providers/hbl/__init__.pxd   |   0
 pyverbs/providers/hbl/__init__.py    |   0
 pyverbs/providers/hbl/hbl_enums.pxd  |  39 +++
 pyverbs/providers/hbl/hbl_enums.pyx  |   0
 pyverbs/providers/hbl/hbldv.pxd      |  60 ++++
 pyverbs/providers/hbl/hbldv.pyx      | 394 +++++++++++++++++++++++++++
 pyverbs/providers/hbl/libhbl.pxd     | 142 ++++++++++
 pyverbs/providers/hbl/libhbl.pyx     |   0
 10 files changed, 647 insertions(+), 1 deletion(-)
 create mode 100644 pyverbs/providers/hbl/CMakeLists.txt
 create mode 100644 pyverbs/providers/hbl/__init__.pxd
 create mode 100644 pyverbs/providers/hbl/__init__.py
 create mode 100644 pyverbs/providers/hbl/hbl_enums.pxd
 create mode 100644 pyverbs/providers/hbl/hbl_enums.pyx
 create mode 100644 pyverbs/providers/hbl/hbldv.pxd
 create mode 100644 pyverbs/providers/hbl/hbldv.pyx
 create mode 100644 pyverbs/providers/hbl/libhbl.pxd
 create mode 100644 pyverbs/providers/hbl/libhbl.pyx

diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index 4ce7ee9c4..339c004ef 100644
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -52,8 +52,9 @@ rdma_python_module(pyverbs
   utils.py
   )
 
-# mlx5 and efa providers are not built without coherent DMA, e.g. ARM32 build.
+# mlx5, efa and hbl providers are not built without coherent DMA, e.g. ARM32 build.
 if (HAVE_COHERENT_DMA)
 add_subdirectory(providers/mlx5)
 add_subdirectory(providers/efa)
+add_subdirectory(providers/hbl)
 endif()
diff --git a/pyverbs/providers/hbl/CMakeLists.txt b/pyverbs/providers/hbl/CMakeLists.txt
new file mode 100644
index 000000000..9591706af
--- /dev/null
+++ b/pyverbs/providers/hbl/CMakeLists.txt
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright 2022-2024 HabanaLabs, Ltd.
+# Copyright (C) 2023-2024, Intel Corporation.
+# All Rights Reserved.
+
+rdma_cython_module(pyverbs/providers/hbl hbl
+  hbl_enums.pyx
+  hbldv.pyx
+  libhbl.pyx
+)
diff --git a/pyverbs/providers/hbl/__init__.pxd b/pyverbs/providers/hbl/__init__.pxd
new file mode 100644
index 000000000..e69de29bb
diff --git a/pyverbs/providers/hbl/__init__.py b/pyverbs/providers/hbl/__init__.py
new file mode 100644
index 000000000..e69de29bb
diff --git a/pyverbs/providers/hbl/hbl_enums.pxd b/pyverbs/providers/hbl/hbl_enums.pxd
new file mode 100644
index 000000000..f57d7a335
--- /dev/null
+++ b/pyverbs/providers/hbl/hbl_enums.pxd
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright 2022-2024 HabanaLabs, Ltd.
+# Copyright (C) 2023-2024, Intel Corporation.
+# All Rights Reserved.
+
+#cython: language_level=3
+
+cdef extern from 'infiniband/hbldv.h':
+
+    cpdef enum hbldv_mem_id:
+        HBLDV_MEM_HOST   = 1
+        HBLDV_MEM_DEVICE = 2
+
+    cpdef enum hbldv_swq_granularity:
+        HBLDV_SWQE_GRAN_32B = 0
+        HBLDV_SWQE_GRAN_64B = 1
+
+    cpdef enum hbldv_qp_wq_types:
+        HBLDV_WQ_WRITE = 0x1
+        HBLDV_WQ_RECV_RDV = 0x2
+        HBLDV_WQ_READ_RDV = 0x4
+        HBLDV_WQ_SEND_RDV = 0x8
+        HBLDV_WQ_READ_RDV_ENDP = 0x10
+
+    cpdef enum hbldv_usr_fifo_type:
+        HBLDV_USR_FIFO_TYPE_DB = 0
+        HBLDV_USR_FIFO_TYPE_CC = 1
+
+    cpdef enum hbldv_cq_type:
+        HBLDV_CQ_TYPE_QP = 0
+        HBLDV_CQ_TYPE_CC = 1
+
+    cpdef enum hbldv_encap_type:
+        HBLDV_ENCAP_TYPE_NO_ENC = 0
+        HBLDV_ENCAP_TYPE_ENC_OVER_IPV4 = 1
+        HBLDV_ENCAP_TYPE_ENC_OVER_UDP = 2
+
+    cpdef enum hbldv_device_attr_caps:
+        HBLDV_DEVICE_ATTR_CAP_CC = 1 << 0
diff --git a/pyverbs/providers/hbl/hbl_enums.pyx b/pyverbs/providers/hbl/hbl_enums.pyx
new file mode 100644
index 000000000..e69de29bb
diff --git a/pyverbs/providers/hbl/hbldv.pxd b/pyverbs/providers/hbl/hbldv.pxd
new file mode 100644
index 000000000..2166fb6ed
--- /dev/null
+++ b/pyverbs/providers/hbl/hbldv.pxd
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright 2022-2024 HabanaLabs, Ltd.
+# Copyright (C) 2023-2024, Intel Corporation.
+# All Rights Reserved.
+
+#cython: language_level=3
+
+from pyverbs.base cimport PyverbsObject
+cimport pyverbs.providers.hbl.libhbl as dv
+from pyverbs.device cimport Context
+cimport pyverbs.libibverbs as v
+
+
+cdef class HblContext(Context):
+    cpdef close(self)
+
+cdef class HblDVContextAttr(PyverbsObject):
+    cdef dv.hbldv_ucontext_attr attr
+
+cdef class HblDVPortExAttr(PyverbsObject):
+    cdef dv.hbldv_port_ex_attr attr
+
+cdef class HblDVUserFIFOAttr(PyverbsObject):
+    cdef dv.hbldv_usr_fifo_attr attr
+
+cdef class HblDVUserFIFO(PyverbsObject):
+    cdef dv.hbldv_usr_fifo *usr_fifo
+
+cdef class HblDVCQattr(PyverbsObject):
+    cdef dv.hbldv_cq_attr cq_attr
+
+cdef class HblDVQueryCQ(PyverbsObject):
+    cdef dv.hbldv_query_cq_attr query_cq_attr
+
+cdef class HblDVCQ(PyverbsObject):
+    cdef v.ibv_cq *ibvcq
+
+cdef class HblDVPortAttr(PyverbsObject):
+    cdef dv.hbldv_query_port_attr hbl_attr
+
+cdef class HblDVQP(PyverbsObject):
+    cdef v.ibv_qp *ibvqp
+
+cdef class HblDVModifyQP(PyverbsObject):
+    cdef dv.hbldv_qp_attr attr
+
+cdef class HblDVQueryQP(PyverbsObject):
+    cdef dv.hbldv_query_qp_attr query_qp_attr
+
+cdef class HblDVEncapAttr(PyverbsObject):
+    cdef dv.hbldv_encap_attr encap_attr
+
+cdef class HblDVEncapOut(PyverbsObject):
+    cdef dv.hbldv_encap encap_out
+
+cdef class HblDVEncap(PyverbsObject):
+    cdef dv.hbldv_encap *hbldv_encap
+
+cdef class HblDVDeviceAttr(PyverbsObject):
+    cdef dv.hbldv_device_attr attr
diff --git a/pyverbs/providers/hbl/hbldv.pyx b/pyverbs/providers/hbl/hbldv.pyx
new file mode 100644
index 000000000..fba60cd96
--- /dev/null
+++ b/pyverbs/providers/hbl/hbldv.pyx
@@ -0,0 +1,394 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright 2022-2024 HabanaLabs, Ltd.
+# Copyright (C) 2023-2024, Intel Corporation.
+# All Rights Reserved.
+
+cimport pyverbs.providers.hbl.libhbl as dv
+
+from cpython.mem cimport PyMem_Malloc, PyMem_Free
+from libc.stdint cimport uint32_t, uint64_t
+from posix.mman cimport munmap
+from pyverbs.base import PyverbsRDMAErrno
+from pyverbs.pd cimport PD
+from pyverbs.pyverbs_error import PyverbsUserError, PyverbsRDMAError, PyverbsError
+from pyverbs.qp cimport QP, QPInitAttr, QPAttr
+
+
+cdef class HblDVContextAttr(PyverbsObject):
+    """
+    Represent hbldv_ucontext_attr struct. This class is used to open an hbl
+    device.
+    """
+    @property
+    def ports_mask(self):
+        return self.attr.ports_mask
+
+    @ports_mask.setter
+    def ports_mask(self,val):
+        self.attr.ports_mask = val
+
+    @property
+    def core_fd(self):
+        return self.attr.core_fd
+
+    @core_fd.setter
+    def core_fd(self,val):
+        self.attr.core_fd = val
+
+cdef class HblDVDeviceAttr(PyverbsObject):
+    """
+    Represents hbl device-specific capabilities reported by hbldv_query_device.
+    """
+    @property
+    def caps(self):
+        return self.attr.caps
+
+    @property
+    def ports_mask(self):
+        return self.attr.ports_mask
+
+cdef class HblContext(Context):
+    """
+    Represent hbl context, which extends Context.
+    """
+    def __init__(self, HblDVContextAttr attr not None, name=''):
+        """
+        Open an hbl device using the given attributes
+        :param name: The RDMA device's name (used by parent class)
+        :param attr: hbl-specific device attributes
+        :return: None
+        """
+        super().__init__(name=name, attr=attr)
+        if not dv.hbldv_is_supported(self.device):
+            raise PyverbsUserError('This is not an hbl device')
+        self.context = dv.hbldv_open_device(self.device, &attr.attr)
+        if self.context == NULL:
+            raise PyverbsRDMAErrno('Failed to open hbl context on {dev}'
+                                   .format(dev=self.name))
+
+    def query_hbl_device(self):
+        """
+        Query for device-specific attributes.
+        :return: An HblDVDeviceAttr containing the attributes.
+        """
+        dv_attr = HblDVDeviceAttr()
+        rc = dv.hbldv_query_device(self.context, &dv_attr.attr)
+        if rc:
+            raise PyverbsRDMAError(f'Failed to query hbl device {self.name}', rc)
+        return dv_attr
+
+    cpdef close(self):
+        if self.context != NULL:
+            super(HblContext, self).close()
+
+
+cdef class HblDVPortExAttr(PyverbsObject):
+    """
+    Represent hbldv_port_ex_attr struct. This class is used to set port extended params.
+    """
+    @property
+    def port_num(self):
+        return self.attr.port_num
+
+    @port_num.setter
+    def port_num(self,val):
+        self.attr.port_num = val
+
+    @property
+    def max_num_of_wqs(self):
+        return self.attr.wq_arr_attr[0].max_num_of_wqs
+
+    @max_num_of_wqs.setter
+    def max_num_of_wqs(self, val):
+        self.attr.wq_arr_attr[0].max_num_of_wqs = val
+
+    @property
+    def max_num_of_wqes_in_wq(self):
+        return self.attr.wq_arr_attr[0].max_num_of_wqes_in_wq
+
+    @max_num_of_wqes_in_wq.setter
+    def max_num_of_wqes_in_wq(self, val):
+        self.attr.wq_arr_attr[0].max_num_of_wqes_in_wq = val
+
+    @property
+    def mem_id(self):
+        return self.attr.wq_arr_attr[0].mem_id
+
+    @mem_id.setter
+    def mem_id(self,val):
+        self.attr.wq_arr_attr[0].mem_id = val
+
+    @property
+    def swq_granularity(self):
+        return self.attr.wq_arr_attr[0].swq_granularity
+
+    @swq_granularity.setter
+    def swq_granularity(self,val):
+        self.attr.wq_arr_attr[0].swq_granularity = val
+
+    @property
+    def caps(self):
+        return self.attr.caps
+
+    @caps.setter
+    def caps(self,val):
+        self.attr.caps = val
+
+
+cdef class HblDVPortExAttrTmp(PyverbsObject):
+    """
+    Represent hbldv_port_ex_attr struct. This class is used to set port extended params.
+    """
+    @property
+    def port_num(self):
+        return self.attr.port_num
+
+    @port_num.setter
+    def port_num(self,val):
+        self.attr.port_num = val
+
+    @property
+    def max_num_of_wqs(self):
+        return self.attr.wq_arr_attr[0].max_num_of_wqs
+
+    @max_num_of_wqs.setter
+    def max_num_of_wqs(self, val):
+        self.attr.wq_arr_attr[0].max_num_of_wqs = val
+
+    @property
+    def max_num_of_wqes_in_wq(self):
+        return self.attr.wq_arr_attr[0].max_num_of_wqes_in_wq
+
+    @max_num_of_wqes_in_wq.setter
+    def max_num_of_wqes_in_wq(self, val):
+        self.attr.wq_arr_attr[0].max_num_of_wqes_in_wq = val
+
+    @property
+    def mem_id(self):
+        return self.attr.wq_arr_attr[0].mem_id
+
+    @mem_id.setter
+    def mem_id(self,val):
+        self.attr.wq_arr_attr[0].mem_id = val
+
+    @property
+    def swq_granularity(self):
+        return self.attr.wq_arr_attr[0].swq_granularity
+
+    @swq_granularity.setter
+    def swq_granularity(self,val):
+        self.attr.wq_arr_attr[0].swq_granularity = val
+
+    @property
+    def caps(self):
+        return self.attr.caps
+
+    @caps.setter
+    def caps(self,val):
+        self.attr.caps = val
+
+cdef class HblDVSetPortEx(PyverbsObject):
+    """
+    This class is used to set port extended params.
+    """
+    def set_port_ex(self, Context ctx not None, HblDVPortExAttr attr not None):
+        rc = dv.hbldv_set_port_ex(ctx.context, &attr.attr)
+        if rc != 0:
+            raise PyverbsRDMAErrno("Failed to set port extended params")
+
+
+cdef class HblDVUserFIFOAttr(PyverbsObject):
+    """
+    Represent hbldv_usr_fifo_attr struct. This class is used to set a user FIFO.
+    """
+    @property
+    def port_num(self):
+        return self.attr.port_num
+
+    @port_num.setter
+    def port_num(self,val):
+        self.attr.port_num = val
+
+
+cdef class HblDVUserFIFO(PyverbsObject):
+    """
+    Represent hbl user FIFO resource.
+    """
+    def create_usr_fifo(self, Context ctx not None, HblDVUserFIFOAttr attr not None):
+        """
+        Creates a user FIFO resource.
+        :param ctx: The device context to issue the action on.
+        :param attr: The attributes used to allocate this user FIFO.
+        """
+        if self.usr_fifo != NULL:
+            raise PyverbsRDMAErrno("User FIFO already created")
+
+        self.usr_fifo = dv.hbldv_create_usr_fifo(ctx.context, &attr.attr)
+        if self.usr_fifo == NULL:
+            raise PyverbsRDMAErrno("Failed to create a user FIFO")
+
+    def destroy_usr_fifo(self):
+        """
+        Destroys a user FIFO resource.
+        """
+        if self.usr_fifo == NULL:
+            raise PyverbsRDMAErrno("No user FIFO to destroy")
+        err = dv.hbldv_destroy_usr_fifo(self.usr_fifo)
+        if err:
+            raise PyverbsRDMAError('Failed to destroy user FIFO', err)
+        self.usr_fifo = NULL
+
+
+
+cdef class HblDVCQattr(PyverbsObject):
+    """
+    Represent hbldv_cq_attr struct. This class is used to create a CQ.
+    """
+    @property
+    def port_num(self):
+        return self.cq_attr.port_num
+
+    @port_num.setter
+    def port_num(self,val):
+        self.cq_attr.port_num = val
+
+    @property
+    def cq_type(self):
+        return self.cq_attr.cq_type
+
+    @cq_type.setter
+    def cq_type(self,val):
+        self.cq_attr.cq_type = val
+
+cdef class HblDVCQ(PyverbsObject):
+    """
+    Represent CQ resource. This class is used to create and destroy CQs.
+    """
+    def create_cq(self, Context ctx, int cqes, HblDVCQattr cq_attr):
+        self.ibvcq = dv.hbldv_create_cq(ctx.context, cqes, NULL, 0, &cq_attr.cq_attr)
+        if self.ibvcq == NULL:
+            raise PyverbsRDMAErrno("Failed to create a CQ")
+
+    def query_cq(self, HblDVQueryCQ attr not None):
+        err = dv.hbldv_query_cq(self.ibvcq, &attr.query_cq_attr)
+        if err:
+            raise PyverbsRDMAErrno("Failed to query CQ")
+
+    def destroy_cq(self):
+        v.ibv_destroy_cq(self.ibvcq)
+
+
+cdef class HblDVPortAttr(PyverbsObject):
+    """
+    Represent hbldv_query_port_attr struct. This class is used to query port info.
+    """
+    @property
+    def hbl_attr(self):
+        return self
+
+
+cdef class HblQueryPort(PyverbsObject):
+    """
+    Represent hbl port specific attributes.
+    """
+    def query_port(self, Context ctx not None, int port, HblDVPortAttr attr not None):
+        """
+        Creates a Query Port instance
+        :param ctx: The device context to issue the action on.
+        :param port_num: the port for which info is required.
+        :param attr: The attributes used to get port info from.
+        """
+        rc = dv.hbldv_query_port(ctx.context, port, &attr.hbl_attr)
+        if rc != 0:
+            raise PyverbsRDMAErrno("query port returns error")
+
+cdef class HblDVQueryQP(PyverbsObject):
+    @property
+    def qp_num(self):
+        return self.query_qp_attr.qp_num
+
+cdef class HblDVQP(PyverbsObject):
+    """
+    Represent HBL QP resource. This class is used to create, modify, destroy QP.
+    """
+    def create_qp(self, PD pd, QPInitAttr attr):
+        self.ibvqp = v.ibv_create_qp(<v.ibv_pd*>pd.pd, &attr.attr)
+        if self.ibvqp == NULL:
+            raise PyverbsRDMAErrno("Failed to create a QP")
+
+    def modify_qp(self, QPAttr qp_attr, int attr_mask, HblDVModifyQP attr):
+        err = dv.hbldv_modify_qp(self.ibvqp, &qp_attr.attr, attr_mask, &attr.attr)
+        if err:
+            raise PyverbsRDMAErrno("Failed to Modify QP")
+
+    def destroy_qp(self):
+        err = v.ibv_destroy_qp(self.ibvqp)
+        if err:
+            raise PyverbsRDMAErrno("Failed to destroy QP")
+
+    def query_qp(self, HblDVQueryQP attr not None):
+        err = dv.hbldv_query_qp(self.ibvqp, &attr.query_qp_attr)
+        if err:
+            raise PyverbsRDMAErrno("Failed to query QP")
+
+cdef class HblDVEncapAttr(PyverbsObject):
+    """
+    Represent hbldv_encap_attr struct. This class is used to create a Encap.
+    """
+    def __init__(self):
+        hdr = <uint32_t *>PyMem_Malloc(32)
+        if not hdr:
+            raise MemoryError()
+        hdr[0] = 0x8
+        self.encap_attr.tnl_hdr_ptr = <uint64_t>hdr
+
+    def __del__(self):
+        PyMem_Free(<void *>self.encap_attr.tnl_hdr_ptr)
+
+    @property
+    def port_num(self):
+        return self.encap_attr.port_num
+
+    @port_num.setter
+    def port_num(self,val):
+        self.encap_attr.port_num = val
+
+    @property
+    def encap_type(self):
+        return self.encap_attr.encap_type
+
+    @encap_type.setter
+    def encap_type(self,val):
+        self.encap_attr.encap_type = val
+
+    @property
+    def tnl_hdr_size(self):
+        return self.encap_attr.tnl_hdr_size
+
+    @tnl_hdr_size.setter
+    def tnl_hdr_size(self,val):
+        self.encap_attr.tnl_hdr_size = val
+
+cdef class HblDVEncap(PyverbsObject):
+    """
+    Represent Encap resource. This class is used to create and destroy Encaps.
+    """
+    def create_encap(self, Context ctx, HblDVEncapAttr encap_attr, HblDVEncapOut encap_out):
+        self.hbldv_encap = dv.hbldv_create_encap(ctx.context, &encap_attr.encap_attr)
+        if self.hbldv_encap == NULL:
+            raise PyverbsRDMAErrno("Failed to create a Encap")
+
+    def destroy_encap(self):
+        dv.hbldv_destroy_encap(self.hbldv_encap)
+
+cdef class HblDVModifyQP(PyverbsObject):
+    """
+    Represent hbldv_qp_attr struct. This class is used to modify a QP.
+    """
+    @property
+    def wq_type(self):
+        return self.attr.wq_type
+
+    @wq_type.setter
+    def wq_type(self,val):
+        self.attr.wq_type = val
diff --git a/pyverbs/providers/hbl/libhbl.pxd b/pyverbs/providers/hbl/libhbl.pxd
new file mode 100644
index 000000000..9cee30d64
--- /dev/null
+++ b/pyverbs/providers/hbl/libhbl.pxd
@@ -0,0 +1,142 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright 2022-2024 HabanaLabs, Ltd.
+# Copyright (C) 2023-2024, Intel Corporation.
+# All Rights Reserved.
+
+#cython: language_level=3
+
+include 'hbl_enums.pxd'
+
+from libc.stdint cimport uint8_t, uint16_t, uint32_t, uint64_t, uintptr_t
+from posix.types cimport off_t
+from libcpp cimport bool
+
+cimport libc.stdio as s
+cimport pyverbs.libibverbs as v
+
+
+cdef extern from 'infiniband/hbldv.h':
+
+    cdef struct hbldv_ucontext_attr:
+        uint64_t ports_mask
+        int core_fd
+
+    cdef struct hbldv_usr_fifo_attr:
+        uint32_t port_num
+        uint32_t base_sob_addr
+        uint32_t num_sobs
+        uint32_t usr_fifo_num_hint
+        hbldv_usr_fifo_type usr_fifo_type
+        uint8_t dir_dup_mask
+
+    cdef struct hbldv_usr_fifo:
+        void *ci_cpu_addr
+        void *regs_cpu_addr
+        uint32_t regs_offset
+        uint32_t usr_fifo_num
+        uint32_t size
+        uint32_t bp_thresh
+
+    cdef struct hbldv_query_cq_attr:
+        v.ibv_cq *ibvcq
+        void *mem_cpu_addr
+        void *pi_cpu_addr
+        void *regs_cpu_addr
+        uint32_t cq_size
+        uint32_t cq_num
+        uint32_t regs_offset
+        hbldv_cq_type cq_type
+
+    cdef struct hbldv_cq_attr:
+        uint8_t port_num
+        hbldv_cq_type cq_type
+
+    cdef struct hbldv_wq_array_attr:
+        uint32_t max_num_of_wqs
+        uint32_t max_num_of_wqes_in_wq
+        hbldv_mem_id mem_id
+        hbldv_swq_granularity swq_granularity
+
+    cdef struct hbldv_port_ex_attr:
+        hbldv_wq_array_attr *wq_arr_attr
+        uint64_t caps
+        uint8_t *qp_wq_bp_offs
+        uint8_t *atomic_fna_fifo_offs
+        uint32_t port_num
+        uint8_t atomic_fna_mask_size
+
+    cdef struct hbldv_query_port_attr:
+        uint32_t max_num_of_qps
+        uint32_t num_allocated_qps
+        uint32_t max_allocated_qp_num
+        uint32_t max_cq_size
+        uint32_t speed
+        uint32_t reserved0
+        uint32_t reserved1
+        uint32_t reserved2
+        uint32_t reserved3
+        uint32_t reserved4
+        uint8_t advanced
+        uint8_t max_num_of_cqs
+        uint8_t max_num_of_usr_fifos
+        uint8_t max_num_of_encaps
+        uint8_t nic_macro_idx
+        uint8_t nic_phys_port_idx
+
+    cdef struct hbldv_qp_attr:
+        uint64_t caps
+        uint32_t local_key
+        uint32_t remote_key
+        uint32_t congestion_wnd
+        uint32_t reserved0
+        uint32_t dest_wq_size
+        hbldv_qp_wq_types wq_type
+        hbldv_swq_granularity wq_granularity
+        uint8_t priority
+        uint8_t reserved1
+        uint8_t reserved2
+        uint8_t encap_num
+        uint8_t reserved3
+
+    cdef struct hbldv_query_qp_attr:
+        uint32_t qp_num
+        void *swq_cpu_addr
+        void *rwq_cpu_addr
+
+    cdef struct hbldv_encap:
+        uint32_t encap_num
+
+    cdef union l3_l4_data:
+        uint16_t udp_dst_port
+        uint16_t ip_proto
+
+    cdef struct hbldv_encap_attr:
+        uint64_t tnl_hdr_ptr
+        uint32_t tnl_hdr_size
+        uint32_t ipv4_addr
+        l3_l4_data l3_l4_data
+        uint32_t port_num
+        uint8_t encap_type
+
+    cdef struct hbldv_device_attr:
+        uint64_t caps
+        uint64_t ports_mask
+
+    bool hbldv_is_supported(v.ibv_device *device)
+    v.ibv_context *hbldv_open_device(v.ibv_device *device,
+                                     hbldv_ucontext_attr *attr)
+    hbldv_usr_fifo *hbldv_create_usr_fifo(v.ibv_context *context,
+                                          hbldv_usr_fifo_attr *attr);
+    void hbldv_destroy_usr_fifo(hbldv_usr_fifo *usr_fifo);
+    v.ibv_cq *hbldv_create_cq(v.ibv_context *context, int cqes, v.ibv_comp_channel *channel,
+                              int comp_vector, hbldv_cq_attr *cq_attr)
+    int hbldv_query_cq(v.ibv_cq *ibvcq, hbldv_query_cq_attr *cq_attr);
+    int hbldv_set_port_ex(v.ibv_context *context, hbldv_port_ex_attr *attr);
+    int hbldv_query_port(v.ibv_context *context, uint32_t port_num,
+                         hbldv_query_port_attr *hbl_attr);
+    int hbldv_modify_qp(v.ibv_qp *ibvqp, v.ibv_qp_attr *attr,
+                        int attr_mask, hbldv_qp_attr *qp_attr);
+    int hbldv_query_qp(v.ibv_qp *ibvqp, hbldv_query_qp_attr *qp_attr);
+    hbldv_encap *hbldv_create_encap(v.ibv_context *context, hbldv_encap_attr *encap_attr)
+    int hbldv_destroy_encap(hbldv_encap *hbl_encap)
+    int hbldv_query_device(v.ibv_context *context, hbldv_device_attr *attr)
diff --git a/pyverbs/providers/hbl/libhbl.pyx b/pyverbs/providers/hbl/libhbl.pyx
new file mode 100644
index 000000000..e69de29bb
-- 
2.34.1


