Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71DE28B5EB
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388840AbgJLNS3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388160AbgJLNS3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:18:29 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86524C0613D0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:28 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id p13so16890321edi.7
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JkxeU+sSRTy9pyx5IFVwQZlr/UNRjLgsU4lVsY6uQx4=;
        b=UokvXF1dIXiFPWMDCE7GHfODGm7GFyra8PAYICWPP/S2u/z28WB5sIVGtFwswG7QkC
         X3SR/fzLxRqjGwBMBpFTk2WoHjGK43tb9LQmd0MQAB62FJOdctCDHSCwv9reQ3DblTgX
         3l2hyTzw5D8yOZQih8qBBADHDNgCLKWcGZLngwbMkvpH30BSAV/nFbq6wTY8Ss7/WJXh
         nRWVolUaHkWJ66/TZvv9D65YkbxMTgkvVhn/h7RfhcXc+//dbADgvXc1cEsG4vPOQON3
         PXNMDAi0IdDJoBwBskuS96PJgNd1um9CHUayZeSBxoGGn0vaSGXCVRAXIPXybmK4xI/W
         7i8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JkxeU+sSRTy9pyx5IFVwQZlr/UNRjLgsU4lVsY6uQx4=;
        b=HbfhN/uhk9WPSmdF3ampOd95Nsgph0ChIVK2FRQDWK32c+SHXtpJHqglFXY5OE/c7d
         +IkO6+5NofAx3xYuPcQO0I/5h6En65rcI6CrJSmqlEuTyaCfwg6zTKnELJ7f+ouT0wR6
         utBabRHbG7LFowLruyxGwDGdmrPbVj22oauhOQqKrdtDn465dEuk+uzN3cC6hMbHrjO7
         nc25fdLQTo0uupT0jVJB4xURvsNSXTIDA4lsrqnKTWBEXVWPqmCM6HODW1gO36d+cY4Z
         xxnmEH2kPxyXDO8eYpfoBqq+q5d/50dh139xVPQDLe1IbcVxJeJEAMZaF7JlaViLHe8H
         nhrw==
X-Gm-Message-State: AOAM532gJWaL2ZXYtlNeS4Qr8ds6hv6+D6cF43O2ykeg9PTRu7rAwhko
        O1eiCRdq5UgAmmLjkAr7XJKIIsTk60w46A==
X-Google-Smtp-Source: ABdhPJzgSnd42kvzWT9dtDLadRhhHIszQaiimeoSRSmXFsOhaqoNLVhNAyGXk6zmcvjdzKxRY4vCnQ==
X-Received: by 2002:aa7:d4d8:: with SMTP id t24mr14597171edr.247.1602508706986;
        Mon, 12 Oct 2020 06:18:26 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4915:9700:86d:33e0:2141:a74a])
        by smtp.gmail.com with ESMTPSA id o12sm10828252ejb.36.2020.10.12.06.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:18:26 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH for-next 11/13] RDMA/rtrs-srv: kill rtrs_srv_change_state_get_old
Date:   Mon, 12 Oct 2020 15:18:12 +0200
Message-Id: <20201012131814.121096-12-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

This function isn't needed since no caller checks the old_state of sess.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index d85a55851446..52e02123697c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -111,28 +111,18 @@ static bool __rtrs_srv_change_state(struct rtrs_srv_sess *sess,
 	return changed;
 }
 
-static bool rtrs_srv_change_state_get_old(struct rtrs_srv_sess *sess,
-					   enum rtrs_srv_state new_state,
-					   enum rtrs_srv_state *old_state)
+static bool rtrs_srv_change_state(struct rtrs_srv_sess *sess,
+				   enum rtrs_srv_state new_state)
 {
 	bool changed;
 
 	spin_lock_irq(&sess->state_lock);
-	*old_state = sess->state;
 	changed = __rtrs_srv_change_state(sess, new_state);
 	spin_unlock_irq(&sess->state_lock);
 
 	return changed;
 }
 
-static bool rtrs_srv_change_state(struct rtrs_srv_sess *sess,
-				   enum rtrs_srv_state new_state)
-{
-	enum rtrs_srv_state old_state;
-
-	return rtrs_srv_change_state_get_old(sess, new_state, &old_state);
-}
-
 static void free_id(struct rtrs_srv_op *id)
 {
 	if (!id)
@@ -469,10 +459,7 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 
 void close_sess(struct rtrs_srv_sess *sess)
 {
-	enum rtrs_srv_state old_state;
-
-	if (rtrs_srv_change_state_get_old(sess, RTRS_SRV_CLOSING,
-					   &old_state))
+	if (rtrs_srv_change_state(sess, RTRS_SRV_CLOSING))
 		queue_work(rtrs_wq, &sess->close_work);
 	WARN_ON(sess->state != RTRS_SRV_CLOSING);
 }
-- 
2.25.1

