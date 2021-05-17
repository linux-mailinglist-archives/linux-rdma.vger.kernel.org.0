Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFE3382811
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbhEQJUn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbhEQJUf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81700C06175F
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lg14so8097270ejb.9
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yLFpOE+TdrRPkoVKHWUcTph7C4sZk65kVFl88lmOKh8=;
        b=UEr/bHDLkb6Vwtdfe9okwXBRdqymdykRUGrK5pUTxyW5/VOhRlriB/tHu4t/Z+pCO3
         eMtdYiaWYQ9w4lXTv/K+O5DHnwnyKQyqZng/8wcKJMDylFkbVGqPQsZ8UMCBNYUs6vTz
         kDmpAWj++TyuOh464yCjtAfO8GuSTlOKyU8k0fgLxZy8fIsKN7ZzkQEyQJHgU2qiU9HK
         smc7AHtowQ1+olSzeRO6nAAXLO4KNd+3Wl2kv7sFOCvDECF7/QW8hNEBHTaF4quALF0v
         c65V3EbwPkmwK/VWK0CytrpBizc0H7mgEHlE14rGKGC7aCkIYMErK4v/XaA30owU1btD
         tmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yLFpOE+TdrRPkoVKHWUcTph7C4sZk65kVFl88lmOKh8=;
        b=b25OwbqyMYazSsbmRQRowLq5kOtYm5z5EqdcHXZeIabngfKi8Rkj3xyK6nUNgNOFy/
         GlG61yKSE5de8W2I9ieQl5qLYej9npR45lG53tDP80N5A6RlmBRyf/W9UeIApmNbGIQq
         hstm1SR+U+oXmmdfsgSh9TLnFylouwsjNtrtwp7HmVuwSQ58y+kuak3uemcNL7N96zyK
         KwA7q7Id4Xdwf52QodFWBAnhJ+jypTYHlZ4uLLAI/VmExfwmLosnhPjoLnZ+jWBPgg9+
         aID4/EV7AXw4r110VXrx77TfpVJ4w4I+urs1SMfNsR1oUNaOP4SxUSZEwT9fy90jCxQp
         +G+g==
X-Gm-Message-State: AOAM530eW+TOED6V6P4d7dVtm/8ZKNcweQrCmPl1e//NlUS91I9x2K7E
        /IztmsVTOZwPBnsJvTE7OzXvKGnlhP42Ng==
X-Google-Smtp-Source: ABdhPJw9FQsayz976d+7/igcr36IOvMLBBEf3zTVIIKToGaAVH9L75YiPJPbuCSl67/wL7GDwoIhAg==
X-Received: by 2002:a17:906:32c3:: with SMTP id k3mr36869555ejk.95.1621243157210;
        Mon, 17 May 2021 02:19:17 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:17 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 02/19] RDMA/rtrs-clt: Remove MAX_SESS_QUEUE_DEPTH from rtrs_send_sess_info
Date:   Mon, 17 May 2021 11:18:26 +0200
Message-Id: <20210517091844.260810-3-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Client receives queue_depth value from server. There is no need
to use MAX_SESS_QUEUE_DEPTH value.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 5e94686bb22d..930a1b496f84 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2455,7 +2455,7 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
 	int err;
 
 	rx_sz  = sizeof(struct rtrs_msg_info_rsp);
-	rx_sz += sizeof(u64) * MAX_SESS_QUEUE_DEPTH;
+	rx_sz += sizeof(struct rtrs_sg_desc) * sess->queue_depth;
 
 	tx_iu = rtrs_iu_alloc(1, sizeof(struct rtrs_msg_info_req), GFP_KERNEL,
 			       sess->s.dev->ib_dev, DMA_TO_DEVICE,
-- 
2.25.1

