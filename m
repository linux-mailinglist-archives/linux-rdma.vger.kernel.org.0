Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108EB382821
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhEQJVP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbhEQJUq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC45C0613ED
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id df21so6000750edb.3
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D6cm8jlD191WhvOo1VR7yF9b0tKk4gRLgxc8yuyhtJE=;
        b=B3KJ2fJCusVoOFcW9Iy+yw2aIoGOU2jXTLcO3z93eTprIgqzB8hVsiuvAay0PvEH83
         QfKYfXyLKixjgaXPXszaBsuI6Leh6fA+oiYhqNvdhhIEFDVYBXxXqoD6vL94uW5S/oUE
         a14BaAfnuIH9HWRWZyMZ0CgBR9kHdsblU/HT6xCy4txDxdkv0S3mLHNcIp5Abv0BNet3
         8ZNF/Ev+z2TVsGsPSS98+Y3kcLq+Y58NEl58d65I6uEHG+QCetVCvTjCh4mcdM7nAsjU
         M/Xz8nS3HBemykd9QDEC7ElJLrjMUWRbNYJTsZYx9iuKcVqVARoKlFk7DOJKlLpKLclv
         wBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D6cm8jlD191WhvOo1VR7yF9b0tKk4gRLgxc8yuyhtJE=;
        b=M0OVEnRh92onAZZ5QnMqFakh+wZKu0KxNJpXeI9W2/2G+41igB5w5EN9LqBaodFvcV
         pIx4wEoc3tOyXJ5OHf3H12iyou5VtoCVE21zF1k5H+sZOBl2lqS5JSLvH7ra4JXTB/F9
         KAGFwWJRERlimWid5RyfzyM36dydxrlhJIp80xV1WcAdQGBZa8aZotOGaSOBHAsQyvRN
         G10+Bv1kY8n5BznNGrrAKmVixerb6ncUaGJWfIgfT2UN0okS8AEVD9+EOrw+O6uO5MH3
         2/dPEDvshd/0Sv8QWA+WoP8W2KxFJAq1hRGy8x7MGEgCbsTLaCUm9MV85HRoaklkexQw
         sa3g==
X-Gm-Message-State: AOAM532SnBcYqmaqV2bDpF9fokmtxIlIkIWCC34lXZ+sIcuwSClXDnBT
        bbN6ezZ48Ri6eMdXWmzCxbE8rEsQeAhVoA==
X-Google-Smtp-Source: ABdhPJzd9c2S0rq2rnhYKvZD7J+N3B5zMFKoI7OvmEw0N9cfL9LKQLJMv6tgvUUbHhKP3b0GWEa76g==
X-Received: by 2002:a05:6402:3446:: with SMTP id l6mr4044167edc.305.1621243169301;
        Mon, 17 May 2021 02:19:29 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:29 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 18/19] RDMA/rtrs-clt: Check if the queue_depth has changed during a reconnection
Date:   Mon, 17 May 2021 11:18:42 +0200
Message-Id: <20210517091844.260810-19-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
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
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index a3d20a5c5112..1bfa3f86c430 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1770,7 +1770,20 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 				  queue_depth);
 			return -ECONNRESET;
 		}
-		if (!sess->rbufs || sess->queue_depth < queue_depth) {
+
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
@@ -1784,7 +1797,7 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 		sess->chunk_size = sess->max_io_size + sess->max_hdr_size;
 
 		/*
-		 * Global queue depth and IO size is always a minimum.
+		 * Global IO size is always a minimum.
 		 * If while a reconnection server sends us a value a bit
 		 * higher - client does not care and uses cached minimum.
 		 *
@@ -1792,8 +1805,7 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
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

