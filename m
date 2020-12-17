Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BFC2DD2DA
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgLQOUm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgLQOUl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:20:41 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1535C0611CB
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:27 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b2so28835020edm.3
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3RUukiGOKC64hIM5ZnyE1+UPMzjrvnMOxG9huIVLy+s=;
        b=cyvk4ONlbuLZren59o3vePOulE6fSjY4ydeDdtjmmjA4WdcgYzHJEGeWy/rwLAwdPg
         eWk6CHGdAnmsvHW24gQvBMnQlbx5Y7yEiKQ9ceJJCzrPQnsEt9RQMw9+djzfrY4K9Bzp
         P9D/BdgJQBxhkAFjaIR8K33NnDY7lue5h30ajtYUkdtcuuW5t8iShTrh59ZZr+I9HGLG
         D7WJjTyiiiLUg55h7z2b0EEos0J8XWNOJjrvYxqmsn+olNeeDIu5NZObT75vT9K0IpIE
         Opbkr08Dvyj09GbABgthYAQM/rI8dLuldRlED85Z5m9+OzmlfvMX4nexuCNdw8g8Yy9L
         eJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RUukiGOKC64hIM5ZnyE1+UPMzjrvnMOxG9huIVLy+s=;
        b=hFl/X6mKmWsb56NCobv97Z7MKQfV8OI0wrQgJSJ5LC8mmEcPxTPpwKCJckTXrmVjB5
         7OkyqouEoGUaLaao6Db7yIqrDx20wwQFb4Izr6AmQw+oSE7mIdpknk0VtZj3Ss/m8Ju8
         CLd/pcOSk5njXKbkSm2udyyTsWuyCE6Pa7B9xerudlpUoeylq2b9fCUZlD+C5Y4+qdqM
         X46YkHnSAt+gMBgQoXvgifzxK5T10pKp05ORdttGTBggat39AyadopmVHEnhmLmxsPQG
         iB+/BlmsJKX4he+eHGbyKvVneq3Odgkj5mOa221WqvKoes08EF759Sh52KSO8BFOj1rr
         3/+Q==
X-Gm-Message-State: AOAM531M4VsvZ4W1sw2vaU/obDBTRF2yEpXoe7T2yrrmk/ibRzdRUk6K
        8tUWzc56uqjai2Xn//1Fx3Web9+WSBe1YA==
X-Google-Smtp-Source: ABdhPJybPi0RaLJciyDOU6HShX2VgCj5ZGS0JTk5c5RJx/z5h+0+pnqHk7duox/1mMPCL0Dgrh7SVA==
X-Received: by 2002:a05:6402:1d13:: with SMTP id dg19mr38710184edb.111.1608214766375;
        Thu, 17 Dec 2020 06:19:26 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:26 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCHv2 for-next 10/19] RDMA/rtrs-clt: Remove unnecessary 'goto out'
Date:   Thu, 17 Dec 2020 15:19:06 +0100
Message-Id: <20201217141915.56989-11-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

This is not needed since the label is just after the place.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 6a5b72ad5ba1..d99fb1a1c194 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2434,7 +2434,6 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
 			err = -ECONNRESET;
 		else
 			err = -ETIMEDOUT;
-		goto out;
 	}
 
 out:
-- 
2.25.1

