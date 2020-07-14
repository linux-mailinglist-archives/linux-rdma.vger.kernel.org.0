Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD21B21EB0F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 10:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGNILA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 04:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgGNIK7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 04:10:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45875C061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:10:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so20215933wru.6
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F52xxdHJpk+aUYTGQsIRXXmLKYtmUocjdywU/DRMnjo=;
        b=V1PYzISAfY/rGKv6vMIse7LK0WCVUYrN0+1Z4Nn9uaFUeDFsIrpFL7i753mxeJ0uyd
         Cz70UAqdw1uPYUwk2NFM51kBnJLJZs2F1uvj4KmuT9Wo7HF0Csl0t2ZVCT0z6/SzI2pS
         9ZsEdfKHVXcZFX5F18REYHduJlrJYynZ4tyY9MXKPlEqmWGp6KPluAPlCDfSrcnwnxZE
         bem0MYAOGQeyM0UToJK/tfNHfaFcAn1eUb17oeOUMCqgJAOeCXk8b2PrWQyQX2NS9fA1
         YzMdXXqFFTQQzBCg1AX+/2lQd7sTlNJGFa2fcqm0Zl2Sahs0mer5ueEBuxFH69Mdm+U7
         nb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F52xxdHJpk+aUYTGQsIRXXmLKYtmUocjdywU/DRMnjo=;
        b=eN+L0V/Sx8AwIF/1EGp2mGshjkxQo6R4Qvv4Wm6jSDxmA5jBu2hE8aJpmRE9j/fGvH
         UV164HYe8e1znsE/52fF6pQIYbHGSjUWJhOez7/ZQMrsV9TkPUmGvoW2FHPhbGhg1niq
         vmzYilCutXVtEIIJNgqtZ8bG3JvqMfgIoKjh72tM+ayPC/ZtWZbENb09xzQQPeDJTCyk
         XvRuGl+QnlXBHIN9MYwm3Sux6KEVjRuxpWY1iBRmRsL4o2IeNd1flsDBL6p3UfHd4q/u
         086FH3uRjAN0As8LwRffWU7GCRzUtFhM5deGLg+ra8XTQ4KMn5ExGqsSOB6cLIQJz8gd
         Gx8w==
X-Gm-Message-State: AOAM530BNhhaelcJfeoZkQe9VeMEjyTvwoDr6qoWy45dTxwJkl8vEsNn
        kYVKXRJmYG6dM+C5IybC9LadFaceZnA=
X-Google-Smtp-Source: ABdhPJyoocTC3TM7SrHPaiYzGz1o//mTiFLISQ1fZisIpFXuKbWjsWIMToReQ6DYJB8+RPqfV/kv2w==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr3658768wrw.405.1594714257838;
        Tue, 14 Jul 2020 01:10:57 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-176-63-152.red.bezeqint.net. [79.176.63.152])
        by smtp.gmail.com with ESMTPSA id f197sm3403891wme.33.2020.07.14.01.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:10:57 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 6/7] RDMA/i40iw: Remove the query_pkey callback
Date:   Tue, 14 Jul 2020 11:10:37 +0300
Message-Id: <20200714081038.13131-7-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714081038.13131-1-kamalheib1@gmail.com>
References: <20200714081038.13131-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that the query_pkey() isn't mandatory by the RDMA core for iwarp
providers, this callback can be removed.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index f9ef3ac2f4cd..6957e4f3404b 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -101,7 +101,6 @@ static int i40iw_query_port(struct ib_device *ibdev,
 	props->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_REINIT_SUP |
 		IB_PORT_VENDOR_CLASS_SUP | IB_PORT_BOOT_MGMT_SUP;
 	props->gid_tbl_len = 1;
-	props->pkey_tbl_len = 1;
 	props->active_width = IB_WIDTH_4X;
 	props->active_speed = 1;
 	props->max_msg_sz = I40IW_MAX_OUTBOUND_MESSAGE_SIZE;
@@ -2459,7 +2458,6 @@ static int i40iw_port_immutable(struct ib_device *ibdev, u8 port_num,
 	if (err)
 		return err;
 
-	immutable->pkey_tbl_len = attr.pkey_tbl_len;
 	immutable->gid_tbl_len = attr.gid_tbl_len;
 
 	return 0;
@@ -2615,22 +2613,6 @@ static int i40iw_query_gid(struct ib_device *ibdev,
 	return 0;
 }
 
-/**
- * i40iw_query_pkey - Query partition key
- * @ibdev: device pointer from stack
- * @port: port number
- * @index: index of pkey
- * @pkey: pointer to store the pkey
- */
-static int i40iw_query_pkey(struct ib_device *ibdev,
-			    u8 port,
-			    u16 index,
-			    u16 *pkey)
-{
-	*pkey = 0;
-	return 0;
-}
-
 static const struct ib_device_ops i40iw_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_I40IW,
@@ -2670,7 +2652,6 @@ static const struct ib_device_ops i40iw_dev_ops = {
 	.post_send = i40iw_post_send,
 	.query_device = i40iw_query_device,
 	.query_gid = i40iw_query_gid,
-	.query_pkey = i40iw_query_pkey,
 	.query_port = i40iw_query_port,
 	.query_qp = i40iw_query_qp,
 	.reg_user_mr = i40iw_reg_user_mr,
-- 
2.25.4

