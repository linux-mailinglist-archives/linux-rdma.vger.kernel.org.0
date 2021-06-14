Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B173A5ECB
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jun 2021 11:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhFNJGp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Jun 2021 05:06:45 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:37755 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNJGo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Jun 2021 05:06:44 -0400
Received: by mail-ej1-f50.google.com with SMTP id ce15so15379842ejb.4
        for <linux-rdma@vger.kernel.org>; Mon, 14 Jun 2021 02:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rhYuxdAj+v+J7dVbCJyHI7fFT2uXU9rnwpNgP+b6Koo=;
        b=gvlkMUi1q0mnRPMIw2wcuKloU352yxtunIt1xMkbpSJEPJspuNxjNmLKO0tuKNQwY4
         upz+C63zSlYIiQv4Xs9AnM/54eJXM6HTGWpgp9X7goOs/pZSBD3RT2h7g/i/anOcj0he
         byw+MROK8ZqvtLBW8SdCvci8nf1pVz2j+/VwcPkNoAlagLoBTW5Q0ntmsRSNED0RXYt3
         +bsVF6J60l9lqiW3m/NMHym1Xml3LNWixU8XOe+dmX7yui3hmFRR7e/yskijknvibz76
         wfbNQ6+uABjj4ScXrlgc5RqX4uwHzmdV/c/RLzgipauzXRdOomycnc/qkMd/wK3xxmfN
         RElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rhYuxdAj+v+J7dVbCJyHI7fFT2uXU9rnwpNgP+b6Koo=;
        b=LpXI0V8QpagcfGyq4iltt+bJEflz5yrMuW6khtucELjXlsJoX9SwATJAW3xnasaQDI
         /N52N4cV3rh2JRp7pmiZvIoEqclru1EOC5GpqobavRN6KgCkHhsgtwEWs32Qgl9Sc+26
         TeU0A+WBy7gTTBhQs+/msHsmsoZdlNHA4qYRB+1WY+YVsYA3pmZolyA1IVnQMGY/S6Ef
         VzuU+LPiqUTQtLKe3KJeSXLFq9sqOzE4MEWNQzOJQCV6eN9fBoDw23hyk+4gdGUOvyze
         pSKUU4PaYEjsf42JM9+LYEFkX8rZvUvP6iGBvp2jvGJIgQeZQ8Cmxe0BDr/gTU3jzuM+
         g24g==
X-Gm-Message-State: AOAM531C9p1lFXDZIiyfPJs6dVYj5yI3VLRg1OjfXj4RYSIYqlGpAJgF
        MQcioEuqFQTWtQr5d++CclmRXEjLCqbhbA==
X-Google-Smtp-Source: ABdhPJwdeckwywDcCJQuTSfwx2srsH91N4gXKhcEn3wLAOptL6CWV8GemZertthx+TinWi2UJtHhHg==
X-Received: by 2002:a17:906:2459:: with SMTP id a25mr14009116ejb.306.1623661421288;
        Mon, 14 Jun 2021 02:03:41 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4960:8600:dc5e:964f:b034:cb7d])
        by smtp.gmail.com with ESMTPSA id qq26sm6764355ejb.6.2021.06.14.02.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 02:03:41 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCHv3 for-next 3/5] RDMA/rtrs: RDMA_RXE requires more number of WR
Date:   Mon, 14 Jun 2021 11:03:35 +0200
Message-Id: <20210614090337.29557-4-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614090337.29557-1-jinpu.wang@ionos.com>
References: <20210614090337.29557-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

When using rdma_rxe, post_one_recv() returns
ENOMEM error due to the full recv queue.
This patch increase the number of WR for receive queue
to support all devices.

Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 ++++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index cd53edddfe1f..acf0fde410c3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1579,10 +1579,11 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 	lockdep_assert_held(&con->con_mutex);
 	if (con->c.cid == 0) {
 		/*
-		 * One completion for each receive and two for each send
-		 * (send request + registration)
+		 * Two (request + registration) completion for send
+		 * Two for recv if always_invalidate is set on server
+		 * or one for recv.
 		 * + 2 for drain and heartbeat
-		 * in case qp gets into error state
+		 * in case qp gets into error state.
 		 */
 		max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
 		max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 04ec3080e9b5..bb73f7762a87 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1656,7 +1656,7 @@ static int create_con(struct rtrs_srv_sess *sess,
 		 * + 2 for drain and heartbeat
 		 */
 		max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
-		max_recv_wr = SERVICE_CON_QUEUE_DEPTH + 2;
+		max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
 		cq_size = max_send_wr + max_recv_wr;
 	} else {
 		/*
-- 
2.25.1

