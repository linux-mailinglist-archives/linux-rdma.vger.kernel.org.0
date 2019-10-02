Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5938DC4621
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 05:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfJBDXt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 23:23:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44739 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJBDXs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 23:23:48 -0400
Received: by mail-io1-f68.google.com with SMTP id w12so25475090iol.11;
        Tue, 01 Oct 2019 20:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yI9RSLxWCR6Ot4uEKdHKvzkRAPkPIl0Uimc/YPRNYt0=;
        b=kOuTnaXiRVaCbKl7zkp2BrejBdpktLIEXYoza20PYozR3ol9msNdB9ngKkRFG41v43
         kUpaJrPa3/awfKFUN4v+Ab6ls2aYMfJrqGIxaKHtWIkFdxitEdLlI/AByokEfJ6BxK6a
         zDCp/7zDwbzgwDs4TNhxzrwNK3klAEfbU7Mc1kWRcjDTgYF9MQB+JMedMd0JxweRZmLg
         hdbuHvMO02JffpWoiaL/mz2bSHZjKtfTGWeazFgQSNf6+MzGzyz+Re6GldVayIMXRYXA
         qNIuMLs6/4ThvRwhTaXLX8PxaL1uyDxBuQETp9uGc5EAvRZdRRQ/dbsTkyUCsE4OZk3y
         3m+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yI9RSLxWCR6Ot4uEKdHKvzkRAPkPIl0Uimc/YPRNYt0=;
        b=VYZHbrXDDRFX7nwOjhVzid0P6CBWkncp+nlnrDydntixUWxzXQ7prd+QTnTWpofE3k
         JOgaPf2Zo/q/PykTrrCHwMuwoFH/kAZIpjIMVUByOgG+Gxn9uKpk5esE2Ko7yMS4O6Ty
         uQzl4CHrrcijU/6n4mqNFZKbdioQCK9rtxP0Ul6uUtrnnRVWsRJnaQuepq2jPcXLRtdN
         BROVqCDIRmTPzkZuhwBjb47jP4AzmS1GxbxdLHxw61KUddKs3xKi5KxT3Y7RIj90EBXJ
         jUP+sOlWzdzP1L7mDBxMdMG3FVe7SN97tEHdewItI49qUrWq0rLxDW3hnTq5ORFXcsvs
         quBA==
X-Gm-Message-State: APjAAAXbrSv70aautZhUe+60acquaVhPEtGtxIh77RFD4uJ0wWxng9ZJ
        xOLL1a18Z2PSLNioLACqlXIL9JIY31M=
X-Google-Smtp-Source: APXvYqzxoiq9WKVaVbSUa64LlFPZJpYM5lXa05/gzKQSCPYbgkMxeM8i7oUMYHZXKnEUuOye4KqELw==
X-Received: by 2002:a6b:8b08:: with SMTP id n8mr1384861iod.190.1569986627937;
        Tue, 01 Oct 2019 20:23:47 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id l21sm7548339iok.87.2019.10.01.20.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 20:23:47 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     jgg@ziepe.ca
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] IB/hfi1: prevent memory leak in sdma_init
Date:   Tue,  1 Oct 2019 22:23:33 -0500
Message-Id: <20191002032334.19965-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001144019.GA12597@ziepe.ca>
References: <20191001144019.GA12597@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In sdma_init if rhashtable_init fails the allocated memory for
tmp_sdma_rht should be released.

Fixes: 5a52a7acf7e2 ("IB/hfi1: NULL pointer dereference when freeing rhashtable")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
Changes in v2:
	-- added Fixes tag.
---
 drivers/infiniband/hw/hfi1/sdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 2395fd4233a7..2ed7bfd5feea 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1526,8 +1526,11 @@ int sdma_init(struct hfi1_devdata *dd, u8 port)
 	}
 
 	ret = rhashtable_init(tmp_sdma_rht, &sdma_rht_params);
-	if (ret < 0)
+	if (ret < 0) {
+		kfree(tmp_sdma_rht);
 		goto bail;
+	}
+
 	dd->sdma_rht = tmp_sdma_rht;
 
 	dd_dev_info(dd, "SDMA num_sdma: %u\n", dd->num_sdma);
-- 
2.17.1

