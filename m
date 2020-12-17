Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A572DD2E1
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgLQOUz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQOUz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:20:55 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248F9C0619D4
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:35 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qw4so38045004ejb.12
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0l8ELeizMdgasVxuWqcV1kW9L+4uQLAYqusCbE9QO7o=;
        b=YwB02qLoBEnkzdd2E70f4Vsh+nQpEIsL/JJvQFHQTyCXmP1vTLpAr9c+8B8ACIHH2O
         aFi3sHuuPiRGoA90em0G8yIIRayvR8u7TAcGXqxL7ojk/0pXro+Y6NkH1UpE+Z0KGWdF
         nvLtcqFW8FIbW3iN7u46IWEM7DCIk7BhjdHx+m84LXuRSBV9HcDc5cNUzxtTWQDeze3b
         xHFVZgVG8STuBJnZRJVR36BXwhxIwldx1W8/4ua9u+/I1dNzlJhjzjqKfzoN+eTN/86X
         7BxhUES72k5m21v8XuivCdFlDM5CIhMSacE/CKut0IDHRvGvVCPM2b5X8LtHUaVmz23T
         ENOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0l8ELeizMdgasVxuWqcV1kW9L+4uQLAYqusCbE9QO7o=;
        b=rz50OqdmHouLBNseDpT1h4FWRYwXPe+j4R9JBvVt34zG/CPT2Yi4zCAUfyFBXav9T5
         ZU4U5CGCn/EgDp1on2nI0MjvfHAhaA1pZV/iNw1ftHajQkLatiircn1bOgO8mhLlbR2K
         hr0iCNzcF6gS8j5fRrRin55HewF8W86Dn6rPcOMmoN/Won5BBgvM84KFQVVcHEEZkrRA
         Jo0fNC3WMHhH5pLVMWh7LNnIgwH6n4LByvbc8Ytmf5m5wPEGeCdY9GZQ2MjZiZQ/WghW
         rYIIcixzu83ZErx7TG4gBHfcTqO4AQpMoTx/YZyknt62lLVxErkYesES1+kXCbIrdTs6
         Mazg==
X-Gm-Message-State: AOAM532oH9TmETUSndsbFHW2Mo1TaBBxNGX0PNi1O7BW44m1DjZqKJy6
        B0tyydVaSAa2XDnEqCGxw8PY/1ZGxB+0qA==
X-Google-Smtp-Source: ABdhPJxzfgb7xvivWbvTYP1BHPIR1o+xuQ6V3krCtBNACLSA58IR4qQtnIuFVXzAj976sXtCFv0czQ==
X-Received: by 2002:a17:906:aac1:: with SMTP id kt1mr19942406ejb.329.1608214773786;
        Thu, 17 Dec 2020 06:19:33 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:33 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 18/19] RDMA/rtrs-srv: Init wr_cnt as 1
Date:   Thu, 17 Dec 2020 15:19:14 +0100
Message-Id: <20201217141915.56989-19-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix up wr_avail accounting. if wr_cnt is 0, then we do SIGNAL for first
wr, in completion we add queue_depth back, which is not right in the
sense of tracking for available wr.

So fix it by init wr_cnt to 1.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 2798c655d7ae..54abbd9562d0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1603,7 +1603,7 @@ static int create_con(struct rtrs_srv_sess *sess,
 	con->c.cm_id = cm_id;
 	con->c.sess = &sess->s;
 	con->c.cid = cid;
-	atomic_set(&con->wr_cnt, 0);
+	atomic_set(&con->wr_cnt, 1);
 
 	if (con->c.cid == 0) {
 		/*
-- 
2.25.1

