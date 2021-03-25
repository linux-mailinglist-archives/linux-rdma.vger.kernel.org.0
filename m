Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E293495A8
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhCYPdy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhCYPde (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196C2C061761
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y6so2922542eds.1
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5eo2byq29vW3omdRQg+MQM+rAG8bTQHBHzK/1JKTnG0=;
        b=Xf6IkRLXWp+iZp8McmYmiuIv0f6N4AH+9jQLP5obxsm4wpp02ikgCgzems5lFZpw8D
         225n+zxDHYmcGoyg/aUJD4CTd/fMzF23ienWkLJ4ygNjOkoGkeUSmuTDp7ttL5oaFft6
         APdKY4baLHXWVGbE8cp4aVHi3/ecM5OxdLfDGbP2H+dlpQZZIfPrIxJ4zDUC98tAJYZ0
         1JFaAY+fMycEE6natYKMInP4eE7eGkXC/FGup5+GZJelQNBGUGvG6zOeHoYx/au0gawX
         r59v/gIKbYYbDkPehK5nVncLqp9QAR95P7tE22QMcuXhVTgNcHYrcF/5ZxzNuj1QrgNu
         fJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5eo2byq29vW3omdRQg+MQM+rAG8bTQHBHzK/1JKTnG0=;
        b=daxUYUtCKppf/UZHt1hUtlSgucOcXpXZkJv2aG/YsOQuVueuPGKyhlxR5o1fsuTW3i
         K6VHElBDpJz9cuw2a0eXI/GD8vohyf6RPNsCwiV335S5XV74xQ5pq8TdxUqdVZ7xWx9R
         nZ4xGR5rp5KIcvGcbnRqpN/tFGIobZg543muQi+MPTYUFlIt9zROrYaQjUUNxXOrOi+1
         aDk81qf6ltk2yeOHiMUvPcV3OBkh4si9cwaDYwR+UeUscxc8otfdYEm2WIyRiflK5mDY
         L3XxDNAkvOf7PvPUlWssYklNE29wLXbAkB87S1O//atX0SLCKYgRqEapDipCPRora6MR
         cizw==
X-Gm-Message-State: AOAM530wa0AWUh2fuYMx5eO4SlK0lzQNcnYnMeYIFOzRVjGEatn/ORPl
        W5LU9Z+P8x5OLBqhCwnFugbIP3sErdSL+uWZ
X-Google-Smtp-Source: ABdhPJzzyjsEcVhQKobxmBoeO5NSuWiOAMIEVsB1Oe2FYAC+dOYJJUe0YxG8yqtvGG+MhYFQDvRLvg==
X-Received: by 2002:a05:6402:3550:: with SMTP id f16mr9660537edd.134.1616686408638;
        Thu, 25 Mar 2021 08:33:28 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:28 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 19/22] RDMA/rtrs-clt: Cap max_io_size
Date:   Thu, 25 Mar 2021 16:33:05 +0100
Message-Id: <20210325153308.1214057-20-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Max io size is limited by both remote buffer size and
the max fr pages per mr.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index eb830c66fa44..7e72f0911cf2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2929,7 +2929,9 @@ int rtrs_clt_query(struct rtrs_clt *clt, struct rtrs_attrs *attr)
 		return -ECOMM;
 
 	attr->queue_depth      = clt->queue_depth;
-	attr->max_io_size      = clt->max_io_size;
+	/* Cap max_io_size to min of remote buffer size and the fr pages */
+	attr->max_io_size = min_t(int, clt->max_io_size,
+				  clt->max_segments * SZ_4K);
 
 	return 0;
 }
-- 
2.25.1

