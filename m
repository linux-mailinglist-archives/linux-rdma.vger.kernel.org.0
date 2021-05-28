Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041A73941C5
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhE1LcI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhE1LcE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797D3C0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ci15so1465287ejc.10
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9kAUJfWVvvjbapa2QAkBuBvSpUh0vDXAcb8xqlnfA30=;
        b=huqE9ehbfVGaMa1H8R9P5WiknsFtGTbWEvAR68iq5O3Yo/SpSd4TTWs8lrIKzfeFDh
         4cnHYwwVXFAWmtykX7M9nZdR+PX7FWsdfqleZw1xcV87P4gIY8k7pZ0LMhgAgi0Kp7Bc
         RdO/hC2Ard9QXvuL6mu2+L5zxaBraqkafF54hrnoVdHC2iPkjdmZOmX5uW0HUim4jxc4
         EV2US+h7wpdocAKxcr9A5pPsbzdZzb0Lx/6JOnc7vHD1pA7fIJUP8RnV38WzWC+Vft8D
         sbTJZa8oUpgkah9uefQ8HQrmNMo74CPj8NgrNJ0LLZU3685apBVNwWA08uFTaKtwI3rv
         kYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9kAUJfWVvvjbapa2QAkBuBvSpUh0vDXAcb8xqlnfA30=;
        b=PWAobVZB22GIsYlq42Fqi2zngH34oDb96UUv1BqlFOLaDGTkMDXeCfCUBNK9qszdep
         dDbM4ah/JRarZ9eQzqLHx55x4VhSpos1f+giDJYLsSb6HnmC9vL0amrXSEmXT/eIPX6q
         ARsynpWFk8MJm3YO647DZEcCodl9nQDWVytGiL8jksL2EN2hhEKwu2AXnnz09E+0+NKF
         PYbYGLDr9VgntiZVXKOFo8bGBkoezNRCHiasPd0KQmExvFZhe38kR3qUk9MO+EH5VO0n
         dBpGjsqbtcJqEeFCAIG7f/QRYP2V0ykZpfUeyMKZji1gVSV28feR2vxr4XYWoUB1Ym0z
         xqKQ==
X-Gm-Message-State: AOAM532oNlutqpbtc1M8j+kJ9CGlEPMMs/frxsp3s0L6eRlLkgSiCl0F
        tbNtOS3Y3G3otu17WNAoQwWDdOeVbnGA2w==
X-Google-Smtp-Source: ABdhPJzGXcsDs/Rw/u8ouo0tVZEyJiUvY8Auom+Sb9JH6g/XCotG8RN3WoGuvBidnCseBQMDQxrhBw==
X-Received: by 2002:a17:906:1189:: with SMTP id n9mr8610318eja.117.1622201423911;
        Fri, 28 May 2021 04:30:23 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:23 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 05/20] RDMA/rtrs: Change MAX_SESS_QUEUE_DEPTH
Date:   Fri, 28 May 2021 13:30:03 +0200
Message-Id: <20210528113018.52290-6-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Max IB immediate data size is 2^28 (MAX_IMM_PAYL_BITS)
and the minimum chunk size is 4096 (2^12).
Therefore the maximum sess_queue_depth is 65536 (2^16).

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 86e65cf30cab..d957bbf1ddd3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -47,12 +47,15 @@ enum {
 	MAX_PATHS_NUM = 128,
 
 	/*
-	 * With the size of struct rtrs_permit allocated on the client, 4K
-	 * is the maximum number of rtrs_permits we can allocate. This number is
-	 * also used on the client to allocate the IU for the user connection
-	 * to receive the RDMA addresses from the server.
+	 * Max IB immediate data size is 2^28 (MAX_IMM_PAYL_BITS)
+	 * and the minimum chunk size is 4096 (2^12).
+	 * So the maximum sess_queue_depth is 65536 (2^16) in theory.
+	 * But mempool_create, create_qp and ib_post_send fail with
+	 * "cannot allocate memory" error if sess_queue_depth is too big.
+	 * Therefore the pratical max value of sess_queue_depth is
+	 * somewhere between 1 and 65536 and it depends on the system.
 	 */
-	MAX_SESS_QUEUE_DEPTH = 4096,
+	MAX_SESS_QUEUE_DEPTH = 65536,
 
 	RTRS_HB_INTERVAL_MS = 5000,
 	RTRS_HB_MISSED_MAX = 5,
-- 
2.25.1

