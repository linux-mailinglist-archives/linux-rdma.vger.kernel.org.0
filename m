Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C671E2D470D
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgLIQrJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgLIQrJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:47:09 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514DBC061285
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:45:58 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id x16so3058757ejj.7
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3RUukiGOKC64hIM5ZnyE1+UPMzjrvnMOxG9huIVLy+s=;
        b=ERYkXltTsA2Kgi5mUdiKzeIbSWuL24PF6DHocmyjBmJPC1JZQj7yS3FNVYpERsyHzN
         zO45WxmMOmjJIqaeDs6HehrLHfCDz6PXIdIVm7IMd29Yvj02Wpc2ipc5bgQM0e+sfdKY
         abE0zK2dbo62l6M9hJilIAHRc2RdyVL5CAkOiPAtvosQkAfS4hycm3YKQTNtyCxF+R+8
         qgTtTZBkzGSGyTzeSPOcav1abSIBVGVMbqtqJMstOiU40miXJqBojpHi8z5ipEH8xnvE
         8/Q7du2tpPZfdVBBT2HGZOk/lVg+yvqr4FFfdizWJMT6Wlxs9LYNBr1k1ujw03PjTlo/
         613A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RUukiGOKC64hIM5ZnyE1+UPMzjrvnMOxG9huIVLy+s=;
        b=ikVRo8QGC/oGf4pmwx0lH0JWppGLImLimJp7/eZ3GB8FuO8txe14PRjVBIj3sxfYXX
         aN2FbTFWR3KCS86DLOo/NwcwrrOwrL5LQsFetxcVXnmaPnDH50t4sbhPk8+UAy2itkuA
         Tfsxdqzp8W0Fh1+mORklRJ3cTfXVyYM+laj2TTNDREwCxwqktA9zDYT3gKPFjbojX9/X
         pMXLYtXrPFb0GcNLmkq2rt6bC2wWbhLoJ62SN7aag6pgW/gObVU3AcDWP5gZVtzkyOQi
         YrnW7Wi0mSd31uNqnT4V0zkeKvgtGJVE+C6aVDIiR9QqOouqr4/BPHrlmPP3P6+ZNnyu
         QSzg==
X-Gm-Message-State: AOAM531Ah+BXl3nHC8bNLk3JeSBCCTUHThnCs3IxN5CPMZt5tx5zCg1+
        5XWR4MwydeHc/1P8DQCUNuaFFDG91soqow==
X-Google-Smtp-Source: ABdhPJw6aROIFtl2IEv8C3z8YWgDI7GgmGCW3zm2DpeDmyuqrTx2BZSdEh5d0SxpV9hdm0cfIr0YDA==
X-Received: by 2002:a17:907:20a4:: with SMTP id pw4mr2730686ejb.499.1607532356906;
        Wed, 09 Dec 2020 08:45:56 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:45:56 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH for-next 10/18] RDMA/rtrs-clt: Remove unnecessary 'goto out'
Date:   Wed,  9 Dec 2020 17:45:34 +0100
Message-Id: <20201209164542.61387-11-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
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

