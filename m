Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945C8215468
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 11:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgGFJLg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 05:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgGFJLg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 05:11:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA340C061794
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2020 02:11:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so39922014wrw.12
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 02:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFhKU1c8QJZQ3rQsIyMuD/WuH/oGWV1Tm3foNGD2v2k=;
        b=dk4m6D5dq8TXcn/MnNq0jhs7WqCMyjXmpwEgMw5FhkkfGi6NwUmr1i1x5n84gtPz6W
         dz6x6MRkG3l9ZlNtLber8+jeWcCSYDwEnfQ6rp2nlnluTuejTmcokda9745yj7qSTxG4
         Jt+ckIiNXEjhNLEpf4lcXQ+Kge/lXsQKIlgA8DXAom1GmKowP2Dt6cXjVgoBY4l3X5Y0
         fbQP0ij6yVqfbY0WSIJJToHD/0a2b8pPNgLnEzRIYaRcm+7sig/Bepr9ZNyX0El8ZvrM
         xGrpGCVyeCdRZev3P+GOM3vTap6UFoZ6O43kRtx47uZoxtW7I3QJA0oB/NbsjJqTuOJJ
         sB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFhKU1c8QJZQ3rQsIyMuD/WuH/oGWV1Tm3foNGD2v2k=;
        b=LhKzNBMpLP0pBcPM5okpuFJl02AHPP1XzuqUcxvpDRkohnu5JU4zkIAZJdmcGs41F+
         cUWlvnbMzR9WMqcxaWPVY9i5uHc2QDXbElFotKhGUZdB4T3Ug2UJcyvKMkOy/V62Gr2t
         l9URos4/P//JgfRbt6yueI23xhRnLhpgzA06tSIr+AAgYULqaxyZtq89HcR8tjducxiB
         vS1E4C8cimdYM8R/fwbGzMiDq67MIA7QyEzsgo5rnf8ZsP1X0Fz0VIt1m2LZIizO7Wfj
         i/YA1RZ9i1QKj0orIgMU6A+gTcLzPaMAhPCFUMrZREElQGdQapLE5QejhHljMN9+bwkn
         ixEw==
X-Gm-Message-State: AOAM531Ck07n+jqr7KhOXMAwzphkIUIW3baud+8zB7FJAeYRagOOM5xl
        ZRtkc2leESlZnGtP7t1/oFOJrlnnfpI=
X-Google-Smtp-Source: ABdhPJyRBazbbY3nGnmSjg6KoyPH7AiUIyJhO795Hcik5c72FzzMR5OfEj+zcHnpmDWopCPdDwE52Q==
X-Received: by 2002:a5d:4a01:: with SMTP id m1mr47094331wrq.250.1594026694548;
        Mon, 06 Jul 2020 02:11:34 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id j4sm18826867wrp.51.2020.07.06.02.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 02:11:34 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: [PATCH for-rc v1 4/4] RDMA/usnic: Fix reported max_pkeys attribute
Date:   Mon,  6 Jul 2020 12:11:19 +0300
Message-Id: <20200706091119.367697-5-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200706091119.367697-1-kamalheib1@gmail.com>
References: <20200706091119.367697-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make sure to report the right max_pkeys attribute value to indicate the
maximum number of partitions supported by the usnic device.

Fixes: e3cf00d0a87f ("IB/usnic: Add Cisco VIC low-level hardware driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Cc: Christian Benvenuti <benve@cisco.com>
---
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index b8a77ce11590..0cb2a73d46ee 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -309,7 +309,7 @@ int usnic_ib_query_device(struct ib_device *ibdev,
 	props->max_pd = USNIC_UIOM_MAX_PD_CNT;
 	props->max_mr = USNIC_UIOM_MAX_MR_CNT;
 	props->local_ca_ack_delay = 0;
-	props->max_pkeys = 0;
+	props->max_pkeys = 1;
 	props->atomic_cap = IB_ATOMIC_NONE;
 	props->masked_atomic_cap = props->atomic_cap;
 	props->max_qp_rd_atom = 0;
-- 
2.25.4

