Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3BF2D470C
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgLIQrJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbgLIQrJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:47:09 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C63C061282
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:45:57 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id x16so3058661ejj.7
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qy3ygq6w7O8DF53aV7q7DOLXGPF0OfN7MeSVY+w05wM=;
        b=P8yhX7tIpAX0zTWE6Js14kQ4vvoQu61Iv5DCKambWh6xLlgatcXBEn01/CoUd86j5s
         lsvue5aqXAdssfptBBi08SI0e9XA+e8n0MNmFXJeZQoTGaz3VdK/N18s/hpN49J9ax2Q
         FXjVudeDk8yYHMHWOcoDdVEXrMrMS30pa0Kq+XCsX39E8eJr5T79ISkiY0/IUyptohqU
         yGJP23A8tsgJwRUkG5ExWc6yQe9mfRjZ5K2XM1p3SF2BHcliU6/IL9H/SutjfKhxgvP1
         ef+2DmAyExn8UycmzwP13dgG1MKJXyiLa7VSPkO4Pddpc/AJpVVJ0O/Bm/VrvKF5cLk1
         1Rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qy3ygq6w7O8DF53aV7q7DOLXGPF0OfN7MeSVY+w05wM=;
        b=gzz7z7w7OlFwktWVYhiYHz8DbeYEkUxrg+ICxlrbwTjh8AAcBQqOH6cGvMdVBpP7Do
         zD7uaw5d0SLd9NZlidN9JQTUHEZ8FddHwBygd7r4AXIvaFHiAocI26gzGYIy8MuMaeKD
         HKkN6pc/ar7eIfn3P4pyLiplwO27MYVGNxrr0leFFA94FauQwoFTR9fhcUUVYqfc6Bnc
         9nuql3jtrFn0YydD8ttsRhNHjk2g42uKKoWCKKMDTdMMgHSD4PfrLn1uFtFMVvv2uf7n
         PBqWZPEvb+LTVOixM9Xh2c0TqlTIcaKYmymHxAb51TGjXVhRFdHwYl0M9XKPHIFi7Kdz
         jSOw==
X-Gm-Message-State: AOAM5312ax1TYmdltvayyrukFd53tiK5P1FQA9l4PP1NfquHJAZVyrGq
        ZWNmOf/VLaBM4d5Fuy6ZbzPIXmr5bqS4ew==
X-Google-Smtp-Source: ABdhPJweGwFwmW0nF/+f0AO+Wyf+8tUNsfV7eUKm8IQ8pntsG73tM4SObKsSqsWQOeMLjLSiPpX8Eg==
X-Received: by 2002:a17:906:1294:: with SMTP id k20mr2754707ejb.404.1607532355835;
        Wed, 09 Dec 2020 08:45:55 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:45:55 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH for-next 09/18] RDMA/rtrs-clt: Kill wait_for_inflight_permits
Date:   Wed,  9 Dec 2020 17:45:33 +0100
Message-Id: <20201209164542.61387-10-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Let's wait the inflight permits before free it.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 99fc34950032..6a5b72ad5ba1 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1318,6 +1318,12 @@ static int alloc_permits(struct rtrs_clt *clt)
 
 static void free_permits(struct rtrs_clt *clt)
 {
+	if (clt->permits_map) {
+		size_t sz = clt->queue_depth;
+
+		wait_event(clt->permits_wait,
+			   find_first_bit(clt->permits_map, sz) >= sz);
+	}
 	kfree(clt->permits_map);
 	clt->permits_map = NULL;
 	kfree(clt->permits);
@@ -2607,19 +2613,8 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 	return clt;
 }
 
-static void wait_for_inflight_permits(struct rtrs_clt *clt)
-{
-	if (clt->permits_map) {
-		size_t sz = clt->queue_depth;
-
-		wait_event(clt->permits_wait,
-			   find_first_bit(clt->permits_map, sz) >= sz);
-	}
-}
-
 static void free_clt(struct rtrs_clt *clt)
 {
-	wait_for_inflight_permits(clt);
 	free_permits(clt);
 	free_percpu(clt->pcpu_path);
 	mutex_destroy(&clt->paths_ev_mutex);
-- 
2.25.1

