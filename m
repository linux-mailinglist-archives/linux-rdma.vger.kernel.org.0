Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895593941C8
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhE1LcL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbhE1LcE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985A5C06138B
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id df21so4477669edb.3
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6sNxd83hFhEZUh1S6gveGbG3IqoLQunL0auufAbUjg=;
        b=La+ouytXrKrOGSidxeHfO2uWKLC8xPOV5igXjERptS771qwR8qwKKmOYZgYE8IJaEk
         raDfizovayjV179A14LvQw/uVIZroCdyXPCIpv0weMFNfTatGtvpvoXHq0bRrQr3XfPW
         Gmv04gnbFfgdlJwmNMrHDr3ZQ/mro5ycmY86egP4bfoFa9DYbdx2eFbgvhV4oPai2okt
         aAP0LB88LPn6GD4eq1BNd80vq6Yxy/ckLDB6AJ4An8fF7efLcxJoM6xKIgbnrfpcnycw
         Mzr1+b633BRxNgmrCJrsq5Z40QjWTEPLrd34JRHujN/EfEF6JIbFIdnbiMTeaSohWSJ5
         twow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6sNxd83hFhEZUh1S6gveGbG3IqoLQunL0auufAbUjg=;
        b=EnzZggGGzUe/7O1NG4WYapLtjsIKIWtezurCeTRnqbRADKMJPIynBZlOnMUy4TCPOU
         mdq7bd4zOqO9WCH1C944eKcAQeXBLJLqxjTlG8asacoKG1dHbWHI7nqE+rU+VNiC7A8i
         WDujGeRR7DyfPZZ7DTapVMe0oms6BFBWc0OqY4rhnVj9a6vKyGKDwU2nfPFl4BZiPTTK
         fc1bA6LQasYTHcSvKOqzCaGmnOUeZg1olevYULfzC6ezLG3JNgv5B6CwsWShip2sWkWp
         Vppw6rxzRSA0Q9Vnww7MdsOuT6e4VNkvH0n2fAGMjFuMyypGslIEFoxhQ75NZknDRL7d
         rgng==
X-Gm-Message-State: AOAM53031tQentMbQrv9BlJoiJl1Q9eZARzHYByo8wnGzFDFG07lVWAU
        F+8Y6dZvucoKwHFt/bxYaA9NdlSBDGenMw==
X-Google-Smtp-Source: ABdhPJwmi38TKnLtvyZGcoxkOPtliOLeaV3WjRA4xcwEFbCdRLka6PT/9sTOVhPp+hFNU9w9yA1b/g==
X-Received: by 2002:a05:6402:1a:: with SMTP id d26mr9588934edu.105.1622201426652;
        Fri, 28 May 2021 04:30:26 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:26 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 08/20] RDMA/rtrs-clt: Kill rtrs_clt_{start,stop}_hb
Date:   Fri, 28 May 2021 13:30:06 +0200
Message-Id: <20210528113018.52290-9-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

The two wrappers are not needed since we can call rtrs_{start,stop}_hb
directly.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index f2005e57ea53..e34d5eadcfb2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1449,16 +1449,6 @@ static void rtrs_clt_init_hb(struct rtrs_clt_sess *sess)
 		      rtrs_wq);
 }
 
-static void rtrs_clt_start_hb(struct rtrs_clt_sess *sess)
-{
-	rtrs_start_hb(&sess->s);
-}
-
-static void rtrs_clt_stop_hb(struct rtrs_clt_sess *sess)
-{
-	rtrs_stop_hb(&sess->s);
-}
-
 static void rtrs_clt_reconnect_work(struct work_struct *work);
 static void rtrs_clt_close_work(struct work_struct *work);
 
@@ -2098,7 +2088,7 @@ static void rtrs_clt_stop_and_destroy_conns(struct rtrs_clt_sess *sess)
 	 */
 	synchronize_rcu();
 
-	rtrs_clt_stop_hb(sess);
+	rtrs_stop_hb(&sess->s);
 
 	/*
 	 * The order it utterly crucial: firstly disconnect and complete all
@@ -2291,7 +2281,7 @@ static int init_conns(struct rtrs_clt_sess *sess)
 	if (err)
 		goto destroy;
 
-	rtrs_clt_start_hb(sess);
+	rtrs_start_hb(&sess->s);
 
 	return 0;
 
-- 
2.25.1

