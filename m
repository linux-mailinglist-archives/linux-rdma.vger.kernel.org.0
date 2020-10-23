Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B547296A71
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 09:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375767AbgJWHoA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 03:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374512AbgJWHoA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 03:44:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0A1C0613D2
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:43:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a3so1022371ejy.11
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LNhaVGuLfGJxt2upLMkHxMIuPnCfXPmkuUGTrNLSfkQ=;
        b=BT6kP5hinfIdc7n0NZXtUnQQ9ic3ug+TleL7om+3yh9kyg4gTA/bIWS5WCiwPlNaEj
         QyJsYo6KNmE6lSyw/u9qpPu5b9E7/vbarKJjE1ibBPGOs9g4HcryRsVq0toc0A0/NBPM
         9gp38aTAiN/xdX74rZ95T6SCXgRjtQeXylP4rRgwsS5HyZVtDIUb4lRmZ8BPTRbdhvPj
         w4aq6VNZ8NiqKQhBxXF8Hinw4eXjey0tE2Kn6D30QidE1SBr9xnvZWfeoRZ2MYcEsC/B
         PKC2s/0Xy0IPCClwTKY88fjGrYceyYWQID5VHbB3gs0/S8gkazhvkr1+hDf/eAhJLhJ/
         rEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LNhaVGuLfGJxt2upLMkHxMIuPnCfXPmkuUGTrNLSfkQ=;
        b=lyna2Kl3SNtl4rbhfR8gHDTjADN8UvfLzQD4uOCAHyjHzRcjOk+P/D0UjltrWb9WIS
         2vBQhu6IyJdJNf0aeIO7LDVcWri3nXwyeDR94pYy+lNQLJIO4ZE8PPiXoZs4tgsyMLAy
         +Jpq3yYbk1Wcc6/PcL9b33DoHFzff0Oyv2OtLecUvAG2ASrGSc8jRC71RpL00lnSJSxH
         06S2E01wF6uvI337GCwWaKU7wLpuIUH3fbSupSZ11ustkgQL77ZRU1AdX8/rsp1QZ9Jg
         8466u+VX18n6b4pufhUE9Mln984bvnJno0xTAx/HkxHlRPluXGqjD3ySHAC76cqSI9Cl
         cU2g==
X-Gm-Message-State: AOAM533lNJur2jJV1gSWUiTcHNUsTmbRnRJab82rLPqgTohiC8ePJcAV
        iH5MHAxf4ERMQ8jvpDn3sKnJe2Oi5Lp53g==
X-Google-Smtp-Source: ABdhPJz4Dm2vv185LZ3bwhDxNrc0UWZEVVqQgkUIK1Az78CjFbbN3VfKR74MafSPe3nswFPfary7Uw==
X-Received: by 2002:a17:906:1299:: with SMTP id k25mr755091ejb.201.1603439036781;
        Fri, 23 Oct 2020 00:43:56 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49b9:3000:d18a:ee7b:bff9:e374])
        by smtp.gmail.com with ESMTPSA id op24sm337928ejb.56.2020.10.23.00.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 00:43:56 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 02/12] RDMA/rtrs-clt: remove outdated comment in create_con_cq_qp
Date:   Fri, 23 Oct 2020 09:43:43 +0200
Message-Id: <20201023074353.21946-3-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
References: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As run destroy_con_cq_qp many times doesn't work, remove
the comments.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Suggested-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 9980bb4a6f78..fb840b152b37 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1520,15 +1520,6 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 	int err, cq_vector;
 	struct rtrs_msg_rkey_rsp *rsp;
 
-	/*
-	 * This function can fail, but still destroy_con_cq_qp() should
-	 * be called, this is because create_con_cq_qp() is called on cm
-	 * event path, thus caller/waiter never knows: have we failed before
-	 * create_con_cq_qp() or after.  To solve this dilemma without
-	 * creating any additional flags just allow destroy_con_cq_qp() be
-	 * called many times.
-	 */
-
 	if (con->c.cid == 0) {
 		/*
 		 * One completion for each receive and two for each send
-- 
2.25.1

