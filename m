Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EDE37148D
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhECLtd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhECLt3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5D9C061343
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b25so7399152eju.5
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bi3i72VMOLp+OX8jpM1jiHQgGARH2szZ5CRD2tHJhoo=;
        b=FyzZ6HyeqkUjng52QX6IewdoPqnZqz2PHJPrwy7MoR4kfOplST7OlFBrvKi2OqqzB2
         wwVBB3o83mPS3zcJtMpKM0jr3rjJEGGMPU2vMOvjVd2lsE26wRghT6OgJnSQr1DGDqyx
         bfr4pYNDthIPGrt8WxGugdqqDjkw37tMTJ5L2bdGPNPZEFMu4HO7NfthTUX8i1eYgUc7
         HFSW/sXUfR/GBzmpD4Wodg7cf5xJ3TcTkQ2/kyl3xfY2ajdhbyyJ2w++epx5SutlBryF
         fC93SywBSqTI/sgs7Zles2btHIw8guqlwbyqGuzvtXWfFj8ayRkOm1z8d6XUP9iuqjox
         VvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bi3i72VMOLp+OX8jpM1jiHQgGARH2szZ5CRD2tHJhoo=;
        b=n39qnqyZ8MVltEEDPZulRjl+L3b+5fqf11y8qOnfpU0S/ZX3T6Bc7a9zg8XKdxuEMS
         cHKa6F2yLYjn5eKigF4kSwS1rK8kxz1Q6vXoEv36pkzxqpn7QZaF7hsg8oOl3IcOKseJ
         rJlBmlg6U6LQ8jJ8E9sc+JO0k5+VP2eLDVLEIl+XrObVy+PYLTzjDPhpsrO6OpE/z9nx
         0cSZQvARq/IxzqxxjsE5d3CjCT+27vt73jQYv21CVeRskW185rjBHbBjzmb4b4XCWTJd
         zhbABlTRwq6NaV8skfQo7WhKaiToevV2IHpSVeqG8b3oi73W5D6niPc8Ak8JRO5v75hq
         UkkA==
X-Gm-Message-State: AOAM530IQEm9wg4Vlo8PwUkDTnTt0VvpAnLYJH0ddlRYfUp67O4ePnKo
        1t33wQGjZo6vk7b+9xYkcNUMc4IHze/5jA==
X-Google-Smtp-Source: ABdhPJwubN5BEYVPCKLsqCdpeGXq8uBQg+zbxLzMBVJPEeyeAohcd2NZPdn2qfUkOKFsKG1Y+W0PJA==
X-Received: by 2002:a17:906:2ac5:: with SMTP id m5mr16416631eje.517.1620042514708;
        Mon, 03 May 2021 04:48:34 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:34 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 19/20] RDMA/rtrs-clt: Check if the queue_depth has changed during a reconnection
Date:   Mon,  3 May 2021 13:48:17 +0200
Message-Id: <20210503114818.288896-20-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
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
index c8a7807793bf..ec7055b8136b 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1764,7 +1764,20 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 	}
 	if (con->c.cid == 0) {
 		queue_depth = le16_to_cpu(msg->queue_depth);
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
@@ -1778,7 +1791,7 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 		sess->chunk_size = sess->max_io_size + sess->max_hdr_size;
 
 		/*
-		 * Global queue depth and IO size is always a minimum.
+		 * Global IO size is always a minimum.
 		 * If while a reconnection server sends us a value a bit
 		 * higher - client does not care and uses cached minimum.
 		 *
@@ -1786,8 +1799,7 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
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

