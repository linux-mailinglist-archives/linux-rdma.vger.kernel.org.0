Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4352522C434
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 13:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgGXLPZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 07:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXLPZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jul 2020 07:15:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C4CC0619D3
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 04:15:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gc15so5723006pjb.0
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rfmz7WqkObcQ7w86x2Q1PZGpYkuIjbN+VcWdXX4eM2Y=;
        b=dncij+yrppruGvLhR+7plKjqXePPyr40+9l0LDhswKENb+EIhaOSJGvLFNPGvEvtg3
         XO4mD54V9fDjq9hpvRFvdgc/MXWeoQiSXNXFeET+a72phMvx8J98QT5sM4yYKFjgGZ2X
         Vzb0GovIOsDToAIUuSB5ROSsMsOZwyONYJ3vmKiNwnRjFzHQTpb3fR1N0XVacN97gOlq
         oSNqThSEOIpBZJTklJ81HLyhn31R6oaTg5rfwI/ZcI+nCSl2DZIADT57VG4U0j7kVAHP
         K67aK9L3MU0vLyFJf17Te8kEbrBxhsdI/7nAQurUEVLy1+4sCd/BcLJzbnB4+yCaSiaO
         RbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rfmz7WqkObcQ7w86x2Q1PZGpYkuIjbN+VcWdXX4eM2Y=;
        b=jOC4q8dMYGcYoyctAwFdWcJv5AqZ+6DgPYlq2/CLMV/F/q2KCRM4cR9LuJ9D4/f0lO
         X+9MsKbsdSquB6j6dZlPeCLsxl9ZFglXL6CHfAxGZqsFQVrqEH8c5tkOSldyUXjQuTDC
         FDmdKOiRWrCw2ajPzKIv1xSKbZ9paSUErvdAX5xa1gGIVjwGtx3eZ3wiA0LEetof9faA
         owiZNX41ZUX7uX2CXBG+AUiWtgPP72hjZkb8H2TKc3IJ7CrvhrXuFYatbTVbZVPTCMF+
         xjCPJoHbajHpep43gKj4JF2WAOmh+mbV4izTbPT38psjj4mNF1LyhImrJmUMR3/EsSyI
         4dmQ==
X-Gm-Message-State: AOAM531PFcx+Mx9PF3pykVCP9XpqZdbS+D4trnmD85YnkWBZnOEkIWSV
        Ra3c3d0B1wOlNrFo3LB/l9bvaQ==
X-Google-Smtp-Source: ABdhPJzZCGqXlOtTUAwCrDhWD7XDYAqewCaTJADjlxV5wk4AM98VyxRjz3pDNPGjZ6jd1LHfy+4e5Q==
X-Received: by 2002:a17:902:b496:: with SMTP id y22mr7871318plr.44.1595589324186;
        Fri, 24 Jul 2020 04:15:24 -0700 (PDT)
Received: from dragon-master.domain.name ([43.224.130.248])
        by smtp.gmail.com with ESMTPSA id y7sm5569643pgk.93.2020.07.24.04.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:15:23 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, bvanassche@acm.org
Cc:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH 2/3] RDMA/rtrs-srv: only call put_device when it's in sysfs
Date:   Fri, 24 Jul 2020 16:45:07 +0530
Message-Id: <20200724111508.15734-3-haris.iqbal@cloud.ionos.com>
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

There are error case we will call free_srv before device kobject
initialized, in such case we shouldn't call put_device, otherwise
a Warning will be generated, eg:

kobject: '(null)' (000000009f5445ed): is not initialized, yet kobject_put() is being called.

So add check before call into put_device.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 0d9241f5d9e6..8a55bc559466 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1373,7 +1373,10 @@ static void free_srv(struct rtrs_srv *srv)
 	mutex_destroy(&srv->paths_mutex);
 	mutex_destroy(&srv->paths_ev_mutex);
 	/* last put to release the srv structure */
-	put_device(&srv->dev);
+	if(srv->dev.kobj.state_in_sysfs)
+		put_device(&srv->dev);
+	else
+		kfree(srv);
 }
 
 static inline struct rtrs_srv *__find_srv_and_get(struct rtrs_srv_ctx *ctx,
-- 
2.25.1

