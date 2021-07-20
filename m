Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645F43CF600
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhGTHhw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:52 -0400
Received: from mail-bn8nam08on2084.outbound.protection.outlook.com ([40.107.100.84]:33923
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232461AbhGTHhl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Feh/aIg6n5hUZBWfi1+WoPJXpNW9i+E1Ba3SS9PltfkvhgTHRejoDIzsL69SQLkBG73mYrrRiJ0BvoEkjUbvG5feQtSxN1oe+HZSyaJ1VSNEvgxXNwez2GaO+DW+jCDEQo1pkP8N/uYL6LEXyn2wtOb5K0t7qUb8F8j/OtmwxR8ttrbe0VLU3XxeqcN/MTmVHzLx3ipqAEUyz2izTr7MWU1upUHsDaXqhBZ9dIoTblAldt1Oa1a2P/1C3i+TvDA0PqzDY+uHVB92/U4RzX11l3fGdof8y6HByLUONyK40Rqm3L8NkZttQWS/rloZFPfJqKEjw6MdKT7YwIP99md+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H680KUjnI3xzBppk/IlhBBTQs1mtIhqp1+h/3F5l7rQ=;
 b=mnyDYI8CBFAHViMevbZE7nsaXVuAZJpXijfy0F1OwR/LSX+DzJz3cERG3HBXDxjdopGaXKsbFOIZoh4he9BjTCqQzTnjo9GLc+qxA6wxcuJ7WfUQV5KlydMVHqd6s34exPuSYHPdU3A6uoBn+DaNtx5pHbhfGd2jaUnJ6XOniiyEuFpn5QLQCjcjGAOadRxZd7tGYW3/QqLBXD6aSqiBMT/xbuLRWhMT32oZYqJ3LWgviZcNRBqUSoMzS2jSymXFRpwud6sanWkkBneQhw/2im5FNg7n8gLC0w79GQq4JtHD08CJa06IxoFB3vNQzsmem57jyoWmltRE7fid+u6fYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H680KUjnI3xzBppk/IlhBBTQs1mtIhqp1+h/3F5l7rQ=;
 b=HRcCRwM6GbcuU5oXAVN80oyrozqR4l5TAJP0qVriOnsNL1sbJgBXKdLjYjIh/NlAIWZqUBlryJHUHOmhtk7SNsPIlkfMB6r8dJjhdbbq7iY03uufTEAbZFLbz6qtIW3Xq48A/P98MKWkK/0l5lEMCOxHZI5nzV0EVs85naPLcds8lgcmNo8qwm4mUDgtqG7alauMyvUPH6F0zoTzuTpbegViqIsXCoyjbUSiMRB4YT0GejbUB5HbuctD0/ZN4W9nJiw24xEQOfDNwFGYhp4f7GxPvIEr400j/et8tu3oHlQlmrFgiPlnJL0Aa1guzbk5hIxPhr4+SqOmpiddVz8zuQ==
Received: from CO2PR07CA0044.namprd07.prod.outlook.com (2603:10b6:100::12) by
 MWHPR12MB1821.namprd12.prod.outlook.com (2603:10b6:300:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 08:18:18 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::f8) by CO2PR07CA0044.outlook.office365.com
 (2603:10b6:100::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 08:18:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:18:18 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:18:17 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:18:15 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>,
        Ido Kalir <idok@nvidia.com>
Subject: [PATCH rdma-core 21/27] pyverbs: Add auxiliary memory functions
Date:   Tue, 20 Jul 2021 11:16:41 +0300
Message-ID: <20210720081647.1980-22-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 709a5c98-ee9c-4287-c411-08d94b56ee45
X-MS-TrafficTypeDiagnostic: MWHPR12MB1821:
X-Microsoft-Antispam-PRVS: <MWHPR12MB18211CCC5C27603A1E996621C3E29@MWHPR12MB1821.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwlv+zcYuigzy0bWJq1FZ7velWddgCnfrb7Jd/8esVmcUk9HRnzmlJXMGuVC8gHg7BfIfuPODNq6sIZ5O1XIwLDL1q54aXeIVlkFi6UyXS9r0smhRAfwhYl7HIyCN0d+iUJErVm4XouuIlk3exSny0nDYpEIDaBDhFbOzxCj++1/FSp/dHLVoX7y4lrJpS7EBRTtzEhFHeMje0HyVf+QMCNnrnX6rtJif/+iAjouCOYxsIM1XN5rfRpwoID5K+OuwcIKI7ZRqDwK3/m6min/N5boPtMUR56ohBMazmA/mIwCo/mdL+KhIhOaM7zpnJR03UvQUHHXvlOa6sXMS2lhaClQbxq7/R7blG0WIKqnHTvH/h55OauXPIf5BZ8xs13fsFwZr8bBiELMzPkgIphACby5+yerU1mqYJhxkNZzDejRAVzS6e7SoDItLZcjif6Ywc1PgJJgvUtFvIFTJHQDjQiIvGMPKw3d41NHaTV12yXfpLFbmJMYhLNIx7fgQ7ccijspw6j11BtxZLzkkV85MNTaVUrvmD7OQ06yHp9dAJoIKlrxakwz6gKvkmqYH/XE0Kmz3REuwCTSoZ2whm33hxzA+XqOzX0ZWKQ/B2YG/UnGOlc6pJfgW+3iOZmQ6KAqplL5h425LNTY586mg1UxuI22jDhXWwGFZTN+URK0/dwPIgAxDdulbcwJWxlLfmUAAxV/Wjz05HrSiS92VW4BZQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(6666004)(7696005)(356005)(1076003)(47076005)(2616005)(508600001)(4326008)(336012)(54906003)(8936002)(7636003)(316002)(36756003)(36860700001)(70586007)(426003)(186003)(8676002)(83380400001)(26005)(107886003)(6916009)(5660300002)(2906002)(86362001)(36906005)(82310400003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:18:18.5336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 709a5c98-ee9c-4287-c411-08d94b56ee45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1821
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@nvidia.com>

Add some auxiliary functions to mem_alloc module to expose to Python
users the ability to read/write from/to memory, with chuncks of 4/8
bytes.
In addition, expose udma memory barriers and the ability to write on
MMIO.

Reviewed-by: Ido Kalir <idok@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 pyverbs/CMakeLists.txt |  7 +++++++
 pyverbs/dma_util.pyx   | 25 +++++++++++++++++++++++++
 pyverbs/mem_alloc.pyx  | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 pyverbs/dma_util.pyx

diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index c532b4c..f403719 100644
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -12,6 +12,12 @@ else()
   set(DMABUF_ALLOC dmabuf_alloc_stub.c)
 endif()
 
+if (HAVE_COHERENT_DMA)
+  set(DMA_UTIL dma_util.pyx)
+else()
+  set(DMA_UTIL "")
+endif()
+
 rdma_cython_module(pyverbs ""
   addr.pyx
   base.pyx
@@ -19,6 +25,7 @@ rdma_cython_module(pyverbs ""
   cmid.pyx
   cq.pyx
   device.pyx
+  ${DMA_UTIL}
   dmabuf.pyx
   ${DMABUF_ALLOC}
   enums.pyx
diff --git a/pyverbs/dma_util.pyx b/pyverbs/dma_util.pyx
new file mode 100644
index 0000000..36d5f9b
--- /dev/null
+++ b/pyverbs/dma_util.pyx
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2021 Nvidia, Inc. All rights reserved. See COPYING file
+
+#cython: language_level=3
+
+from libc.stdint cimport uintptr_t, uint64_t
+
+cdef extern from 'util/udma_barrier.h':
+    cdef void udma_to_device_barrier()
+    cdef void udma_from_device_barrier()
+
+cdef extern from 'util/mmio.h':
+   cdef void mmio_write64_be(void *addr, uint64_t val)
+
+
+def udma_to_dev_barrier():
+    udma_to_device_barrier()
+
+
+def udma_from_dev_barrier():
+    udma_from_device_barrier()
+
+
+def mmio_write64_as_be(addr, val):
+    mmio_write64_be(<void*><uintptr_t> addr, val)
diff --git a/pyverbs/mem_alloc.pyx b/pyverbs/mem_alloc.pyx
index 24be4f1..c6290f7 100644
--- a/pyverbs/mem_alloc.pyx
+++ b/pyverbs/mem_alloc.pyx
@@ -6,13 +6,17 @@
 from posix.stdlib cimport posix_memalign as c_posix_memalign
 from libc.stdlib cimport malloc as c_malloc, free as c_free
 from posix.mman cimport mmap as c_mmap, munmap as c_munmap
-from libc.stdint cimport uintptr_t
+from libc.stdint cimport uintptr_t, uint32_t, uint64_t
 from libc.string cimport memset
 cimport posix.mman as mm
 
 cdef extern from 'sys/mman.h':
     cdef void* MAP_FAILED
 
+cdef extern from 'endian.h':
+    unsigned long htobe32(unsigned long host_32bits)
+    unsigned long htobe64(unsigned long host_64bits)
+
 
 def mmap(addr=0, length=100, prot=mm.PROT_READ | mm.PROT_WRITE,
          flags=mm.MAP_PRIVATE | mm.MAP_ANONYMOUS, fd=0, offset=0):
@@ -82,6 +86,46 @@ def free(ptr):
     c_free(<void*><uintptr_t>ptr)
 
 
+def writebe32(addr, val, offset=0):
+    """
+    Write 32-bit value <val> as Big Endian to address <addr> and offset <offset>
+    :param addr: The start of the address to write the value to
+    :param val: Value to write
+    :param offset: Offset of the address  to write the value to (in 4-bytes)
+    """
+    (<uint32_t*><void*><uintptr_t>addr)[offset] = htobe32(val)
+
+
+def writebe64(addr, val, offset=0):
+    """
+    Write 64-bit value <val> as Big Endian to address <addr> and offset <offset>
+    :param addr: The start of the address to write the value to
+    :param val: Value to write
+    :param offset: Offset of the address  to write the value to (in 8-bytes)
+    """
+    (<uint64_t*><void*><uintptr_t>addr)[offset] = htobe64(val)
+
+
+def read32(addr, offset=0):
+    """
+    Read 32-bit value from address <addr> and offset <offset>
+    :param addr: The start of the address to read from
+    :param offset: Offset of the address to read from (in 4-bytes)
+    :return: The read value
+    """
+    return (<uint32_t*><uintptr_t>addr)[offset]
+
+
+def read64(addr, offset=0):
+    """
+    Read 64-bit value from address <addr> and offset <offset>
+    :param addr: The start of the address to read from
+    :param offset: Offset of the address to read from (in 8-bytes)
+    :return: The read value
+    """
+    return (<uint64_t*><uintptr_t>addr)[offset]
+
+
 # protection bits for mmap/mprotect
 PROT_EXEC_ = mm.PROT_EXEC
 PROT_READ_ = mm.PROT_READ
-- 
1.8.3.1

