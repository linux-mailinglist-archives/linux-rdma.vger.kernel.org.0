Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2DABDE1E5
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 04:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfJUCKo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 22:10:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44954 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUCKn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Oct 2019 22:10:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id e10so6754933pgd.11
        for <linux-rdma@vger.kernel.org>; Sun, 20 Oct 2019 19:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jbm+cxLRc7RAp9D4tOJOlQI8lunApAqNH2Ug36mxlE8=;
        b=Y3BraBUX5mD66eCYqcrUoWKkM5HonQ5wnpTdlZMDHTiK2IsiSgzLKGoHtjkILoyvE+
         +4JkawtZ+b9i27ZVaTTJC/j2st3Q2gpsQVjMWMQz2klXWKiTKHIncYhR6hA3IrbaZJl/
         7OfJ3WBFOaIilv58x9JutKhYdvPvwYLBrqwKPOGOOyGJYFlpPF8hBPxKxV/WFS7fqJan
         O+VixeeMn+jZBpEkqic3NFfhaaaIqVttsEpQV6AMY/QxepJNDHPjRAXcGOlTb6zl6CVL
         iNv17lCOOo7MI6TPrlALVaqGohS2RgAmWpBW8FShzH8yYlZ+BH5U9LTTkoEqI3PzYXSU
         aCqg==
X-Gm-Message-State: APjAAAWwD6O7lVhk7dv1Cgc/m1Yt9N2Hb5+GWHlkfpZ281Eg1ZIFtlcE
        HRuHnIfj9JPiEHJbwyvLWTc=
X-Google-Smtp-Source: APXvYqy+GoeylrtxnzQJC1ieL2Q7ozkN97Au/HuslVjBOeXU1155iceLzH29vx8zYxhNjZbA2ZiDJA==
X-Received: by 2002:aa7:9525:: with SMTP id c5mr19790283pfp.22.1571623843089;
        Sun, 20 Oct 2019 19:10:43 -0700 (PDT)
Received: from localhost.net ([2601:647:4000:ce:256c:d417:b24b:327f])
        by smtp.gmail.com with ESMTPSA id k23sm12559333pgi.49.2019.10.20.19.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 19:10:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Adit Ranadive <aditr@vmware.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 2/4] RDMA/core: Set DMA parameters correctly
Date:   Sun, 20 Oct 2019 19:10:28 -0700
Message-Id: <20191021021030.1037-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021021030.1037-1-bvanassche@acm.org>
References: <20191021021030.1037-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The effect of the dma_set_max_seg_size() call in setup_dma_device() is
as follows:
- If device->dev.dma_parms is NULL, that call has no effect at all.
- If device->dev.dma_parms is not NULL, since that pointer points at
  the DMA parameters of the parent device, modify the DMA limits of the
  parent device.

Both actions are wrong. Instead of changing the DMA parameters of the
parent device, use the DMA parameters of the parent device if these
parameters are available.

Compile-tested only.

Cc: Michael J. Ruhl <michael.j.ruhl@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Adit Ranadive <aditr@vmware.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Gal Pressman <galpress@amazon.com>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>
Fixes: d10bcf947a3e ("RDMA/umem: Combine contiguous PAGE_SIZE regions in SGEs")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/core/device.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 536310fb6510..b33d684a2a99 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1199,9 +1199,18 @@ static void setup_dma_device(struct ib_device *device)
 		WARN_ON_ONCE(!parent);
 		device->dma_device = parent;
 	}
-	/* Setup default max segment size for all IB devices */
-	dma_set_max_seg_size(device->dma_device, SZ_2G);
 
+	if (!device->dev.dma_parms) {
+		if (parent) {
+			/*
+			 * The caller did not provide DMA parameters. Use the
+			 * DMA parameters of the parent device.
+			 */
+			device->dev.dma_parms = parent->dma_parms;
+		} else {
+			WARN_ON_ONCE(true);
+		}
+	}
 }
 
 /*
-- 
2.23.0

