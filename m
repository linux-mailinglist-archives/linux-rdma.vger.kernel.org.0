Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7DD382814
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhEQJUy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbhEQJUl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:41 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA37C0613ED
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t15so5965726edr.11
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5hfBn9GhMfx7I0EOUEgaTpDRmXZT14MLT0af7KVBCEc=;
        b=SYuwFK5WT90Kv2mwVFuJ9Y0zU3I9R/tEqgH2j2Ns1D6B45UxC8VB4PZ3TF7g9+pJtp
         llqcQ/oA/k3LYSQoQ/GV+UefhrgRY/OwZiOyXXWO+Hb50LszeDDAfGVTJ3bC1JvkmFIu
         aiOZJKrnOwXYeqH0VKgFHX8Rr6tee4mBFE3iuY/PEWVSztD8nkScA0X7truiNmqtmL6/
         E/B9AFuPhGafRX6X+gtx7BoYcB1sXnCDqBSD3rusWu0fJFF0oyvLl+1okVL/pHEEfujN
         gto+0iIAJxdpHs5kDUDsc6TDqBQL1wqoSfSxVsIl/b3/76ezZ8gr9KgLe3liaBO508e5
         3s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hfBn9GhMfx7I0EOUEgaTpDRmXZT14MLT0af7KVBCEc=;
        b=L/EfGZhvD87h8GfqUa95kOwIahi0WpbC4/C++Vdbsmn9Uf3cmBwgVpMU+80Vh6Aw2s
         RFClT8U3jatquqkxGCW/qmznIj3a9ciVZnHgj7H39KEXygITWpnrnPjmcBIn5NuBiuXO
         6YDy6QB3lDfpseAkQpM+QSxnStcfdyj4Z3mevc7Ew/C56WqZGZZmrfQQRdWNOwAmRGyH
         wasWX5wgFHlFWRMW8dcf3Z9IXqKRlAC2WyX6JbMXlbCBiHK6c7iW067moNcdG6fUyT8v
         sbRjtouso3cNSALcTHf6ZZjVNbHqVP3IQxEmTLQ0ivKwRYoAqT4WgLgDWmAGHgfdUUEa
         GsfQ==
X-Gm-Message-State: AOAM530m/g34XTZ6ZriEuH/u4hBkBd0MXq7BYzdG2f8KmzWqaaOdlFtF
        FiEhCxS/IPRMXcJ9bXRDTRxt8G+qLlbSow==
X-Google-Smtp-Source: ABdhPJzxrjorSrzvJoIghQhxHN4pSvzLwh9cDSVzi2nwWmCn+Dl3N1sjx8/LcrLMW6OfJhRK9B5QvA==
X-Received: by 2002:a50:ff08:: with SMTP id a8mr38301725edu.46.1621243160077;
        Mon, 17 May 2021 02:19:20 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:19 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 06/19] RDMA/rtrs: Define MIN_CHUNK_SIZE
Date:   Mon, 17 May 2021 11:18:30 +0200
Message-Id: <20210517091844.260810-7-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Define MIN_CHUNK_SIZE to replace the hard-coding number.
We need 4k for metadata, so MIN_CHUNK_SIZE should be at least 8k.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 62924ad5362d..a092f7d7c7b3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -56,6 +56,7 @@ enum {
 	 * somewhere between 1 and 65536 and it depends on the system.
 	 */
 	MAX_SESS_QUEUE_DEPTH = 65536,
+	MIN_CHUNK_SIZE = 8192,
 
 	RTRS_HB_INTERVAL_MS = 5000,
 	RTRS_HB_MISSED_MAX = 5,
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 74a5dfe85813..02bc704667a8 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -2165,9 +2165,9 @@ static int check_module_params(void)
 		       sess_queue_depth, 1, MAX_SESS_QUEUE_DEPTH);
 		return -EINVAL;
 	}
-	if (max_chunk_size < 4096 || !is_power_of_2(max_chunk_size)) {
+	if (max_chunk_size < MIN_CHUNK_SIZE || !is_power_of_2(max_chunk_size)) {
 		pr_err("Invalid max_chunk_size value %d, has to be >= %d and should be power of two.\n",
-		       max_chunk_size, 4096);
+		       max_chunk_size, MIN_CHUNK_SIZE);
 		return -EINVAL;
 	}
 
-- 
2.25.1

