Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB45E28B5E7
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbgJLNSZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388160AbgJLNSZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:18:25 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F62C0613D1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:24 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e22so23151795ejr.4
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uuFRrj9WYf9gUlAzDmpD9QovElzcMlssDMZFI4gvMaA=;
        b=U/Ck/9i13M3J6L4QxLLz6w1krWrlhzVCwZXo+83bODtx+hxVZickf+OIy2Bqt5/CIl
         wxphWWkBbCzRfim1vanTB9Tj0LaCgzN1lQfGRma/6qS8+53RVJ7bKHLFWxrLo6i7aqo3
         FjslvmrFSf0PpBuAOdLg4eGroYmSy9uYs7Ca5vXIsYRXaT1LNclU5OGfACkVUd9VL2Sj
         aAhzxpuABkPQMidjtadFZRva94ma9mFEQwSYPEgKuQJX0R6kMCjOv4B132NOCNH7mosy
         K1+PS33RJUmv2XOvzgHzhhfWlGT5rL4cRnjMv7CQA+LIkuibi8YKpC9CmKTYg05wpzaQ
         gYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uuFRrj9WYf9gUlAzDmpD9QovElzcMlssDMZFI4gvMaA=;
        b=b4SaEYUlhn81qxR6XH/YMYqNWAOQuQVHOChQwupJqpNkWTcd4t6y+rUv365U1nYnKl
         NLryOTnYCkLoqhZaJeLUGd9Z9m0Wpl1r+hrIoeDFuG1x/l8VUYwQmx2IcP0r2/y8Dmqq
         e/CUnwJ4rwVZAT/UTk4bV2svQU1zse0vt6h3CGbbS9ba7fU14ZZ+56FufSI3/czdNuYS
         Rs2XFZ0btVqW6QW9KpHFaFhQlEQ2vtUnA+5Vt2kQ41+rHdBYUmjAT9252MYWPGdu8gob
         lHTitdmVammAAYlj3w89X8/dwAXAOBKGLe9CcqMtRWlVD5gz2tmZsjMqg9PxXR1NSdcT
         pj1Q==
X-Gm-Message-State: AOAM5320frw4xJPkp9bZ1WFjdt9RipFqaxHsAUBnTvwgUy7XG5h7C+b/
        PR6iansudXnsOT7YjHj4uTke9Pjr7DQJAg==
X-Google-Smtp-Source: ABdhPJxo5OapPCoNy6OYw7pmOlFN/ipxepxtBgxfpRpOtXAQWj36Ik7QhTzKbWJQwvzJ0/O8GN1z9g==
X-Received: by 2002:a17:906:2b85:: with SMTP id m5mr29353894ejg.143.1602508703114;
        Mon, 12 Oct 2020 06:18:23 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4915:9700:86d:33e0:2141:a74a])
        by smtp.gmail.com with ESMTPSA id o12sm10828252ejb.36.2020.10.12.06.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:18:22 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 07/13] RDMA/rtrs-clt: remove duplicated switch-case handling for CM error events
Date:   Mon, 12 Oct 2020 15:18:08 +0200
Message-Id: <20201012131814.121096-8-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

The events returning the same error value are put together.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 6507cfb960d4..7764a01185ef 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1836,20 +1836,22 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_REJECTED:
 		cm_err = rtrs_rdma_conn_rejected(con, ev);
 		break;
+	case RDMA_CM_EVENT_DISCONNECTED:
+		/* No message for disconnecting */
+		cm_err = -ECONNRESET;
+		break;
 	case RDMA_CM_EVENT_CONNECT_ERROR:
 	case RDMA_CM_EVENT_UNREACHABLE:
+	case RDMA_CM_EVENT_ADDR_CHANGE:
+	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
 		rtrs_wrn(s, "CM error event %d\n", ev->event);
 		cm_err = -ECONNRESET;
 		break;
 	case RDMA_CM_EVENT_ADDR_ERROR:
 	case RDMA_CM_EVENT_ROUTE_ERROR:
+		rtrs_wrn(s, "CM error event %d\n", ev->event);
 		cm_err = -EHOSTUNREACH;
 		break;
-	case RDMA_CM_EVENT_DISCONNECTED:
-	case RDMA_CM_EVENT_ADDR_CHANGE:
-	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
-		cm_err = -ECONNRESET;
-		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		/*
 		 * Device removal is a special case.  Queue close and return 0.
-- 
2.25.1

