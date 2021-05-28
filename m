Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01393941CA
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhE1LcM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhE1LcF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07080C061574
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t3so4456429edc.7
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hlpwZoL+DNah27/Nz5DhzxgnHNjAukENDwvMU97btBY=;
        b=LT/9+d71olBml3QMg/TxbIugugnEp8gA8f4wHwmccu7fg1KMQcd5abLz0ienfJbwx0
         X2Ctf8IG7ZVlq9URgAKzMlYJ55vBSl5kgvBryKnWLJczXf0BxpgmRoW0uxipYBA8vYOb
         pZRUJpBuTrJywvBs0cmTFJdsdAsQDQ1puYfdDXD7qHZZJLCBVEIKTzafuKouBFCBvXT2
         8qtzOke8JYjEsiXa1IOzE8r1fetTLqzUZBsn5fiZsEGTCwsrjW7K26wgqijaFWmxUS10
         Br7KEZT83XcmxZOJEmijWaB20Y9mii41eXzlvmTlmkHwJv+uWhK19F1gaJZ9rwJoYMDR
         g1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hlpwZoL+DNah27/Nz5DhzxgnHNjAukENDwvMU97btBY=;
        b=ct/0o0vlQ1e64XOt4GooRpHMnFYwGDS/euR8W7fueXki9Nw3UwU/EirDhSwEE+d6gh
         eadZeEvEc97HXN+/wWE/wae73rseCaAIGqplrPK50Gse+T3bjTsCwnIM1smgEzdFcQAF
         eQceB87H2a/AXwcjltEQ15QrLumr6ZfIGU9E6JbEicuUvrQcpVnxmMhfjASLLtMwwPOM
         NdXL8EYgRQXw/7Q8aSFRmEfr6ccrQGZJpm50XeXwnrKK/UH0XkG/LvjzvdK1fxiw8+yH
         t8lToo6HlZ1660UrnQngA5JSE4XawFVKwhInLxdf34fo4ntJoUQJmUVANO7YKXe9c+OY
         IX6w==
X-Gm-Message-State: AOAM532mOUZRgIF0h5YLBDVtYUFsD/Rkutbk4gitIiUfESvhrPuMGxLF
        AuAcgBLt5n5kTszcDuOVVugczQauREkBnA==
X-Google-Smtp-Source: ABdhPJz4mQk4YwCnoOch+hiFabvIkWXkyvkIDE2YHf3I48LvGpecOQjKfaQ0ULC/evjdjqNymKKHbQ==
X-Received: by 2002:aa7:c04c:: with SMTP id k12mr9497056edo.252.1622201428502;
        Fri, 28 May 2021 04:30:28 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:28 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 10/20] RDMA/rtrs-srv: Kill __rtrs_srv_change_state
Date:   Fri, 28 May 2021 13:30:08 +0200
Message-Id: <20210528113018.52290-11-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

No need since the only user is rtrs_srv_change_state.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 2ba6658c5e35..840a3423f749 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -67,13 +67,13 @@ static inline struct rtrs_srv_sess *to_srv_sess(struct rtrs_sess *s)
 	return container_of(s, struct rtrs_srv_sess, s);
 }
 
-static bool __rtrs_srv_change_state(struct rtrs_srv_sess *sess,
-				     enum rtrs_srv_state new_state)
+static bool rtrs_srv_change_state(struct rtrs_srv_sess *sess,
+				  enum rtrs_srv_state new_state)
 {
 	enum rtrs_srv_state old_state;
 	bool changed = false;
 
-	lockdep_assert_held(&sess->state_lock);
+	spin_lock_irq(&sess->state_lock);
 	old_state = sess->state;
 	switch (new_state) {
 	case RTRS_SRV_CONNECTED:
@@ -94,17 +94,6 @@ static bool __rtrs_srv_change_state(struct rtrs_srv_sess *sess,
 	}
 	if (changed)
 		sess->state = new_state;
-
-	return changed;
-}
-
-static bool rtrs_srv_change_state(struct rtrs_srv_sess *sess,
-				   enum rtrs_srv_state new_state)
-{
-	bool changed;
-
-	spin_lock_irq(&sess->state_lock);
-	changed = __rtrs_srv_change_state(sess, new_state);
 	spin_unlock_irq(&sess->state_lock);
 
 	return changed;
-- 
2.25.1

