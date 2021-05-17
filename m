Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08D1382813
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhEQJUx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbhEQJUg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC84C061761
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k14so4625759eji.2
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v2jM+Ra/5Z6joqP338SkpJMALJWRGixf8r+AeqFXX7U=;
        b=R1SKyzwWE5rDR9ne7smuD8mLUq8A23CiBXkDSjPpaFAY6qL6DC4k3L6pdY26+b9RC6
         3kxQwTx271IsvMNQGY0QQmgMq1T7Qttd5B4/jziqeR40jREpHIA94uHsj32yesEpUw+f
         W+gM7H3vHbfEvN5cwbVf1CRNJVQUB4PWSrYJpyp58Z2ODFWLVYciQc+coHQoQd9tmBJj
         Qj/pFO7UPOYtJvE0XIRoDuEBke2pfasMiHOhzpa7pu/Fkr80Wd3EZt/8PtUHK50PPne+
         OanHmQL2lohjGVPYE+fRbWwpUKRpXape9nYRWIltKI7KN9yiKAB6ych7TJo83HzyNaNq
         5uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v2jM+Ra/5Z6joqP338SkpJMALJWRGixf8r+AeqFXX7U=;
        b=ofPfp1AqAkq8qxNi2HilQBYmewDlF4Ip/EECETRiyWw3J8wr4JgUyyBAcr6AH4TZjp
         KZjvPvxiwKmlAHE9QOuE8qEM/Q6EhG63skftWwiYKYTuIyIQzNSItFR3m6xKC5pYvZfo
         9RZfqJPD6lzVqf19olCNkZJA+sZlaNv0BMfGU2IgTQtx/l6wXCSuZ9sUVQlCWL5S47M+
         fu2fT/ESfzLRrJphJlfYC1NzT7RilOZiQ8qgJ+XqzNSgDTGxpdGsrqHBvUuvJyh3ndTH
         NNSzkT+wyeuZfFB1WWvp4wR+qYHBArVssoSpQ3ofElWus/ZxUP/BOaYPds1XjOvYIisz
         DFcw==
X-Gm-Message-State: AOAM530EpvDx2AIfYc5lEOB1FXJr90zf1U7kcpNZb2fm9dKzWDlJtzKX
        IDrXbbt9pEbTZ3IRRIeTcNqYfrI/FpUFLw==
X-Google-Smtp-Source: ABdhPJz+kiM07HMfy+doz984a6oKXpXKVleyFadmbDAfO10F5d1aSAiFFqCYO34Q5rpF3GagaPtIHA==
X-Received: by 2002:a17:906:28d4:: with SMTP id p20mr62105398ejd.552.1621243158751;
        Mon, 17 May 2021 02:19:18 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:18 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 04/19] RDMA/rtrs-srv: Clean up the code in __rtrs_srv_change_state
Date:   Mon, 17 May 2021 11:18:28 +0200
Message-Id: <20210517091844.260810-5-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

No need to use double switch to check the change of state everywhere,
let's change them to "if" to reduce size.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index df17dd4c1e28..74a5dfe85813 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -77,32 +77,17 @@ static bool __rtrs_srv_change_state(struct rtrs_srv_sess *sess,
 	old_state = sess->state;
 	switch (new_state) {
 	case RTRS_SRV_CONNECTED:
-		switch (old_state) {
-		case RTRS_SRV_CONNECTING:
+		if (old_state == RTRS_SRV_CONNECTING)
 			changed = true;
-			fallthrough;
-		default:
-			break;
-		}
 		break;
 	case RTRS_SRV_CLOSING:
-		switch (old_state) {
-		case RTRS_SRV_CONNECTING:
-		case RTRS_SRV_CONNECTED:
+		if (old_state == RTRS_SRV_CONNECTING ||
+		    old_state == RTRS_SRV_CONNECTED)
 			changed = true;
-			fallthrough;
-		default:
-			break;
-		}
 		break;
 	case RTRS_SRV_CLOSED:
-		switch (old_state) {
-		case RTRS_SRV_CLOSING:
+		if (old_state == RTRS_SRV_CLOSING)
 			changed = true;
-			fallthrough;
-		default:
-			break;
-		}
 		break;
 	default:
 		break;
-- 
2.25.1

