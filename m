Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC7D616415A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 11:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgBSKUS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 05:20:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53200 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgBSKUS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 05:20:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so5864131wmc.2
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 02:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Eo9FKW9bQ1lU41F/g70le18La6cS9qAQw6iMttqDsA=;
        b=gHjWgmEOTLft+bpuyGz8jZW/05oVi/GDq2Hjy1WVMJcxKMxX5hcor+Eo4ar4znyNcW
         8Uob/4yW94eImbVTIsuEkRGxR8rIua/VEaDQQ+QKJgMexiSF3LGxCeVY1gUQX3Mqnq7H
         GNFmzMrsCphMMhd77ddHU8b+mNJLTTxsE7fCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Eo9FKW9bQ1lU41F/g70le18La6cS9qAQw6iMttqDsA=;
        b=NBaPfTUsY8rBNUou/dIsVnOPJzG/BDrA99V3ghTXkwT1dTv3PN39OZXIPVKZzmmdhJ
         Wh1aJj9jr6w6uC0er81x5KJWVH245vaTgUBxTi/VDJUnz36ww8BFt9IO6FPSYo5cskJs
         w0mPUtHgnyGd8e7HYtvC0eYTROR5kDtglMEoyAB/YyE63a6G9q+37MsvMgHlK9qP5iBB
         TY1h3+bCp86GNjNBpJOTGM6f1hFnlMaKPSfGbemN5iVi/GmQ6nFvfoZ3WR3MO4SA1dYt
         /SUXly5qM3yMKdctAuQELjMmEMJIImSjdMi7aYFZidzjTZhqHCv+7t/XFj/q6HRROgyY
         T4yw==
X-Gm-Message-State: APjAAAXp1AlbYKEOQG4+Jf2NdCEF08YfOp1jty3i9yqYgJMfmW21yg2h
        E+ZtNfAcXFBWKQKSz7mjh0oZtw==
X-Google-Smtp-Source: APXvYqxAdAjNJcc2d1n8fRbNLTufMFcHJzq/xVWoP8pCAkCgxTS9DXYw9himnAW5W7VEMeM2HwxJtA==
X-Received: by 2002:a05:600c:24d2:: with SMTP id 18mr9152687wmu.149.1582107616094;
        Wed, 19 Feb 2020 02:20:16 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k16sm2408260wru.0.2020.02.19.02.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 02:20:15 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v4 1/2] RDMA/core: Add helper function to retrieve driver gid context from gid attr
Date:   Wed, 19 Feb 2020 02:19:53 -0800
Message-Id: <1582107594-5180-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1582107594-5180-1-git-send-email-selvin.xavier@broadcom.com>
References: <1582107594-5180-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Adding a helper function to retrieve the driver gid context
from the gid attr.

Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/core/cache.c | 20 ++++++++++++++++++++
 include/rdma/ib_cache.h         |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 17bfedd..2ebf322 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -973,6 +973,26 @@ int rdma_query_gid(struct ib_device *device, u8 port_num,
 EXPORT_SYMBOL(rdma_query_gid);
 
 /**
+ * rdma_read_gid_hw_context - Read the HW GID context from GID attribute
+ * @attr:		Potinter to the GID attribute
+ *
+ * rdma_read_gid_hw_context() reads the vendor drivers GID HW
+ * context corresponding to SGID attr. Callers are required to already
+ * be holding the reference to existing GID entry.
+ *
+ * Returns HW GID context
+ *
+ */
+void *rdma_read_gid_hw_context(const struct ib_gid_attr *attr)
+{
+	struct ib_gid_table_entry *entry =
+		container_of(attr, struct ib_gid_table_entry, attr);
+
+	return entry->context;
+}
+EXPORT_SYMBOL(rdma_read_gid_hw_context);
+
+/**
  * rdma_find_gid - Returns SGID attributes if the matching GID is found.
  * @device: The device to query.
  * @gid: The GID value to search for.
diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
index 870b5e6..e06d133 100644
--- a/include/rdma/ib_cache.h
+++ b/include/rdma/ib_cache.h
@@ -39,6 +39,7 @@
 
 int rdma_query_gid(struct ib_device *device, u8 port_num, int index,
 		   union ib_gid *gid);
+void *rdma_read_gid_hw_context(const struct ib_gid_attr *attr);
 const struct ib_gid_attr *rdma_find_gid(struct ib_device *device,
 					const union ib_gid *gid,
 					enum ib_gid_type gid_type,
-- 
2.5.5

