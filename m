Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F68A38E012
	for <lists+linux-rdma@lfdr.de>; Mon, 24 May 2021 06:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhEXENw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 May 2021 00:13:52 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:40718 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhEXENv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 May 2021 00:13:51 -0400
Received: by mail-pl1-f174.google.com with SMTP id n8so8745527plf.7
        for <linux-rdma@vger.kernel.org>; Sun, 23 May 2021 21:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YsNdqphigPomo9Pv53rTPx+zCMlWhqzBAp2xeveZOTE=;
        b=tnVtlsDBzrBMcv5HD2EIhxKtaFVPbYf/ISRW+vkfygCDKNkvJxiwVbqtCoDjQ6djuD
         wYYo3Q2IeJY2VF2NNQFU90IZREG/C/d7GCMma5IjxwOMHYsbjN6rOuRb1G7TCtaXfhzW
         W+ostZhlYPn0CvltQL95aer4otwy8Ls/Xx+FshZ+4PPrbaHJ5O4MYoboJJZm7zzvIWFk
         WCyxq3y6xHAtVmeoDAplboDZGF8dTwOn1/FnxIynp9PD6TVZBku6MiOZiwQ4rJtxUmWu
         MT3kFowTsYfpr9YCJYR7QbbdUMbVtpBSsKTcYLA04UBj3nVXE98vLAbOEQIokbUHdOPc
         I7Cg==
X-Gm-Message-State: AOAM532jd9m8pgN5/KAAEplMtifyJo6qtoZPe3hlW2JBbH+H21C2mrf4
        plQ2ucTSv8n4RKePc97wNl4=
X-Google-Smtp-Source: ABdhPJzV/OKEr+9TdLZo8Eutq11MbMHjKe5r1vJg1i/3MBsCi0uXoUfjTlvsUjLkJua079yCm0IVqw==
X-Received: by 2002:a17:90a:e50b:: with SMTP id t11mr22967998pjy.181.1621829544314;
        Sun, 23 May 2021 21:12:24 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id q9sm13141979pjm.23.2021.05.23.21.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 21:12:23 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [PATCH v2 4/5] RDMA/srp: Fix a recently introduced memory leak
Date:   Sun, 23 May 2021 21:12:10 -0700
Message-Id: <20210524041211.9480-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524041211.9480-1-bvanassche@acm.org>
References: <20210524041211.9480-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Only allocate a memory registration list if it will be used and if it will
be freed.

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Cc: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Fixes: f273ad4f8d90 ("RDMA/srp: Remove support for FMR memory registration")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 0f66bf015db6..70107ab0179a 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -998,7 +998,6 @@ static int srp_alloc_req_data(struct srp_rdma_ch *ch)
 	struct srp_device *srp_dev = target->srp_host->srp_dev;
 	struct ib_device *ibdev = srp_dev->dev;
 	struct srp_request *req;
-	void *mr_list;
 	dma_addr_t dma_addr;
 	int i, ret = -ENOMEM;
 
@@ -1009,12 +1008,12 @@ static int srp_alloc_req_data(struct srp_rdma_ch *ch)
 
 	for (i = 0; i < target->req_ring_size; ++i) {
 		req = &ch->req_ring[i];
-		mr_list = kmalloc_array(target->mr_per_cmd, sizeof(void *),
-					GFP_KERNEL);
-		if (!mr_list)
-			goto out;
-		if (srp_dev->use_fast_reg)
-			req->fr_list = mr_list;
+		if (srp_dev->use_fast_reg) {
+			req->fr_list = kmalloc_array(target->mr_per_cmd,
+						sizeof(void *), GFP_KERNEL);
+			if (!req->fr_list)
+				goto out;
+		}
 		req->indirect_desc = kmalloc(target->indirect_size, GFP_KERNEL);
 		if (!req->indirect_desc)
 			goto out;
