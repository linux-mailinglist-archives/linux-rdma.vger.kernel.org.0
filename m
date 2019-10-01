Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCC5C393E
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfJAPii (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 11:38:38 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46719 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfJAPii (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 11:38:38 -0400
Received: by mail-qk1-f193.google.com with SMTP id 201so11626715qkd.13
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iMTlO+AEgeDLsL8YAEtLh+P+HOtJZNPl0oq3/hQrOh8=;
        b=dEAHwIYgJ9V2/7IkEdYXM8at8DrKQqaErQMfF4CVDErlim9qX2xYBGr6qUyd6MMCzg
         kW3Zf+jlQaitXaaYc1+Kg7RGhq89tmtXhhuFWlH5efnlW8iVOeHroJwySekqgU7MZFDa
         9Cg1wqEYgei1DxpohcB+bB1cjgZHsmha/8/3sK1VPGJcKah4wdo09A5UvhPI2cudGweg
         2uwe5rFzmg4wDOA8infVKmX7y6JF7kXpYjS7hLzevfRxeF/vDbp0/EOjFSzwxrEJ/lBl
         qT/GtMXcWlQ3ehcApm55GVNFiX+IVq+ro+jlShpwGXQU9gfM1dDHpdMA4hZlk5129Cq3
         Gfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iMTlO+AEgeDLsL8YAEtLh+P+HOtJZNPl0oq3/hQrOh8=;
        b=UdHfNW8bB4odA1g3OLyXOI1lxkv4RJNGqH+WU/SgROHszvqUE3VRB0Rf3J3lXLFkid
         yNjvqrzpyz+0oaX3B3AWcRJhnThc56vC5pFPL3ASTuToOEkZHNrm16enMxbXexZlKaTH
         /7zTEOxJKkdslVebG9t2u5nSxDgpkfCfY3CtfFPkEgwZ5knMcyD1zwNF5Q4u3hAa9Mzi
         RMwhANJRUOxf6k4yNgaK8f0rmXqJaIvA9aycuukGFR80f0TvOH/AYcaT6aIdJYeSa2Xj
         DkmbqGka31JqSDBwZ80fzAtQ3dpZM/clmgHKXMiDYT1klAOBnC11Dardv2rl+Rrl8IPI
         tRdw==
X-Gm-Message-State: APjAAAWmKi45/e5TiVEIvoJGHHMyyWJAJS7tyNV7DSzuVTAQlywQZgNX
        7LXpz+/op27qlRFNV2uQKpwN0/PG6XI=
X-Google-Smtp-Source: APXvYqyOS2+JlI4Pk18PHLLI0E0a7U1k5yd5/f7rUJ4sB9CDFRN6MeCvtesUM7X4VdZUGCljCAOXDA==
X-Received: by 2002:a37:c204:: with SMTP id i4mr6541380qkm.282.1569944317138;
        Tue, 01 Oct 2019 08:38:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u132sm7901728qka.50.2019.10.01.08.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 08:38:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFKEU-0006Ep-3x; Tue, 01 Oct 2019 12:38:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 4/6] RDMA/mlx5: Order num_pending_prefetch properly with synchronize_srcu
Date:   Tue,  1 Oct 2019 12:38:19 -0300
Message-Id: <20191001153821.23621-5-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001153821.23621-1-jgg@ziepe.ca>
References: <20191001153821.23621-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

During destroy setting live = 0 and then synchronize_srcu() prevents
num_pending_prefetch from incrementing, and also, ensures that all work
holding that count is queued on the WQ. Testing before causes races of the
form:

    CPU0                                         CPU1
  dereg_mr()
                                          mlx5_ib_advise_mr_prefetch()
            				   srcu_read_lock()
                                            num_pending_prefetch_inc()
					      if (!live)
   live = 0
   atomic_read() == 0
     // skip flush_workqueue()
                                              atomic_inc()
 					      queue_work();
            				   srcu_read_unlock()
   WARN_ON(atomic_read())  // Fails

Swap the order so that the synchronize_srcu() prevents this.

Fixes: a6bc3875f176 ("IB/mlx5: Protect against prefetch of invalid MR")
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index e7f840f306e46a..0ee8fa01177fc9 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1609,13 +1609,14 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 		 */
 		mr->live = 0;
 
+		/* Wait for all running page-fault handlers to finish. */
+		synchronize_srcu(&dev->mr_srcu);
+
 		/* dequeue pending prefetch requests for the mr */
 		if (atomic_read(&mr->num_pending_prefetch))
 			flush_workqueue(system_unbound_wq);
 		WARN_ON(atomic_read(&mr->num_pending_prefetch));
 
-		/* Wait for all running page-fault handlers to finish. */
-		synchronize_srcu(&dev->mr_srcu);
 		/* Destroy all page mappings */
 		if (!umem_odp->is_implicit_odp)
 			mlx5_ib_invalidate_range(umem_odp,
-- 
2.23.0

