Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC1FE56C5
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2019 00:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfJYW6l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Oct 2019 18:58:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44382 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfJYW6l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Oct 2019 18:58:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so2571882pfn.11
        for <linux-rdma@vger.kernel.org>; Fri, 25 Oct 2019 15:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xiZm8Grr+XQGxlXA+rdrPe0AsMaw87H9ybwMaRghF2A=;
        b=V04LPsyabgfCUYkYD3zDTGIJ7GvydLkrQHugLDy7OavYDlXwAVLZ8sW29b0Xcda352
         Hy8jyeeIVkUxsaBb67Af8YJH9g0N0PnSijqY4KXtw7JiAa4V429TWuopohA4YgKC+MbX
         kU5/LIBkowqydgSpIqSvN5loHAjJG6ReO+lwkFekdtH8PpIDKSn6IfQhiLMoIo4ZhvoE
         9MakD+6k1Bzp7P1RrKBcCcnP3BmFhasf2Qc24yf69GyfCNKZBoHXNiKCxFv3JjqqnR/m
         KpfxfLbmQpI56V6iaX0SqSZktRLyB8OGV+pKQLZI1r07eJ8oFIWEL6gU+ou1XUnR2adG
         2ovA==
X-Gm-Message-State: APjAAAVoYkbZrYcerT2Dwgm6jVMk+aCzxPrFyLMsolMm6tYr4FGIgB0Z
        0JhTL6co1VFq9m34J60LBjmUOd1S
X-Google-Smtp-Source: APXvYqz3Cu64n1dFpqt8SRjoYReWjqvGauv5d7jDrUQ4FyATstzRNA8iLffkSqCvdJOuxOCZNBKA8w==
X-Received: by 2002:a17:90a:8002:: with SMTP id b2mr56437pjn.39.1572044320655;
        Fri, 25 Oct 2019 15:58:40 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id o123sm3243983pfg.161.2019.10.25.15.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 15:58:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/4] rdma_rxe: Increase DMA max_segment_size parameter
Date:   Fri, 25 Oct 2019 15:58:28 -0700
Message-Id: <20191025225830.257535-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191025225830.257535-1-bvanassche@acm.org>
References: <20191025225830.257535-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Increase the DMA max_segment_size parameter from 64 KB to 2 GB.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 3 +++
 drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index fa47bdcc7f54..9dd4bd7aea92 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1175,6 +1175,9 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
 			    rxe->ndev->dev_addr);
 	dev->dev.dma_ops = &dma_virt_ops;
+	dev->dev.dma_parms = &rxe->dma_parms;
+	rxe->dma_parms = (struct device_dma_parameters)
+		{ .max_segment_size = SZ_2G };
 	dma_coerce_mask_and_coherent(&dev->dev,
 				     dma_get_required_mask(&dev->dev));
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 5c4b2239129c..95834206c80c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -384,6 +384,7 @@ struct rxe_port {
 struct rxe_dev {
 	struct ib_device	ib_dev;
 	struct ib_device_attr	attr;
+	struct device_dma_parameters dma_parms;
 	int			max_ucontext;
 	int			max_inline_data;
 	struct mutex	usdev_lock;
-- 
2.24.0.rc0.303.g954a862665-goog

