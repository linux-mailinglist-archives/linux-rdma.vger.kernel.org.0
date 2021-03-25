Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF56B34959E
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhCYPdr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhCYPdU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B1CC06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r12so3620739ejr.5
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g9GEKEx/zawMMQH3jE5N7jL7nSXjAaXut7/DjvpdxrE=;
        b=ccQUKXxhuMdqCfExCIcK1He+UfmaJW8Y9RjuoHJQamxeaNNvZogOnvRuS2Mh61ga+P
         5dsPKy3NgIzqeOnOSX0G1R9x89mqYPjrWjyQ8N8rS8g4/nz+cXzoXWasHTsniSIsqNRo
         YeA/2tsOCdY4BvAidGtFrl2Og5RsI3kEDGzj/zKgSheuez867u7g77gUzWSTkLO/V5ag
         jtlv8j7Jn+tR9CzVR0NV4q3qHqzvqxYL3w0yz8T/OAb+03A4xhXWBCoLG/FECjgcQbQJ
         /9P4QhzDG4nPTqjNaVxFTzWXXdzQ5Ys9Gzrs+eu7mI11S4dBzF6s0P2RTGAjVC35F50g
         JfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9GEKEx/zawMMQH3jE5N7jL7nSXjAaXut7/DjvpdxrE=;
        b=G9Kcaz1ro7/qKtHweXDEGadNypxuX+Jmy6FGYolxt/E0+nYZOsYlNT77/PbrCkGKPG
         8Zsr/iCFgsYu8HLdkXyj3CcowK1PCOFvBZmYIBwJjxWlX8B/wmBg58MSjjbnmvyO7oFx
         yI1onRNk+6Kixtp9QlkekssjG1D1OS1V2/GGiCsfjccgg704wxnFDH+TKRyvKdHoVofW
         cMMWzVyjTdE8oL7K3lp9zb8VzZlF3M3MOEriM23iy5HrIeUq0WwOUXEtzClmkwCnsQv+
         ZuwkWObbxXEwCjpq42iGIK3twsP9/R13B3j6SVuyYEv46ykrGQOMT2t4mB1hOWkTe9l9
         rJGA==
X-Gm-Message-State: AOAM533kwIysnhzbCTc56MgOg44kK569hY5Q4A4Fyoyef7/hiKIFaCYY
        9+OnxsEyP3uo0xTG1tnODHyFgnpYP82/KZjD
X-Google-Smtp-Source: ABdhPJyJrFJ6rssqZH7KnlaI3l5upBsMBery1EpBIE6S8dnFhkRMBVvX3u5aJ6hqMvATr6BSSPQy1Q==
X-Received: by 2002:a17:906:a86:: with SMTP id y6mr10322474ejf.354.1616686398875;
        Thu, 25 Mar 2021 08:33:18 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:18 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 07/22] RDMA/rtrs-clt: Remove redundant code from rtrs_clt_read_req
Date:   Thu, 25 Mar 2021 16:32:53 +0100
Message-Id: <20210325153308.1214057-8-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

There is no need to dereference 's' from 'sess', since we have
"sess = to_clt_sess(s)" before.

And we can deference 'dev' from 's' earlier.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index bfb5be5481e7..dd841121dc2c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1055,7 +1055,7 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 	struct rtrs_sess *s = con->c.sess;
 	struct rtrs_clt_sess *sess = to_clt_sess(s);
 	struct rtrs_msg_rdma_read *msg;
-	struct rtrs_ib_dev *dev;
+	struct rtrs_ib_dev *dev = sess->s.dev;
 
 	struct ib_reg_wr rwr;
 	struct ib_send_wr *wr = NULL;
@@ -1065,9 +1065,6 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 
 	const size_t tsize = sizeof(*msg) + req->data_len + req->usr_len;
 
-	s = &sess->s;
-	dev = sess->s.dev;
-
 	if (unlikely(tsize > sess->chunk_size)) {
 		rtrs_wrn(s,
 			  "Read request failed, message size is %zu, bigger than CHUNK_SIZE %d\n",
-- 
2.25.1

