Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2FC382815
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhEQJUz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbhEQJUl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C269AC061763
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h16so5995301edr.6
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jwh9n3cEUrIKhH1fG8xS+kyq9CAdzrPRzFsqcgnQ84=;
        b=IXuWvWkZ1sdYjtUibfiaKZzbGJ2bYMIG1AAsqLWWXIs6BCQGKaDmDKwtfINvwMRMB2
         G53LokmmWmlzZnPxj0wh1QtyoMOIVAdpFm+3MF8Yhcky8wmmndPpBmSmJ7y5uoP4bU2/
         Sg8T484g0bCMiyNB/q6sELw6cnCK3m6PF9dVjJNnMsaBNiV0xg9a26tKzwNrd2EzXQC8
         XmiLQNeVZkSPoVM7+kLsmU9TL6j2SlsYRMh3TM6/Y9MFjwwpcO3+pK1MtMZ4dtF60LA5
         73dZ3W074ZXXUE2sDXhrJrNxJbcXXGuH40A95X0hjgJBsnvNeAtUZ/YP7LCNWktGnYQ/
         WOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jwh9n3cEUrIKhH1fG8xS+kyq9CAdzrPRzFsqcgnQ84=;
        b=Fl//OKmYGHKFJP4MPvxh4+CYH56aoaErKajwO4Ih7z8rxuJndgBFgWeZS1FdlAV7Xv
         iz/YJcrbZ8bDvg3IFL5xWT+6kKZr2rY0G5a2DFDe8aiHBRqp1xF1OiNKafvIcnrmuKz+
         PSYEn2zvKR67VDhqL2q2b29l1rhApBhmP40WBkHpGbwhKsNPmkI+z6kCDi1c/OEppy1h
         sMz993opNcIyabQq9z5YCEQXRt0Pb3k7J1R03Y69SlSFGuFgnW1ey4cU/dcsSYadoUyA
         lroowQsyfcOWyG520v4kgG05jtei4PvMBOfpT7Xp1o4o5emZ+UY3Fy8Nebilp/J9S1Mb
         2cQQ==
X-Gm-Message-State: AOAM530sjO++sBi8x26hjqo8CY3/DFLmUYt10HyeWHzM7QkUO4W8Gcn/
        kslXeLED97yr9AWjvRwx9hy2BLMilAS4og==
X-Google-Smtp-Source: ABdhPJx6YVXQzSaBBhPBVlqcIyAlkLphkx4tL+SBADnAO9tYbVxi/yDAk/ZTEvfoNBExinawTsnbnw==
X-Received: by 2002:a50:f388:: with SMTP id g8mr13257983edm.236.1621243159484;
        Mon, 17 May 2021 02:19:19 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:19 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 05/19] RDMA/rtrs: Change MAX_SESS_QUEUE_DEPTH
Date:   Mon, 17 May 2021 11:18:29 +0200
Message-Id: <20210517091844.260810-6-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
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

