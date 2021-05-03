Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39ED37147D
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhECLtT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbhECLtS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8889AC061763
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a4so7414109ejk.1
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpuDjvDwrAl+4Do92O+UgpuhmW8xe1GkSLXNGhMxOe8=;
        b=HGIhJHyZZ4ybWyaT/Zig9Z/WzTZY3w2cL0xRxyx7qIuViKBHmoR+ciCClprF2ondKj
         BsRwfJVMjlaZOC0JhDk94hTQKISQMZ4lSjMvhjaAYbrP5iCfnQywBHgNnPN52TCUV1Ic
         UASOtfpDBCWqS23yCKXYNHxiPvx46TsmMKklJYJLjFG5mFEqtqMhkl+f3ypI4AwAs3/7
         EautqMs0cW81zXALuK5tk6EDNlumHfwn0QEuEh/8c6JmJ5v2iLl226QEt4qjB+hbn0CP
         blzfm4Iy/zT29uC/fyUX2xNE4Sock/l5q3VlfeDieYnZFeDeKnAIA5RH5tKb6Nlb7un9
         7NOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpuDjvDwrAl+4Do92O+UgpuhmW8xe1GkSLXNGhMxOe8=;
        b=W1rl6A5VbRqUP7DJYCeZS9TdCDVjalOE3Mf0YH+BsNmX/A7LhpKT/VLCwCZWLzQL92
         7qS3BdbXGb3h04ABGzVXfLh/T4C/6fcNKNakx0h1FPZRw72IiPbWBqj0lnpCNUXvcjJJ
         Y+9Pevj2XnvOU9MSJb42YeehNQmfucA33gc/435fVk+g7YqofJl+7u8USzMrDHRCPAvh
         uDVOWgqXPl9pb/w9ia3TUFSx7nSKqtDaKv/wXHPDJPaw2Atdlr/7TpJ+/EmynbZDXr7j
         rxi28WO1wogYjqfUMDf7Ze42PChz95uxXy08DssO3VHLYU7/B+/lwNAPtcGiw6jaDGex
         uYQQ==
X-Gm-Message-State: AOAM530Yp8xtYaA7SGpTRFyb3PAuWcMxpWHGo1IW/DQ/MwHrc4Kh3TVR
        8RofeLX9J4ANdTZUrNgNHQk7ZtNgk2HJHg==
X-Google-Smtp-Source: ABdhPJz86dp692j2MrnkvONrjmUyHBkQD9oknB5RQaC49cTM6dR0T4s6IkJhYXnwNnAkXO4ZZeGKpA==
X-Received: by 2002:a17:906:8904:: with SMTP id fr4mr9162979ejc.146.1620042503209;
        Mon, 03 May 2021 04:48:23 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:23 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 03/20] RDMA/rtrs-clt: No need to check queue_depth when receiving
Date:   Mon,  3 May 2021 13:48:01 +0200
Message-Id: <20210503114818.288896-4-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

The queue_depth size is sent from server and
server already checks validity of the value.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 930a1b496f84..0c828ea0f500 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1772,12 +1772,6 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 	}
 	if (con->c.cid == 0) {
 		queue_depth = le16_to_cpu(msg->queue_depth);
-
-		if (queue_depth > MAX_SESS_QUEUE_DEPTH) {
-			rtrs_err(clt, "Invalid RTRS message: queue=%d\n",
-				  queue_depth);
-			return -ECONNRESET;
-		}
 		if (!sess->rbufs || sess->queue_depth < queue_depth) {
 			kfree(sess->rbufs);
 			sess->rbufs = kcalloc(queue_depth, sizeof(*sess->rbufs),
-- 
2.25.1

