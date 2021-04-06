Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724503552FA
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 13:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343627AbhDFL7Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 07:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343676AbhDFL7W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 07:59:22 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F0BC06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 04:59:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a7so21494533ejs.3
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doCHjXrIEyIxkGDp2qrSmqpjfoS5nKo5gHhnzQIaKpo=;
        b=Uyb43h+9vew5LNVPX7x4BdBiWc/wR/fBGkdytEyQ1EWdnW8tL/KJgH/9gSsOpk+sUu
         j2xYS34qN40yvibRT/aYi+8j91wQn3OSLAK4+TJegW4Hx6i/Lyl8998117MYNAQ/jTja
         n9M7VdHogK+xJ4UQIVGH9SCPu4Lam5idz+efKTagG0jVwckXKnXul0Uo4zCkqsiHTfpb
         SKD59JKYQpo9u4NAIs3hvXJY68jB6LlhtyVYdgS5YbJr/90Ya/QqbHZxpKL6o8XFaJea
         XlkRBEWU0pQR0+TUQSXFKcsIhkxECX8d/G6PvJ9HYdCe9ML9lx/AyHFjOQnsHuJX2wFF
         jLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doCHjXrIEyIxkGDp2qrSmqpjfoS5nKo5gHhnzQIaKpo=;
        b=qlYr8UhHAF2WOzhU6C9EkKHA1n3U11Q4vX6e6xSVd1Pv+89lEpDIpH+qjJ4rtKYhzv
         jef8OliKJMPN+cWyIm/DxvmLT61RXZCowaZXScJAKtFP98Z3FHSk+7KuEHk2BBch0iLD
         VTpfaJ/OyNFSG4o/TKo3I7B/T/qeZfrtBhY4ym3y9uD8JDvJyggRuue/NxoM+ZpqiElB
         0OcYbeAUizzYaf8FNgq9mTZVlhOhbjH69KiA77iF81TkE93aQKE+H+jEyxAQiE/NrC1F
         t5Ck2jp0pqqlgv8KC/NSfObYZtQzAG6F8gigHoOPi+aEIs0gHniUDpWzNDboQTTzZCAL
         aBYQ==
X-Gm-Message-State: AOAM533URCxEote94gKR8h9+Dqgk1Gntj8lU4Z+9yCYeUpcNekHMzzSG
        0FYmM24tc8fd0ejVnNUBL56jqZ87JJ9pmWjn
X-Google-Smtp-Source: ABdhPJz6diBdtmmZuSS9oB7nX8JrNy5riTDsZz9AtL61K9grSbVwxyxoCXcfiz12NeCoM5W6uLaBow==
X-Received: by 2002:a17:906:ecac:: with SMTP id qh12mr11572788ejb.427.1617710353095;
        Tue, 06 Apr 2021 04:59:13 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id da12sm3554954edb.34.2021.04.06.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:59:12 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH 2/3] RDMA/rtrs-srv: More debugging info when fail to send reply
Date:   Tue,  6 Apr 2021 13:59:07 +0200
Message-Id: <20210406115908.197305-3-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406115908.197305-1-gi-oh.kim@ionos.com>
References: <20210406115908.197305-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

It does not help to debug if it only print error message
without any debugging information which session and connection
the error happened.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 6e53dac0d22c..e11e91626b41 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -518,8 +518,9 @@ bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
 
 	if (unlikely(sess->state != RTRS_SRV_CONNECTED)) {
 		rtrs_err_rl(s,
-			     "Sending I/O response failed,  session is disconnected, sess state %s\n",
-			     rtrs_srv_state_str(sess->state));
+			    "Sending I/O response failed,  session %s is disconnected, sess state %s\n",
+			    kobject_name(&sess->kobj),
+			    rtrs_srv_state_str(sess->state));
 		goto out;
 	}
 	if (always_invalidate) {
@@ -529,7 +530,9 @@ bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
 	}
 	if (unlikely(atomic_sub_return(1,
 				       &con->sq_wr_avail) < 0)) {
-		pr_err("IB send queue full\n");
+		rtrs_err(s, "IB send queue full: sess=%s cid=%d\n",
+			 kobject_name(&sess->kobj),
+			 con->c.cid);
 		atomic_add(1, &con->sq_wr_avail);
 		spin_lock(&con->rsp_wr_wait_lock);
 		list_add_tail(&id->wait_list, &con->rsp_wr_wait_list);
@@ -543,7 +546,8 @@ bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
 		err = rdma_write_sg(id);
 
 	if (unlikely(err)) {
-		rtrs_err_rl(s, "IO response failed: %d\n", err);
+		rtrs_err_rl(s, "IO response failed: %d: sess=%s\n", err,
+			    kobject_name(&sess->kobj));
 		close_sess(sess);
 	}
 out:
-- 
2.25.1

