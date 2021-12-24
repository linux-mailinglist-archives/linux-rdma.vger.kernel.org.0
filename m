Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E8C47EC51
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Dec 2021 07:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351646AbhLXGze (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Dec 2021 01:55:34 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:36343 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241330AbhLXGzb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Dec 2021 01:55:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V.bRwAa_1640328928;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.bRwAa_1640328928)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Dec 2021 14:55:29 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     leon@kernel.org
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, chengyou@linux.alibaba.com
Subject: [PATCH rdma-core 5/5] RDMA-CORE/erdma: Add to the build environment
Date:   Fri, 24 Dec 2021 14:55:22 +0800
Message-Id: <20211224065522.29734-6-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20211224065522.29734-1-chengyou@linux.alibaba.com>
References: <20211224065522.29734-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make the build system can build the provider, and add it to redhat package
environment.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 CMakeLists.txt                 | 1 +
 MAINTAINERS                    | 5 +++++
 README.md                      | 1 +
 kernel-headers/CMakeLists.txt  | 2 ++
 providers/erdma/CMakeLists.txt | 5 +++++
 redhat/rdma-core.spec          | 2 ++
 6 files changed, 16 insertions(+)
 create mode 100644 providers/erdma/CMakeLists.txt

diff --git a/CMakeLists.txt b/CMakeLists.txt
index e9d1f463..4197ac19 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -668,6 +668,7 @@ add_subdirectory(providers/bnxt_re)
 add_subdirectory(providers/cxgb4) # NO SPARSE
 add_subdirectory(providers/efa)
 add_subdirectory(providers/efa/man)
+add_subdirectory(providers/erdma)
 add_subdirectory(providers/hns)
 add_subdirectory(providers/irdma)
 add_subdirectory(providers/mlx4)
diff --git a/MAINTAINERS b/MAINTAINERS
index 9fec1240..bbeddabb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -61,6 +61,11 @@ M:	Gal Pressman <galpress@amazon.com>
 S:	Supported
 F:	providers/efa/
 
+ERDMA USERSPACE PROVIDER (for erdma.ko)
+M:	Cheng Xu <chengyou@linux.alibaba.com>
+S:	Supported
+F:	providers/erdma/
+
 HF1 USERSPACE PROVIDER (for hf1.ko)
 M:	Mike Marciniszyn <mike.marciniszyn@intel.com>
 M:	Dennis Dalessandro <dennis.dalessandro@intel.com>
diff --git a/README.md b/README.md
index 18c3b014..ebb941e2 100644
--- a/README.md
+++ b/README.md
@@ -15,6 +15,7 @@ under the providers/ directory. Support for the following Kernel RDMA drivers
 is included:
 
  - efa.ko
+ - erdma.ko
  - iw_cxgb4.ko
  - hfi1.ko
  - hns-roce.ko
diff --git a/kernel-headers/CMakeLists.txt b/kernel-headers/CMakeLists.txt
index 580582c1..997cc96b 100644
--- a/kernel-headers/CMakeLists.txt
+++ b/kernel-headers/CMakeLists.txt
@@ -23,6 +23,7 @@ publish_internal_headers(rdma
   rdma/rdma_user_rxe.h
   rdma/rvt-abi.h
   rdma/siw-abi.h
+  rdma/erdma-abi.h
   rdma/vmw_pvrdma-abi.h
   )
 
@@ -75,6 +76,7 @@ rdma_kernel_provider_abi(
   rdma/qedr-abi.h
   rdma/rdma_user_rxe.h
   rdma/siw-abi.h
+  rdma/erdma-abi.h
   rdma/vmw_pvrdma-abi.h
   )
 
diff --git a/providers/erdma/CMakeLists.txt b/providers/erdma/CMakeLists.txt
new file mode 100644
index 00000000..65e63b33
--- /dev/null
+++ b/providers/erdma/CMakeLists.txt
@@ -0,0 +1,5 @@
+rdma_provider(erdma
+  erdma.c
+  erdma_db.c
+  erdma_verbs.c
+)
\ No newline at end of file
diff --git a/redhat/rdma-core.spec b/redhat/rdma-core.spec
index 754ac3d3..950e299c 100644
--- a/redhat/rdma-core.spec
+++ b/redhat/rdma-core.spec
@@ -148,6 +148,8 @@ Provides: libcxgb4 = %{version}-%{release}
 Obsoletes: libcxgb4 < %{version}-%{release}
 Provides: libefa = %{version}-%{release}
 Obsoletes: libefa < %{version}-%{release}
+Provides: liberdma = %{version}-%{release}
+Obsoletes: liberdma < %{version}-%{release}
 Provides: libhfi1 = %{version}-%{release}
 Obsoletes: libhfi1 < %{version}-%{release}
 Provides: libipathverbs = %{version}-%{release}
-- 
2.27.0

