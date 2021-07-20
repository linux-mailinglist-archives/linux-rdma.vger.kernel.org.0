Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5C23CF60A
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhGTHiJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:38:09 -0400
Received: from mail-bn8nam12on2061.outbound.protection.outlook.com ([40.107.237.61]:51168
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234588AbhGTHiC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:38:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDhdLSNwLcCU69uW73GGa652nskmL0QtYwII/XhiKuCXiAltNKLu97ApdemOBZvR1Et/2cVPzE1ZVpgDCvMnCEi085W0E+CD/hSajaMYgfdBKgYqJlO7nIbRShsWiG4fBsMnSgsSbK05wvEkuSVp2kO/IjCby9NeQZBV6aOlhe2Pk3v/qNkKQ7hOxDM+S12Cd5my1b4DrYO9fCjGs0I68CKRkPKYs7NhNQrfGiucc9NyXzaq4G35UkV/jBBBs8S4zIDxOdmSjFc4518gQ7qQYBNZE56TE5lu2m67mD3xGQtdmZABtsTGnALEzpwsGgObKo8hpF/QrEbvS621XRycyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iST6CQbGJ6SmvgxmdhPEBErmusimR2KJNDwIXh81uLQ=;
 b=gnZKjdnn1d+qDxHbZ2E0qJchBdeOCk9iwhxOXnm4F9SbQP3eaql7YAbweIaJS9aQrsCKKq3Eg/eXBlDxc0Ghv9HOKEgNMyHRuPZn/ghmE5XFzpFTx2B2aaVVaVj60HGoUuvRH2JoI7wYNyAJQhgRVlfaV/aRxRDKDpeMsARz+E2ahMAUZHB8C14Vz77mApERvwnaRje+Jz0DkM98t/qZzzW3tZne+P2KZ+bR5LW3Lo5H8PS8to49Nin4i2zc189tH2aAWzXUJKMishCXOdQNjuHfnVEPcQgJVINoslSpbGisPpHXHhcNFaoB+CkST75zNMvHa7ajUce2Oe/ihRrJFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iST6CQbGJ6SmvgxmdhPEBErmusimR2KJNDwIXh81uLQ=;
 b=ELBHi/DRgea7+elPmoommNuwRChTasubM+gSi7Cn4PDC5Ulc95zTiftc7eWQLGcMAkZmHD8mM3Fvn0vIiucKicSqVE4WFE6RTlhxRMZ65blnPHPO31oqthQO2hPn43EjDiwaMq8CHmfrrOWiX7/jsfULBax2nAf/XhYAwXHj6090Bj74LqqFowZB53xmh2wkEiWptZyTWLTL3cm/57Ey76zfI1tpaBMM9E3WZkWT5HyDpYFS2gSIO1sQw3fCV8hB75zFMiH5Jemv2gW76PpWtezZB0nFcz0VAmNMOhAjn4USmU1w6bhvsG54XaI/mav6nJ+x+n5pVPN1JcmJlsa2dg==
Received: from DM6PR18CA0019.namprd18.prod.outlook.com (2603:10b6:5:15b::32)
 by CY4PR12MB1223.namprd12.prod.outlook.com (2603:10b6:903:38::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Tue, 20 Jul
 2021 08:18:38 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::d) by DM6PR18CA0019.outlook.office365.com
 (2603:10b6:5:15b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 08:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:18:38 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:18:35 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:18:35 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:18:32 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>,
        Ido Kalir <idok@nvidia.com>
Subject: [PATCH rdma-core 26/27] pyverbs/mlx5: Support mlx5 devices over VFIO
Date:   Tue, 20 Jul 2021 11:16:46 +0300
Message-ID: <20210720081647.1980-27-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfa64d08-86f9-47d7-befa-08d94b56fa06
X-MS-TrafficTypeDiagnostic: CY4PR12MB1223:
X-Microsoft-Antispam-PRVS: <CY4PR12MB122318BD01580F497E1E7515C3E29@CY4PR12MB1223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OhXx3a0j/csC/wRwTIfTYuV9f0/eu7WDdGmjjJTRYCfYEPBTtEYYUZmxasCY8bR84sOh1uQ4bzRKDt50enQcfFLpPRBkwtBYIA3jcLhdK/CI3+BNkOewsYHygdlULENQIUjJukYEUE/4LbzmE7tGTDp6KS4rigCUCcjLNg1hyUXRLCcDVZLqz/Mnjhvyech+GKL+IGU90c+CuPBzLWP2J3wJQavN0DPDq8hkqdTZwM9ir2bnciz95/VhZItfSbvOJ/YQoNHvp10lhEfdQVMPavjBh6AVQlU4jfwpt1XXNpiRnsf3ikPUdcP7P4n8HyrJF4xFLYYOvmcvZV70YPa+xqOX0V5n2EhUfWQugjDMzQo0g/qB4k5mz3GRpjhNGJAUhgg6ErSuc5F4izKyPLZh/yvO3n219TiKY0akYk85VAMaulatJp7HqZtbw+NDs0se0QeORVlX97XnVKs6rglmD+kPWVV1FvL59NLPOk17bPwZquqajiCxuOmqlRZA3vi4B5JYss+jxSMARfM5CRSeOXcdA/42fdeqaARgzlc4IgEfb/kngAA9lmAtRHCRDC33/OMphMqGm8H9UEZIM2Nehcgoooetyw5+0Fu2jw/vihqSck1u+QRgCLj7PLG0KrHDv1NSyW94gzy4eL8nhVJZlTu0XFeZeMrWQAzoA/UHsn5Nq5OEGxuzp23MXap7/+OCLpnrj6zYcA30RAc5T537Ow==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(36840700001)(1076003)(36756003)(86362001)(26005)(82310400003)(36860700001)(186003)(7696005)(4326008)(70586007)(70206006)(36906005)(2906002)(19627235002)(356005)(7636003)(47076005)(6666004)(6916009)(5660300002)(107886003)(8936002)(82740400003)(2616005)(336012)(426003)(478600001)(316002)(8676002)(54906003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:18:38.2173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa64d08-86f9-47d7-befa-08d94b56fa06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1223
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@nvidia.com>

Support opening an mlx5 device and creating a context over VFIO by
adding  Mlx5VfioContext class based on Mlx5Context to allow using DevX
APIs.

Reviewed-by: Ido Kalir <idok@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 pyverbs/providers/mlx5/CMakeLists.txt   |   3 +-
 pyverbs/providers/mlx5/libmlx5.pxd      |   8 +++
 pyverbs/providers/mlx5/mlx5_vfio.pxd    |  15 +++++
 pyverbs/providers/mlx5/mlx5_vfio.pyx    | 116 ++++++++++++++++++++++++++++++++
 pyverbs/providers/mlx5/mlx5dv.pxd       |   3 +
 pyverbs/providers/mlx5/mlx5dv_enums.pxd |   3 +
 6 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 pyverbs/providers/mlx5/mlx5_vfio.pxd
 create mode 100644 pyverbs/providers/mlx5/mlx5_vfio.pyx

diff --git a/pyverbs/providers/mlx5/CMakeLists.txt b/pyverbs/providers/mlx5/CMakeLists.txt
index 4763c61..c0b5869 100644
--- a/pyverbs/providers/mlx5/CMakeLists.txt
+++ b/pyverbs/providers/mlx5/CMakeLists.txt
@@ -7,8 +7,9 @@ rdma_cython_module(pyverbs/providers/mlx5 mlx5
   dr_matcher.pyx
   dr_rule.pyx
   dr_table.pyx
-  mlx5dv.pyx
   mlx5_enums.pyx
+  mlx5_vfio.pyx
+  mlx5dv.pyx
   mlx5dv_flow.pyx
   mlx5dv_mkey.pyx
   mlx5dv_objects.pyx
diff --git a/pyverbs/providers/mlx5/libmlx5.pxd b/pyverbs/providers/mlx5/libmlx5.pxd
index af034ad..e0904f5 100644
--- a/pyverbs/providers/mlx5/libmlx5.pxd
+++ b/pyverbs/providers/mlx5/libmlx5.pxd
@@ -223,6 +223,11 @@ cdef extern from 'infiniband/mlx5dv.h':
         uint64_t    pgsz_bitmap
         uint64_t    comp_mask
 
+    cdef struct mlx5dv_vfio_context_attr:
+        const char  *pci_name
+        uint32_t    flags
+        uint64_t    comp_mask
+
     cdef struct mlx5dv_pd:
         uint32_t    pdn
         uint64_t    comp_mask
@@ -372,6 +377,9 @@ cdef extern from 'infiniband/mlx5dv.h':
                              uint64_t device_timestamp)
     int mlx5dv_get_clock_info(v.ibv_context *ctx_in, mlx5dv_clock_info *clock_info)
     int mlx5dv_map_ah_to_qp(v.ibv_ah *ah, uint32_t qp_num)
+    v.ibv_device **mlx5dv_get_vfio_device_list(mlx5dv_vfio_context_attr *attr)
+    int mlx5dv_vfio_get_events_fd(v.ibv_context *ibctx)
+    int mlx5dv_vfio_process_events(v.ibv_context *context)
 
     # DevX APIs
     mlx5dv_devx_uar *mlx5dv_devx_alloc_uar(v.ibv_context *context, uint32_t flags)
diff --git a/pyverbs/providers/mlx5/mlx5_vfio.pxd b/pyverbs/providers/mlx5/mlx5_vfio.pxd
new file mode 100644
index 0000000..0e9facd
--- /dev/null
+++ b/pyverbs/providers/mlx5/mlx5_vfio.pxd
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2021 Nvidia, Inc. All rights reserved. See COPYING file
+
+#cython: language_level=3
+
+from pyverbs.providers.mlx5.mlx5dv cimport Mlx5Context
+cimport pyverbs.providers.mlx5.libmlx5 as dv
+from pyverbs.base cimport PyverbsObject
+
+
+cdef class Mlx5VfioContext(Mlx5Context):
+    pass
+
+cdef class Mlx5VfioAttr(PyverbsObject):
+    cdef dv.mlx5dv_vfio_context_attr attr
diff --git a/pyverbs/providers/mlx5/mlx5_vfio.pyx b/pyverbs/providers/mlx5/mlx5_vfio.pyx
new file mode 100644
index 0000000..2978b61
--- /dev/null
+++ b/pyverbs/providers/mlx5/mlx5_vfio.pyx
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2021 Nvidia, Inc. All rights reserved. See COPYING file
+
+#cython: language_level=3
+
+from cpython.mem cimport PyMem_Malloc, PyMem_Free
+from libc.string cimport strcpy
+import weakref
+
+from pyverbs.pyverbs_error import PyverbsRDMAError
+cimport pyverbs.providers.mlx5.libmlx5 as dv
+from pyverbs.base import PyverbsRDMAErrno
+from pyverbs.base cimport close_weakrefs
+from pyverbs.device cimport Context
+cimport pyverbs.libibverbs as v
+
+
+cdef class Mlx5VfioAttr(PyverbsObject):
+    """
+    Mlx5VfioAttr class, represents mlx5dv_vfio_context_attr C struct.
+    """
+    def __init__(self, pci_name, flags=0, comp_mask=0):
+        self.pci_name = pci_name
+        self.attr.flags = flags
+        self.attr.comp_mask = comp_mask
+
+    def __dealloc__(self):
+        if self.attr.pci_name != NULL:
+            PyMem_Free(<void*>self.attr.pci_name)
+            self.attr.pci_name = NULL
+
+    @property
+    def flags(self):
+        return self.attr.flags
+    @flags.setter
+    def flags(self, val):
+        self.attr.flags = val
+
+    @property
+    def comp_mask(self):
+        return self.attr.comp_mask
+    @comp_mask.setter
+    def comp_mask(self, val):
+        self.attr.comp_mask = val
+
+    @property
+    def pci_name(self):
+        return self.attr.pci_name[:]
+    @pci_name.setter
+    def pci_name(self, val):
+        if self.attr.pci_name != NULL:
+            PyMem_Free(<void*>self.attr.pci_name)
+        pci_name_bytes = val.encode()
+        self.attr.pci_name = <char*>PyMem_Malloc(len(pci_name_bytes))
+        strcpy(<char*>self.attr.pci_name, pci_name_bytes)
+
+
+cdef class Mlx5VfioContext(Mlx5Context):
+    """
+    Mlx5VfioContext class is used to easily initialize and open a context over
+    a mlx5 vfio device.
+    It is initialized based on the passed mlx5 vfio attributes (Mlx5VfioAttr),
+    by getting the relevant vfio device and opening it (creating a context).
+    """
+    def __init__(self, Mlx5VfioAttr attr):
+        super(Context, self).__init__()
+        cdef v.ibv_device **dev_list
+
+        self.name = attr.pci_name
+        self.pds = weakref.WeakSet()
+        self.devx_umems = weakref.WeakSet()
+        self.devx_objs = weakref.WeakSet()
+        self.uars = weakref.WeakSet()
+
+        dev_list = dv.mlx5dv_get_vfio_device_list(&attr.attr)
+        if dev_list == NULL:
+            raise PyverbsRDMAErrno('Failed to get VFIO device list')
+        self.device = dev_list[0]
+        if self.device == NULL:
+            raise PyverbsRDMAError('Failed to get VFIO device')
+        try:
+            self.context = v.ibv_open_device(self.device)
+            if self.context == NULL:
+                raise PyverbsRDMAErrno('Failed to open mlx5 VFIO device '
+                                       f'({self.device.name.decode()})')
+        finally:
+            v.ibv_free_device_list(dev_list)
+
+    def get_events_fd(self):
+        """
+        Gets the file descriptor to manage driver events.
+        :return: The file descriptor to be used for managing driver events.
+        """
+        fd = dv.mlx5dv_vfio_get_events_fd(self.context)
+        if fd < 0:
+            raise PyverbsRDMAError('Failed to get VFIO events FD', -fd)
+        return fd
+
+    def process_events(self):
+        """
+        Process events on the vfio device.
+        This method should run from application thread to maintain device events.
+        :return: None
+        """
+        rc = dv.mlx5dv_vfio_process_events(self.context)
+        if rc:
+            raise PyverbsRDMAError('VFIO process events failed', rc)
+
+    cpdef close(self):
+        if self.context != NULL:
+            self.logger.debug('Closing Mlx5VfioContext')
+            close_weakrefs([self.pds, self.devx_objs, self.devx_umems, self.uars])
+            rc = v.ibv_close_device(self.context)
+            if rc != 0:
+                raise PyverbsRDMAErrno(f'Failed to close device {self.name}')
+            self.context = NULL
diff --git a/pyverbs/providers/mlx5/mlx5dv.pxd b/pyverbs/providers/mlx5/mlx5dv.pxd
index 968cbdb..490c697 100644
--- a/pyverbs/providers/mlx5/mlx5dv.pxd
+++ b/pyverbs/providers/mlx5/mlx5dv.pxd
@@ -86,3 +86,6 @@ cdef class Mlx5DevxObj(PyverbsCM):
 
 cdef class Mlx5Cqe64(PyverbsObject):
     cdef dv.mlx5_cqe64 *cqe
+
+cdef class Mlx5VfioAttr(PyverbsObject):
+    cdef dv.mlx5dv_vfio_context_attr attr
diff --git a/pyverbs/providers/mlx5/mlx5dv_enums.pxd b/pyverbs/providers/mlx5/mlx5dv_enums.pxd
index 60713e8..94599ab 100644
--- a/pyverbs/providers/mlx5/mlx5dv_enums.pxd
+++ b/pyverbs/providers/mlx5/mlx5dv_enums.pxd
@@ -215,6 +215,9 @@ cdef extern from 'infiniband/mlx5dv.h':
         MLX5_SEND_WQE_BB
         MLX5_SEND_WQE_SHIFT
 
+    cpdef enum mlx5dv_vfio_context_attr_flags:
+        MLX5DV_VFIO_CTX_FLAGS_INIT_LINK_DOWN
+
     cpdef unsigned long long MLX5DV_RES_TYPE_QP
     cpdef unsigned long long MLX5DV_RES_TYPE_RWQ
     cpdef unsigned long long MLX5DV_RES_TYPE_DBR
-- 
1.8.3.1

