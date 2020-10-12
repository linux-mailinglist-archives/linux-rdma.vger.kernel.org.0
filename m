Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193CB28B5ED
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbgJLNSc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388160AbgJLNSc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:18:32 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A0FC0613D0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:30 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i5so16889692edr.5
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B1WTni9FMmqOxX6J8clKnzfWIzfNoMGtmaM+3RUD3qw=;
        b=WHzBvOUc9Jmvz9h3tqAlNKGcRqGSLaSUDgkk0xi04BLmFPpKwbKqT8TdjBx7ofanYE
         zhvIvzSAoiEa9fwXhFr3jeSrawKt5IV38+bYRWhjMvsRbYB3hMZK9TEC0QYf15o1TJOM
         le5Zz1ivCWo68FJNAjESfSARCxqr149capqbwLep0njSzIBnKTo6TuJTLRR0V42zknix
         zG77EYuN6sqhVfmRYbxFoofAYSuAASxNGhXQ/T67u0EXZ5Ex5GIlIoQk54k4DuQhgHGH
         /uBOrlKVqzmbbCN38GeRsmKUMPFJByiFyQ5MS2GST/dsfF8ON9jEp3hKIdNgbJ9oI5o7
         vtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1WTni9FMmqOxX6J8clKnzfWIzfNoMGtmaM+3RUD3qw=;
        b=nVq9tphWHDjjw1ohT+lC0BBt0aZIWBB1LVzBheltgitAmMJb5frAsnjn6H2BumugBF
         H1ZaHplfJPgrj9jrGnsRZOAXnRv760uLd/2ei+F3hBTVw73Lv+U3m4uPTCZTDzLeZFVx
         TJDDf6/p2KrRjsFHYEV81wIqqTXjaL8yrVLxVGNys7h97MXL+2r3EdWc2+HpF0sT/wxq
         k3cGj28eFdB+og3CXG+Sl5VtW3IAsoUVTaRb8xNFui+t6yaEgTvSiB16lmazRhrndF4P
         vsbHv+DkPA0vLOMAswl3Oj1ib/bNzoH9UeO808h/1vKgVgqu0AdpMMO4NrXf0P9Izknk
         jdpQ==
X-Gm-Message-State: AOAM532IyiQ4Ydv4tN6vudBh9leejF7B3PrFoyJO6dpENq2UeMa99Qyq
        5sKi8QT8NcpybKIUtco0x7QHPy7NyuTQzg==
X-Google-Smtp-Source: ABdhPJy0EB8wEWyxUjxbwzf8ZsupJ259c0rPZ6/SqRnrTIka5ogo+v5zkvGmXu/Z1btz88gQt8bMIQ==
X-Received: by 2002:aa7:c98f:: with SMTP id c15mr14350861edt.200.1602508708867;
        Mon, 12 Oct 2020 06:18:28 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4915:9700:86d:33e0:2141:a74a])
        by smtp.gmail.com with ESMTPSA id o12sm10828252ejb.36.2020.10.12.06.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:18:28 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH for-next 13/13] RDMA/rtrs-clt: remove 'addr' from rtrs_clt_add_path_to_arr
Date:   Mon, 12 Oct 2020 15:18:14 +0200
Message-Id: <20201012131814.121096-14-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
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
index 102df6898339..a9f1dc3295c4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2154,8 +2154,7 @@ static void rtrs_clt_remove_path_from_arr(struct rtrs_clt_sess *sess)
 	mutex_unlock(&clt->paths_mutex);
 }
 
-static void rtrs_clt_add_path_to_arr(struct rtrs_clt_sess *sess,
-				      struct rtrs_addr *addr)
+static void rtrs_clt_add_path_to_arr(struct rtrs_clt_sess *sess)
 {
 	struct rtrs_clt *clt = sess->clt;
 
@@ -2930,7 +2929,7 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
 	 * IO will never grab it.  Also it is very important to add
 	 * path before init, since init fires LINK_CONNECTED event.
 	 */
-	rtrs_clt_add_path_to_arr(sess, addr);
+	rtrs_clt_add_path_to_arr(sess);
 
 	err = init_sess(sess);
 	if (err)
-- 
2.25.1

