Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A978C3FEE61
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 15:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344942AbhIBNJY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 09:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344991AbhIBNJT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 09:09:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A741C061575
        for <linux-rdma@vger.kernel.org>; Thu,  2 Sep 2021 06:08:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m17so1144984plc.6
        for <linux-rdma@vger.kernel.org>; Thu, 02 Sep 2021 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L+G9kPhwsuho0YbQ3uM8CI129eTwrDx36Qp4gKZ7PCA=;
        b=XEzu6SxGtCjCDZ5ZILrNAjU5WcoIoZgBfHSLRPy7EoHcdr0ee+eGu5jLuqpbKtZMiq
         hd+qdiyXzgT4SDSEZtQUh0pSH/pOwcbsQWNMfYXjd/z2p9Neb2GQ17PmO13ApLxqd7JB
         u+8dsnbasdGBBXubbiU7CpPrOWwbTUAOWhvytAshDGMnsi8yYWU136hG03559H+D15C4
         FmbA1FqBB8FZCNrnWjCSWme8rSnMjaOh7Dp8Mu2OlS5+TAPLQySWvUOHBpRMJXdKxbUN
         szaVr9hfpYqhzDy5pHOh3ZORkUFtPPzOYxx0H1Z86AY1e1TVFhUuTw9U8GgaSqA8L/6J
         GOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+G9kPhwsuho0YbQ3uM8CI129eTwrDx36Qp4gKZ7PCA=;
        b=gqT1iXY5kdHE5Ti40mQ7rbzKKhihCM6BqWT3rOvTsMwKOvdjlftNHYryFnZ0296Sol
         H32OZr2XJJp8oBMpIECUKeeMyk1Qojdq/TvCrnyuNB01d6Zzm8TiTHi0tWasmm1JBVhM
         VDgkrfDatr/l6kXFsMobFTnxr4wYTdubAaqpAWk7YqpwlpCa1nMWE6Dzip6KmTGLTZDw
         QhGJ/7/4+dB/gkkhGyGV0SjNsZAJzrOVpPBt05lSYdyT3JUsLxMkma0OLEID3NyvUk/c
         YBtmscQFpE2SLRHg0EaqI3ygu7n//j2VHr0oAICZEEXa7CwO2yfTSVEq0ILDMbBR3zQQ
         tYUA==
X-Gm-Message-State: AOAM530i/8w9cXUgxBzatS9arB5ykreT71VOF0kx1ebAUgZYtflC/IKi
        LZb6GTMnQNNW/oshSqg49GyXrQ==
X-Google-Smtp-Source: ABdhPJyCxnuTLqOl7CCROnnXqyJ/zDL9uG3QdE9kp2zXMQh6j8vqadez6ThslEN21V0vilvkCkk6VQ==
X-Received: by 2002:a17:90a:8005:: with SMTP id b5mr3875331pjn.190.1630588098890;
        Thu, 02 Sep 2021 06:08:18 -0700 (PDT)
Received: from C02FR1DUMD6V.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id d6sm2307415pfa.135.2021.09.02.06.08.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 06:08:18 -0700 (PDT)
From:   Junji Wei <weijunji@bytedance.com>
To:     dledford@redhat.com, jgg@ziepe.ca, mst@redhat.com,
        jasowang@redhat.com, yuval.shaia.ml@gmail.com,
        marcel.apfelbaum@gmail.com, cohuck@redhat.com, hare@suse.de
Cc:     xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        weijunji@bytedance.com, linux-rdma@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Subject: [RFC 4/5] virtio-net: Move some virtio-net-pci decl to include/hw/virtio
Date:   Thu,  2 Sep 2021 21:06:24 +0800
Message-Id: <20210902130625.25277-5-weijunji@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210902130625.25277-1-weijunji@bytedance.com>
References: <20210902130625.25277-1-weijunji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yuval Shaia <yuval.shaia.ml@gmail.com>

This patch is from Yuval Shaia's [RFC 1/3]

Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
---
 hw/virtio/virtio-net-pci.c         | 18 ++----------------
 include/hw/virtio/virtio-net-pci.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 16 deletions(-)
 create mode 100644 include/hw/virtio/virtio-net-pci.h

diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index 292d13d278..6cea7e0441 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -18,26 +18,12 @@
 #include "qemu/osdep.h"
 
 #include "hw/qdev-properties.h"
-#include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio-net-pci.h"
 #include "virtio-pci.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qom/object.h"
 
-typedef struct VirtIONetPCI VirtIONetPCI;
-
-/*
- * virtio-net-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_NET_PCI "virtio-net-pci-base"
-DECLARE_INSTANCE_CHECKER(VirtIONetPCI, VIRTIO_NET_PCI,
-                         TYPE_VIRTIO_NET_PCI)
-
-struct VirtIONetPCI {
-    VirtIOPCIProxy parent_obj;
-    VirtIONet vdev;
-};
-
 static Property virtio_net_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
@@ -84,7 +70,7 @@ static void virtio_net_pci_instance_init(Object *obj)
 
 static const VirtioPCIDeviceTypeInfo virtio_net_pci_info = {
     .base_name             = TYPE_VIRTIO_NET_PCI,
-    .generic_name          = "virtio-net-pci",
+    .generic_name          = TYPE_VIRTIO_NET_PCI_GENERIC,
     .transitional_name     = "virtio-net-pci-transitional",
     .non_transitional_name = "virtio-net-pci-non-transitional",
     .instance_size = sizeof(VirtIONetPCI),
diff --git a/include/hw/virtio/virtio-net-pci.h b/include/hw/virtio/virtio-net-pci.h
new file mode 100644
index 0000000000..c1915cd54f
--- /dev/null
+++ b/include/hw/virtio/virtio-net-pci.h
@@ -0,0 +1,35 @@
+/*
+ * PCI Virtio Network Device
+ *
+ * Copyright IBM, Corp. 2007
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_VIRTIO_NET_PCI_H
+#define QEMU_VIRTIO_NET_PCI_H
+
+#include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio-pci.h"
+
+typedef struct VirtIONetPCI VirtIONetPCI;
+
+/*
+ * virtio-net-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_NET_PCI_GENERIC "virtio-net-pci"
+#define TYPE_VIRTIO_NET_PCI "virtio-net-pci-base"
+#define VIRTIO_NET_PCI(obj) \
+        OBJECT_CHECK(VirtIONetPCI, (obj), TYPE_VIRTIO_NET_PCI)
+
+struct VirtIONetPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIONet vdev;
+};
+
+#endif
-- 
2.11.0

