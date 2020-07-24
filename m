Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6918F22C433
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 13:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgGXLPX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 07:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXLPW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jul 2020 07:15:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97B2C0619D3
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 04:15:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m16so4269573pls.5
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 04:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gto24Pi+IXgbmRe3PXmvOIzkGoqiEp4UN50msKjKdEU=;
        b=U8BuOQFRAKjhNf1dg2ZzhizGRfIg1elWLEfzLRBG2GqAH6ra/v5BeLJHd3b7m6mgc6
         GReTcSj/sGLGi1LeZpPVfi9aypYHD0Gz+HzBANTOsVbcWiyN4tmNM8hIIKtSNUBYJZtZ
         9OKfWs1q8D/5+UuQUgHErToyRA47J2uQgRRPza0ifBDflzkOJoWCksUFi/KnjW0cbM5U
         /bJvXThz2lG6CC3VEtPAiUCkejuI+i9NioDFgJrSqNSMqbUtDNefyt10ZnbhPqqJBb+6
         GrHvGrfotCEqACObIjO4e1Q1VUgPTBNLdEKxdiS+HlSjzaW9HHuHRgZ7VAUuxFeCPmEp
         0LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gto24Pi+IXgbmRe3PXmvOIzkGoqiEp4UN50msKjKdEU=;
        b=SViRSUCcftm2FKslAParfTaeuJYdkKXpPiBQ2LontVJtCWdaEc5PG2jMHjDzYw+NfS
         BnQZRKr01oDERp0HekINjTQ6qbgpw/I+WEXZDHDyJFB4+ckONH+ulDCr5QzgTMefrS87
         oGvcN5y3YfS1OJvp0L63mqbgW8kIxD2UIzYzfHfIOUIAJADJUwDJTCVhzS0XbiUg2Ik+
         4MMEuIvq6oqDMYY3LWtIFGcn0ghyTi4GsN2zHmStb9FBV0ycht54XEn8qpn+ZgeCOh2x
         SKlCXXA31HREnNR7aZSL7YxoBicP7GIsIDwQ/Sn5hNmS70UOlj6/6MtkUtUr4pD6QPhQ
         PeVA==
X-Gm-Message-State: AOAM533UYWFJgCDn/fanWwe4yo9MdrxEzYLIuWvyIknrk8pewulROmIN
        RSOYIJNaPnGPjbDQDBZ1S5bIzQ==
X-Google-Smtp-Source: ABdhPJy4CIOOBa0z/DQt0+RuVckhp+vzdLr3AExaNxbYk9/5G2CXGrfB7JYcmIX0lmL/whCo/YM2/w==
X-Received: by 2002:a17:90a:f007:: with SMTP id bt7mr3047468pjb.214.1595589319074;
        Fri, 24 Jul 2020 04:15:19 -0700 (PDT)
Received: from dragon-master.domain.name ([43.224.130.248])
        by smtp.gmail.com with ESMTPSA id y7sm5569643pgk.93.2020.07.24.04.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:15:18 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, bvanassche@acm.org
Cc:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH 1/3] RDMA/rtrs-clt: add an additional random 8 seconds before reconnecting
Date:   Fri, 24 Jul 2020 16:45:06 +0530
Message-Id: <20200724111508.15734-2-haris.iqbal@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724111508.15734-1-haris.iqbal@cloud.ionos.com>
References: <20200724111508.15734-1-haris.iqbal@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Danil Kipnis <danil.kipnis@cloud.ionos.com>

In order to avoid all the clients to start reconnecting at the same time
schedule the reconnect dwork +[0,8] seconds late

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 564388a85603..5b31d3b03737 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -12,6 +12,7 @@
 
 #include <linux/module.h>
 #include <linux/rculist.h>
+#include <linux/random.h>
 
 #include "rtrs-clt.h"
 #include "rtrs-log.h"
@@ -23,6 +24,12 @@
  * leads to "false positives" failed reconnect attempts
  */
 #define RTRS_RECONNECT_BACKOFF 1000
+/*
+ * Wait for additional random time between 0 and 8 seconds
+ * before starting to reconnect to avoid clients reconnecting
+ * all at once in case of a major network outage
+ */
+#define RTRS_RECONNECT_SEED 8
 
 MODULE_DESCRIPTION("RDMA Transport Client");
 MODULE_LICENSE("GPL");
@@ -306,7 +313,8 @@ static void rtrs_rdma_error_recovery(struct rtrs_clt_con *con)
 		 */
 		delay_ms = clt->reconnect_delay_sec * 1000;
 		queue_delayed_work(rtrs_wq, &sess->reconnect_dwork,
-				   msecs_to_jiffies(delay_ms));
+				   msecs_to_jiffies(delay_ms +
+						    prandom_u32() % RTRS_RECONNECT_SEED));
 	} else {
 		/*
 		 * Error can happen just on establishing new connection,
@@ -2503,7 +2511,9 @@ static void rtrs_clt_reconnect_work(struct work_struct *work)
 		sess->stats->reconnects.fail_cnt++;
 		delay_ms = clt->reconnect_delay_sec * 1000;
 		queue_delayed_work(rtrs_wq, &sess->reconnect_dwork,
-				   msecs_to_jiffies(delay_ms));
+				   msecs_to_jiffies(delay_ms +
+						    prandom_u32() %
+						    RTRS_RECONNECT_SEED));
 	}
 }
 
-- 
2.25.1

