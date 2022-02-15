Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BF34B768E
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbiBOS20 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 13:28:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiBOS20 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 13:28:26 -0500
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B77E03B
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 10:28:16 -0800 (PST)
Received: by mail-pf1-f177.google.com with SMTP id f6so15301370pfj.11
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 10:28:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=beA4VtgSVtno4340OjHX6Z8kzkIs9ExRgf/t8FaUa/w=;
        b=WMI7aRYf7myTCM71lmXjsDegMiCVcFTwmorfQ5jL+OvsYXPuWOzqPQHGToXAD9aEAS
         FVXlqZzivY7cy6CKqvHSH/u6DL0zf7YxfpjfwBdH6SU0rpA8rGPdd/SaZHNnSgX6Jj4Y
         KGTEUUHFpZohfvXspp0VPtmQ+0Y4d7uhI+lMlAH+Mm+OCYW132kWNg7ll5bmxdpCMTfW
         wrMabys+p7l5Qc/qLZAeA8uJZtDMH1arn8+48BI+nzzK4b6BF1Itihtfhar0Q38w4/Fm
         pl9VSvLA2Uqx/Al+yptDIf6oY3ofIkVZkJXTKHBQbf7HHoivzRu1lmghlnXuL1ulxISc
         e7RQ==
X-Gm-Message-State: AOAM530r8hZexYQGMCSnjrM8TQJZ33PNEN141L5SWODMBLNO/Sxyalcs
        SIgJaBNGeoblOYOEC0JXUD4=
X-Google-Smtp-Source: ABdhPJy6FEnL6Tb5lJbRSdXg2IFtmzelDrAgMZ5ltgGv0ePMOsR+XCJg0aH/BVlEtE06mF0xJUpzZA==
X-Received: by 2002:a63:945:: with SMTP id 66mr165688pgj.432.1644949695684;
        Tue, 15 Feb 2022 10:28:15 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id k13sm43896746pfc.176.2022.02.15.10.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 10:28:15 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/3] ib_srp: Add more documentation
Date:   Tue, 15 Feb 2022 10:26:48 -0800
Message-Id: <20220215182650.19839-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215182650.19839-1-bvanassche@acm.org>
References: <20220215182650.19839-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make it more clear what the different ib_srp data structures represent.

Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index abccddeea1e3..55a575e2cace 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -92,6 +92,9 @@ enum srp_iu_type {
 };
 
 /*
+ * RDMA adapter in the initiator system.
+ *
+ * @dev_list: List of RDMA ports associated with this RDMA adapter (srp_host).
  * @mr_page_mask: HCA memory registration page mask.
  * @mr_page_size: HCA memory registration page size.
  * @mr_max_size: Maximum size in bytes of a single FR registration request.
@@ -109,6 +112,12 @@ struct srp_device {
 	bool			use_fast_reg;
 };
 
+/*
+ * One port of an RDMA adapter in the initiator system.
+ *
+ * @target_list: List of connected target ports (struct srp_target_port).
+ * @target_lock: Protects @target_list.
+ */
 struct srp_host {
 	struct srp_device      *srp_dev;
 	u8			port;
@@ -183,7 +192,7 @@ struct srp_rdma_ch {
 };
 
 /**
- * struct srp_target_port
+ * struct srp_target_port - RDMA port in the SRP target system
  * @comp_vector: Completion vector used by the first RDMA channel created for
  *   this target port.
  */
