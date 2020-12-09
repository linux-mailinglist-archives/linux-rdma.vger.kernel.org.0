Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7BB2D4706
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgLIQqa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgLIQqa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:46:30 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EB5C061794
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:45:50 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id f23so3080299ejk.2
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+WulD6e33SdYGyVi0ara7vlGG7jOds3Zvo+vLhCU0c=;
        b=Kqw2U4ne8YDvsq4+ie0RihtatdFU9j0Odz6iOgr/JKQbNKhZ73sQw9eI9PKKVmvFpm
         RD/E8m1vIBx/N/QhVSxj6yfgg5f6/QF+jcmdMq0u7shd37SKx9yWiVFYwYu4WHynEt0r
         dHQbhCAzcVrN0fN5vKlYvac+2BIFtcgpz/ER6x5UASNAbzj3LOqGK+zg3Fwra/BZcdtt
         DJ8eyQ8TnJFVvR6NL64TJCbJWPwnzM+mzH/YvMuGcTITy3UaloRL1JJH7ch//W9iBCzG
         cxeCsiZHaCT5gdwkGme2Zbnmde8m+WKZKBnONpnlyWHeoUv045I/iFDi2Pz48+VxxATt
         O9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+WulD6e33SdYGyVi0ara7vlGG7jOds3Zvo+vLhCU0c=;
        b=r/KG/aNVq4mwvMN32+zFBQ7big2MohRg7xm2ehicJuMeVKSWGL9OzRCKdcqJSHfKSN
         Q53M7ln6L59LGJRt3qGFO3jfUuPKFH49GG9+aiEGrRMh/FZvqprmZzq/bC6NDgNvCyx+
         OPsvYfZi9+62ep2gvY65OKF0GqAPzTYGBamljdnPQddnuQ65pRygpTuvEU4TQNFNRwKn
         T470jQG18eL/nXxMV2jOnP77wquVaFW1BvPPP8zwJVK9ciAoCWglF7D5FYZjeUJdlNDm
         93G42fw40Nr3JbKRNiKvPAuQLjSx86kfWxlR/HCdd0M+W89+nbHXMHqYb30Rjfdvra5F
         jvzw==
X-Gm-Message-State: AOAM530DyVGP0p9BLJo50AHDKL01Y0NqFPxUo6CrWrQN7be5o8CrmYbX
        pKIlOu0wr47iwpLBzraTQJZPgn95GoYpJA==
X-Google-Smtp-Source: ABdhPJwOI6aeUFDtIAvq18tGidUm6jF3ELAaGKlRUlvKHncp+31kKPiiBdkwks3QfQAkPBrNXZW1cQ==
X-Received: by 2002:a17:906:d10f:: with SMTP id b15mr2721003ejz.268.1607532348458;
        Wed, 09 Dec 2020 08:45:48 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:45:47 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
Subject: [PATCH for-next 03/18] RDMA/rtrs-srv: Release lock before call into close_sess
Date:   Wed,  9 Dec 2020 17:45:27 +0100
Message-Id: <20201209164542.61387-4-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In this error case, we don't need hold mutex to call close_sess.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Tested-by: Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 0a2202c28b54..ef58fe021580 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1867,8 +1867,8 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	return rtrs_rdma_do_reject(cm_id, -ECONNRESET);
 
 close_and_return_err:
-	close_sess(sess);
 	mutex_unlock(&srv->paths_mutex);
+	close_sess(sess);
 
 	return err;
 }
-- 
2.25.1

