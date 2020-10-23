Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A69296A76
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 09:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375773AbgJWHoE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374490AbgJWHoE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 03:44:04 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8E5C0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:03 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dt13so1019358ejb.12
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hNwL06T9lZbIYJAW3UwxrnMIZQSk9NdDK4p0pWkg0K8=;
        b=G6xRiZseQCXjBdPkPAKc+M78RRTDsvMAPpASn94IDAXBCtJGQ4tx81ywKDnpBFmccr
         SFsYxSXxYDKTGc37I50/VXP6t13fMJaoPNdydCmifAgZGJYrIYNZAohygedpUE+PmWoQ
         PIJgEP8SpRXQ4bLIBzylt/roiO9B/lT7XiTB3Gj50nqAeP5Afr80hb+fb6LRhDRgiCU2
         Jd/968qJkPk1Xjq8j/+SNlqpppueER38vz2AhRUGCCjqKCLibdoTCVfL2v2P2WfQkYu3
         zXlvyNIT6eFOOqUmyF1EtHbTWXg/GOU9LkTW+9UzGnkjwy0prTAamzCmtHW66uQrnCov
         CNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNwL06T9lZbIYJAW3UwxrnMIZQSk9NdDK4p0pWkg0K8=;
        b=dtUFwZapqZOYwGehYDJv20I9q5Sc/g8mE4uiN7vvZO58MeDMssU66zsm01oCz/sHQb
         cQI8fE0wZ6UDqpBvNFVxFupmOr+UopXNGZSJSFLFw+v+2JGdXJaybUIWke/FmuScKb5W
         GEfcMtVhmIaK06JSKlKbI9+tJFK9hRtHbYmyqtId0cntK3JgxQf+dZZx0YldVQqmOXdi
         DrdKWor7lOWOizxJEApkmobu04TX0oV0maYvtMQ4VwMssE6RioSA5Pv/OiulIYKai5jo
         GDRvSsuc/84qoXLJ5xBJAbYB+csL5+jfMwvT0Yyay+eT/UKYfHWpPRdCAm6z4zWKHb7s
         9V4g==
X-Gm-Message-State: AOAM533VRu1EQcExXhiqU3eU3mVQMsTD3hqhgHPSV8XI7/bJe0e1KECI
        ekSHofuxr5OF7FO1/+TD/XVuHw5KROGjHA==
X-Google-Smtp-Source: ABdhPJwp3mJBNrmkfsSmh9QpPF8KcvmdbDPyknHRLU3qj09ffMCASb5roAfmBKdFJt6KNmgoF/iiqQ==
X-Received: by 2002:a17:906:bc98:: with SMTP id lv24mr741770ejb.536.1603439042505;
        Fri, 23 Oct 2020 00:44:02 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49b9:3000:d18a:ee7b:bff9:e374])
        by smtp.gmail.com with ESMTPSA id op24sm337928ejb.56.2020.10.23.00.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 00:44:02 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 08/12] RDMA/rtrs-clt: remove duplicated switch-case handling for CM error events
Date:   Fri, 23 Oct 2020 09:43:49 +0200
Message-Id: <20201023074353.21946-9-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
References: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
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
index 4e5da834034a..30eda2f355e1 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1843,20 +1843,22 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
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

