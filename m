Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D3F28B5E1
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbgJLNSU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387743AbgJLNSU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:18:20 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D10C0613D0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:18 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dt13so23121859ejb.12
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qz5o+0xhtEcQDYPVbsuO2F8boamxheOIyacunDrflCY=;
        b=VSWgMdZjfXySCSe1XC4Efo6Q8ZR1p9u8B9JAPuJOJTv6GFCLzyhleqq+37YR5kspaT
         aHQI0CO+WUZvzpqp/INB5G68UiVLuvomTnEu3AEZfcmL7THXkjc2hwobPSZPmiSEyFz1
         jOdcWCEXw7tlLVB5lkq/6FyjVfswLShR5kIk5cUaKjXwEGax+ob3qqw8DyXQzZB+6OD5
         w1IQiUXI9OnvXft5Dp/zN5Xy3U6h7AJabYkGpjR5ktoKsRE/9IBaqi7/Y08koYENyuwT
         6KPBGH45eSNCtjBQCEi7NfKyFEMORJ6/MvP6oVA9Fxvj5YixKmntvYlwJgelZbnJsUtM
         amdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qz5o+0xhtEcQDYPVbsuO2F8boamxheOIyacunDrflCY=;
        b=Z4q6GbNkStBv9uBulVqWqFkFmdM+Vknsz9K6xRfh7rh65GxdoBZ3Njibq3QlO0ZUt2
         TgmkmP/DatE+enY8T73VDhdrUy2zcGynxskE/gOXqbjjZVAEgmLrVCdoI+df4M7kuvJV
         W/LQV0oZXerBYXAXWGWFA024JrXkUitC4cwKhlvOp7ZzVAo0nAOTMecO9TqmQlPLsQcd
         zg4fstukRKmFk2uu54THWquO6meU58bG/+PKwi+auWXxMwSfmlz+vFQFBWjdNjLA+srV
         MtOGUCUzJExBTh/Svv9+mBQcxa/WDNdu6V4uYvCl3DMM4cdeko1Dwf8mit0kx+rEIPcG
         gKmw==
X-Gm-Message-State: AOAM532KjT5UAa7dzMySb0F9tEQA6H0pjuMLfbl+/FDOpxwzo66wjxI5
        Z29a1qXlv0Smxj/F6PJeq3K0VE+oGlBOlw==
X-Google-Smtp-Source: ABdhPJzZhoC6CMV6Te0mbthcBqFzlqZcdLQxMDeIBvsL50zhSznglnw3BVMtI+s9PdsxR1GrK80zdA==
X-Received: by 2002:a17:906:bfe2:: with SMTP id vr2mr26066682ejb.248.1602508696669;
        Mon, 12 Oct 2020 06:18:16 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4915:9700:86d:33e0:2141:a74a])
        by smtp.gmail.com with ESMTPSA id o12sm10828252ejb.36.2020.10.12.06.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:18:16 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
Subject: [PATCH for-next 01/13] RDMA/rtrs-clt: remove destroy_con_cq_qo in case route resolving failed
Date:   Mon, 12 Oct 2020 15:18:02 +0200
Message-Id: <20201012131814.121096-2-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Danil Kipnis <danil.kipnis@cloud.ionos.com>

We call destroy_con_cq_qp(con) in rtrs_rdma_addr_resolved() in case route
couldn't be resolved and then again in create_cm() because nothing happens.

Don't call destroy_con_cq_qp from rtrs_rdma_addr_resolved, create_cm()
does the clean up already.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 776e89231c52..9980bb4a6f78 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1640,10 +1640,8 @@ static int rtrs_rdma_addr_resolved(struct rtrs_clt_con *con)
 		return err;
 	}
 	err = rdma_resolve_route(con->c.cm_id, RTRS_CONNECT_TIMEOUT_MS);
-	if (err) {
+	if (err)
 		rtrs_err(s, "Resolving route failed, err: %d\n", err);
-		destroy_con_cq_qp(con);
-	}
 
 	return err;
 }
-- 
2.25.1

