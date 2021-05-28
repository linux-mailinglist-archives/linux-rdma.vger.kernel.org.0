Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331FD3941C6
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhE1LcJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhE1LcE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D76C0613ED
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y7so4483277eda.2
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WpqYI7iC4VG2x5Qos9a4Y7Ie71t6WEBxgpfmSxlvJoc=;
        b=g5k7wvFp5tzt/0Zv4uovaVF9/G6mv8frfwZTHCEuhXI3LYYh9Pi3M36lhEwQOQGcfu
         wvuq8Kpc6d5XOXBcZ+nB9g5mjy3ixVuDWgPENTdPJXc+EnBiyPr7Wj/vBvUYgmSSblFf
         HaGhTB9JFyNfwVVSWET7WBx02J20Z2OQU4mqZwBPGMhAxMZ9MGEryD+pA9kt9WNFppLI
         JWzsa2adtUq6pt+gPJJ962F0Q22xeezN9DmfgnpsN+oRPGnVLfhkuMq6NsXC/0UG7XfW
         hOMGHp8OboYoZecSe2XhI23tG14g9Bol9i7Qfkf+bc3hTXhr36rBcQEhd3XZB3vIV04Z
         qmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WpqYI7iC4VG2x5Qos9a4Y7Ie71t6WEBxgpfmSxlvJoc=;
        b=erv80S1c0m4nxnHapatl/1NPi/nWlrdXlNzvzfeX5TZNg22QVz4sjJ5PjyVZmftroZ
         3Sel8Vu53Ft8nzOGODKfZXhXjL9kWcNxBOkuyue8ajW3gz74vswA33s+NPIDKx9xpN6p
         055e3ANJfBrgL6oeSdxVFYvonNPdXtLkfEQWtw1yxufZ7/gzCjZeYIr/hjtgpU1h15e3
         v7SL62233HDPpu33rzxRIbTZdEGrXUq0sXxPphtfOliPoGFn0xZFxRl3EfPujyQWLily
         3fpF6hZw7Jqg9ZU9GjXzu1EaZlG8J5cNcZ0N8OrNDSX8WupEEgrLNGb/fYqsTQ12+LCT
         nGyQ==
X-Gm-Message-State: AOAM530bdHtqA/SJSOUmWqZ13unPqef+MGGpbYStRZzsOr4u3PwPp28M
        YJw+pye6ySHj5xJx1tMFhiNOJ3Z75APBuw==
X-Google-Smtp-Source: ABdhPJyZglVOfml7OfF1YTzLu8mAqVzS2FOGFLetdUy8wbav04oIzVKx6x1Jc9DWMi8yU5jjxI7OZA==
X-Received: by 2002:aa7:d30f:: with SMTP id p15mr9328423edq.264.1622201424727;
        Fri, 28 May 2021 04:30:24 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:24 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 06/20] RDMA/rtrs: Define MIN_CHUNK_SIZE
Date:   Fri, 28 May 2021 13:30:04 +0200
Message-Id: <20210528113018.52290-7-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
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
index d957bbf1ddd3..1705197b8c22 100644
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
index aa0585c176c9..5cfc2e3f9596 100644
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

