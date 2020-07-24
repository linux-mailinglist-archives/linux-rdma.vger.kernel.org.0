Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED30222C436
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 13:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgGXLP3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 07:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgGXLP3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jul 2020 07:15:29 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01545C0619D3
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 04:15:29 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s189so5040260pgc.13
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ByTK/MSOWmoWUor1KYibnpKbiy1kgHfk5qHnLHNx6g0=;
        b=K45E34Qk+3CMK1GTniglWFyBfFxieyks5gTBMV/STUVLZtFGtzgskHfsbpByVPMjtD
         OmG87NNUlh9lu7nga/V9cxDhJFtjNVHkDCALLbmMRU9M7TFDCI2tOfq9gZuLxk2brKiz
         hchPX3gXuPK85KdXCIFOFjHVosp2SKm32+xXW6lGjYe/kDKsaOnFubVjCIS40bIJIZ0l
         AqKw0TMOq0QaKVvEeDog8zMxVBfFU2rls+1O1aWwOII+PQPf+ko/id8t6gftsduYR+OB
         1pPZ20KP+oWoTMpK8ltq4+VfaBtlvQChQ84Y9gnISQdHs0AK/CXOQmOx5CMfWWhOIvSy
         tE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ByTK/MSOWmoWUor1KYibnpKbiy1kgHfk5qHnLHNx6g0=;
        b=ab+w5nz8Oc73jsmIKc6UzbSZXEjWxS/7kPjoHcZFMVCz1rjalwKeerYlC6WZCzaICN
         SYqlv7RnypOX1u2zK6vl0glQ2V9N6gfX4NvcQfnqIhO3x/o43Yrqv6EPemMxibVKM3Wf
         oY7UBlGvIOd3LWMEHz+IGGY9hGzb+Osx8D99fgdoQzLGPgPKQGIxUXah5VYiq7k+qdfm
         zqIyQ9pUP1w0nc1gyNqcRdiJ7VcfS9jLv1gz2+gg+9KgaKi3tC8P6xt32LhTKyhTDf34
         5mGP428EM5d5wHoPn0xmignGZMntfCr5uvA68s/szlt2TLkErSos4tyaGNjJuXnsW6GG
         PRTg==
X-Gm-Message-State: AOAM531tNtLJ1KdZHmhCV1uwj0h1Ks85VfRtXFkg2lf35tnNjdZfg50E
        7qw+LR3yy6h8DitPaN0mG9ovhQ==
X-Google-Smtp-Source: ABdhPJxQJKNsX1mN2ufI/w/jKMI8D8XHGjqMcGsUgSNeNlY+Q3Cca4/YxQqoLmXrpuAIAloPeSpXWQ==
X-Received: by 2002:a62:cdc4:: with SMTP id o187mr8622431pfg.200.1595589327284;
        Fri, 24 Jul 2020 04:15:27 -0700 (PDT)
Received: from dragon-master.domain.name ([43.224.130.248])
        by smtp.gmail.com with ESMTPSA id y7sm5569643pgk.93.2020.07.24.04.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:15:26 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, bvanassche@acm.org
Cc:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH 3/3] RDMA/rtrs: remove WQ_MEM_RECLAIM for rtrs_wq
Date:   Fri, 24 Jul 2020 16:45:08 +0530
Message-Id: <20200724111508.15734-4-haris.iqbal@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724111508.15734-1-haris.iqbal@cloud.ionos.com>
References: <20200724111508.15734-1-haris.iqbal@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

We triggered warning from time to time when we run regression
test, eg:

rnbd_client L685: </dev/nullb0@bla> Device disconnected.
rnbd_client L1756: Unloading module
------------[ cut here ]-----------
workqueue: WQ_MEM_RECLAIM rtrs_client_wq:rtrs_clt_reconnect_work [rtrs_client] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]
WARNING: CPU: 2 PID: 18824 at kernel/workqueue.c:2517 check_flush_dependency+0xad/0x130

The root cause is workqueue core expect flushing should not be done
for a !WQ_MEM_RECLAIM wq from a WQ_MEM_RECLAIM workqueue.

In above case ib_addr workqueue without WQ_MEM_RECLAIM, but rtrs_wq
WQ_MEM_RECLAIM.

To avoid the warning, remove the WQ_MEM_RECLAIM flag.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 5b31d3b03737..776e89231c52 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2982,7 +2982,7 @@ static int __init rtrs_client_init(void)
 		pr_err("Failed to create rtrs-client dev class\n");
 		return PTR_ERR(rtrs_clt_dev_class);
 	}
-	rtrs_wq = alloc_workqueue("rtrs_client_wq", WQ_MEM_RECLAIM, 0);
+	rtrs_wq = alloc_workqueue("rtrs_client_wq", 0, 0);
 	if (!rtrs_wq) {
 		class_destroy(rtrs_clt_dev_class);
 		return -ENOMEM;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 8a55bc559466..454bb6c343bb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -2153,7 +2153,7 @@ static int __init rtrs_server_init(void)
 		err = PTR_ERR(rtrs_dev_class);
 		goto out_chunk_pool;
 	}
-	rtrs_wq = alloc_workqueue("rtrs_server_wq", WQ_MEM_RECLAIM, 0);
+	rtrs_wq = alloc_workqueue("rtrs_server_wq", 0, 0);
 	if (!rtrs_wq) {
 		err = -ENOMEM;
 		goto out_dev_class;
-- 
2.25.1

