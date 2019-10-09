Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C89D1428
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbfJIQgP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:36:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39359 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIQgO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:36:14 -0400
Received: by mail-qk1-f195.google.com with SMTP id 4so2788291qki.6
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+HKKyBh5Mxz2+SPSiNgHktnqZFyO/mMHEowsHIa+nU=;
        b=kMlL9KtsUQW7KLYh+03CVqsPG8LhvwvSL/Xr3oR0okKKGJcIQTnpCkMUWNw1ORKoor
         4oD5zBQAwTmBBP4GvgXSaUjf32yuLZW3YtytmeF7p7iOcLkmBNPhO/1im6RKu9SZoT0l
         chIQuxr7WpUUgGGJFiluAM9mGfGQoaITo/sOyu2xo+914LV85rwKOBWkG6CHevykLdDL
         LWpFd1i3erxJQCqQ9HCVQrCibugBk1nejfcTZy0Bul9pFnXJV2jz1VXPamHeghtX50HN
         ym0UeIRbQz92FME1wKKmoXkckA5r+9zG2moiaUd2Z9MoBULMCBVtgfC9fGR+f1rJFGyJ
         M0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+HKKyBh5Mxz2+SPSiNgHktnqZFyO/mMHEowsHIa+nU=;
        b=lfIKzxfu7rxtlgCRixIhHShl9GmQXhZ+n43fLCemJhALLwZItBCbotTizLi/3zzeSM
         8xXEAsnoUGZq+e0JO/EK+NP3qdChdqkc4SBMD5ia75OKZYbHa5uUlk+1iWgJlt4NaZCy
         RowAiJdKumvDI3sFpht3z7QWspx5bS1nrQQCjb3Xvz2DvbvXHS5gZDh7GgpVDFG6J+At
         RJ1nTgH5o3Xoc26If1UD5wL+NBuFpsNjec0v4oae8gQmnZOBUzCDUPwoKuHiWOmzo8A8
         csHbOOPmxMH+kvM5ph+2WdfIf3neex4CUw74znL5xLiCu1poRCUHlal/QYbPER9TDIkN
         6UrQ==
X-Gm-Message-State: APjAAAWl+F5Jk1446R13Zb4i5L9V52Aao3bkOhW6DlWWdbh8Qyvmw0FL
        m3UgkRm1dXebJH4oX6obgbMqXB59Xz4=
X-Google-Smtp-Source: APXvYqxS1Pv7hVkUKM0pjiu9ITnrcQvHBtmqtVf7WBFELjRez9n6ZGEsLXSBjab+3ieOl1xTVpqURw==
X-Received: by 2002:a37:f90e:: with SMTP id l14mr4714916qkj.40.1570638973718;
        Wed, 09 Oct 2019 09:36:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id h68sm1141769qkf.2.2019.10.09.09.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:36:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXN-0000rg-C2; Wed, 09 Oct 2019 13:10:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 15/15] RDMA/odp: Remove broken debugging call to invalidate_range
Date:   Wed,  9 Oct 2019 13:09:35 -0300
Message-Id: <20191009160934.3143-16-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009160934.3143-1-jgg@ziepe.ca>
References: <20191009160934.3143-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

invalidate_range() also obtains the umem_mutex which is being held at this
point, so if this path were was ever called it would deadlock. Thus
conclude the debugging never triggers and rework it into a simple WARN_ON
and leave things as they are.

While here add a note to explain how we could possibly get inconsistent
page pointers.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c | 38 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 163ff7ba92b7f1..d7d5fadf0899ad 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -508,7 +508,6 @@ static int ib_umem_odp_map_dma_single_page(
 {
 	struct ib_device *dev = umem_odp->umem.ibdev;
 	dma_addr_t dma_addr;
-	int remove_existing_mapping = 0;
 	int ret = 0;
 
 	/*
@@ -534,28 +533,29 @@ static int ib_umem_odp_map_dma_single_page(
 	} else if (umem_odp->page_list[page_index] == page) {
 		umem_odp->dma_list[page_index] |= access_mask;
 	} else {
-		pr_err("error: got different pages in IB device and from get_user_pages. IB device page: %p, gup page: %p\n",
-		       umem_odp->page_list[page_index], page);
-		/* Better remove the mapping now, to prevent any further
-		 * damage. */
-		remove_existing_mapping = 1;
+		/*
+		 * This is a race here where we could have done:
+		 *
+		 *         CPU0                             CPU1
+		 *   get_user_pages()
+		 *                                       invalidate()
+		 *                                       page_fault()
+		 *   mutex_lock(umem_mutex)
+		 *    page from GUP != page in ODP
+		 *
+		 * It should be prevented by the retry test above as reading
+		 * the seq number should be reliable under the
+		 * umem_mutex. Thus something is really not working right if
+		 * things get here.
+		 */
+		WARN(true,
+		     "Got different pages in IB device and from get_user_pages. IB device page: %p, gup page: %p\n",
+		     umem_odp->page_list[page_index], page);
+		ret = -EAGAIN;
 	}
 
 out:
 	put_user_page(page);
-
-	if (remove_existing_mapping) {
-		ib_umem_notifier_start_account(umem_odp);
-		dev->ops.invalidate_range(
-			umem_odp,
-			ib_umem_start(umem_odp) +
-				(page_index << umem_odp->page_shift),
-			ib_umem_start(umem_odp) +
-				((page_index + 1) << umem_odp->page_shift));
-		ib_umem_notifier_end_account(umem_odp);
-		ret = -EAGAIN;
-	}
-
 	return ret;
 }
 
-- 
2.23.0

