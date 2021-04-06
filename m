Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF8F355454
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 14:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243382AbhDFM5E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 08:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243376AbhDFM5E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 08:57:04 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04F4C06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 05:56:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u21so21743318ejo.13
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 05:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phdW3EKeG62xJ5V2/ZsuufmrviD2OrwartQvXb73f3s=;
        b=K1TrXGaoLawZjLrko5cH7hbj1aox+6CKwfuNzuKRFieK28YijF8lnw2i74DRNumOAr
         +qtzU+4njmvVoKJ+EMiuRfUZ8vf+Y826yMeVPmMh/HvnpjANCrZt2e4ObzEeyYlSXXoV
         qdiVKu6Boh7LIgHNdeN6+OhTnqDhpHL+2hVQ6jnyfhFNU8jUwEtLOjLhlJsrOkQDFapi
         IOWJAUbB0a8MgLw32k6nKjbhvuxSOqMhpZVM7/HemSW/XFi/7S3JcNuMXvpEmPC9Feme
         DQE/xJQ+N4THXAXqfMW19YkiRz/ipvfWK+dIqe/tf+ZBNJxqRSlZtofmPAjkkie6LaB9
         NFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phdW3EKeG62xJ5V2/ZsuufmrviD2OrwartQvXb73f3s=;
        b=UoT57p2lob1vzvUE4kDIa2ho5m6ex3i98/9eO7hofQGEc8oj5XtS4IuKzIufC1H7Wn
         bHclqoTwKHGWsAc1wfvjaR8ms/IFUleaBg46pyQTPOkovkQRkR9gsW0gZ6ylJYseF2kI
         6PUy1qir9ly1sC2Ud/XDctWLh5mN9A56XyfJpuwTblTKlccuYp8eKk6qjcIC0ewlUcOd
         B7Ac7aF/m+aIlOs3mqWH/LqMgn/HRdRIh3w+ZZca72MHnF7RyOjZw397vzdTvT29I1HW
         IORqe9/SVbnLiijef5mST3DA58Vi4hED/uHC0MrZW1/8UGXI/1a0SycR0PBVB4afk0DF
         EAbQ==
X-Gm-Message-State: AOAM532c3Lt3Wblmfxrm34banxBLaOpLEsZQY/XiW/jPWmUN39Peet6+
        tElliDTsTZSdR/uAKMZSjZptfjAhA1eRqwWq
X-Google-Smtp-Source: ABdhPJyQ1HN0znZodG2GAxocBDV7Hv7X+rleXNg04LZIFraVLnzSBbYCrnEx5hQYu91eAQrQq1K98Q==
X-Received: by 2002:a17:906:845b:: with SMTP id e27mr11813682ejy.39.1617713815294;
        Tue, 06 Apr 2021 05:56:55 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id hc43sm7741161ejc.97.2021.04.06.05.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:56:55 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next] RDMA/rtrs-clt: Break if one sess is connected in rtrs_clt_is_connected
Date:   Tue,  6 Apr 2021 14:56:49 +0200
Message-Id: <20210406125649.204623-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

No need to continue the loop if one sess is connected.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 5062328ac577..1b75d2e4860e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -51,7 +51,10 @@ static inline bool rtrs_clt_is_connected(const struct rtrs_clt *clt)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sess, &clt->paths_list, s.entry)
-		connected |= READ_ONCE(sess->state) == RTRS_CLT_CONNECTED;
+		if (READ_ONCE(sess->state) == RTRS_CLT_CONNECTED) {
+			connected = true;
+			break;
+		}
 	rcu_read_unlock();
 
 	return connected;
-- 
2.25.1

