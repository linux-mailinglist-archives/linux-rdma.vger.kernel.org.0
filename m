Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFBA3E56C6
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2019 00:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfJYW6n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Oct 2019 18:58:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39636 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfJYW6m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Oct 2019 18:58:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17so2069121plp.6
        for <linux-rdma@vger.kernel.org>; Fri, 25 Oct 2019 15:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KK2MwTYJxaSyWA184yIdB0YJ/S2GhMiDQz5RLBVTHHE=;
        b=poJf5S0MRQ46kAdMJu+Bxs98MFEIgtrc2lbrg1ithK1vz6/vTM8wkA/AKeXxgymMPX
         NebrYE5WzOT7k6dL2GG4boR09QjV3qarXEvfXoSU1kHVN2qj8CJ5J9rBaRW876AXt4Yc
         1XHet3O2lluJ+wijEEpuZ6JN7WHNJHd/qTpnKyTlupmLhvmqYBGPAZO6KCqpY37aSPq0
         fpVe6sbfSOzgqyFPm7KCqWOM6bjDYmEbTswN+wewb5GHx8Tor2DcvJMbFfp4x7AjwU7r
         545ZvRBnpL6ZiHF3jV/c7FYpIsAAMwSua3vIKvUyy1nXGup9zTTJEccawhD87tkVJHfx
         l+uA==
X-Gm-Message-State: APjAAAUVYi6By5AOrYr2/hRZ22ltQJgDBupQs0PGoao4GcyPNI2m4bKu
        ljMumfzVmPohhBAhixxguYA=
X-Google-Smtp-Source: APXvYqw5Z4y8LfkUY3zohGpQmUTg3x7o60kx8aNLGNkRFtxveKUXIPBuqCqk4dS74nDlDPCviVbGIw==
X-Received: by 2002:a17:902:7786:: with SMTP id o6mr6567146pll.109.1572044322103;
        Fri, 25 Oct 2019 15:58:42 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id o123sm3243983pfg.161.2019.10.25.15.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 15:58:41 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH v2 3/4] siw: Increase DMA max_segment_size parameter
Date:   Fri, 25 Oct 2019 15:58:29 -0700
Message-Id: <20191025225830.257535-4-bvanassche@acm.org>
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
index b8fe43074ad6..48e45a852b51 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -382,6 +382,9 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 	base_dev->phys_port_cnt = 1;
 	base_dev->dev.parent = parent;
 	base_dev->dev.dma_ops = &dma_virt_ops;
+	base_dev->dev.dma_parms = &sdev->dma_parms;
+	sdev->dma_parms = (struct device_dma_parameters)
+		{ .max_segment_size = SZ_2G };
 	base_dev->num_comp_vectors = num_possible_cpus();
 
 	ib_set_device_ops(base_dev, &siw_device_ops);
-- 
2.24.0.rc0.303.g954a862665-goog

