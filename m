Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4EB2FAD6C
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389409AbhARWlu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389417AbhARWln (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:41:43 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF409C0617A5
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:48 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r4so15031279wmh.5
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsbmv5w03vnjiOCZ9ztIqVycOKtYQMyD++uj7S+oBaA=;
        b=Bsh8Bp+n5RmhG7/A1tk/zBERDgsg3vE0KB/FhLBZTXnBAq5QOOEEdrU31mfSmMqCPJ
         DNDTYNKEelWwGh+68MTZDVDgM1QzfqNT0A8vJcNK7bxsFBj4jyZ2GukkquZtLx2jYQrn
         BNVqduN/oyFGGn7S2xJMD0XAUS08favqjEHTJXZr23Dts4ri0GWfUBcfoi4N31PkbXLr
         WruY2feR0j/LBtAjS/7070DhSx3AMrCBYDPD03RhcnEQsgDeLkq8N9XYcsGPU9WosL4S
         mKEB4ese7E4bIg8MzltSffdUbaNXjXJ75sbkc68wTExMK+u/8qBc7cxrgGkfKa1K1yAc
         S0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsbmv5w03vnjiOCZ9ztIqVycOKtYQMyD++uj7S+oBaA=;
        b=Hyr/IZarUHTy5UaFBS88rXDj118to7IC81bFiW66Ak7Zn6Swd7tjA5A87qwZ/veHrQ
         Mvnf6EEmBrTyayfvXZlPdVlIHm3kxH6KeKG9d9k3STQvjTyrWTHg1Yev0vbMaps0Ir1V
         ecgjtvXqsirvg66g2TrMQvoBblibcfdUhkUmhY8w22onyQHrGSQnq8ayWBEFhhd8Px90
         jFBg82aEK6qppUh4JwI12GO+ntRuQJcEV8CiI+c5Uw0tqbSJQMkVGhObSutJ/FJKcooX
         EF46yB4g8bnI5AlxGy8Yi+kgsihXItCqvKFXqKm5PpbGPWr2d42BxQ9275GQuJD41Lab
         cVWQ==
X-Gm-Message-State: AOAM533K2S0Xk7GaoqyNq4lUaJpw3n9ITreTf1H5WcYyt6QdrcCZwOym
        pUfd19yEc5AGZtIQCz+pJzbIDQ==
X-Google-Smtp-Source: ABdhPJxf9wv/NbZWRWTYHfdIWGD0Af2LP2U86lGlj7VSdMQG3e6T/oH2CHblGaF/iv8B8HArifotJg==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr1272961wmc.102.1611009587458;
        Mon, 18 Jan 2021 14:39:47 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 13/20] RDMA/hw/i40iw/i40iw_uk: Clean-up some function documentation headers
Date:   Mon, 18 Jan 2021 22:39:22 +0000
Message-Id: <20210118223929.512175-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/i40iw/i40iw_uk.c:129: warning: Function parameter or member 'total_size' not described in 'i40iw_qp_get_next_send_wqe'
 drivers/infiniband/hw/i40iw/i40iw_uk.c:129: warning: Function parameter or member 'wr_id' not described in 'i40iw_qp_get_next_send_wqe'
 drivers/infiniband/hw/i40iw/i40iw_uk.c:724: warning: Excess function parameter 'post_cq' description in 'i40iw_cq_poll_completion'
 drivers/infiniband/hw/i40iw/i40iw_uk.c:1058: warning: Function parameter or member 'queue' not described in 'i40iw_clean_cq'

Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/i40iw/i40iw_uk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_uk.c b/drivers/infiniband/hw/i40iw/i40iw_uk.c
index c3633c9944db4..f521be16bf31b 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_uk.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_uk.c
@@ -119,6 +119,8 @@ void i40iw_qp_post_wr(struct i40iw_qp_uk *qp)
  * @qp: hw qp ptr
  * @wqe_idx: return wqe index
  * @wqe_size: size of sq wqe
+ * @total_size: work request length
+ * @wr_id: work request id
  */
 u64 *i40iw_qp_get_next_send_wqe(struct i40iw_qp_uk *qp,
 				u32 *wqe_idx,
@@ -717,7 +719,6 @@ static enum i40iw_status_code i40iw_cq_post_entries(struct i40iw_cq_uk *cq,
  * i40iw_cq_poll_completion - get cq completion info
  * @cq: hw cq
  * @info: cq poll information returned
- * @post_cq: update cq tail
  */
 static enum i40iw_status_code i40iw_cq_poll_completion(struct i40iw_cq_uk *cq,
 						       struct i40iw_cq_poll_info *info)
@@ -1051,7 +1052,7 @@ void i40iw_device_init_uk(struct i40iw_dev_uk *dev)
 
 /**
  * i40iw_clean_cq - clean cq entries
- * @ queue completion context
+ * @queue: completion context
  * @cq: cq to clean
  */
 void i40iw_clean_cq(void *queue, struct i40iw_cq_uk *cq)
-- 
2.25.1

