Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B7A37147F
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhECLtV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbhECLtT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:19 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B9FC06174A
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g14so5893345edy.6
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jwh9n3cEUrIKhH1fG8xS+kyq9CAdzrPRzFsqcgnQ84=;
        b=UH4Sz2kyBAgdbeYq5MudmycswqLXFYYrkJTuhkPTaOktKAQYEd/XMdX+2nc/IQjeoZ
         pC3bGsnCR3swqUUFPxvvxlOtHygrAP8RRp5P3FYG3umfvQ6PBypOvli3QKdG4Z06Z2YH
         THq6xay1u14jaPZP/liFEDGLglNGxJOfi3Ow8eoE7e5heKJxUd8dielwCWn/LG6qPBNT
         yZ5uLeZKimNsfQP7lY9qFATo32soh7SpfvBs5EUjiq8obklDb6hWVI62PtecyeGBOFcK
         0OTrMOKDSRDdorsdDffXe9Agzy7anicYgvk8Mp/HT86YU8O5foLQHXrPRiVNCHcFcFkn
         sJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jwh9n3cEUrIKhH1fG8xS+kyq9CAdzrPRzFsqcgnQ84=;
        b=OBoiYoZP/dKEaYcXVFZFefYVuXcghUfZ3aJyhYvh9/n27nN8bjS3ysv+qmo4qwZt3q
         BkWu56B9Y/21ox5aT0Sur2kN2+sIpVT7w0QhL8Qrruh/0tzy2fHZaDtPGhlPpqFZ/eIz
         QRLO8oWE25R6NZcvazNSvVxB1AL3q2+lnsUKEyKaB4T2LUieFpgc88ppEUikEi8I6mPL
         mzIGmWh5rzfDFQ44gFeDJd/wG5CDd+QeVFsJ7r4hqnyB/GcA3NoRhLq6pQNWR/UvYzIq
         ue8vEWkDPf7Ax/z84DF1aYweRjBCxiytZ7xbcwiNSvXex2z7TtNFREITjsgxz2ViIZfR
         MBig==
X-Gm-Message-State: AOAM531KnmXZzwdE4a/tHBSuaHukNBm37y5QAg/JHM7l3P2oQASFyGCI
        +rntASUQfg52MEBe7HcbT7uvoEIfy9/+sg==
X-Google-Smtp-Source: ABdhPJxcGGr8WWmUnlBrh18E5ugx4stolTKmFJePxg9Q4MopCNBOcv3OstF5U9lW2XcPUi2H2QoxSQ==
X-Received: by 2002:a05:6402:2283:: with SMTP id cw3mr19352827edb.122.1620042505256;
        Mon, 03 May 2021 04:48:25 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:25 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 06/20] RDMA/rtrs: Change MAX_SESS_QUEUE_DEPTH
Date:   Mon,  3 May 2021 13:48:04 +0200
Message-Id: <20210503114818.288896-7-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
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
index bcad5e2168c5..62924ad5362d 100644
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

