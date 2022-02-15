Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24584B79C8
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 22:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiBOVFg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 16:05:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiBOVFf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 16:05:35 -0500
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA662A720
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 13:05:25 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id j4so162379plj.8
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 13:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=beA4VtgSVtno4340OjHX6Z8kzkIs9ExRgf/t8FaUa/w=;
        b=M6v4/RfnVhWOmujp6dcM+mrqgNpKutfF37OT3n1AOlK1r19vwcDWbQxKPOA3vGDdb5
         jLFR0FLJpmefl2bS39hPQh+dyljfS4PIfBAEKS5RWcVZMsGhQc7bEGBPYYWMIPOTRuv3
         Lr74WBxQmye57KrLlZPstFjf+tU977C0Ogz7Yeqya+RbvkNxkt3G52YFvQ8t6WYiekDQ
         2tE3oZA5i0Txk/rSJbcmVamw/zF/n2/+7RiYY67adgFVz7NiZB0JkfIsdnrh/CI/xj81
         aAlx5GUJcufboPq27j3samREdaheqaLyUSdFo/I2QOZyMJOmrv+Iypwz7Kzh4vvk6bnF
         DeDw==
X-Gm-Message-State: AOAM533NzaEbFOiE+EB8x8o+lfMqZiW4dVIpNRG27VJHrvSfg3K6CIYx
        ZCu6KV2p+s6amoS/ECGrDiY=
X-Google-Smtp-Source: ABdhPJyNZ9GofEJdel0m7JhqTia7F3jugFYO6EvYOv20G/IlFzbnUAz0W77/qiNlD5XKti8nf58vVg==
X-Received: by 2002:a17:90b:4c0d:: with SMTP id na13mr753761pjb.205.1644959124423;
        Tue, 15 Feb 2022 13:05:24 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id i10sm19223888pjd.2.2022.02.15.13.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:05:23 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 1/2] ib_srp: Add more documentation
Date:   Tue, 15 Feb 2022 13:05:10 -0800
Message-Id: <20220215210511.28303-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215210511.28303-1-bvanassche@acm.org>
References: <20220215210511.28303-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
