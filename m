Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1FD371482
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhECLtX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhECLtW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0724C061761
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l4so7361039ejc.10
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yE/rvzHkZGy1N5Z/cqUKjEOF4LLSvM26nBzknaJPIAM=;
        b=TV+RzRHMMkGxxenw829C1sFdMY5uNOE0alRQZzmz3gjIzT7JHCs8vWkQxvAC/rM5lY
         HDeI884vto/HhZoVS3oRxtuen1CuhU0WgeIBjyf3yaGL8UDdp1kT9GZA45FW57cIDgre
         aueM6mw30NXppHlbc1ox6tGwkCRfW0LK2b6LXmJzzEwKsfzBF2dPlgLRF6QSJAIYZL4i
         Odd6Ij/GYmxwDUC05gwBr7tFazhXON6U8RhKwOCNg7uObnSXzNl7qB/RffGF8hvrPd2M
         Ogk3dgURi3J53261bLMFzokrWqr9Of149UFdPYqINb6UpTjo84vFmHIqqB8gNjPHw8LZ
         cETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yE/rvzHkZGy1N5Z/cqUKjEOF4LLSvM26nBzknaJPIAM=;
        b=MqXDl8HfWHrpKrdVaNB6umvJJ+ZgjhmTN9BdELQYXHjZh//ZQ0gEWeW+Ch8srYu2lY
         Sod19Vmw7vwf1NyuLWkTYvy/07U9OJNMn2+WDMS5edGnlg4glwMGP10swAtqikCohbs6
         shAEz6LTv9m5JOdSinReOH2QW6w4P80t0D5V9pUcfKMuK3+coR8l7TXEAj9Xz/msoJJw
         Qy+2JfXZ8Ao3btEW/jV5YPPRXwFbq8VBqqE53Ps3K5bbU8iZFPzejnKqFabdyG8Kaoyy
         n/MHae25rDGYZgtJ8lRG8IEUuV/KDzGV4c3ZRheQMYEak5IRa61QiIB6RbXv8JYxlAuH
         dkrw==
X-Gm-Message-State: AOAM531nwm/CLeEAjOh+u+RejXhDyLAO+LKcNgRM4sZdYxsE6vmmGtFs
        RKuV9WnLhjVzdKumWn6Aq7QInHoz1LMhSA==
X-Google-Smtp-Source: ABdhPJzyfcLeUQnldXjlCbqFOiQ5uPox1rIQV6S7Ve6vcgRitVssLEXsnBbejrWv/ww/jY1PafJr1Q==
X-Received: by 2002:a17:907:948d:: with SMTP id dm13mr15976194ejc.180.1620042507309;
        Mon, 03 May 2021 04:48:27 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:27 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 09/20] RDMA/rtrs-clt: Kill rtrs_clt_{start,stop}_hb
Date:   Mon,  3 May 2021 13:48:07 +0200
Message-Id: <20210503114818.288896-10-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
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
index 5ba87862a251..76040f6c43b2 100644
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
 
@@ -2082,7 +2072,7 @@ static void rtrs_clt_stop_and_destroy_conns(struct rtrs_clt_sess *sess)
 	 */
 	synchronize_rcu();
 
-	rtrs_clt_stop_hb(sess);
+	rtrs_stop_hb(&sess->s);
 
 	/*
 	 * The order it utterly crucial: firstly disconnect and complete all
@@ -2275,7 +2265,7 @@ static int init_conns(struct rtrs_clt_sess *sess)
 	if (err)
 		goto destroy;
 
-	rtrs_clt_start_hb(sess);
+	rtrs_start_hb(&sess->s);
 
 	return 0;
 
-- 
2.25.1

