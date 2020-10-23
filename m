Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482D7296A73
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 09:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375768AbgJWHoC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 03:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375769AbgJWHoB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 03:44:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FEEC0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:00 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p9so1058824eji.4
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjgVVeV7ye/lxK4uc/5lZilh6HVPNP9zhUrFloHljoY=;
        b=Ksr4VU5EnyUfX2IlPQaXkoQRoH3HyD3WF+G0kXc9AZlV8q9NzmAmxN/sVcS4zCMd3T
         owygceoGxA6D+2r8X67ZIcsST1ixX4O0lZne+NzlC7wowRYXJ4itdGjvlaxcajb/UAEY
         kP5sjgwOnJCL7kZgcvTcsJCjkjGlWlw7dgRzXwW7UUxfzF5OP42R0j31fvXohBz+wHZ0
         9hskyrt+Pd1XB318aUW+MabgkkLiQoHpH4HXAtaymYBWJe6berRAX/OvOh6ZFe1Gq44O
         lLbQrfoJQ/mRDaZD5c1ekucPODo9rV6HhdrBEDNC0/0908N07T530L10k/ZD9n2bHw3O
         eAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjgVVeV7ye/lxK4uc/5lZilh6HVPNP9zhUrFloHljoY=;
        b=rB+JS4xomWM++FueCWrTlT+h7JBm43XSo9M1/ZCS9sy0u2IZfBMaQ/Cu8/2JoE1ZWy
         QArp1hbjRgmrFHcE6/nZaslKTHVNzGE3YUf9z+sGxapFz0/4n7Epg+yTrFHhkq4uV5qu
         CZ1vXHJqP381iKiui/ta5pxfW8Ocy5aBY/DQE7AfeoCM1tuXjCw2HJTdpWJD6+D5+ydE
         kQLpLG0P9EYhxxC2VEd1mvrwQQP0qrdW4WNC+5oK9ZrmOTlAinKV2gDVFleYSmyIKvNq
         PLMtbYS7EObjICV3PQTphJXSUv04TJ8lWtxUc7BwNkeanah2hiWA/SYh+kMgHXIjsXwS
         jCYw==
X-Gm-Message-State: AOAM5336CgGqaH8AHXsVFPIxebW6tbRBiyzQt6YL0bzNFKIaIqfZ/mcw
        GrzveRhh6fCcvmjl0Su3Xb2XdYtyZh2/Hw==
X-Google-Smtp-Source: ABdhPJxn1jygWe8e5NbQyYVmgVs/AYH3SpD/Jr2wU3HNRdujWIzFPvO7gGCMFzmnFMYiQOp2L9i/sQ==
X-Received: by 2002:a17:906:1107:: with SMTP id h7mr706251eja.481.1603439038734;
        Fri, 23 Oct 2020 00:43:58 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49b9:3000:d18a:ee7b:bff9:e374])
        by smtp.gmail.com with ESMTPSA id op24sm337928ejb.56.2020.10.23.00.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 00:43:58 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 04/12] RDMA/rtrs-clt: missing error from rtrs_rdma_conn_established
Date:   Fri, 23 Oct 2020 09:43:45 +0200
Message-Id: <20201023074353.21946-5-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
References: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

When rtrs_rdma_conn_established returns error (non-zero value),
the error value is stored in con->cm_err and it cannot trigger
rtrs_rdma_error_recovery. Finally the error of rtrs_rdma_con_established
will be forgot.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 4677e8ed29ae..ffca004625bb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1831,8 +1831,8 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		cm_err = rtrs_rdma_route_resolved(con);
 		break;
 	case RDMA_CM_EVENT_ESTABLISHED:
-		con->cm_err = rtrs_rdma_conn_established(con, ev);
-		if (likely(!con->cm_err)) {
+		cm_err = rtrs_rdma_conn_established(con, ev);
+		if (likely(!cm_err)) {
 			/*
 			 * Report success and wake up. Here we abuse state_wq,
 			 * i.e. wake up without state change, but we set cm_err.
-- 
2.25.1

