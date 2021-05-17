Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865B8382819
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbhEQJU7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbhEQJUm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD37C06138D
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v5so5974054edc.8
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xii0S/iziW0WNUb3W/LUH3djvpI4vadbCj4/x9QRIjY=;
        b=Bb/Rg0vJpwkMEMoWXjhrF7yMkOJSsF/1T1Gjtr/Zqv4Fin6wts+U7bHmqCn/N3Cj90
         NqGV4lKPWmafu6IGBxQFifrTJvUh7tn8ifRdeddWuQk38LjugX/JK5g3aLsJXombeZAf
         xB4hNUOE+08NJbcHmeDw+L+IB7UxoIKgLOfqRVDvXJglL0Zyv6RIJrwWPDKvOYvlqvRu
         anMy3JkkUfi3Qd1oUeTUA9bwJ+cH+8GxKOcsNjj3wlXSdYQdnqTjxKQQrHBSRycbNqIx
         Rgoceskm15h8pxUNpfoT5vH87GOR5MYQonhxNucyWSmrMGYc//jGY+XLNv32dGrB+OxA
         sYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xii0S/iziW0WNUb3W/LUH3djvpI4vadbCj4/x9QRIjY=;
        b=Xm0vwWaOuVGKnDzMijoiTrKnJohE5BeVHD8sat/Gkk9x5cvVoJi8IhswX2+DOuO2Ym
         NTaaZfcmtcNPdr3KVSksYvx65PM+8bwIXMpsdXg7Zm6Ri9cGbi03PKE9HbyGQ/U9cgL6
         NQn7XhueWPPRWbz7PXUg4h3IqpgMoMN9PVwgh+RRTTwAFa7PvvPsM+tn5jwMh5Fp9npj
         aVxzMnOMJeY+FX0ra6OSGlnJ6qpDD7vGSpgzzd7u8hjX86UAYi9xiHURC45evrDPOpEB
         LQwf+lSuNM8rrCG4TjMtZoe1U4/HdGDRwiuJ7hCAxcZ6fB7n0U1A8hk+NVx9zWjnDLN+
         B9gg==
X-Gm-Message-State: AOAM533Y5c+mgRcH3YhPSuH9vTcvpP9afAeTL7CryJ89vBwGcfFdOcQF
        7jmxi5ihMYwao4DgcWVlO5kZnHeEKf6Spw==
X-Google-Smtp-Source: ABdhPJz3sJQckuSTZsjOD8/f3dTv0jOI1xUieBBDbS7e80jDOPy+R3d9ZJHfEO7PVmCu4BIwlL7hCA==
X-Received: by 2002:aa7:dc15:: with SMTP id b21mr72042761edu.350.1621243163039;
        Mon, 17 May 2021 02:19:23 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:22 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 10/19] RDMA/rtrs-srv: Kill __rtrs_srv_change_state
Date:   Mon, 17 May 2021 11:18:34 +0200
Message-Id: <20210517091844.260810-11-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
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
index afa63f06586b..54a29285240d 100644
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

