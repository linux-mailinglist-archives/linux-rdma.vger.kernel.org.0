Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D024DE1EC
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 04:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfJUCKq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 22:10:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42421 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfJUCKq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Oct 2019 22:10:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id f14so6752410pgi.9
        for <linux-rdma@vger.kernel.org>; Sun, 20 Oct 2019 19:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vTcerqeLx7y8275r+z3eE5hpmq6x0OzokQL0fWcQlL0=;
        b=SfmwlF0C5OztLH/3cgW3AnKAUC1+bN2g1ElFpEdv8ddVACx3XVXnNI2m8VY1mqqBne
         3d4/PKQJSky5gymJD4ySMowFwhzuBzXLiJsWFG0ZMqCjFJtW5wXz5a/kdmn7FNbba7T8
         R8M6c8pfLW1iSsO+HuGfK6iEStNSJC+rlmDrak8HckX3EqJVc/H5SqIiNhI+tc/n5mzB
         flVyEpdohg0JpJCylPbFJigUubVFrrxKKFhme8/8BOEpYeD2RXI1og3W6s3uq4CDLEdX
         GhLqohk70D1J4pB1u9Wz6zC4MOdIcF/nYPwviVoa1kqaTuqPCWY0bUJAisCuwfToL1yq
         oakw==
X-Gm-Message-State: APjAAAVYriG8qKnVDgvG57L5sXgaGB2YA9Gmj43H0LBPr+M4/VnIQvQb
        BgCFj5yRohgK44msFJ5Sm74=
X-Google-Smtp-Source: APXvYqyM3Yo5vGVQytmZfJCX47BxpA+wlf02Uy9KrRYOZgttQBWa4phzFKLFd7tRwcAfdH9w42SpCQ==
X-Received: by 2002:a17:90a:ba83:: with SMTP id t3mr25114993pjr.139.1571623845456;
        Sun, 20 Oct 2019 19:10:45 -0700 (PDT)
Received: from localhost.net ([2601:647:4000:ce:256c:d417:b24b:327f])
        by smtp.gmail.com with ESMTPSA id k23sm12559333pgi.49.2019.10.20.19.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 19:10:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH 4/4] siw: Increase DMA max_segment_size parameter
Date:   Sun, 20 Oct 2019 19:10:30 -0700
Message-Id: <20191021021030.1037-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021021030.1037-1-bvanassche@acm.org>
References: <20191021021030.1037-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Increase the DMA max_segment_size parameter from 64 KB to UINT_MAX.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/sw/siw/siw.h      | 1 +
 drivers/infiniband/sw/siw/siw_main.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index dba4535494ab..1ea3ed249e7b 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -70,6 +70,7 @@ struct siw_pd {
 
 struct siw_device {
 	struct ib_device base_dev;
+	struct device_dma_parameters dma_parms;
 	struct net_device *netdev;
 	struct siw_dev_cap attrs;
 
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index d1a1b7aa7d83..041496376047 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -402,6 +402,9 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 	base_dev->phys_port_cnt = 1;
 	base_dev->dev.parent = parent;
 	base_dev->dev.dma_ops = &dma_virt_ops;
+	base_dev->dev.dma_parms = &sdev->dma_parms;
+	sdev->dma_parms = (struct device_dma_parameters)
+		{ .max_segment_size = UINT_MAX };
 	base_dev->num_comp_vectors = num_possible_cpus();
 
 	ib_set_device_ops(base_dev, &siw_device_ops);
-- 
2.23.0

