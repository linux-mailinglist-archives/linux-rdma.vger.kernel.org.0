Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0622D471A
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgLIQrr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgLIQrr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:47:47 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A64C0611CE
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:46:06 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id x16so3059366ejj.7
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Tu9uEebi7AgTLMoh/8fJzo59NxyxXxaWkQigCjrk4A=;
        b=IKI7Rr3G+9EKmUPvgJjQGAyA2ltuvOIUgoGWKTtU3xP9Lb1xwpH2cK4fpYRHRf615i
         /IK0XcatOT8kHmww4gpO99oR/v0CD9JVxJvBj64gfIqCRB+e2utfpRp1gq35qmPu3wY3
         pt+JfAF1Fyfd6IYfo4r4WEqIWy+vSaljVUGTLFpQaGRZlXXvNH32R07G4gL4YNLPlOCw
         tSYZCdNpNRoaQUWa17dfE2LT/yUxPVap5cUts9d5yDXy1KyBHwNi6VDYL561kiIRAC8J
         1UKTp3CTCVIWjrnIMDzDfMhsuU5BG4OIVl73rRU8uGEYXBVGGKS8aC1Q4Vpr93BJgO+6
         QVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Tu9uEebi7AgTLMoh/8fJzo59NxyxXxaWkQigCjrk4A=;
        b=aO2umORAKbeJQZ5CicKCAzo+PsGZs8OyDzNWFzb4gqk9aIBeZUGYBScqGSjbdXD5mP
         qtjgevv9IAznY00bjWBW2L8eGpbMTWv3Be4vmPL8QV1+c1K9wJFGkRwPCUJaxDgjOs/U
         CD8Ax3AyxZY2j1DVe8cBYNIzxIAs6TYvBL46DMFP/dsfaX9BmwmZJlOUV5mJeeV0LSPG
         ir0S5ev4c9X9Aibt+cvAUxei/UhFVcO8sS0iTIU3llpjwBKT8hr/dU3l+24aRV5PqerH
         gRVjIyHsaz8xY4bwaNd+pwq4s3nDDl5b8KVmVjBxXxq01QLbtL5AQpy4fH9iv5cJpnjz
         oU3g==
X-Gm-Message-State: AOAM531NFsGQKoQSFGxnFJhOa41EfbYg0RiCqTGAwMYa9ObHyduL8AQT
        dR3lISrbxjLEbAeQlh5dU5Fivq+vcJyfeA==
X-Google-Smtp-Source: ABdhPJyvMDeeYnF8ic22j0cOS7dWpc5e34Om/ffHyJNsdoPE/g7zT/C9CiQxYjI9t9Ek4CQpxsKspg==
X-Received: by 2002:a17:906:a183:: with SMTP id s3mr2914121ejy.60.1607532365339;
        Wed, 09 Dec 2020 08:46:05 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:46:04 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 17/18] RDMA/rtrs-srv: Do not signal REG_MR
Date:   Wed,  9 Dec 2020 17:45:41 +0100
Message-Id: <20201209164542.61387-18-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We do not need to wait for REG_MR completion, so remove the
SIGNAL flag.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 5065bf31729d..8363c407ab4b 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -818,7 +818,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 		rwr[mri].wr.opcode = IB_WR_REG_MR;
 		rwr[mri].wr.wr_cqe = &local_reg_cqe;
 		rwr[mri].wr.num_sge = 0;
-		rwr[mri].wr.send_flags = mri ? 0 : IB_SEND_SIGNALED;
+		rwr[mri].wr.send_flags = 0;
 		rwr[mri].mr = mr;
 		rwr[mri].key = mr->rkey;
 		rwr[mri].access = (IB_ACCESS_LOCAL_WRITE |
-- 
2.25.1

