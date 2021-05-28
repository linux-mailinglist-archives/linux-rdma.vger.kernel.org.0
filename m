Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB32F3941D3
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhE1LcX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbhE1LcM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911B9C061761
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id df21so4478219edb.3
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Waffu+p5UPYdv4TtYYnLf0EydpIp8rGvSwttG2VyGrM=;
        b=HMkGHQlA9r2T+aGhuE5i6cGPHu6tMf3C0MZQ5UkQk1EnuaAVysfCmCmU/s89p+BB6J
         KZdsGCUy/oSQ4LfE7sJKhX2u2D+1ltJclaIyamulqZYvJ4aJuuqwwOSf+12PhJBCoWx5
         7MZscz3gC0IsriefYnZ9LoN79FN5DRLxHHVWKPLIec0DkINMAPKVoNyFTWDhpe38OaRE
         hW2gh8tlPLUTJiyLNvbooOllOaTPrf3fC5uYk5pimWEWQDMjW4htN3eSXbFDkBQlYeAP
         m6cK8Zbx9MS6ZGOPzO8Odfo5o7f4jT8JUznnTt1/ZV+fsj1CRtlSZNv4GVDxVPkNEbBB
         YbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Waffu+p5UPYdv4TtYYnLf0EydpIp8rGvSwttG2VyGrM=;
        b=HXzwX8F8KRm2V09pGK0xR3QElOKX03Rd24CD6c3SfX+INcFIKzm7rPkkWa9FVsWmUp
         RESQk3YlkKzYmx3qj0B6s4jJvRtDR27Xjt7x/2eH8Bxf8sx7a0m8odVz8Q3ZVS4E037E
         I3egy2c7LfjbNOyKOcu+1H26jo+t8ocF/LPYRrjdj/bGD/1YFvDe5Kq6v9XUN3i3Ycad
         2uzzWqRV/TktlhVRe8wBLOk1+M16fgOJc+EFnl1cg58Vutslkw/dpV4GWNgcGNDRciST
         EXAki3l5DQ15p0UIpsNhX0THARP7MPuTHDOd3pbS6h7tkj9pmgqakuY2JXfrGK2gj1bO
         zCbg==
X-Gm-Message-State: AOAM531lsZbErTjM0QKm3Z6nP9t7IisWZy5nWJ63d97u776oCkAaBg/p
        YaFTioFEvASbgx0c1Gj6J01f+dLxRJSD6w==
X-Google-Smtp-Source: ABdhPJxe5jnpF2ArvJ+M4yvIaONX/UXCmI9JqRaXe1mw05bC3UYB8FLEiogLWzDsTQNemz32jpdWbQ==
X-Received: by 2002:aa7:c04e:: with SMTP id k14mr9117238edo.157.1622201436114;
        Fri, 28 May 2021 04:30:36 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:35 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 19/20] RDMA/rtrs-clt: Check if the queue_depth has changed during a reconnection
Date:   Fri, 28 May 2021 13:30:17 +0200
Message-Id: <20210528113018.52290-20-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

The queue_depth is a module parameter for rtrs_server. It is used on the
client side to determing the queue_depth of the request queue for the RNBD
virtual block device.

During a reconnection event for an already mapped device, in case the
rtrs_server module queue_depth has changed, fail the reconnect attempt.

Also stop further auto reconnection attempts. A manual reconnect via
sysfs has to be triggerred.

Fixes: 6a98d71daea18 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 88a1c93f244a..e4a23c40d4c7 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1780,7 +1780,19 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 				  queue_depth);
 			return -ECONNRESET;
 		}
-		if (!sess->rbufs || sess->queue_depth < queue_depth) {
+		if (sess->queue_depth > 0 && queue_depth != sess->queue_depth) {
+			rtrs_err(clt, "Error: queue depth changed\n");
+
+			/*
+			 * Stop any more reconnection attempts
+			 */
+			sess->reconnect_attempts = -1;
+			rtrs_err(clt,
+				"Disabling auto-reconnect. Trigger a manual reconnect after issue is resolved\n");
+			return -ECONNRESET;
+		}
+
+		if (!sess->rbufs) {
 			kfree(sess->rbufs);
 			sess->rbufs = kcalloc(queue_depth, sizeof(*sess->rbufs),
 					      GFP_KERNEL);
@@ -1794,7 +1806,7 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 		sess->chunk_size = sess->max_io_size + sess->max_hdr_size;
 
 		/*
-		 * Global queue depth and IO size is always a minimum.
+		 * Global IO size is always a minimum.
 		 * If while a reconnection server sends us a value a bit
 		 * higher - client does not care and uses cached minimum.
 		 *
@@ -1802,8 +1814,7 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 		 * connections in parallel, use lock.
 		 */
 		mutex_lock(&clt->paths_mutex);
-		clt->queue_depth = min_not_zero(sess->queue_depth,
-						clt->queue_depth);
+		clt->queue_depth = sess->queue_depth;
 		clt->max_io_size = min_not_zero(sess->max_io_size,
 						clt->max_io_size);
 		mutex_unlock(&clt->paths_mutex);
-- 
2.25.1

