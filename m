Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED111620C3
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 07:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgBRGUf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 01:20:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44327 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgBRGUf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 01:20:35 -0500
Received: by mail-pl1-f195.google.com with SMTP id d9so7649717plo.11
        for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2020 22:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J3QBOCojK0zDQJHJPiUbw9OBpMwSH2IqCjGpKl/d1M0=;
        b=QtHk+Bi38C0uD2ahbd5YJLoHSCDtidfDi4HXqwDPblA40KuJn+jZgAdlCiLwpDXvyu
         WablUmr25X/wGlI+JgejaAN5wjuFCGjQRMyzPU+fdEyN+0ZNPRlLwmuecODlN00ou0cr
         pXGBF1dYarvOi1XqvI0979i03g3hdPm+ylzZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J3QBOCojK0zDQJHJPiUbw9OBpMwSH2IqCjGpKl/d1M0=;
        b=q6hhJZmyuWNzMh6BwjfBCjb5HlaieE5WGok52AfKij6zB4wVCKxffi5zfDffmDW/gh
         DmVNJGWwQfr7KojoQOywSM25PQmADasQ4xOpSeQgbS4iAzqympR/m+ibY+ABg4gflyfO
         5McwLZpA1ralEysrnmHJsQu8CpdgG6o8+aux0wXQs2z9GCm6GRNwGgBlUxErrVXzZrLI
         l21Wr9jiiTaQGgYAV/bNDcF1SzLkMulpGa1uPsX/+tgSh8jJV+A29MhYQex2NOJri23O
         aC3t8FnIM3TNO/BatyMeUt/8vw9y25rix0l+lLEBgxGRFX9O+Kq0TgEUVGic27buFiWp
         ARiQ==
X-Gm-Message-State: APjAAAWslWekQcq9Wkyc1/1Gr/U6hVxhLNknQWDHSuqp9mpajLSK9XeB
        IST6cbf6AInLR5+vwEsCP321uA==
X-Google-Smtp-Source: APXvYqy9bu94CQwEzieBl2chDP3a8nENJzenuySnbFJUx/XPVEOj4lNGZkxhlbLo9/f5p8hZI2PNiw==
X-Received: by 2002:a17:90a:2e86:: with SMTP id r6mr799145pjd.104.1582006834054;
        Mon, 17 Feb 2020 22:20:34 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 72sm2606753pfw.7.2020.02.17.22.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 22:20:33 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 1/2] RDMA/core: Add helper function to retrieve driver gid context from gid attr
Date:   Mon, 17 Feb 2020 22:20:09 -0800
Message-Id: <1582006810-32174-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1582006810-32174-1-git-send-email-selvin.xavier@broadcom.com>
References: <1582006810-32174-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Adding a helper function to retrieve the driver gid context
from the gid attr.

Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/core/cache.c | 41 +++++++++++++++++++++++++++++++++++++++++
 include/rdma/ib_cache.h         |  1 +
 2 files changed, 42 insertions(+)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 17bfedd..1b73a71 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -973,6 +973,47 @@ int rdma_query_gid(struct ib_device *device, u8 port_num,
 EXPORT_SYMBOL(rdma_query_gid);
 
 /**
+ * rdma_read_gid_hw_context - Read the HW GID context from GID attribute
+ * @attr:		Potinter to the GID attribute
+ *
+ * rdma_read_gid_hw_context() reads the vendor drivers GID HW
+ * context corresponding to SGID attr. It takes reference to the GID
+ * attribute and this need to be released by the caller using
+ * rdma_put_gid_attr
+ *
+ * Returns HW context on success or NULL on error
+ *
+ */
+void *rdma_read_gid_hw_context(const struct ib_gid_attr *attr)
+{
+	struct ib_gid_table_entry *entry =
+		container_of(attr, struct ib_gid_table_entry, attr);
+	struct ib_device *device = entry->attr.device;
+	u8 port_num = entry->attr.port_num;
+	struct ib_gid_table *table;
+	unsigned long flags;
+	void *context = NULL;
+
+	if (!rdma_is_port_valid(device, port_num))
+		return NULL;
+
+	table = rdma_gid_table(device, port_num);
+	read_lock_irqsave(&table->rwlock, flags);
+
+	if (attr->index < 0 || attr->index >= table->sz ||
+	    !is_gid_entry_valid(table->data_vec[attr->index]))
+		goto done;
+
+	get_gid_entry(entry);
+	context = entry->context;
+
+done:
+	read_unlock_irqrestore(&table->rwlock, flags);
+	return context;
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

