Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E7E28B5E9
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbgJLNS1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388160AbgJLNS1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:18:27 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4ACC0613D0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:26 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 33so16828929edq.13
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2TUjEk2WzlxSK5DdNDdO9Tl/sONKN92hcjKxyFdyhpM=;
        b=ihQM3NAjTaciSAJuiBXnuZyqJMy2QO2Xl3WR3tVitBFgN52TqjtQ+3gfW8OiZ1qK2l
         boLCUjktEvPZmyndW3naW9r1b5Ovn45z7k/1LfrXUrldHc0B2O+7x2j76dbLxLEITHTv
         XqBE0w43BaSo313Za4U0JPzNePgw8w0vkDEpWl3N8O9IStHtQ6eKHuQ60TpcxL9xJUXU
         qlV+yE/gj3/QxaUxGaHpJtMY6aX2Zqn/4uZRlrjoTI2lRqIgPSB87bxnpf4YhGKgIpWL
         Jb6J7zqAyouCfTVnVrDmtM0pm1IAVd4ASIb6oGKhghkI9YLfY0f1GMPJiyUwDwudnnt7
         zZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2TUjEk2WzlxSK5DdNDdO9Tl/sONKN92hcjKxyFdyhpM=;
        b=gSF5swkVhm4/kKxYxYLG5MfwLe8byBVNOyHhbQYOn9ObFc/lffKYNCli0OMM7vQ5wP
         o+Fbc+c1ZkAPulC0E8toJmUpKqwfx4xv5kmry1Canl2ijUQCv1yZxSv/soepr1WZcORN
         CdzvZH43+x670I7nf2h1P74iJ2l5C5mmZjKHFgKw3YH1iWR9tWY2c2Catgc1ujDSftYW
         CmKMlETpZGjyjh+VkKk4rGqlNrD+wZ/bXAVxyNe6arDZEvRc3rI18hFVxSLxJAe6xDVj
         u/fXmcELKCTn9EHSPK4A/bhbBLgG15NINozMFcHk9bwIe/UK7xlJOgjp3vI6knsJhfv+
         uGTg==
X-Gm-Message-State: AOAM5329L94ILqJ7goMr+l7WQkPhF6Mj9x/D9VesAKQbJPh/K7oyTkTY
        QVn8CY0a6uEluRIpB9QWuGJ+vNlWZ9rKRQ==
X-Google-Smtp-Source: ABdhPJy4O+UVsqYzVBii0M/PL7Ge8y9dfjFONWbcaPxp1imGVyCjyM/HV4/XbGQPVPVcEqYlGY1Wtg==
X-Received: by 2002:a50:aa84:: with SMTP id q4mr3067609edc.331.1602508705059;
        Mon, 12 Oct 2020 06:18:25 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4915:9700:86d:33e0:2141:a74a])
        by smtp.gmail.com with ESMTPSA id o12sm10828252ejb.36.2020.10.12.06.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:18:24 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 09/13] RDMA/rtrs-clt: remove duplicated code
Date:   Mon, 12 Oct 2020 15:18:10 +0200
Message-Id: <20201012131814.121096-10-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

process_info_rsp checks that sg_cnt is zero twice.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index f63f239bbf55..102df6898339 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2257,8 +2257,12 @@ static int process_info_rsp(struct rtrs_clt_sess *sess,
 	int i, sgi;
 
 	sg_cnt = le16_to_cpu(msg->sg_cnt);
-	if (unlikely(!sg_cnt))
+	if (unlikely(!sg_cnt || (sess->queue_depth % sg_cnt))) {
+		rtrs_err(sess->clt, "Incorrect sg_cnt %d, is not multiple\n",
+			  sg_cnt);
 		return -EINVAL;
+	}
+
 	/*
 	 * Check if IB immediate data size is enough to hold the mem_id and
 	 * the offset inside the memory chunk.
@@ -2271,11 +2275,6 @@ static int process_info_rsp(struct rtrs_clt_sess *sess,
 			  MAX_IMM_PAYL_BITS, sg_cnt, sess->chunk_size);
 		return -EINVAL;
 	}
-	if (unlikely(!sg_cnt || (sess->queue_depth % sg_cnt))) {
-		rtrs_err(sess->clt, "Incorrect sg_cnt %d, is not multiple\n",
-			  sg_cnt);
-		return -EINVAL;
-	}
 	total_len = 0;
 	for (sgi = 0, i = 0; sgi < sg_cnt && i < sess->queue_depth; sgi++) {
 		const struct rtrs_sg_desc *desc = &msg->desc[sgi];
-- 
2.25.1

