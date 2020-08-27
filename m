Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051562546E5
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 16:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgH0Obk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 10:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgH0O0p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 10:26:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4CBC061235
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 07:17:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y8so3835125wma.0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2iQKSRyr52ny+0GoSuNEe/jexENn4wzJDRi/sR1iaQ=;
        b=bdyHoA7TbcKDQ5SaZFWz27l1FitaEDZ7MtkmP5aZjv/IZl3lHdY0XsDi5lzur+FFMb
         /GGAJ8yC98UHmrORUpYj1gTYhr4z/JvX1ptO+V5TxCTYS6XDAUlHZlg4GkTLqle8xFG8
         b0FvdGY1aYTfUD5hzZFeEL7M9Z6He8Vhn+DlYhEl6gXFzMjZmVvTopyov5sNi+z8FqIq
         nv1/Antsa3QhnI0ji31eiBIOf8eLrYqR3xXAOqzEW9UBzT3i9AEAaPEF23qUNNigXjWt
         C2kXVAa3qfvcpiGiW7ujdUiK3VO/C7hmLbZGJaxEVagZqw458VSOX+5KSefKpCE+DrH0
         uinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2iQKSRyr52ny+0GoSuNEe/jexENn4wzJDRi/sR1iaQ=;
        b=DEYrN+3Vv38x4BqTBmeMEjVqbMmRMI7onXJNGiZOWroEc+kd8vFoxg5151silBOz9L
         x9zRPdPWE+PSIiW5ax4s0a4uVVcAt1gHt7KiXuMZjN22DcIiT/ZzyuVc9ib3tnvp4ma5
         Uxw9rQL0P700xOxjnJaV5ZuOYObAZLSrsl4TXjfaL0GuQz9kbLG+D+sBwfu8OgdjahS8
         v8I6TIvHHE1vXYUoN4WoCNI4kvFy6mJ9MZ75fhKCVIsNNJwKwhyGBUTQTCH7JgJZYuOW
         kOYmPz32LfXcIyu3J5lAFv5QeK52BWEoaiYQPU5ejjoMhydbVV/pUYfX3UcFQmCbEGT5
         QppQ==
X-Gm-Message-State: AOAM531+05uSlJ0QqIZEEh/TZ3DI/Cr5ycljZk2sBsAyDi65fXkO0exT
        BPMKoKGyJm5SHEu9F0uHIhFOFl/QtEo=
X-Google-Smtp-Source: ABdhPJw1LH91H8OCHdi+o7a3WwNz1fYIiGN8S4KYT/d6NCUAoQ6AaYqjSlfhQg2kRAYNEcBwahnsOQ==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr11808866wmc.26.1598537878071;
        Thu, 27 Aug 2020 07:17:58 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.0.228])
        by smtp.gmail.com with ESMTPSA id t25sm5314500wmj.18.2020.08.27.07.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:17:57 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/qedr: Fix reported max_pkeys
Date:   Thu, 27 Aug 2020 17:16:55 +0300
Message-Id: <20200827141655.406185-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As qedr driver supports both RoCE and iWarp, make sure to set the
max_pkeys only when running in RoCE mode.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/qedr/verbs.c         | 2 +-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 4ce4e2eef6cc..1d1d5628bfc7 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -157,7 +157,7 @@ int qedr_query_device(struct ib_device *ibdev,
 
 	attr->local_ca_ack_delay = qattr->dev_ack_delay;
 	attr->max_fast_reg_page_list_len = qattr->max_mr / 8;
-	attr->max_pkeys = QEDR_ROCE_PKEY_MAX;
+	attr->max_pkeys = qattr->max_pkey;
 	attr->max_ah = qattr->max_ah;
 
 	return 0;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index a4bcde522cdf..03894584415d 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -504,7 +504,8 @@ static void qed_rdma_init_devinfo(struct qed_hwfn *p_hwfn,
 	dev->max_mw = 0;
 	dev->max_mr_mw_fmr_pbl = (PAGE_SIZE / 8) * (PAGE_SIZE / 8);
 	dev->max_mr_mw_fmr_size = dev->max_mr_mw_fmr_pbl * PAGE_SIZE;
-	dev->max_pkey = QED_RDMA_MAX_P_KEY;
+	if (QED_IS_ROCE_PERSONALITY(p_hwfn))
+		dev->max_pkey = QED_RDMA_MAX_P_KEY;
 
 	dev->max_srq = p_hwfn->p_rdma_info->num_srqs;
 	dev->max_srq_wr = QED_RDMA_MAX_SRQ_WQE_ELEM;
-- 
2.26.2

