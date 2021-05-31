Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FD4395A82
	for <lists+linux-rdma@lfdr.de>; Mon, 31 May 2021 14:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhEaMaV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 May 2021 08:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhEaMaU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 May 2021 08:30:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38A5C061574
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 05:28:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b9so16355844ejc.13
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 05:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5RtmV3FJY6haXE/zIFR6Vcs4co0hG7Jc3n6yh7iZOg=;
        b=Sch8t0UqJhwdSbeqXn9P+9aaWfCEc/juL27wV/yuG6DiMHLBt7twYTp/NVsnpaSbQx
         3Qs8GmyD65r6vkza+P/SO8VhADBDsjt7Afie6LKrGB+k3tlacYMWLFWB1T8iZdpR6RCR
         FHHLHYUQ3xBZHzaZEC8eP5yyPqwBc/fWdifN9zwr861hV9Fx9Wjv5TrOpJZu1LjXZdGB
         F/c7vtV2NN2e39SXF/+Hr8o686Rh3Jh+n9x+wiHCe0tRPonRrVssTviMvrY8OWrgRuTA
         8XTnhl2uaaqihr2fCOdT6/FB6YFPw4ntKCVprSg7XKUOD//75Z1Lpmj4rskrM8JotKJk
         m2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5RtmV3FJY6haXE/zIFR6Vcs4co0hG7Jc3n6yh7iZOg=;
        b=jUszjuHxiLBJz/bApHGC0N3HHSgwW9m/WYldTdTRpZL/E0EmYBOOTRyz9PvliC52Ow
         AkiyOLufayZhGWmf0tzv7Ru1LTFttYIuzG7+PZ5RIZDbMau8/zi+DOrbv8j4+WKFkKvN
         JwxEvAs7JuUcEKyGooV44F4MEnytpq05Zl/CQyitYfRKDPDPbMIWKvwd+OrHPQKXC83l
         oS1IV/DvKtwu37cfRsLXuTugo94S5rSuRhexXjH3JWdctDV1ClXhBkHeXA2F615bx/34
         C42nL6Wzap6dNTAfB7ZLggDIvkpMvj5Ie0z6TIOdTSwrEhKzDnYr0+UjMjRNK1E/3p2p
         WaZg==
X-Gm-Message-State: AOAM533IkWFjOzbdYRBI+eXX6RlJzzhcpAKXIqN01SdIeU9I/1By0T0R
        gkanHkLJFrcm1CT8RQkrIRIFJTsWBKk3Mw==
X-Google-Smtp-Source: ABdhPJzD8mT/gwtcb+nCoheVbuZ3xTkfOKQpQLW7QzCx66JIqoYIMqQ0akdfUQp/DMVBohpH6GYhtg==
X-Received: by 2002:a17:906:c14c:: with SMTP id dp12mr22439195ejc.312.1622464116350;
        Mon, 31 May 2021 05:28:36 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:496e:7f00:ac75:214:6009:b606])
        by smtp.gmail.com with ESMTPSA id u4sm5896347eje.81.2021.05.31.05.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 05:28:36 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, gi-oh.kim@ionos.com,
        jinpu.wang@ionos.com
Subject: [PATCH] RDMA/rtrs: Avoid Wtautological-constant-out-of-range-compare
Date:   Mon, 31 May 2021 14:28:35 +0200
Message-Id: <20210531122835.58329-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

drivers/infiniband/ulp/rtrs/rtrs-clt.c:1786:19: warning: result of comparison of
constant 'MAX_SESS_QUEUE_DEPTH' (65536) with expression of type 'u16'
(aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]

To fix it, limit MAX_SESS_QUEUE_DEPTH to u16 max, which is 65535, and
drop the check in rtrs-clt, as it's the type u16 max.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 5 -----
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 8e05a71d8da1..f1fd7ae9ac53 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1775,11 +1775,6 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 	if (con->c.cid == 0) {
 		queue_depth = le16_to_cpu(msg->queue_depth);
 
-		if (queue_depth > MAX_SESS_QUEUE_DEPTH) {
-			rtrs_err(clt, "Invalid RTRS message: queue=%d\n",
-				  queue_depth);
-			return -ECONNRESET;
-		}
 		if (sess->queue_depth > 0 && queue_depth != sess->queue_depth) {
 			rtrs_err(clt, "Error: queue depth changed\n");
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 1705197b8c22..bd06a79fd516 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -53,9 +53,9 @@ enum {
 	 * But mempool_create, create_qp and ib_post_send fail with
 	 * "cannot allocate memory" error if sess_queue_depth is too big.
 	 * Therefore the pratical max value of sess_queue_depth is
-	 * somewhere between 1 and 65536 and it depends on the system.
+	 * somewhere between 1 and 65534 and it depends on the system.
 	 */
-	MAX_SESS_QUEUE_DEPTH = 65536,
+	MAX_SESS_QUEUE_DEPTH = 65535,
 	MIN_CHUNK_SIZE = 8192,
 
 	RTRS_HB_INTERVAL_MS = 5000,
-- 
2.25.1

