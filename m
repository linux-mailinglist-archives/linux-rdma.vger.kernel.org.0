Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50832A1E83
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Nov 2020 15:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgKAORl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Nov 2020 09:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgKAORk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 Nov 2020 09:17:40 -0500
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 01 Nov 2020 06:17:40 PST
Received: from mailg110.ethz.ch (mailg110.ethz.ch [IPv6:2001:67c:10ec:5605::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57940C0617A6
        for <linux-rdma@vger.kernel.org>; Sun,  1 Nov 2020 06:17:40 -0800 (PST)
Received: from mailm214.d.ethz.ch (2001:67c:10ec:5603::28) by mailg110.ethz.ch
 (2001:67c:10ec:5605::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Sun, 1 Nov 2020
 15:02:30 +0100
Received: from ktaranov-laptop (194.230.155.211) by mailm214.d.ethz.ch
 (2001:67c:10ec:5603::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 1 Nov 2020
 15:02:35 +0100
Date:   Sun, 1 Nov 2020 15:02:33 +0100
From:   Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
To:     <linux-rdma@vger.kernel.org>
CC:     <konstantin.taranov@inf.ethz.ch>
Subject: [PATCH] The patch fixes minor typos in debug messages and comments
 in rdma-core
Message-ID: <20201101150233.3b9ebb41@ktaranov-laptop>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.230.155.211]
X-ClientProxiedBy: mailm213.d.ethz.ch (2001:67c:10ec:5603::27) To
 mailm214.d.ethz.ch (2001:67c:10ec:5603::28)
X-TM-SNTS-SMTP: 4D315C5289D373E4DC944A3D9E411D3FEF2513F506C6E202A40D85DE1F2780192000:8
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The patch only makes grammar-related fixes. It fixes misspelled abbreviations for Remote Direct Memory Access and incorrect use of the article "a" with "RDMA".

The changes include:
 * Changed "a RDMA" to "an RDMA"
 * Changed "RMDA" to "RDMA".

Signed-off-by: Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
---
 Documentation/udev.md                   | 4 ++--
 buildlib/azure-pipelines.yml            | 2 +-
 debian/control                          | 2 +-
 libibverbs/driver.h                     | 2 +-
 libibverbs/man/ibv_query_gid_table.3.md | 2 +-
 librdmacm/examples/rping.c              | 2 +-
 librdmacm/man/rdma_init_qp_attr.3.md    | 4 ++--
 tests/base_rdmacm.py                    | 2 +-
 tests/rdmacm_utils.py                   | 4 ++--
 9 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/udev.md b/Documentation/udev.md
index cf94a4fb..1ebee250 100644
--- a/Documentation/udev.md
+++ b/Documentation/udev.md
@@ -26,7 +26,7 @@ This can happen in several spots along the bootup:
    This happens asynchronously in the boot process, systemd does not wait for
    udev to finish loading modules before it continues on.
 
-   This path makes it very likely the system will experience a RDMA 'hot plug'
+   This path makes it very likely the system will experience an RDMA 'hot plug'
    scenario.
 
  - From systemd's fixed module loader systemd-modules-load.service, e.g. from
@@ -41,7 +41,7 @@ This is triggered automatically by udev rules that match the master devices
 and load the protocol module with udev's module loader. This happens
 asynchronously to the rest of the systemd startup.
 
-Once a RDMA device is created by the kernel then udev will cause systemd to
+Once an RDMA device is created by the kernel then udev will cause systemd to
 schedule ULP module loading services (e.g. rdma-load-modules@.service) specific
 to the plugged hardware. If sysinit.target has not yet been passed then these
 loaders will defer sysinit.target until they complete, otherwise this is a hot
diff --git a/buildlib/azure-pipelines.yml b/buildlib/azure-pipelines.yml
index f2a86b46..6a948480 100644
--- a/buildlib/azure-pipelines.yml
+++ b/buildlib/azure-pipelines.yml
@@ -165,7 +165,7 @@ stages:
 
           - task: PublishPipelineArtifact@0
             inputs:
-              # Contains a rdma-core-XX.tar.gz file
+              # Contains an rdma-core-XX.tar.gz file
               artifactName: source_tar
               targetPath: artifacts
 
diff --git a/debian/control b/debian/control
index 0837cfc1..290b14d8 100644
--- a/debian/control
+++ b/debian/control
@@ -87,7 +87,7 @@ Description: User space provider drivers for libibverbs
  hardware access from userspace (kernel bypass), and libibverbs
  supports this when available.
  .
- A RDMA driver consists of a kernel portion and a user space portion.
+ An RDMA driver consists of a kernel portion and a user space portion.
  This package contains the user space verbs drivers:
  .
   - bnxt_re: Broadcom NetXtreme-E RoCE HCAs
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 451924d4..87d1a030 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -190,7 +190,7 @@ enum {
 	VSYSFS_READ_FW_VER = 1 << 2,
 };
 
-/* A rdma device detected in sysfs */
+/* An rdma device detected in sysfs */
 struct verbs_sysfs_dev {
 	struct list_node entry;
 	void *provider_data;
diff --git a/libibverbs/man/ibv_query_gid_table.3.md b/libibverbs/man/ibv_query_gid_table.3.md
index e10f51c6..63f17a49 100644
--- a/libibverbs/man/ibv_query_gid_table.3.md
+++ b/libibverbs/man/ibv_query_gid_table.3.md
@@ -37,7 +37,7 @@ to the size of *entries* array.
 *entries* array must be allocated such that it can contain all the valid
 GID table entries of the device. If there are more valid GID entries than
 the provided value of *max_entries* and *entries* array, the call will fail.
-For example, if a RDMA device *context* has a total of 10 valid
+For example, if an RDMA device *context* has a total of 10 valid
 GID entries, *entries* should be allocated for at least 10 entries, and
 *max_entries* should be set appropriately.
 
diff --git a/librdmacm/examples/rping.c b/librdmacm/examples/rping.c
index 882f878b..a270d7db 100644
--- a/librdmacm/examples/rping.c
+++ b/librdmacm/examples/rping.c
@@ -1119,7 +1119,7 @@ static int rping_connect_client(struct rping_cb *cb)
 		}
 	}
 
-	DEBUG_LOG("rmda_connect successful\n");
+	DEBUG_LOG("rdma_connect successful\n");
 	return 0;
 }
 
diff --git a/librdmacm/man/rdma_init_qp_attr.3.md b/librdmacm/man/rdma_init_qp_attr.3.md
index 99e812ab..dfd6f22a 100644
--- a/librdmacm/man/rdma_init_qp_attr.3.md
+++ b/librdmacm/man/rdma_init_qp_attr.3.md
@@ -10,7 +10,7 @@ title: RDMA_INIT_QP_ATTR
 
 # NAME
 
-rdma_init_qp_attr - Returns qp attributes of a rdma_cm_id.
+rdma_init_qp_attr - Returns qp attributes of an rdma_cm_id.
 
 # SYNOPSIS
 
@@ -23,7 +23,7 @@ int rdma_init_qp_attr(struct rdma_cm_id *id,
 ```
 # DESCRIPTION
 
-**rdma_init_qp_attr()** returns qp attributes of a rdma_cm_id.
+**rdma_init_qp_attr()** returns qp attributes of an rdma_cm_id.
 
 Information about qp attributes and qp attributes mask is returned through the *qp_attr* and *qp_attr_mask* parameters.
 
diff --git a/tests/base_rdmacm.py b/tests/base_rdmacm.py
index 67d00fbf..e5ecc7df 100755
--- a/tests/base_rdmacm.py
+++ b/tests/base_rdmacm.py
@@ -91,7 +91,7 @@ class CMResources(abc.ABC):
 
     def create_qp(self):
         """
-        Create a rdmacm QP. If self.with_ext_qp is set, then an external CQ and
+        Create an rdmacm QP. If self.with_ext_qp is set, then an external CQ and
         RC QP will be created and set in self.cq and self.qp
         respectively.
         """
diff --git a/tests/rdmacm_utils.py b/tests/rdmacm_utils.py
index 834762cb..2880fa2a 100755
--- a/tests/rdmacm_utils.py
+++ b/tests/rdmacm_utils.py
@@ -267,7 +267,7 @@ class CMAsyncConnection(CMConnection):
 
     def establish_connection(self):
         """
-        Establish RMDACM connection between two Async CMIDs.
+        Establish RDMACM connection between two Async CMIDs.
         """
         if self.cm_res.passive:
             self.cm_res.cmid.bind_addr(self.cm_res.ai)
@@ -378,7 +378,7 @@ class CMSyncConnection(CMConnection):
 
     def establish_connection(self):
         """
-        Establish RMDACM connection between two Sync CMIDs.
+        Establish RDMACM connection between two Sync CMIDs.
         """
         if self.cm_res.passive:
             self.cm_res.cmid.listen()
-- 
2.25.1

