Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DC3371481
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhECLtW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbhECLtU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C840C061763
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id zg3so7373382ejb.8
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5hfBn9GhMfx7I0EOUEgaTpDRmXZT14MLT0af7KVBCEc=;
        b=go69IhSjAGjWGbZU3QmzIaMkOnEwZlP3rNAt3fOC0i1TsjdF+8cECQQt52zLzQr7Fc
         GRb43zfYpSB0u7FeoBO1HfEEntOqqWEAaD9ooSyy94Pk4klCvAoS5y3tcmsutiyEb+T7
         kApy2NrG1rPt7apCZzQbjTRqSOtmF+SUQh1YVACw2x3qoaVErVAG4A2fuViH5VvVMxVo
         LHYV44XHjw/RmluxSHeytwZaTIle+zgMp40Trvtc8B0r08m3d/dpGF84bmeRDZtZr9I/
         1j1wQ4SbVL5ukUgheDKpTgcEor0uLR/LJaig4Fgr3CTjGmPCbwOYKdiucCCNj6L2UVBC
         X0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hfBn9GhMfx7I0EOUEgaTpDRmXZT14MLT0af7KVBCEc=;
        b=UAoRPBbEwVANABof02P/e6YycjXodjI1bgbCuevakjnboS2K//IhpZexyklA604xlX
         N7VIOdPku55F23rfz6xD3gbhrcOFaQ9U4bQhm9dowQ7kpBbJY8PHGwH/EJltLijl3l51
         eQH6KH9h5jIK+G2USghqWk+pQHrztdd1hjTxHYYgksTsF3lECQm8xqDpbeTCpzDIcbNM
         px+n60Fdg8mipVynpVHKDKJkrv5LNKWXHdJ0uZdvKwHCWEcA+fRqco1QT4sSOqWYqAOk
         Pm3+eAr2/k/LuggBbdCsumFwl5y8qRBFTG8MW32Y+3kw4j3iKLY1FRuUvkdB55Rp5xAE
         JtIw==
X-Gm-Message-State: AOAM5331y6ZYRETEur0IKtjQagc6ppaaN71NlaKrciMCJ+lV1CUBGSv+
        biB04VVxOe8NIzrkaOeSaDDcHaoMXZNHSQ==
X-Google-Smtp-Source: ABdhPJzUKPEp3nUnf0bhigRcfei9gyigbDAyxvEErL1N2wIa5CDOuKTIZRlhazPXH3502inTsUDJ4w==
X-Received: by 2002:a17:906:2ad2:: with SMTP id m18mr9410001eje.44.1620042505920;
        Mon, 03 May 2021 04:48:25 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:25 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 07/20] RDMA/rtrs: Define MIN_CHUNK_SIZE
Date:   Mon,  3 May 2021 13:48:05 +0200
Message-Id: <20210503114818.288896-8-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Define MIN_CHUNK_SIZE to replace the hard-coding number.
We need 4k for metadata, so MIN_CHUNK_SIZE should be at least 8k.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 62924ad5362d..a092f7d7c7b3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -56,6 +56,7 @@ enum {
 	 * somewhere between 1 and 65536 and it depends on the system.
 	 */
 	MAX_SESS_QUEUE_DEPTH = 65536,
+	MIN_CHUNK_SIZE = 8192,
 
 	RTRS_HB_INTERVAL_MS = 5000,
 	RTRS_HB_MISSED_MAX = 5,
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 74a5dfe85813..02bc704667a8 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -2165,9 +2165,9 @@ static int check_module_params(void)
 		       sess_queue_depth, 1, MAX_SESS_QUEUE_DEPTH);
 		return -EINVAL;
 	}
-	if (max_chunk_size < 4096 || !is_power_of_2(max_chunk_size)) {
+	if (max_chunk_size < MIN_CHUNK_SIZE || !is_power_of_2(max_chunk_size)) {
 		pr_err("Invalid max_chunk_size value %d, has to be >= %d and should be power of two.\n",
-		       max_chunk_size, 4096);
+		       max_chunk_size, MIN_CHUNK_SIZE);
 		return -EINVAL;
 	}
 
-- 
2.25.1

