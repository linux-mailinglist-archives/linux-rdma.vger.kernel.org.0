Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C726BE075
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 16:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437802AbfIYOpx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 10:45:53 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35006 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437125AbfIYOpw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 10:45:52 -0400
Received: by mail-io1-f68.google.com with SMTP id q10so14545776iop.2;
        Wed, 25 Sep 2019 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nAVrJDHIDBra40Uuy+AUfb+6zUJ3+jZrE+iUF3Dk0KI=;
        b=N1Wr3dxg1K5qGKh0yZEcC9dF1F1gc3gevxYHOg7ybqpWJvAd7y8ymsN0VnXvlNBwAk
         w/ZMRXwi6Fnc648J/ttWXTwE6meZc2zSY3ipcoQWb30bfajA0VO7zMXEEjlGCWpv8Z9w
         CN+iitFsXtvoDyYc/+6YsU2KA4OThlhq8XQ8IQIqTepUux0cwtCM91GQox5zpmrVBtTC
         HpEWxKzYUJkuImrjpaT6ePht9MhCqu+RRfgnriVHHKX14BaV316lo5M0LkR79t++0l8F
         QveO7RfZrgOau8iD/Ojs+lwxELBAkttFQ/r+0Sqtm+zOEjrrz+pyagX72gS/GmvDiwFk
         rzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nAVrJDHIDBra40Uuy+AUfb+6zUJ3+jZrE+iUF3Dk0KI=;
        b=cdwITw2KLYSCNTrLG5JOv1034qu3bDebQHzuZsWVB8e5gNbu1KklixK2RCTYS0LT0a
         PPGO7K0JYYEy1IAh3KFbd2331CRWl85CIZeiC9NpzGvGeH9KoO96wIDjw895X9yFGYOV
         JWKDxfxuCJiAre44gblB9WlYK2shVtkrbWZKsioReh3wZ/ka7aYCB4h4dg4Ir5oKfAq+
         4B6/xz2uFC6TJLId6zSnbAQH4JUwWCqxJinAkPRa8DEhOCzqIOWMI4fPdK+QXyY8724w
         ZrjzAZI3uVCmswZitzBUcp/3XGX+Y/qEK9Axm/RmS5Ra2zYvRhMDYF6VqJrnyJ3PWqtC
         8W+Q==
X-Gm-Message-State: APjAAAWsBg3a/1h/ajpz/dbVvma0a2z+oKvzI9m2pzpgOq4r0NKcSPll
        YTq8vCXNYvHRAAuKDEi8JxU=
X-Google-Smtp-Source: APXvYqwgciqG0jk2Z8tPYToMmFpz6Nd+M5UHoGUHpSWp3wEpe437YXczlA7Ik1I7iOiNMNzkkEBpqw==
X-Received: by 2002:a02:3f12:: with SMTP id d18mr1897410jaa.39.1569422751853;
        Wed, 25 Sep 2019 07:45:51 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id v3sm7174457ioh.51.2019.09.25.07.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 07:45:51 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] IB/hfi1: prevent memory leak in sdma_init
Date:   Wed, 25 Sep 2019 09:45:42 -0500
Message-Id: <20190925144543.10141-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In sdma_init if rhashtable_init fails the allocated memory for
tmp_sdma_rht should be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/infiniband/hw/hfi1/sdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 2395fd4233a7..2ed7bfd5feea 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1526,8 +1526,11 @@ int sdma_init(struct hfi1_devdata *dd, u8 port)
 	}
 
 	ret = rhashtable_init(tmp_sdma_rht, &sdma_rht_params);
-	if (ret < 0)
+	if (ret < 0) {
+		kfree(tmp_sdma_rht);
 		goto bail;
+	}
+
 	dd->sdma_rht = tmp_sdma_rht;
 
 	dd_dev_info(dd, "SDMA num_sdma: %u\n", dd->num_sdma);
-- 
2.17.1

