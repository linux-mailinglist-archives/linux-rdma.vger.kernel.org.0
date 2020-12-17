Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6E12DD2DE
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgLQOUn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgLQOUn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:20:43 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F50BC0611CE
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:29 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id q22so20357532eja.2
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNCE9BUjl8LjgBBWvrzQwpmCGHe5xlvz+eb/c5dap0o=;
        b=QrnQs7Y54xJMvr96TG9gQqczUbvHJ3KTZO8F4zbSTyaui9oMB0J1BjhW5g72EkSyZ8
         aNRWMRR9pan0Z9FF37IS0X0wXiMbnbKbZY0RNzi7nLusAF8dcmwv0eScwGDXtalUhzOw
         oEyGW9N/hrxB4tQuU1CjD/4SoLjKciu0Zml/goSXI80xCp9dDWsvvd7XdFvzqbpssuHG
         y2OaZ9sCF8Q7r1xwiT0H9n9Z6BdXI+HH4UQrWbNiVLNbtKoKgp4+q5gMSa4v+piS17Ji
         iNHCQThvkkUojxnCSCFxCEAWU0jdBtjC5Ht1McdDnf/GCb5G8/vg/8Wzu9wsjoYK4x8P
         LQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNCE9BUjl8LjgBBWvrzQwpmCGHe5xlvz+eb/c5dap0o=;
        b=ZZSkB7rkJL8JbdmNcpylGzFVKmP2owvxBeHCJhdIJMyO03kZ9xzY18aWKD7z2xH8eX
         /fnV5K+TIhg25lheuuvw+NVdbl799dz5hpWBAyi04uYsWySnD90VgbAYvTl5T1ozrE0F
         dMCD2XxiQ5sCkWzRpzrxD6QOHcuF28ZsEXZNwj+tPvw3//rK6w5MeDgPLTBObR0mjd5M
         za5ut2vFAWzAfnoanPklqVFgluU6uxpARM5OY9RUdMXqhWZrs+MPZktiwJaj1GEaHS0p
         4hLSYSJ9/9qyb6F/yjUkB0SW5i/FiAqNuVgVWxoFudslQgEJ7PjfZ5TivRLA8gRmOP1B
         8z1g==
X-Gm-Message-State: AOAM530YvsBaNS091SSQG37mk7bApZgd5Jo4IlzHuljaHhycUIo+Yg7u
        YBdScc8MhzTQaxIuFvbxCUgDIE3syIaOSA==
X-Google-Smtp-Source: ABdhPJwVn3FqGPKqdoQX/e0Kjg54CQx/0vyVx4e/3C6ZfGZFCYuFqHIwJY+Kl0oiha5Ooo2HUuSxhg==
X-Received: by 2002:a17:907:28d4:: with SMTP id en20mr36076722ejc.196.1608214768145;
        Thu, 17 Dec 2020 06:19:28 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:27 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCHv2 for-next 12/19] RDMA/rtrs-clt: Rename __rtrs_clt_change_state to rtrs_clt_change_state
Date:   Thu, 17 Dec 2020 15:19:08 +0100
Message-Id: <20201217141915.56989-13-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Let's rename it to rtrs_clt_change_state since the previous one is
killed.

Also update the comment to make it more clear.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 39dc8423d7df..3c90718f668d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -178,18 +178,18 @@ struct rtrs_clt_con *rtrs_permit_to_clt_con(struct rtrs_clt_sess *sess,
 }
 
 /**
- * __rtrs_clt_change_state() - change the session state through session state
+ * rtrs_clt_change_state() - change the session state through session state
  * machine.
  *
  * @sess: client session to change the state of.
  * @new_state: state to change to.
  *
- * returns true if successful, false if the requested state can not be set.
+ * returns true if sess's state is changed to new state, otherwise return false.
  *
  * Locks:
  * state_wq lock must be hold.
  */
-static bool __rtrs_clt_change_state(struct rtrs_clt_sess *sess,
+static bool rtrs_clt_change_state(struct rtrs_clt_sess *sess,
 				     enum rtrs_clt_state new_state)
 {
 	enum rtrs_clt_state old_state;
@@ -286,7 +286,7 @@ static bool rtrs_clt_change_state_from_to(struct rtrs_clt_sess *sess,
 
 	spin_lock_irq(&sess->state_wq.lock);
 	if (sess->state == old_state)
-		changed = __rtrs_clt_change_state(sess, new_state);
+		changed = rtrs_clt_change_state(sess, new_state);
 	spin_unlock_irq(&sess->state_wq.lock);
 
 	return changed;
@@ -1361,7 +1361,7 @@ static bool rtrs_clt_change_state_get_old(struct rtrs_clt_sess *sess,
 	spin_lock_irq(&sess->state_wq.lock);
 	if (old_state)
 		*old_state = sess->state;
-	changed = __rtrs_clt_change_state(sess, new_state);
+	changed = rtrs_clt_change_state(sess, new_state);
 	spin_unlock_irq(&sess->state_wq.lock);
 
 	return changed;
-- 
2.25.1

