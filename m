Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFAF296A7A
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 09:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375778AbgJWHoI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 03:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375775AbgJWHoI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 03:44:08 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12402C0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:08 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qh17so1047001ejb.6
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MSVlZYGl3MWtTRqU1euC5XK0zC3yaVL2aUUV00m8iRw=;
        b=EvpUltxW553RjPcT6JDcm71PEg0Dj5DOFbTEqzyyJLdbJZBK3bLmiofbgdyxr0E2Bu
         8tatyXG8GVh2yhwuxCy31N0AyZ7nL6xyIiW+ClTZgs31HfGgP+xFNJG/QGbuE4x5f1OK
         /4jJjlni0Jv0PILAY5RIPeqwSU7HRWU0eUyrFwMmJAaDOii6KFbGkI2tlYOLTV9vwXbY
         clvlnmLo412VZawLW9kaE883XjEN3AGFCon9JSFT1WwkpuNY8TkdJUDYbY2m7dGAA7b1
         Zz/gnpNlJu+0xeEY1eSdfUzKrcd00Phoncp59RYfBGUZ+Y23Ilump81YlZR2id/662Wn
         0ezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MSVlZYGl3MWtTRqU1euC5XK0zC3yaVL2aUUV00m8iRw=;
        b=WL1yDxcKw0qRd/JAH9uzf/71yM6WEMtepKeP940svoxJsCTgZClieCIYmxBpgy/WWI
         TG5GkrbUPy859yrm8uXEga+GBDdEJQ15UH3J01mnpSK2xphbab/GuOxfoczN+59ZQ3Ji
         IJaLwOz0Jk199vhpXszQPnZ8CVqy6WVA4zExyZ63hFmLswnfkzARykDlCCgz6t2eXGFh
         voWdc9SOMhFtqD4VWuGToLrxwB0GSQRjnd7jQa8ITHvEh4ESS5TjOhMc11bm9Hm8ade/
         7lgUVK0/ZGkk+zdEedn0Qy7b3YBL6JEfh89uws7kKIhDR6xmGU+Fx8w6IYe4RkjbHBp7
         InzA==
X-Gm-Message-State: AOAM533v8+r9oooBNpZGNt9D6WushwEBD6S5chwhj+rOa5FM3jIZpMen
        AwxOfLADq7nNjmxN0beASPoCr8K8eqinSg==
X-Google-Smtp-Source: ABdhPJx9qyrCCUXHax25RROmYlduEYpVoujbkzW4ze+2KLky9Fz5wlVeptV+sel+srCkr4JMO+2TZg==
X-Received: by 2002:a17:906:aec1:: with SMTP id me1mr768531ejb.225.1603439046601;
        Fri, 23 Oct 2020 00:44:06 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49b9:3000:d18a:ee7b:bff9:e374])
        by smtp.gmail.com with ESMTPSA id op24sm337928ejb.56.2020.10.23.00.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 00:44:06 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCHv2 for-next 12/12] RDMA/rtrs-clt: remove 'addr' from rtrs_clt_add_path_to_arr
Date:   Fri, 23 Oct 2020 09:43:53 +0200
Message-Id: <20201023074353.21946-13-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
References: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Remove the argument since it is not used in the function.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 1b2821d71b46..9d359c8f2f81 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2161,8 +2161,7 @@ static void rtrs_clt_remove_path_from_arr(struct rtrs_clt_sess *sess)
 	mutex_unlock(&clt->paths_mutex);
 }
 
-static void rtrs_clt_add_path_to_arr(struct rtrs_clt_sess *sess,
-				      struct rtrs_addr *addr)
+static void rtrs_clt_add_path_to_arr(struct rtrs_clt_sess *sess)
 {
 	struct rtrs_clt *clt = sess->clt;
 
@@ -2937,7 +2936,7 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
 	 * IO will never grab it.  Also it is very important to add
 	 * path before init, since init fires LINK_CONNECTED event.
 	 */
-	rtrs_clt_add_path_to_arr(sess, addr);
+	rtrs_clt_add_path_to_arr(sess);
 
 	err = init_sess(sess);
 	if (err)
-- 
2.25.1

