Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8024BE56C8
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2019 00:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfJYW6p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Oct 2019 18:58:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36006 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfJYW6p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Oct 2019 18:58:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so1467578plp.3
        for <linux-rdma@vger.kernel.org>; Fri, 25 Oct 2019 15:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N5fX6/xTHdCr2cl+KM/9mkyr80CZCAS+fLmex58s/Tw=;
        b=dUlgKjCU4es1+qhfN+qlTLHaqfg4MepOernbKfn9qhOdhu57mOwKzvqp7xWwv68N2N
         srwvXzyN+8UqxowyLRFbjz2raEQcPyYVcGaP8oZWQjrGFA18g1ZA4JsOO86Mu5nEIPQE
         LV73eccKr1lfFQb5+Tro5nNDe+p6JqRhlMGcuQ+2CCgvcWsAPP1Q910s58E9WNPNRNUj
         XEL0V3CDFDEI6IXVyprfLXyukNQYsMZAkZ+qSs/LmBAo+AScRrLB9d/+CkJkYrffqT9t
         lvP5sdRAFk9z9k2/iAGQVHjCKUklW0Gv0ehOCZKJj4OPLRpmWA1e9pc7haFQ26WvlENS
         9xbw==
X-Gm-Message-State: APjAAAUzAEMx4kXK/S9UrUSUM2p1K3PFcs/Bvg/QEIXN3VPMdcdy4TKV
        Ffeuvq091bBRfSjhrMjOGMM=
X-Google-Smtp-Source: APXvYqwTXmk9JYFILFZ4MTkn1hBb6AE6dIkjWrNLfB6+glX4S/7zJ0mxJvS+I9sSlkIep4TGzPCXEg==
X-Received: by 2002:a17:902:a98c:: with SMTP id bh12mr6428508plb.289.1572044323566;
        Fri, 25 Oct 2019 15:58:43 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id o123sm3243983pfg.161.2019.10.25.15.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 15:58:42 -0700 (PDT)
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
Subject: [PATCH v2 4/4] RDMA/core: Set DMA parameters correctly
Date:   Fri, 25 Oct 2019 15:58:30 -0700
Message-Id: <20191025225830.257535-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191025225830.257535-1-bvanassche@acm.org>
References: <20191025225830.257535-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The dma_set_max_seg_size() call in setup_dma_device() does not have any
effect since device->dev.dma_parms is NULL. Fix this by initializing
device->dev.dma_parms first.

Cc: Michael J. Ruhl <michael.j.ruhl@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Adit Ranadive <aditr@vmware.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Gal Pressman <galpress@amazon.com>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>
Fixes: d10bcf947a3e ("RDMA/umem: Combine contiguous PAGE_SIZE regions in SGEs")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/core/device.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index eb35b663a742..a93c23867fb5 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1196,9 +1196,21 @@ static void setup_dma_device(struct ib_device *device)
 		WARN_ON_ONCE(!parent);
 		device->dma_device = parent;
 	}
-	/* Setup default max segment size for all IB devices */
-	dma_set_max_seg_size(device->dma_device, SZ_2G);
 
+	if (!device->dev.dma_parms) {
+		if (parent) {
+			/*
+			 * The caller did not provide DMA parameters, so
+			 * 'parent' probably represents a PCI device. The PCI
+			 * core sets the maximum segment size to 64
+			 * KB. Increase this parameter to 2 GB.
+			 */
+			device->dev.dma_parms = parent->dma_parms;
+			dma_set_max_seg_size(device->dma_device, SZ_2G);
+		} else {
+			WARN_ON_ONCE(true);
+		}
+	}
 }
 
 /*
-- 
2.24.0.rc0.303.g954a862665-goog

